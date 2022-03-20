module dummydata

function loadData(){
var user1 := User{
  name := "Gian Richardet",
  email := "grichardet0@free.fr",
  password := ("123" as Secret).digest(),
  verified := false,
  newsletter := true
};
user1.save();

var user2 := User{
  name := "sklampt1",
  email := "sklampt1@meetup.com",
  password := ("123" as Secret).digest(),
  verified := false,
  newsletter := false
};
user2.save();

var user3 := User{
  roles := {PREMIUM},
  name := "ehatter2",
  email := "ehatter2@rambler.ru",
  password := ("123" as Secret).digest(),
  verified := true,
  newsletter := false
};
user3.save();

var user4 := User{
  name := "Belle Seabon",
  email := "bseabon3@bloglovin.com",
  password := ("123" as Secret).digest(),
  verified := false,
  newsletter := false
};
user4.save();

var user5 := User{
  name := "dbigly4",
  email := "dbigly4@istockphoto.com",
  password := ("123" as Secret).digest(),
  verified := true,
  newsletter := false
};
user5.save();

var user6 := User{
  name := "Manon Southcombe",
  email := "msouthcombe5@blog.com",
  password := ("123" as Secret).digest(),
  verified := false,
  newsletter := false
};
user6.save();

var user7 := User{
  name := "Godfree Riolfi",
  email := "griolfi6@studiopress.com",
  password := ("123" as Secret).digest(),
  verified := false,
  newsletter := false
};
user7.save();

var user8 := User{
  roles := {PREMIUM},
  name := "Alikee Bedle",
  email := "abedle7@virginia.edu",
  password := ("123" as Secret).digest(),
  verified := false,
  newsletter := false
};
user8.save();

var user9 := User{
  name := "Sula Naile",
  email := "snaile8@phpbb.com",
  password := ("123" as Secret).digest(),
  verified := true,
  newsletter := true
};
user9.save();

var user10 := User{
  name := "mlibbis9",
  email := "mlibbis9@arizona.edu",
  password := ("123" as Secret).digest(),
  verified := false,
  newsletter := true
};
user10.save();

var user11 := User{
  name := "Milt Greenaway",
  email := "mgreenawaya@icq.com",
  password := ("123" as Secret).digest(),
  verified := false,
  newsletter := true
};
user11.save();

var user12 := User{
  name := "fhasemanb",
  email := "fhasemanb@noaa.gov",
  password := ("123" as Secret).digest(),
  verified := false,
  newsletter := false
};
user12.save();

var user13 := User{
  roles := {PREMIUM},
  name := "triceardsc",
  email := "triceardsc@about.me",
  password := ("123" as Secret).digest(),
  verified := true,
  newsletter := false
};
user13.save();

var user14 := User{
  roles := {PREMIUM},
  name := "khayhurstd",
  email := "khayhurstd@google.nl",
  password := ("123" as Secret).digest(),
  verified := true,
  newsletter := true
};
user14.save();

var user15 := User{
  roles := {PREMIUM},
  name := "Lewie Arington",
  email := "laringtone@ebay.co.uk",
  password := ("123" as Secret).digest(),
  verified := false,
  newsletter := false
};
user15.save();

var user16 := User{
  name := "cklaassensf",
  email := "cklaassensf@ebay.com",
  password := ("123" as Secret).digest(),
  verified := false,
  newsletter := false
};
user16.save();

var user17 := User{
  name := "randriulisg",
  email := "randriulisg@cyberchimps.com",
  password := ("123" as Secret).digest(),
  verified := true,
  newsletter := true
};
user17.save();

var user18 := User{
  roles := {PREMIUM},
  name := "tstofferh",
  email := "tstofferh@cnbc.com",
  password := ("123" as Secret).digest(),
  verified := false,
  newsletter := true
};
user18.save();

var user19 := User{
  name := "Nola Pettecrew",
  email := "npettecrewi@oakley.com",
  password := ("123" as Secret).digest(),
  verified := false,
  newsletter := true
};
user19.save();

var user20 := User{
  name := "Suzy Tripe",
  email := "stripej@people.com.cn",
  password := ("123" as Secret).digest(),
  verified := false,
  newsletter := false
};
user20.save();

var user21 := User{
  roles := {PREMIUM},
  name := "hlenink",
  email := "hlenink@imageshack.us",
  password := ("123" as Secret).digest(),
  verified := true,
  newsletter := false
};
user21.save();

var user22 := User{
  roles := {PREMIUM},
  name := "Dino Balden",
  email := "dbaldenl@wsj.com",
  password := ("123" as Secret).digest(),
  verified := false,
  newsletter := true
};
user22.save();

var user23 := User{
  roles := {PREMIUM},
  name := "Vivianne Stait",
  email := "vstaitm@ihg.com",
  password := ("123" as Secret).digest(),
  verified := false,
  newsletter := true
};
user23.save();

var user24 := User{
  name := "amcalessn",
  email := "amcalessn@technorati.com",
  password := ("123" as Secret).digest(),
  verified := false,
  newsletter := false
};
user24.save();

var user25 := User{
  roles := {PREMIUM},
  name := "twakelyo",
  email := "twakelyo@4shared.com",
  password := ("123" as Secret).digest(),
  verified := true,
  newsletter := false
};
user25.save();

var user26 := User{
  name := "dconrathp",
  email := "dconrathp@cargocollective.com",
  password := ("123" as Secret).digest(),
  verified := true,
  newsletter := true
};
user26.save();

var user27 := User{
  roles := {PREMIUM},
  name := "zdavidaiq",
  email := "zdavidaiq@symantec.com",
  password := ("123" as Secret).digest(),
  verified := true,
  newsletter := true
};
user27.save();

var user28 := User{
  name := "Marena Goss",
  email := "mgossr@theglobeandmail.com",
  password := ("123" as Secret).digest(),
  verified := true,
  newsletter := false
};
user28.save();

var user29 := User{
  name := "Connor Ruppertz",
  email := "cruppertzs@craigslist.org",
  password := ("123" as Secret).digest(),
  verified := true,
  newsletter := true
};
user29.save();

var user30 := User{
  name := "Rogers Seilmann",
  email := "rseilmannt@squidoo.com",
  password := ("123" as Secret).digest(),
  verified := false,
  newsletter := true
};
user30.save();

var user31 := User{
  name := "shuncoteu",
  email := "shuncoteu@washington.edu",
  password := ("123" as Secret).digest(),
  verified := true,
  newsletter := true
};
user31.save();

var user32 := User{
  name := "jhadinghamv",
  email := "jhadinghamv@ebay.co.uk",
  password := ("123" as Secret).digest(),
  verified := true,
  newsletter := true
};
user32.save();

var user33 := User{
  name := "josbaldstonew",
  email := "josbaldstonew@netvibes.com",
  password := ("123" as Secret).digest(),
  verified := false,
  newsletter := false
};
user33.save();

var user34 := User{
  roles := {PREMIUM},
  name := "Emery Bruckental",
  email := "ebruckentalx@nationalgeographic.com",
  password := ("123" as Secret).digest(),
  verified := false,
  newsletter := false
};
user34.save();

var user35 := User{
  roles := {PREMIUM},
  name := "mugoy",
  email := "mugoy@wix.com",
  password := ("123" as Secret).digest(),
  verified := false,
  newsletter := false
};
user35.save();

var user36 := User{
  name := "hnorringtonz",
  email := "hnorringtonz@is.gd",
  password := ("123" as Secret).digest(),
  verified := false,
  newsletter := true
};
user36.save();

var user37 := User{
  name := "Christen Wingeat",
  email := "cwingeat10@github.com",
  password := ("123" as Secret).digest(),
  verified := true,
  newsletter := true
};
user37.save();

var user38 := User{
  name := "Leah Kyte",
  email := "lkyte11@pcworld.com",
  password := ("123" as Secret).digest(),
  verified := false,
  newsletter := true
};
user38.save();

var user39 := User{
  name := "jredsell12",
  email := "jredsell12@state.tx.us",
  password := ("123" as Secret).digest(),
  verified := true,
  newsletter := false
};
user39.save();

var user40 := User{
  roles := {PREMIUM},
  name := "Chrysler Trask",
  email := "ctrask13@wiley.com",
  password := ("123" as Secret).digest(),
  verified := false,
  newsletter := false
};
user40.save();

var user41 := User{
  name := "mtittletross14",
  email := "mtittletross14@ebay.co.uk",
  password := ("123" as Secret).digest(),
  verified := true,
  newsletter := true
};
user41.save();

var user42 := User{
  name := "Carlota Matussevich",
  email := "cmatussevich15@cafepress.com",
  password := ("123" as Secret).digest(),
  verified := true,
  newsletter := false
};
user42.save();

var user43 := User{
  roles := {PREMIUM},
  name := "Kimberley Randleson",
  email := "krandleson16@drupal.org",
  password := ("123" as Secret).digest(),
  verified := false,
  newsletter := false
};
user43.save();

var user44 := User{
  name := "Kin Worwood",
  email := "kworwood17@arizona.edu",
  password := ("123" as Secret).digest(),
  verified := true,
  newsletter := true
};
user44.save();

var user45 := User{
  roles := {PREMIUM},
  name := "Dix Treske",
  email := "dtreske18@hao123.com",
  password := ("123" as Secret).digest(),
  verified := false,
  newsletter := true
};
user45.save();

var user46 := User{
  roles := {PREMIUM},
  name := "lmawer19",
  email := "lmawer19@live.com",
  password := ("123" as Secret).digest(),
  verified := true,
  newsletter := false
};
user46.save();

var user47 := User{
  name := "jzapata1a",
  email := "jzapata1a@yale.edu",
  password := ("123" as Secret).digest(),
  verified := true,
  newsletter := false
};
user47.save();

var user48 := User{
  name := "starbox1b",
  email := "starbox1b@yelp.com",
  password := ("123" as Secret).digest(),
  verified := true,
  newsletter := false
};
user48.save();

var user49 := User{
  name := "Chelsea Gambie",
  email := "cgambie1c@diigo.com",
  password := ("123" as Secret).digest(),
  verified := true,
  newsletter := true
};
user49.save();

var user50 := User{
  roles := {PREMIUM},
  name := "jtilby1d",
  email := "jtilby1d@angelfire.com",
  password := ("123" as Secret).digest(),
  verified := false,
  newsletter := false
};
user50.save();

var user51 := User{
  roles := {PREMIUM},
  name := "ilawranson1e",
  email := "ilawranson1e@gov.uk",
  password := ("123" as Secret).digest(),
  verified := false,
  newsletter := true
};
user51.save();

var user52 := User{
  name := "Christoper Luce",
  email := "cluce1f@ning.com",
  password := ("123" as Secret).digest(),
  verified := false,
  newsletter := true
};
user52.save();

var user53 := User{
  name := "Geraldine Bouchier",
  email := "gbouchier1g@nydailynews.com",
  password := ("123" as Secret).digest(),
  verified := false,
  newsletter := false
};
user53.save();

var user54 := User{
  roles := {PREMIUM},
  name := "mpetel1h",
  email := "mpetel1h@ed.gov",
  password := ("123" as Secret).digest(),
  verified := true,
  newsletter := false
};
user54.save();

var user55 := User{
  name := "ascrane1i",
  email := "ascrane1i@gizmodo.com",
  password := ("123" as Secret).digest(),
  verified := true,
  newsletter := true
};
user55.save();

var user56 := User{
  name := "Ewell Meach",
  email := "emeach1j@house.gov",
  password := ("123" as Secret).digest(),
  verified := false,
  newsletter := false
};
user56.save();

var user57 := User{
  name := "cferry1k",
  email := "cferry1k@businessweek.com",
  password := ("123" as Secret).digest(),
  verified := true,
  newsletter := false
};
user57.save();

var user58 := User{
  name := "Gardie Croce",
  email := "gcroce1l@java.com",
  password := ("123" as Secret).digest(),
  verified := false,
  newsletter := true
};
user58.save();

var user59 := User{
  name := "Chloris Maseres",
  email := "cmaseres1m@nifty.com",
  password := ("123" as Secret).digest(),
  verified := false,
  newsletter := true
};
user59.save();

var user60 := User{
  roles := {PREMIUM},
  name := "fwoodman1n",
  email := "fwoodman1n@google.de",
  password := ("123" as Secret).digest(),
  verified := false,
  newsletter := true
};
user60.save();

var user61 := User{
  name := "Win Arthur",
  email := "warthur1o@go.com",
  password := ("123" as Secret).digest(),
  verified := true,
  newsletter := true
};
user61.save();

var user62 := User{
  name := "bhemmingway1p",
  email := "bhemmingway1p@ca.gov",
  password := ("123" as Secret).digest(),
  verified := true,
  newsletter := true
};
user62.save();

var user63 := User{
  name := "Kimmi Slyme",
  email := "kslyme1q@topsy.com",
  password := ("123" as Secret).digest(),
  verified := true,
  newsletter := false
};
user63.save();

var user64 := User{
  name := "Blair Mackness",
  email := "bmackness1r@etsy.com",
  password := ("123" as Secret).digest(),
  verified := true,
  newsletter := true
};
user64.save();

var user65 := User{
  roles := {PREMIUM},
  name := "Kylen Seeger",
  email := "kseeger1s@slashdot.org",
  password := ("123" as Secret).digest(),
  verified := true,
  newsletter := false
};
user65.save();

var user66 := User{
  name := "cwalles1t",
  email := "cwalles1t@ca.gov",
  password := ("123" as Secret).digest(),
  verified := false,
  newsletter := true
};
user66.save();

var user67 := User{
  name := "Neddy Poulden",
  email := "npoulden1u@yellowpages.com",
  password := ("123" as Secret).digest(),
  verified := true,
  newsletter := true
};
user67.save();

var user68 := User{
  roles := {PREMIUM},
  name := "ejeenes1v",
  email := "ejeenes1v@google.ca",
  password := ("123" as Secret).digest(),
  verified := false,
  newsletter := false
};
user68.save();

var user69 := User{
  name := "mcolafate1w",
  email := "mcolafate1w@marriott.com",
  password := ("123" as Secret).digest(),
  verified := false,
  newsletter := false
};
user69.save();

var user70 := User{
  roles := {PREMIUM},
  name := "Whittaker Stanfield",
  email := "wstanfield1x@patch.com",
  password := ("123" as Secret).digest(),
  verified := true,
  newsletter := true
};
user70.save();

var user71 := User{
  name := "crothwell1y",
  email := "crothwell1y@shop-pro.jp",
  password := ("123" as Secret).digest(),
  verified := false,
  newsletter := true
};
user71.save();

var user72 := User{
  name := "mcheccuzzi1z",
  email := "mcheccuzzi1z@illinois.edu",
  password := ("123" as Secret).digest(),
  verified := false,
  newsletter := false
};
user72.save();

var user73 := User{
  name := "Lexi Wildman",
  email := "lwildman20@chron.com",
  password := ("123" as Secret).digest(),
  verified := true,
  newsletter := false
};
user73.save();

var user74 := User{
  name := "aryding21",
  email := "aryding21@ebay.com",
  password := ("123" as Secret).digest(),
  verified := false,
  newsletter := false
};
user74.save();

var user75 := User{
  roles := {PREMIUM},
  name := "Codi Galero",
  email := "cgalero22@naver.com",
  password := ("123" as Secret).digest(),
  verified := false,
  newsletter := true
};
user75.save();

var user76 := User{
  roles := {PREMIUM},
  name := "Jasmina Rubinsohn",
  email := "jrubinsohn23@cyberchimps.com",
  password := ("123" as Secret).digest(),
  verified := false,
  newsletter := false
};
user76.save();

var user77 := User{
  name := "Melisande Walsom",
  email := "mwalsom24@qq.com",
  password := ("123" as Secret).digest(),
  verified := true,
  newsletter := false
};
user77.save();

var user78 := User{
  roles := {PREMIUM},
  name := "Kristofer Benninger",
  email := "kbenninger25@aol.com",
  password := ("123" as Secret).digest(),
  verified := false,
  newsletter := true
};
user78.save();

var user79 := User{
  name := "mbimson26",
  email := "mbimson26@nydailynews.com",
  password := ("123" as Secret).digest(),
  verified := true,
  newsletter := false
};
user79.save();

var user80 := User{
  name := "Cirillo Giscken",
  email := "cgiscken27@imageshack.us",
  password := ("123" as Secret).digest(),
  verified := false,
  newsletter := true
};
user80.save();

var user81 := User{
  name := "Nevil Durbyn",
  email := "ndurbyn28@archive.org",
  password := ("123" as Secret).digest(),
  verified := false,
  newsletter := true
};
user81.save();

var user82 := User{
  roles := {PREMIUM},
  name := "Dewitt Milius",
  email := "dmilius29@woothemes.com",
  password := ("123" as Secret).digest(),
  verified := false,
  newsletter := false
};
user82.save();

var user83 := User{
  name := "hkleinpeltz2a",
  email := "hkleinpeltz2a@paginegialle.it",
  password := ("123" as Secret).digest(),
  verified := false,
  newsletter := true
};
user83.save();

var user84 := User{
  name := "emccaffrey2b",
  email := "emccaffrey2b@tuttocitta.it",
  password := ("123" as Secret).digest(),
  verified := false,
  newsletter := true
};
user84.save();

var user85 := User{
  roles := {PREMIUM},
  name := "aputt2c",
  email := "aputt2c@t.co",
  password := ("123" as Secret).digest(),
  verified := false,
  newsletter := false
};
user85.save();

var user86 := User{
  name := "Phebe Vigus",
  email := "pvigus2d@msu.edu",
  password := ("123" as Secret).digest(),
  verified := true,
  newsletter := true
};
user86.save();

var user87 := User{
  name := "nskamal2e",
  email := "nskamal2e@fc2.com",
  password := ("123" as Secret).digest(),
  verified := true,
  newsletter := false
};
user87.save();

var user88 := User{
  name := "Salim Teasey",
  email := "steasey2f@cbslocal.com",
  password := ("123" as Secret).digest(),
  verified := true,
  newsletter := true
};
user88.save();

var user89 := User{
  name := "thardson2g",
  email := "thardson2g@yolasite.com",
  password := ("123" as Secret).digest(),
  verified := true,
  newsletter := true
};
user89.save();

var user90 := User{
  roles := {PREMIUM},
  name := "fkiebes2h",
  email := "fkiebes2h@mlb.com",
  password := ("123" as Secret).digest(),
  verified := false,
  newsletter := true
};
user90.save();

var user91 := User{
  name := "Susanetta Huckabe",
  email := "shuckabe2i@ifeng.com",
  password := ("123" as Secret).digest(),
  verified := true,
  newsletter := true
};
user91.save();

var user92 := User{
  roles := {PREMIUM},
  name := "Garrek Izkovitz",
  email := "gizkovitz2j@illinois.edu",
  password := ("123" as Secret).digest(),
  verified := false,
  newsletter := true
};
user92.save();

var user93 := User{
  name := "gjupp2k",
  email := "gjupp2k@sourceforge.net",
  password := ("123" as Secret).digest(),
  verified := true,
  newsletter := false
};
user93.save();

var user94 := User{
  roles := {PREMIUM},
  name := "mstreak2l",
  email := "mstreak2l@amazon.co.uk",
  password := ("123" as Secret).digest(),
  verified := true,
  newsletter := true
};
user94.save();

var user95 := User{
  name := "Lenard Beldham",
  email := "lbeldham2m@businesswire.com",
  password := ("123" as Secret).digest(),
  verified := false,
  newsletter := false
};
user95.save();

var user96 := User{
  roles := {PREMIUM},
  name := "afeathersby2n",
  email := "afeathersby2n@google.fr",
  password := ("123" as Secret).digest(),
  verified := false,
  newsletter := false
};
user96.save();

var user97 := User{
  roles := {PREMIUM},
  name := "mbeams2o",
  email := "mbeams2o@prweb.com",
  password := ("123" as Secret).digest(),
  verified := false,
  newsletter := true
};
user97.save();

var user98 := User{
  name := "Antonio Lamond",
  email := "alamond2p@arstechnica.com",
  password := ("123" as Secret).digest(),
  verified := true,
  newsletter := true
};
user98.save();

var user99 := User{
  name := "vdeferrari2q",
  email := "vdeferrari2q@issuu.com",
  password := ("123" as Secret).digest(),
  verified := false,
  newsletter := false
};
user99.save();

var user100 := User{
  roles := {PREMIUM},
  name := "cfogel2r",
  email := "cfogel2r@zimbio.com",
  password := ("123" as Secret).digest(),
  verified := false,
  newsletter := false
};
user100.save();

}
