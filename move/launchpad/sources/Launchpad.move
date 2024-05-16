module Launchpad::launchpad {
    use aptos_std::table::{Self, Table};
    use aptos_std::event::{Self, EventHandle};
    use aptos_std::type_info::{Self, TypeInfo};
    use aptos_framework::guid::{Self, ID};
    use aptos_framework::aptos_coin::AptosCoin;
    use aptos_framework::aptos_account;
    use aptos_framework::account;
    use std::vector;
    use std::signer;

    // error constants
    const ELAUNCHPAD_NOT_FOUND: u64 = 1000;
    const EBUY_AMOUNT_TOO_LOW: u64 = 1001;
    const EBUY_AMOUNT_TOO_HIGH: u64 = 1002;
    const EINVALID_COIN_TYPE: u64 = 1003;
    const EACCOUNT_NOT_FOUND: u64 = 1004;
    const ENOT_READY_TO_CLAIM: u64 = 1005;
    const ELAUNCHPAD_NOT_FINALIZED: u64 = 1006;
    const EREFUND_AMOUNT_TOO_HIGH: u64 = 1007;
    const ELAUNCHPAD_ALREADY_FINALIZED: u64 = 1008;
    const ENOT_READY_TO_REFUND: u64 = 1009;
    const ENOT_IN_TIME_TO_BUY: u64 = 1010;

    const APT_FEE_AMOUNT: u64 = 1000000; // 0.01 APT
    const ONE_APT_OCTAS: u128 = 100000000; // 10^8

    struct CreationEvent has drop, store {
        creator: address,
        launchpad_id: ID,
    }

    struct BuyEvent has drop, store {
        buyer: address,
        launchpad_id: ID,
        is_refund: bool,
        buy_amount: u64,
        timestamp: u64,
    }

    struct LaunchpadInfo has key, store {
        // token info
        asset_address: address,
        payment_asset_address: address,
        is_legacy_coin: bool,
        legacy_coin_type: TypeInfo,
        legacy_payment_coin_type: TypeInfo,
        presale_price: u64, // per 1 APT
        max_buy_amount: u64, // Octas = 10^8 APT
        min_buy_amount: u64, // Octas = 10^8 APT
        hardcap: u64, // Octas = 10^8 APT
        softcap: u64, // Octas = 10^8 APT

        // sale
        sale_method: u8, // 0: FCFS, 1: Whitelist
        whitelist_addresses: vector<address>,
        whitelist_max_amounts: vector<u64>,

        // launchpad public info
        owner: address,
        start_timestamp: u64,
        end_timestamp: u64,
        launchpad_id: ID,
        launchpad_name: vector<u8>,
        launchpad_website: vector<u8>,
        launchpad_logo: vector<u8>,
        launchpad_description: vector<u8>,
        launchpad_socials: vector<vector<u8>>,

        // vesting
        is_vesting_enabled: bool,
        vesting_description: vector<u8>,
        vested_tokens_percent: u8,
        first_token_release: u64,
        token_release_cycle: u64,
        release_cycle_percent: u8,

        // pool
        finalized: bool,
        total_raised: u64, // Octas = 10^8 APT
        // deprecated, cannot store too many addresses
        contributors: vector<address>,
        contributions: Table<address, u64>,
    }

    struct LaunchpadStore has key {
        // launchpad_id -> LaunchpadInfo
        launchpads: Table<ID, LaunchpadInfo>,
        // events
        launchpad_buy_events: EventHandle<BuyEvent>,
        launchpad_creation_events: EventHandle<CreationEvent>,
        // signer_cap for the coins holder account
        signer_cap: account::SignerCapability,
        signer_account_address: address,
    }

    struct LaunchpadParticipation has store, drop, copy {
        launchpad_id: ID,
        buy_amount: u64,
        timestamp: u64,
    }

    struct LaunchpadParticipationEnvelope has key {
        participations: vector<LaunchpadParticipation>,
    }

    fun init_module(admin: &signer) {
        let (signer_account, signer_cap) = account::create_resource_account(admin, x"44cfade93f0ab61a0a");

        move_to(admin, LaunchpadStore {
            launchpads: table::new(),
            launchpad_buy_events: account::new_event_handle<BuyEvent>(admin),
            launchpad_creation_events: account::new_event_handle<CreationEvent>(admin),
            signer_account_address: signer::address_of(&signer_account),
            signer_cap,
        });
    }

    fun create_unique_id(owner: &signer): ID {
        let gid = account::create_guid(owner);
        guid::id(&gid)
    }

    entry fun initialize_sale<CoinType, PaymentCoinType>(
        sender: &signer,

        // token info
        asset_address: address,
        payment_asset_address: address,
        is_legacy_coin: bool,
        presale_price: u64,
        max_buy_amount: u64,
        min_buy_amount: u64,
        hardcap: u64,
        softcap: u64,

        // sale
        sale_method: u8, // 0: FCFS, 1: Whitelist
        whitelist_addresses: vector<address>,
        whitelist_max_amounts: vector<u64>,

        // launchpad public info
        start_timestamp: u64,
        end_timestamp: u64,
        launchpad_name: vector<u8>,
        launchpad_website: vector<u8>,
        launchpad_logo: vector<u8>,
        launchpad_description: vector<u8>,
        launchpad_socials: vector<vector<u8>>,

        // vesting
        is_vesting_enabled: bool,
        vesting_description: vector<u8>,
        vested_tokens_percent: u8,
        first_token_release: u64,
        token_release_cycle: u64,
        release_cycle_percent: u8,
    ) acquires LaunchpadStore {
        let launchpad_id = create_unique_id(sender);
        let launchpad_store = borrow_global_mut<LaunchpadStore>(@Launchpad);

        let legacy_coin_type = type_info::type_of<AptosCoin>();
        let legacy_payment_coin_type = type_info::type_of<AptosCoin>();

        if (is_legacy_coin) {
            legacy_coin_type = type_info::type_of<CoinType>();
            legacy_payment_coin_type = type_info::type_of<PaymentCoinType>();
        };

        aptos_account::transfer_coins<AptosCoin>(
            sender,
            launchpad_store.signer_account_address,
            APT_FEE_AMOUNT
        );

        let apt_amount: u128 = (hardcap as u128) * (presale_price as u128);
        let initial_deposit = apt_amount / ONE_APT_OCTAS;

        // Transfer the hardcap amount of coins to the launchpad
        aptos_account::transfer_coins<CoinType>(
            sender,
            launchpad_store.signer_account_address,
            (initial_deposit as u64),
        );

        table::add(&mut launchpad_store.launchpads, launchpad_id, LaunchpadInfo {
            asset_address,
            payment_asset_address,
            is_legacy_coin,
            legacy_coin_type,
            legacy_payment_coin_type,
            presale_price,
            max_buy_amount,
            min_buy_amount,
            hardcap,
            softcap,
            sale_method,
            start_timestamp,
            end_timestamp,
            launchpad_id,
            launchpad_name,
            launchpad_website,
            launchpad_logo,
            launchpad_description,
            launchpad_socials,
            whitelist_addresses,
            whitelist_max_amounts,
            is_vesting_enabled,
            vesting_description,
            vested_tokens_percent,
            first_token_release,
            token_release_cycle,
            release_cycle_percent,
            owner: signer::address_of(sender),
            // deprecated, cannot store too many addresses
            contributors: vector::empty(),
            contributions: table::new(),
            total_raised: 0,
            finalized: false,
        });

        event::emit_event(&mut launchpad_store.launchpad_creation_events, CreationEvent {
            creator: signer::address_of(sender),
            launchpad_id,
        });
    }

    entry fun contribute<CoinType, PaymentCoinType>(
        buyer: &signer,
        launchpad_id_address: address,
        launchpad_id_creation_number: u64,
        buy_amount: u64,
    ) acquires LaunchpadStore, LaunchpadParticipationEnvelope {
        let launchpad_store = borrow_global_mut<LaunchpadStore>(@Launchpad);

        let launchpad_id = guid::create_id(launchpad_id_address, launchpad_id_creation_number);
        let is_valid = table::contains<ID, LaunchpadInfo>(&mut launchpad_store.launchpads, launchpad_id);
        assert!(is_valid, ELAUNCHPAD_NOT_FOUND);

        let launchpad_info = table::borrow_mut<ID, LaunchpadInfo>(&mut launchpad_store.launchpads, launchpad_id);
        let buyer_address = signer::address_of(buyer);

        assert!(launchpad_info.total_raised + buy_amount <= launchpad_info.hardcap, EBUY_AMOUNT_TOO_HIGH);

        // add check on min and max dates
        assert!(launchpad_info.start_timestamp < aptos_framework::timestamp::now_microseconds(), ENOT_IN_TIME_TO_BUY);
        assert!(launchpad_info.end_timestamp > aptos_framework::timestamp::now_microseconds(), ENOT_IN_TIME_TO_BUY);

        let prev_contribution = 0;
        if (table::contains(&mut launchpad_info.contributions, buyer_address)) {
            prev_contribution = *table::borrow_mut(&mut launchpad_info.contributions, buyer_address);
        };

        let total_amount_after_contribution = prev_contribution + buy_amount;

        // check if whitelist is enabled and the buyer is in the whitelist
        if (launchpad_info.sale_method == 1) {
            let (found, index) = vector::index_of(&launchpad_info.whitelist_addresses, &buyer_address);
            assert!(found, EACCOUNT_NOT_FOUND);
            // enable this when we have the whitelist max amounts per address
            // let max_amount = *vector::borrow_mut(&mut launchpad_info.whitelist_max_amounts, index);
            let max_amount = launchpad_info.max_buy_amount;
            assert!(total_amount_after_contribution <= max_amount, EBUY_AMOUNT_TOO_HIGH);
        } else {
            assert!(total_amount_after_contribution <= launchpad_info.max_buy_amount, EBUY_AMOUNT_TOO_HIGH);
        };

        assert!(total_amount_after_contribution >= launchpad_info.min_buy_amount, EBUY_AMOUNT_TOO_LOW);

        // Transfer the buy amount of coins to the launchpad
        assert!(launchpad_info.legacy_coin_type == type_info::type_of<CoinType>(), EINVALID_COIN_TYPE);
        assert!(launchpad_info.legacy_payment_coin_type == type_info::type_of<PaymentCoinType>(), EINVALID_COIN_TYPE);
        aptos_account::transfer_coins<PaymentCoinType>(
            buyer,
            launchpad_store.signer_account_address,
            buy_amount
        );

        launchpad_info.total_raised = launchpad_info.total_raised + buy_amount;

        table::upsert(&mut launchpad_info.contributions, buyer_address, total_amount_after_contribution);

        if (!exists<LaunchpadParticipationEnvelope>(buyer_address)) {
            move_to(buyer, LaunchpadParticipationEnvelope {
                participations: vector::empty(),
            });
        };

        let time_now = aptos_framework::timestamp::now_microseconds();
        // let participation_id = create_unique_id(buyer);
        let envelope = borrow_global_mut<LaunchpadParticipationEnvelope>(buyer_address);
        vector::push_back(&mut envelope.participations, LaunchpadParticipation {
            launchpad_id,
            buy_amount,
            timestamp: time_now,
        });

        event::emit_event(&mut launchpad_store.launchpad_buy_events, BuyEvent {
            timestamp: time_now,
            is_refund: false,
            buyer: buyer_address,
            launchpad_id,
            buy_amount,
        });
    }

    entry fun claim<CoinType, PaymentCoinType>(
        buyer: &signer,
        launchpad_id_address: address,
        launchpad_id_creation_number: u64,
    ) acquires LaunchpadStore {
        let launchpad_store = borrow_global_mut<LaunchpadStore>(@Launchpad);

        let launchpad_id = guid::create_id(launchpad_id_address, launchpad_id_creation_number);
        let is_valid = table::contains<ID, LaunchpadInfo>(&mut launchpad_store.launchpads, launchpad_id);
        assert!(is_valid, ELAUNCHPAD_NOT_FOUND);

        let launchpad_info = table::borrow_mut<ID, LaunchpadInfo>(&mut launchpad_store.launchpads, launchpad_id);
        let buyer_address = signer::address_of(buyer);

        // Transfer the buy amount of coins from the launchpad to the buyer
        assert!(launchpad_info.legacy_coin_type == type_info::type_of<CoinType>(), EINVALID_COIN_TYPE);
        assert!(launchpad_info.legacy_payment_coin_type == type_info::type_of<PaymentCoinType>(), EINVALID_COIN_TYPE);
        assert!(launchpad_info.total_raised >= launchpad_info.softcap, ENOT_READY_TO_CLAIM);
        assert!(launchpad_info.end_timestamp < aptos_framework::timestamp::now_microseconds(), ELAUNCHPAD_NOT_FINALIZED);

        let contribution = *table::borrow_mut(&mut launchpad_info.contributions, buyer_address);
        let signer_account = account::create_signer_with_capability(&launchpad_store.signer_cap);

        let apt_amount: u128 = (contribution as u128) * (launchpad_info.presale_price as u128);
        let final_contribution_amount: u128 = apt_amount / ONE_APT_OCTAS;

        aptos_account::transfer_coins<CoinType>(
            &signer_account,
            buyer_address,
            (final_contribution_amount as u64),
        );

        table::upsert(&mut launchpad_info.contributions, buyer_address, 0);
    }

    entry fun refund<CoinType, PaymentCoinType>(
        sender: &signer,
        launchpad_id_address: address,
        launchpad_id_creation_number: u64,
        amount: u64, // Octas = 10^8 APT
    ) acquires LaunchpadStore {
        let launchpad_store = borrow_global_mut<LaunchpadStore>(@Launchpad);

        let launchpad_id = guid::create_id(launchpad_id_address, launchpad_id_creation_number);
        let is_valid = table::contains<ID, LaunchpadInfo>(&mut launchpad_store.launchpads, launchpad_id);
        assert!(is_valid, ELAUNCHPAD_NOT_FOUND);

        let launchpad_info = table::borrow_mut<ID, LaunchpadInfo>(&mut launchpad_store.launchpads, launchpad_id);
        let buyer_address = signer::address_of(sender);

        // Transfer the buy amount of coins from the launchpad to the buyer
        assert!(launchpad_info.legacy_coin_type == type_info::type_of<CoinType>(), EINVALID_COIN_TYPE);
        assert!(launchpad_info.legacy_payment_coin_type == type_info::type_of<PaymentCoinType>(), EINVALID_COIN_TYPE);
        assert!(launchpad_info.total_raised < launchpad_info.softcap, ENOT_READY_TO_REFUND);
        // TODO: check only some time before the end of the sale

        assert!(table::contains(&mut launchpad_info.contributions, buyer_address), EACCOUNT_NOT_FOUND);

        let contribution = *table::borrow_mut(&mut launchpad_info.contributions, buyer_address);
        assert!(contribution >= amount, EREFUND_AMOUNT_TOO_HIGH);

        table::upsert(&mut launchpad_info.contributions, buyer_address, contribution - amount);

        launchpad_info.total_raised = launchpad_info.total_raised - amount;

        let signer_account = account::create_signer_with_capability(&launchpad_store.signer_cap);
        aptos_account::transfer_coins<PaymentCoinType>(
            &signer_account,
            buyer_address,
            amount,
        );

        let time_now = aptos_framework::timestamp::now_microseconds();
        event::emit_event(&mut launchpad_store.launchpad_buy_events, BuyEvent {
            timestamp: time_now,
            buyer: buyer_address,
            launchpad_id,
            is_refund: true,
            buy_amount: amount,
        });
    }

    entry fun finalize_sale<CoinType, PaymentCoinType>(
        admin: &signer,
        launchpad_id_address: address,
        launchpad_id_creation_number: u64,
    ) acquires LaunchpadStore {
        let launchpad_store = borrow_global_mut<LaunchpadStore>(@Launchpad);
        let launchpad_id = guid::create_id(launchpad_id_address, launchpad_id_creation_number);
        let is_valid = table::contains<ID, LaunchpadInfo>(&mut launchpad_store.launchpads, launchpad_id);
        assert!(is_valid, ELAUNCHPAD_NOT_FOUND);

        let launchpad_info = table::borrow_mut<ID, LaunchpadInfo>(&mut launchpad_store.launchpads, launchpad_id);
        let admin_address = signer::address_of(admin);
        assert!(launchpad_info.owner == admin_address, EACCOUNT_NOT_FOUND);
        assert!(launchpad_info.finalized == false, ELAUNCHPAD_ALREADY_FINALIZED);
        assert!(launchpad_info.end_timestamp < aptos_framework::timestamp::now_microseconds(), ELAUNCHPAD_NOT_FINALIZED);

        let signer_account = account::create_signer_with_capability(&launchpad_store.signer_cap);
        launchpad_info.finalized = true;

        if (launchpad_info.total_raised >= launchpad_info.softcap) {
            // Transfer the raised amount of coins to the launchpad owner
            aptos_account::transfer_coins<PaymentCoinType>(
                &signer_account,
                launchpad_info.owner,
                launchpad_info.total_raised,
            );

            let refund_amount: u128 = (launchpad_info.hardcap as u128) - (launchpad_info.total_raised as u128);
            let apt_amount: u128 = refund_amount * (launchpad_info.presale_price as u128);
            let final_refund_amount: u128 = apt_amount / ONE_APT_OCTAS;

            aptos_account::transfer_coins<CoinType>(
                &signer_account,
                launchpad_info.owner,
                (final_refund_amount as u64)
            );
        } else {
            let refund_amount: u128 = (launchpad_info.hardcap as u128);
            let apt_amount: u128 = refund_amount * (launchpad_info.presale_price as u128);
            let final_refund_amount: u128 = apt_amount / ONE_APT_OCTAS;

            // Refund the coins to the owner
            aptos_account::transfer_coins<CoinType>(
                &signer_account,
                launchpad_info.owner,
                (final_refund_amount as u64),
            );
        }
    }

    #[view]
    public fun allowed_contribution_amount(
        launchpad_id_creator_address: address,
        listing_id_creation_number: u64,
        buyer_address: address,
    ): u64 acquires LaunchpadStore {
        let launchpad_store = borrow_global_mut<LaunchpadStore>(@Launchpad);
        let launchpad_id = guid::create_id(launchpad_id_creator_address, listing_id_creation_number);
        let launchpad_info = table::borrow_mut<ID, LaunchpadInfo>(&mut launchpad_store.launchpads, launchpad_id);

        if (launchpad_info.sale_method == 1) {
            let (found, index) = vector::index_of(&launchpad_info.whitelist_addresses, &buyer_address);
            if (found) {
                // enable this when we have the whitelist max amounts per address
                // *vector::borrow_mut<u64>(&mut launchpad_info.whitelist_max_amounts, index)
                launchpad_info.max_buy_amount
            } else {
                0
            }
        } else {
            launchpad_info.max_buy_amount
        }
    }

    #[view]
    public fun get_contributed_amount(
        launchpad_id_creator_address: address,
        listing_id_creation_number: u64,
        buyer_address: address,
    ): u64 acquires LaunchpadStore {
        let launchpad_store = borrow_global_mut<LaunchpadStore>(@Launchpad);
        let launchpad_id = guid::create_id(launchpad_id_creator_address, listing_id_creation_number);
        let launchpad_info = table::borrow_mut<ID, LaunchpadInfo>(&mut launchpad_store.launchpads, launchpad_id);
        *table::borrow_mut(&mut launchpad_info.contributions, buyer_address)
    }
}
