select umemo_id, uuid, subject, content, importance from memo where uuid = 'tes4tuser'


insert into user (uuid,uname,uface,pw) values ('bb','bb','b',PASSWORD('rr'));


CREATE TABLE apm.schedule (
   schedule_id INT UNSIGNED AUTO_INCREMENT,
   uuid VARCHAR(30) CHARACTER SET utf8 NOT NULL,
   subject TEXT CHARACTER SET utf8,
   ymdt DATETIME NOT NULL,
  PRIMARY KEY (schedule_id),
  KEY `FK_schedule_1` (`uuid`),
  CONSTRAINT `FK_schedule_1` FOREIGN KEY (`uuid`) REFERENCES `user` (`uuid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB ROW_FORMAT = DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;

------------------------------------------------------------
//스케줄 추가

insert into schedule (uuid, subject, ymdt) values ('testuser','test','2016-09-06 14:21:56');

insert into memo (uuid, subject, content) value ( 'bb','', '');";
