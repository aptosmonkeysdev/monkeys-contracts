module PopCoin::assets_v1 {
    use aptos_std::table::{Self, Table};
    use aptos_std::event::{Self, EventHandle};
    use aptos_framework::type_info::{Self, TypeInfo};
    use aptos_framework::aptos_coin::AptosCoin;
    use aptos_framework::aptos_account;
    use aptos_framework::account;
    use aptos_framework::coin;
    use std::timestamp;
    use std::vector;
    use std::signer;
    use std::string;

    /*
    * This module is used to create coins from a nice UI
    * We have to use these structs to create coins because
    * it is required to have the struct deployed and managed
    * by the module that created it before deployment.
    *
    * This is a limitation of the legacy coin.
    * It is solved in the new Fungible Asset coin.
    */

// #region Structs
    struct EchoCoin000 {}
    struct EchoCoin001 {}
    struct EchoCoin002 {}
    struct EchoCoin003 {}
    struct EchoCoin004 {}
    struct EchoCoin005 {}
    struct EchoCoin006 {}
    struct EchoCoin007 {}
    struct EchoCoin008 {}
    struct EchoCoin009 {}
    struct EchoCoin010 {}
    struct EchoCoin011 {}
    struct EchoCoin012 {}
    struct EchoCoin013 {}
    struct EchoCoin014 {}
    struct EchoCoin015 {}
    struct EchoCoin016 {}
    struct EchoCoin017 {}
    struct EchoCoin018 {}
    struct EchoCoin019 {}
    struct EchoCoin020 {}
    struct EchoCoin021 {}
    struct EchoCoin022 {}
    struct EchoCoin023 {}
    struct EchoCoin024 {}
    struct EchoCoin025 {}
    struct EchoCoin026 {}
    struct EchoCoin027 {}
    struct EchoCoin028 {}
    struct EchoCoin029 {}
    struct EchoCoin030 {}
    struct EchoCoin031 {}
    struct EchoCoin032 {}
    struct EchoCoin033 {}
    struct EchoCoin034 {}
    struct EchoCoin035 {}
    struct EchoCoin036 {}
    struct EchoCoin037 {}
    struct EchoCoin038 {}
    struct EchoCoin039 {}
    struct EchoCoin040 {}
    struct EchoCoin041 {}
    struct EchoCoin042 {}
    struct EchoCoin043 {}
    struct EchoCoin044 {}
    struct EchoCoin045 {}
    struct EchoCoin046 {}
    struct EchoCoin047 {}
    struct EchoCoin048 {}
    struct EchoCoin049 {}
    struct EchoCoin050 {}
    struct EchoCoin051 {}
    struct EchoCoin052 {}
    struct EchoCoin053 {}
    struct EchoCoin054 {}
    struct EchoCoin055 {}
    struct EchoCoin056 {}
    struct EchoCoin057 {}
    struct EchoCoin058 {}
    struct EchoCoin059 {}
    struct EchoCoin060 {}
    struct EchoCoin061 {}
    struct EchoCoin062 {}
    struct EchoCoin063 {}
    struct EchoCoin064 {}
    struct EchoCoin065 {}
    struct EchoCoin066 {}
    struct EchoCoin067 {}
    struct EchoCoin068 {}
    struct EchoCoin069 {}
    struct EchoCoin070 {}
    struct EchoCoin071 {}
    struct EchoCoin072 {}
    struct EchoCoin073 {}
    struct EchoCoin074 {}
    struct EchoCoin075 {}
    struct EchoCoin076 {}
    struct EchoCoin077 {}
    struct EchoCoin078 {}
    struct EchoCoin079 {}
    struct EchoCoin080 {}
    struct EchoCoin081 {}
    struct EchoCoin082 {}
    struct EchoCoin083 {}
    struct EchoCoin084 {}
    struct EchoCoin085 {}
    struct EchoCoin086 {}
    struct EchoCoin087 {}
    struct EchoCoin088 {}
    struct EchoCoin089 {}
    struct EchoCoin090 {}
    struct EchoCoin091 {}
    struct EchoCoin092 {}
    struct EchoCoin093 {}
    struct EchoCoin094 {}
    struct EchoCoin095 {}
    struct EchoCoin096 {}
    struct EchoCoin097 {}
    struct EchoCoin098 {}
    struct EchoCoin099 {}
    struct EchoCoin100 {}
    struct EchoCoin101 {}
    struct EchoCoin102 {}
    struct EchoCoin103 {}
    struct EchoCoin104 {}
    struct EchoCoin105 {}
    struct EchoCoin106 {}
    struct EchoCoin107 {}
    struct EchoCoin108 {}
    struct EchoCoin109 {}
    struct EchoCoin110 {}
    struct EchoCoin111 {}
    struct EchoCoin112 {}
    struct EchoCoin113 {}
    struct EchoCoin114 {}
    struct EchoCoin115 {}
    struct EchoCoin116 {}
    struct EchoCoin117 {}
    struct EchoCoin118 {}
    struct EchoCoin119 {}
    struct EchoCoin120 {}
    struct EchoCoin121 {}
    struct EchoCoin122 {}
    struct EchoCoin123 {}
    struct EchoCoin124 {}
    struct EchoCoin125 {}
    struct EchoCoin126 {}
    struct EchoCoin127 {}
    struct EchoCoin128 {}
    struct EchoCoin129 {}
    struct EchoCoin130 {}
    struct EchoCoin131 {}
    struct EchoCoin132 {}
    struct EchoCoin133 {}
    struct EchoCoin134 {}
    struct EchoCoin135 {}
    struct EchoCoin136 {}
    struct EchoCoin137 {}
    struct EchoCoin138 {}
    struct EchoCoin139 {}
    struct EchoCoin140 {}
    struct EchoCoin141 {}
    struct EchoCoin142 {}
    struct EchoCoin143 {}
    struct EchoCoin144 {}
    struct EchoCoin145 {}
    struct EchoCoin146 {}
    struct EchoCoin147 {}
    struct EchoCoin148 {}
    struct EchoCoin149 {}
    struct EchoCoin150 {}
    struct EchoCoin151 {}
    struct EchoCoin152 {}
    struct EchoCoin153 {}
    struct EchoCoin154 {}
    struct EchoCoin155 {}
    struct EchoCoin156 {}
    struct EchoCoin157 {}
    struct EchoCoin158 {}
    struct EchoCoin159 {}
    struct EchoCoin160 {}
    struct EchoCoin161 {}
    struct EchoCoin162 {}
    struct EchoCoin163 {}
    struct EchoCoin164 {}
    struct EchoCoin165 {}
    struct EchoCoin166 {}
    struct EchoCoin167 {}
    struct EchoCoin168 {}
    struct EchoCoin169 {}
    struct EchoCoin170 {}
    struct EchoCoin171 {}
    struct EchoCoin172 {}
    struct EchoCoin173 {}
    struct EchoCoin174 {}
    struct EchoCoin175 {}
    struct EchoCoin176 {}
    struct EchoCoin177 {}
    struct EchoCoin178 {}
    struct EchoCoin179 {}
    struct EchoCoin180 {}
    struct EchoCoin181 {}
    struct EchoCoin182 {}
    struct EchoCoin183 {}
    struct EchoCoin184 {}
    struct EchoCoin185 {}
    struct EchoCoin186 {}
    struct EchoCoin187 {}
    struct EchoCoin188 {}
    struct EchoCoin189 {}
    struct EchoCoin190 {}
    struct EchoCoin191 {}
    struct EchoCoin192 {}
    struct EchoCoin193 {}
    struct EchoCoin194 {}
    struct EchoCoin195 {}
    struct EchoCoin196 {}
    struct EchoCoin197 {}
    struct EchoCoin198 {}
    struct EchoCoin199 {}
    struct EchoCoin200 {}
    struct EchoCoin201 {}
    struct EchoCoin202 {}
    struct EchoCoin203 {}
    struct EchoCoin204 {}
    struct EchoCoin205 {}
    struct EchoCoin206 {}
    struct EchoCoin207 {}
    struct EchoCoin208 {}
    struct EchoCoin209 {}
    struct EchoCoin210 {}
    struct EchoCoin211 {}
    struct EchoCoin212 {}
    struct EchoCoin213 {}
    struct EchoCoin214 {}
    struct EchoCoin215 {}
    struct EchoCoin216 {}
    struct EchoCoin217 {}
    struct EchoCoin218 {}
    struct EchoCoin219 {}
    struct EchoCoin220 {}
    struct EchoCoin221 {}
    struct EchoCoin222 {}
    struct EchoCoin223 {}
    struct EchoCoin224 {}
    struct EchoCoin225 {}
    struct EchoCoin226 {}
    struct EchoCoin227 {}
    struct EchoCoin228 {}
    struct EchoCoin229 {}
    struct EchoCoin230 {}
    struct EchoCoin231 {}
    struct EchoCoin232 {}
    struct EchoCoin233 {}
    struct EchoCoin234 {}
    struct EchoCoin235 {}
    struct EchoCoin236 {}
    struct EchoCoin237 {}
    struct EchoCoin238 {}
    struct EchoCoin239 {}
    struct EchoCoin240 {}
    struct EchoCoin241 {}
    struct EchoCoin242 {}
    struct EchoCoin243 {}
    struct EchoCoin244 {}
    struct EchoCoin245 {}
    struct EchoCoin246 {}
    struct EchoCoin247 {}
    struct EchoCoin248 {}
    struct EchoCoin249 {}
    struct EchoCoin250 {}
    struct EchoCoin251 {}
    struct EchoCoin252 {}
    struct EchoCoin253 {}
    struct EchoCoin254 {}
    struct EchoCoin255 {}
    struct EchoCoin256 {}
    struct EchoCoin257 {}
    struct EchoCoin258 {}
    struct EchoCoin259 {}
    struct EchoCoin260 {}
    struct EchoCoin261 {}
    struct EchoCoin262 {}
    struct EchoCoin263 {}
    struct EchoCoin264 {}
    struct EchoCoin265 {}
    struct EchoCoin266 {}
    struct EchoCoin267 {}
    struct EchoCoin268 {}
    struct EchoCoin269 {}
    struct EchoCoin270 {}
    struct EchoCoin271 {}
    struct EchoCoin272 {}
    struct EchoCoin273 {}
    struct EchoCoin274 {}
    struct EchoCoin275 {}
    struct EchoCoin276 {}
    struct EchoCoin277 {}
    struct EchoCoin278 {}
    struct EchoCoin279 {}
    struct EchoCoin280 {}
    struct EchoCoin281 {}
    struct EchoCoin282 {}
    struct EchoCoin283 {}
    struct EchoCoin284 {}
    struct EchoCoin285 {}
    struct EchoCoin286 {}
    struct EchoCoin287 {}
    struct EchoCoin288 {}
    struct EchoCoin289 {}
    struct EchoCoin290 {}
    struct EchoCoin291 {}
    struct EchoCoin292 {}
    struct EchoCoin293 {}
    struct EchoCoin294 {}
    struct EchoCoin295 {}
    struct EchoCoin296 {}
    struct EchoCoin297 {}
    struct EchoCoin298 {}
    struct EchoCoin299 {}
    struct EchoCoin300 {}
    struct EchoCoin301 {}
    struct EchoCoin302 {}
    struct EchoCoin303 {}
    struct EchoCoin304 {}
    struct EchoCoin305 {}
    struct EchoCoin306 {}
    struct EchoCoin307 {}
    struct EchoCoin308 {}
    struct EchoCoin309 {}
    struct EchoCoin310 {}
    struct EchoCoin311 {}
    struct EchoCoin312 {}
    struct EchoCoin313 {}
    struct EchoCoin314 {}
    struct EchoCoin315 {}
    struct EchoCoin316 {}
    struct EchoCoin317 {}
    struct EchoCoin318 {}
    struct EchoCoin319 {}
    struct EchoCoin320 {}
    struct EchoCoin321 {}
    struct EchoCoin322 {}
    struct EchoCoin323 {}
    struct EchoCoin324 {}
    struct EchoCoin325 {}
    struct EchoCoin326 {}
    struct EchoCoin327 {}
    struct EchoCoin328 {}
    struct EchoCoin329 {}
    struct EchoCoin330 {}
    struct EchoCoin331 {}
    struct EchoCoin332 {}
    struct EchoCoin333 {}
    struct EchoCoin334 {}
    struct EchoCoin335 {}
    struct EchoCoin336 {}
    struct EchoCoin337 {}
    struct EchoCoin338 {}
    struct EchoCoin339 {}
    struct EchoCoin340 {}
    struct EchoCoin341 {}
    struct EchoCoin342 {}
    struct EchoCoin343 {}
    struct EchoCoin344 {}
    struct EchoCoin345 {}
    struct EchoCoin346 {}
    struct EchoCoin347 {}
    struct EchoCoin348 {}
    struct EchoCoin349 {}
    struct EchoCoin350 {}
    struct EchoCoin351 {}
    struct EchoCoin352 {}
    struct EchoCoin353 {}
    struct EchoCoin354 {}
    struct EchoCoin355 {}
    struct EchoCoin356 {}
    struct EchoCoin357 {}
    struct EchoCoin358 {}
    struct EchoCoin359 {}
    struct EchoCoin360 {}
    struct EchoCoin361 {}
    struct EchoCoin362 {}
    struct EchoCoin363 {}
    struct EchoCoin364 {}
    struct EchoCoin365 {}
    struct EchoCoin366 {}
    struct EchoCoin367 {}
    struct EchoCoin368 {}
    struct EchoCoin369 {}
    struct EchoCoin370 {}
    struct EchoCoin371 {}
    struct EchoCoin372 {}
    struct EchoCoin373 {}
    struct EchoCoin374 {}
    struct EchoCoin375 {}
    struct EchoCoin376 {}
    struct EchoCoin377 {}
    struct EchoCoin378 {}
    struct EchoCoin379 {}
    struct EchoCoin380 {}
    struct EchoCoin381 {}
    struct EchoCoin382 {}
    struct EchoCoin383 {}
    struct EchoCoin384 {}
    struct EchoCoin385 {}
    struct EchoCoin386 {}
    struct EchoCoin387 {}
    struct EchoCoin388 {}
    struct EchoCoin389 {}
    struct EchoCoin390 {}
    struct EchoCoin391 {}
    struct EchoCoin392 {}
    struct EchoCoin393 {}
    struct EchoCoin394 {}
    struct EchoCoin395 {}
    struct EchoCoin396 {}
    struct EchoCoin397 {}
    struct EchoCoin398 {}
    struct EchoCoin399 {}
    struct EchoCoin400 {}
    struct EchoCoin401 {}
    struct EchoCoin402 {}
    struct EchoCoin403 {}
    struct EchoCoin404 {}
    struct EchoCoin405 {}
    struct EchoCoin406 {}
    struct EchoCoin407 {}
    struct EchoCoin408 {}
    struct EchoCoin409 {}
    struct EchoCoin410 {}
    struct EchoCoin411 {}
    struct EchoCoin412 {}
    struct EchoCoin413 {}
    struct EchoCoin414 {}
    struct EchoCoin415 {}
    struct EchoCoin416 {}
    struct EchoCoin417 {}
    struct EchoCoin418 {}
    struct EchoCoin419 {}
    struct EchoCoin420 {}
    struct EchoCoin421 {}
    struct EchoCoin422 {}
    struct EchoCoin423 {}
    struct EchoCoin424 {}
    struct EchoCoin425 {}
    struct EchoCoin426 {}
    struct EchoCoin427 {}
    struct EchoCoin428 {}
    struct EchoCoin429 {}
    struct EchoCoin430 {}
    struct EchoCoin431 {}
    struct EchoCoin432 {}
    struct EchoCoin433 {}
    struct EchoCoin434 {}
    struct EchoCoin435 {}
    struct EchoCoin436 {}
    struct EchoCoin437 {}
    struct EchoCoin438 {}
    struct EchoCoin439 {}
    struct EchoCoin440 {}
    struct EchoCoin441 {}
    struct EchoCoin442 {}
    struct EchoCoin443 {}
    struct EchoCoin444 {}
    struct EchoCoin445 {}
    struct EchoCoin446 {}
    struct EchoCoin447 {}
    struct EchoCoin448 {}
    struct EchoCoin449 {}
    struct EchoCoin450 {}
    struct EchoCoin451 {}
    struct EchoCoin452 {}
    struct EchoCoin453 {}
    struct EchoCoin454 {}
    struct EchoCoin455 {}
    struct EchoCoin456 {}
    struct EchoCoin457 {}
    struct EchoCoin458 {}
    struct EchoCoin459 {}
    struct EchoCoin460 {}
    struct EchoCoin461 {}
    struct EchoCoin462 {}
    struct EchoCoin463 {}
    struct EchoCoin464 {}
    struct EchoCoin465 {}
    struct EchoCoin466 {}
    struct EchoCoin467 {}
    struct EchoCoin468 {}
    struct EchoCoin469 {}
    struct EchoCoin470 {}
    struct EchoCoin471 {}
    struct EchoCoin472 {}
    struct EchoCoin473 {}
    struct EchoCoin474 {}
    struct EchoCoin475 {}
    struct EchoCoin476 {}
    struct EchoCoin477 {}
    struct EchoCoin478 {}
    struct EchoCoin479 {}
    struct EchoCoin480 {}
    struct EchoCoin481 {}
    struct EchoCoin482 {}
    struct EchoCoin483 {}
    struct EchoCoin484 {}
    struct EchoCoin485 {}
    struct EchoCoin486 {}
    struct EchoCoin487 {}
    struct EchoCoin488 {}
    struct EchoCoin489 {}
    struct EchoCoin490 {}
    struct EchoCoin491 {}
    struct EchoCoin492 {}
    struct EchoCoin493 {}
    struct EchoCoin494 {}
    struct EchoCoin495 {}
    struct EchoCoin496 {}
    struct EchoCoin497 {}
    struct EchoCoin498 {}
    struct EchoCoin499 {}
    struct EchoCoin500 {}
    struct EchoCoin501 {}
    struct EchoCoin502 {}
    struct EchoCoin503 {}
    struct EchoCoin504 {}
    struct EchoCoin505 {}
    struct EchoCoin506 {}
    struct EchoCoin507 {}
    struct EchoCoin508 {}
    struct EchoCoin509 {}
    struct EchoCoin510 {}
    struct EchoCoin511 {}
    struct EchoCoin512 {}
    struct EchoCoin513 {}
    struct EchoCoin514 {}
    struct EchoCoin515 {}
    struct EchoCoin516 {}
    struct EchoCoin517 {}
    struct EchoCoin518 {}
    struct EchoCoin519 {}
    struct EchoCoin520 {}
    struct EchoCoin521 {}
    struct EchoCoin522 {}
    struct EchoCoin523 {}
    struct EchoCoin524 {}
    struct EchoCoin525 {}
    struct EchoCoin526 {}
    struct EchoCoin527 {}
    struct EchoCoin528 {}
    struct EchoCoin529 {}
    struct EchoCoin530 {}
    struct EchoCoin531 {}
    struct EchoCoin532 {}
    struct EchoCoin533 {}
    struct EchoCoin534 {}
    struct EchoCoin535 {}
    struct EchoCoin536 {}
    struct EchoCoin537 {}
    struct EchoCoin538 {}
    struct EchoCoin539 {}
    struct EchoCoin540 {}
    struct EchoCoin541 {}
    struct EchoCoin542 {}
    struct EchoCoin543 {}
    struct EchoCoin544 {}
    struct EchoCoin545 {}
    struct EchoCoin546 {}
    struct EchoCoin547 {}
    struct EchoCoin548 {}
    struct EchoCoin549 {}
    struct EchoCoin550 {}
    struct EchoCoin551 {}
    struct EchoCoin552 {}
    struct EchoCoin553 {}
    struct EchoCoin554 {}
    struct EchoCoin555 {}
    struct EchoCoin556 {}
    struct EchoCoin557 {}
    struct EchoCoin558 {}
    struct EchoCoin559 {}
    struct EchoCoin560 {}
    struct EchoCoin561 {}
    struct EchoCoin562 {}
    struct EchoCoin563 {}
    struct EchoCoin564 {}
    struct EchoCoin565 {}
    struct EchoCoin566 {}
    struct EchoCoin567 {}
    struct EchoCoin568 {}
    struct EchoCoin569 {}
    struct EchoCoin570 {}
    struct EchoCoin571 {}
    struct EchoCoin572 {}
    struct EchoCoin573 {}
    struct EchoCoin574 {}
    struct EchoCoin575 {}
    struct EchoCoin576 {}
    struct EchoCoin577 {}
    struct EchoCoin578 {}
    struct EchoCoin579 {}
    struct EchoCoin580 {}
    struct EchoCoin581 {}
    struct EchoCoin582 {}
    struct EchoCoin583 {}
    struct EchoCoin584 {}
    struct EchoCoin585 {}
    struct EchoCoin586 {}
    struct EchoCoin587 {}
    struct EchoCoin588 {}
    struct EchoCoin589 {}
    struct EchoCoin590 {}
    struct EchoCoin591 {}
    struct EchoCoin592 {}
    struct EchoCoin593 {}
    struct EchoCoin594 {}
    struct EchoCoin595 {}
    struct EchoCoin596 {}
    struct EchoCoin597 {}
    struct EchoCoin598 {}
    struct EchoCoin599 {}
    struct EchoCoin600 {}
    struct EchoCoin601 {}
    struct EchoCoin602 {}
    struct EchoCoin603 {}
    struct EchoCoin604 {}
    struct EchoCoin605 {}
    struct EchoCoin606 {}
    struct EchoCoin607 {}
    struct EchoCoin608 {}
    struct EchoCoin609 {}
    struct EchoCoin610 {}
    struct EchoCoin611 {}
    struct EchoCoin612 {}
    struct EchoCoin613 {}
    struct EchoCoin614 {}
    struct EchoCoin615 {}
    struct EchoCoin616 {}
    struct EchoCoin617 {}
    struct EchoCoin618 {}
    struct EchoCoin619 {}
    struct EchoCoin620 {}
    struct EchoCoin621 {}
    struct EchoCoin622 {}
    struct EchoCoin623 {}
    struct EchoCoin624 {}
    struct EchoCoin625 {}
    struct EchoCoin626 {}
    struct EchoCoin627 {}
    struct EchoCoin628 {}
    struct EchoCoin629 {}
    struct EchoCoin630 {}
    struct EchoCoin631 {}
    struct EchoCoin632 {}
    struct EchoCoin633 {}
    struct EchoCoin634 {}
    struct EchoCoin635 {}
    struct EchoCoin636 {}
    struct EchoCoin637 {}
    struct EchoCoin638 {}
    struct EchoCoin639 {}
    struct EchoCoin640 {}
    struct EchoCoin641 {}
    struct EchoCoin642 {}
    struct EchoCoin643 {}
    struct EchoCoin644 {}
    struct EchoCoin645 {}
    struct EchoCoin646 {}
    struct EchoCoin647 {}
    struct EchoCoin648 {}
    struct EchoCoin649 {}
    struct EchoCoin650 {}
    struct EchoCoin651 {}
    struct EchoCoin652 {}
    struct EchoCoin653 {}
    struct EchoCoin654 {}
    struct EchoCoin655 {}
    struct EchoCoin656 {}
    struct EchoCoin657 {}
    struct EchoCoin658 {}
    struct EchoCoin659 {}
    struct EchoCoin660 {}
    struct EchoCoin661 {}
    struct EchoCoin662 {}
    struct EchoCoin663 {}
    struct EchoCoin664 {}
    struct EchoCoin665 {}
    struct EchoCoin666 {}
    struct EchoCoin667 {}
    struct EchoCoin668 {}
    struct EchoCoin669 {}
    struct EchoCoin670 {}
    struct EchoCoin671 {}
    struct EchoCoin672 {}
    struct EchoCoin673 {}
    struct EchoCoin674 {}
    struct EchoCoin675 {}
    struct EchoCoin676 {}
    struct EchoCoin677 {}
    struct EchoCoin678 {}
    struct EchoCoin679 {}
    struct EchoCoin680 {}
    struct EchoCoin681 {}
    struct EchoCoin682 {}
    struct EchoCoin683 {}
    struct EchoCoin684 {}
    struct EchoCoin685 {}
    struct EchoCoin686 {}
    struct EchoCoin687 {}
    struct EchoCoin688 {}
    struct EchoCoin689 {}
    struct EchoCoin690 {}
    struct EchoCoin691 {}
    struct EchoCoin692 {}
    struct EchoCoin693 {}
    struct EchoCoin694 {}
    struct EchoCoin695 {}
    struct EchoCoin696 {}
    struct EchoCoin697 {}
    struct EchoCoin698 {}
    struct EchoCoin699 {}
    struct EchoCoin700 {}
    struct EchoCoin701 {}
    struct EchoCoin702 {}
    struct EchoCoin703 {}
    struct EchoCoin704 {}
    struct EchoCoin705 {}
    struct EchoCoin706 {}
    struct EchoCoin707 {}
    struct EchoCoin708 {}
    struct EchoCoin709 {}
    struct EchoCoin710 {}
    struct EchoCoin711 {}
    struct EchoCoin712 {}
    struct EchoCoin713 {}
    struct EchoCoin714 {}
    struct EchoCoin715 {}
    struct EchoCoin716 {}
    struct EchoCoin717 {}
    struct EchoCoin718 {}
    struct EchoCoin719 {}
    struct EchoCoin720 {}
    struct EchoCoin721 {}
    struct EchoCoin722 {}
    struct EchoCoin723 {}
    struct EchoCoin724 {}
    struct EchoCoin725 {}
    struct EchoCoin726 {}
    struct EchoCoin727 {}
    struct EchoCoin728 {}
    struct EchoCoin729 {}
    struct EchoCoin730 {}
    struct EchoCoin731 {}
    struct EchoCoin732 {}
    struct EchoCoin733 {}
    struct EchoCoin734 {}
    struct EchoCoin735 {}
    struct EchoCoin736 {}
    struct EchoCoin737 {}
    struct EchoCoin738 {}
    struct EchoCoin739 {}
    struct EchoCoin740 {}
    struct EchoCoin741 {}
    struct EchoCoin742 {}
    struct EchoCoin743 {}
    struct EchoCoin744 {}
    struct EchoCoin745 {}
    struct EchoCoin746 {}
    struct EchoCoin747 {}
    struct EchoCoin748 {}
    struct EchoCoin749 {}
    struct EchoCoin750 {}
    struct EchoCoin751 {}
    struct EchoCoin752 {}
    struct EchoCoin753 {}
    struct EchoCoin754 {}
    struct EchoCoin755 {}
    struct EchoCoin756 {}
    struct EchoCoin757 {}
    struct EchoCoin758 {}
    struct EchoCoin759 {}
    struct EchoCoin760 {}
    struct EchoCoin761 {}
    struct EchoCoin762 {}
    struct EchoCoin763 {}
    struct EchoCoin764 {}
    struct EchoCoin765 {}
    struct EchoCoin766 {}
    struct EchoCoin767 {}
    struct EchoCoin768 {}
    struct EchoCoin769 {}
    struct EchoCoin770 {}
    struct EchoCoin771 {}
    struct EchoCoin772 {}
    struct EchoCoin773 {}
    struct EchoCoin774 {}
    struct EchoCoin775 {}
    struct EchoCoin776 {}
    struct EchoCoin777 {}
    struct EchoCoin778 {}
    struct EchoCoin779 {}
    struct EchoCoin780 {}
    struct EchoCoin781 {}
    struct EchoCoin782 {}
    struct EchoCoin783 {}
    struct EchoCoin784 {}
    struct EchoCoin785 {}
    struct EchoCoin786 {}
    struct EchoCoin787 {}
    struct EchoCoin788 {}
    struct EchoCoin789 {}
    struct EchoCoin790 {}
    struct EchoCoin791 {}
    struct EchoCoin792 {}
    struct EchoCoin793 {}
    struct EchoCoin794 {}
    struct EchoCoin795 {}
    struct EchoCoin796 {}
    struct EchoCoin797 {}
    struct EchoCoin798 {}
    struct EchoCoin799 {}
    struct EchoCoin800 {}
    struct EchoCoin801 {}
    struct EchoCoin802 {}
    struct EchoCoin803 {}
    struct EchoCoin804 {}
    struct EchoCoin805 {}
    struct EchoCoin806 {}
    struct EchoCoin807 {}
    struct EchoCoin808 {}
    struct EchoCoin809 {}
    struct EchoCoin810 {}
    struct EchoCoin811 {}
    struct EchoCoin812 {}
    struct EchoCoin813 {}
    struct EchoCoin814 {}
    struct EchoCoin815 {}
    struct EchoCoin816 {}
    struct EchoCoin817 {}
    struct EchoCoin818 {}
    struct EchoCoin819 {}
    struct EchoCoin820 {}
    struct EchoCoin821 {}
    struct EchoCoin822 {}
    struct EchoCoin823 {}
    struct EchoCoin824 {}
    struct EchoCoin825 {}
    struct EchoCoin826 {}
    struct EchoCoin827 {}
    struct EchoCoin828 {}
    struct EchoCoin829 {}
    struct EchoCoin830 {}
    struct EchoCoin831 {}
    struct EchoCoin832 {}
    struct EchoCoin833 {}
    struct EchoCoin834 {}
    struct EchoCoin835 {}
    struct EchoCoin836 {}
    struct EchoCoin837 {}
    struct EchoCoin838 {}
    struct EchoCoin839 {}
    struct EchoCoin840 {}
    struct EchoCoin841 {}
    struct EchoCoin842 {}
    struct EchoCoin843 {}
    struct EchoCoin844 {}
    struct EchoCoin845 {}
    struct EchoCoin846 {}
    struct EchoCoin847 {}
    struct EchoCoin848 {}
    struct EchoCoin849 {}
    struct EchoCoin850 {}
    struct EchoCoin851 {}
    struct EchoCoin852 {}
    struct EchoCoin853 {}
    struct EchoCoin854 {}
    struct EchoCoin855 {}
    struct EchoCoin856 {}
    struct EchoCoin857 {}
    struct EchoCoin858 {}
    struct EchoCoin859 {}
    struct EchoCoin860 {}
    struct EchoCoin861 {}
    struct EchoCoin862 {}
    struct EchoCoin863 {}
    struct EchoCoin864 {}
    struct EchoCoin865 {}
    struct EchoCoin866 {}
    struct EchoCoin867 {}
    struct EchoCoin868 {}
    struct EchoCoin869 {}
    struct EchoCoin870 {}
    struct EchoCoin871 {}
    struct EchoCoin872 {}
    struct EchoCoin873 {}
    struct EchoCoin874 {}
    struct EchoCoin875 {}
    struct EchoCoin876 {}
    struct EchoCoin877 {}
    struct EchoCoin878 {}
    struct EchoCoin879 {}
    struct EchoCoin880 {}
    struct EchoCoin881 {}
    struct EchoCoin882 {}
    struct EchoCoin883 {}
    struct EchoCoin884 {}
    struct EchoCoin885 {}
    struct EchoCoin886 {}
    struct EchoCoin887 {}
    struct EchoCoin888 {}
    struct EchoCoin889 {}
    struct EchoCoin890 {}
    struct EchoCoin891 {}
    struct EchoCoin892 {}
    struct EchoCoin893 {}
    struct EchoCoin894 {}
    struct EchoCoin895 {}
    struct EchoCoin896 {}
    struct EchoCoin897 {}
    struct EchoCoin898 {}
    struct EchoCoin899 {}
    struct EchoCoin900 {}
    struct EchoCoin901 {}
    struct EchoCoin902 {}
    struct EchoCoin903 {}
    struct EchoCoin904 {}
    struct EchoCoin905 {}
    struct EchoCoin906 {}
    struct EchoCoin907 {}
    struct EchoCoin908 {}
    struct EchoCoin909 {}
    struct EchoCoin910 {}
    struct EchoCoin911 {}
    struct EchoCoin912 {}
    struct EchoCoin913 {}
    struct EchoCoin914 {}
    struct EchoCoin915 {}
    struct EchoCoin916 {}
    struct EchoCoin917 {}
    struct EchoCoin918 {}
    struct EchoCoin919 {}
    struct EchoCoin920 {}
    struct EchoCoin921 {}
    struct EchoCoin922 {}
    struct EchoCoin923 {}
    struct EchoCoin924 {}
    struct EchoCoin925 {}
    struct EchoCoin926 {}
    struct EchoCoin927 {}
    struct EchoCoin928 {}
    struct EchoCoin929 {}
    struct EchoCoin930 {}
    struct EchoCoin931 {}
    struct EchoCoin932 {}
    struct EchoCoin933 {}
    struct EchoCoin934 {}
    struct EchoCoin935 {}
    struct EchoCoin936 {}
    struct EchoCoin937 {}
    struct EchoCoin938 {}
    struct EchoCoin939 {}
    struct EchoCoin940 {}
    struct EchoCoin941 {}
    struct EchoCoin942 {}
    struct EchoCoin943 {}
    struct EchoCoin944 {}
    struct EchoCoin945 {}
    struct EchoCoin946 {}
    struct EchoCoin947 {}
    struct EchoCoin948 {}
    struct EchoCoin949 {}
    struct EchoCoin950 {}
    struct EchoCoin951 {}
    struct EchoCoin952 {}
    struct EchoCoin953 {}
    struct EchoCoin954 {}
    struct EchoCoin955 {}
    struct EchoCoin956 {}
    struct EchoCoin957 {}
    struct EchoCoin958 {}
    struct EchoCoin959 {}
    struct EchoCoin960 {}
    struct EchoCoin961 {}
    struct EchoCoin962 {}
    struct EchoCoin963 {}
    struct EchoCoin964 {}
    struct EchoCoin965 {}
    struct EchoCoin966 {}
    struct EchoCoin967 {}
    struct EchoCoin968 {}
    struct EchoCoin969 {}
    struct EchoCoin970 {}
    struct EchoCoin971 {}
    struct EchoCoin972 {}
    struct EchoCoin973 {}
    struct EchoCoin974 {}
    struct EchoCoin975 {}
    struct EchoCoin976 {}
    struct EchoCoin977 {}
    struct EchoCoin978 {}
    struct EchoCoin979 {}
    struct EchoCoin980 {}
    struct EchoCoin981 {}
    struct EchoCoin982 {}
    struct EchoCoin983 {}
    struct EchoCoin984 {}
    struct EchoCoin985 {}
    struct EchoCoin986 {}
    struct EchoCoin987 {}
    struct EchoCoin988 {}
    struct EchoCoin989 {}
    struct EchoCoin990 {}
    struct EchoCoin991 {}
    struct EchoCoin992 {}
    struct EchoCoin993 {}
    struct EchoCoin994 {}
    struct EchoCoin995 {}
    struct EchoCoin996 {}
    struct EchoCoin997 {}
    struct EchoCoin998 {}
    struct EchoCoin999 {}
// #endregion

    const APT_FEE_AMOUNT: u64 = 1000000; // 0.01 APT
    const APT_FEE_COLLECTOR: address = @0xe4ccb6d39136469f376242c31b34d10515c8eaaa38092f804db8e08a8f53c5b2;

    const EWRONG_COIN_TYPE: u64 = 1;
    const ESYMBOL_EXISTS: u64 = 2;
    const EWRONG_SENDER: u64 = 3;

    struct EchoCoin has store, drop, copy {
        id: vector<u8>,
        created_at: u64,
        name: vector<u8>,
        symbol: vector<u8>,
        decimals: u8,
        icon: vector<u8>,
        website: vector<u8>,
        mint_supply: u64,
        mint_address: address,
        creator_address: address,
        type_info: TypeInfo,
    }

    struct BookedCoinInfo has store, drop, copy {
        name: vector<u8>,
        symbol: vector<u8>,
        decimals: u8,
        icon: vector<u8>,
        website: vector<u8>,
        mint_supply: u64,
        mint_address: address,
        creator_address: address,
    }

    struct EchoCoinStore has key {
        // struct name -> EchoCoin
        echo_coins: Table<vector<u8>, EchoCoin>,
        // symbol -> BookedCoinInfo
        booked_coins: Table<vector<u8>, BookedCoinInfo>,
        // symbol list
        symbols: vector<vector<u8>>,
    }

    struct CoinCreationEvent has drop, store {
        coin_type: TypeInfo,
        timestamp: u64,
        value: u64,
    }

    struct Events has key {
        coin_created_event: EventHandle<CoinCreationEvent>,
    }

    struct Count has key {
        value: u64,
    }

    fun init_module(admin: &signer) {
        move_to(admin, Count { value: 0 });

        move_to(admin, EchoCoinStore {
            echo_coins: table::new(),
            booked_coins: table::new(),
            symbols: vector::empty(),
        });

        move_to(admin, Events {
            coin_created_event: account::new_event_handle<CoinCreationEvent>(admin),
        });
    }

    /**
    * Prebook a coin symbol
    * This is used to reserve a symbol for a coin for a fee.
    * We need this step as only the module that created the coin
    * can mint it afterwords.
    * The person that prebooks the coin will be the one defining the
    * coin parameters (name, symbol, supply, etc.)
    */
    entry fun prebook_coin<FeeCoinType>(
        sender: &signer,
        name: vector<u8>,
        symbol: vector<u8>,
        decimals: u8,
        icon: vector<u8>,
        website: vector<u8>,
        mint_supply: u64,
        mint_address: address,
    ) acquires EchoCoinStore {
        assert!(type_info::type_of<FeeCoinType>() == type_info::type_of<AptosCoin>(), EWRONG_COIN_TYPE);

        let sender_address = signer::address_of(sender);
        let echo_coin_store = borrow_global_mut<EchoCoinStore>(@PopCoin);
        let booked_coins = &mut echo_coin_store.booked_coins;
        let is_reserved = table::contains<vector<u8>, BookedCoinInfo>(booked_coins, symbol);

        if (is_reserved == false) {
            // Collect fee
            aptos_account::transfer_coins<FeeCoinType>(
                sender,
                APT_FEE_COLLECTOR,
                APT_FEE_AMOUNT
            );

            table::add(booked_coins, symbol, BookedCoinInfo {
                name,
                symbol,
                decimals,
                icon,
                website,
                mint_supply,
                mint_address,
                creator_address: sender_address,
            });
        }
    }

    /**
    * Create a coin
    * This is used to create a coin after it has been prebooked
    * The module owner can create a coin for any prebooked symbol
    * The coin will be created with the parameters defined by the
    * prebooker.
    */
    entry fun create_coin<TargetCoinType>(
        sender: &signer,
        symbol: vector<u8>,
    ) acquires Count, Events, EchoCoinStore {
        assert!(signer::address_of(sender) == @PopCoin, EWRONG_SENDER);

        let echo_coin_store = borrow_global_mut<EchoCoinStore>(@PopCoin);
        let echo_coin_exists = table::contains<vector<u8>, EchoCoin>(&mut echo_coin_store.echo_coins, symbol);
        assert!(echo_coin_exists == false, ESYMBOL_EXISTS);

        let booked_coins = &mut echo_coin_store.booked_coins;
        let is_reserved = table::contains<vector<u8>, BookedCoinInfo>(booked_coins, symbol);
        assert!(is_reserved == true, ESYMBOL_EXISTS);

        let existing_symbol = vector::contains(&mut echo_coin_store.symbols, &symbol);
        assert!(existing_symbol == false, ESYMBOL_EXISTS);

        let booked_coin = table::borrow<vector<u8>, BookedCoinInfo>(booked_coins, symbol);

        let name = booked_coin.name;
        let decimals = booked_coin.decimals;
        let mint_supply = booked_coin.mint_supply;
        let mint_address = booked_coin.mint_address;
        let website = booked_coin.website;
        let icon = booked_coin.icon;

        assert!(mint_supply > 0, EWRONG_SENDER);

        let count = borrow_global_mut<Count>(@PopCoin);
        let events = borrow_global_mut<Events>(@PopCoin);

        let (burn_cap, freeze_cap, mint_cap) = coin::initialize<TargetCoinType>(
            sender,
            string::utf8(name),
            string::utf8(symbol),
            decimals,
            true,
        );

        let coins_minted = coin::mint(mint_supply, &mint_cap);
        coin::deposit(signer::address_of(sender), coins_minted);

        coin::destroy_burn_cap(burn_cap);
        coin::destroy_mint_cap(mint_cap);
        coin::destroy_freeze_cap(freeze_cap);

        aptos_account::transfer_coins<TargetCoinType>(
            sender,
            mint_address,
            mint_supply
        );

        let id = symbol; // use symbol as id for now
        table::add(&mut echo_coin_store.echo_coins, id, EchoCoin {
            id,
            name,
            symbol,
            decimals,
            icon,
            website,
            mint_supply,
            mint_address,
            created_at: timestamp::now_microseconds(),
            creator_address: booked_coin.creator_address,
            type_info: type_info::type_of<TargetCoinType>(),
        });

        vector::push_back(&mut echo_coin_store.symbols, symbol);

        event::emit_event(&mut events.coin_created_event, CoinCreationEvent {
            coin_type: type_info::type_of<TargetCoinType>(),
            timestamp: timestamp::now_microseconds(),
            value: count.value,
        });

        count.value = count.value + 1;
    }

    #[view]
    public fun get_coin_count(): u64 acquires Count {
      let count = borrow_global_mut<Count>(@PopCoin);
      count.value
    }

    #[view]
    /// Return echo coin saved data in the table
    public fun get_echo_coin(symbol: vector<u8>): EchoCoin acquires EchoCoinStore {
        let echo_coin_store = borrow_global_mut<EchoCoinStore>(@PopCoin);
        let echo_coin = table::borrow<vector<u8>, EchoCoin>(&mut echo_coin_store.echo_coins, symbol);
        *echo_coin
    }
}
