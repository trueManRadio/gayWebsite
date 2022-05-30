import 'player.dart';

Map<String, String> trackNames = {
  "basta-sansara-right-version-by-fuggot.mp3": "Баста - сансара",
  "dora-kapli-right-version-gachi-remix.mp3": "Дора - капли",
  "dora-mladsaya-sestra-gachi-remix-right-version.mp3": "Дора - младшая сестра",
  "dora-osen-pyanaya-right-version-gachi-remix.mp3": "Дора - осень пьяная",
  "dora-poslyu-ego-naright-version-gachi-remix.mp3": "Дора - пошлю его на...",
  "dora-vtyurilasright-version-gachi-remix.mp3": "Дора - втюрилась",
  "dora-zadolbal-menya-ignorit-right-version-gachi-remix.mp3":
      "Дора - задолбал меня игнорить",
  "femlove-fotografiruyu-zakatright-version-gachi-remix.mp3":
      "Fem.Love - фотографирую закат",
  "hensy-pobolelo-i-proslo-gachi-remix-right-version.mp3":
      "Hensy - поболело и прошло",
  "homie-bezumno-mozno-byt-pervym-gachi-remix-right-version.mp3":
      "Homie - безумно можно быть первым",
  "karat-a-skolko-v-serdce-ran-right-version-g-man.mp3":
      "Карат - а сколько в сердце ран",
  "kotenok-v-kolodce-gachi-remix.mp3": "Кристина Прилепина - котенок",
  "lizer-packa-sigaret-right-version-gachi-remix.mp3": "Lizer - пачка сигарет",
  "lyube-davai-zaright-version-gachiremix.mp3": "ЛЮБЭ - давай за",
  "maksim-moi-rai-right-versiongachi-remix-remastered.mp3": "Максим - мой рай",
  "maksim-naucus-letat-right-version-gachi-remix.mp3":
      "Максим - научусь летать",
  "maksim-son-right-versiongachi-remix.mp3": "Максим - сон",
  "maksim-trudnyi-vozrast-right-version-fallfrog-gachi-remix.mp3":
      "Максим - трудный возраст",
  "maksim-vetrom-stat-gachi-remix.mp3": "Максим - ветром стать",
  "maks-korz-maloletka-right-version-russian-slaves-remix.mp3":
      "Макс Корж - малолетка",
  "maks-korz-motylekright-version-gachi-remix.mp3": "Макс Корж - мотылек",
  "morgenshtern-selyavi-right-versiongachi-remix.mp3": "Morgenshtern - селяви",
  "morgenstern-uff-dengiright-version-gachi-remix-gachibass.mp3":
      "Morgenshtern - уфф, деньги",
  "nurminskii-drug-right-version-gachi-remix.mp3": "Нурминский - друг",
  "nurminskii-dyadya-billi-gachi-remix-right-version.mp3":
      "Нурминский - дядя Билли",
  "picca-oruzieright-version-gachi-remix.mp3": "Пицца - оружие",
  "prpaganda-melm.mp3": "Пропаганда - мелом",
  "ruki-vverx-on-tebya-celuet-right-version.mp3": "Руки вверх - он тебя целует",
  "sektor-assa-liricum-tredcat-gachi-remix.mp3": "Сектор газа - лирика",
  "the-vepri-bekap-right-version-gachi-remix.mp3": "The Вепри - бекап",
  "tik-tok-kuda-neset-dym-right-version-fallfrog-gachi-remix.mp3":
      "Cvetocek7 - куда несет дым",
  "ty-tak-krasiva-right-versiongachi-remix.mp3":
      "Quest Pistols - ты так красива",
  "valentin-strykalo-mama-ya-geivsyo-reseno-right-version.mp3":
      "Валентин Стрыкало - мама я гей",
  "valentin-strykalo-nas-dungeon-mastergachi-remix-gachibass.mp3":
      "Валентин Стрыкало - наше лето",
  "via-gra-popytka-5-right-version-g-man.mp3": "Виа-Гра - попытка номер 5",
  "wiz-khalifa-ft-charlie-puth-see-you-again-rightversion.mp3":
      "Wiz Khalifa feat Charlie Puth - see you again",
  "yurii-satunov-detstvoright-version-gachi-remix.mp3": "Юрий Шатунов- детство",
  "zippo-kuris-casto-right-version-fallfrog-gachi-remix.mp3":
      "Zippo - куришь часто",
  "zuki-batareika-right-version-gachi-remix.mp3": "Жуки - батарейка",
  "4-pacana-ix-bylo-cetvero-right-version-gachi-remix.mp3":
      "Пятый регион - четыре пацана",
  "basta-medlyacokgachibass-right-version.mp3": "Баста - медлячок",
  "55x55-kak-pukat-nezametnoright-version-gachi-remix.mp3":
      "55Х55 - как пукать незаметно",
  "55x55-tupoe-gright-version-gachi-remix.mp3": "55Х55 - тупое г...",
  "aleksandr-pistoletov-nas-samolet-right-version.mp3":
      "Александр Пистолетов - наш самолет",
  "anacondaz-mama-ya-lyublyu-right-version-gachi-remix-gachibass.mp3":
      "Anacondaz - мама я люблю",
  "artur-pirozkov-zacepila-right-version-gachi-remix.mp3":
      "Артур Пирожков - зацепила",
  "brb-obnyal-pripodnyal-right-version-g-man.mp3": "BRB - обнял-приподнял",
  "butyrka-sarik-right-version.mp3": "Бутырка - шарик",
  "dbrta.mp3": "Барбарики - доброта",
  "dj-misha-fiksiki-tydyshh-right-version-gachi-remix-perezaliv.mp3":
      "Фиксики - тыдыщь",
  "dlb-gacibass-right-version-gachi-remix.mp3": "dlb. - гачибасс",
  "ebanko-gady-right-version-gachi-remix.mp3": "Ебанько - гады",
  "ebanko-landysi-right-version-gachi-remix.mp3": "Ебанько - ландыши",
  "ebanko-roma-ft-bruh-master-gachisound-right-version-gachi-remix.mp3":
      "Ебанько - Рома",
  "enjoykin-bratiska-right-version-gachi-remix-by-dan-varkholme-gachi.mp3":
      "Enjoykin - братишка",
  "femlove-1000-7-right-version-gachi-remix.mp3": "fem.love - 1000-7",
  "gorillaz-feel-good-inc-gachi-mix-right-version.mp3":
      "Gorillaz - feel good inc.",
  "gubki-bantikom-kristina-orbakaite-right-version-or-else-gachi-remix.mp3":
      "Кристина Орбакайте - губки бантиком",
  "kraski-ya-lyublyu-tebya-sergei-right-version-gachi-remix.mp3":
      "Краски - я люблю тебя, Сергей",
  "maddymurk-texnocastuski-right-version.mp3": "Maddy Murk - техночастушки",
  "morgenshtern-dulo-right-version-gachi-mix.mp3": "Morgenshtern - дуло",
  "niletto-lyubimkaright-version.mp3": "Niletto - любимка",
  "nurminskii-valim-right-version-gachi-remix.mp3": "Нурминский - валим",
  "olga-buzova-skuka-vesna-right-version-gachi-remix-by-wdsc.mp3":
      "Ольга Бузова - сука весна",
  "o-zone-numa-numa-yeright-version-gachi-remix-gachi-show.mp3":
      "O-Zone - numa-numa",
  "perezaliv-basshunter-dota-gachi-remix.mp3": "Basshunter - dota",
  "shadowraze-showdownright-version-gachi-remix.mp3": "Shadowraze - showdown",
  "shtern-morgenshtern-hummerright-version-gachi-remix.mp3":
      "Shtern, Morgenshtern - hummer",
  "skillet-awake-and-aliveright-versiongachi-remix.mp3":
      "Skillet - awake and alive",
  "slava-marlow-ty-goris-kak-ogon-obeme-gachi-mashup.mp3":
      "Slava Marlow - ты горишь как огонь",
  "sultan-uragan-na-diskoteku-gachi-remix-right-version.mp3":
      "Султан Ураган - на дискотеку",
  "sveta-a-mozet-da-right-version.mp3": "Света - а может да",
  "timati-baklazan-right-version-gachi-remix.mp3": "Тимати - баклажан",
  "trofim-gorod-soci-gachi-remix-right-version.mp3": "Трофим - город Сочи",
  "verka-serdyucka-gulyanocka-right-version-g-man.mp3":
      "Верка Сердючка - гуляночка",
  "ya-kak-dungeon-master-tomas.mp3": "Alley Gang - паравозик Томас",
  "ya-kogda-nibud-uidu-feel-good-inc-by-checkoff.mp3":
      "Morgenshtern - я когда нибудь уйду",
  "55x55-eto-navalnyi-right-version-gachi-remix.mp3": "55Х55 - это Навальный",
  "cumbusters.mp3": "Ghostbusters - main theme",
  "dima-bilan-molniya-right-version-gachi-remix.mp3": "Дима Билан - молния",
  "eiffel-65-blue-da-ba-dee-right-version-gachi-remix.mp3": "Eiffel 65 - blue",
  "irina-allegrova-mladsii-leatherman-tredcat-gachi-remix-mladsii-leitenant.mp3":
      "Ирина Аллегрова - младший лейтенант",
  "klava-koka-baby-right-version-gachi-remix.mp3": "Клава Кока - бабы",
  "klava-koka-hensy-kostyorright-version-gachi-remix.mp3":
      "Клава Кока, Hensy - костёр",
  "klava-koka-pokinula-cat-right-version-russian-slaves-remix.mp3":
      "Клава Кока - покинула чат",
  "klava-koka-ruki-vverx-nokautright-version-gachi-remix.mp3":
      "Клава Кока, Руки Вверх - нокаут",
  "klava-koka-ximiyaright-version-gachi-remix-gachibass.mp3":
      "Клава Кока - химия",
  "maks-korz-zit-v-kaif-right-version-gachi-remix-gachibass.mp3":
      "Макс Корж - жить в кайф",
  "mc-pox-vesennii-les-right-version-gachi-remix.mp3": "МС Пох - весенний лес",
  "meibi-beibi-dora-barbisaiz-right-version-gachi-remix.mp3":
      "Мейби Бейби, Дора - барбисайз",
  "mia-boyka-begu-po-tropinke-right-version-gachi-remix.mp3":
      "Мия Бойка - бегу по тропинке",
  "monetocka-padat-v-cum-tredcat-gachi-remix-padat-v-gryaz.mp3":
      "Монеточка - падать в грязь",
  "ms-pox-banka-parilka-right-version-gachi-remix.mp3":
      "МС Пох - банька парилка",
  "niletto-ft-klava-koka-krasright-version-gachi-remix.mp3":
      "Niletto, Клава Кока - краш",
  "perezaliv-aqua-barbie-girl-right-version.mp3": "Aqua - barbie girl",
  "perezaliv-danzel-you-spin-me-round-right-version.mp3":
      "Danzel - you spin me round",
  "perezaliv-dead-blonde-malcik-na-devyatke-right-version.mp3":
      "Dead Blonde - мальчик на девятке",
  "perezaliv-modern-talking-brother-louie-right-version.mp3":
      "Modern Talking - brother Louie",
  "rammstein-du-hast-gachi-mix-right-version.mp3": "Rammstein - du hast",
  "raz-raz-raz-eto-xardbass-right-version-gachi-remix.mp3": "Russian hardbass",
  "slava-marlowcamry-35-v-stile-gaci.mp3": "Slava Marlow - camry 3.5",
  "tatu-nas-ne-dogonyat-gachi-remix.mp3": "taTu - нас не догонят",
  "the-vepri-kacevo-serdce-right-version-gachi-remix.mp3":
      "The Вепри - кацево сердце",
  "the-vepri-konsyumerizm-right-version-gachi-remix.mp3":
      "The Вепри - консьюмеризм",
  "the-vepri-polnyi-kurs-social-darvinizma-right-version-gachi-remix.mp3":
      "The Вепри - полный курс социал-дарвинизма",
  "turbomoda-kanikuly-right-version-gachi-remix.mp3": "Турбомода - каникулы",
  "vinks-right-version-gachi-remix-zastavka-iz-vinks.mp3": "Винкс - main theme",
  "vot-i-pomer-ded-maksim-right-version-gachi-remix.mp3":
      "Вот и помер дед Максим",
  "yunost-v-sapogax-gachi-version-gacimuci-remiks.mp3":
      "Солдаты - юность в сапогах",
  "zestokii-dungeon-master-evangelion-opening-right-version-evangelion-opening-gachi.mp3":
      "Evangelion - opening",
  "a4-kids-right-version-gachi-remix.mp3": "A4- kids",
  "cmh-x-gspd-sessiya-right-versiongachi-remix.mp3": "cmh.x, GSPD - сессия",
  "louis-armstrong-what-a-wonderful-world-right-version.mp3": "Louis Armstrong - what a wonderful world",
  "platters-feat-boynextdoor-sixteen-slaves.mp3": "The Platters - Sixteen Tons",
};

Map<GayWave, List<String>> waveContents = {
  GayWave.none: [
    "Wtf bro",
  ],
  GayWave.gay: [
    "55x55-eto-navalnyi-right-version-gachi-remix.mp3",
    "55x55-kak-pukat-nezametnoright-version-gachi-remix.mp3",
    "55x55-tupoe-gright-version-gachi-remix.mp3",
    "aleksandr-pistoletov-nas-samolet-right-version.mp3",
    "anacondaz-mama-ya-lyublyu-right-version-gachi-remix-gachibass.mp3",
    "artur-pirozkov-zacepila-right-version-gachi-remix.mp3",
    "brb-obnyal-pripodnyal-right-version-g-man.mp3",
    "butyrka-sarik-right-version.mp3",
    "dbrta.mp3",
    "dj-misha-fiksiki-tydyshh-right-version-gachi-remix-perezaliv.mp3",
    "dlb-gacibass-right-version-gachi-remix.mp3",
    "ebanko-gady-right-version-gachi-remix.mp3",
    "ebanko-landysi-right-version-gachi-remix.mp3",
    "ebanko-roma-ft-bruh-master-gachisound-right-version-gachi-remix.mp3",
    "enjoykin-bratiska-right-version-gachi-remix-by-dan-varkholme-gachi.mp3",
    "femlove-1000-7-right-version-gachi-remix.mp3",
    "gorillaz-feel-good-inc-gachi-mix-right-version.mp3",
    "gubki-bantikom-kristina-orbakaite-right-version-or-else-gachi-remix.mp3",
    "kraski-ya-lyublyu-tebya-sergei-right-version-gachi-remix.mp3",
    "maddymurk-texnocastuski-right-version.mp3",
    "morgenshtern-dulo-right-version-gachi-mix.mp3",
    "niletto-lyubimkaright-version.mp3",
    "nurminskii-valim-right-version-gachi-remix.mp3",
    "olga-buzova-skuka-vesna-right-version-gachi-remix-by-wdsc.mp3",
    "o-zone-numa-numa-yeright-version-gachi-remix-gachi-show.mp3",
    "perezaliv-basshunter-dota-gachi-remix.mp3",
    "shadowraze-showdownright-version-gachi-remix.mp3",
    "shtern-morgenshtern-hummerright-version-gachi-remix.mp3",
    "skillet-awake-and-aliveright-versiongachi-remix.mp3",
    "slava-marlow-ty-goris-kak-ogon-obeme-gachi-mashup.mp3",
    "sultan-uragan-na-diskoteku-gachi-remix-right-version.mp3",
    "sveta-a-mozet-da-right-version.mp3",
    "timati-baklazan-right-version-gachi-remix.mp3",
    "trofim-gorod-soci-gachi-remix-right-version.mp3",
    "verka-serdyucka-gulyanocka-right-version-g-man.mp3",
    "ya-kak-dungeon-master-tomas.mp3",
    "ya-kogda-nibud-uidu-feel-good-inc-by-checkoff.mp3",
    "louis-armstrong-what-a-wonderful-world-right-version.mp3",
    "platters-feat-boynextdoor-sixteen-slaves.mp3",
  ],
  GayWave.sadGay: [
    "4-pacana-ix-bylo-cetvero-right-version-gachi-remix.mp3",
    "basta-medlyacokgachibass-right-version.mp3",
    "basta-sansara-right-version-by-fuggot.mp3",
    "dora-kapli-right-version-gachi-remix.mp3",
    "dora-mladsaya-sestra-gachi-remix-right-version.mp3",
    "dora-osen-pyanaya-right-version-gachi-remix.mp3",
    "dora-poslyu-ego-naright-version-gachi-remix.mp3",
    "dora-vtyurilasright-version-gachi-remix.mp3",
    "dora-zadolbal-menya-ignorit-right-version-gachi-remix.mp3",
    "femlove-fotografiruyu-zakatright-version-gachi-remix.mp3",
    "hensy-pobolelo-i-proslo-gachi-remix-right-version.mp3",
    "homie-bezumno-mozno-byt-pervym-gachi-remix-right-version.mp3",
    "karat-a-skolko-v-serdce-ran-right-version-g-man.mp3",
    "kotenok-v-kolodce-gachi-remix.mp3",
    "lizer-packa-sigaret-right-version-gachi-remix.mp3",
    "lyube-davai-zaright-version-gachiremix.mp3",
    "maksim-moi-rai-right-versiongachi-remix-remastered.mp3",
    "maksim-naucus-letat-right-version-gachi-remix.mp3",
    "maksim-son-right-versiongachi-remix.mp3",
    "maksim-trudnyi-vozrast-right-version-fallfrog-gachi-remix.mp3",
    "maksim-vetrom-stat-gachi-remix.mp3",
    "maks-korz-maloletka-right-version-russian-slaves-remix.mp3",
    "maks-korz-motylekright-version-gachi-remix.mp3",
    "morgenshtern-selyavi-right-versiongachi-remix.mp3",
    "morgenstern-uff-dengiright-version-gachi-remix-gachibass.mp3",
    "nurminskii-drug-right-version-gachi-remix.mp3",
    "nurminskii-dyadya-billi-gachi-remix-right-version.mp3",
    "picca-oruzieright-version-gachi-remix.mp3",
    "prpaganda-melm.mp3",
    "ruki-vverx-on-tebya-celuet-right-version.mp3",
    "sektor-assa-liricum-tredcat-gachi-remix.mp3",
    "the-vepri-bekap-right-version-gachi-remix.mp3",
    "tik-tok-kuda-neset-dym-right-version-fallfrog-gachi-remix.mp3",
    "ty-tak-krasiva-right-versiongachi-remix.mp3",
    "valentin-strykalo-mama-ya-geivsyo-reseno-right-version.mp3",
    "valentin-strykalo-nas-dungeon-mastergachi-remix-gachibass.mp3",
    "via-gra-popytka-5-right-version-g-man.mp3",
    "wiz-khalifa-ft-charlie-puth-see-you-again-rightversion.mp3",
    "yurii-satunov-detstvoright-version-gachi-remix.mp3",
    "zippo-kuris-casto-right-version-fallfrog-gachi-remix.mp3",
    "zuki-batareika-right-version-gachi-remix.mp3",
  ],
  GayWave.trueGay: [
    "a4-kids-right-version-gachi-remix.mp3",
    "cmh-x-gspd-sessiya-right-versiongachi-remix.mp3",
    "cumbusters.mp3",
    "dima-bilan-molniya-right-version-gachi-remix.mp3",
    "eiffel-65-blue-da-ba-dee-right-version-gachi-remix.mp3",
    "irina-allegrova-mladsii-leatherman-tredcat-gachi-remix-mladsii-leitenant.mp3",
    "klava-koka-baby-right-version-gachi-remix.mp3",
    "klava-koka-hensy-kostyorright-version-gachi-remix.mp3",
    "klava-koka-pokinula-cat-right-version-russian-slaves-remix.mp3",
    "klava-koka-ruki-vverx-nokautright-version-gachi-remix.mp3",
    "klava-koka-ximiyaright-version-gachi-remix-gachibass.mp3",
    "maks-korz-zit-v-kaif-right-version-gachi-remix-gachibass.mp3",
    "mc-pox-vesennii-les-right-version-gachi-remix.mp3",
    "meibi-beibi-dora-barbisaiz-right-version-gachi-remix.mp3",
    "mia-boyka-begu-po-tropinke-right-version-gachi-remix.mp3",
    "monetocka-padat-v-cum-tredcat-gachi-remix-padat-v-gryaz.mp3",
    "ms-pox-banka-parilka-right-version-gachi-remix.mp3",
    "niletto-ft-klava-koka-krasright-version-gachi-remix.mp3",
    "perezaliv-aqua-barbie-girl-right-version.mp3",
    "perezaliv-danzel-you-spin-me-round-right-version.mp3",
    "perezaliv-dead-blonde-malcik-na-devyatke-right-version.mp3",
    "perezaliv-modern-talking-brother-louie-right-version.mp3",
    "rammstein-du-hast-gachi-mix-right-version.mp3",
    "raz-raz-raz-eto-xardbass-right-version-gachi-remix.mp3",
    "slava-marlowcamry-35-v-stile-gaci.mp3",
    "tatu-nas-ne-dogonyat-gachi-remix.mp3",
    "the-vepri-kacevo-serdce-right-version-gachi-remix.mp3",
    "the-vepri-konsyumerizm-right-version-gachi-remix.mp3",
    "the-vepri-polnyi-kurs-social-darvinizma-right-version-gachi-remix.mp3",
    "turbomoda-kanikuly-right-version-gachi-remix.mp3",
    "vinks-right-version-gachi-remix-zastavka-iz-vinks.mp3",
    "vot-i-pomer-ded-maksim-right-version-gachi-remix.mp3",
    "yunost-v-sapogax-gachi-version-gacimuci-remiks.mp3",
    "zestokii-dungeon-master-evangelion-opening-right-version-evangelion-opening-gachi.mp3",
  ],
};
List<String> adContents = [
  "88005553535-right-version-feat-tacoguy.mp3",
  "audioreklama-vk-right-version.mp3",
  "fistingtryanka-gaci-reklama-right-version-gachi-remix.mp3",
  "gachi-galkin-pravilnaya-rasprodaza-na-aliexpress.mp3",
  "novogodnee-obrashhenie-prezidenta-2021-right-version-gachi-remix.mp3",
  "pravilnaya-reklama-1xbet-right-version-mrake-perezaliv.mp3",
  "recept-plova-right-version-gachi-remix.mp3",
  "reklama-agusi-right-version-gachi-remix.mp3",
  "reklama-cekc-sopa-tixii-omut-right-version-gachi-remix.mp3",
  "reklama-failoobmennika-right-version.mp3",
  "reklama-gachi-tinkoff-right-version.mp3",
  "reklama-iogurta-right-version.mp3",
  "reklama-makdonalds-right-version-gachi-remix.mp3",
  "reklama-vkontakte-right-version.mp3",
  "right-version-reklamy-pepsi-gachi.mp3",
  "v-semen-tvoya-sila-i-mudrost.mp3",
  "zolotaya-semen.mp3",
];
