package dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import dto.Schedule;

public class ScheduleRepository {
	List<Schedule> scheduleList = new ArrayList<>();
	
	public void insertSchedule(Schedule schedule){
		scheduleList.add(schedule);
	}
	
	public List<Schedule> getAllSchedules(){
		return scheduleList;
	}

	public Schedule getSchedule(Date date, int seq){
		for(Schedule schedule: scheduleList) {
			 if(schedule.getSeq()==seq)
			 return schedule;	 
		}
		return null;
	}
}