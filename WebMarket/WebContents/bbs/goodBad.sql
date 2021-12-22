create table bbsGoodBad(
num number primary key,
good number default 0,
bad number default 0
);


select * from bbs order by num desc;
select * from bbsgoodbad;

--  이 결과는 어떻게 나오나요?
-- outer join
select * 
  from bbs, bbsgoodbad
 where bbs.num = bbsgoodbad.num(+)
;  

-- ansi조인 
select * 
  from bbs left outer join bbsgoodbad
   on bbs.num = bbsgoodbad.num
   ;

 

select *
  from 
(select rownum rn, a.* from
 (select bbs.num num,
       bbs.writer writer,
       bbs.subject subject,
       bbs.content content,
       bbs.readcount readcount,
       bbs.password password,
       bbs.reg_date reg_date,
       bbs.ip ip,
       bbs.ref ref,
       bbs.re_step re_step,
       bbs.re_level re_level,
       nvl(bbsgoodbad.good,0) good,
       nvl(bbsgoodbad.bad,0) bad
  from bbs, bbsgoodbad
 where bbs.num=bbsgoodbad.num(+)
 order by ref desc, re_step asc)a )
where rn between 11 and 20 ;



select bbs.num num,
       bbs.writer writer,
       bbs.subject subject,
       bbs.content content,
       bbs.readcount readcount,
       bbs.password password,
       bbs.reg_date reg_date,
       bbs.ip ip,
       bbs.ref ref,
       bbs.re_step re_step,
       bbs.re_level re_level,
       nvl(bbsgoodbad.good,0) good,
       nvl(bbsgoodbad.bad,0) bad
  from bbs, bbsgoodbad
 where bbs.num=bbsgoodbad.num(+)
 order by ref desc, re_step asc
 ;
 
 
 select * 
   from 
	(select rownum rn, a.* from 
	  (select  bbs.num num,
		       bbs.writer writer,
		       bbs.subject subject,
		       bbs.content content,
		       bbs.readcount readcount,
		       bbs.password password,
		       bbs.reg_date reg_date,
		       bbs.ip ip,
		       bbs.ref ref,
		       bbs.re_step re_step,
		       bbs.re_level re_level,
		       nvl(bbsgoodbad.good,0) good,
		       nvl(bbsgoodbad.bad,0) bad 	
		 from bbs, bbsgoodbad
	    where subject like '%'||'테스트'||'%'
	      and bbs.num = bbsgoodbad.num(+)
	    order by ref desc, re_step asc) a)
  where rn between 11 and 20
  ;