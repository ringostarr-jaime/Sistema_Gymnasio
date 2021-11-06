SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

CREATE DATABASE IF NOT EXISTS `ventas` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `ventas`;

DROP TABLE IF EXISTS `clientes`;
CREATE TABLE `clientes` (
  `idclientes` int(11) NOT NULL COMMENT 'El idclientes se cruza con el campo id de la tabla imagenes para sacar la imagen blob',
  `nombres` varchar(150) DEFAULT NULL,
  `apellidos` varchar(150) DEFAULT NULL,
  `telefono` varchar(45) DEFAULT NULL,
  `fechaNacimiento` date DEFAULT NULL COMMENT 'la edad se muestra en java en base a restar el year actual con la fecha de nacimiento y si el mes es mayor al actual se resta 1',
  `correo` varchar(45) DEFAULT NULL,
  `estado` int(11) DEFAULT NULL COMMENT 'ESTADOS = 1 activo, 0 mora, 2 desactivado',
  `nota` varchar(150) DEFAULT NULL,
  `dui` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='ESTADOS = 1 activo, 0 mora, 2 desactivado\nEl idclientes se cruza con el campo id de la tabla imagenes para sacar la imagen blob';

INSERT INTO `clientes` (`idclientes`, `nombres`, `apellidos`, `telefono`, `fechaNacimiento`, `correo`, `estado`, `nota`, `dui`) VALUES
(162, 'CLIENTE-GENERICO', 'CLIENTE-GENERICO', '', '1989-12-05', '', 1, 'CLIENTE GENERICO SE UTILIZA CUANDO EL CLIENTE NO EXISTE Y SE REQUIERE HACER UNA VENTA', '000000000'),
(163, 'jaime ernesto REPORTE', 'rodas martinez', '7727-5486', '1989-12-05', 'correo77@hotmail.com', 1, 'TESTTTTT', '000000000'),
(164, 'jaime ernesto', 'rodas martinez', '8080-7749', '1993-02-11', 'correodeprueba@hotmail.com', 1, 'Cliente de prueba', '000000000');

DROP TABLE IF EXISTS `detallefactura`;
CREATE TABLE `detallefactura` (
  `codDetalle` int(11) NOT NULL,
  `codFactura` int(11) NOT NULL,
  `codProducto` int(11) NOT NULL,
  `codBarra` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `nombreProducto` varchar(75) COLLATE utf8_spanish_ci NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precioVenta` decimal(10,2) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `fechaInicio` date DEFAULT NULL,
  `fechaFinal` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

INSERT INTO `detallefactura` (`codDetalle`, `codFactura`, `codProducto`, `codBarra`, `nombreProducto`, `cantidad`, `precioVenta`, `total`, `fechaInicio`, `fechaFinal`) VALUES
(1, 1, 20, 'PESAS/SPINNIG', 'PESAS', 1, '25.00', '25.00', '2021-08-03', '2021-09-03'),
(2, 2, 20, 'PESAS/SPINNIG', 'PESAS', 1, '25.00', '25.00', '2021-08-26', '2021-09-30');
DROP TRIGGER IF EXISTS `trgActualizarStock`;
DELIMITER $$
CREATE TRIGGER `trgActualizarStock` BEFORE INSERT ON `detallefactura` FOR EACH ROW BEGIN
SET @stockAntiguo =(SELECT stockActual FROM producto WHERE codProducto=new.codProducto);
UPDATE	producto
SET stockActual=@stockAntiguo-new.cantidad where codProducto=new.codProducto;
end
$$
DELIMITER ;

DROP TABLE IF EXISTS `factura`;
CREATE TABLE `factura` (
  `codFactura` int(11) NOT NULL,
  `numeroFactura` int(11) NOT NULL,
  `idusuarios` int(11) NOT NULL,
  `idclientes` int(11) NOT NULL,
  `totalVenta` decimal(10,2) NOT NULL,
  `fechaRegistro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

INSERT INTO `factura` (`codFactura`, `numeroFactura`, `idusuarios`, `idclientes`, `totalVenta`, `fechaRegistro`) VALUES
(1, 1, 1, 163, '25.00', '2021-08-03 15:04:50'),
(2, 2, 1, 163, '25.00', '2021-08-26 20:39:39');

DROP TABLE IF EXISTS `imagen`;
CREATE TABLE `imagen` (
  `codigo` int(11) NOT NULL,
  `img` longblob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `imagenes`;
CREATE TABLE `imagenes` (
  `idimagenes` int(11) NOT NULL,
  `descripcion` varchar(150) DEFAULT NULL,
  `id` int(11) DEFAULT NULL,
  `imagen` longblob,
  `idmodulo` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `imagenes` (`idimagenes`, `descripcion`, `id`, `imagen`, `idmodulo`) VALUES
(1, 'jaime ernesto_rodas martinez', 164, 'ÿØÿà\0JFIF\0\0\0\0\0\0ÿí\0œPhotoshop 3.0\08BIM\0\0\0\0\0€g\0X-eNUt3Tbia8Mn_Va1F5(\0bFBMD01000ac0030000ea070000041000003b110000aa120000d01b0000782600004c270000a0280000ff290000003a0000ÿâICC_PROFILE\0\0\0lcms\0\0mntrRGB XYZ Ü\0\0\0\0)\09acspAPPL\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0öÖ\0\0\0\0\0Ó-lcms\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\ndesc\0\0\0ü\0\0\0^cprt\0\0\\\0\0\0wtpt\0\0h\0\0\0bkpt\0\0|\0\0\0rXYZ\0\0\0\0\0gXYZ\0\0¤\0\0\0bXYZ\0\0¸\0\0\0rTRC\0\0Ì\0\0\0@gTRC\0\0Ì\0\0\0@bTRC\0\0Ì\0\0\0@desc\0\0\0\0\0\0\0c2\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0text\0\0\0\0FB\0\0XYZ \0\0\0\0\0\0öÖ\0\0\0\0\0Ó-XYZ \0\0\0\0\0\0\0\03\0\0¤XYZ \0\0\0\0\0\0o¢\0\08õ\0\0XYZ \0\0\0\0\0\0b™\0\0·…\0\0ÚXYZ \0\0\0\0\0\0$ \0\0„\0\0¶Ïcurv\0\0\0\0\0\0\0\Z\0\0\0ËÉc’kö?Q4!ñ)2;’FQw]íkpz‰±š|¬i¿}ÓÃé0ÿÿÿÛ\0C\0\n\n\n		\n\Z%\Z# , #&\')*)-0-(0%()(ÿÛ\0C\n\n\n\n(\Z\Z((((((((((((((((((((((((((((((((((((((((((((((((((ÿÂ\0\0Â\0\"\0ÿÄ\0\0\0\0\0\0\0\0\0\0\0\0\0\0ÿÄ\0\0\0\0\0\0\0\0\0\0\0\0\0\0ÿÄ\0\0\0\0\0\0\0\0\0\0\0\0\0\0ÿÚ\0\0\0\0\0ÀHÒ—‘H¦st<ĞŒ¶Wó\Zh¸È£vétjŞsÇ–C9›R4n©CU¼KºÓóTUÛ6®6|¦•Í\0´–˜9tAš%lHõ#.lµs¾“Ím1,c£ĞÌº¨lH\Z²Q“d½á2<ÎHFÛ‰­íTPó®óç¾6Ÿ”O¦Æ:cA!šÀb\"8©®zñ™H»TrÍv±IWöKÙs“a›®ĞUïÔe_£—Ş;å2¹k‹ûWwèş7ªáè—ãt<r¹LÇ*¬aé”ÅiñÓBÆ€kåì2$A3\nŒJØŞd¸X:L‚È÷f/¯¬Ìéf¹M%rrÂô8~BÈ¢ããk²ZÓDIôÿ\0+>ÓŞæ0ÃFiÙ\r>M¡Éìêu phlaÓœOÅ’ùÂ©ÚS8Ü+f]HäRİš´r&LàöƒÙp LĞ¦g\rÅ@MŠÌ¾WDÀë‘zeòä~ßÕ™²ŒR89]Æ_)ô¤Î(,ûe²B×jrSSé´çA“Şà=Ğ#ÖºŸYqqˆ··£Ul{ÜGD\'šÒR;jØyã¹W\\RBTæ€)Eá«{çMbÚ±sÕtôòÈ?*âs;)¶eTßôº·\0ø‘aç~ÏJaw°`Y|”ó²Eî¬¡š‰{iú/XS`\\¶reNÁ“u“ôª\r=5—_M|»ˆ\0[NÍ?’\Z@Åa§é”Ó¡*OVBeœóÂË=TûM„ÔZnfCSj³uÂSñ¯>·¬ñ¢Â»©úş§vÊçfr+P%0íä[õ_>a›+m44„İÊuäÕtEŠğîu§\n ¾xh×CR•Rn¶ªÑ;iêß\nƒ ©ŠOPŸÜöÎ¹¦‰ü])°@äIÎ¾.ª®FÜ*wbÄĞª7>zwWR­Îb}4M*ë8Ôsù³V¸ç›\ZÇµ–»Î·_Ú¬/ôû\0·Tğ¦’Âğb­jĞ}I·’*©ù–ÁZ“ReŞµß\" J$ôg-1®W„Îo›Ë¼à_f<ÈıF¸böŸf(û¡œ{Ëqûï<÷ò[:> `bgÜßKÔ+–ŒJM[…ï\'†’º —5Z­Ñú=¦5:ô¾ŸêtfåÂ\r¦u\0ı²9Ï\'€ùŞseˆ}\"Á?¤¼û½aåØÍd}~Âı C¾=Òf¤Íè”`ç\Zl›yÉ*w%b.•tY‰Â´¶ªÁs°ØyW­y‚ãÕ—â7=9Œ‡.×:\"US0û‘œ«ëıÉ²ı÷~#Éî¦ı•_•ÕewF¿¾ûTÎä¢IBàg	™B•7½ŠöVúÇ“úÆ\r03<]FÊ29ş¶«l¥ó¼ô3Ó]•ùµçß|[ëjµ‡~ûê¯ÿÄ\0,\0\0\0\0\0\0!\"1#2$34A 0BÿÚ\0\0\0	cø—S‹ÕÄƒ2AÑ‘\'ÜÙ\"ågeÓÎîd«ÁŸ¼ˆƒ·È­Xˆë¿[\r¸×òœß:yåÊ!RS9Ë7œ²£)„²DC†ÌÊxé12Š¨‰Ë½#˜ôÈŠ\'»8À.x»V	ú’ ëZ¨3[öÂáç^Ö¤8ÅÜ@‘»RJ…¨l0$^ÛmßhŞ~^İ²S“?hÉd=->6«_ø«×î­%RÅ•PßPD`TˆÆ*XÖVãC¦û¡™_VH®íHÚ³0ÙöcqÍ$!0Ö8¤ ÉŠæÌ.®H–õ9&}>p£“Èb%®¼òUVH %H¯ıqYZvV˜ş‘•Ä:€¿‹7AsbÉ›ú“38Í¤F½ƒÅÔxÂª¹Æí-Ñ–›2¸œÚ;8xğ9÷Œ¯ù­ĞSóŸå“•¸˜S‹2Ş«øš¿ükÇíëÿ\0a^9Ä¤²·õo5È¬0f3Ç§²9Vì Ö¸¹V•qª—2vÕiùJkÄ‚kLY[—*ôi­¯»û\\9ÅJVè˜’˜Ç/¤`ÏjzlöK”(KGÜ[‰ÈNÎôæe\n\\Z›:Uweúî®Øœ™‰Ïö\'¾©2¥Dk&Ç–ûº Ö“	ÕcgiĞ&$lØĞW-Ídñn’–eİ<êO.åñÇ|ÛËoì{xŸŠ!¸3tyv‚\rù8Îm#U´¬E´ê)ÔtÓ¯©î	ñqÌrtñHÏoóT±¦—İùÈ´ÊÎ=e\\kjÕß:¯t|dNäéãŠ&O)¦í;æìrŠİƒTü]òQç·já_ÙšX9B«‰·éıµ×\'åŠ$â£eânØHºÓ[0q\"ãsÎµrá;Nñ§­ù«ÔpÓ™˜¢à¨¤³M«v¡Y\n?M.?|ßšì8<›BN	Î¿\"İvB©\0¬”Ìöà=Hú4T¹c~–ÈÏ¦;>’ÙÄékŠUöö©Œè.F|f\"L0\n®ÄdX\"Ë–:TÆ¢zõxˆ§ƒó¥{“ÜQ0Xí²†9Œg1’U™¤šk\\À/rœ\0ï¬¦ZªS*u¾á2! œ”góãI7ÚæºÊ£&K‘`çû°íECîrêzÉ’.ÚVÂ2ºÑ&‚Œ5÷ŠÃí†sÛÉ™¬n›Ì`>ÿ\0‘j\néÙ[$f½÷¤¾ıŒ¿3á;­ĞöH”å®C\'¹.™í¦Êºü\0{\r\r\"Å¼F—] U,©Íá%g\'İpéY,éó=0g2Æ®p\\c‰l–W8Â»]qçj1eˆ,°MÜPl˜¡0aÑ±¹d,0=0••¿áW‚gÇU¶ÕR:ıN¾àáÛİeëïµŞA[çmÈçuŸQs’¤U‚‘ãcƒ¸˜ùˆ)Õ­uwJtñ™Á3Î†ø¡†BåÕğLùIå=?h°øHZ²M7eg}e©„]¾BË&{î9¼ÀLvàÉˆå9%<`m<cxÍ!Ş¾™!ƒ¶ÛçâØBËbMsd¢ªÑ±´\\µ,–ièìš½jßuS‡\0À–Ä¹ˆùÏ.F<…cÌB8ÈDAo;Lqî®;.œ¼¼`b™ä¼	äNªL\nõ ’:rÛüI›Ë;à„õ²ê—ƒ­‘\"Ï,0lîsœd€ÆvÜü‚b #nèï?¶8áï³6$íÒ¹@ë<¤C5âp9ÛáòãÜ’ˆöÊ(çÜŸ2•ÀŒì°åƒƒˆ\" •—Ü‰Ì2¸2|L]CÆsœam!·%¯Ê°p™…—%ÀLV‚\Z6úƒ‡bov–À™ÖI2[A¨`*D©¹ki˜ºGn’ÃŠÉ‘´ùË´ÈLBÓ/–Uzª²½–×%Xö”T5-F§KWm©¤m_O¹dné­¤·é—áIÓ5+8tÍDGH®«GWOµnX‹´qzMa7×*7ì”téOŞQí•]É:Ê°mÕ¶B¸‘L·xåœÊsrÛÆÌS-=imMOÓlê£õôQ¥È–°H7~¦ ¹„JÁh&èšá½—?VÜzYíJÔV1®¾¾«õ¯ÓÜ½î‘\\ş‘®¤Ù ~†\rt¼aq”éÖğ×)ÈÚVquœ\'Õ°1m-]=¼KmÄ¶ÈŞAÇä¯ÈZUì}urÍ.í:¥aåiğÍ¬uö9”uºWÖuEÙ¦â&¾µÓëX°±A™†\"­ø”i\Z„­:¨+é”‘9aKvtR¸™¢{Bæd¶­3ôşYË7ì¶H!\ZcÚ,«`r½4o&ÅiÚg<·Çç6ÃBšV+ı<öM5fÀ@ç–m›z[†˜(\ZáÀš‡#ÒøsĞıbsMWº±´6ÆĞÖp³NÅ!Õj•‚fŸ\nHÌo¾rÛ4ÔÅ›\n>301›FNLúï›úqÍ¿àYÎŠò¢ÿ\0}4öÂsŞF­ä-O(¹#y_q¸ªí°átÆ4Ç»™ûÁ;`–Aúm›äˆı»C–X¯á1·¦óœ‹#œÏ˜±Y#q»›}ÁôÕ„ˆÉYFQl¢ÜÇ ßr2\'iƒï¾m›dúï›ú×ş·øÿ\0á,ÿ\0gŸı#øl~?è|ÈüàÏ”ÿ\0\0|Ìdä`d|O¤ÿ\0ÀügÿÄ\0\"\0\0\0\0\0\0\0\01! AQÿÚ\0?BÇgó“Ä£¨Ç“=Hq­Å*×éo¡Ê‰Ë‘BørcvV£,–¬½ÙÙ[´66Bw®4O÷L¦Æš&ş•¯X§Ò]şáÖ§Ğ±ò?”õqQÈô2Cü¨Ø¥DrVtsd¤ËÔdĞİ­8‘Åj+LÂ“d|xögÀ¸ü*‰ãÚè¢R#3Ù¥óiÓ0K”Itg…KvEZ\ZH“×zl‹F?)ÀÇæFkéåM‹CdrĞóYvqÍ\"Çø	Kê3c‘ZâÊbB”p]œ#´¬XQëhñºS3Á„£G\"õG1²ÉGæ¢èö‹5Ø‘òxÌ!“™8¦Jğú„õ[]ü-3ÇÜºÒÓ×ÿÄ\0\'\0\0\0\0\0\0\0\0! 12\"QaAÿÚ\0?ls£Ê)Ï!ÜƒìW“ÿ\0ƒ·Æ?nEhI‰	QÕJ#áÈnÊ1+GQğÊ\Z;r¢äJ%‰’ÑhÔˆè¾(l²\\]	¦bûñö\'¢£*\Z?Ñ‡Ã$lÆöO/MŸ¹ÔùÌÉ4×=•Q¡pÊ:’ÄÙ,m\n,®Ëcô¨XR&©½ĞÙzÎï…Ì™bâŒ±Ñdd7b‘…¼.Z%Ä†OàñvgJ(Šı—ìq±Âˆñ(Ù4<vK\"Bt.ıİ…ÏxhfOQº¬­Qùá“Ö5¤~dŒ[‰Ct<¢Êw›ÔøÍyt‡Øø±Í²¶QŞ9QŠkCVx‰agŠhJŠ=|+gòOF<­}…×\'Á<n%‰ñFo¹é¾¾Æ>?Pú®p}‰üäBãÿÄ\07\0\0\0\0\0\0!1A\"Qa2q #Rb‘0B¡3r@cs±ÑñÿÚ\0\0\0?kê¸“³WL±Š\\ãü ]¡XrÉ?Ê\09Ùò‹It*$©—Bér¶×J0•u˜Q\r‘²şÏáIkß\nêOu\Z‘£²\nüÙåd•î!{—¹C]§-y\\\n‘×D‰\'D~P¨õQ½ª‹d9S,ÙMÁ88u*3ú•V³3”ÀıSÀU©’%7Šö¶O•J&àì®\"›_{bæ•R¯ı.Mc5*Ú~èÊô8oö;ô”ZíBˆå°FÜòiòœ<«İ\n{>S³”5Ê¥ğ¸¡ûAş”EB06Z Ö	=Ğ»©ËÔ!·#sm¨‚œ+\\!5­ĞšÌ‘Ÿ^‰°¸snZë]ğ«Æ\"G#Å?q	änVv@ÏSp~\nÉ+T[· ¾éóáÂ´kd2ÄÆª_\n«{Òw*²NB.$»Â»m…m1.Ü©q?e¹v™G ØZ­¥sš¡Í*Ï•.¥ü&±¸×”\Ztİ=®ÂóÍÎÚ-¹:«Uî)¾®‰¶è„ª	€îNobŠ2™åwİ|”é0QÊÿ\0Úé2Uó‡yVSï’€\Zí!¬>åÕQßeÒIPÍBÈÍÚ«\\:F¥9„6í\r˜½ÍpA£(ä©ú–”-Ê¥/\Z*6:Mà*Íıå:v_diFB¤ÓàH+¦›XáÙ~hÇ /L48\\©³Òã²œ×{HB[8B)50O»a(Š}ğ©ÓÉQé7:UÓÓÈ¡©ºª,xû¾Qü9>àã*¥şë¥Wÿ\0`Tí&8lª=¤‚İÆË©÷)Áã#Q¨Ã4¾šg³‡\'»ÂoÂ	‡±Qß“Ë>†aY–(îü£•ÇEáRyQpÏJ«~ëWh	)#\n«ëj×Ü¢Û	ƒ²ÅÌÎª¥OUÎweÒ>|+Úò|GÑÒ<©ªî‘˜Ùñ÷@öröªou[/ËššşKm¶\Zƒ}Ï”ë¸­¶Œ\'\Z˜c7AÔÜââU£NLŞ¬¦ÁÂÙ:Â²£ƒ¬Ó	ı>zp¡´¤”ßÄQ×ü\"ê”y:›`^…eÆS5%[êá{Ø³Qˆúµn^â·NkFHQ¸*›‡e×HÔiÄ\r•´½F»Ê\0ê˜°êˆ¢ëêTÑ¿¥XL¸åÈGêXS¼~L!àJêªÔf§øX©Vÿ\0r¥¶y*öXæî\0\'·2éM·V ıİ<&ú¶\Z«+…‚\nö,Ï\'¸ôS×¦Û±¹O&°eKÜ×EÇdjTÁœr·¶y—ú@ä×]{ÓeÒÒ`¨É^Ò´PÜÏ1P{^±…¬ÈšŒpÉÎ¡G¤nå×Ä½P/âk;Â.¥-hÂ–Õ}ß*ÊÀNÅ\nÓGÇR&#!d*©¿te>;\"ØÔ ç~U.å[Lºîë=I¡´¥bFZßáHªNWæ×‘à®ò£Ê%‡\Z-Vj——ŞîÁ6pÆh¼ò-î1)ñíW7+÷vSç”88 ıFP×\0ÈFB³w+{r¨ßkv*L:¦îrƒU0‡`¢ÊŸÂ’¸fçº¶9ıÅ\ZxFßîšïå;LÕ+U¢\ZŒ«€Ğ­ ¤õŒ‚¥ßé¼/îc»¦Bº™êQQÉöM®Á	Â§¸atºæŒÂ½Çáhd•¨Ğ,FN*-Ô…!Š—Â,×)+D3¨„ßÚœÏºlLdGÒ#«¾ëü„AºßrÁ¨ì¥¥g¨Ñƒ‡(Ôl…¬R}ãu7(^Cá13óğ\\A®ñ·d\'¿øOÆ™NŒËu)ıI‡q„ë¢æ§Æ‡<±Ì·Ì«]²éŒh®¥6bJ¥.YV´\\U¤) õ»r!aa\0WÙ7*›@.—®?òˆŸş¦™×U2tÑ™–•Pcg)$)¯`Ì;î;sÕ5ÃdH]ñ+ç(~ ©|+{«sºioo¤§Hê\"WRœxVĞhwò;.Ëì¤û¡g3™ì±Tc@¥Ñ\Za4ë²g‡ANiÑÈÚùY‘áuL\'l/pMaÙFéÎr->Õ!wäâ€@^Ö¢*³§õ7^½F]éˆµ^F¨|  NJJÀCÊêÈS±×«HŠ/ ƒ(ñ\"ô}×!Ä¾‘ôvtê¸jUDµÇ)Ü7EÎ‚\Zõxs`ì¼/S‡¥4ç˜L5*³ñL\nA>ş\ZÑ$Ê)P6Ÿ0…:ô+l¨xbGù\\O¯B­Kb-Ù;ğÔ‰\0êPmvß†•*<GUÜMQ\"Ó„şî¾‚œ9õ‹‡”YJŸæ÷ì¬h.ÍÆE\'ÇÂ—Ù6@k)ó„$hB•ÕPÀ\n‡ø‡Ö«‚i5ºÆğÔƒl®€oö6ç.·¹•ÄYUÔ­¤Ùµq-ô«´™ÿ\0UÓr}:‡0Á\\+×¿\0şI…Á\Zœ3©SkÀ™•J\'ÚÊŒê„“Åq\Z{hjà*ÕoåÁlşí“ßÃ¾(íµÄıB×:D–èªÕ5+¹qŠ4Œn„Sp,‡¸É‰âxz,{†ïn«VuÕ©E¥·;,RİØCÕªÙ;30­»ü&–pÍoûòƒœZÖš!~M¡¿\n™¼z_tWÂ)ØåKˆg¹§\r;¯Z—ámÄ£ÄW§Xñ’tÑ;Š­2ã\0v\ZeÌ3‚Ò½O^§©ú®Ê¿ñ5¯ïr~¥äÉÕ\Zo<]Á¥,*\\?*ô™½ú©«QõH“¢üEK×&6­j¯:/I•øŒí;\"Ê|MQŞïL§ñéü¢Úœ[™MÚ‹¥7‹¬\Zu\r1(YFHİË¥€}õ[0¤S¦>Ê  Ğ„íË„Û?GY…u6ËTÖ¤ş‘Œ+úXØÄ¦2¨!dë”Ÿ«ò©¸…5Úa\Z…åa«¥£–~‚\Z\n¶¸-\rì¡Œ yR³ÉŸ¶ÒÆ8ô”\Z0Ñ²¾\0Hİ\Z5]©×²ôÜÒîÄ›íÕ\Z«]n¡akÈ‡{\Z$…`Ò?äLè[¿Ğ;óÛU!¡t•m®>ãİT¾¢Ö¼ÏÔÔ\'B9cúÌøäâ>O#áx^È^Ôñánº_Éµ;)\Zjş½/Nú?*¯ÊÇ/º<¨ÿ\0±7úÿ\0ÿÄ\0&\0\0\0\0\0\0\0!1AQaq‘¡±ğÁÑñáÿÚ\0\0\0?!DC™™«k9¨Ü,•¡¸4,¾™WFÈi£NjF2* µdT´óÕ*HÏÄd¶T2çJ\"‹×}\"Şª*2ä±{Û’dÇj•>¦_ä@½{®ï5­RåÍA²İ Šç0Š+Ş [£æá¹w,5qÜ³wŒ}Á—ÕqÉ)=3‰FÉD,¹C¥šXP5@¾%Ç\nQP¦–ÙOdÚ“Ş©ÀÊ\"¾¬¨KQ4D¯ı”nîmî[ á3-êÎ&¢±†I¿ôBƒ$\r6jç\ZÍ\\Å)ŒMXÔB†2—¨`Şb–ò¡š5Fsfjâ\"Œ…Fo\"âQo¥d_í„2Ë+°T²ç]Ê¤¦ï¹n>§ÖêS8ìõ*è.!3>£}-¶qşS0“—·\r©`aÉx$ıá“ÌŞõÊ`J›ô—sÄÂ¿›6ÉöÆÊš[2á‚U3’ráÑ­a)«B+”AvÓ˜$fŒöĞ¾ŒÅ?äÄ¡@ªÁö”¯ødå$¹0LûzŠlÖ(.§Rw„ÂJÆ¡=u©gVN¥Îs‰…Tw\0»á\n¬. 7Ûõ•f™êX¶j>mCdÀ {ƒBß¤Ê4q\\DUyƒñ;†!hÙ(°ì3	uw¥~\'õ\0•>À!¶\"fº•O¢MD0zJCŸ&X…F×¹_\0û‰2îv	ªÊ>Şõ.]ğ–²9gß¤>6š–ÅzB²„6„0³’ØÏ_ê:dK‰Œ690ßr‚?IĞ¬TÌJ2¦°GHáçˆV®à»¿(•q÷4İ÷å±0·x0¢{b/[©ºÑH¡(œpbíÕ‘e†PZNfa	‹Œ ˆ¼®àÿ\0j²¶iÌ üx¡­!>\0~ğI\\–lÔ°Eø½ğ±4ÑJ ¡âf3¶#˜/I…€§SGœÇ¤k9šh¹¸ˆpx˜mr¿PÀ\r3\nÚaäã¥ˆÜº`¹ûD6V÷’iŒ\Zbü±[´:şã\Z¾¡ñ.ê\rSÕÌöòQÑra¡†	ÀmˆB¶âJõÂX8Ğ\ZŠÂ’åœeŸg4˜„7Êu%*bP‹aoeˆÍ‹$|‹÷/fÅ5h©Õ¼Ñbàf€-)ĞOºğê3õUq\r’£ÜLM+Û‚ê|\"aP€h™%`¤¤vm69†.r¼@kc‘U,\0;.åŒÃ´;œÊA©ü‚ ÛL_8Š”ğº§$±AL´~¡1¨)E©‰&7K2ùçTY°šODVkÉÂeUÔ[™CÒA\reš—áx‚däAPm(8bó²dVüËÛÜÀ•‰@¡x,uŠ,êL¾q.@CÙ^´`¦`´,=¦Såm6ØY\\ÊD6\Z‰,À•b²ıÍ½Æ!Åå„ıD»3Y¸ƒ¢£šSá¹Ÿ¹›ùi\0ãrÉf§¨„n@ì«]¡;iiÌE\"¯¦ #7aÕÊÙü nf®qª`×¸x ÷ˆÂø#>x ®2†u¼Ç!”‰›o<ÜX-o¨ş¤º±¤[%–Ä[X0T½F¥¯Ÿ‚#;nq/å†z¸İS\nË• \rä¸øÂ¥÷2·¤¼í£]+¥/×–Ì«¬Ö¨{-¨‡°tÎâ—Å›·©ZeH]$óÅBU\r=õ00Âì,ÙM]¸¹‰Mì/—¦ï1@²ÍŒÅè7şoÚC)NE:Ù.¯-qV¸æLp–v¡Íjã•£¸ŒMHq’œÑÈºƒm‚í—n»¾ÂÄK®b2ÚnBvq-FõDê˜ºÔË¾áˆå¿.FeÂ´AV\r‘&8XN·Â@1#Úá:”iÂËÉUqğ…‹AÜÄºZC0SSVZ!P’ºM-O¨‘XòŒê±c¹Ä#‹‰Œ±iUÌ—›7i \r0à,í2Ua~¢‰9¥Ôhà˜û˜$±oÌx(ê\nÄ;¨â\ZV˜öù…•m‡6mØêhSÁn»f—~%3âRNDÀH«1òR9jù3	¶•˜ïjY^&‡:Şcæªbaıû†$*aYç™äƒ^\'DâƒÖ±Ì©\\=é\"%|È”¥\"ÌšÔ´ñ3*ÛRËb†÷*[l«ìÀ¦ÎTM\\»`áÚ]™uGÜS72²Œå¶[°E©Ê’Æ¤1@˜5kâ3V†Õ\r/1ÚTÂû¡tÜ]û Xhf¦TÏÊhu¼ÎPéâQ¹üĞĞ†[edZk1°ÉİÄ¶DÛÄº¨ÌÔ,¨:ôN<q)<Û™ä@3¨á$jğve@¦ç\"6 ¸J¨ûªÚ<¢pn)Üb —™dW9‹(4@6,ë+¤ê˜px–©UBff<7Ä´àÁhÑÅ–§ÔÆ9ğ©šw–³9:•³t¿,WxÄ™F¢Æıõ,Bºx™‚5[„€s‰	@k4.¢¼8sÆBÙš[bû‚äOı®¶Ì•s#5ê$Pq\Z€®š¯¦\Z8>t€D-á—O1´ÍäœêJ©jI´†.ÍQ9¬È7{¸‹ó,Š½xœ0‚Y¸*w›¸Ä¬&q\rhe$S¦UıÀŒ_½³Ä»\r­\'æ—,l [Ô½IM›“˜òš\\Ò-*¥äk÷ zäøz…1:è„´#jeñE~Ø˜–\Z‹Ø¸\nœƒ`ŒùˆÍqÄ¬ÛE§HDïÔI´2˜zŒi kÌ¹^PgW¿…ÛJ\\Ğ«rš>ËL¨\ZÎ%&æbÑáY\rßQlœ<!kxA‡£–\\µŠÍ†6qTÑ:\rŞe³lçà”`8.&ĞMŸÁuµ?ÜÈ‹—ÁRßš3ğÙê\Z@·^n=,•Dr§“5hxbóÙµ‚õS%tê§\\ØäÓ©†A:n\r¼PhŞbW$b\";¶‰ ÉìŒm)u‰ïl·„Qµzó6nÖğ380ğ—êÂ»\"4Ö’¡³Ré¼#¦ÊÅµœıOÇâb˜|TŒ\rµî¹õŒ&â	‘µ\"AC{º=}æ›ÁÄrhÖ)Äšéy˜g\"»öàõšöî:5j²¢@!÷uwQœ£G^qúü@8y\'à’Ö\\vÏQŠ1$_\\B	´>”à}Oê[<Ê7ˆqEGqÃ@.ÈÉ¥ÅÁ1X… Òf­” U™£;\n•tÀuŞã³G1-»#eZ…¶±\r^übB.®áÖ|Ui…ÅèŸighHc2õˆ\rOˆ/\\¥Ck,[|9+†`+˜¥Ÿ-¼Li¶Ú4BØBô×ƒÆÃ”*ôœ¨°9Õš¦\\ñ‚¨	hÜüì‘GjÙS¸p(â]Ëe™å>âaF>+¨¼ª%\0i\'pêlfYçîP%cÌÓÚ(C9©˜s÷0‹$9KMê>ê¤´Ïá2²—+_ÔR–­Ë€õ¨»pGQ¼\\l–Íü[0œü]o0d¸ Q@•jş\0_æ^iÆ_ò›oª°‹PÆQ*¿ÅÏåeÚ–Mcµ}@\r‚¬u5üƒJ(ÚTX5rï?\"ü\'/•‡1CâŸ?loå8À€ËÜııi«ãÊrøkœ~6ùtÍ?ÿÚ\0\0\0\0\0LïËbLÁ­Võã´@òŸÌ	¡)ñ[6»µØò#¡™%‘sï.„c»B~.„ôK.—UÚ0òWJËâÉ½%/©$§œ&Ğuä»hÿ\0À\nÑÑb»ƒMF>›NÌ¢‹±Üx?KÁ¿_fP<s2É-ª—PÈ™oB*ÒyÊSó;@ôví&tlæ.CØ}mˆ‘ïàØìÍ@@0L¦\'Ê:°~§ÿÄ\0\0\0\0\0\0\0\0!1AQa ÿÚ\0?\ZlO İ‚_È:|\rr<¶ê0’_ùäÆìÃ\'}ù\'\'â8B¼íŒYa¿Û98öÉCØcKô¿I†@¶áï\'É[_šÂìO‹½ó~¨œŞ\\0~m~Åá’NÙÃÛ,Ãùæ—õrÆ{°ìÿ\0meø£gæF½a\r”õ†¶Ì{¤›iä_·ùÌoXá—«6ŞÔV0S‘ô‡á|F;fL6£¼¹}ëJ”Ï¿\ràC—PXŞ9.õøåâ5‘¿!ŞJrIµÙ‘ÖZÇ»9w9ğùÀƒHGäûÉ/Iw¥²;¶u§ÍdxA“³I†Â%íü1¾ßÁu%‚*í¨]H‘½d>CÃv(IËjÄvé×âğüñ¼ß¿ô~§É÷ä{ñùõÿÄ\0\0\0\0\0\0\0\0\0!1AQaÿÚ\0?€í±ù+ìƒòÄ³ÒÃË‰p´EélãçÖĞ´ìÙpí§¶ŞÄq½Nş]3,·x÷~wìA1å’˜JEç²«mvàYèÛxXIû»ğc;a)‘#2ÙÖA»mÇ° 2-/VùâN²ëÙ}ÌsùtãØ%ù\n¸@`ü¶‰×	ºå£Kk¹~<;’ØãtÙGH»gN}}A.}(aÙÑmÌã–†|±‘gØH[m·n…<H:¿$·Ÿöı¥ŞYoÀİøy=$9!nÖ%FNç	wÖÓû,iñ6{%û!ìÜCÒ=…ş_Ô`ò\rÆÍ§Á¼oã®zÆş¶äõ°oÕ™Õùl&L–şØ´b2ÂDˆ¨ÜÏzXóÔ6Û´úôù—ä}“÷ïïòõz‹ÿÄ\0&\0\0\0\0\0\0\0!1AQaq‘¡±ÁÑáğñÿÚ\0\0\0?Ş5§oŸlùŒñrİÒ›”6WÉEŞKæ#q°ŞÇ(ôXz¶„~`GšÎ\\óiÜ¥rW2X-QÌ	ÒÚ\rŒ¢ºwÌU“2]D•·‘úØ†Eø¯ô`ƒu\n*å^ÉORÃÁ|§còÃ¸$R«DPe4¹®ã\"ı¶À(©¼©HÀÎ“!­$|&ÙYº$ØŸd=“beíı‹ÿ\0ôœE1ÉIrG€şÊD–ïâÑÙ7_Ë`|y‚\ZÒ¨Ñï‹ö‹\Z_0Æ×0¼ş“³Ş_q ¼å\0”Vq*\\²çÒ?5‚^RÍNÅöR¢wŸ0¥&«Ë(İ=×(Ø‹Õí7Úî<Lsá=0w&‰«ËÁ\"Î`ÕeZ¨/9rÜ+O3•¯ââPdeˆÉ”G¤œG§qåBÆu<%/Ò@?h•1vÁÃÌ:²ßÜjµ;9Örjx‚¥aTW29«?ûÌ³\"ªúUê.@Y…êPªñ]—Óá‡]V[Q*(0İ|K(¹ÒĞóY@PoÌ>Ôª¤+J‚¨)C“Ì(”»%Ë(R”*X…ÑÚ÷}EÙb‚*à …l¾È4Ü¥=%³÷MKÇ‹–§6ŠõÔ\rPu’ı@ä…¡÷ßø^Ûa>uS{…¸~s¨¥v–%³I.®%xÂúƒr!g^r¤-‹ÈJ0;{7hõ„¨^ŠIƒ¶š‘Á‚\\²øLûÇ\0©ØƒçDY$¤%/›‡¢»Õâêæ«XJ+Dá\\6</d+Ó1ÇÈ¾O©Ş†^ÓŒ5wÚí¿ä´9û±QB‚UeÀWâB}‹ş%~ÅÖ³Xê·jçöh§Cñ1QÓ¼ÊA‹…‰àù”EcÀ‰ \rpÁĞ\0ó¨¬ÚârìQÃ^1ÿ\0É@CE¾>\"¦Î÷	v‡j Òµİ±\0!Íy‹¬Eé1Ã\"\Z‰f“Q^å­5›\'sT_‚$¶ğ­œÕ<Ë¯[\'WîËbĞ¸¾wÉNŠ`‹µ„Uõ‡–ÁşÆ5K]Òÿ\0r…Š…‚øùM”?w%\n]ÂQP“aÆs)8>ûŠŒmcsÊEki,ìçÄkX!PWnªY rj@\\‹œ:•Äå?ê¸Øx~È¢(7ÌK(£|¤Ø} 1e¬F=h2Î.0Y*0¼+ä_ˆ(oV÷*Ø‡PÀâÌ\0ki­ÙpéÃ½êôAÁH[¨<‚mŞÄtG†Öò¢&î‰½%Šºª-±…`gT]×i›¶¾!mUÒà\ZZÍ.\']LuJ>î5wA }Ëi:2İˆH‘1Âú”8£)]ò­«ó,‘e†H(\\\rKô]ÙE;Q ™Q¤û•7‚×™fgÉâ.b•kâ¥uJJ¼36UÑ\0\Zi¶B…T³M¿KPFåƒ˜Í2ì«WR‹êà¦ ò>úA)¸§¾DE\Z¾îš«­.îã‰ƒd’Æ2ší\0¡‡‚:Ô½^\'\0xùŠñ\\‹\nó)@¶oc\Z|õüˆ¤ƒW•YGbDO„¯€Gàr¼ÊArñ}Üíl¦Ä\\Ñbë<F£LMLss»Oa¸9´¾<ÅEØºŠ¯.|L2(\r×Ä\rSd¥õ;$¶¥sFNTÛ+à»¼š\ZS‡‡\")FÎA|ÔÈN¤Lîåàşb\'ê3ÂÇ«ÅxÇÔ°ÕyâQ˜º@Jxk´A\nk\ZƒÂÉˆˆ¢ëæ\n\0BW¦ éy\'åà}F]È“AyÙBëkÜ@H¡EÂš[Œr—É\\úæ6….ÒÒ[EEñ‰vC„•ŠÚî9JMÛ”Âuƒ„K? Õ´¸ò@¦~`®Ôª!\\áØÿ\0ÇûâŞq°õiìÉQàŠoDd\'ì	Êqyçh-B*ôd©¯!|§èŒÙĞP(À·šüòY.ñV*£Ïk-ŠÆÎ€±­ÊE•|lpß–c7°0ƒ2v\n©<:_rª‚‰rëv D¨×…uéÁUj$MV¨iö#Î†€ı!ÚuÛK{›FÆ*Ë–*\\æ^90·[C‘mkKv20>dKj8k\rğ¯d·Ò©:õ-èå‡ÔÚ‡¬o E7xŠRû›o­Òí¹[/gàDÄAÃÇ1PØµ_˜›øÍ¶_Ë3kŠÌáD‚\0,àLQbz¾Q;hiÂ\\PÂİFŞêæ ÃºS‡P*ø¹¸\nñ‹\n@ %ß12Ê=Axğ[Ÿs~Jãæ’!p\'R½0¦z»/*“SEğwmÛXùe´Š‚ıJEÊR*æ\0?a/É+.«Ó:¸ùkû6õ¦ß^¡‡¶6ÛX^œó*¶“ÍQŠ—ÍAKÖ®ª,70[õøŠÜ·=°\rŒm9¨lEb¡Pd8¤ub(@İÀ«$ñ)ˆöŠ*â+t›‰ÿ\0qQ¢\0óPµ°Î;ˆ\0]¼F°¬³R½AÊÑjÜw¾ÙPƒ]¶òüËÂâ:÷ÿ\0ijZZrT¢‹°Nî\'®&\Z.ÒG2kÌX%É³W\rªå¨ˆe;1‰ã›¦å\"Fsé>|ÃqTÔã“ÔQn¨8a¬æö(tÊp6ç¯™BCæê\"ù³Ğ\"°ªàz\"o¾‰däîZÕ¼”(m¶K‹’œCÖÎåz´?‡2ìˆù%„ª ^ò/òFxøKC%ß`š¥Ãİî²^läZÒù–›\Z£¸5øüDEå¥\n/H­»ê¢\"mS×Äá?=¯ÊópeCNÑnªë@Y3Oy¸Ê‰zîaÙˆéó5	<ıÖ 1Eª1V®ÒúCn–¯“ÌDR~ô¯RÑ3Á}ÅXÊƒ?ŸÑÉ„\näÊÂ˜£…—ÌçhØµ•ƒÔ<{Pä}d°jÊuK\0±Ï=…®ø€ˆİÕ?¹@nJì÷ñäF›µ-{ÑÏæXSÇ#ÜE¾œlcF¯`K÷°)±Msq3g—²Ñ¥6%Yó°uú¹·İDµùĞ¸×â>á¥÷IZÔÆ¡}0ÒÍ,s}¯ù‚«;¾ä²™^E-a‘â\\ìØA ‚×Ò´ª©ÌaÒºğEJ¥ÑúÚÃÖ°=2ĞxbZôtŠ÷)äöâ%‹ÊŠÂ‚#h4£†Äêíp··æa{•[ú…yä˜\n‹÷+®á²í´°¦ËÌvJj³‡¨SŞær²®o\r_gpjBHíWÄUô‹_RBnÓÊjñÕßrØŠXv­‡WY»…£DPP8|˜î£Ql?Q«K½±rF¬‚³GÜ@ªP„Å1­X*ÔÓËÂÌÄq–Ï™Äí˜ƒ­B…é-8W¯WÜÀ^ï=˜är~‰ª•ÈªòJ“@™+O‰v¶–ÍBg»š†\Z^~/¹Äù†S¢¢R›Ìª\'•*‘KBxÖegkYëfBö‡İA#˜oû(¹ùESXæâ-’šù~Czø9`§h!r¤díY\0[fõ\ZÅzp\0P)ÅD”9‡¸Y½Ú½y:ì¶ìê\n0h¡¬ˆê<TKñ‰yKDáó\rLV†5.>@Æ)cw/pû™…ûj_&ê˜®#àÅ¨Ãğ3XÙ„Ö\n(×‰á=‚Õø‚ÖRøU~§&»úšD±»+ñ—;<ÄxÖ#ïê¦Ü ¥Ü\"@üZŠUk¬·ô²¡üIÊòyœè«¨‘UÉ¥*uE>ac{\'‚7ãRĞ1Ìu-dz¨¸j€û]“ñ`«>ÅMYn‰Aä‹€“në†ªSˆŞ+ˆÈ±J¡[y²ØB\"ˆ<Í±Ò<K[Oié•0a`6*Õ^à®^ÏTu«¿¨ Š‰1\\urıİuŠ°²ùK.ÅÂÔ¶¨óCMÛ?\n[Ä jéÏLY„L\0W)¾ Ğ9èÖ4¼KBªŞ·;-\'–hhò•#vºYÙ«~+.GR]¢€ ÑhÌ~ÁH\nQuWß2±¡ÄAÜ!J_RÀÊD¸…½Œ¡07‘±Qm\\!È½®¡\"Ü,Éb†]2*#hFÀ€`·—(bÑ®¦J¼‡•ØA—Ş «ñhæpØıy5ñÔyXr«`-”\\7R(‰]SL ª¼#÷qsm!Ğ\0Ñ6»áŸ…œ@Œ®F	x3¥•>ãdÍÂÉ~3ú@—îIi¶4çş¯°ûñ.šê®€¢İÁà¥í…<O.°œ,^yâñnÑå‹ÆS²ß¿‚-´ñÀ:ëÒ¸ã¨€Â¢/ç¨ëà<Ö\\¶\r\"³å……(’tSäÙj†µ÷qkháµZ1©±Ÿ•D™pÚ»+¸î¤Vm \']«ÎÇLNñ<	L¤“¯‚i¹Ü“ã™½ˆW7gd~™h&x^àĞnÓ^)—†Ây]‹†\0Ú:NÛ\\—GW~ãËi7Õ¬ø%oj,Y›Qàw;t~\"¯¨vÉT_Œ[,¸şbø¿P><Ç«¿l¬Š¹®°¥qÆ£õï€ùØß‰)Ø~âBÕU\nüE‹ÊÅò%èrî.\0¯ˆ.—Eı.%U$ío›ˆfòV1—D<òåÊœ¹R^-÷\0\raÍ_Ê´c}ÜÙæWÁ½(¹.ÍÊÌ}!È¸î‰H#³—r¤²Å¢¢¡\'ª “[F¼@n9I«±·î6»qİÃ”üN®\0\\=vºrT¹cÙ‰2\nÅÅÜ*`~	àş@€p -Jë,u[\0ã™çÅ[-‰á3#4A’& %\Z´¥Ò@¡¥,æ*şT´8>\"¾ÚWU®“#\"\"0Ä^ğ%j,x€µ\nş¥ã¼º¸²qÇ¾@îRB¨9®Y’©CÃ`8/ ˜6å—®#Ô³°Wˆª¯„KáßsÂ9VÁu‘.¯êá(œÖ—ñ-A›âdK]<A>MÙ\Z¸\":	á1ĞÑ|ËŒ<MŸ˜ ó‚€|lHbTƒìsÒ¾`#!WuqÎËİE••Iqº‚«ŞÓ—J_—¨û#âr*\Zì´Ù–®.ø!Ùwê!Û\0ÛÍM/OˆôkóÊ¹ª<•)Û%ö’›ñ´X•‘m\Z=DğÃ•ÁÓ/­ LÛæàB”FX*E²1A6¯æå3¥E\n=JIBL£õN<jSf€Ç-c8zöKÂµ\rÜE7Rú¼Äd^–Ygeõ:?QR¾YsS„Í	Wî}T\n]³i€@lIgŸø3üOİƒ~süÁNxŠ´?!Œ‚øıL	…ñ9¾ÓÓ9öƒË¸o{í€äêPpêğ|OÚYûS„şìşS“ñÿ\0‡Ê<ıÎ_ùG‰ûæÿÙ', 1),
(2, 'jaime ernesto REPORTE_rodas martinez', 163, 'ÿØÿà\0JFIF\0\0Ü\0Ü\0\0ÿÛ\0C\0\n\n\n\r\rÿÛ\0C		\r\rÿÀ\0¡9\"\0ÿÄ\0\0\0\0\0\0\0\0\0\0\0	\nÿÄ\0µ\0\0\0}\0!1AQa\"q2‘¡#B±ÁRÑğ$3br‚	\n\Z%&\'()*456789:CDEFGHIJSTUVWXYZcdefghijstuvwxyzƒ„…†‡ˆ‰Š’“”•–—˜™š¢£¤¥¦§¨©ª²³´µ¶·¸¹ºÂÃÄÅÆÇÈÉÊÒÓÔÕÖ×ØÙÚáâãäåæçèéêñòóôõö÷øùúÿÄ\0\0\0\0\0\0\0\0	\nÿÄ\0µ\0\0w\0!1AQaq\"2B‘¡±Á	#3RğbrÑ\n$4á%ñ\Z&\'()*56789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz‚ƒ„…†‡ˆ‰Š’“”•–—˜™š¢£¤¥¦§¨©ª²³´µ¶·¸¹ºÂÃÄÅÆÇÈÉÊÒÓÔÕÖ×ØÙÚâãäåæçèéêòóôõö÷øùúÿÚ\0\0\0?\0öÏ,Ë€HU°rqïsZg’v…ÛÇeì2ÏZµîp3ye9ëÆ=)Û.BSÀéÈ9õşUéØòt{”¼²[k.Iä±¶:~­7jŒG=rO¿zŸJ¹åõ!ÎsÏ_CÔzõïHÑ[§ñ2ğG¦~˜­K¬eßéßl³x³ö†sÓ¡÷#ú×7›¦ß;pË»”ã‘ú~f»i!eãå-ÈÀÉî	ıÏ¦^³¦‹ˆÖHşyWI\\“ØÀJD»îIo\"M\nH„`×Ïùõ©	UGÌˆß?3úÖ“xÖ3¼q‡¹ÀbO:jé0»pŒepsÁÇ§×Ö‘K¹	ƒp\0\\dg<;õéQ²¾ĞR{ñÎsÏãŠ·µ—.‡$`zı?Î*#´®7cœ“»Ó¶iú•šÜFQèyéß\'\'”Ì¹A´1ãŒÈÿ\08«^^Ä* r½GnOùõ¨r Œìûcè1ßéR…dW’?.4U8ËyÎ:ú:É*áƒƒ·éÇù÷«N0ÌXòüÀ\0Œöş•¨ç\n}ñø€zúg¯µQ\\½lDÊ>b288ÏƒÔ¡ıj$ˆÇì=ñVYO±ãúçùĞ±¬gKnÎC1\0zãôı*\nå×Bª*y€©PÄw8çÀîi²0êOŞ?t’=8*Êá³‡éÏnœú÷ëÖ¢Øÿ\0/cÔrqœuÆ}©Ü9J «Àq*:€r@üé6…ÇÊ	Î	÷Ö¥’&féÆz`ç¯Ÿ­:Tcò£,0ÎqÏ¿_­K/DVhÃ’Ù Fy=R:Óv,c~pqŒnœñønjvR¼üxã§ØSrVOf8ÛÆ1ÓŸaE‹JÎÄ,‡ÌÁÀ=@İØv<ı{ö¨•J–À\'$tê[8úÔûÂœ\\ãoíì:Ôùœ.ÜrTÏ.9íHnÛ™ú¢c/pR~éÎpAï×Î¹ÿ\0Ç²ıøÛéŒç×Ÿ_Jé5Q›)W‘òœmÉÈÆë×¿µaxs1_JO/µ½‡\'ÿ\0Z£Iv:9\"À™˜®FÏ \0ç¯=ÏjË>™=x<pOÇJ•£\n\0\'¼™\'§^½»S%\nÇøxlg=>¼õÉ5hnWdø@ÄuUü:g>ãó¨›&FÈç«w=8íÛü*i›*ÅApÇ àñr}ñëŞ¢;v‚s†l79í×ê#L-©Æ¡P1ÉÆï›#\'#‚~õZi†ÖÁÂ:œwÿ\0õÕ¦R¸ 0!‰ëÁŒvúş•ÀÒ\0L• óÏ·Ò« [¢+19?7z±ıµG&ŞX`O¶8Æ:zúÕ¦U‘~éç¡ã2~¸íU[î¢ù{‰å~cŸn~¸¨Ô|©2œÑyg!‚ñƒó\09ã™Ïõ¦ÈùÏßÆâÄqşõbHÜÀÜû€Œà‚O±Ïz‹k,e\\e×Œã–Çÿ\0_)ŠÏnë=ñœÀÏLÔÔË´n!Ïb\0#‚IÏOcVİYòÏ¸ävÀ<sëõ¨Y\ná‰R¬yÇ\'ƒê3G›.·*…mÜƒ‘ÔÀôÁã¦O¥ÄŸóÑ/şµ=áqa“´ã#€\0çñâ«ı†/ùô?ÿ\0\Z\nMŸF(-³wÛô§`;ÔyDd|À7sÓ¿qVîŸ—œœ`÷ãóö¦˜û‘œŒç¡Î=~£¿­u$1©şèÆp½sÛ¾´Å,¯µAãàñÆ>¼U€¡XŒò\0ïëŒú`~”ŒF0Àõäàc‚G>ÇJ–ŠV+ºîRNzu\\yëí×ò¨İ[Ë,«„ã#>˜éÎ=½êĞØ¥ˆ[ø‚ZlØ08Œç õ?-IvØåõ­,£y‰—S÷¿<úwÀëéVt]H\\!†S™dÆå#¯OÎ¶.#óò\'Rİ?1éë\\½ô2éwX›%IaŒà÷Á¸ÇnÕ>`·±ÓüÄ÷u=>l¼şİ1ûàîb0ŸQÛqùÔv7‘ßB“ÇÜc×pG_Qú\n™™cå¸îQÓ·¦?¥‘IdÎXwäq‘qéŸÊ«á•z{ã##Oùô«M÷@éN;Ÿş¿Jc²´`u$p£O¾=;J¼ŠØ*ÀŒ˜Î=úôşuÑüœ\0~é8ã ZšB@RÃı»¸ïôüª?/j¦FQ·8çÿ\0ÖzPQ3xêNOéŸ¯ÿ\0^š²nb¬¤\08 “ÔqÎ>¿˜§·İ“Óï)‘Îü?JgÃÁô<æıÙC«¨ƒ<óÇü¿\nqòşcIÂóßŒqïéS0Üq‚:g°¾}Zpê7 ##œÀçó¤ÇæEÊ1*2Ï¯ÿ\0®˜Á±Œu9Àúò~µ6CFïSŞŞ¿Ê¢í=0zåzgÓ¯¡=»Tõ(UÎ0Wû¼\0;sÓúT\n›ÉUÇ ğ3ÀÇüjÆ@B»²~öëı=»ÓNß3sŒ†1×çCRá²ü¼äã¿•5”À Cœç9Ï¿_SíÖœÃl„îÀœwç8öÇåH?x˜c~n¯©Æ^°ÁlÜª.Jç§lñ“á·İ$ÁòFÇ tê}ñíÚµ5æ_°È@-¸`Ô‚zëÍføuK<í¸íV<Ü~Yşb½€ÈYÈØ®3wõcŸëQ¿R™ÉSœ•ã®3õÿ\0FİÑerä¾1íÆ£™ƒJr	=@ã¦sŸÃ8ªCcXÛPÄöúcê*»«)) Q°Æssš›pà.Ñ3ß§òÏZd£åÚ<dwúíƒC\'±37ÍÁ8=1Ô{qŞ¡f‚(Â± ¾w¸ãğÇJ™²ªàå~öîFı=»Uy¦Ü®äã#÷Ç±íL¯@˜®Õ%HCÇNzg:\ZÛlãœ‘ÇLPIyoI‘€òO§¥S›Y·\\‰È9ÚªqìO©éŞ“°¯­‹¬C8Ì]zs§<ñÛıª\r¡d*ß¼1ÃôÏ<{÷õªÚ‡ËeÚyw½´^?—ëP4×Ó`Gm³#;]‡ ÁüqüªoØË’»=NK‚{q‘ïî?Ä×šQ“‚Aëë¾¸ô•Öºƒ(eºü«“×¯×§áš©6ŠóÊUï]³ÁÚqÎ{ôÈôíOÈ­Y4×‘Â¤3 uç§¯aééTµm¼ï¦§K¡Û¬–gr¬T’9ÁÇ¿Ö£şÎ´şçéKNÂùŸT+\r¼rëõÁÏ\'\\zš6yƒ\'$rO=zÓÖ¥FÖ`N:arsÏoÿ\0]9°6`r9ãß·_é]vèpêVe?xïéÇ|zı=i|¼ÛyÜ3Æ·Õ,™ÉÏ\\ûg°ÈŸ1°ªÁÏ;›\'¯øóùÒc+ğ¿9õ?‡¯?ÓŞ£ÈØpqƒ‚ÄğÙïùTÒ2z67qØÿ\0œS/V?–rs×ÌÑæ&ÈvıÌs“ş{zTÖ±Ü[È§‚ÇŒLgğÍZ}vzŒğ;sëéHÀ*ô¡ÁŒñù­&?3”³º—Eºx¤Ü#vÄ›˜§ÿ\0Ï­t;†Ò\0ÎàYYHëõúÕ]{NúÛrŒ¸íÜŒgŞ²4m`[È,¥!8…†sĞ„c®÷©ô\Z7YAÛ#<½”É¾öÜsĞş\\ò>µ32îÛIzz…@íÆ“Æyo§çÚ¥ŞÃœm9ÎNI?öãó51ÎùN¶:úÿ\0…HÍ¿ƒÏ8<ß§ãş5]™y+óŒú“Ûÿ\0¬?3R1ZM |ÀuêyìE6F\0Fqœúc$ı#©fÃ=p1Ó×üõ¨¤en@8S‘Éã¯OaÇéAk°›¾]¹°~èëÛóıMG÷À;Hrv•`GNİ?+åã9Ç^3éÏ×»oæÉÉÀÀÏô¥©Zû¬\\€rq»<•±‘º°=NNNúÇÓÒªÜj–±²n0IÆö==\Z„kÖ¬À#3·j¡?†qüê_q¦h3§\0ÿ\0§_ò;S\\|¥Ğõ\'ğı:ViÔ¦`<«IOmÇ\0sßùu¨şÑ¨Ê\n¤1ÆAÎwdqÁÿ\0ëÒõÍ#)QùñçÔOQMeT$†ëÏNÿ\0_\\ÿ\0*Ìhu9ù7QÂ6äª¯±÷şCÖ£şÊ’á7K{+ò\0U8ç=:wş¢CµÈüI([ó)wÆĞ8ès€Óµbèº­µ£N.7NF‰è;1ô5k[Óâ³E1Ü³;ÿ\0‹ƒÀãÖ®h6pÉf²¼*Næ9ç>3ê1Ï¥AĞl …[“qÀ8ÓœgÒ™ı©$Š¯ŒÅ›%~\\yÉ8útô­yUl˜ğ ıO˜Ï9äúŒgòÇoZõ0ÖëS™¶­’Ç³Ş1ÆrH=9#µ9aÔ÷fG…[£øà{\ZÖóWçQÛŸ›¿±ç¯5LÛHnsÏlô?ÏéÚÅ¡’tÉİßÌ¼>„\"ßŒö>Ùâ˜º}eifÁËbzŠ¾Y£À-œ‚ÇHÆ=:v¨æî\0æ7ƒ‘ìqØõìzÓ\rw*C£ÙÄÙX9ÚA\\çu#¦OoSBÛÂ»Äq¬hF~U\0ãÚ¤ó›k±*„`±\0\0pCŸO_z‚Yº”“çÆ77Nüã”¬>‚´›0ùNq’sïùñëPÈÛ²¨U(ÉüsíßÚ›#6ÃómÇ¦px#8éŒÛ¹¤“oÉ\"9b¤“Ç>˜Æ=hØ¤20ãº`‚îNI>Ø÷¨&míµº©ÏÆsü‡zWãŒƒĞÃñ??Ê c¹³¿yİò‘÷xéÛëùÒg™cRÏ”…f9¯_Ã=}F+ş&şêşŸãU5Iõ[Ï±Â	‰	L½ˆ?–)ßØŸôÙ¿ïá©ìA·  ç¯OçşsJòa##§ÍœãëëFİ¨>ıü÷¦3¨\\‚1Ôô×ŸÇ=±]‡}„‘‚Ì@Ï1üO>™Å@ØŞINIÆ\0=1ÓòöîELYH=s2~~œİª‘[*ı‡\'#ŸäĞ	‘ğ²}íÙ=x9çŞ´Ï0üàQŸLcÇŞ¢¸¼¶„î€ù²Ã¿ôª—\ZÕ¬l›&óÑzô;{Ô\r—p sHã?§™·qÜ9äƒÛ§·^şµšÚÓ2şâÒSÎU¤ã>Ÿ˜45åüÍò@£wc“şrjF¶/JÃû¸Ûß×üãÚ¹iãwœ¥£FÁ+È!³Ãtãz÷vhõ•¯vÈòÇ>äqüıMS›CiX™.¦rİİÇ=@ç¡ãò zîˆôE<Oow2Gs·¤pÃ‡=sW›\\³Ü@•N9 öãú×3©é­¦Ì’Ä…Ğœ…n½	+øÿ\0ZÛÓÚÖúÚbF\0…sNA÷úRÔ½Å> „–)\\NÔÇLóQ¶­4øXÈ\0ş\'G#ŸÖ´v…b1…#hÇOÃ×4É’WëÏèqëš^ÔÍûF£\"…X‘H;¾y7c¾O>´4:Œ¹g#\\g(¼÷Ïz½&7`‚	ï»Óÿ\0¯HÒ~èmãN98ÇOğ¢ÅÄ š{™2÷S·®\0{Óüâ˜ºE·ñ)ƒ–\'ßéÖ­³\r»ŠÉëÉõééåMÏÌ~\\zsÇ±ş&‘{ÆŸl¼GdŒä(öÎO­N\n‘Â„9ÀÈ·üèyvÆ20~™HÏ_jœË!ubã¦X€zp>œŒı*»ePxPPœgùÈıiŸ0d;qƒØç§ãÏzK0ÜY9Æ;qÀü8õ¦…^W‡cÛ rsœ÷ ĞR[ŒŸb¶?úıı)(^3Øg©ãOñÍáN2ô\0d 8ïı*6brPd÷Ûç§¿Î¤«^$Sö8ğ@ù³ØõVŸ^SVô­ñéq\0ØùGËÀ<ÿ\0LÖ/‹.ÀŠ ¼08<ûqß¦ê+OL.—n¡ÿ\0åš“Ó9ş_­A%ÔÑv=Ô0\'ƒÁü*\'“÷œ2ü¹=¹?©üW’à+’{óŒö¨$*»±”ÈÆx#¼ÿ\0Ôı\0·çªãjì8ÀQÈ\'û_QUüÆ‘¶·RAÛƒë/J­%Àr7ó–ÈŸQŸÌ¾•Ú²ìã¡Éã“ëÓ­2eä\nç%±»†	\\ä~µÓ\r¥Æ>UÊ†à‡&Ó¨&>	9fÀ$àäûg½Rº¾³FÙ5å¬£?4È\'Æî¹êy’êW+kD9Â1%wI\\œã¦y÷¨ä—rãk#íÏO­dÉâíşÒÊœíÛ©ùÕÇo^ÆªÍã]-$FºƒÀ\r*Z…\\“ÁœàıÚ9ãÑ–K¡¹-Àbçe988ô¯åP³«3-Óœ_¯©¬;Ÿi¶ÿ\0rŞæTÆX³ªûç\0sÈ?­b? •ÌFÆÏÊ˜}ªveçŒ»Ó=½k.u²+–VÔêd˜äáU¶°Ü\0èN1ş{Ö>«|ëfâÔHï’.HäôÏ®?­aê_#³Ï—>/_*%n ô<Œş•Îënï-åßRî64ZFIQ¸1ÆFı/S®Òc{8ãÖá™›ZœdùûÔßioùá\'ıô¿ã^%ª|U×¯c>eØ—‡HÔ`ädıx™¬_øLµÏùú÷íÿ\0Â…!r¦M©ŞÉ³e ÙŒ~ñ€×ëî)’h?F†#ÈA-ÛÛ¹şUkízr3Ç8Îsøÿ\0•]1…~¸<ô•w\\ómÔ¤Ö÷&7İw&	ÃÀ=¿OÆı˜¿Ì•Ütıãã<}z}*O´(c£hÁ#¯\\ıqŠ¬×˜€ps‚	ÈííJı—bU³³#É\\±ş,z	ô¥ÜŠÙUÛ8óƒùUfŸ¸9ã·ÍÓ>ß­B×ƒvW±çÃ¯ÿ\0«ÖBíÜ¶ÓnO¯!G_nİ¿¥G$İ‡ÌsÆ:ôÿ\0=>•Y®\nÈA^\0\0ãŸóŒTm6Tœ}qş}*n5Ä¸ä0Ø=zã9úÿ\0JŒÍ¹IÏ¿·¨¥U[´rNF{œcñÍF÷S€÷\\œõä’;JW\ZCî™.â`mè=s\\üsI¡jò³?ŞÛN7ëÇéŞ¶\ZeÜê1‚Ş£Ø~¹ã8ïÖ©jVé}®æ}Öü8ü?úô®ZF²ÈC#®3rpnı)\ZO,Oâ9Á8#\0uë\\æ•}-Œiu$fà1şqĞç×®k^[åL‡”ÙIÆN:ÿ\0:/‘a‰e›btã±ä~¥1Yw.æ(C`•öõş•ÊdÜ7`‚UIŸ§Ó8õ¦I3Û‚óyp¹•Õ{ry=€ïC}™IË&Õ9üH^ßız…¤*Fp7óã?€Íe\\x“LU%µKP…%X¸ÜFG u8?¥R¾ñn“bŒÓ^ïÇ8LıNæä\ner¹_Ton¸C×#<õÆ:Ô>gğ•bvàç>øúÿ\0:ánş*hp,¡&iäF³ l\"38=‡é\\Ë|y²š35¶ƒ!\r÷L÷|¸ğ0£õ?•C’ZšFKDzÿ\0³6==qƒĞç°ö¥ûÀcŒâ÷ÿ\0?ÏÖ¼>:ºÂ\r¾‘¥D9;¥Y±Ô¿Ó£¿éºWŒoï<;e¨Ïs^|1ÊË\n*¹A õç¿µa:ê\næñ¡=™ĞI³)Är6A‘NF@öúu¦É¦êDBYHpp»¶¨õàšæî¼e-÷œ,¼şû•ÎF\0İÜş5â:—Š¼u©Fogpè[jÍ«1ã=Is´Ò§YÔz!Ê.ì÷ûï½ÒªŞŞØY¤m•Sp	än¸É¨#¸Ò´øR)5ËfòÔëÛ÷Èëíë_<¶‹ñZŒovõÜÊ‡ŒœúUOáïŠí¼–½•¡3)æ\\$.	úÒ¶mõd*Nèú_şO\r[[£Ë«ù¹\\\0±…Î9<ëëè+çâçƒìcbî9t³ª¯L“O§§jùãşy®cEŸQX?w-œœçvò­½?Á\ZM½/u9Øà¢z‘pzàşU›¨’»eº¾­ñ¯\\7š„Çi`–óÈaµWŒùéÏ¿ó¬;Ï‹*›p‹X–(ÎY|•HÁRr@ú÷«shºq¼¹ºŠ)®^giäMà,sÇÈï*xü9mrªĞZ\"m\\¸•›<ã¯nzÂ±öª÷Fñ¦¬7áæ¥sâKÛÏíMI§•|¶d…ºîÉÆz}G5ÔBÆÎbª9I2$b OC˜=ë…ñ?ğ†X‹•‚9w|¬Gğœ6}p?úõÏ¶½5äQ´p`å—8=9#¿×½sIJnèÚ)ZÈí|mª_½Í³hcíSI.¶ê%Â†Èİ«‹ûo\n6Ë¥ÛÊ¨\" 8û¸ãÔş@×uğ—P›TÖ¯-ÛZĞ°Êò0ëÎ~‡§°ë]uñM&ñúîŞ!ÏÊó.}OSïíÔWD-fsM{Ö<^‡~+¾mÓ¾ÉN@ó®áÓ×Ü÷¬;ßG3‹«¥Â–UY°rsÇüõ¯¡`¼Ó5+—ÏTîïïyp>â€è3ÏÅr·^¼7ì’˜ÕÉHI ã©J£è	\'k£Ë¬ü	·¡$¾o™¶Ÿİàv\0}şœŠÔ³øwâu$\ZîÚãtÒ¨8`AÉÈç}Ew¿ğ‹ß5»ÉåZÛ e,­\"ƒ8úœÖ´ïş+A¦«Z4­ØY$¸\rœ\02F=}ûUF£)«;mÁoÉ0y-!ATÊ(ÆGÔµoş©ÿ\0Pÿ\0ûøÕÕÿ\0ÂçŒ*Ænà’FvXØÜu9Æ¿¥ğ¸Ÿş~-ïŸşÊ§B½ºPÛø‚;ˆ”¤Švğ[9\0ƒşÌÓ¿µ‹r_âÏNÙ>ÙÍx.ƒãÁs!X&òåûÁGñtÉÇ¨ã§¡®£Lñƒ]˜à0I,øDH\\œg§QÔwè©>ç™*|º¢×âI-–ë×ŒgŸéùÓ\Zø¶~céÆ}9ü¸ü«ûmÈPÒF¶j®$Tç\0g9÷³V-üC¥yŞCk6f@¤²BåÎ3×8ş½H¡ÍEjƒoDt¯tw÷=º~\\Ò˜×‹†¾^€_åùW4|a¡Ã+$ó0À»OÓzZæ5Ï‰W±İyZ7†¤Ôc“qæ;\"’Êv£ıêcQIÙéµ«G¥=Ñ\'Ã7\'©ïÀôïúÔh|ù20 ş`ûWÍã/‰:¢ˆ,ôk=8¯ñ$hXúŒ»2oñ¬í]¾%´I%î¸ö‘³m>LÁâ2AÇø\Z·%Ü$Ït’y‰%‰‚5çt§hç·×Ò¨\\x‹G…€ŸYÓ wq_´£e¸ùx=y˜¯›fğÅŞ¯4o}ªH÷¼–‘Ávnr	,İpMké~\rÒ£†9\'½’[•6ÜÈ ‚F;;Ön¤VÌµIÃñKÂP)Zk¡œmnÇpF[‚\rs÷Ÿ\ZôU;!²Ô®úíÌ‘Ä	ä€pzzWoà»q‚{„\rŒ3´ƒÉ\0Ï_Î¶bøyi\'ÍlFÕ–BÄq£ØóÛµcí‘¿±Lô7ÄöWšL\Z­¤Iê¬É;4­Ïdœc9íÜS.¼W#[Kä<V°Ñª¸€xõşUå:–¤<?¨.KD/\0ç,Bòçß· ªÖúäĞ¶LJn\nÊwGQíÚ¹¹§)joÉ†j¾3ø‹ª+2Ázbnx·|#®k=ü;ñSTqi2DS¹Ñ{NNyÅ}Ì“höwKÙŞ(È€` zUÿ\0„DxÒ7Õ-b”Ÿ-b3).À€8Ï\'%k¯Ú$´ÜæQ÷oşø¦Ö`—“\'˜Ë½¼ÉÙ› 3¹§Ò©Âq3—P …³¸ıyôÏóëŞüE ]ê\Z‚K\"²*©Úp\0$œ{r1ô¬sà½BæÜ&4Ú“# 8$ç=>‡Ö±uZ:V‡	gà-6Ö8ÇÛ¤¸œÇ*Ÿ-@ 2”#¡ìÇ©)müa\nÄŒ—Ä¼ïÇb=»ã‘ïR^4zN¥s\rÍÅ½«Ç\'A8[9ÊŒu\0ızSåñå¥²€×ŠBòÍ°œçƒÇÔVru%±¤yQ¡oğÎ;†°(‰‚+HxP~\\ó÷±¢±õlh÷í¥›/ìaP~ğĞsÓ¦=}\rzÃ-bÓÇfõ\"¼˜UŒ³Fª£-»§Bô®«şÎu¨Ou*‡¼—Fgo›Œg\0î÷ë._ç4U‹ÄÁ#¿‘µAÀÊ–½@ÏCôõ¯rÓíæ¼ğ®•4E›YÁaŒ˜Á=û\Zñßˆ^»›Æ—±iV3=’l±FY¼gIËuïXÉà_F\"šÚw|‡Ø3ÛÕK–=BQs[ßÿ\0	•f)µ{GN¥¦Q»=³ŸcÖ¹ÿ\0i3jbÎâÔIq«Ú»•²È8ô¿q^¤ü\r×µ«ä%·¶Kù²ÈN1ŒœóÜ÷¯YÒ>kpÚÛÃ6¼ÌD±yaŸ7zçTõÙ™éO?ŸÂz£3ªÙâN>y˜\0¼ƒ“ê{áÉx£K¸Òµö{{ç÷ª02Ç8Ïr{zŠ÷ÏøTÑÈÅ®õ9æwR>@\'rIã\0õ…G¨üğ¶¥åËw÷s Ú3 nIÀ\nAƒÖœb“³¨|ğºä6±5gƒ\0`9éœôØÔŞñU÷ˆ´ı=gœı¦xá;BüÎªpqÔdôõ®ÓÄ>ğo‡uÉÓË³‚Ü¶&¶\0ä’z“éë\\õÇ…íuë,šşr•Ø„(@@-	ã¿aZû(ÚèÏÚt±êº—ÃıP‚(nóp‘¾äY$#i<1zu5Î|Hğ™£øBî#NW¹iD#F,˜ \0sœ{Jõi\Z8ÄqG;×•8ÚOëœ~•Ïøúx!Ğïî¶°6]Ê°<ÈÃ9ï·õ5ƒºØ¸½µ>h·ğ»#:t \nÈBœgÆzdzsZ)ğ—X¼&S\nÃ\n²\' 8ô#©®œüa¼º¥Ÿ‡f»v>`™À\0¾}{Õ	ş6ë–ö¯kıƒo´¬áË/Q’29ÿ\0\n•í[»Z\Zû½\rüÖ´™$ÕYØÈÛubØÜ§é]º|1¹¹ƒı\'Xß#sífè9İÓ§å^9ÅïCh°G$6éæ3X”¶	Î>bxæ©_|JñÕûúëÇp\Z%Xñ¢óÃ½iÊŞ¬ÁúëÂ½8„W»¹œ)ùdôãúúÖG‰~x^Ş;»¹,ÚVù˜4ŒHË“ìséŠğËÿ\0x†Kr&×oÌÉÛçºÏ9ÁëŸ_SX¿nÕšé&yå˜îiüÀy5j-lV®Îòé|\'f‰M9\nœ6ç$ÁïœçôÍAö	zØßµÿ\0\nóëËXÿ\0µ\'Ê*ˆäxşbxQ‘úæ³6/÷Wşû?üU?b¥­Äê5¥]ğü±Ûø„33l90€<!#ğÈklJu	„‘´(?1V	ìsƒÈÏô®~Ê\'Ä<°F$\ròóÊ7AéÓ½&¯YÂÙYYÉáV4!x÷Ç½RRjè*¤§sµµÑã¾¹L;—™Ùˆãã¾Oz±«hãÃ6nŒG+–UÚÊG\\`úÿ\0Ÿjæ­ü]*È<¸\'‘K}İ¼ôÆŸSüëÜtí7MÔ4»i%·3#Ä²°”oƒQíQ(ÉYÈ•.Ç>¹<¬”±\\1*Bõ\'¯©ú÷¯Gøy®Y^i7ëw}R¬Ùıû\"‚\nã¯Ô¾•\'ÄÃs£Åg¥Ù¤sÉp\0\n¸)gĞNõÀØü2Ôfû:aË±b2z=GcR¥¡ë-PÆÚŸçÅu©Ûó‘˜_qÜ	=»ãÛÒ¤Õ¬ÛÄšM½Îœísşñğ\n•8\'Ğƒ±®Óà¹º¸‚Şöım•Û«èNzÿ\0zF‡ğ¦ÒÆx¥Ô\'’(ÑÀÎ1ƒÓÚ®é«¢yTm©ÊGá™ám¢K;c×÷²Àƒéë\\†¼¶z.¨ÑO{l§,’’I ƒß»W·ÇğóAµÉİØ¶O›.Ñß<üúÕmgÁ]“ŞÇ§ÈñÇåÿ\0¤\\óŒ’:·¨=i$º‰Èñ‰|cgaMĞyN²¨=pN{Jëş\Zëv¾)Õ§ÓÄÓ)—2(ëÉüÅb]Kàı)RØ‹P@$4Pî#\0d„ã¥t?îô‹ïÌºw/ögPÆ=¿Ä„‡ÛµiÉƒšGp~è3jW3Û‰nÜ)y˜– gÓÛ½y\'<{qãÿ\0ìËö5+³ËÀP|µÈÏ©\'Ö½ş;µf¹ù2›Wi?)<	}ÿ\0\Zó_xºóÃzÇ‘¦è÷\ZÂÜ\"N|†\'Ë`0Ã…=‚õ>µÏï_ChµmO3‹á»x Mf¶dƒ#œôÈ=+kCø#«êW±Iöøm¾ÙK|ÌÇ’AF;óV.>*xŸMqp|4m\"\'jµÒ8q“Øs×½a‹0kég‰-lÜü˜1¤ç½ÇZ¨¹ÛŞ¬Ÿº{…¯€u)Ik½nWgá~V\0twqíÚ§‡áM‰c×·3–Ô@ã§õÿ\0ëxÇÄÏÜu×&ß¦#ĞÈ^àŠÌŸÄ^!–ŞO;^¿å¶éŸ:Œ¸Í>R9ŸSŞ<Ağ;Áí%ÅÜöM<î¹,óócëí^W}§ø+Neš<|pCää“¹<ŸÈ}+¹şÒ¸™dšîiBŒîv,I\0AÏò=ëÙ—á_‡`†+»ùÌÍ¸o—\0/|=qøUºÏpPçĞOƒri?Û:¤ZcF<È|ÂUv«`¸ëóœ×®,ÑÎ×@*È•eàœÆ}sŸÎ¸}Cğ¾ƒæO¦µªK“’+‚íŒƒ°	ÇéV£Ô\"´Õ.åòå¹¶•P¬Ä(A’3înæ¹UQìmìÜzœÏÄOEàÍr[Hì\'¼ûT)p$a6}È_NõÊMñ›S¶d¹·ğÓÆ¥›p^€òvõ\'ß½zïü$VQÌ^+	•gæT=ÿ\0yÿ\0Å]e5=È¶XåV,î	äË4­	5th¥+Yœcüjñ5Å÷Û-ôû;I#\r¨Äe°	#wP?™ª’|Zñíï˜‘jpÛî`± <œğqì{W/0v”æC\'9##œ\0NÀÚü3ğÖ•â+@êsY˜öÃ*†¶q‘Ğ:üÖúGdCö9»¯x¦û-/ˆ/‰ÚX™Ô¯8Á ç·¥b_ê\ZÕæZMNúìÏ™pì˜8ÈÁ=€ô5î‹àÂÄ+Kvío™|ÿ\0õô¬¯èº=†’ƒJµóù˜,İ´‚r	ï?Jµ8‘n†?‚~Øø«Ãöw—²°H‚RŒ0@g*OOÒº=?áß„,Ş6—ÊyBÿ\0Ëk–Áã€{cÓµxö¥§]Ş!İçyQ’C6Jñœ½9ìiÿ\0\r<?#xëMÜdhœÉ»€O°èN=+EÊí2î¢µG¼k—VÓC[ÎÒíœ;Ùƒ\0¤g>„‘Nm~ÆR­e\'˜ï’sŒçœu&­Gà×Xİ¥½š2¼…R^r{uéÓŞŞ´kT3ù“1Á>d„ñÆ¥§+jÌ\\ã}Œ‹ïÂÖèE”é#Uzóê^kÂüi,’j×sƒ³Ì™áIìxêxıké(4Í;e2Å	pÁ›$`œc=Î=+ç¯‰Ö&oˆ—‹¦É´qÃ/ıZä=rz\n¨Å¥«-4Ş‡)¤ÜmòúpNyÁêšG€<76g$ú”ŞcÀ¬ÃÌP¡ˆòçã­yå¾,ùC\n‘ÎçŒçğÜø~ÚŠiü§ÆİÀŒmÏ¯ğ¨¨ÚWC·™¥\'|0­²â&T©VY‡cØõävî+Ç¾!İ[Øøš[k\"ğD»JT€@$gëŸÒ½ŞHã¸Ä[äØUwdG\0œçÏnõá?4×µñRFƒïÂ¤yg#«;éØÑNnO”–­©ÈI|’:ÉæsŸRÍß™÷õ©?´l}dÿ\0¿ŸıEoá½NéGú\ráUÊÂÇ>İ;çùš_ìWş€÷÷Ã×JHg´GPxª4oùúÊ ÷lr=ÒºsÅ¾†ÅmìÖsŠÌa€‚Ø#¿ojÂñD1Xøêá†í‘ßÉÏI#ëO·¸Ò4İS0Å”Øl v?1ôî	ëéS# T\\Ödmâ‹[¾>Àà3/ÌÛ@nAïŒù×±øTŠßCÒÆõŠ_*6+‘…Àc×ôæ¸H~&xzÆc´sÍˆÖ8@+‚qÔ÷ö×bÈB\"‘™@28Ï®\0ëŒuõëYÊ£vMr%­Í_O{q£ÌÚ]°¸¿VI-£l€ÜŒ‚sÆz‘Ú¼òòçâ,vòÈlmì£Œ/¹	Àäàn=>ƒ ®ò=jú8üµ”muVb=¿Â™ªMªj\Z|±¼{£–=¤ÇÎzäûÑ§T	¾çj6ñeÓ ›U*cq\"˜£Qµ‡98Z‚M[Ä\Z”»d×¯ßqÉO´¸VôÆï§nk.Eİ6ä8p9<õë€Zî>ÜiÍ«´Z­²ÜD!Â+/!·\0ä{õµùUì¾ç%„“Å#\\\\Mr\0Üw6Bœ\0çŒúT£7–$HßaMÜ)äœ^ùíë_E[Ç¤I?›i¥AbŞZÇLcÒ¹o\\%øD1À9Aƒ÷›®GA³öšl+;èRğî‹àù¼=g}ªÜÙÇz#Eh¦ºU(Àcy»ã¡ë³Ğ§ğd>dšSZHéÍl…Ï<Œ:p;ö5áz—‡]á,J\0¨òØsÎ9£İüğäR]jé0 •…”ÇMù#ß‘YòsksW.T“G¦GzßKq\r³I(R»AÛ‚\0ôÈïïŞ¬ÂL¬—§ª|Èî<~9ıÿ\0_ğØBÁ—’«¹‹ÌÄ{äg¯¥W—Tğö—>..ôôsóH€8éŸSOÙ»neí#}?ø¡­\\_i6êaF“¦7$ıÖ\'óúş~P×ÉpLÆs³\0tŒzôü…{/Å¯xwYğ|ÖVZ‹_‰RDà’u=q¦¼¢ËM™şÌ\ZErAÎÓÀ‚ã§úU¥dRiêw?\rô_k\ZT²êBO´} ¯–¬Ø(HÈ©9ïü&ºåğ—…â˜ôãrŸÜusÔu9>€~µÆø6Í4ûë°Ó*:òHÏN™Q^…g4rXÄ<Áòå˜À19<õ==c)I=\rM}ãËX-äÛ§#ZÆrª6ÀOÌyèO¿ò¯0Ô¼;qy—’ŒÈA0Áà‘9àÊ½[â4ÒÚjVe-³‘ÖùAQ†\'g¸#ğ&¹y®mšİRòXmäA€ÂqÇ8è·­™ô6\\¶ÜêşøMï<;~$‘IÙbU†İ¥rqÉàôö¯U‹ÂpÛÌíäüÊ\\(äsœÄWÌËãÍF‡Kñ\nÙ£ò*$˜b\0œ/ñéšãâ=Ôp„¸Öµ)İY¡gÚr9,?AØ×Diß[³–º3éÕÑt»)¶Ë\ZaË3“ïÜôÍr›@o‡úšÙI`/Ég’É½À•9É\0şµó÷ü%MòÆnglc0SŒc“îkÖ´¿ƒºuî™c{öÉˆ¸D“lxrA>™#¶y52J›óKDyf›§]MnV6ÜÀŞ	ã¡\'1ı+ªğÎ–,üA	Ê¢I	f\n3Ñ€É?é^—gğ¿EÓ£‹æ™Œ\r€7œsÁ}=}\nëôŸøSì±JVŞ[µYZr\\ÔŸQØuÅd¤§{»Ãs‡ÓVÚ2Şfì¤Œ8QFáïõ¬ˆ¦?³Ä©,şj»®âÍÀÀşd`~\\qé$ÑôÇÓ.í¬mÑÄÉæ$$˜÷.£õ¯?³ü·šïÄ×\0à”Ç‘Kÿ\0OZ¸EnÙzy˜1Í,pwmöE”í*’ÏÈV9ëèOZÅ¸Õ$Ğnî—©ÁÌ\'¸•w.T†œgŸÖ½+Oıšt%YãSÔ\'uÂ…Q\'œ|½Á­»_€¾·„m³v\0Òİ>ìdã¡ü©¿grUç£<ïÃºÇ¼Yk%ÊjãÉ‰š#‰\0À”zZ¶şñf­¿Ï×YĞü§ı*G=°qëŒ÷ëŠôh|a ÚİYéhT$â!#HL„°\'%ºOëUî#¹…\02â6ù€èÆ}1Sí¯¢)S±æz¿Ã±Ûy÷úš¼•FØIlAçĞŒví\\í¿‡¬4×ÀóI&yWuÚxà}Ş ŠõÍKG\\´ÚidX1€W¯2:`š†Ãáæºfy$8(ÓLA,23íÚœª«{Ä(?²y­´¹E·Q·+IrxÎsÓı:?YXÉË•²c\0ìI=¯a‡º»,­m\'Ì˜‘^RUóŒõn£ó¯ñ––`ñ¦–Ñ·•ÅR<vœ‚=q^µ1”gsNVµgM?ÆØÅqéW3„ÎæAÂç\'æê~ê÷Æh§l<1)Ç‹9çœzg§µsz}®çdŒFLjÛĞ†pTœ#Ú¦ox‡M¶şÎ°¶[#:«,‹)\'Œç±>ŸZ|‹ì“Ğ§âc\\ñÓ:Ë£6›?4lrxèHë:Vü!\Z‡üñoûéÆ­Í­xºëæò¥ŒmŞD œp1Ç8è{Ô_Ú%ÿ\0§¯Ïÿ\0­Z¤È¹è¿íÅŸoİ‰b×,ÙÎG\'#¿¿ëXZœ+}¨ÜÅÊÿ\02à±\\“Ï=9=«ªøÓnSÆ×ê9Ë+àp>âŸæ}=>•ÆÈ²ß_½Ì\ZuÓ3€ÛcSÆp1œ	şx§ØÒ£VL…´•PJe7`£9ş¾æ½ŞxJŞ8Ôj“ÌcŠ°b<í¦=»×”C¡ë—Ğüº5ÉÚŒA‘[\'\09?¡ª#ÁÚÑİj\ZP·¶cÌ…È$‘ÜyãÓ°«¶šœò×DÏf‰Ş…]b¾yy\\.¨êvõ<ôõ5ß´H0¾EäÇn>DB8“–«Ìíô«9#ÿ\0E†(åÛ‡V„0ë÷Kc§ZìşÁaÕòë£NCµL-\"ÆvsÇ¹ÀééR¥¹¶V<âÖÆÚîk†‚I\n	U #¨‡äkµĞ´3£¢ŞGÛÇËn¤téÀíŞ»ûŸxsO]±ê:x>S!`1Î1Îzt÷«¿<3´D—æ[ŒàÇLsÙÆ9†³”œ¶/Ec&ßÄšn—æ¥ÍÄVà·ÊÇ!º^}?„zW;ãÏéšœ6BÃP)s;3‚qƒŒu8>½kBê?\rêó½ÅŒÓ¬’´»rrrÄ€>n b´ll|6²®k\ZB7³İMÉäÿ\0¨8üÅBŠZšs=ç\r«Con.ã¼B¿|ÄÙ9øêZæõÛÃ7ú\rİõ³±Îè”.xÆ	ßı=+Öµ¤ğÆµgq`ÓØii¸2ËFqÎHÏü«‘—Á…üÆñ%ÅÆOİXY“÷OŸÊ´ƒKt»Ğá®<C\ZÆCKurêÙÜÇ`Ï üŞİ©mõ¤eHÖŞLT¼ÙÎOîú{×c%§€-X,‹{z€wóœşõíWìáğcL$‡JyP¨šB@lŒ’r1ëíZó¥ĞÁE½ÙèøCáíKÂº^£=£M-Õ¬w¾kÉPJz‘]—„4ycDÓ¢…b]ŒÌİ±IäãÜ×x«ÅWöº¬¶Ö×wV:xXÖh.JÇ\Z„Q´\0zÕÉÍ=ş¡2Àò\\NÍÂ±fcÔ`ŸPJÏÙ¹;¶Z—Cé]{IÑ,´›¨QìínÚ2”€Á±ÁÎ?Ï­y·ü š]Ìë%ÎºåØ`¬K÷úäunã±¬oxoW·³u}&ü§™”>KXu‚¦»›?ŞBÑM%„…Jå(ä’0	ëœtõ¨qPz²ÓmlPµø{áéVyV+»¸B²´ŒÄsœ•<oÓ­`xŸá”^ ·´şÁHt÷Fas-Üì7}Ğ3÷¹Ê•‘ãmÄPêÒÃÔö–N ‹o<ªô9, úù\nç¦ø¬qo÷N69vÈà‚1Û#§½Nî÷5écJoƒÿ\0a¸s{âm>ÒTùˆI¯>£Œ‚9|1ÅoüFäqöp½r}Ïù«Úü=kØÄ²jY¶ÈŠ„c=ÁÏ~Ÿ•vZ?Àİ.êÍf–úùåV*Æ0ª¼gùON#Zóé«\"É;:gƒü¸¶Şİ\0B®Òîq‚6õç±¯Rµñæƒ¡XÅ¦%¥Û-´Ax8\0\r£$ö\\w¬Vøs£è°‹ÎË?/4Ç!A9#ŸÓéW-tß\nIb%Ôî-ğI\Zù†ë\0Ç£»û£™®YÉ^ÏS¢ºº-Kñ\"ÒåJÃa2&AÄ®:`ôëÀ­ø«Î³Üc)#d§‘ŸL×¨x›ÃÌ’y¶Ñl“fSLF{tëPøgÄV>!ñzf‘r³ÜÜÈDPª”)b@èü…U8İíbj>‰»\'ˆßì34»#}»sÀÁ}}Ç½x5ÇÆmzi\n¬PÄÛ”nXÁ<È·>™é^Ùgá-}˜‹¥·X™J°–e1Àî=«Ío¾Ü4Ï%çˆ´è®Øä.z9Ç<úWDyN}YÊŞü\\×R_í\'¶ˆƒş©B¸È gŒŠÊ·ñf³®o1ê·À£a›í,ÎHÀÏ¨#‘Å7\\ğùÓîMˆ¼[”•m¥~\\‘Ó>Ôš—Ÿ1\r!\'ÆX)ÇéŸj\Z®Š×coÃ~$¾ğÜºƒ_4šº\n#/pÅ”ÜóÓ“Ûü+­¶ÖMìK7›\Z.í‡v~P9ã zûUønÃRŞoì%ÔmÌ…Ç ^€ãÃ®GZï¿áĞôûYü%†í’FÜU¹\0ƒ“ÛÓ+ráïu7Ä]ÒAš´e\ná¼¬³x9\0€IÅ,?¼9mo šúâTÙò,våO<à¶ÑÓÜ÷ç°ü,Ë–IüK¦ZÉænU.+ìs÷³ê;gÚ¢o‡:LüCöƒ¸ÅjÁApÙô õª”i½¤\\¢mê´ÈK#[ß<­!Ù#¸i$ƒ‚O$8ô¯HğzYxÇC\ZÂi¶ló†İ%ÀBû#oİì\0êkÎ<;ğ§@ñK¼Pß_\\ı™~fSq;€åê1ßÒ½wÃş\r‹ÂzRé¶wwOj¬ÌÙOS“Î3Œç½cZP‚÷w.rz—L1ÛÇ½mm6(Ù…ˆöëø?1^{!›V¹ûCF‡å.b.Ğ2G^œ´ÏˆZ”º^©¼ZÆÀê\Zà…frsŸL~B¼şAÃ´—~nàvîbwã¯oaß¸¥N3’æ¹%ì—X¸HH üì7mä|¿Âÿ\0¯µsŸÛ—Ş‡şş­gmZê7QCZYb.ÜÄ€H÷5ÕÂâ?ö¿ïâlâ££f<ŞGkñÊÓÈñ¬³±á£Sƒ’ÊObQRiz•¼zMŒåÄ¡° ‘ò1yÏåW¿hkcˆí› 6Ê§=2û}1úV†õû:Í..bKİÛLBc¹†vã¿Aê+TŞ¶F’³‚;H|B#ØÑA,©7}Ğ	ô<ö$•Ï|Gñ×¾¸CoåL¬Œz˜®ozèäÑà¶¶bCd¬«ãüş5w_ñ…mã{»w\"\\„0¢ã½EC”º¨.¬ğM6êôÆÑÃÁ]ã‚8Æ;æ´µkŸ?LEY‘%PY†x\r1×$~UèÑ|UÓî¤6pØNc¹	öñ^½ÿ\0Æº¨şøÉDÒ[(”0{§nù €ØÀ÷µ¢’ºrD»ìlô›Í^DÖyK×s(\'qÆ2XsóŞ»İàÇ‰­î#º¸†HBù³†ê1€Fyô¯hµğç´¶C…ŸŸŸ“ËO4îÀçŒóLñ·ˆ´-GÂÚ­¥ÆÔ%¶‘cÄ$m“nĞ#‚­S¨Ş‘&Énrkà[Ë]íqse\0\\JÌ\\gIéÀwô®_Ç^³×!·êvÎë“åÛ°gäÎqÓ·ÏÏâğ†±\'—â!¸Ş;€NXŒ¹=‡Ë²ğÃ]N§”ÍjŒñ²*—`wd›{`ôö©å¶·2ìb[ü7²eó>ÕpÏUx ã·¸şUv×ÀÚ\\‚XîGp~BÒp}F=Çùæ½\ZÛÁ—–v²F³¡Yï]U²:Û¸½…sÚ•®axa½º1Ì¤);”äg§bä+\'ráNƒ4|işk†ë$xî1»¿Ó½jİ|\ZÂÁ‘5¦Œè~rĞù¥Æ=:ƒïŞ©Øx²ÂŞÂ{£\Z]#E^½:ÿ\0•r][ùói¶:…Ë¨\0lÛ“ÁÀÈşÆ(æ•ìM•«û4½ógRñ+JÊ¸Ó—è\0ãµzƒ~Yø.GjW@Öª8ÀÛØ!^M7Ä²¾Ö…ÃnÜìòàäÇ@qùÔ?ÛŞ$ÔÛı/Nò­$aæIpÇ1®ì“–>œt¥)IèÙI.‡QñóÅš¯WCŸDÔ™\Zv•&\"8Ø|¡Hê¼p[§­xN±ñ;Ä×Ó ŸV»aÂ<íÁÈ<\0;dvï]7¾#iş\r±¸•ÑÄNØY‰ó8É9ìkäßˆŸµk{H =Â­şV^œ‚:dÿ\0/Æ´ŒSİ™»™ªüu¼Òˆ’Kˆµ‘¹¾y®K:qÀÇp=	îk‘Õ?iG#‹Xm¼§ù•¥V%2[89éÈê;W‘ÈŞnN§%³ĞûŸ§O­F¿él„$ô?\"¶öq\Z›HôFøåâ†·Iå\"u;›d`í¿^‡¿Ò¯GûRxâÖÕ-m5%Æ´3œ‘İè:úõ¯-‘¢ìE>X8AÇ×8çğª¿e–mŠ6Øğıj¹\"º™îz¥ûCxÄ—‡V™.’Ù™™Py{÷6YIÏA˜×¢ü;øÛğş]`Eâm;RŠÊHÕ–K{€Í„áƒ\0£rŒuàœŠù”Çäºï ‘Áù€õÆ9şµ2íÀíò°ü?­.XJÛ¨şğÿ\0ÁbÖÎæÁôûä•~W¹¾â€*_†+Ÿ”¨è+¢şÌømáco©Dt{á$	£(:‡}H,+òŸLñ&¡¢Ê\'²¹’İ×¼LAè@#ß“Ú½ƒÁ¿®5½>Ó@Ö]Œ\"ÇqRÅÇÊŠW×\\î¬¥_}¾ÛŸ[ßøóÂSjú¤r«LÁ)bTç!zî;V¡ñ_ÂğÊ¨u*¢˜á#2OQí\\¿ÁÓ$2I©‹RÀFr»w¿§zÒÓşéú¦­´·w.åsû­ Œt9íéX^íse¥r­öµeã×¹±J»z€øÜÇ€	õı+>.lãbU‚g!ß¸$gqŒt®Ò×á•‡…Ì±Ç-Àf\n\ZI$àœ1Ó÷ïEæ›¥Æè‘òäÉ™2A½FOæ*ºÙlC’¶»™~ñ‹mmÌ:‘\räK\'ÉıæÁ*¿0ç‘ùŠÖmGâ¥û:‹D\'¹£Ï\\¯ÔOCø7N»³Y\'±³v./N8åˆöÏ ­&·l6ÌÎ’Ñ‘åµ.*/D%+«·…ü=Õå´ºœ:<:œÑ‰•ö’r-3×5è7Vß\r4;s2ZJ²?}¿œe²z3ZÍ³Ò.nXE%«$Ry€¨KÎ=qİb7Ã›iãšYIİ•ëz‘€;_Z®n²)FíXèt\rO@}qíü<ÖâWD·€ À*Cg‘Ï_Që^ˆÊYB°¶üÙéß¶1œ*ó-Áúg†o<í8¸½‘É!-Èzğ:\nmô^\"vvïœpUW{ÁÉÀİ½kGÚ=\r¯ìõ2~=xz}hé‰lñ£¤nÈF,¤`úœ¦¼o\\+@%ºŠ\r‹óe²I<İöïÅ{$×n¦Í¥İKrË4|óO#¿½A¬øzò-QwÓš)İË`¦T\0O¯|uö5ÑN2ŒTQ„¦›»G˜é^ÓtÛ«{ÙõøÖâŞD\'`9ÚAvş3Û½zü,_ùşµÿ\0¿†¼vŞğ™¥ü¸ÊÁ˜œÓ§^ŸáU¶ÿ\0éŒ™ÿ\0\n¹PrwlŸj—CêÚØı»O›<4L}ÃrOâÕçz™¢-¤Wsy	{r¬ìCnJäg¸Åz¯íû™&wãÎÀ;ìàóïßÖ¼`wÉv\'<c¾Ş”Òm³Uü$}CkäIn„©%Ù_w${û{w®SâÍİ®—eawy\nKÊê®HÊ€1×\0õ÷¬8ş.\\Â°Å›æ+2Œù„Ï?Ã×¯ç]¿ë–«şT«yŠÛHã9ëÈüë4Ü^¦2Ï;µø£Z°òm¤»…{Üô#ÔVFŸ¯k$ñV–z´°ùÎU^Ke\n¼ùˆÈÀïùW`<?o¶Ù#L–*Ğó‘ùöõ¬ûË‹«I&–¶E…YH 0BÙÓ\"µçRé©‡*\'oë‹!ø‰¥=	BÊ­ÀÎïAú\n±‹A\nÛ+4óFÍ¾gÈ\'Àõç¯sØW¿ˆu«Ñ)“T¹,[iÛ!è=nhŞ/¾Òl~Êûœ•oô‡?1NNìî}(Š’İ‰ò½¾íOÙÇÚÍhÜ ÿ\0h€ùWao§Å1Lìüdã‡»b³í|\'5Ô!¤¿ÈëûµÉ\'9à“èk¼]zñívùĞY•ıÔ@gr¯=+:‘æµ˜éµ\Z99-µ’LFğí\\¶Òç*\r£g?Ê³uh´-6àE}Ü„ß¶â3¸g<Œöõ®¼mªIË_;Ä®Ê6Æ pHÆvôé\\Ä([^Ò.o}Ac\n²>wm\rÈ\0vnõÌ£g«-´öF„~,Ò-•E»ïÛıØÈ‡¶1€jô?´Í>9[\\K	É;Pœ÷ê}‡zğtİpLAiãGCĞõÓÔÒÂ«]‡–ic¶‰zÜ\\9u\'\n	î;WG³]Y*ï¡ë¾\"øÔ%×KÇ!1“$Àª‚G\0ñóÖ¼ËÇî`±–Ú;hÑæ]Œ37?Å;ŸNõ“yx4¿\r¥¤Œ—\";‰nãÜî€Ts”=Gzò­^IõË©îã\0>ÆRpª8Ü!Ğõ­!F2w\'™£ñ–½¨x“V{Ëû£;¡À$/Àáü«´Ù-íşÔèDSd,’3É/©É­›9ä,c0–*ÎO ËçĞŞ••wÈ¦/3!ËcÆN{WM’è-YNO*åÁàœ\0:÷ãéĞS~Ï˜ĞE–\';S$÷~½\r9­Yc$cÔìRF:uÏøô£tê ¬kÈÉã¿¿OÎ³rKrÔ]´!û×R<“·Î:m\\Oş¸©$‰¢„Ç*Œ?Ÿ¯ÅC5åÁS‚û˜ıÑ‚:uÿ\0õZ=7W™wGÒó´gê1ëQíSEú\r’ÄùaŠ:pFF=ñìzõZK-²:ıÓÆCÈé¥hCkª/ÊĞHr9aëôÛ6m¨|·(F~ï<éõ¤ªEõ¥.ÆWÍğŒtäqÛ4–ò˜ßpÜ¤ğp;{¨ô«ÆF;!Áä½sÍM&$P‚TçÔsş{÷íO’G§ü)øÙ¨ø>Hì\'i°vë\\‚€õlçÓÖ¾³ÒtÛ¯Agxú\\ò\rt»8BJğsÈ½ëóüÙÍj£|gÈıF*ú·öWø¡›-/õ=—öò\"7{˜0+´Ùà€[òïÛ)F?C¼¶g°Ãğ®$¾ñÒ»6[îA%½»O­cxûá>›á.í¯î®îaFÅ\0U(NâBöÀüëÓu$pÇqowo)uQIür¾{ûTÖº^<ğ¼O¨LL±-¸‚¬@9 ûğOsY{I-X(¦|İ¦İO¡ï¹µºhä8\'iëÛ¦\0ê*¾©ñÄ+q³ûBG*¾^(\0qÉã¨öö¯¢føMáÈ£Ù5´·\nËÆfN„6s‘Øw©­~ø=rbĞa|üÍç3LTú\rÄúÔûdä®héİi¡ÍZ›«Í2ÇQä1\\[Á,‘Ê¦cRHèIõõ­it»u…$EGb®å8 =;sëZòØÁcD¸··ËİYUUF@P½N˜íô¨&•ª§úÀ­ˆÕ‰ùˆÈ<gòÜ¹d“Øà¼“³4<:]í&P!“-¹NwmPFAéÀü«M\ZêK­Ò\\©‘FjŒ¡çÔú×–x–O[jHt{9¥·tE1dwÎ<úW8Ò|a‘g>sÛÚƒ\0záAn¾•Ï(I»Üí‹\\ºßyu$yi%“©%sßïŸzç|Eoi¬hw‹m4ŠşK¬Ÿ;\0Ù\\cäc9şµó¬Ú§‰u=“ËâÒäŸùg,ùàŒlüÍcêW·3a.<E{4L»›Ëg— Xq×µ\n“şa]v(Åá=kX™-Bd|»G¡9æ¦ÿ\0…SâOùò³ÿ\0À£]¦‡ã-6mJ[xîå‘#S,j Àpç¹§¥z·ü!pÏÅ¯ıòøªÒUy]®gË\'Ğì¿h+V“Ãràe\'#¶âJ“ùqü«Äü=¢ÿ\0iXÉ#¨ù_’Í´òÜ?•{çÇ(\rF\nØ\n[hìUÀÇâZğŸøhö·	:+û¾vùGú=Í)_šÈè‡ğ»Gğo™õ·‡å\\“ƒÉÇĞƒèz×:Ş.‘£(\"d¼w9ÈÏ¸=x>ÿ\0wŞ×`ñMÃÚÙÜÚ¤Ş^ãDåÉî[õúRÿ\0Â§ÓÖfi.fyFNUTqĞâ³K_y&­¡ÁŞxÒ&i£µ·Ôï¾c‚r¯ ôíPjß5+«9l\nZF“@<ÕT!¶²‚@;û‚zúŠôkŸ†ºdX‡dÒ¹*ÄÔdçÕã´¦±ñ¥í­œS<j±*mË1QaG‚·Š‹9›ó(A—ºe$c¢îÀíŸÈõ5ô>ğÚÓQĞtËïì{yÖÉ.ùŠÅ1lĞ‘Ûÿ\0Õó¯‡õ%i×“ÈGÊ‚İòH8$œtÁ}3á\Zk0ø_K°şÍòHã&E`ÙTç#§$wô§4ÚI2“Ilu\Z…dcäË³•8Ûrızu\0ŸÎ·ağ‰€’Ÿeœ±“Ğc§áŞ¸«ê:\\ñı¦K8ä¾`Uø›»AT¦øÁlÕD$R2Àœs…şÅs{2£&eëÚy±Õ¯\"Ş\0I™‰\\¯SœŸLtö¨Ùàš6³{ÈQæS(eİÉãŒõô®Åz‡‰µ«»·¼‹†ÏµƒŒ(\n@ÙíëØ×-gªÙh·qÌ³Ë8·‘dGX€-†‘‚@ı%ìù–{;ßqğïHK€ÑOs$)ÏÎêAaÎ~ï@qùVG|gƒuG·…ÂCæ	7gbİº`ŸÀVTŸ´¸Ô˜ì.Ì‡î¤¥Wå#9ëÜş†±u¯É«iwvH(·<M\'Ú6•¥FÓÛÖ”iÎêâ”—CÅõ‰\'ºÓ^0|ª¸)¾™íX3ÙÛ[Ú™<±rW–‹\r œƒüzúô­ík\n¤ZE&de	pí¸œñÓ8íë[:_ÃİFòĞİK\ZÇla.«Éß…bõG÷kÕƒTãª3ä•I$!Ölæ¼··ŠŞİÔ°ù£*zzã×éPéßu)­Zf·`	ãp\n×ğ\"¾°ø{ğ²ûÛÈÍÍÄI;nQÔ€H#şUëğ¬`¼T{‹HÁë‚ vàê\0ÿ\0<W‰_%\'Ê¡¡‹ŠægÁšÁık\\íµ‘¢\\íUÈpsŸoç]Îû0_İ*›§HÁ*Xozvâ¾È‹ÀğZa\\ş•~Gh§Jğ+cë6ì{4ğ4£•¬dÛTŞÎÜò¤Œr99ëŸóŠô\rüÒt[5Œ@§oBÊIã=ş¾õíÿ\0Ù±F{p)$· _~Ø®O¬Õ–›}ZšÙ3­| Ğî ukÈö9Æ9ãÚ¼ËÄ¿íR9ŞØH9ÚY˜0ôÇãêkê‹«5`NÏÀóíX7šJ³n*¤±ÌÛØÁ­QòŸ…ˆyYCî\0ìe¨Æzú¥gÏğ¥7<B\"xù_oõõÍ}W©i;WŒqş^+œ¼ÑãW\0t<g¶3ú×Lqs{³™áa}òÏŒ¾Åk Èò\0’GÂñúş#?¥y×ƒ|Kwà¿Zj6±º6:R§\0©R9gµ}uâïÛ_Y:º)!r”`pH?+ä?XZâ!Â,½Ïn=Å{ø\ZÎ¢³>0 ©»£ïßIoâ¯Ûj¡Zs4jÄÂÊt<|İÁıkÊu?‰(Ğõ+½:ÓP{KHg$q(*2Äõúşõ\'ìçãhî¼‘„]KùdI3ã+Ÿ”c;J“œ÷õãÑ¥×\\n[\r>%‘ÙËG\0²‹Ÿ\\şf½{ûÈñô[O}ãßkSı£pò6B œ”g«¾Æ¢ó<ytÌ‘vO4nØ¦P¸Ç@=8üëİtıvïnØå·¶9ùR×9$1ÜtíÚªÉ«ks^f)îœŒÅïé…õÇâEUü…~çš|;ÒüCcâ-2{›;Ä‡í‰~Ó»„,\'\'9äõ«Öãøƒ£]¶ôùJÄŸ‘ˆ\\uãÈúUxãÕï¤ŠYMÔjdüÆÛ»•÷\0vï^YoáfÑnKVI÷–Vf\\ŒÆsßßÖ¥´JOcÖ®~+hvò;ù³Hq´ˆb\'p0O·¡ş•{Aø‘g®ÛÜA§Àä+lv“	÷!=Áí^\'\'†u9¥5¶×Ú$2€İyëê?Zêş}»Á¿Úfâ+yÒ`…d†İùíÉ%‡ìkš¤¬®™×ßKÛám½å¼3¥®ÌFì˜!”€@ëƒùÖ>­á»-á-ç¹°·DÊÍ&~SÊ‚z‘ÓÔVÆ¥âiáŞ[`·½#Œ–*=û\Z£}áuø«qO~¶1XÂÎÑÆ<âw )¦¦œ›~ó*I$siƒjÁß]´.­‘)¸‚;z{~ÿ\0ğ°¬?è2¿÷Áÿ\0\ZÏöw°û@S¬\\JaµTF~¸;¸ü}*Çü3•ÿ\0?\Z‡ıÿ\0‹ÿ\0ˆ®ÏgNZœœÌúâí¨—À÷ÌÉ¿ÊhØt%€ÏOö_S_%Ii<*Er8ëænêOç§^µöÅHÄŞÕBıÆU9ÉÉÃ)\'¯o¯¥|¥ı—u<¦yÇ!‰pzäLõµ¢øÍiÙÑw:ÿ\0„1Mo®Kq40‚-ˆS08Ü£ÏLzúzW­My6é+M–èÇÌ$t9$gŒØu5àö>:¼L\Z$ÀÜ»a%»£¶	üë@ø³ÄşR?ökª‚v¿ÙØ’p:vô5)9;ÜÊ3ŠV=BèÕšGœÈ½çltÇLôëZqëI4SÜF°D¸Vb™y\'cùšò¼]ãY­cÚ602ÀÂªx\'¡#§ù÷¨\'Õµ„_³jZ’Ú<Œ†HdeåHdÓùQ\Z]nc)yÇª|HğÕœ%áÕ¢;WåU³Î\0ÇQ‘œZ¥oñÃ–k‰gšOâ8XNr:^°›¹<…Úc#$;zrNGnæ»\rüÖuı=/êÂŞÙ‹šF,0HÉ{ë”8Çv“z#¹×¼E¥x¢î	šÎIÑC ó0£’£‘ŸoåPiğøv-‡o\n3ª4“±(¹9,Lö5¥aàÕÓíáû^µ§G±°7IqÉtÈªº¥®‹q§ÜØ7‰lH*T*Ê»œ•$ªüÜ’r8ë&Òz\Z¤ì“	5Ï\néóÇI¢Ç…!š2¬A9ú˜Ïzà¥ğŸ#ˆùş+’y·eÄv®FŞ2<õÇ­Uµømc$’™eœ.ìf0¿2G8îOçš¶¿tø§A2İ¬ÊHÎAÇP9äúVz\'tËåmæ±ø{nèSP¿¹AÉÂ’[#“÷Gÿ\0Z“ş(I6Ú]ì¤);¤€ÜôáıûzWaáß†>¾bÓÚı¤ePf‘z;¹\Zê¡ø[¢iöwG¥ÛªÌ|×fşàd‘Vä®µ2Hùfuë^”AÈÕÛÊ\'7aN}Hõ¯³~øÃTğ]±¹e>YR2HÃqÇàOQ_#ê\Z`Å×©ò“íR$j¿À œøzzŠûWàÔÆ?ÚBìÀ*½3ƒíŠê¨ıÔuáV·±½máÛ.×Ë‚İ\"U@sÇNœv¦É\nIÀÇ`qZ—Ÿ¼Î8š#eoQœõâ¾ûKAw)Ín¸ãüóYÓF7pkfxØd~µFH×5àÕÜõ¡±“4}péùÔoíÈõ9üëcìùê8¨ßv0¿JÅwE7ĞÁ¸•xôÉïøV]Ñ<çù{W[-‹°Æ3ø*ÂÔtÒ½»ñüÿ\0ÏÖ“O¡QÔão¡ÜÇ?–yÿ\0ë\ZÅ¾„r?Jë/´òsàu¬\rBÔª}3şzÕEÎ3\\·-‘ÈÆ?Jùâ¶“ö=fw^¹;H#OËõ¯±5?¸ão^Şµó÷Æá~×Áó8=\'?OĞW»€—,õ<\\Â<Ğº4?dğ·ĞŞÛÉY@Rà¯\'#Iô~¦¾—ûÌH…<Ì\n¨çŞü¢¾9ø#y­i·ú‚é+1~cŞO\'Û¨Áéï^å¥Øøç^»´Š85y-LŠ&‘mä\n7-¸Øc¯¥{’¦å&Ó>g6µdğÊ¬‹w*È•XÊ’vÇO”ô«’^\'Úãˆ8%]ƒr:ğOáÛÖ³m~ê³6ù<ÇNß%­Y$`ŒŸ¼\0êG­EÁ™ãš_ÜêÛ–‘¥ˆGC–Ï>ã½eËæ\rõ9İ{_¾]bæİn^;Nª±Hí\0qŸÎ’;>U.ó¨Ã+9\'=Ï¸=½jÎ­ğÇt¿Ù\'N¶´v©º”:õÉéí\\Å×ƒü^í‰ïm#•oXØã§$ü¹äç{ŠÛÙßbcQDëtû½>ù¶VYY<°ŞIvp2B\0ş½+#Ç»ÕílHÓXÊdaqû¯(”\0I>ÿ\0ÖªøIÕ´ßiÏwy$ğ4ø0ÆŸ.à¬,}	íé^å&é¼£\nóá•xè2@çĞwö¬İ7ií/±óˆ¼+©xKûQ·x­’A\Zˆv®IàÇ#ƒÛÒ“À_áğ¦£swuÍÍµÄ\rBªÈe!#€ïÜ×·|NĞÓ^Òà°O\"&›åu^yÁ¯7o…:zóöË™<¶Ú ó“~ÕŸ2Jì×Y¡/¾8éK\'›g¥Ş,øÁ2²¨Îxş#Á¦ÿ\0ÃD/üú·ıô+Jßàş”Ö]JÓNU°\\`)\\ç§\'Ò²¿áOé_óÑïşÊµS‰—*ì}3ã%I¼-ª&ÂÍöY\0;€q±ŸÇó7öÃâIÓ`ó\Z&_˜ıâYIıíŞ¾¥ñ%´—š£VKy#R¬AåH½}«ãi­î.5‚¶Ìşs1‡*~éÎ:u®¹i!PÖ\'»èo…rJ¼©Ï\\dcòÏåU¼Sk+ZíFád…Éà8çß¿¥y,~Öî¤HÂ‚feËM7œ>£ŸOş¿¬øCÂş\'Òt»}9î¬£‚=Àó¸ä±9\'nz‘Ş¢¦»35\r4Õ‚ĞË,ªTÏSÎp;ñÒ»èş—KYõ&Ñïmgº€<¬ˆ\\äuÀöÅKgàı~mÎú”qç£FÄ9G^\Z‹ZøK«É²xêÑ@eƒ ’3’9ãÆ³ö¹2’ênØ¿ƒí\ZßIµ‚E\\®,B•À íè3Ú´á5Ñô¤DŠÁËà˜Ñ\"@©Æ}s^B¾xŠvöåöU”àtårÇ;ûTñi0øud‚ŞVI¾mÒ0lm9<Ô‚*7{“¶¨ä<[áOZñ&µ¨Ú˜ÖÚæâIR9w6@#ï\rü1Ônî­®…Õº¤rnV›î“‚A¾‡°®îİ¤…°ÊpK&8\rŒuí;ö­éÉ6’‡Â¼€ª±òAü‡j¹ÍÅh3Ü‚ËÀóÃ*Ooz§iù\Z8²£# ?‡§jËñ’šB·\\´q»aßË$ŒÎ3×>İë·{;„]¶âø&rB\nƒ€2@î9ıj½å­¬ókåÀ¸òã’æ}Ãbò2=sùšãRmìiªêr\Z>³¤éè±[^Ï!Ë`Á\'9#>¼ŸÖ¶æñœ0˜ü»ËÈvÑBƒsd`\0OCÿ\0	>fÇÈhòË¹6ÆF=q½{÷«úwì,çGtg`q·h?.29ÆJ·½ìEº\r®ÛÅqñ˜lç²²™ÖHâ¹M®0Ç®Aı?°<¦ÿ\0fxvÎ2¼ì  äLJùÇÆ\ZÅ·Š>5øqí d_.)°1={î_È×ÖVp£>Ê :qùWEMb‘Û…Ñ\\kDp†=:TÉÉÏjãş/|`Ò~ÙˆŞu{†0q·§õ9=+Æö¯Ó®‘¢‹¾IéLzúsÍy•éI¯uÅ\Zñ_ôdò)8æª2®z×Î×Ÿµv“ö˜Æ&Ú¬Ì ó.AÉÏİİÔzW¥xOâ¦—âë´[]ÆIÁÙ¸23‚3Ôñí^\rl=HêÑìQ¯	és¾U¥(Û»Ú²#Ö“ÁíM›X\n¹-ÄW\"vÒÇSõFÅÄÑ¢œœöíX\ZÜmŸ˜û×9â/XéÉ-ÍÊD‰Ë8úÿ\0ŸqŞ¾zø‘ûWYéï=¦‘º[…fRB\0\'‡ŞµÕNŒë;$rT­\n+Sè›™!9>bôÇ¯Nx¯6ño4]*f‹í±M9òãpİO×Øşuò¼?¼oã›Ém,d¹3…¹ÆIÇ¨õü:c~ßàŸˆ¢µ{»»Ñä¼³nA ““rI?‰®èàáOãgŸ,\\çğ#Û©g¯Y‹‹IÒE?ysóî;sú\\/tÑ¬xgP¶òÃÈÑ³\'ÌÜGê?Zóí7ÁŞ#ğÕ×œ.]¯’ğ·çÿ\0Wzô&òMGLY\'\\K¬=àŒ~•¬iªrN$JrœZ‘“ûé7š§ˆ<OöUSåÁ\nÉ¹€%ˆ˜ÿ\09¯¯//¥øwáıWRÄP*²Ç\rÍÎÜ:ò;ú×Åÿ\0ì¤ğ¿Š¼\\ñÈĞÅÈ¦&\'˜€}°æ+èıOOŠ;tx‚¹a„A^AÁÓìBJrĞùúÔ4¤ÂÚ‚Ú >Ïá›Ë©»bPƒœ…n£Ú¥¶øí¯jCÏ·ğœàm#lÉÂ†ù:‘µÉÉtº<2¤ˆï#I«ÚsÁÈç¯oJ³Ä(-¡Š¬åyŞE’]ÓU\nA\0½IÊ›–º\"#ÕŞÆ†¡ñ—Ç)/ÚÄN@Fà…ã‘ƒÖ¹½Zj÷Ïök4ˆIªdsÓ$ô5¡â¶½ó/â·™#c·ìñ9f+3œqÔö¨®ş8ŞÚXµ¼zDq	ı`¸mçA$/N;ôã)öİjhxcCñ£êš}Ö¤‘x¥YK\"ü€ç\0Ôÿ\0Q^™y­<6jc`7±PÅsÆ2s>ğíÚ¼ÃÂ?u?]Ihút:GæFcGpØÀ#¯Q‘Û±ü:Iµ«‹©SÍİù‹*ÂHÇ±Î:ûÔ9Nö‘|‘µÑ·ã=;TÖ´ÛKGX§¸e1O$Íû¶!ƒÁıkÊ?áQxÚRÌL™Y¥`£È<sÇ¯zïf½Ö¼²‰swåÜ¡aQœué×¿zöÛ_ºS¶kƒd2†ÆĞğäsôî×Ahº	¯Xëv—rYKâ+‹¯-Ù\Z=ÍĞ7ú{Ööïüÿ\0Mÿ\0}šè<[$‹©Oo<¬\'†VGY_©?{ñŠÅÚ«ù-tz’“gèuÖ^\r´|¸ÚÃÎz~Ê¾*»Õ.,õğm#YçWù.AÇ_SØö¯µ&Ïw``qĞöÆHõã½|sâ˜OñÄ‘Cò´w\\`Õd88Ær@?•i-Óa‡vRE¸~(xã¥¤eNa³ôÎü÷şu©ÿ\0kÅ»Ç=¬r1Î×ø@è8==ı«‚“|ÓH»³µ±ór3œç ÿ\0Jë¼k¦ê\Z€P™£ãn­ÆO¯çZ>T¶2ÕèËüXñ³HìÚÈHÕC(H£nO\'äõõ=¨“â—Œ&TGÖ§rÀîÚª˜÷2Ş»ˆüái\\mó¯WË0aìFÅüL‡MğÓiÑéQùÜ	‡VaÁ^íì•e§¥ŒåÔçn5+ë»§yon>a»\r+`dg× ÉÇJÑĞõÉ´6’â)\ZA\"ìÎA¹Ç¦O\\×+qqæ\\#<ƒÏ€ÇlÚ½¿à×…bñ‡y ³´ºÜybyÀ$€‹€>SÇ==ê¤ÔUìB‹oVix6ÁüI¤Ã}uq0y\Z@Y7(b8Éè@kĞ´“¡Ú%•¶¥ˆ\'æòØä’I¤Òi¾:n¥¶Íßv5Ê¯9ÈúşuÓZø}ãÂ‹‹tş#¶ÿ\0íw5Ë*ô5ŒWs˜¸ñì2y)ªÉ(Ù’Â5\'9Á*õ5‹ªŞVÔZÜM=Ï\0¬nîFìc8Ï¡ıkSâe°µ“NßqYvìQ‚¤óô#¿­r0ë6«»ûJÙeåòÓ‡×ĞšÆït‡Êxî½¤êÿ\0Ú×+Dk+„]Ê7œ1ß¯¡¢OøƒP›t[Îİ¸>zÆ2\0ûİ\nöx</¥kVi~&šYç‘›lr)‹hvƒ×œ‡½jYxONø	ù»±\'ƒÎO¯N¾µ§¶Óa¸jyÿ\0†>ßx_Å½Ô;™î/dVX2Â\"¤Ôƒéü5ô†¹¬?MšH%Û8ş,qıkÈ5mJâ/‰° ›O´C2pnRß\\9éì+Ö5?Ï´ ¿çóçô¬å[š<İnof’ï©ó­à;ojóê^!›}±f1G×<õuô÷®ORø[ğî×Îº{£‚D‹+àN@ÆF?C^ã‡^\"ñeñK9’Î(Ã2¼§¾8*3÷†?ˆ`u¬?|Ñ¼YàKù,¤¹¿ñd{$X5[¿F²ÑÂ€Ê[î€ËœcWÍQó9YQ§(Üù·Æğçoë’JXá’c¹N1Àã¯Zæ|3£ë:mòMaxÀô&7 qÓOzôŸ‡µŸüEÒ\"ñ.™&¢i[ØZÌ®6 ‘ÜAl’İ›ÌsÏ_MÖş\rÚYërÉá‹+À‡î¦PŒ¯Ê0<\rİAü:ÑZQ¦¹T®UûGª±¥ğ—Äš”š\\p_ÊÒÈƒ\0³n8Ï\\ã­wºÕäÿ\0cs\Zç™Î¹èÑi÷I)`0ƒ×¸üë´Õ#Ùbùî3şós’æºGĞÆ›åVgÍ¿å¼ÔEV|±Æz{ãÄ÷ä–\rÅ×Ú%§,ÜK2\0O=}!­iñÜjcÍMÊ­Î0k¡Ñ<.šmËjV·‚‹„\n¨°Æâ$\'pU,	Æ@è}kÒ£^ÊÈó*ÑRzî|ïªI¨ü3Õ#Òï­…h«\rÄ³Kµ¦0»Zƒ ‘€å2F29ÂxPñwÄØu[ËU´’+RşcM	ubİs`£¨ş!_LüBÒ4ï‰Z}§ˆôÛkùmX´7YŠh³ÆÕ`ØÁô ‡µghú-¯…<,|?¢ZÇ¥éÅ™™bÚRG,ÎÙlğ\'¥w:Ôy5Üâ²—‘óÆ¬k­KmuĞ¢ÈWÉ,%AŒƒ‡ô\'×Ö½N\r$Cf[n.xü}«r/	Åö‚é¦:|£\'ÔŸ­hßX46ÿ\0wŒwâ¸eU6¬v{7k3Éü9¢ÇuâÁ#4Bo³ÊÅx€ãğüëêÈü%\Z]½¼is!Š5_™-´c#§ƒ½xn‹§EõİÒª‰ö¢³q’sØ’\ZõÏ|_	øvÎâ[!{!†2Ûf ò9$mëÓzïÃ·)èyxèÚœRÖÅY|#m&§:]ÚHî¥dE“9{ô<şµ+i:e¶\"K¶@‹û\\G¾?Ÿ¥y®±ûHOy\'ÚãÑ1ò¬`4˜ùA$É¬[ãÖ±æ]678ŞH¸è3ü«¶Tæİîy*K–ÍÅ³é·LH³‰•ƒôÃté\\šh¸µD³ıácÑ‘±†r1õÈ?ˆÅdêß5?ãíÖv³¼ˆÕÕÂ‚pïĞöZì>ø~Aªô{YmJ‘öRT:°8È ó•=ı*ùyUî$úØÊø}¬iş	ÖäŸP™­ ’‰¤\0’rÈØ$àÛü+ĞæøÁàõ·\"+òW%ãÁà€6õ£Vøqá€ïÅ”³‚@¦`2A# ½ÿ\0\n]?áw†Î‰nc+yÌÍÛ\0r{ëV¤·\"I˜·ß<6ûÒy,Š1º4\0õ<à·ùÍWoÚDÓãÚjE‚í¨§‡şÇ·zo¾Ù¶¡\0Óm¬l+oÄ@c‘ŒuÉõï\\Ìæ…ŸÌÖKrÇhR ‚F}3Û¿z¾dìgkXãµ«Ëø’÷UDxåŒ[àrdg®sÓĞ{Òÿ\0fÃıÓÿ\0ÿ\0ñ5ÖÂòy¯/‰Ôl•\rÏ9wCƒĞzt©á_ZĞÃ\'ä?Æ¢Ub™¼[±öLÀI`cPpNß|‡ñá´¯ˆWód!úI\0?òÓp?äw¯¯\r§Aä‘ëÁã?Jù/ãe–Ïj)Çï1İ‚UI#>¤šè–èœ6ìãö­ö¡¨][¶aiYÒ2>b[úóšé´?*+Û}Ï\Z‘ó;FzóşqIağ×T˜D$¾·…˜\r»\0ŒaÓúVô?/&_)ü@Èì3·i sÁÎîütõúV’×©·:í\'R…©|n\\îä@â;×ñ’Æ+½7J–Õ~Ô|Öd@ÊAuÉ\'Ü•ÇãU<Ià»¬ÿ\0kËt“|¸9S;¿½Ğçô¨#Ôúİ•®$€“·tRÜ€N€õô®}#+£Fù•¬pú†uI¤ß°E%±m&9=IÇN_zö?ƒºÇ‰<3i©Û.æ™ãe3[¾7ƒê3ßªOxÛMğ>›wm|×.óH^\'D·‚wzßµ\\¼øÛ£#ÅµşŞGİB©ûİO¦9ÍSœŸC+êwË¯xËó6GœÁsÆ9éÏ<úVlß…¬(&ÔeYœà·^xë?¯zÇÒ~<iºÖØ Ó®\Z}›‰fP11O<Ö«ÚêZqaÑmåä¯ÎªÄñœ“·®qÚ¡Şú¡Åhõ3~!xæ5ªOzÌ bx¸v;Ã5çÒZØÂÒ\\	Ü@‡,¼1ÆAùzv=ëØáñF‡¥´‚èiúo–ØdŒ†n0ìsÒ°uÏø;Å–1ÚêÚ×Ùã†_5M«†<c“´äôÇaY]§¢Ğ¥f¬Ì¯üZÓü7£Ûékq<°»ï|*†Ë=7§µj\\|~†7gÑŞPp~iƒ¯ŸÊ°.t†v³;G¬êW$®cù\0*9Áû€g¥?Oµø|&,z„¡˜öôNsè+KCt‰÷¶g x7\\âV»¦_-ªY\\ÙO‘7îİËw.ŞGqë_DÇh·j{İ«À¾Ûèë-\"ÚH|Â»dgfUƒA=HSÓµô•À	şëiE3Ş§RU#Õ—Új\"9¡í\\ˆ4™.¤ù¢ôä;çü\rzF£0`H#×Ú¹Ëµ,İ=ëÃ¯Yü(öèÓ{¾§›ÉáçYŸ“Œg©äò>ŸáVáÓZ%ÄHA=[œı:ë\ZÄ;|ÃJµœ(r©JN×;œb•Ú9]Âf97²åØäõÍK¯X˜­å\0NµŞiJ±ÂeÆv×7â&Ş$8àş}zVµ¨ÆO©4ê96º+wd‚è–\\8­&‡W®:ã“ÓÚ—ÄP˜·¡Æx£A¾I¤	»+™]j‹’W7~ÎÒ™sÆ3ŒŸóô§Ç¦+•çß­kH7(n½©Ò§Ìú“ÊŞ†<šxU<qÒ°õÈÖ8›qÓÓüôô®–òèF¸®KÄw‹å~=*éİÉ6eR6W8«{¶ŠòX‡R“ìrOåšÍ¼ğï„­µ}w®Ï$ŒÌÓ@±«xocıjÒ[Ksy)ˆd¨İß¿z’o‡º<öæêá®\ZâMÛ•_åV$€øê}kİÃ4¦õ<b|‰˜—Màg9ÔïdVÂùIŒv_—¿×µ?ûSáü€Í¨\\\r»&Ñ1ØôÆ;UKÿ\0éÆá-¤qFã3n-“œö>ƒµ^‡À:Ø”Ú3(X, ‡$·;¦½KÄñl÷ñGÃ«\\¦•~™\rÆq‘æu?J¨Ş6³ÆæëÂ‰u¢âh£˜ùŒYÃ,„ƒĞïê*ûøL×5k=;G†Ö¹K¬MpXÇò©bó‘…?ÃØVí·ìÿ\0âÃk%³Şhv–™İºJ@Â–\"!ÈÉïÜÓ‚¦¤·&¬y~­ãMvâ1<šµÛ„l°i‰=AëN†³!ñ6· Ş5[ÆFà£\\³\r¸hç¡Àí^×£şÍú…¬OÍşŸ,%±´[3‚»@AÏjõ/\0é¶–ğÇg¦i–±KMº©ÜF	q©ª”â¾$ŸV|ş¬óc|î;aY³Œß=1)ê°¬W%e`ûˆÌ1´ğO¾yïŞ—_øõ.“¨Şi±èv)-¼®Ÿ¾İó2“œñÓ\0öõ®u¾;k·WâÏND<(ò™Š¨ àŞ„÷õ¨åŸT\Zw(êß¼[y	·1Àˆ¦5òírB€c®GáXğœøÓşxİÿ\0à\"ñ5Ù}£í$’d•D¿\'=FIÏ<ç¯ ©üû_ïÏùKş4ù—aéÜû]‰\n¯$•9õä}+åoù~=»*pP©Ür?v ŸÈ\Zúœ*“_¯\\~Uóoí¢/[8Lî´R0IÜÃŸ@½«zˆ0ÏßhA¿Õ.lí4b\n©\råç9ÆpqéÌVıŒ÷òH€=Äs–)UuÁóÇ×šá¼âíRyl4ÿ\0ìá aÛ$€Ç­z¥¾,ÒÛO¿{ïî˜É<û`v¬$ä¶*I)o<\'¯x‹K¶ò£VòæYÍ™S±œç9\"¹y¾ëz‹>¥{ä›KS‡DĞe±·“Èïßğ¯@ñ×ˆ5ÍX‚ÓKXf\r†Aœ–*W9è1ßÖ³´=sÅójVjVĞ¥œR	@Bv‚O=péJ*¥µ&R…ô<ŞóWMZ(+™cS»œç8úùV§…üwâË‹kuYofF·}£<õúâ¾‡oˆ\Z]» \r„0fUÛÎ	7RHüêHş\'èèŞZÍl¯ü-%ÌkH¯±íŞ´SiY#ny½—Á[ù·÷¾#cUPehB$|äÛñØuş£5×…ôÕw_[I‚¬¬Šw0 `c?Òµ|}ãüuà{½*+af—b6I™òF\\äÜÓÒ¼u¾\\}ªÚÔ6y£\n|–n Ÿ^Ø==©[™^OQ§©Ñø£Oğß‹.¡–Âı¯äEö*g‘“¯~ÕZßáÎ•äÇ/•+aO™ºBF\0’;ç?tø_—\rÜo«oy°Iò‚‘†À\0äòCwô®©¼$\Z{Dei-Õ„Œ¬y\0vïÕÏ\'Êí\\mÕ{¦øD“m»	|Ìæ¿+œtÏ9üëÒ4?…¾(?²‘ÊœîyqÇ?Şé“Ú¹EÔ4k=BD»iEÜo•\n¹Vóü«®ÓüQi}3¨ùqŒm#Ôı9ªw²%Úúo‡ü3g¥ëH¶šm¼Gnòñ @öïõõ®í¤e„u¯#O‰¢\\	¿²u;ÙdÊf\0ÀÈ>ø\'¿Q^§op.ìã™s¶E3@###±æ¹ê_”õprZ\roŞulgüâ«OVÅXl*óò•Jyù9?x5­±õ4ÈŞ=«øÿ\0\"²®®·ß[Z† Ï Pqœ¤ş\0\Z»5ÖàTtõ®_Ä‡Oh¯„m\'û˜/P¤N1Øş®(;I\\ìŞ,ô5¼´µÿ\0EIC_=p+R³h_, à“ïÒ¼+Çÿ\05{_iĞè±ÛÏ¶é¦•\\ª®>è\0ğHÏ\'Ú»¼p×6\"UÈB¹ëÊät?şºô«^ªG%8ªwlÍñÅöÏ\'p,N1ßoÆ¹™ 6ÑK<?Ì3ëÿ\0ë®#ÅwŞ\'º×£ÕôİF;+hN>Ë5·˜²àõcœı=\nët}høªâ$X$‹fÛ‘•G#$rzô®wO‘nZ—1ëZ\\û¡o$JuçËÏéøU}1V(BtãÃÿ\0ÕN¿¸ERY°½I5Í~ÆÉisU‘†zóõ®\']¸äÓ•§õÖêW+*îS½È+ĞŒp~˜®Vbd~¼WM%­ÎZîÈ©¤Ìa¾?½Ø¤`£$ò>€õëNûWkb4\\±?{$ÏàüëˆÖ/ï,6=¶ñ¹Æí©œŒô\'Ô‚:zÖtÍ­NÆ8­î×™<¸™‡ƒNZúJ4¢£Ì÷>GZrŸ\";Y-5IÊİß­¥¼8&5ˆ1|äO±Ê›vúbÃ‰5k¢3‰T!@\0«Ó#ùWªi>ğäöplÓ­X¨V‘Êo\'€0xèsüûÔ×Ú?‡l•Øhöî;GÙT\0.2IõïSí;;¥fÏ!ÓõÏèúµƒØ^Oöˆşr£” »èOSé[W¿¢i›]]Áä7ß·>\0\0üÇ×ÔW£ZÚèóF’I¥ÛÄM¶áyà8èF:zV‰u=C„ß´Î#G¶ÆO|ğ3“j¸¾mlEõĞä—ãá’0ÑI|êXƒ½b]ß(<m^¸\'ò~ßÇš¶©o-ÒÏq¹‘V(¼ÎrUy-èO·zåµ?ŠÚ\Zİ3+Ìãï\0s1ÈÆN;T6šÅ¯‰–K„œÁn²‚ñÌß7İv3ĞñùV±¿aOmZo\réš•ÕÅä¶ÑIs+3;»%È$’{‚Hãèğ×†ô˜˜Ms¥Ú³Å#_(`à’<ôÇj³y¨[tŠ@ƒ—êt\'9ÿ\0<Ö÷€ôwÕô»ÉVêÚ n²w*pà™\'¿jU/k£8Úú’[Å¥yD5¼Vè •o\'–êTc>èàúÔ?gÓ¿çØÿ\0à9ÿ\0\ZÙ“F±úÖ—eÚÁnAœñëÇÓ ¦Â+gÿ\0A­3ÿ\0V²÷ÍmŒ÷Ëidflc®O¾GĞÒ¼ö’µjšeÒç\rnP°Çğ¶HÇÑ‡_JúO•UÈ\\sØò2;õÀ¯ı§Ë°Ò$ÚÉş»;‘àãüûW¡WTg†|µ<»Â¾06²Øißc\\“Æ¾fÿ\0›\"@A1Î¾µº+åªÉ¹C‚r\0ÀëÚ¾UÒæÚT¹BCÅ \nÀà¡`zzŸ^ÕÙXêZÕÆ§g4—fÑ$(ŞØ+œ1#<œ‘ì+ŞæÓ»nÇ |V›S±½ÓeÓ!YËBêÿ\00\nª¬¸8ã®[òÉ/‰¼Q}jöÏojEÛÉì@}şIíŞºÓ©iw©fo”2–Îß¯ı\rF‘Ã2¼_e|¶GÉòçõ×ßğQ¨â¬sò+êq~ğt\Z¦· ×\"Ş,“ö{€‚0sÆ~oËšì†|#¦ïcp«“òÍx9ÁëÍ`ø³J–ÏÃ×7¢\"‚vå×=‡qÚ¼şaıÔ{˜¾{B+DMS\'™GFnÓãûe¼f&	o\nùa‘ƒ\0£€sÜ~ÕaSse\Z³9óÒ0Ê>f îrGµæúıôwºe€2}›ÎÇ’›Y¹?‘î;\ZöÛ?éVÓG)sæÆêêÂfÈaÈ8\rëŞ”åd¬Øµæ½‹ğø~ïçÆåÜŒ+ÙzŒu¡¼\'+NßÙ²†ÎBº˜gI=G}«]uFº¶%¯ï%;~SÈöÀô÷€¾ ºº·‚C¨İ;ìÉŒÌûƒÏëÀê+C]Í¹úX‡V×4PÊU[yá1ùEq‘œtëÈïMÇ–Lè-ÃÀÚÛ\0ÇcÏ=ùü«‘ø…§SK–êÊ<\\RÓHÙgàƒ“ß€:ú\nóË-7VU“æçnl˜$‘€?2ZéŒ–ä9YŸFÙüNÓ,íöIÎ¼\0Fz`ç¨â»¿kÑx‹IŠòdI\rÃAÏ>¢¾>Ñüâ=bE„ÍçM“Áãóã¨¯¢şi÷~ÑNw´¾ZC$gå$±àP1Ú²©(»3³;TW=é‚ÇÅ`^İuô­KËŒ)íšç/®Oó˜]°¡k\\#ÈBçüõ¦İB’ÇµŠøà_Ê±/µ‘a‡LóëYÖ^(PºòÖT;~÷Ì1ñı*aCiHSÄJü±F•İ¼\n¾Lduä|Ö$@s\nã ãç­iŞx‹DµÊMz†@2Bä÷=½k;ûrÆö@¶÷­óğ\ZŞoM¡Nmİ˜7Öğ«„XÔ\0IãÇ_ç×Ú’ÎEµ`B„íĞ”º·ˆô˜p\ZmÒg“·©çôıkûÄvA:äv-ı=3íYòó+4²†©ƒkª\'—÷‡=GøÕ{­a\'Ìls>¹ş˜¯.ƒÇípcK„.8 0Ï_Oş·j×Óõ§½|ó½zsúÖr¡Ê®Š!É¨´oj$1„Œ*\"Œ\0;\nãïåûç¨\'Ş¶uKí±òG¾1\\õ”2kš¾Ÿ2âU@Np2pOà	üoB-Ù™b&’g[¡è©6•†v€íó\0Ï\'¨8ààÈ×šˆ\ZšÉ$ßİ\n¢€[œ‘ı+éÉ4K{46ö{c]¡\0€>p+âïê	câkß)YsÈ¿t>bn;WÒQŒ\Z³>2¤¦Ûg¡xÃWmsL‚\rEâêáá¡URº©\0öb	éíÍ{¼Öö÷M¾[÷pNì,årr3Ó¿N†¾@Ğ¼Ew¦ëZeÊ+‚î9š0 Ã‚Aïéæ¾“_\\2µÂÙD\"U`Î¬1ÇBxé‘Ü~”ë%œ9ì»­GmJ°¼Ò@w#³ìÆ8<õÀ=Oq^GâİfÊmPŒ^yòîaglàñÏ`+Ò[â×vâŠ %_9\0ä½yíë_.Zj‘&b—†2@ÏŞ´R»E¸¤Z‘£}ªcŒ>ÑÕ@ìÜõ÷®’ÛÃZÜÖIgkrm¦]àp¨ÊrÊAÏ¦:×±\0}Ê$Ëg$°Á=†?Ş¾§øu¦Úëô›>âLÀFÕÂÊpp1Ø¯jº’qÖÃ·Vrş	ÑÍ‹i\rİ˜{ÄÜJ†9\'Ÿ\\c½t-ïN4ÙDgååc=\0Éûİx®‚ßC‚ÍÈ¥9e;w†IÀúsßµi‹%•#hä üÄ—lÈã¯^+‘Ê{,w<ïÄ$vÖ’¶ŸäÀ$Ã3mç*ÜÇÔö¬í\r7şyËùğ®÷âBiÚo„®nÜàÆèÊC3s¿iÀ$÷c’=kÆ?á#´ÿ\0 ¤_÷àÿ\0ñ5¢RbWû\'Úí…Wî1÷³ƒëÓõ¯ı¤m|ßÙJ2.¶ç‚9V8úeqÇ¥{‘¸#£?6?Ïå^[ñö7ØÅRåíÆ:0\0L°ÙSDìEâDğ¯é1ê\Zl¹Œ¾&Îÿ\00(ìy?ë]ÅÆ‡mo£Ş|òAr‘¶×V\')\0œuÁü+Ç4İbâÊI#¶ŒÈd\0í\rÓÛP+Ô~ëÖšÕåİ¾«n©2Æ¬¬°å‹6=@*?\\’§\'i\\íœ’mXálõõPMÜ ¨Èeä`òG§\'µXÔ5-Oì¨ëw3Èœ£‡eØ;®sš÷ØbÓ·m6‹Æß³ÄwÛ×§½A4–\ry\"$J˜8\n‘‘Ÿ^İ±ßĞÕÆIêÑÉ+£æÕÕ¥šB&™Æ?‚VÊ“ûÊ–ÇPŒKµ¤W¸ç¿¦?ksÄüMu®jw0i§ì’O3ÆÂD\0Ç’rAlç\0öíTm¾km°ChÏ%šE9Çn½9×RqµŒ®ï©õÔiaF7‚TAíÓ9ëõ5­¢éjÁRIŸjåQW<8ÍyVŸâï4–ö×RyU	!0}3ÅlË¬kº{ÿ\0¤\\ÊyæÎà9{ó\\®’z\\|îçªÁ¦À±—ûDØrs÷{Œc•<æ¼3PÔ¬lõ[˜\'½µ#™£a,Ê¯¸1c=AÕm{ãDš§7n]ê\"—I#ç¯¥y^­®Øê²\\ÜOÎ’±“ï†+¸“ÙìOqëDh¸‚¨{U¶©¤ëSÃb×ğÈ—¹[yA$I@:V›xCHîF$hÃeVIKşq_=øTŸIÔ-.à²’o*@Ë¿8lp8À98Î:¥{G„|csâË˜^Ñ-\n…l\rÌ0FqÛ‘ì:ñRéI=£’¶§m¦èö–µBƒnÂr}¯¨şu¬º±]é˜G\0c•õT˜H\0ë»ËÈèAÇ?ZÀñ—¬¼+N%L˜áHşn3ÓüúÖÔğU«ÉF\n÷0x˜R÷¤ö=	µ2ÏáÓµejˆı*\r*ÖşãA†[¤ê;|ÉmĞ“µHÈO÷€»ç¯‘q1“ß1àç¯Nk‹1ÊêáZçGÑåy•,dvö0õëYuBè¬Àtxÿ\0\"¸ÈşÃÓ\\‹¨‹pÁ\'p­¹ë×µz|(± Êä^MEyp†2¡yõÇéü«ÂISv{AÈ«s”‡á¶—qfJ_Ü[ìÎ2zOçUÛáª¨ÿ\0G×\Z0p‘ŸÄtéÕ.¥\rÚ³µ¤…$?ˆúı+™¸±ñ,Œ[í‘¨Îx‰á÷«£ÚF[3¥K’6±¥ª|%´÷Z»Ls–(ÛAçŸÊ¼û[ğ™Ât’hÇÌvo^q¦»·ÕäË¹¾ÀôDÁü÷uúÊ’ßBXrNXõË`j]eˆŸ¾’Hæt[Â±²ÀˆPñÆù<WSf«§«©éÛ¦*s¶5ÀéŒv¬Rñcˆí=¿È®x¹MêsÉF*åmoV\r•üÿ\0sZgŠ®trŞş×h–Õ·.ìÈÚAö õ…âÏE`vnß$™\n¡ˆôÉÏâ+;Eºûu˜wĞŒøçé×¡í_}‘åq­ïÔZœæšäƒÔö	>3xÁ‘ä²Ó,§[Î8ê8ÁaÏ=+>Ãì7—?Ú:“iÑŞ]3K2’¸X±\0Ø“Ü×›Ï\nÌÌç\'hÃ©ÆÖ\\1øô¦i6º6¥y\'ÛRàÛ+bSjê­‚İFAÉ\0NÕêâ2YS¼©,Æ3´f{Mæ¡áy4Iáiqİª0Œ¬‘¯™‘ƒ’OU\'ƒŸJÉ´×¬o&†Ú=VÅæyKWH~l z’1ùš›Ã¿~ë¾_Ùµké]‘O‘4éç9z>ï¯Zèà¯†¼2RşÁeî×l<“·’1×æ=Ga_+ZÔ¤ã8»Õ?}^,Ä_^y€ÆæÊ«1!¸ı==+Êõ‚~%mBêX¡€Áæ1WiÂ¹lŸAørkÜï­fÒ¯ebáÑ_å.ÀœxôÉ=\rQ—U–íH,¹f*Prú}Ozç…GdoËk]*ß5èí@Å¤Nãò7N	\n}Ev^mkÂš¶Ÿ>¡0òÁhf/ÌìÃ{ş·Y¤n-b20ÚO@Wğ9ş•‹âJáx°…eÂcn2rHç¦sùQídôhc=\nMâÉæ•¯®ƒà.DìLàŒú“úUK¿‰p[ÙF²­Ã37,À1ÈÏ?{§ã^{¨k~l°‰ ÄAŒƒ@#>¿ãXw×·n#c4sGr¸=²yéëšßt´%Et;kâ-–·kä0€;Šï¿ß¡õ®[ívßóÚoûò¿ü]}o/…<”xF–…‚³íTóótê2{zRÅ1ıËoûèRæF|ÍBO!olHú~#ò¯>øÑï‡º–0]|³Ó#‡®	¯@™‚«‚~LäuÉöü¿qŸ kÏjê¼$Éógªİ?ÕÕ-™•7i£ä\r7MQ¾’6BÏÔdàçƒÏ|~•İxÃ²h:¤Wâ/.0Xæ|ß2½=kŠÒ|-?ˆµC_e³’N0Ÿ\'òö®‡Mø7¨İ|§U‰_» fÂ€9<Şô’R¬ì¬í=ìğ•¢íŒ¯™»cH¸ë“Æ}7N»7\n÷‚âĞnlßŒòHÉtÿ\0\Zò»Ÿ‚—Zm¬²Í«Ç!Œ¨*’s€wuÉïTáËE˜ßRØd:ÄIãc>¹öæ²:k©ƒ”¤®e¼ñ4+o4R_Û>—/psƒ§ëÒ²ìôËˆ–Š×NÇ!ğÇ<AãÓ¥q:GÃ´šİ¨d³ì!¢Áæ\'=FOc_Fhú…ÓZG’ßxTû²K``œníúÕÔ¦•œ£.Œó-aï´]6æşŞÊá\r¼F@ÓBÌ£\0õltÆz×jŸ¼AªªA$±*(Ú1Î ~5ôw£xGZi•ÃZÈÍ\ZÆ\0!T’3ŸoÒ¾a’ÅoÉo+GåciÂ·9©Åtá©¹+´aVi;\\õ€wÖúå¦¥³o\rÄªèg·ŞÊ`0@<å^Í§iº]dŠÓÍu îû3zvçŒt÷¯Ÿ¾K}áø5é<í‘‰šLeNü£§\'õ®ÓÂuŸÜÜÃà±Œ|tˆ¤Œ`\0Oø×RÊëâ<‡,±Ô¨û²{«©jQÇnEÌsE`É#´%@ÀÉÇ@3øWÛxÓOñ•àm\ZÊw·µÜ¦êU\n®Húô«ãŠµ}/Â÷ºt“µÕÅÁ» òÁ$¯\0rHôìk›ø)¬.¦Ëm3 å>`yl·\0Sœ~¢¾‹ÃğŒyëîxØ¬ŞM~çcÔn58áÓ§º–dÆÕÎÙ³÷Tç¹\0sú×—ü;Ódñ·.|Cª(’f,‘•ÊïÉØ<Çş:);Ö&G—L2FÎY‹0Üxã?¯QÚ»Ï‡zKh:\r¼ƒË“I‡î`2:õ\0ÇÎ¾ª–6„O«ˆ©Q^LôÍ/{$®¹v ã<’Ï§5áÿ\0>*iş\nø™©2ÛXŞ.ïµ1!\"rq†ô‘óg\'<r=ÊÅ£ûÆ+xç¯R3ù×Ë¿µß†\"¿k{‚YåxÌc éØWÂCIÂHëÊ1SÂâT¢ô=ŠÛT†ê\0ÑHöü~”«cç±ù¸ÎGOZùà·ÄK›]54K×asb6!$œÇÛ>Àqø\n÷=3ÇˆÑd!Ÿâ<Lñ¯Æñ˜\'Nm#öì>1J)³­m&4]ò¿ıoÒ©M$JHÂã8ïÛ­dßxÑdV]ØŒr½sw&ƒæc=½ëÉ•)-,z+ŸS_RXÚBø\'Ë\'ğ¬Ë‰ÕTàş¼÷ïøVU×ˆ)mÙ ÔşYÿ\0\nçµoG	$¿nùôúTû	Kb\")nlêZšZ#în~µÀk~%’îO&ß÷NÓü{Ö>©â+Jà$ÄpªÇ“ÇSZÖZö}Œ—7\0yå7zíî8ÿ\0ëÿ\0õ½:t£E.mÙçÔ­*òìyŸˆ	“ÄÆHã\0…ÁÉ8$}\0#ò®§Âkû»&äËw\0F0}q\\õªÉ¨^Ëq7Ü;$d…Ïü1ùW]£Àci°\rò…è	ÀÆqëÇ¯¥~Ã”Òöxxè~_™Uç«\"õÄ)ó•8-×åú}qİªœcşH!	\'’s’3ƒøûsƒZ­ÉveÏİ^xúcÛ}ÍeÏ–·iÜ\n¶=OóÀéí^İµ<H·%bş›ç4?3í¿|ıkJçÅ\ZŸŸª^7”TLøÂ’v~éÉÏÍbÃu*íòşær c8Æsß·5\rÅ»İJÊÄ/«ŒÙëõü…rÖÁÒ¬­8ÜŞj”^ŒôÏøX‡Tš9#u¶%Dl’1+Ë\'8ê	EbÜ|@³<&Ì;à~ğ?ËÈÉ ã\0õ¬sD%~O—°s×ŸsıkZº’?œqYOLIús_7S‡é]Ê\Z3×§›OHÍ¬ìt¸cˆi~|‚-¡·´:à¾õ<ÉtşÈÈcå™&ãİ~çCƒŞ¼Èx~ãTG{)ö|mÁ Ó8íV¿á^ê²7’5.}d”ç8ÉŒuÉü«æ«åµi»8Ü÷iâéÉ^ú”5ıhêÚ†¡|!hâRÊ nb[ÇAïŞ²ciNè‹²•Ç9üÆzc?çšílşkº¤ƒf³ey+sØËHA8\0¯OZdukVÚ\Z“YLA-öì®9<ààãƒù\ZóåOIhuÆª{3Ğ¼/ Ú_ipL·b#€xÆqœv×¿ãVÿ\0³áÿ\0¯ÿ\0~ÓükË­~ê‘Føñ4ª:*Æ\0Æ1»¦oj›şM÷ı“ß“ÿ\0ÅW¡}Í\\÷sãËT\nò+™ñ’	<+¬&pMœ£åğÈçÖºi×ËÊô •gŸoÏß½bêù–sÆÀ>øØÀşî98öıkÓ–Ç^©ŸøsÄVŞ×ŒÒÆîY\nÆ¡˜äcŒçĞö®Æ×ãct%K[’Y]TÈëıkÏíímn<C7$[ˆm™ÇNs×Ğ×woàÿ\0M¦™ÚX°‹¹·\\\rÜÓŸaÔÖ’ÚÇ}uÔî4ÏØøãG¸’&ÉU‚yw2\0I\07=·½Ao£îb_ÛDÛpÌXœøõöì*î‹£ø&ÈÆ‘Oin„n)öÂH\0’7{õÖC\'ÃÛQ¹µ[€>Ú	íœ|İE>W}ËÌ¬aø{ÂÖ—K07¶Óò>ÒT¼sÁÈîk¸Ò|	6¡t>Î¶»8Oåã\0÷>ß©«zg†t›­2;ı>–ÎFÊÉ­´€yÛƒÔz{Öÿ\0ö½“¤›;ÛzÑª¾ğïÎA9à‚Qü«ßÀe•1Rˆğñ¸øQV¦õ8?Š×Qx^-7N±Ù¾çrÉu4aœíÀùW8Æq×5âÿ\0æÖtvÓ\ZKƒå)VAÈ©¸p\0OQÜ÷¯{ñ\'†íüQ¦ù\ZŒª×,ÙV$ŒO=€¯§5ã.Y/¼;¨h‰æjºOï\"™Tåâ\'\nçğÇ~ãĞ×İÒÂR§(Ÿ*±U*M92O\r|Di#E’Ş+y!Ë¼ÌN[8Á+‘ÉÁç<m¹9fğŸŠ£F1G6$]¹\'¡>Ø ×á{£câ($y˜,§kéŸa“Ò½ÅÖãTÓâ¾o›n3æ\0A¸íŒÖ»cÁ{«C\Zóµ.¦×Œ¡OhWšßŸr±f#sqÎ:òx+‡ğV¥ı—©Y´jŒç\rœp‡¯jÓğ¿ˆ–÷CW-=CÏãŠç­a‘uÃe\nošIÄQ<p?Âµ†IhâÏ_Ô,¢Ô|ZnäSöHv°Ú~V‘€*Ç@pë]¶‰pDb&‘ÈUÏsœ™ëÁë–ÓH’İ_åØŠ¨6‚•\0?—ê+¡Ğd	‚r€1œàr3èI¤ÎI7ò=K›e±û¥±»\n¤\0Æq^=ñÒØ^FˆÛ¤‰VG*¤çvÓ´©\0s^¯¤Î­T;r3Œç£¸ì{×—ü\\·ûd‰üõm£‚sï½zÖ6.‹´“>I×!êkÁŒˆß:©%]äqùW}a­ë4Úl£dãÙÏëëÚ³|_bÂŸÇ¯_Ï=¸¬?Ş¹â=À9;_qÓ’¯õL‡ícìª5Ïˆ.¢Î]ÃÇ§×¥QoÍ2œÜş}=+°E´Ô£ÆsÎ{ş•Sºğ\rœŒJ±9äsï_õˆõGØûÌãîµÉq†¹àuëô¬å{ıV@–ÈîÌq½Ç\\W¡Û|=µF¬ÃŸ˜çñÅt–>‚Ì.ØÇúR–*+áÕßSğ‚—›‰±-Ñ\0—+¼Áõôªÿ\0®›NğíØ‹’P®yûÍòÈŸÒ»Ë‰Ş\'?…y7Ä‹§½¾Ól£bDóolŒ(\'\'ñÇ^)`ù±8ˆÅ÷3Ä5BŒš9í%Šà£\n¼Ôöõ9®‚İ|Œ?u·¶2x$‚2=*°·KxÜ;Ñ²Çqœ 9üOj±o	ó¢ù·ÊPõ p:g©&¿z£(ö?ÄMÊNLÑ1Å*î\\§œñïT¯z—?2@ÚGÓğöü«Y¶Q‡Ï‚~ğõ=?Ï¥P¾ƒËŒœm2@8?–}jéÜàƒwf}Àv(ÃçC>œ~™ÏĞÔ­#2(`>ïİßpF>¼£¸ªFG·…Ï1úo¥JÒ!ºDÀCÔc¿bÇ^¿RÚÆÍê‚ÆOôÉö.|¬xÉ\0äô$şµ. \rÃF¬1~èÆsë‘Š­o#	g?0€Nrxÿ\0ë\nuÕÇ•k+*0R¸+À\';óøú~M®Œw,Ù^y1–‰²Wå ‚0¯¿éR´Í36òÁ:eHÂ€äÕ;I•lW`ë÷³ÓŸÃÒ§l‚íRyÜN3×>õ“Š¶ÆÍ½Ê°ê\Z†‡t—vsÛºr²Ã3#)é€ÀõÆGµuZ÷õïY$z•äkzr]ª(pJ€U€\0F:Â¹ÓN‘‚|°Ab½@ì=¸ÿ\0&­|®n\0!ÎæÎ8äƒƒé^}\\%*é©Äì…yÓ·+9¿k^(ğû…¸½ß6Õ’=¬¤ç#œuÉ=GcXÿ\0ğ˜ëŸóÿ\0yúÿ\0…tš…ô—ÄèÍ·Éb[¨ c§ósşË/ùâŸ÷Ê×Êâ2T§û½r–a.UÏ¹÷æ Û®®BŸ½#õ9ôÿ\0Ys—1ÈÈ9ús õïZÚ£¨ºô,Ouqÿ\0JÅºÛ3OÊGçŸ©¯‘Ú¶GÅ:î‡ÆÙÜî!uå°ÈgÓ\0t+7RÑímï§µ¶ŞäÚƒ9îNsN„\Zè¼{\n[üFÕéìIÎ\0ùÉäuÀ÷éŠÇñe¿Ù|IukíŸ++à‚r äûuüªéFîÈí¬ÖŒu“ÑÆ#IŸyµN[§ç8ëù×ªü=ø\'qâ	~Û«,š~§ƒ&àó*@@z?ˆŒ}k¡øağ†O\rÉ¤kŞ\'Y 2¯mf0¸nŠeÏ×;G¨Ïq^·¨j‰<†İÙ@b¶yŸËÒ¾·–95R©ò8üÏ’ôè’Yx’ßG´¶Òá‰bÓíãX!Uãb…\0ãĞwÍTÖ4Øµ‰â»¶ÛŞ™%…IYÔJ‘¸Ï_S\\Œ._B»F“/o+•ûø##œsŞ¶4­›\'vò¤Pbó>lÎzúz××ÆœTR‰òMËâzÜ±ı£{srÒ9æbHõÿ\0ëWˆü@×&Óş\'ÌÁ/#h%ç‚§Ô¾ÕôÖ±I‰Ç/vñĞŸ_ozğ?Ú7Gû©i¨BI£gé‘‚ÊĞàşB—6©mÍ¡ç’/ÙïC©_İÏzg#z{W¡é7ÿ\0n°–	qär£”œãë¢¼öàƒpÎç8äƒ=ÿ\0­t>Ô<½CËŞƒwrGãè;zŠ¸ö5¨¯«2­nªÌ‰òË‚8ÇşÕŞhvQ5Ëİ¿h‘p€5=XzZâu»ÿ\0„œÄ£÷r¯˜Tü dzk¾³¸„F†vÁó™€éÉ<œ´û\"\'µÑÜé¥VİX„#=†p—Sé[–«òDù,3Îx9$zñùŠàãñö¥KRjö¹ÚFÁ#€ÏR=«:ûã¦“bÁ,á½½?\"lİÏ@X÷Ï§zv8½”¤ôGºh·ÀD[$`•¸î{ƒ^eñ[Ç\Zƒ2Iy¨ÃoprGÌ1È!}}±Ş¼“ZøÏâÏ3ÙYˆt•&=¯0R1€qòq\\ğİ»j½ÿ\0H–lï¸‘÷¹?RzàTm±ÕO–³g¤xÓH‘¡’H£¦Ü¬…	Y@lr#¿zó[^ŞùU•¡wÁ_0cp# ıjí>ëºoÃMbXüKo¨ê^½…íÉ²˜ïÓägW¢µˆÃg#ø^†?ˆáhu	´[jzv¡›mó+)G—:c÷lsÆ{)éÀ>>	#è°–J¢wF¶ƒçÀ$“œôóÒºˆ-åfş\'šå¼/«¤r%­Ú,OÚLŒrF3ÏQèkĞmDm‚¾ùééí_f:Ø:®\"~…ÅÃ(1ĞéíåŒ\n²4×lc8ôçŞ´lÕv€Gùÿ\0?Ê¯3\"\0}?.O­xn÷=Tô9‹Í,ù¼?/ùæ¼{Vÿ\0LñÔ‘ háıÔoÉ\0’Aõ>Şõë^.Õ™c6–ÁMÌÃjï;B¥›Ø\0kÏÆma8\"(€bÓ9ÎrHÉ>øì;šûîËçV¯Ö$´GÈgØèÓ§ìSÕ™wÚ-Ä–ñ¶âN3;s…;ÜmqÓÖ¹xàx>M>;{$™·›GN1üYoÈ×Kqã[yv\\ÒÇ•O˜É9ê\0ëŒši5Ëï´Î¨Xò°Àôôõ¯ÖyZVLüê2÷¯%s)~9M.maËsİ¾_\\õ5«¦ü`Ñµk„Šò	ô×cş±ˆdï	õ¦K¢ÇqóM\n:ò*1ÜcôíXš·Ãû}Ba>T€t ã<Œ}zvj-V:ÜÖÔ%ÒÇ}+,–»áuhŠîIoVCÁà÷¬ô’9n¡Vàƒü=xç®q^s¦êº·ÃÛÍ’DÒØœïˆ¶p`qÁéù}+·’îÚòçL¹³Á,¤äã#%s Ö¶§5/R%O•&†İ¬l$“ra9L|c?_¥&£+¥£àlÊğ=2?˜¯­%»’UbÛGñtíôòëØÃ[–ã“¸Szr	Çå[³(î7O™ZÅHeÃ\0~R	úš}ìÂÙL…~n›sÎËõ&‡ì°(FO”pCtïúØU;²dÔ¢æãtœ÷àŒúc¯¨¨{X¥ñ\\±onVü	wnfÇ#\'€FséùÔŒÊ#åCºıåèyç\\>‚¦{QŒHpBG¦qÛõ^F-…fãî¶1×\0\\Òµ­b£w&Ù}oç^Z,`0c¿å#œÎq×8ïë[ÿ\0goî¿ıòk B\'ÖœŒa³Œô\'9¹Íl}ÿ\0ÏÏş>õÇ(¶Î¾f¼u\"Òù\'7F­Êœ”¸ö¬Y°ŠW#’NGÿ\0ëŠØ»‘şÏgİ„x9ÇbG_ñpã\'\'gû?N}ëóOt|“ñŠÆH~\"jÂ›ä’U#vÌÊ¤qõşf½¯àïÀö‡OŸÄšä‘]k‹*¬	\'Îm;Æ1¸ä}6õ>‡ğÅ¼Oñ’}^ízV#˜?\0I0µsõ\0Ÿ÷GL× xnaáÑ}¡İÌéfy¡’E\n$Vl€¨$ÀWÕå88µíf½5Æ»*Tß©ãOOÁ:™‘wö2/©ASŸıjçX\Z¦›o<nT2‡ÉÁ<ã9ÿ\0=ª÷‰í|é.í\n(7°Y9ÃqÜzä“øWœè\Z”Ö—M¦Ü;Gåò›0^2OA×¿×E[CåUäµÜé>\"çXğ\'ÚGü|Z¸eÚNCÇ§ò®b9á!ğ‹Ëÿ\0¥Û&ì‘’Ã?wñÉïéõ®—\\“í~½~û©$€F0rGNkÍü+ª%¯˜’+Ø´EN\0`’1È9=ı{\'`Œ=Ó×>øª={AŠŞwß<g\rœà\0rñqùšá><BY/Ó\nÑÿ\0g©VÈ$m¸ßĞÜdÕi´›Ä+)\n$\'îœ‘»8\\ı…hüeºTÓ®Ùqói…A^yóc#@è{Öm\'+¢ ¹fxò·–ŒJ<yrG@@ÿ\0?Zµ¦ºÃ­²äd&=G^¹ü¿*Šr,tÉÕ‰;[ÛØqôşUJÑë¥‹áB’FIÇ\0:œ‚ª\'Lµ»4>!Y­Ô673Î9À<ßòê?úÙÚŸYóaÈÏ—•äóÏ?ˆıuzµˆ¼ğûœ™\'nnã<ƒÖ¹½6àÂ©#S8<óÔpG¡úÑÜÊ:ÀÅ};O˜İ_v2qÔàg§OÒ¶µ\r<G®åàK\ZœóùuüèÖ6A«[N8[…ØN1†¨ã©Åjjp¨Ôô©:FĞm;@ğ—éUØ¾mŠQé¥dÜŠ¤7vœqı{S5;U†âÒP6ßÃÇ#±?ç­tÕ<ç|‚Xò¬7Î	íúÔ:–ßÙêÌê\n6ìã Ï¼şµ\"R}›OMZÄÅÔJãG\'èHí\\\'ö-½¸šÊâ$6“­!1·ftÈúJôm2-±HqÔ_SŞ²uë[Ï3km|Ø ä¨åMêU::\\ä4»;!¤µ‘$Ú?”£ÍÉçèÂ½Â>*û3Åkw.õû±ÈxõÀ<tÛµsÿ\02âQ–¹¶UYg÷‘œ\0Àúğs“ØúÒê\Zd¬†æÚ6hˆÜÈ €¼`²^ßÖ¼Œ~]KIÂhö0˜éáæ¤™íwA†Aã¨?Ö¤ÔµojÎà.søpÏ¥y¿€ü`×p‹)¤W’1˜Ûœ•äqÇ_zë<E«G¦éRÍ.İåv¢“Á$p1îM~/ŠËªa±>Á£ôúØV£íS<ÓQÕ¯µCQÿ\0H{WeØ²ÄØm£$¨ç×ÿ\0‡Ş¸}VâóRŸeåõÍÈ<l.Ã#¿â;Wi¨Ê4½æöV\nï\"†\0åß Ç\'$ôô8®;M´’ëd„d±-ÉÎpSù×íVêØXÓØüÏ‰XŠò©r±©Uˆ\0\'§\\ÿ\0œÖÕ®œ±cåàğ‘™9ÎsùÓì4±É~n2FséJİµ³+Ï8nI ‚8ê¯?Ê½¥Êœú#6í’ª€®îpzdQÖ˜¶²*¡.Å€ÆÒO8 d|wëÍojIäÇòˆ[È)ÈÆsØP$koòŒü˜Äã¯Lf¬çæ{ô9SE‡Rµòå‡ËŒ©ô9öÇ§zçôM%´ô²´’C\'—rî¬ËÕs€=s]óYƒÁ!÷pK.O=Ó?Ê²dµhï­•GG\'v\0=ñ‘ã5<©¾chÔÓ•¬íİÄjOÌK£¯çÓ×Ú¡Õ—t1 PşaÀÇ~Ns×šÒRcóÈ ãå2sÇ¨Ï^õŸ{Ú¦E\0„\\º	=9ëÔTĞ\'iZ H6Ûi\nÜF}Éş]êU¬7íäaFOLt\'±õ­E N{lşç[OˆÉy+‘»nN\nçóã ô¥©¥ØÙnÈÀ~Ë?Ã\'¯¨æ©ÊNí¸\\/$äãğúúÖ„Ğ\rÀáÉÁÜXòz“êO·§¥WÚ0’2s¸làğp=±Ú”¼Ë‡C6Æ\r—/30Ëu#*0pxéÁık_ÈOI?ïŸş½Ce…±µW¸ùx<õÆ;ñù\ZÒşÏoùåÿ\0ñ¬TK’RgÚ÷glÊ¡È,38<åYñÛÉ}y´k—cO¾Iöãô©mp4{bäpÌyï÷xÇ×=\rlØZË¤Û¥òB%g$Ğãò=\r~u„ÃºõzA‰Ä*ùåŸ³Ã¥Û¤0ã†bq“Ó®ê?Jæ<a§sM\r˜.íØåR	\\ôàÖŞµ¦²C®CFÇ\rÁèG×ĞW){¨e–6“ËŒñÊşGáü«ô\nTÔ\"¢º\r:’”¹ŸS†ÿ\0„êZßÆ‘^Z¶Ö^y8+ê:~µÍøšŞ‹ä?q1û²n\06Èüzûş7üqn5	>ÑnŞEüCv\0Øç¨Î„×#ˆ¡fb;Ä«ó…p	Ü\0ÈÇ®1ĞsÅu­Q¬U½ãªÑudÔ4ñm>3’¬ äô##>¸çŸjàVìınêÑF7*GÏ§o¥tzmâ\\‘UDåCmçzué‚?:ÄñDló[_Æ„ŞSªã¡8èzR4[ØÒl…;K»# À cĞñQøÊAq¡˜ÕÂîŒ®>¬¤ræy¡™¼¸q.áŸx^¿U×Ë]XçT2©#\0<uâZÍ6qzJ°Ğmw¶V†O¦N¤ÌÑö\\ëÆ\\&œ‚1ƒÉôÿ\0ëUë{3­Ìeñ¶xÊ¡Šõëœ=h’Ô%äR`„c<××=?Â™NWÒÆîœâæÒhÉ\0*0:x?Zä­á)±mÈŒdàºÄ^?•t:YÍô‘?ƒ’r~ÇùVlÈ°ê×°ägvvœó•\'Û>•$Æ/TTÕíZ<rg-k:üÍ‘×\0\0ógQ‘~Ë¥¸fˆqcÈ\'“ŸçíUY¬õŞP²ãŒ²Aúÿ\0…Éçx^ü$m¹‰à÷?^j¯Ô¾V¶:fÄ{\0ôè§¾[L•[=rÙÏPI#?çµPIwAC6œq€8éÓ¯ëWm¤+nø?Ş‰FÓÁíî)#+v\"´àsÀS•!¿ıGÛÔTú‚‹v+É$Œœã#\'ß>õRĞùq¸%s»d9=;ú÷«“)šİ”ä;&V\0şvÉíÿ\0×/ØZ§©4,ËÄJ¦eåQ”á—<¯^ø«úJ†Ùkû™\0hø#¨Æ:v8¬è&û<Ø?s;J¶8éœUÅÚÜF	&7mÇhÎÖ Øéê}ªY®¦ˆ3á=zË\\†-ğyªò£Œ†*\0ŒôÀ\nyè¥z—ÄËkK£Üé\0Ãb±G;™$fÃ:åcÆï¼çk…ñ=¨Ôì^Áˆ2\\7—ä`gqê\0íM»ğ®§áı7O²{‹+(”ÇœHØ˜¶:;ñÏJñëàèVÄB¤÷G§GV\\ĞÅÖnZÔc€ÙÚ©ÆW‘Ï,yëÓµXÍI±é‚8îË=•˜[©Xîn­É·üûı*ìpï¶!xB0§’zõ=ÇŠöt[t™\r½‘•B•ÂcËqœúšÒ*©°ú2A\0çéÒ~B¢)á‡CŒqøôÿ\0=*Yˆ\nX‘Ğ±ê0s£µF2wÔÈÔ™Ù¢ø9-´àÏäzzšÂËæ‘üYÛÏ®ãè}j;¨Ëj1*rªâÜã>½\0«qóÊpSvrÄöãŸ\\b« [KØ­Â¬yÎWœ™Ï®1ÓÚ±ï¶¡lÊ®‘‚K	è;~\\ÚºE0	´òKNzwü;ÖMò£j±2+œªî\'ÔuÆ9ÇëI\ZElìWUEÌ›š=ÄUİƒ*¼0¾y—bğ¡ÁÉ$t=1ZPŒÚ’Ìqó9=A==N1şx†Ö0X…”;g R\nƒ3İzûÕ_[¯»$š$@ÃzpGËN¿ŸãQÚÛ6çÜ<¿—–<tÆ×ëéR®íèÄa1y$‚qéšaRpÄÏñF2Ôı¨.å;ˆ|¬‘€âNI#=òõªö»¼É\'î–9è\0äûûU·„*íR\0\r¸`“Ôgõ÷=é±ªÇ&ÃÉİÀ÷çõ \\ÏtAmÎT)@0FĞÜàq×¨ı¨ù?¼ß÷éêÃ:Ã¸R\ZO”tî0=1üêéçîOûõIXNNçÛ±mKM‡œ\rû÷.U~<~UĞj7²ZÛ˜£uÜÕ\n0ÃOåY6W\ráÌœıÙ# \0=Gò¬ûŸAtÄD’2Û±Ÿ§NõóÙ~R‡3Z²ñÕİiY=_ÅÜ%òOT¸Ş@hÛÇ9c?—µrú†´ğ¶ÙÑã‘rå`§·^õÔêú¤ErX€¿39\'9êp+‹Ö¯¢š„«oèW$údR2r+İGšµÒÆ6µ®y™ÂÆĞ2c‘F=ò®Zı!îm~Pßy0FIÈ$’{s[:‹IåH²ÄNdàs#Œvõ¬Y­ÄÌïoòH£-XrÏBsÛ½_¡Ñ‰†ƒª+_y\"O–nv®F9#éŸéZ×Æ+˜eŒ’N2@ô8Ï¨şµÅÌÏo<“ƒ±òj7rIéÇ&¶mõEº»9)ò–lŒ)\0àş½+\Z¸ı¤\\v’ÔŒ66Ñ»9éÈÇ§øÓ~ÒóZ€	ØÎ¤`xëê8àúUY.Ö=à6\"ÆÒ úd`œs€1íK¢hIë™#\0§ ÷9íA,Šâ#Ëœ!i3œàp==¿ ¦,lÖC-€Fw09=>¹Ç_J±¨m†ÂBÎNìäç¸ç×5Z4gÓQ™W<\0\0ä~GĞTwfA¾‰ğÀò¡zF8>¤{zÕ]bA¾\0o–HwsÏBFz÷Èü¿\nµ#î¸p.œŒ/Räã§CYş!òâ¾±gÜí‰¡#“œñìåGbÕî0F|ñVRyÉÈlsß#¥E!Âò@²&Àø<1àûôïH×]äRä-Œ«}ô9<{Õ}ZU†Æî=à†Äq×8ÇÔ~”¯ĞÕ#zÎ_ô4`w¹À ‘ŒdtëÏéZ6ó‘µ6à.Ü„\09úvíô®{MºÙg H:g§© gµhXİy…$‚;÷#—ó§©»–­æòîˆ!°§…R{œ×¯OÖ¯A3F°á«ó8úõëÔV“,wwÎåùW{9½­^ŠÄÁ)Ée§\0{uëïI’ã¹Ÿ«Hcº–BÊ®¬pÇ¿r1éÿ\0ë«?li¬°Ç	»\0ŒŒzık3ÄR²Àd‰Eö\0\'¿óô5^Æø¶›(Á9İŒ”ddş ÿ\0—ĞÒË–ìßğ•Ä#ÆÖÎmo,jÏ&Á`IÎ;Û±ôéï5m\"çÁ¶–ğ´-<\Z€ıÒIqí‚¢¾bÓ‹RÁ•ä“æaµO ``~½²¢—$6	œçÜôöæUÁûjÑªŞÇB­ÉMÁ\"çÉ+K(9Ü3Ï# Ïëİªk\"×h$6y\'ğIôÿ\0\Z©óû@U8<`2!×ÔÕ1”o\\ìwù˜³q×uôô÷õ¯I£lJU¢ò€/°\nğ\0>„Zy…¼µ,¹KçÉãè2:š‹†‘ZCŒF9ÈÇAê{÷5e]zg¹fÇõü‡J~„rİØÏ…D—ÃnãòíÎNQ‚Ö¤µBÊXgj¶îœz’?ıuº–’WR¨I#¸àg¹ô%ª²ÇòÄä0ç8#ßéëUĞö\'Vvvù†:OLv>¢³¥„¶¢w \\ü¸õ\'#ßëÒ´·$*a€0Ü`¹Ç¹üª‹C¶ì´{PíÉ%sØ“zò;ô—‘wi‘FÌ®ˆ¬ÅçÇs0ô©mT,_8(äã!‰ìI?@OéE»6Ş8î2@$õéŒ~µr‡r8\'jä1Œ§¡íWÔŞÅO™›ËV õ$zzqèOjSy¥ucm Î99`=òF=…Yhÿ\0v_8ÁÜxê9ëŞ”×‘£ğ\nc‰ïŒ`ñ××ñ=\nE|ÈCÜ~lm899ç¶qßÔsG–VİÎ6óÇ=G9ÇAõÅO·vyG8 ¹ùr9$\Z‡p‘1€çı{qŸlçò=(ógj“‹hr6‚ÄÎ2}@8õÏåPy6¿óÍ¿ïÈÿ\0â©úçÌbˆ*»Ì!³œqÇÔduõªjÿ\0b?ûàñU;šEY¡—Ì!\0§—éŒà‚zÿ\0Zä5„‚4İäFÊ*:œ`wúzÖıæ¨>ÏoS7|¹Æ8É?çô®WXÔC+•!\\¸wQÏOóŠã§•‘æ7wvršä#•Øªv€2Fr\0ãÒ¼ûZ¸Y‡yVÈ9ìF}ş•ØëWyV*Whà0`ìôööõ¯7ñÆİàn$õÁ<`·¿^}«©\ZFVi™wÊåƒÀêGPpFIı?:È{¶šğFÇÏ<“–õÎGjîcå†-„}ÒCw AÏjË:§™û™æ0Ã=s€OÈìQOV_º¸Y\"Ky¢AÔ«dÙ\'\'8ê8ëY7¦k†`!”“ÀÁÏ©ÁëëDÓyj>ÊÅ×¯–ÄƒÉÏ§OåøeÉ¨	a(ÌsÉ!$‘™÷úÒlÒ*èÛ’üÛêS¡9-Îp=ÏåÉïWt›¥’0HÁ,H½«™¹Ô¤-§ä<¨ÊØ8PA\'ÜqùV†~­lø\'‚nzÈsJúØr»¡»®_;Ø€är2z`Ïı©Öw@Ù\"\0pœdäwçÛük&òğù8iI9Áçèyô#¿jd3*D˜#8ÃsƒÎ\0\'üvô¨¿CO\'–ˆ#\'=A=NG_NÕ™â‹ähí¥Š,‡–$rxçØşU$Ó¹J’’pçÏ¡úÖ\'‰¯ÙP‚£l˜/‘™éùô2‘¬#mI/µ\rÈ¿;Ã òÇ	ÜÔZÕÇîÃ/Ó;pH9ïƒéÇåYÒLÇçn›Fsœq˜şU¬Ëö{xÔ/Ê6 Ç`ŸJË™ìã{›Ú]òm¾fÆÎq’Œçß¯5©\rŞæuÚÜÆŞƒ®}¾•Èh³Ç$k™åî\\Ïğ‘ı2;v­ˆ®v¨e,ùFA¶xÇ°ü¨R\"I§sfêFÜ¼–ï‚09äï×¯µOctÂ6³òü¼`vëøzV)¸I<Â@\\Àö9=êí”Ã•\rò\n\0çœç>˜ê{V©İ´I¯°k$æEİÆ?—ZÀ¶½Æ›4O+œç\'Œzæ¶õG\r§HŸ2\06çõéŸoZäşĞÏ¥N…ó·ûÜÿ\0@Ïùü)9;èt–Ë¿O¶Û¸\r©€£AäğOøWEú°FP7ğğwzéÎ:Ö—å­¾Ğ¤írp9ÎzñúÖôl~V\n9í\\ùŠÖ/C\nEˆ×ln¸bê¡<N1ŸB;Ñc#C6ÑÊ§;yãx>ƒüû¥¼Â;°ÎTùv¦:ñœuäöéL³•şØÛË\"ÀÛ½y:SU©­Y;d(KPAoÃ©¹\'§­I,†8~êˆúpëïëü¿Úaö¢üÇ$œã§„öö¦Ş\\~ç0aÑ‰È\0r=ûõõ£R×R5ÿ\0GBÛÙ†rTdã<Ÿn½}MYŠÂ1}³øÕk9GÙ ?*H9Äõb<6\0 l\\•lÏŞ¦šØw»º%@b0TòN÷Ï·j€)ûc\r›A_—kÛ1Ó9ı=jÇÚdáù-’xñØ}3ßµUóc{‚§%İO*ç8çNİhAÌ“Ğ–¹ÚlƒØ“Ï¸ıjsû•_˜‚~ö	ÇË‘ÆªÆñ°\n7zäzòxÿ\0<Õéba—vBç¡î*º…ŞÂF»1@äœcô9\'ü÷¨ØcØ1FGä}9ı*A0PcVÆîÜğ:Ÿ©>µ\\ p»Îå\\®ÒOqúôàúÕê=;qå‰6sÁåäû{~öaæÀŒò0rÌ{úŠ‚i˜R91($¨$ã¾GN£Ş¬Itª¥ĞIÜÄ+\0\'~ƒô¥«Ù=Ì}i¶Ík6bëƒÁäg¯¦GÓ­SÛşÔÿ\0÷èÿ\0…O¨HÒ^F¤$™	#œs×®zzÕ¯:?Eü¿úôjvBÍYxoşA6¿õÆ?ık.óş>gÿ\0qh¢±†Ç‡.‡\rª®‡ü÷jâ5®‹şäŸú¢Šİ.‡yş¸¹\'ó5“y÷àIÿ\0£V]NènCiş¾Óêk*oøşo÷¢ÿ\0Ùh¢³{0Ø†ÏşA)ÿ\0]ßÿ\0B­_	ÿ\0«o÷šŠ(îhZÕ¾÷ü	$ê×ıãüÅT=9/ü~Gşøÿ\0Ğcøƒş=şºÿ\0ñ4QY\ZÇc2oøõıáüé5ù¢ÿ\0®‡ùÑE¸î\ZİüGòzĞş=_ıÇÿ\0ĞET-‹êh\\Ç¼ßõÇÿ\0ei×÷SúÑEo	ŞÇ›ÿ\0×6®=äsôş‚Š*~ÉÑ„êìÿ\0ÔÅşïô5½cÒëş¹§òQ[#†[²EûËÿ\0]ùUk?ù\\¾ŸúÑEjÌº\ZÃıpú7ş‚)·ßò×ş¹äÔQRÈ–äÿ\0ëşÿ\0şËV-şèú¯òQN;ÊMş±ş«ı)Ïş¹~’èŠ*º\"WB=7ı{ÿ\0¸ÿ\0ÌUÿ\0ùi/û­ü¨¢‡¹ªÜ¦¿òÏşüšªÛÿ\0®o÷ş‚ÔQZt1]K\rş°ÿ\0×cÿ\0 T‘t—ıåşbŠ)Ç©Ksş^GĞÿ\0:’Š*ÕK©ÿÙ', 1);

DROP TABLE IF EXISTS `modulos`;
CREATE TABLE `modulos` (
  `idmodulos` int(11) NOT NULL,
  `descripcion` varchar(150) DEFAULT NULL,
  `estado` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `modulos` (`idmodulos`, `descripcion`, `estado`) VALUES
(1, 'CLIENTES', 1),
(2, 'PRODUCTOS', 1),
(3, 'VENDER', 1),
(4, 'REPORTE', 1),
(5, 'USUARIOS', 1);

DROP TABLE IF EXISTS `permisos`;
CREATE TABLE `permisos` (
  `idpermisos` int(11) NOT NULL,
  `valor` int(11) DEFAULT NULL,
  `descripcion` varchar(45) DEFAULT NULL,
  `id_modulos` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='ESTA TABLA CONTIENE LOS PERMISOS Y ESTA CRUZADA CON LOS MODULOS \nMODULO 1  CLIENTES\nMODULO 2  PRODUCTOS\nMODULO 3  VENTAS\nMODULO 4  REPORTES';

INSERT INTO `permisos` (`idpermisos`, `valor`, `descripcion`, `id_modulos`) VALUES
(1, 1, 'crear-clientes', 1),
(2, 1, 'editar-clientes', 1),
(3, 1, 'eliminar-clientes', 1),
(4, 1, 'ver-clientes', 1),
(5, 1, 'generar-clientes', 1),
(11, 1, 'crear-productos', 2),
(12, 1, 'editar-productos', 2),
(13, 1, 'eliminar-productos', 2),
(14, 1, 'ver-productos', 2),
(15, 1, 'generar-productos', 2),
(16, 1, 'crear-vender', 3),
(17, 1, 'editar-vender', 3),
(18, 1, 'eliminar-vender', 3),
(19, 1, 'ver-vender', 3),
(20, 1, 'generar-vender', 3),
(26, 1, 'crear-reporte', 4),
(27, 1, 'editar-reporte', 4),
(28, 1, 'eliminar-reporte', 4),
(29, 1, 'ver-reporte', 4),
(30, 1, 'generar-reporte', 4),
(31, 1, 'crear-usuarios', 5),
(32, 1, 'editar-usuarios', 5),
(33, 1, 'eliminar-usuarios', 5),
(34, 1, 'ver-usuarios', 5),
(35, 1, 'generar-usuarios', 5);

DROP TABLE IF EXISTS `persona`;
CREATE TABLE `persona` (
  `codigo` int(4) NOT NULL,
  `nombre` varchar(20) DEFAULT NULL,
  `sexo` char(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `producto`;
CREATE TABLE `producto` (
  `codProducto` int(11) NOT NULL,
  `nombreProducto` varchar(75) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `precioVenta` decimal(10,2) NOT NULL,
  `stockMinimo` int(11) NOT NULL,
  `stockActual` int(11) NOT NULL,
  `codBarra` varchar(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  `estado` int(11) NOT NULL,
  `fechaInicio` date DEFAULT NULL,
  `fechaFinal` date DEFAULT NULL,
  `otrosProductos` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `producto` (`codProducto`, `nombreProducto`, `precioVenta`, `stockMinimo`, `stockActual`, `codBarra`, `estado`, `fechaInicio`, `fechaFinal`, `otrosProductos`) VALUES
(20, 'PESAS', '25.00', 10, 999999992, 'PESAS/SPINNIG', 1, NULL, NULL, 1),
(23, 'SPINNING', '15.00', 10, 999999997, 'SPINNING', 1, NULL, NULL, 1),
(24, 'MATRICULA', '5.00', 10, 999999996, 'MATRICULA', 1, NULL, NULL, 1),
(25, 'ENTRENAMIENTO', '40.00', 10, 999999997, 'PERSONALIZADO', 1, NULL, NULL, 1);

DROP TABLE IF EXISTS `rol`;
CREATE TABLE `rol` (
  `idrol` int(11) NOT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  `descripcion` varchar(150) DEFAULT NULL,
  `estado` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `rol` (`idrol`, `nombre`, `descripcion`, `estado`) VALUES
(1, 'admin', 'full-access', 1);

DROP TABLE IF EXISTS `rol_permiso`;
CREATE TABLE `rol_permiso` (
  `idrol_permiso` int(11) NOT NULL,
  `id_rol` int(11) DEFAULT NULL,
  `id_permiso` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='ESTA TABLA CRUZA LA DATA DE LOS PERMISOS CON EL ROL';

INSERT INTO `rol_permiso` (`idrol_permiso`, `id_rol`, `id_permiso`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 1, 3),
(4, 1, 4),
(5, 1, 5),
(6, 1, 11),
(7, 1, 12),
(8, 1, 13),
(9, 1, 14),
(10, 1, 15),
(11, 1, 16),
(12, 1, 17),
(13, 1, 18),
(14, 1, 19),
(15, 1, 20),
(16, 1, 26),
(17, 1, 27),
(18, 1, 28),
(19, 1, 29),
(20, 1, 30),
(92, 1, 31),
(93, 1, 32),
(94, 1, 33),
(95, 1, 34),
(96, 1, 35);

DROP TABLE IF EXISTS `seguimiento`;
CREATE TABLE `seguimiento` (
  `idseguimiento` int(11) NOT NULL,
  `revisado` int(11) DEFAULT NULL,
  `revisionFechaInicio` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `thema`;
CREATE TABLE `thema` (
  `idthema` int(11) NOT NULL,
  `estado` int(11) DEFAULT NULL,
  `nombre` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `thema` (`idthema`, `estado`, `nombre`) VALUES
(1, 1, 'bootstrap');

DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE `usuarios` (
  `idusuarios` int(11) NOT NULL,
  `usuario` varchar(45) DEFAULT NULL,
  `clave` varchar(45) DEFAULT NULL,
  `nombre` varchar(150) DEFAULT NULL,
  `correo` varchar(150) DEFAULT NULL,
  `telefono` varchar(45) DEFAULT NULL,
  `rol` int(11) DEFAULT NULL,
  `estado` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `usuarios` (`idusuarios`, `usuario`, `clave`, `nombre`, `correo`, `telefono`, `rol`, `estado`) VALUES
(1, 'admin', '@admin', 'ADMINISTRADOR', 'test@gmail.com', '0', 1, 1);


ALTER TABLE `clientes`
  ADD PRIMARY KEY (`idclientes`);

ALTER TABLE `detallefactura`
  ADD PRIMARY KEY (`codDetalle`),
  ADD KEY `FK_detalle_Factura_idx` (`codFactura`),
  ADD KEY `FK_detalle_producto_idx` (`codProducto`);

ALTER TABLE `factura`
  ADD PRIMARY KEY (`codFactura`),
  ADD KEY `FK_factura_cliente_idx` (`idclientes`),
  ADD KEY `FK_factura_usuario_idx` (`idusuarios`);

ALTER TABLE `imagen`
  ADD PRIMARY KEY (`codigo`);

ALTER TABLE `imagenes`
  ADD PRIMARY KEY (`idimagenes`);

ALTER TABLE `modulos`
  ADD PRIMARY KEY (`idmodulos`);

ALTER TABLE `permisos`
  ADD PRIMARY KEY (`idpermisos`),
  ADD KEY `idmodulos_idx` (`id_modulos`);

ALTER TABLE `persona`
  ADD PRIMARY KEY (`codigo`);

ALTER TABLE `producto`
  ADD PRIMARY KEY (`codProducto`);

ALTER TABLE `rol`
  ADD PRIMARY KEY (`idrol`);

ALTER TABLE `rol_permiso`
  ADD PRIMARY KEY (`idrol_permiso`),
  ADD KEY `id_permiso_idx` (`id_permiso`),
  ADD KEY `idrol_idx` (`id_rol`);

ALTER TABLE `seguimiento`
  ADD PRIMARY KEY (`idseguimiento`);

ALTER TABLE `thema`
  ADD PRIMARY KEY (`idthema`);

ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`idusuarios`);


ALTER TABLE `clientes`
  MODIFY `idclientes` int(11) NOT NULL AUTO_INCREMENT COMMENT 'El idclientes se cruza con el campo id de la tabla imagenes para sacar la imagen blob', AUTO_INCREMENT=165;
ALTER TABLE `detallefactura`
  MODIFY `codDetalle` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
ALTER TABLE `factura`
  MODIFY `codFactura` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
ALTER TABLE `imagen`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `imagenes`
  MODIFY `idimagenes` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
ALTER TABLE `modulos`
  MODIFY `idmodulos` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
ALTER TABLE `permisos`
  MODIFY `idpermisos` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;
ALTER TABLE `persona`
  MODIFY `codigo` int(4) NOT NULL AUTO_INCREMENT;
ALTER TABLE `producto`
  MODIFY `codProducto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;
ALTER TABLE `rol`
  MODIFY `idrol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
ALTER TABLE `rol_permiso`
  MODIFY `idrol_permiso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=97;
ALTER TABLE `seguimiento`
  MODIFY `idseguimiento` int(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `thema`
  MODIFY `idthema` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
ALTER TABLE `usuarios`
  MODIFY `idusuarios` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

ALTER TABLE `detallefactura`
  ADD CONSTRAINT `FK_detalle_Factura` FOREIGN KEY (`codFactura`) REFERENCES `factura` (`codFactura`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_detalle_producto` FOREIGN KEY (`codProducto`) REFERENCES `producto` (`codProducto`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `factura`
  ADD CONSTRAINT `FK_factura_cliente` FOREIGN KEY (`idclientes`) REFERENCES `clientes` (`idclientes`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_factura_usuario` FOREIGN KEY (`idusuarios`) REFERENCES `usuarios` (`idusuarios`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `permisos`
  ADD CONSTRAINT `idmodulos` FOREIGN KEY (`id_modulos`) REFERENCES `modulos` (`idmodulos`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `rol_permiso`
  ADD CONSTRAINT `idpermisos` FOREIGN KEY (`id_permiso`) REFERENCES `permisos` (`idpermisos`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `idrol` FOREIGN KEY (`id_rol`) REFERENCES `rol` (`idrol`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
