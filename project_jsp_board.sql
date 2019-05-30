CREATE OR REPLACE PACKAGE PACK_ENCRYPTION_DECRYPTION
IS
FUNCTION FUNC_ENCRYPT -- ��ȣȭ�� ���� �Լ�
(V_INPUT_STRING IN VARCHAR2, KEY_DATA IN VARCHAR2:='java1234$!')
RETURN RAW;
FUNCTION FUNC_DECRYPT -- ��ȣȭ�� ���� �Լ�
(V_INPUT_STRING IN VARCHAR2, KEY_DATA IN VARCHAR2:='java1234$!')
RETURN VARCHAR2;
END PACK_ENCRYPTION_DECRYPTION;
/

--3. ��Ű�� ����
CREATE OR REPLACE PACKAGE BODY PACK_ENCRYPTION_DECRYPTION
IS
FUNCTION FUNC_ENCRYPT
( V_INPUT_STRING IN VARCHAR2,
KEY_DATA IN VARCHAR2 := 'java1234$!'
) RETURN RAW
IS
V_ORIGINAL_RAW RAW(64);
V_KEY_DATA_RAW RAW(64);
ENCRYTED_RAW RAW(64);
BEGIN
-- INPUT���� RAW Ÿ������ ����
V_ORIGINAL_RAW := UTL_I18N.STRING_TO_RAW(V_INPUT_STRING,
'AL32UTF8');
--Ű ���� RAW Ÿ������ ����.
V_KEY_DATA_RAW := UTL_I18N.STRING_TO_RAW(KEY_DATA, 'AL32UTF8');
ENCRYTED_RAW := DBMS_CRYPTO.ENCRYPT(
SRC => V_ORIGINAL_RAW,
TYP => DBMS_CRYPTO.DES_CBC_PKCS5,
KEY => V_KEY_DATA_RAW,
IV => NULL);
RETURN ENCRYTED_RAW;
END FUNC_ENCRYPT;
FUNCTION FUNC_DECRYPT
( V_INPUT_STRING IN VARCHAR2,
KEY_DATA IN VARCHAR2 := 'java1234$!'
) RETURN VARCHAR2
IS
V_KEY_DATA_RAW RAW(64);
DECRYPTED_RAW RAW(64);
CONVERTED_STRING VARCHAR2(64);
BEGIN
V_KEY_DATA_RAW := UTL_I18N.STRING_TO_RAW(KEY_DATA, 'AL32UTF8');
DECRYPTED_RAW := DBMS_CRYPTO.DECRYPT(
SRC => V_INPUT_STRING,
TYP => DBMS_CRYPTO.DES_CBC_PKCS5,
KEY => V_KEY_DATA_RAW,
IV => NULL);
CONVERTED_STRING := UTL_I18N.RAW_TO_CHAR(DECRYPTED_RAW,
'AL32UTF8');
RETURN CONVERTED_STRING;
END FUNC_DECRYPT;
END PACK_ENCRYPTION_DECRYPTION;
/


--�Խ��� ���̺�

drop table project_jsp_board; 

create table project_jsp_board (
num number not null primary key, --�Խù���ȣ 
writer varchar2(50) not null references project_jsp_user(userid), --�ۼ���
subject varchar2(50) not null, --����
reg_date date default sysdate, --�ۼ����� 
readcount number default 0,	--��ȸ��
content clob not null, --����
ip varchar2(30) not null,	--�ۼ��� ip 
filename varchar2(200),
filesize number default 0, 
down number default 0, --�ٿ�ε� Ƚ��
show char(1) default 'y'    --�Խ��� ��� ����
);

delete from project_jsp_board;

insert into project_jsp_board(num,writer,subject,content,ip)
    values((select nvl(max(num)+1,1) from project_jsp_board),'kim','����','����','123.111.111.111');

insert into project_jsp_board(num,writer,subject,content,ip,show)
    values((select nvl(max(num)+1,1) from project_jsp_board),'kim','����','����','123.111.111.111','s');

select * from project_jsp_board;

--��� ���̺�
drop table project_jsp_comment;
delete from project_jsp_comment;

create table project_jsp_comment (
c_num number not null primary key, --��� �Ϸù�ȣ 
board_num number not null references project_jsp_board(num), --Foreign Key 
c_writer varchar2(50) not null references project_jsp_user(userid),
c_content clob not null, --ū������ ó���� �� �ְ� clob�� �ẻ��.
c_date date default sysdate,
c_show char(1) default 'y'    --��� ��� ����
);

select * from project_jsp_comment;
--insert into project_jsp_comment(c_num,board_num,c_writer,c_content,c_ref,c_step,c_level)
--    values((select nvl(max(c_num)+1,1) from project_jsp_comment),1,'kim','���',
--    (select nvl(max(c_num)+1,1) from project_jsp_comment),0,1);

insert into project_jsp_comment(c_num,board_num,c_writer,c_content)
    values((select nvl(max(c_num)+1,1) from project_jsp_comment),1,'kim','���');

INSERT INTO project_jsp_comment
			(c_num,board_num,c_writer,c_content) 
			VALUES ((select nvl(max(c_num)+1,1) from project_jsp_comment)
			, 26, 'kim', '�뿧��');

commit;
select count(*) from project_jsp_comment where board_num=c_num;
select * from project_jsp_board;
 SELECT *
			FROM (
 		 	select A.*, rownum as rn 
			from (
      			select num,writer,subject,reg_date,readcount,filename,filesize,down,show
			,(select count(*) from project_jsp_comment where board_num=num) comment_count
      				from project_jsp_board
      				order by num DESC
  				) A
			)
		where rn between 1 and 10;
        
 SELECT *
			FROM (
 		 	select A.*, rownum as rn 
			from (
      			select num,writer,subject,reg_date,readcount,filename,filesize,down,show
			,(select count(*) from project_jsp_comment where board_num=num) comment_count
      				from project_jsp_board
                    where writer='kim'
      				order by num DESC
  				) A
			)
		where rn between 1 and 10;