/* 회원정보 update history 테이블 */
drop table if exists history_memberUpdate;
create table history_memberUpdate(
select 0 seq,
       a.id id, 
       a.name oldName,
       a.gender oldGender,
       a.birth oldBirth,
       a.mail oldMail,
       a.phone oldPhone,
       a.zipcode oldZipcode,
       a.roadAddress oldRoadAddress,
       a.jibunAddress oldJibunAddress,
       a.detailAddress oldDetailAddress,
       a.extraAddress oldExtraAddress,
       b.name newName,
       b.gender newGender,
       b.birth newBirth,
       b.mail newMail,
       b.phone newPhone,
       b.zipcode newZipcode,
       b.roadAddress newRoadAddress,
       b.jibunAddress newJibunAddress,
       b.detailAddress newDetailAddress,
       b.extraAddress newExtraAddress,
      curdate() updateDate
       
       from member a, member b where 1=0
);

alter table history_memberUpdate modify
seq int not null auto_increment primary key;

select * from history_memberUpdate;


select * from member;