CREATE or replace TRIGGER member_AFTER_UPDATE
AFTER UPDATE ON member FOR EACH ROW 
BEGIN
insert into 
  history_memberUpdate(seq, id, oldName,  oldGender, oldBirth, oldMail, oldPhone, oldZipcode,
                       oldRoadAddress, oldJibunAddress, oldDetailAddress, oldExtraAddress,
                       newName, newGender, newBirth, newMail, newPhone,newZipcode,
                       newRoadAddress,newJibunAddress, newDetailAddress, newExtraAddress, updateDate) 
     values(null, :old.id, :old.name,:old.gender,:old.birth,:old.mail,
        :old.phone,:old.zipcode,:old.roadAddress, :old.jibunAddress, :old.detailAddress, :old.extraAddress,
        :new.name, :new.gender,:new.birth,:new.mail,
        :new.phone,:new.zipcode,:new.roadAddress, :new.jibunAddress, :new.detailAddress, :new.extraAddress,
        sysdate);
END;

create sequence history_member_seq start with 1;