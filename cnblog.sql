-- MySQL dump 10.13  Distrib 5.6.40, for Win64 (x86_64)
--
-- Host: localhost    Database: cnblog
-- ------------------------------------------------------
-- Server version	5.6.40

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can add permission',2,'add_permission'),(5,'Can change permission',2,'change_permission'),(6,'Can delete permission',2,'delete_permission'),(7,'Can add group',3,'add_group'),(8,'Can change group',3,'change_group'),(9,'Can delete group',3,'delete_group'),(10,'Can add content type',4,'add_contenttype'),(11,'Can change content type',4,'change_contenttype'),(12,'Can delete content type',4,'delete_contenttype'),(13,'Can add session',5,'add_session'),(14,'Can change session',5,'change_session'),(15,'Can delete session',5,'delete_session'),(16,'Can add user',6,'add_userinfo'),(17,'Can change user',6,'change_userinfo'),(18,'Can delete user',6,'delete_userinfo'),(19,'Can add article',7,'add_article'),(20,'Can change article',7,'change_article'),(21,'Can delete article',7,'delete_article'),(22,'Can add article2 tag',8,'add_article2tag'),(23,'Can change article2 tag',8,'change_article2tag'),(24,'Can delete article2 tag',8,'delete_article2tag'),(25,'Can add article up down',9,'add_articleupdown'),(26,'Can change article up down',9,'change_articleupdown'),(27,'Can delete article up down',9,'delete_articleupdown'),(28,'Can add blog',10,'add_blog'),(29,'Can change blog',10,'change_blog'),(30,'Can delete blog',10,'delete_blog'),(31,'Can add category',11,'add_category'),(32,'Can change category',11,'change_category'),(33,'Can delete category',11,'delete_category'),(34,'Can add comment',12,'add_comment'),(35,'Can change comment',12,'change_comment'),(36,'Can delete comment',12,'delete_comment'),(37,'Can add tag',13,'add_tag'),(38,'Can change tag',13,'change_tag'),(39,'Can delete tag',13,'delete_tag');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog_article`
--

DROP TABLE IF EXISTS `blog_article`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blog_article` (
  `nid` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `desc` varchar(255) NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `content` longtext NOT NULL,
  `comment_count` int(11) NOT NULL,
  `up_count` int(11) NOT NULL,
  `down_count` int(11) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`nid`),
  KEY `blog_article_category_id_7e38f15e_fk_blog_category_nid` (`category_id`),
  KEY `blog_article_user_id_5beb0cc1_fk_blog_userinfo_nid` (`user_id`),
  CONSTRAINT `blog_article_category_id_7e38f15e_fk_blog_category_nid` FOREIGN KEY (`category_id`) REFERENCES `blog_category` (`nid`),
  CONSTRAINT `blog_article_user_id_5beb0cc1_fk_blog_userinfo_nid` FOREIGN KEY (`user_id`) REFERENCES `blog_userinfo` (`nid`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_article`
--

LOCK TABLES `blog_article` WRITE;
/*!40000 ALTER TABLE `blog_article` DISABLE KEYS */;
INSERT INTO `blog_article` VALUES (2,'java面试感悟【一】','我最终选择不包装工作经验，或许是因为我怂，或许是因为一些莫名其妙的坚持…… 然而结果就是在boss上沟通了20多家，只有7家让我投了简历，1家跟我说要我发个时间段给他稍后告诉我面试时间，然后就没有然后了。只有一家开4-5k的让我过去面试。 我感觉我的经历也不算太差啊，五年专科，计算机应用基础专业，虽 ...','2018-07-27 13:27:55.293825','xtu熊大\r\n面向接口编程\r\n\r\n面向接口编程\r\n这里要举一个很简单的例子来介绍面向接口编程。\r\n\r\n我这次花时间记录下这个例子，是想提醒自己平时写代码的时候不要为了完成任务而敲代码，仅仅实现功能的代码没用的。\r\n\r\n我通过这段时间的实习，总结出自己写代码的一些不足：\r\n\r\n1.接到需求之后，只是考虑采用什么技术来实现，一想到就开始敲代码，啥也不考虑了。其实要考虑的东西有很多，比如：性能，日志，通用性，可读性\r\n\r\n比如性能方面：hashmap的性能比hashtable就要强很多，hashtable的优势只是线程安全，但并发情况下往往用currenHashMap,它并发性高于hashmap,性能高过hashtable\r\n\r\n比如日志方面：得养成打日志的习惯，举个上周五的例子，线上的邮件系统炸了，结果服务器上查日志根本看不出哪里出问题，我又得回来本地测试环境找问题，这就是没养成打日志习惯的弊端\r\n\r\n通用性：面向接口编程就是实现通用编程的一个方法，待会下面会放出一个例子\r\n\r\n可读性：方法的文档注释，命名规范等等（优秀的代码，别人单看看代码就能熟悉整个业务流程，所以命名很重要）\r\n\r\n \r\n\r\n接下来，言归正传，下面举个面向接口编程的例子：\r\n\r\n复制代码\r\npackage com.xiongda.interfacecode;\r\n\r\n/**\r\n * \r\n * @author xiongda\r\n * @date 2018年8月4日\r\n * @description 面向接口编程例子\r\n *  主机 连接外设进行工作 \r\n *  键盘 ：插入主机进行工作 \r\n *  鼠标 ：插入主机进行工作\r\n */\r\ninterface OuterDevice {\r\n    void work();\r\n}\r\n\r\nclass Keyboard implements OuterDevice {\r\n    public void work() {\r\n        System.out.println(\"键盘开始工作！\");\r\n    }\r\n}\r\n\r\nclass Mouse implements OuterDevice {\r\n    public void work() {\r\n        System.out.println(\"鼠标开始工作！\");\r\n    }\r\n}\r\n\r\nclass Host {\r\n    public void connectTo(OuterDevice outerDevice) {\r\n        outerDevice.work();\r\n    }\r\n}\r\n\r\npublic class Device {\r\n    public static void main(String[] args) {\r\n\r\n        Host host = new Host();\r\n        OuterDevice keyboard = new Keyboard();\r\n        host.connectTo(keyboard);\r\n        OuterDevice mouse = new Mouse();\r\n        host.connectTo(mouse);\r\n    }\r\n}\r\n复制代码\r\n键盘和鼠标都属于外设，需要连接主机进行工作。所以键盘和鼠标这些应该作为同一类，而不是一堆方法，连接鼠标，连接键盘。。。。。\r\n\r\n所以这时候就需要定义一定的规范，而接口就是一种规范。\r\n\r\n例子很简单，一看就明白，但我希望自己能够在平时敲代码的时候养成这种思想，考虑通用编程，而不是等一堆东西凑起来的时候才发现这里可以改成通用的。\r\n\r\n（新的8月份，好好努力！）\r\n\r\n务实，说实话！\r\n分类: java\r\n好文要顶 关注我 收藏该文    \r\nxtu熊大\r\n关注 - 1\r\n粉丝 - 4\r\n+加关注\r\n0 0\r\n« 上一篇：Springboot整合FreeMarker\r\nposted on 2018-08-04 22:48 xtu熊大 阅读(5) 评论(0) 编辑 收藏\r\n\r\n刷新评论刷新页面返回顶部\r\n发表评论\r\n昵称：\r\nvenicid\r\n\r\n评论内容：引用 粗体 链接 缩进 代码 图片\r\n\r\n 提交评论 退出 订阅评论\r\n\r\n[Ctrl+Enter快捷键提交]\r\n\r\n【推荐】超50万VC++源码: 大型组态工控、电力仿真CAD与GIS源码库！\r\n【前端】SpreadJS表格控件，可嵌入应用开发的在线Excel\r\n【推荐】如何快速搭建人工智能应用？\r\nqcloud\r\n最新IT新闻:\r\n· Microsoft Edge浏览器有了新的产品经理 来自OneNote团队\r\n· 起立时感觉头晕眼花？这预示你患痴呆的风险更高\r\n· 余承东：要有王者之气 我的团队在任何领域都要成为王者\r\n· 谷歌地图迎来比例更加精确的地球仪模式\r\n· 微软用图表展示Windows 10的每一次更新涉及到的组件\r\n» 更多新闻...\r\n最新知识库文章:\r\n· 如何提高一个研发团队的“代码速度”？\r\n· 成为一个有目标的学习者\r\n· 历史转折中的“杭派工程师”\r\n· 如何提高代码质量？\r\n· 在腾讯的八年，我的职业思考\r\n» 更多知识库文章...\r\n导航\r\n博客园 首页 联系 订阅 管理\r\n<	2018年8月	>\r\n日	一	二	三	四	五	六\r\n29	30	31	1	2	3	4\r\n5	6	7	8	9	10	11\r\n12	13	14	15	16	17	18\r\n19	20	21	22	23	24	25\r\n26	27	28	29	30	31	1\r\n2	3	4	5	6	7	8\r\n公告\r\n昵称：xtu熊大\r\n园龄：6个月\r\n粉丝：4\r\n关注：1\r\n+加关注\r\n统计\r\n随笔 - 72 文章 - 0 评论 - 13\r\n搜索\r\n\r\n 找找看\r\n\r\n 谷歌搜索\r\n常用链接\r\n我的随笔\r\n我的评论\r\n我的参与\r\n最新评论\r\n我的标签\r\n我的标签\r\n指针(6)\r\ncss(4)\r\n题解(4)\r\nxml(2)\r\n结构体(2)\r\nHTML(2)\r\njson(2)\r\nspring(1)\r\n问题(1)\r\n随笔分类\r\nandroid(2)\r\ncss(6)\r\nC语言(9)\r\nhtml(2)\r\njava(36)\r\njavascript(2)\r\nJSP(3)\r\nphp(1)\r\n算法与数据结构(4)\r\n项目(2)\r\n随笔档案\r\n2018年7月 (1)\r\n2018年6月 (4)\r\n2018年5月 (13)\r\n2018年4月 (8)\r\n2018年3月 (13)\r\n2018年2月 (17)\r\n2018年1月 (16)\r\n最新评论\r\n1. Re:Springboot整合FreeMarker\r\n@沉默成名感谢支持，我会努力的...\r\n--xtu熊大\r\n2. Re:Springboot整合FreeMarker\r\n写的很好，加油！\r\n--沉默成名\r\n3. Re:android小程序之幸运菜谱\r\n@黎泽糖醋排骨...\r\n--xtu熊大\r\n4. Re:android小程序之幸运菜谱\r\n7，我的幸运数。\r\n--黎泽\r\n5. Re:JAVA简便解析json文件\r\n直接用java对象解析很方便！\r\n--星月神话131452\r\n阅读排行榜\r\n1. 通过指针引用字符串(148)\r\n2. 时间复杂度为O（logN）的常用算法(146)\r\n3. 简单创建json格式文件(140)\r\n4. android小程序之幸运菜谱(139)\r\n5. JAVA简便解析json文件(136)\r\n评论排行榜\r\n1. 刚开博客，谈谈计划！(6)\r\n2. android小程序之幸运菜谱(2)\r\n3. Springboot整合FreeMarker(2)\r\n4. JAVA简便解析json文件(1)\r\n5. 返回指针值的函数小练习--处理学生成绩(1)\r\n推荐排行榜\r\n1. 数组排序算法(1)\r\n2. 对象与引用(1)\r\n3. swing 之简单登录窗体实现(1)\r\n4. JAVA简便解析json文件(1)\r\n5. 刚开博客，谈谈计划！(1)\r\nPowered by: \r\n博客园 \r\nCopyright © xtu熊大',1,2,0,3,15),(5,'实例 可以把它们应用到按钮、工具条中的按钮组、导航或输入框等地方。    Star Star Sta','fs：一种虚拟内存文件系统，它会将所有的文件存储在虚拟内存中，如果你将tmpfs文件系统卸载后，那么其下的所有的内容将不复存在。tmpfs既可以使用RAM，也可以使用交换分区，会根据你的实际需要而改变大小。tmpfs的速度非常惊人，毕竟它是驻留在RAM中的，即使用了交换分区，性能仍然非常卓越。由于t','2018-07-27 16:20:22.840212','<span style=\"color:#333333;font-family:verdana, Arial, Helvetica, sans-serif;font-size:13.3333px;background-color:#FFFFFF;\">fs：一种虚拟内存文件系统，它会将所有的文件存储在虚拟内存中，如果你将tmpfs文件系统卸载后，那么其下的所有的内容将不复存在。tmpfs既可以使用RAM，也可以使用交换分区，会根据你的实际需要而改变大小。tmpfs的速度非常惊人，毕竟它是驻留在RAM中的，即使用了交换分区，性能仍然非常卓越。由于tmpfs是驻留在RAM的，因此它的内容是不持久的。断电后，tmpfs的</span><br/>',3,0,0,5,15),(13,'自定义分页器','3、自定义分页器   分页器Paginator.py   解耦   from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger4、记录日志log   settings配置文件，终端打','2018-08-08 11:09:35.319853','<pre>3、自定义分页器\r\n\r\n   分页器Paginator.py\r\n   解耦\r\n   from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger\r\n\r\n4、记录日志log\r\n\r\n   settings配置文件，终端打印sql语句\r\n   mylog.py 日志文件，解耦，终端打印并在log文件记录用户操作\r\n   import logging\r\n\r\n5、模板继承\r\n\r\n    {% extends \'base.html\' %}\r\n\r\n    {% block site-header %}\r\n    {% endblock %}\r\n\r\n\r\n6、ORM表关系\r\n\r\n        一对一(author authordetail)\r\n      删除author，对应删除authordetail表的信息\r\n</pre>',5,1,0,1,13),(14,'图书主页','1)图书主页            /book/index/        2)图书操作            /book/book_list/        # 图书list            /book/add_book/         # 添加图书','2018-08-08 11:17:26.815041','<pre>        1)图书主页\r\n            /book/index/\r\n        2)图书操作\r\n            /book/book_list/        # 图书list\r\n            /book/add_book/         # 添加图书\r\n            /book/edit_book/30/     # 编辑图书\r\n            /delete_book/30/        # 删除图书\r\n        3)作者操作\r\n            /book/author_list/       # 作者list\r\n            /book/add_author/        # 添加作者\r\n            /book/edit_author/15/    # 编辑作者\r\n            /book/delete_author/15/  # 删除作者\r\n            /book/author2book/15/    # 查看该作者出版过的所有图书\r\n        4)出版社操作\r\n            /book/publish_list/       # 出版社list\r\n            /book/add_publish/        # 添加出版社\r\n            /book/edit_publish/16/    # 编辑出版社\r\n            /book/delete_publish/16/  # 删除出版社\r\n            /book/publish2book/16/    # 查看该出版社出版过的所有图书\r\n\r\n    404错误\r\n            /^.*/       # url not found</pre>',0,0,0,1,13),(15,'44444','11111dfasfsda','2018-08-08 12:24:10.365346','11111dfasfsda',2,3,0,1,13),(18,'魅族手机','妹子手机','2018-08-08 16:13:53.473626','妹子手机',1,1,0,4,13),(19,'虾米音乐','请您打开CMD控制台，到依赖包同目录下，执行：pip install -r requirements.txt  4、测试用例文档给您提供了更好的测试思路，您可以通过测试用例达到更好的测试效果','2018-08-08 16:26:07.462002','*注意事项：**\r\n\r\n1、相关文件说明：\r\n\r\n    flow.png          项目流程图\r\n    tree.txt          该项目的所有文件\r\n    requirements.txt  依赖包文件\r\n    img-floder        项目效果图\r\n\r\n2、环境安装：\r\n\r\n    请您在python官网下载python3.5以上版本进行安装。\r\n\r\n3、当前程序的所有依赖包及其精确版本号。\r\n\r\n    请您打开CMD控制台，到依赖包同目录下，执行：pip install -r requirements.txt\r\n\r\n4、测试用例文档给您提供了更好的测试思路，您可以通过测试用例达到更好的测试效果\r\n\r\n5、该项目博客地址:\r\n   [http://www.cnblogs.com/venicid/p/9286796.html]\r\n\r\n6、github地址：\r\n   [https://github.com/venicid/BMS]\r\n\r\n7、效果图\r\n\r\n   ![BMS效果图](https://github.com/venicid/BMS/blob/master/img-floder/book_index.png)',1,0,2,7,16),(20,'斗鱼直播','业需求: 1.列出图书列表、出版社列表、作者列表 2.点击作者，会列出其出版的图书列表 3.点击出版社，会列出旗下图书列表 4.可以创建、修改、删除 图书、作者、出版社   踩分点: 1.满足需求1，2，3，4 得分85','2018-08-08 16:26:30.727934','业需求:\r\n1.列出图书列表、出版社列表、作者列表\r\n2.点击作者，会列出其出版的图书列表\r\n3.点击出版社，会列出旗下图书列表\r\n4.可以创建、修改、删除 图书、作者、出版社\r\n\r\n\r\n踩分点:\r\n1.满足需求1，2，3，4 得分85',8,0,2,6,17),(21,'adfsaf','dsafdsafa','2018-08-08 16:52:37.050419','dsafdsafa',1,1,0,NULL,13);
/*!40000 ALTER TABLE `blog_article` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog_article2tag`
--

DROP TABLE IF EXISTS `blog_article2tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blog_article2tag` (
  `nid` int(11) NOT NULL AUTO_INCREMENT,
  `article_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  PRIMARY KEY (`nid`),
  UNIQUE KEY `blog_article2tag_article_id_tag_id_b0745f42_uniq` (`article_id`,`tag_id`),
  KEY `blog_article2tag_tag_id_389b9a96_fk_blog_tag_nid` (`tag_id`),
  CONSTRAINT `blog_article2tag_article_id_753a2b60_fk_blog_article_nid` FOREIGN KEY (`article_id`) REFERENCES `blog_article` (`nid`),
  CONSTRAINT `blog_article2tag_tag_id_389b9a96_fk_blog_tag_nid` FOREIGN KEY (`tag_id`) REFERENCES `blog_tag` (`nid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_article2tag`
--

LOCK TABLES `blog_article2tag` WRITE;
/*!40000 ALTER TABLE `blog_article2tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `blog_article2tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog_articleupdown`
--

DROP TABLE IF EXISTS `blog_articleupdown`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blog_articleupdown` (
  `nid` int(11) NOT NULL AUTO_INCREMENT,
  `is_up` tinyint(1) NOT NULL,
  `article_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`nid`),
  UNIQUE KEY `blog_articleupdown_article_id_user_id_fa3d0c08_uniq` (`article_id`,`user_id`),
  KEY `blog_articleupdown_user_id_2c0ebe49_fk_blog_userinfo_nid` (`user_id`),
  CONSTRAINT `blog_articleupdown_article_id_9be1a8a2_fk_blog_article_nid` FOREIGN KEY (`article_id`) REFERENCES `blog_article` (`nid`),
  CONSTRAINT `blog_articleupdown_user_id_2c0ebe49_fk_blog_userinfo_nid` FOREIGN KEY (`user_id`) REFERENCES `blog_userinfo` (`nid`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_articleupdown`
--

LOCK TABLES `blog_articleupdown` WRITE;
/*!40000 ALTER TABLE `blog_articleupdown` DISABLE KEYS */;
INSERT INTO `blog_articleupdown` VALUES (4,1,13,13),(5,1,18,13),(6,1,15,NULL),(7,0,20,13),(8,1,15,13),(9,0,19,13),(10,1,15,15),(11,1,21,15);
/*!40000 ALTER TABLE `blog_articleupdown` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog_blog`
--

DROP TABLE IF EXISTS `blog_blog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blog_blog` (
  `nid` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(64) NOT NULL,
  `site_name` varchar(64) NOT NULL,
  `theme` varchar(32) NOT NULL,
  PRIMARY KEY (`nid`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_blog`
--

LOCK TABLES `blog_blog` WRITE;
/*!40000 ALTER TABLE `blog_blog` DISABLE KEYS */;
INSERT INTO `blog_blog` VALUES (1,'jack的博客','jack','jack.css'),(2,'alex的博客','alex','alex.css'),(3,'zhang的博客','zhang','张发大水发散'),(4,'zhou的博客','zhou','zhoufdsafasf'),(5,'ming的博客','ming','ming的css');
/*!40000 ALTER TABLE `blog_blog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog_category`
--

DROP TABLE IF EXISTS `blog_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blog_category` (
  `nid` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(32) NOT NULL,
  `blog_id` int(11) NOT NULL,
  PRIMARY KEY (`nid`),
  KEY `blog_category_blog_id_80f0723a_fk_blog_blog_nid` (`blog_id`),
  CONSTRAINT `blog_category_blog_id_80f0723a_fk_blog_blog_nid` FOREIGN KEY (`blog_id`) REFERENCES `blog_blog` (`nid`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_category`
--

LOCK TABLES `blog_category` WRITE;
/*!40000 ALTER TABLE `blog_category` DISABLE KEYS */;
INSERT INTO `blog_category` VALUES (1,'alex的IT',2),(3,'jack的面试',1),(4,'alex的Html',2),(5,'jack的css',1),(6,'zhang的phone',3),(7,'zhhou的面',4),(8,'ming的IT',5);
/*!40000 ALTER TABLE `blog_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog_comment`
--

DROP TABLE IF EXISTS `blog_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blog_comment` (
  `nid` int(11) NOT NULL AUTO_INCREMENT,
  `content` varchar(255) NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `article_id` int(11) NOT NULL,
  `parent_comment_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`nid`),
  KEY `blog_comment_article_id_3d58bca6_fk_blog_article_nid` (`article_id`),
  KEY `blog_comment_parent_comment_id_26791b9a_fk_blog_comment_nid` (`parent_comment_id`),
  KEY `blog_comment_user_id_59a54155_fk_blog_userinfo_nid` (`user_id`),
  CONSTRAINT `blog_comment_article_id_3d58bca6_fk_blog_article_nid` FOREIGN KEY (`article_id`) REFERENCES `blog_article` (`nid`),
  CONSTRAINT `blog_comment_parent_comment_id_26791b9a_fk_blog_comment_nid` FOREIGN KEY (`parent_comment_id`) REFERENCES `blog_comment` (`nid`),
  CONSTRAINT `blog_comment_user_id_59a54155_fk_blog_userinfo_nid` FOREIGN KEY (`user_id`) REFERENCES `blog_userinfo` (`nid`)
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_comment`
--

LOCK TABLES `blog_comment` WRITE;
/*!40000 ALTER TABLE `blog_comment` DISABLE KEYS */;
INSERT INTO `blog_comment` VALUES (1,'666','2018-08-05 15:13:47.137410',2,NULL,13),(21,'111','2018-08-05 16:09:09.219720',2,NULL,13),(24,'都是分散','2018-08-05 16:29:24.442039',2,NULL,13),(27,'萨达','2018-08-05 16:30:40.462073',2,NULL,13),(28,'第三方大师','2018-08-05 16:35:45.627406',2,21,13),(29,'123','2018-08-05 16:40:36.806392',2,28,13),(30,'爱的色放三','2018-08-05 16:40:55.800115',2,28,13),(31,'特回事','2018-08-05 17:59:39.816538',2,28,13),(32,'this is 邮件测试','2018-08-06 10:02:23.910507',2,NULL,13),(33,'email   test','2018-08-06 10:03:09.440629',2,NULL,13),(34,'email  test2222','2018-08-06 10:07:23.524666',2,NULL,13),(35,'test ','2018-08-06 10:11:13.721701',2,NULL,13),(36,'test ','2018-08-06 10:13:42.456149',2,NULL,13),(37,'dfasfdsa','2018-08-06 10:13:44.831207',2,NULL,13),(38,'test email','2018-08-06 10:20:59.841158',2,NULL,13),(39,'test111','2018-08-06 10:22:21.241169',2,NULL,13),(40,'this is test1111','2018-08-06 10:23:17.129359',2,NULL,13),(41,'','2018-08-06 10:26:12.630444',2,NULL,13),(42,'托尔斯泰','2018-08-06 10:26:17.004570',2,NULL,13),(43,'11111','2018-08-06 10:27:13.221140',2,NULL,13),(44,'2222','2018-08-06 10:27:57.143123',2,NULL,13),(45,'铁素体斯特','2018-08-06 10:28:21.317941',2,NULL,13),(46,'阿范德萨范德萨','2018-08-06 10:30:57.382420',2,NULL,13),(47,'111111','2018-08-06 10:54:15.189313',5,NULL,13),(48,'222222','2018-08-06 10:54:29.820811',5,47,13),(49,'ddddd','2018-08-06 10:57:58.549836',5,47,13),(50,'dasfsa','2018-08-06 10:58:10.457658',5,49,13),(55,'22222','2018-08-08 11:15:47.940008',13,NULL,13),(56,'dddd','2018-08-08 11:16:34.267315',13,NULL,13),(57,'dfasfsa','2018-08-08 11:16:39.567270',13,55,13),(58,'4444','2018-08-08 16:12:48.427013',2,NULL,17),(59,'1111','2018-08-08 16:32:42.522766',13,NULL,13),(60,'1111','2018-08-08 16:33:09.717823',18,NULL,13),(61,'111111','2018-08-08 16:52:54.222904',5,NULL,13),(62,'fdsafsa','2018-08-08 16:53:00.666234',5,61,13),(63,'1111','2018-08-08 22:11:53.236194',13,NULL,13),(64,'111','2018-08-08 22:14:49.861745',19,NULL,13),(65,'11111','2018-08-09 17:16:21.566408',20,NULL,13),(66,'1111','2018-08-09 17:17:25.085741',5,NULL,13),(67,'6666','2018-08-09 17:23:10.350413',20,NULL,13),(68,'6666','2018-08-09 17:23:37.741453',20,NULL,13),(69,'','2018-08-09 17:23:49.014829',20,NULL,13),(70,'','2018-08-09 17:24:25.717234',20,NULL,13),(71,'','2018-08-09 17:24:29.632833',20,NULL,13),(72,'6666','2018-08-09 17:24:50.865388',20,NULL,13),(73,'','2018-08-09 17:24:54.443358',20,NULL,13),(74,'66666','2018-08-09 17:33:06.645642',15,NULL,13),(75,'44444','2018-08-09 17:35:33.970878',15,74,15),(76,'6666','2018-08-09 17:41:24.835227',21,NULL,15);
/*!40000 ALTER TABLE `blog_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog_tag`
--

DROP TABLE IF EXISTS `blog_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blog_tag` (
  `nid` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(32) NOT NULL,
  `blog_id` int(11) NOT NULL,
  PRIMARY KEY (`nid`),
  KEY `blog_tag_blog_id_a8c60c42_fk_blog_blog_nid` (`blog_id`),
  CONSTRAINT `blog_tag_blog_id_a8c60c42_fk_blog_blog_nid` FOREIGN KEY (`blog_id`) REFERENCES `blog_blog` (`nid`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_tag`
--

LOCK TABLES `blog_tag` WRITE;
/*!40000 ALTER TABLE `blog_tag` DISABLE KEYS */;
INSERT INTO `blog_tag` VALUES (1,'python之路',2),(2,'明天憧憬',1),(3,'oppo手机',3),(4,'抄袭面',4),(5,'ming的生活',5);
/*!40000 ALTER TABLE `blog_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog_userinfo`
--

DROP TABLE IF EXISTS `blog_userinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blog_userinfo` (
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `nid` int(11) NOT NULL AUTO_INCREMENT,
  `telephone` varchar(11) DEFAULT NULL,
  `avatar` varchar(100) NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `blog_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`nid`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `telephone` (`telephone`),
  UNIQUE KEY `blog_id` (`blog_id`),
  CONSTRAINT `blog_userinfo_blog_id_aa34488f_fk_blog_blog_nid` FOREIGN KEY (`blog_id`) REFERENCES `blog_blog` (`nid`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_userinfo`
--

LOCK TABLES `blog_userinfo` WRITE;
/*!40000 ALTER TABLE `blog_userinfo` DISABLE KEYS */;
INSERT INTO `blog_userinfo` VALUES ('pbkdf2_sha256$100000$fDLaoHIQZSg9$0fOYkKbdpBs0+vTAWdI48nEuDxc1NdMZ0ozuJdWuWWM=','2018-08-09 17:32:56.841023',0,'alex','','','1234@qq.com',0,1,'2018-07-27 09:30:59.000000',13,'15132125','avatars/default.jpg','2018-07-27 09:30:59.233553',2),('pbkdf2_sha256$100000$7jMouaoVu8PS$EaOXEzFRJ/oBmri2kiGZv/WJnCt1gX+beTjm4zZdOfs=','2018-08-08 16:57:38.343198',1,'tom','','','',1,1,'2018-07-27 12:57:17.999260',14,NULL,'avatars/default.jpg','2018-07-27 12:57:18.080314',NULL),('pbkdf2_sha256$100000$39w8M061HM7H$VvmYPBh9BjdQ2Zz+VGoa4OViJUKtv+2k3JLY/G9c/ng=','2018-08-09 17:35:25.302407',0,'jack','','','1234@qq.com',0,1,'2018-07-27 13:05:59.000000',15,'48641651','avatars/qishi.png','2018-07-27 13:05:59.688005',1),('pbkdf2_sha256$100000$Rbk5v4yLgRP5$V40ipABPoOYt74bdI+lAMx1dUAKgNwM8JkGCodfHAHM=','2018-08-07 18:23:25.000000',0,'zhou','','','1234@qq.com',0,1,'2018-08-07 18:16:02.000000',16,'2343654654','avatars/8f0f0dbc1d90fc6e373d251d554490a.jpg','2018-08-07 18:16:02.698276',4),('pbkdf2_sha256$100000$2obVttXld8bW$oqESSkPPLEyeaKji3XCIP3NYmFYiv5rL92ziS0xkR5w=','2018-08-08 16:11:08.000000',0,'zhang','','','1234@qq.com',0,1,'2018-08-08 16:10:28.000000',17,'18941534','avatars/0d62ca712c1f6fcf856711101307d47.png','2018-08-08 16:10:28.140261',3),('pbkdf2_sha256$100000$mfkAJ2Hg0EFA$7ZGFjeKNwCgkoUegyS7s8x7ORgKQQV97ty5bdRFpHRg=','2018-08-09 15:58:52.035269',0,'ming','','','1234@qq.com',0,1,'2018-08-09 15:58:43.969584',18,NULL,'/avatars/default.png','2018-08-09 15:58:44.054641',5);
/*!40000 ALTER TABLE `blog_userinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog_userinfo_groups`
--

DROP TABLE IF EXISTS `blog_userinfo_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blog_userinfo_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userinfo_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `blog_userinfo_groups_userinfo_id_group_id_5f60ecec_uniq` (`userinfo_id`,`group_id`),
  KEY `blog_userinfo_groups_group_id_1fb5e93a_fk_auth_group_id` (`group_id`),
  CONSTRAINT `blog_userinfo_groups_group_id_1fb5e93a_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `blog_userinfo_groups_userinfo_id_f6f0498b_fk_blog_userinfo_nid` FOREIGN KEY (`userinfo_id`) REFERENCES `blog_userinfo` (`nid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_userinfo_groups`
--

LOCK TABLES `blog_userinfo_groups` WRITE;
/*!40000 ALTER TABLE `blog_userinfo_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `blog_userinfo_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog_userinfo_user_permissions`
--

DROP TABLE IF EXISTS `blog_userinfo_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blog_userinfo_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userinfo_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `blog_userinfo_user_permi_userinfo_id_permission_i_7d343093_uniq` (`userinfo_id`,`permission_id`),
  KEY `blog_userinfo_user_p_permission_id_ace80f7e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `blog_userinfo_user_p_permission_id_ace80f7e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `blog_userinfo_user_p_userinfo_id_57e76697_fk_blog_user` FOREIGN KEY (`userinfo_id`) REFERENCES `blog_userinfo` (`nid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_userinfo_user_permissions`
--

LOCK TABLES `blog_userinfo_user_permissions` WRITE;
/*!40000 ALTER TABLE `blog_userinfo_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `blog_userinfo_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_blog_userinfo_nid` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_blog_userinfo_nid` FOREIGN KEY (`user_id`) REFERENCES `blog_userinfo` (`nid`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2018-07-27 13:07:33.713238','1','jack的博客',1,'[{\"added\": {}}]',10,14),(2,'2018-07-27 13:07:48.518268','2','alex',1,'[{\"added\": {}}]',10,14),(3,'2018-07-27 13:08:01.250698','2','alex的博客',2,'[{\"changed\": {\"fields\": [\"title\", \"site_name\"]}}]',10,14),(4,'2018-07-27 13:11:23.487608','1','IT',1,'[{\"added\": {}}]',11,14),(5,'2018-07-27 13:11:25.041639','1','设计模式（二十三）—— 模板方法',1,'[{\"added\": {}}]',7,14),(6,'2018-07-27 13:26:39.344595','2','IT',1,'[{\"added\": {}}]',11,14),(7,'2018-07-27 13:27:13.738882','1','设计模式（二十三）—— 模板方法',2,'[{\"changed\": {\"fields\": [\"category\"]}}]',7,14),(8,'2018-07-27 13:27:53.728635','3','面试',1,'[{\"added\": {}}]',11,14),(9,'2018-07-27 13:27:55.293825','2','java面试感悟【一】',1,'[{\"added\": {}}]',7,14),(10,'2018-07-27 13:28:23.425249','2','IT',3,'',11,14),(11,'2018-07-27 13:28:51.868123','3','爬取百万数据的采集系统从零到整的过程',1,'[{\"added\": {}}]',7,14),(12,'2018-07-27 13:31:24.998276','13','alex',2,'[{\"changed\": {\"fields\": [\"telephone\", \"blog\"]}}]',6,14),(13,'2018-07-27 13:32:02.275991','15','jack',2,'[{\"changed\": {\"fields\": [\"telephone\", \"blog\"]}}]',6,14),(14,'2018-07-27 16:18:53.504969','4','alex的Html',1,'[{\"added\": {}}]',11,14),(15,'2018-07-27 16:19:11.519886','4','只对内容为空的元素起作用',1,'[{\"added\": {}}]',7,14),(16,'2018-07-27 16:19:57.016064','5','jack的css',1,'[{\"added\": {}}]',11,14),(17,'2018-07-27 16:20:22.841211','5','实例 可以把它们应用到按钮、工具条中的按钮组、导航或输入框等地方。    Star Star Sta',1,'[{\"added\": {}}]',7,14),(18,'2018-07-27 16:26:44.212594','1','python之路',1,'[{\"added\": {}}]',13,14),(19,'2018-07-27 16:27:00.347232','2','明天憧憬',1,'[{\"added\": {}}]',13,14),(20,'2018-07-27 16:27:42.974652','5','实例 可以把它们应用到按钮、工具条中的按钮组、导航或输入框等地方。    Star Star Sta',2,'[]',7,14),(21,'2018-07-27 16:28:04.441328','1','java面试感悟【一】---明天憧憬',1,'[{\"added\": {}}]',8,14),(22,'2018-07-27 16:28:13.319220','2','只对内容为空的元素起作用---明天憧憬',1,'[{\"added\": {}}]',8,14),(23,'2018-07-27 16:28:20.067561','3','爬取百万数据的采集系统从零到整的过程---python之路',1,'[{\"added\": {}}]',8,14),(24,'2018-07-27 16:28:27.335141','4','实例 可以把它们应用到按钮、工具条中的按钮组、导航或输入框等地方。    Star Star Sta---python之路',1,'[{\"added\": {}}]',8,14),(25,'2018-08-08 16:18:30.788604','3','zhang的博客',1,'[{\"added\": {}}]',10,14),(26,'2018-08-08 16:18:43.058640','17','zhang',2,'[{\"changed\": {\"fields\": [\"telephone\", \"blog\"]}}]',6,14),(27,'2018-08-08 16:19:06.854697','4','zhou的博客',1,'[{\"added\": {}}]',10,14),(28,'2018-08-08 16:19:08.341922','16','zhou',2,'[{\"changed\": {\"fields\": [\"telephone\", \"blog\"]}}]',6,14),(29,'2018-08-08 16:22:15.750943','3','oppo手机',1,'[{\"added\": {}}]',13,14),(30,'2018-08-08 16:22:40.296509','4','抄袭面',1,'[{\"added\": {}}]',13,14),(31,'2018-08-08 16:22:58.808055','6','zhang的phone',1,'[{\"added\": {}}]',11,14),(32,'2018-08-08 16:23:16.016680','7','zhhou的面',1,'[{\"added\": {}}]',11,14),(33,'2018-08-08 16:23:36.554342','18','魅族手机',2,'[{\"changed\": {\"fields\": [\"category\"]}}]',7,14),(34,'2018-08-08 16:23:50.669746','15','44444',2,'[{\"changed\": {\"fields\": [\"category\"]}}]',7,14),(35,'2018-08-08 16:23:59.715678','14','图书主页',2,'[{\"changed\": {\"fields\": [\"desc\", \"category\"]}}]',7,14),(36,'2018-08-08 16:24:04.497336','13','自定义分页器',2,'[{\"changed\": {\"fields\": [\"desc\", \"category\"]}}]',7,14),(37,'2018-08-08 16:26:07.463002','19','虾米音乐',1,'[{\"added\": {}}]',7,14),(38,'2018-08-08 16:26:30.728934','20','斗鱼直播',1,'[{\"added\": {}}]',7,14);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(7,'blog','article'),(8,'blog','article2tag'),(9,'blog','articleupdown'),(10,'blog','blog'),(11,'blog','category'),(12,'blog','comment'),(13,'blog','tag'),(6,'blog','userinfo'),(4,'contenttypes','contenttype'),(5,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2018-07-23 13:00:12.656983'),(2,'contenttypes','0002_remove_content_type_name','2018-07-23 13:00:12.762092'),(3,'auth','0001_initial','2018-07-23 13:00:13.173700'),(4,'auth','0002_alter_permission_name_max_length','2018-07-23 13:00:13.240744'),(5,'auth','0003_alter_user_email_max_length','2018-07-23 13:00:13.248750'),(6,'auth','0004_alter_user_username_opts','2018-07-23 13:00:13.256756'),(7,'auth','0005_alter_user_last_login_null','2018-07-23 13:00:13.272768'),(8,'auth','0006_require_contenttypes_0002','2018-07-23 13:00:13.279807'),(9,'auth','0007_alter_validators_add_error_messages','2018-07-23 13:00:13.295817'),(10,'auth','0008_alter_user_username_max_length','2018-07-23 13:00:13.311828'),(11,'auth','0009_alter_user_last_name_max_length','2018-07-23 13:00:13.324837'),(12,'blog','0001_initial','2018-07-23 13:00:15.356973'),(13,'admin','0001_initial','2018-07-23 13:00:15.577153'),(14,'admin','0002_logentry_remove_auto_add','2018-07-23 13:00:15.594162'),(15,'sessions','0001_initial','2018-07-23 13:00:15.666260');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('3eadc19wdk4heayrqh2udpf614kf1roi','OWY4YmE3MDZhMjk0NWIxMWRkYmQ1MDcwMzVlOGU3NmMxYjg2M2I5MDp7InZhbGlkX2NvZGVfc3RyIjoiZWp2b2ciLCJfYXV0aF91c2VyX2lkIjoiMTMiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjlhZWVjNDcxNjM1OGJhZjEyZGIwYzhmOTdkYjY5OTM2OWQ1NDYzNWYifQ==','2018-08-23 17:31:31.283771'),('3wzbc023i44jr5l96o0yvkahqt3jkqug','YmZhNGYxZWU2YTRjYTYzNTRlZGRlYTJkODRkMjI2YzFlZmU2OTE1ODp7InZhbGlkX2NvZGVfc3RyIjoiZUpheFciLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNmE1OTNmNTI4MGM3ZTU1YmQ1MDliNWJjNThmZWQyOTFmMzY1MGNiMSJ9','2018-08-07 03:02:31.621998'),('dil20btrpg2nqluujdaf56r74ogo2viv','MTRhYjM2MWZjM2I2ZGQyOTM4MWE1OWQxM2M2NmVjMWMxNGE0YzM0Yzp7InZhbGlkX2NvZGVfc3RyIjoiT1p4QVgifQ==','2018-08-23 17:04:57.186366'),('fygahy724pg7yjxkgnwh2evpnpkqvu6h','MmMwZGJlNDA4NWJiYzY3ZjdkNjdlNDE5N2JiNDllOTIwZmUwZDBhOTp7InZhbGlkX2NvZGVfc3RyIjoicXdsbmMifQ==','2018-08-23 16:35:27.472331'),('rtyv4piged7cabxf5hzcfkk7wplvjqvl','MmZiNDIzYTE3OTQ4MDdkMzFjZWQyY2JhZmE3MTlkYzQwYjdmMTYwNDp7InZhbGlkX2NvZGVfc3RyIjoiVzBtV0MiLCJfYXV0aF91c2VyX2lkIjoiMTMiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjlhZWVjNDcxNjM1OGJhZjEyZGIwYzhmOTdkYjY5OTM2OWQ1NDYzNWYifQ==','2018-08-23 17:24:31.894528'),('vpm5feticd8t04y19lsztyzyrd13x45j','MjgyNzkzNDdmM2YyNDBjMjBkNWZmYWVjNDVmMzNiMzczYWIwMzhkMDp7InZhbGlkX2NvZGVfc3RyIjoieXdkY3MiLCJfYXV0aF91c2VyX2lkIjoiMTUiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjQ5NjYyZjhjZTdjZTlhNzg2OWI0MDk1MDdmMTg5YzU1YTYyNjIyYmMifQ==','2018-08-23 17:35:25.306411'),('vsatu6r78ijffz9lgsibohzehhmvuegd','NmNhYmYwYmU4YTFmZjI2YThiNGRjNDEwY2NhN2FlMTk2MDBiYTE1ZDp7InZhbGlkX2NvZGVfc3RyIjoiN2tGczcifQ==','2018-08-08 02:43:18.781579');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-08-09 17:48:02
