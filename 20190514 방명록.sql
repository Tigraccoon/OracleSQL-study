--방명록 테이블
create table guestbook (
idx int not null primary key, --게시물 일련 번호
name varchar2(50) not null, --이름
email varchar2(50) not null, --이메일
passwd varchar2(50) not null, --수정삭제용 비번
content varchar2(2000) not null, --내용,
--varchar2는 4000byte가 끝, 내용이 이상 넘어가면 clob(4GB)을 사용해야함 
-- ex)content clob not null,
post_date date default sysdate --작성일시
);

drop sequence guestbook_seq; 
-- 게시물 일련번호 부여를 위한 시퀀스  생성
create sequence guestbook_seq
start with 1 --1부터 시작
increment by 1 --1씩 증가
nomaxvalue --무제한 증가
nocache; --캐쉬 사용 안함 (기본값은 사용함으로 되어있음)
--캐쉬를 사용하면 번호가 잘못 입력될 수 있음(순서가 중요한 경우 nocache사용 )
/* cach옵션을 사용하면 속도를 증가시키기 위해 sequence 번호를 한번에 
 *  여러 개씩 메모리에 올려놓고 작업을 한다. 이러한 경우에 DB를 중지시키거나 
 *  전원이 off되는 경우에 메모리에 있던 번호가 삭제되기 때문에 원치않는 번호로 증가될 수 있다 */

-- 시퀀스.nextval ==> 다음 번호 발급
-- 방명록 테스트 레코드 추가
insert into guestbook (idx, name, email, passwd, content) values
( guestbook_seq.nextval, 'kim', 'kim@daum.net', '1234', '첫번째 게시물'); 
-- 방명록 리스트
select * from guestbook; 
commit;
--비밀번호 체크
select count(*) from guestbook where idx=1 and passwd='123'; 

-- 방명록 수정/삭제 화면
select * from GUESTBOOK where idx=1; -- 수정
update GUESTBOOK
set name='김미선', email='kim@naver.com', passwd='2222', content = '...'
where idx=1; 

--삭제
delete from guestbook where idx=17; 

--모든 레코드 삭제
delete from guestbook;


--sql문 테스트
SELECT idx,name,email,content,post_date 
			FROM guestbook 
			ORDER BY idx DESC;
