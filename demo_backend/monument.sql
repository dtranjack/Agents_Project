-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: db
-- Generation Time: Jul 20, 2023 at 12:26 PM
-- Server version: 11.0.2-MariaDB-1:11.0.2+maria~ubu2204
-- PHP Version: 8.1.20

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `monument`
--

-- --------------------------------------------------------

--
-- Table structure for table `continents`
--

CREATE TABLE `continents` (
  `id` int(11) NOT NULL,
  `name` varchar(13) DEFAULT NULL,
  `cover` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `continents`
--

INSERT INTO `continents` (`id`, `name`, `cover`) VALUES
(1, 'Asia', 'IMG/Continents/Asia.jpg'),
(2, 'Europe', 'IMG/Continents/Europe.jpg'),
(3, 'North America', 'IMG/Continents/NA.jpg'),
(4, 'South America', 'IMG/Continents/SA.jpg'),
(5, 'Africa', 'IMG/Continents/AFK.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `countries`
--

CREATE TABLE `countries` (
  `ID` int(11) NOT NULL,
  `name` varchar(8) DEFAULT NULL,
  `continent_ID` int(11) DEFAULT NULL,
  `cover` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `countries`
--

INSERT INTO `countries` (`ID`, `name`, `continent_ID`, `cover`) VALUES
(1, 'China', 1, ''),
(2, 'Jordan', 1, ''),
(3, 'India', 1, ''),
(4, 'Viet Nam', 1, ''),
(5, 'Brazil', 4, ''),
(6, 'Peru', 4, ''),
(7, 'Mexico', 3, ''),
(8, 'Italy', 2, ''),
(9, 'France', 2, ''),
(10, 'USA', 3, '');

-- --------------------------------------------------------

--
-- Table structure for table `gallery`
--

CREATE TABLE `gallery` (
  `ID` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `img_path` text DEFAULT NULL,
  `monu_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `gallery`
--

INSERT INTO `gallery` (`ID`, `name`, `img_path`, `monu_ID`) VALUES
(1, 'Petra', '[\"IMG/Petra/1.jpg\",\"IMG/Petra/2.jpg\",\"IMG/Petra/3.jpg\",\"IMG/Petra/4.jpg\",\"IMG/Petra/5.jpg\"]', 2),
(2, 'Great Wall of China', '[\"IMG/Greatwall_of_China/1.jpg\",\"IMG/Greatwall_of_China/2.jpg\",\"IMG/Greatwall_of_China/3.jpg\",\"IMG/Greatwall_of_China/4.jpg\",\"IMG/Greatwall_of_China/5.jpg\",\"IMG/Greatwall_of_China/6.jpg\"]', 1),
(3, 'Christ the Redeemer Statue', '[\"IMG/Christ_the_Redeemer_statue/1.jpg\",\"IMG/Christ_the_Redeemer_statue/2.jpg\",\"IMG/Christ_the_Redeemer_statue/3.jpg\",\"IMG/Christ_the_Redeemer_statue/4.jpg\",\"IMG/Christ_the_Redeemer_statue/5.jpg\",\"IMG/Christ_the_Redeemer_statue/6.jpg\"]', 3),
(4, 'Machu Picchu', '[\"IMG/Machu_Picchu/1.jpg\",\"IMG/Machu_Picchu/2.jpg\",\"IMG/Machu_Picchu/3.jpg\",\"IMG/Machu_Picchu/4.jpg\",\"IMG/Machu_Picchu/5.jpg\"]', 4),
(5, 'Chichen Itza', '[\"IMG/Chichen_Itza/1.jpg\",\"IMG/Chichen_Itza/2.jpg\",\"IMG/Chichen_Itza/3.jpg\",\"IMG/Chichen_Itza/4.jpg\",\"IMG/Chichen_Itza/5.jpg\",\"IMG/Chichen_Itza/6.jpg\",\"IMG/Chichen_Itza/7.jpg\",\"IMG/Chichen_Itza/8.jpg\"]', 5),
(6, 'Colosseum', '[\"IMG/Colosseum/1.jpg\",\"IMG/Colosseum/2.jpg\",\"IMG/Colosseum/3.jpg\",\"IMG/Colosseum/4.jpg\",\"IMG/Colosseum/5.jpg\",\"IMG/Colosseum/6.jpg\",\"IMG/Colosseum/7.jpg\",\"IMG/Colosseum/8.jpg\",\"IMG/Colosseum/9.jpg\",\"IMG/Colosseum/10.jpg\"]', 6),
(7, 'Taj Mahal', '[\"IMG/Taj_Mahal/1.jpg\",\"IMG/Taj_Mahal/2.jpg\",\"IMG/Taj_Mahal/3.jpg\",\"IMG/Taj_Mahal/4.jpg\",\"IMG/Taj_Mahal/5.jpg\",\"IMG/Taj_Mahal/6.jpg\",\"IMG/Taj_Mahal/7.jpg\",\"IMG/Taj_Mahal/8.jpg\"]', 7),
(8, 'Statue of Liberty', '[\"IMG/Statue_of_Liberty/1.jpg\",\"IMG/Statue_of_Liberty/2.jpg\",\"IMG/Statue_of_Liberty/3.jpg\",\"IMG/Statue_of_Liberty/4.jpg\",\"IMG/Statue_of_Liberty/5.jpg\",\"IMG/Statue_of_Liberty/6.jpg\",\"IMG/Statue_of_Liberty/7.jpg\"]', 8),
(9, 'Arc de Triomphe', '[\"IMG/Arc_de_Triomphe/1.jpg\",\"IMG/Arc_de_Triomphe/2.jpg\",\"IMG/Arc_de_Triomphe/3.jpg\",\"IMG/Arc_de_Triomphe/4.jpg\",\"IMG/Arc_de_Triomphe/5.jpg\",\"IMG/Arc_de_Triomphe/6.jpg\",\"IMG/Arc_de_Triomphe/7.jpg\",\"IMG/Arc_de_Triomphe/8.jpg\",\"IMG/Arc_de_Triomphe/9.jpg\"]', 9),
(10, 'Halong Bay', '[\"IMG/Halong_Bay/1.jpg\",\"IMG/Halong_Bay/2.jpg\",\"IMG/Halong_Bay/3.jpg\",\"IMG/Halong_Bay/4.jpg\",\"IMG/Halong_Bay/5.jpg\",\"IMG/Halong_Bay/6.jpg\",\"IMG/Halong_Bay/7.jpg\",\"IMG/Halong_Bay/8.jpg\",\"IMG/Halong_Bay/9.jpg\",\"IMG/Halong_Bay/10.jpg\",\"IMG/Halong_Bay/11.jpg\"]', 10),
(11, 'Ho Chi Minh Mausoleum', '[\"IMG/HCM_Mausoleum/1.jpg\",\"IMG/HCM_Mausoleum/2.jpg\",\"IMG/HCM_Mausoleum/3.jpg\",\"IMG/HCM_Mausoleum/4.jpg\",\"IMG/HCM_Mausoleum/5.jpg\",\"IMG/HCM_Mausoleum/6.jpg\",\"IMG/HCM_Mausoleum/7.jpg\"]', 11);

-- --------------------------------------------------------

--
-- Table structure for table `monuments`
--

CREATE TABLE `monuments` (
  `ID` int(11) NOT NULL,
  `name` varchar(26) DEFAULT NULL,
  `description` varchar(1740) DEFAULT NULL,
  `short_description` text DEFAULT NULL,
  `mini_background` varchar(255) DEFAULT NULL,
  `cover` varchar(255) DEFAULT NULL,
  `gallery_ID` int(11) DEFAULT NULL,
  `country_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `monuments`
--

INSERT INTO `monuments` (`ID`, `name`, `description`, `short_description`, `mini_background`, `cover`, `gallery_ID`, `country_ID`) VALUES
(1, 'Great Wall of China', 'The Great Wall of China is one of the most iconic and remarkable man-made structures in the world, encompassing a rich history and cultural significance. Stretching over 13,000 miles (21,196 kilometers) across northern China, it is an architectural marvel that has captivated people\'s imaginations for centuries. Construction of the Great Wall began in the 7th century BC and continued for centuries, with various dynasties contributing to its expansion and fortification. Initially built as a defensive barrier against invasions, the wall served as a protective boundary against nomadic tribes and later became a symbol of national unity. While sections of the wall have eroded or succumbed to the passage of time, significant portions still stand today, attracting millions of visitors who marvel at its grandeur and appreciate its historical significance.', 'Discover the grandeur of the Great Wall of China, an awe-inspiring architectural wonder stretching over 13,000 miles. Explore its rich history, formidable defensive structures, and breathtaking landscapes as you delve into one of the world\'s most iconic cultural landmarks.', 'IMG/Greatwall_of_China/mini_background.jpg', '/IMG/Greatwall_of_China/cover.jpg', 2, 1),
(2, 'Petra', 'Petra, an ancient city nestled in the rugged desert of modern-day Jordan, is a captivating archaeological site renowned for its extraordinary architecture and historical significance. Often referred to as the \"Rose City\" due to the color of its sandstone cliffs, Petra flourished as the capital of the Nabataean kingdom from the 4th century BC to the 1st century AD. This unique city was strategically located along trade routes, allowing it to thrive as a major trading hub for spices, silk, and incense. The most famous structure within Petra is the Al-Khazneh, or the Treasury, an intricate temple facade carved into the rock face. This breathtaking sight is just one example of the city\'s impressive rock-cut architecture, with its tombs, temples, and intricate water management systems showcasing the advanced engineering skills of the Nabataeans. Over time, Petra\'s prominence waned as trade routes shifted, and the city was eventually abandoned and lost to the Western world for centuries until its rediscovery in the early 19th century. Today, Petra stands as a UNESCO World Heritage site, attracting visitors from around the globe who are awe-inspired by its timeless beauty and intriguing historical legacy.', 'Embark on a virtual journey to the ancient city of Petra, a captivating UNESCO World Heritage site nestled in the Jordanian desert. Immerse yourself in the awe-inspiring rock-cut architecture, explore intricate temples and tombs, and unravel the mysteries of this remarkable Nabataean kingdom.', 'IMG/Petra/mini_background.jpg', '/IMG/Petra/cover.jpg', 1, 2),
(3, 'Christ the Redeemer Statue', 'The Christ the Redeemer Statue, an iconic symbol of Brazil and a marvel of religious artistry, stands tall atop the Corcovado mountain in Rio de Janeiro. This colossal statue, reaching a height of 98 feet (30 meters), depicts Jesus Christ with open arms, symbolizing peace and welcome. Designed by French sculptor Paul Landowski and built by Brazilian engineer Heitor da Silva Costa, the construction of the statue began in 1922 and was completed in 1931. The statue\'s location offers breathtaking panoramic views of Rio de Janeiro, including its famous beaches, lush mountains, and vibrant cityscape. Christ the Redeemer was intended to be a symbol of faith and a testament to Brazil\'s strong Catholic heritage. Over the years, it has become an iconic landmark and a UNESCO World Heritage site, attracting millions of visitors who are captivated by its grandeur and spiritual significance. The statue underwent several renovations and improvements to maintain its structural integrity and has been a source of inspiration and unity for people around the world. It has become an enduring symbol of Brazil\'s warm hospitality and the welcoming spirit of its people.', 'Experience the magnificence of the Christ the Redeemer Statue, an iconic symbol overlooking the vibrant city of Rio de Janeiro. Discover the statue\'s rich history, breathtaking views, and its role as a universal symbol of peace, unity, and faith in the heart of Brazil.', '/IMG/Christ_the_Redeemer_statue/mini_background.jpg', '/IMG/Christ_the_Redeemer_statue/cover.jpg', 3, 5),
(4, 'Machu Picchu', 'Perched high in the Andes Mountains of Peru, Machu Picchu is an awe-inspiring archaeological site that holds both mystery and allure. This ancient Inca city, built in the 15th century, remained hidden from the outside world until its rediscovery in 1911 by American explorer Hiram Bingham. The remote location and intricate stonework of Machu Picchu have puzzled researchers and historians, with its purpose and the reasons behind its abandonment remaining subjects of speculation. Believed to have served as a sacred and ceremonial center, Machu Picchu is characterized by its remarkable stone terraces, temples, and intricate urban planning that harmoniously blend with the surrounding natural landscape. The site\'s strategic positioning at an elevation of 7,970 feet (2,430 meters) offers breathtaking views of the Andean mountains and the lush green valleys below. Recognized as a UNESCO World Heritage site and one of the New Seven Wonders of the World, Machu Picchu attracts travelers from all corners of the globe who are captivated by its mystical aura and the architectural genius of the Inca civilization. The preservation efforts and ongoing research have provided valuable insights into the Inca culture and have made Machu Picchu a remarkable testament to the ancient achievements of human civilization.', 'Embark on a virtual exploration of Machu Picchu, the legendary ancient city nestled in the Andes Mountains. Uncover the secrets of the Inca civilization, marvel at the breathtaking mountain vistas, and immerse yourself in the mystical allure of this UNESCO World Heritage site.', '/IMG/Machu_Picchu/mini_background.jpg', '/IMG/Machu_Picchu/cover.jpg', 4, 6),
(5, 'Chichen Itza', 'Chichen Itza, located in the Yucatan Peninsula of Mexico, is a breathtaking archaeological site that offers a glimpse into the ancient Maya civilization. This UNESCO World Heritage site, which flourished from the 7th to the 13th century AD, stands as a testament to the advanced architectural and astronomical knowledge of the Maya people. The most famous structure in Chichen Itza is the iconic El Castillo, also known as the Temple of Kukulcan. This massive step pyramid, with its four sides and 365 steps, is a remarkable example of Mayan engineering and serves as a celestial calendar. During the spring and autumn equinoxes, the play of light and shadow creates an illusion of a descending serpent along the staircase, representing the feathered serpent deity. Apart from El Castillo, Chichen Itza is also home to other notable structures, such as the Temple of the Warriors, the Great Ball Court, and the Sacred Cenote. These architectural wonders, along with intricate carvings and sculptures, showcase the Mayan\'s profound religious beliefs, astronomical observations, and cultural practices. Chichen Itza remained an important pilgrimage site for centuries until its decline and eventual abandonment. Today, it attracts visitors from around the world who are fascinated by its historical significance, architectural splendor, and the mysteries that continue to surround this ancient Mayan metropolis.', 'Embark on a virtual expedition to Chichen Itza, an awe-inspiring archaeological site in Mexico. Uncover the mysteries of the ancient Maya civilization as you explore the iconic El Castillo pyramid, the sacred cenote, and the intricate Temple of the Warriors. Immerse yourself in the rich history, vibrant culture, and architectural wonders of this UNESCO World Heritage site, and discover why Chichen Itza continues to captivate visitors with its timeless beauty and profound cultural significance.', '/IMG/Chichen_Itza/mini_background.jpg', '/IMG/Chichen_Itza/cover.jpg', 5, 7),
(6, 'Colosseum', 'The Colosseum, an iconic symbol of ancient Rome, stands as a testament to the grandeur and engineering prowess of the Roman Empire. Constructed between 70 and 80 AD, this magnificent amphitheater was commissioned by Emperor Vespasian and completed by his son Titus. The Colosseum, originally known as the Flavian Amphitheater, was a marvel of Roman architecture, capable of accommodating up to 50,000 spectators who gathered to witness gladiatorial contests, animal hunts, and other spectacles of entertainment. With its elliptical shape, towering arches, and impressive system of seating, the Colosseum showcased the ingenuity and organizational skills of the ancient Romans. Made primarily of concrete and stone, the Colosseum\'s exterior facade featured a series of arches, columns, and intricate carvings, while the interior housed a labyrinth of chambers and tunnels for the gladiators, animals, and props. Throughout its history, the Colosseum witnessed countless events, but its significance extended beyond mere entertainment. It served as a symbol of imperial power and Roman society, showcasing the might and sophistication of the empire. Over the centuries, earthquakes, fires, and looting took their toll on the Colosseum, leaving it in a state of partial ruin. However, extensive restoration efforts have preserved its majesty, and today, it stands as a UNESCO World Heritage site and a beloved landmark that draws millions of visitors from around the world who marvel at its architectural grandeur and reflect upon its historical legacy.', 'Step into history with a virtual visit to the Colosseum, the awe-inspiring amphitheater that once hosted spectacular events in ancient Rome. Dive into its architectural splendor, learn about thrilling gladiatorial contests, and immerse yourself in the rich legacy of the Roman Empire.', '/IMG/Colosseum/mini_background.jpg', '/IMG/Colosseum/cover.jpg', 6, 8),
(7, 'Taj Mahal', 'The Taj Mahal, an exquisite masterpiece of Mughal architecture, is an enduring symbol of love and beauty located in Agra, India. Commissioned by Emperor Shah Jahan in the 17th century, the Taj Mahal was built as a mausoleum to honor his beloved wife, Mumtaz Mahal, who passed away during childbirth. This grand structure, constructed over a span of 22 years, combines Persian, Islamic, and Indian architectural elements to create a harmonious and breathtaking monument. The Taj Mahal is renowned for its flawless white marble exterior adorned with intricate carvings, inlaid semi-precious stones, and geometric patterns. The central dome, flanked by four minarets, stands as a pinnacle of architectural elegance. Inside the Taj Mahal, the cenotaphs of Shah Jahan and Mumtaz Mahal are placed in a serene chamber, while their actual graves rest in the lower level. The surrounding gardens, water channels, and reflecting pool add to the ethereal charm of the site, enhancing its allure as a romantic and peaceful sanctuary. The Taj Mahal has earned recognition as a UNESCO World Heritage site and attracts millions of visitors who come to marvel at its unparalleled beauty and pay homage to its timeless love story. It stands as a testament to the creativity, craftsmanship, and cultural legacy of the Mughal Empire, leaving a lasting imprint on the world\'s architectural and artistic heritage.', 'Indulge in the timeless beauty of the Taj Mahal, a mesmerizing monument of love in Agra, India. Explore the exquisite architecture, delve into the poignant love story behind its creation, and bask in the ethereal charm of this UNESCO World Heritage site.', '/IMG/Taj_Mahal/mini_background.jpg', '/IMG/Taj_Mahal/cover.jpg', 7, 3),
(8, 'Statue of Liberty', 'The Statue of Liberty, a universal symbol of freedom and democracy, stands proudly on Liberty Island in New York Harbor, United States. Designed by French sculptor Frédéric Auguste Bartholdi and dedicated on October 28, 1886, this colossal neoclassical statue was a gift from France to the United States. Standing at a height of 305 feet (93 meters), including the pedestal, the Statue of Liberty represents Libertas, the Roman goddess of freedom. The statue holds a torch in one hand, representing enlightenment, and a tablet in the other hand inscribed with the date of America\'s Declaration of Independence. The statue\'s crown bears seven spikes, symbolizing the seven continents and seas. A symbol of hope and welcome for immigrants arriving in America, the Statue of Liberty has come to embody the values of liberty, justice, and opportunity. Over the years, it has become an iconic landmark and an enduring symbol of the United States, attracting millions of visitors who are moved by its majestic presence and the ideals it represents. The Statue of Liberty was designated as a UNESCO World Heritage site in 1984, further cementing its global significance. As a beacon of freedom, the Statue of Liberty continues to inspire people around the world and serves as a reminder of the enduring human spirit and the pursuit of liberty and equality for all.', 'Experience the essence of freedom with a virtual encounter with the Statue of Liberty, an enduring symbol of hope and democracy in New York Harbor. Discover the history, significance, and architectural magnificence of Lady Liberty, and be inspired by the ideals she represents.', '/IMG/Statue_of_Liberty/mini_background.jpg', '/IMG/Statue_of_Liberty/cover.jpg', 8, 10),
(9, 'Arc de Triomphe', 'The Arc de Triomphe, a magnificent triumphal arch, stands at the western end of the Champs-Élysées in Paris, France. Commissioned by Napoleon Bonaparte in 1806 to honor the French army\'s victories, construction of the arch was completed in 1836. Designed by Jean Chalgrin, the Arc de Triomphe is an architectural masterpiece that blends Neoclassical and Empire styles. Standing at a height of 164 feet (50 meters) and adorned with intricate reliefs and sculptures, the monument exudes grandeur and significance. The arch serves as a memorial to fallen soldiers and bears the names of major battles and generals. The Tomb of the Unknown Soldier, added in 1920, further commemorates the sacrifice of those who fought for France. The Arc de Triomphe has witnessed significant historical events, including military parades, political gatherings, and moments of national celebration. It has become a symbol of national unity, resilience, and the enduring spirit of the French people. Ascending to the top of the arch offers panoramic views of Paris, showcasing its beauty and grand urban layout. The Arc de Triomphe holds a central place in French culture and attracts countless visitors who are captivated by its architectural splendor and the historical legacy it represents. It stands as a reminder of France\'s rich history, its triumphs, and its commitment to honoring those who have fought for the nation.', 'Uncover the grandeur of the Arc de Triomphe, an iconic monument standing proudly at the heart of Paris. Admire its neoclassical design, learn about its historical significance, and immerse yourself in the spirit of triumph and unity that defines this remarkable French landmark.', '/IMG/Arc_de_Triomphe/mini_background.jpg', '/IMG/Arc_de_Triomphe/cover.jpg', 9, 9),
(10, 'Halong Bay', 'Halong Bay, located in the Gulf of Tonkin, Vietnam, is a mesmerizing natural wonder that has captivated travelers from around the world. This UNESCO World Heritage site is renowned for its breathtaking scenery, featuring thousands of limestone karsts and islands rising dramatically from the emerald waters. Halong Bay, meaning \"Descending Dragon Bay,\" is steeped in myth and legend, with local folklore telling tales of dragons descending from the heavens to protect the region from invaders. The bay covers an expansive area, with over 1,600 limestone islets creating a surreal and otherworldly landscape. Towering cliffs, hidden caves, and secluded beaches add to the enchanting beauty of Halong Bay. The limestone formations have been shaped over millions of years by the forces of nature, resulting in unique and awe-inspiring geological formations. Visitors to Halong Bay can explore the bay on traditional Vietnamese junk boats, sailing through the maze-like waterways and marveling at the stunning vistas around every corner. Many of the islands are home to hidden caves and grottoes, such as the famous Hang Sung Sot (Surprising Cave), which reveals an incredible display of stalactites and stalagmites. The biodiversity in Halong Bay is also remarkable, with a rich array of marine life, including coral reefs, tropical fish, and even rare species like the Cat Ba langur. Halong Bay\'s pristine beauty and ecological significance have made it a popular destination for nature lovers, photographers, and adventure seekers alike. It stands as a testament to the power and beauty of nature and continues to inspire and awe all who have the privilege of visiting this extraordinary place.', 'Embark on a virtual voyage to the enchanting Halong Bay, a natural wonder nestled in the Gulf of Tonkin, Vietnam. Witness the mesmerizing beauty of limestone karsts, explore hidden caves, and immerse yourself in the tranquility of this UNESCO World Heritage site.', '/IMG/Halong_Bay/mini_background.jpg', '/IMG/Halong_Bay/cover.jpg', 10, 4),
(11, 'Ho Chi Minh Mausoleum', 'The Ho Chi Minh Mausoleum, located in Hanoi, Vietnam, is a solemn and revered monument dedicated to the country\'s beloved leader, Ho Chi Minh. Constructed after his death in 1969, the mausoleum serves as the final resting place for Ho Chi Minh, who played a pivotal role in Vietnam\'s struggle for independence and the founding of the Democratic Republic of Vietnam. Designed with simplicity and grandeur, the mausoleum is an imposing structure made of grey granite, featuring a large central hall that houses Ho Chi Minh\'s embalmed body. The mausoleum\'s exterior is adorned with elements of classical Vietnamese architecture, reflecting the cultural heritage of the nation. The interior is kept minimalistic, emphasizing respect and reverence for the revered leader. Surrounding the mausoleum is a beautifully landscaped area known as Ba Dinh Square, which serves as a gathering place for national celebrations and events. The Ho Chi Minh Mausoleum is not only a place of remembrance but also a symbol of the enduring legacy of Ho Chi Minh and the ideals he stood for, including independence, unity, and social justice. It is a site of pilgrimage for Vietnamese citizens and visitors from around the world who come to pay their respects and reflect upon the country\'s history. The Ho Chi Minh Mausoleum stands as a poignant reminder of Vietnam\'s struggle for independence and the profound impact of its visionary leader, leaving a lasting imprint on the nation\'s collective memory.', 'Pay tribute to a visionary leader with a virtual visit to the Ho Chi Minh Mausoleum in Hanoi, Vietnam. Discover the solemnity of this revered site, honor the legacy of Ho Chi Minh, and reflect upon the nation\'s struggle for independence and social justice.', '/IMG/HCM_Mausoleum/mini_background.jpg', '/IMG/HCM_Mausoleum/cover.jpg', 11, 4);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `continents`
--
ALTER TABLE `continents`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `countries`
--
ALTER TABLE `countries`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `continent_ID_FK` (`continent_ID`);

--
-- Indexes for table `gallery`
--
ALTER TABLE `gallery`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `monu_FK` (`monu_ID`);

--
-- Indexes for table `monuments`
--
ALTER TABLE `monuments`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `gallery_FK` (`gallery_ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `continents`
--
ALTER TABLE `continents`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `countries`
--
ALTER TABLE `countries`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `gallery`
--
ALTER TABLE `gallery`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `monuments`
--
ALTER TABLE `monuments`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `countries`
--
ALTER TABLE `countries`
  ADD CONSTRAINT `continent_ID_FK` FOREIGN KEY (`continent_ID`) REFERENCES `continents` (`id`);

--
-- Constraints for table `gallery`
--
ALTER TABLE `gallery`
  ADD CONSTRAINT `monu_FK` FOREIGN KEY (`monu_ID`) REFERENCES `monuments` (`ID`);

--
-- Constraints for table `monuments`
--
ALTER TABLE `monuments`
  ADD CONSTRAINT `gallery_FK` FOREIGN KEY (`gallery_ID`) REFERENCES `gallery` (`ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
