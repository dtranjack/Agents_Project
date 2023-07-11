BEGIN TRANSACTION;
DROP TABLE IF EXISTS "continents";
CREATE TABLE IF NOT EXISTS "continents" (
	"id"	INTEGER,
	"name"	TEXT NOT NULL,
	"still_background"	TEXT,
	PRIMARY KEY("id" AUTOINCREMENT)
);
DROP TABLE IF EXISTS "site_images";
CREATE TABLE IF NOT EXISTS "site_images" (
	"ID"	INTEGER,
	"name"	TEXT NOT NULL,
	"img_path"	TEXT,
	"monu_ID"	INTEGER,
	FOREIGN KEY("monu_ID") REFERENCES "monuments"("ID"),
	PRIMARY KEY("ID" AUTOINCREMENT)
);
DROP TABLE IF EXISTS "countries";
CREATE TABLE IF NOT EXISTS "countries" (
	"ID"	INTEGER,
	"name"	TEXT NOT NULL,
	"continent_ID"	INTEGER,
	"still_background"	TEXT,
	FOREIGN KEY("continent_ID") REFERENCES "continents"("id"),
	PRIMARY KEY("ID" AUTOINCREMENT)
);
DROP TABLE IF EXISTS "monuments";
CREATE TABLE IF NOT EXISTS "monuments" (
	"ID"	INTEGER,
	"name"	VARCHAR(50) NOT NULL,
	"description"	LONGTEXT NOT NULL,
	"cover"	SHORTTEXT,
	"gallery"	SHORTTEXT,
	"country_ID"	INTEGER,
	FOREIGN KEY("country_ID") REFERENCES "countries"("ID"),
	PRIMARY KEY("ID" AUTOINCREMENT)
);
INSERT INTO "continents" ("id","name","still_background") VALUES (1,'Asia',NULL),
 (2,'Europe',NULL),
 (3,'North America',NULL),
 (4,'South America',NULL),
 (5,'Africa',NULL);
INSERT INTO "countries" ("ID","name","continent_ID","still_background") VALUES (1,'China',1,NULL),
 (2,'Jordan',1,NULL),
 (3,'India',1,NULL),
 (4,'Viet Nam',1,NULL),
 (5,'Brazil',4,NULL),
 (6,'Peru',4,NULL),
 (7,'Mexico',3,NULL),
 (8,'Italy',2,NULL),
 (9,'France',2,NULL),
 (10,'USA',3,NULL);
INSERT INTO "monuments" ("ID","name","description","cover","gallery","country_ID") VALUES (1,'Great Wall of China','The Great Wall of China (traditional Chinese: 萬里長城; simplified Chinese: 万里长城; pinyin: Wànlǐ Chángchéng, literally "ten thousand li long wall") is a series of fortifications that were built across the historical northern borders of ancient Chinese states and Imperial China as protection against various nomadic groups from the Eurasian Steppe. Several walls were built from as early as the 7th century BC, with selective stretches later joined by Qin Shi Huang (220–206 BC), the first emperor of China. Little of the Qin wall remains.[5] Later on, many successive dynasties built and maintained multiple stretches of border walls. The best-known sections of the wall were built by the Ming dynasty (1368–1644).

Apart from defense, other purposes of the Great Wall have included border controls, allowing the imposition of duties on goods transported along the Silk Road, regulation or encouragement of trade and the control of immigration and emigration. Furthermore, the defensive characteristics of the Great Wall were enhanced by the construction of watchtowers, troop barracks, garrison stations, signaling capabilities through the means of smoke or fire, and the fact that the path of the Great Wall also served as a transportation corridor.

The frontier walls built by different dynasties have multiple courses. Collectively, they stretch from Liaodong in the east to Lop Lake in the west, from the present-day Sino–Russian border in the north to Tao River (Taohe) in the south; along an arc that roughly delineates the edge of the Mongolian steppe; spanning 21,196.18 km (13,170.70 mi) in total. Today, the defensive system of the Great Wall is generally recognized as one of the most impressive architectural feats in history.','thousand','li',1),
 (2,'Petra','',NULL,NULL,2),
 (3,'Christ the Redeemer Statue','',NULL,NULL,5),
 (4,'Machu Picchu','','','',6),
 (5,'Chichen Itza','',NULL,NULL,7),
 (6,'Colosseum','',NULL,NULL,8),
 (7,'Taj Mahal','',NULL,NULL,3),
 (8,'Statue of Liberty','',NULL,NULL,10),
 (9,'Arc de Triomphe','',NULL,NULL,9),
 (10,'Halong Bay','',NULL,NULL,4),
 (11,'Ho Chi Minh Mausoleum','',NULL,NULL,4);
COMMIT;
