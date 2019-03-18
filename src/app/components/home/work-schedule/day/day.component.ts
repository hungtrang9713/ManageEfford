import { Component, OnInit, Input } from '@angular/core';
import { Day } from 'src/app/shared/enums/day';
import { WorkStatus } from 'src/app/shared/enums/work-status';
import * as moment from 'moment'
import { HttpClient } from '@angular/common/http';

class JobBooking {
  UserID: string;
  Date: Date;
  WorkingState: number
}

@Component({
  selector: 'app-day',
  templateUrl: './day.component.html',
  styleUrls: ['./day.component.scss']
})
export class DayComponent implements OnInit {

  constructor(
    private http: HttpClient
  ) { }

  ngOnInit() {
  }

  private _week: number;

  get week(): number {
    return this._week;
  };

  @Input()
  set week(week: number) {
    this._week = week;
    this.getData();
  }

  @Input()
  day: Day;

  get date(): Date {
    return moment().weekday(this.day + this.week*7).toDate();
  }

  workStatus: WorkStatus = WorkStatus.NoRegister;

  listWorkStatus: Array<WorkStatus> = [WorkStatus.AllDay, WorkStatus.Morning, WorkStatus.Afternoon, WorkStatus.NotWorking];

  get isCurrentDay() {
    let currentDay = moment().format("DD");
    let day = moment().weekday(this.day).format("DD");
    if (this.week === 0 && currentDay === day) {
      return true;
    }
    return false;
  }

  get isOver() {
    let currentDay = +moment().format("DD");
    let day = +moment().weekday(this.day).format("DD");
    if ((day < currentDay && this.week === 0) || this.week < 0) {
      return true;
    }
    return false;
  }

  get dayText() {
    if (this.day === Day.Monday) {
      return "Thứ 2"
    }
    if (this.day === Day.Tuesday) {
      return "Thứ 3"
    }
    if (this.day === Day.Wednesday) {
      return "Thứ 4"
    }
    if (this.day === Day.Thursday) {
      return "Thứ 5"
    }
    if (this.day === Day.Friday) {
      return "Thứ 6"
    }
    if (this.day === Day.Saturday) {
      return "Thứ 7"
    }
    return "";
  }

  get workStatusText() {
    if (this.workStatus === WorkStatus.AllDay) {
      return "Cả ngày"
    }
    if (this.workStatus === WorkStatus.Morning) {
      return "Sáng"
    }
    if (this.workStatus === WorkStatus.Afternoon) {
      return "Chiều"
    }
    if (this.workStatus === WorkStatus.NotWorking) {
      return "Nghỉ"
    }
    if (this.workStatus === WorkStatus.NoRegister) {
      return "Chưa đăng kí"
    }
  }

  convertWorkStatusToString(workStatus: WorkStatus) {
    if (workStatus === WorkStatus.AllDay) {
      return "Cả ngày"
    }
    if (workStatus === WorkStatus.Morning) {
      return "Sáng"
    }
    if (workStatus === WorkStatus.Afternoon) {
      return "Chiều"
    }
    if (workStatus === WorkStatus.NotWorking) {
      return "Nghỉ"
    }
    if (workStatus === WorkStatus.NoRegister) {
      return "Chưa đăng kí"
    }
    return "";
  }

  setWorkStatus(workStatus) {
    this.workStatus = workStatus;
    this.saveToDB();
  }

  saveToDB() {
    let jobBooking: JobBooking = {
      Date: this.date,
      UserID: "4d7cbe29-eca7-49d4-ab2f-b968fe8d4490",
      WorkingState: this.workStatus
    }
    this.http.post("http://localhost:50999/JobBooking", jobBooking).subscribe(res => {

    })
  }

  getData() {
    
  }

}
