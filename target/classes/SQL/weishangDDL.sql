
-- Host: 127.0.0.1
-- Generation Time: 2018年3月22日 14:02:44

--
-- Database: 'weishang'
--

--
-- 表的结构 'adminuser'	管理员表
--

CREATE TABLE adminuser (
	uid int(11) PRIMARY KEY AUTO_INCREMENT,
  username varchar(255) NOT NULL UNIQUE ,
  password varchar(255) NOT NULL
)ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- 表的结构 'category'	一级分类表
--

CREATE TABLE category (
  cid int(11) PRIMARY KEY AUTO_INCREMENT,
  cname varchar(255) NOT NULL,
  discount float DEFAULT NULL COMMENT '折扣',
  privilegeTime datetime NOT NULL COMMENT '优惠时间'
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 'categorysecond'
--

CREATE TABLE categorysecond (
  csid int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  csname varchar(255) NOT NULL,
  cid int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 'orderitem' 订单项表
--

CREATE TABLE orderitem (
  itemid int(11) PRIMARY KEY AUTO_INCREMENT,
  count int(11) DEFAULT NULL,
  subtotal float DEFAULT NULL,
  oid	int(11) DEFAULT NULL,
  pid int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

----------------------------------------

--
-- 表的结构 'orders' 订单表
--

CREATE TABLE orders (
  oid int(11) PRIMARY KEY AUTO_INCREMENT,
  addr varchar(255) DEFAULT NULL,
  name varchar(255) DEFAULT NULL,
  ordertime datetime DEFAULT NULL,
  phone varchar(255) DEFAULT NULL,
  state int(11) DEFAULT NULL,
  total float DEFAULT NULL,
  uid int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


-- --------------------------------------------------------

--
-- 表的结构 'packet' 卡包表
--

CREATE TABLE packet (
  pacid int(11) PRIMARY KEY AUTO_INCREMENT COMMENT '卡包编号',
  uid int(11) NOT NULL COMMENT '客户编号'
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='卡包表';


-- --------------------------------------------------------

--
-- 表的结构 'product' 商品表
--

CREATE TABLE product (
  pid int(11) PRIMARY KEY AUTO_INCREMENT,
  pname varchar(255) DEFAULT NULL,
  market_price float DEFAULT NULL,
  shop_price float DEFAULT NULL,
  inventory int(5) NOT NULL,
  image varchar(255) DEFAULT NULL,
  pdesc varchar(255) DEFAULT NULL,
  is_hot int(11) DEFAULT NULL,
  pdate datetime DEFAULT NULL,
  csid int(11) DEFAULT NULL,
  cid int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=107 DEFAULT CHARSET=utf8;


-- --------------------------------------------------------

--
-- 表的结构 'ticket'
--

CREATE TABLE ticket (
  tid int(11) PRIMARY KEY  AUTO_INCREMENT COMMENT '优惠券编号',
  privilege double NOT NULL COMMENT '优惠券金额',
  consume double NOT NULL COMMENT '满减金额',
  useTime datetime NOT NULL COMMENT '使用期限',
  cid int(11) NOT NULL COMMENT '类别编号',
  pacid int(11) NOT NULL COMMENT '卡包编号'
) ENGINE=InnoDB  AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='优惠券表';



-- --------------------------------------------------------

--
-- 表的结构 'user'
--

CREATE TABLE user (
  uid int(11) PRIMARY KEY AUTO_INCREMENT,
  username varchar(255) DEFAULT NULL UNIQUE,
  password varchar(255) DEFAULT NULL,
  name varchar(255) DEFAULT NULL,
  email varchar(255) DEFAULT NULL,
  phone varchar(255) DEFAULT NULL,
  age int(5) DEFAULT NULL,
  addr varchar(255) DEFAULT NULL,
  state int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

--
-- 触发器 'user'
--
DELIMITER $$
CREATE TRIGGER u_afterinsert AFTER INSERT ON user FOR EACH ROW insert into wallet(uid) values (new.uid)
$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER u_safterinsert AFTER INSERT ON wallet FOR EACH ROW insert into packet(uid) values (new.uid)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- 表的结构 'wallet'
--

CREATE TABLE wallet (
  wid int(11) PRIMARY KEY AUTO_INCREMENT,
  money float default 0,
  uid int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------


--
-- Indexes for dumped tables
--


--
-- Indexes for table 'categorysecond'
--
ALTER TABLE categorysecond
  ADD KEY FK_CATEGORY_CID(cid);
--
-- Indexes for table 'orderitem'
--
ALTER TABLE orderitem
  ADD KEY FK_ORDERITEM_ORDERS_OID (oid),
  ADD KEY FK_ORDERITEM_PRODUCT_PID (pid);

--
-- Indexes for table 'orders'
--
ALTER TABLE orders
  ADD KEY FK_ORDER_USER_UID (uid);

--
-- Indexes for table 'packet'
--
ALTER TABLE packet
  ADD UNIQUE KEY UK_PACKET_USER_UID (uid),
  ADD KEY FK_PACKET_USER_UID (uid);

--
-- Indexes for table 'product'
--
ALTER TABLE product
  ADD KEY FK_PRODUCT_CSID (csid);
  ADD KEY FK_PRODUCT_CID (cid);

--
-- Indexes for table 'ticket'
--
ALTER TABLE ticket
  ADD UNIQUE KEY UK_TICKET_CATEGORY_CID (cid),
  ADD KEY FK_TICKET_CATEGORY_CID (cid),
  ADD KEY FK_PACKET_PACID (pacid);

--
-- Indexes for table 'wallet'
--
ALTER TABLE wallet
  ADD UNIQUE KEY UK_WALLET_USER_UID (uid);
--
-- 添加外键
--

--
-- 限制表 'categorysecond'
--
ALTER TABLE categorysecond
  ADD CONSTRAINT FK_CATEGORY_CID FOREIGN KEY (cid) REFERENCES category (cid);

--
-- 限制表 'orderitem'
--
ALTER TABLE orderitem
  ADD CONSTRAINT FK_ORDERITEM_ORDERS_OID FOREIGN KEY (pid) REFERENCES product (pid),
  ADD CONSTRAINT FK_ORDERITEM_PRODUCT_PID FOREIGN KEY (oid) REFERENCES orders (oid);

--
-- 限制表 'orders'
--
ALTER TABLE orders
  ADD CONSTRAINT FK_ORDER_USER_UID FOREIGN KEY (uid) REFERENCES user (uid);

--
-- 限制表 'packet'
--
ALTER TABLE packet
  ADD CONSTRAINT FK_PACKET_USER_UID FOREIGN KEY (uid) REFERENCES user (uid);

--
-- 限制表 'product'
--
ALTER TABLE product
  ADD CONSTRAINT FK_PRODUCT_CSID FOREIGN KEY (csid) REFERENCES categorysecond (csid);
  ADD CONSTRAINT FK_PRODUCT_CID FOREIGN KEY (cid) REFERENCES category (cid);

--
-- 限制表 'ticket'
--
ALTER TABLE ticket
  ADD CONSTRAINT FK_TICKET_CATEGORY_CID FOREIGN KEY (pacid) REFERENCES packet (pacid),
  ADD CONSTRAINT FK_PACKET_PACID FOREIGN KEY (cid) REFERENCES category (cid);

--
-- 限制表 'wallet'
--
ALTER TABLE wallet
  ADD CONSTRAINT wallet_ibfk_1 FOREIGN KEY (uid) REFERENCES user (uid);


