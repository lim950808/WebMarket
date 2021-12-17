insert into board
select board_seq.nextval, id,name,subject,content,regist_day,hit,ip from board;

select *
 from(
select rownum rn, board.* 
  from board 
  where rownum <=20
   and  subject like '%테스트%'
  order by num desc
  )
  where rn >=10
  ;
  
select count(*) 
  from board 
  where subject like '%'||'테스트'||'%'
 ;
 
select count(*) 
  from board 
 ;
 
  sql:select * from  
  (select rownum rn, board.*   from board    order by num desc) 
  where rn between 21 and 30 ;
  
select * from  
(select rownum rn, board.*   
  from board   
  where subject like '%테스트%'   order by num desc) 
  where rn between 21 and 30