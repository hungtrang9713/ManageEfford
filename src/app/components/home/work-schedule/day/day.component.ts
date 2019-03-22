import { Component, OnInit, Input } from '@angular/core';
import { Day } from 'src/app/shared/enums/day';
import { WorkingState } from 'src/app/shared/enums/work-status';
import * as moment from 'moment'
import { HttpClient } from '@angular/common/http';

class JobBooking {
  UserID?: string;
  Date: string;
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
    this.getData();
  }

  isLoadFirstTime: true;

  private _week: number;

  get week(): number {
    return this._week;
  };

  @Input()
  set week(week: number) {
    this._week = week;
    if (this.day) {
      this.getData();
    }
  }

  @Input()
  day: Day;

  get date(): string {
    return moment().weekday(this.day + this.week * 7).format('YYYY-MM-DD');
  }

  workStatus: WorkingState = WorkingState.NoRegister;

  listWorkStatus: Array<WorkingState> = [WorkingState.AllDay, WorkingState.Morning, WorkingState.Afternoon, WorkingState.NotWorking,WorkingState.NoRegister];

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
    if (this.workStatus === WorkingState.AllDay) {
      return "Cả ngày"
    }
    if (this.workStatus === WorkingState.Morning) {
      return "Sáng"
    }
    if (this.workStatus === WorkingState.Afternoon) {
      return "Chiều"
    }
    if (this.workStatus === WorkingState.NotWorking) {
      return "Nghỉ"
    }
    if (this.workStatus === WorkingState.NoRegister) {
      return "Chưa đăng kí"
    }
  }

  convertWorkStatusToString(workStatus: WorkingState) {
    if (workStatus === WorkingState.AllDay) {
      return "Nghỉ cả ngày"
    }
    if (workStatus === WorkingState.Morning) {
      return "Nghỉ Sáng"
    }
    if (workStatus === WorkingState.Afternoon) {
      return "Nghỉ Chiều"
    }
    if (workStatus === WorkingState.NotWorking) {
      return "Chưa chắc chắn"
    }
    if (workStatus === WorkingState.NoRegister) {
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
      WorkingState: this.workStatus
    }
    this.http.post(`http://localhost:55465/JobBooking/${localStorage.getItem('UserID')}`, jobBooking).subscribe(res => {

    })
  }

  getData() {
    this.http.get(`http://localhost:55465/JobBooking/workingState/${this.date}/${localStorage.getItem('UserID')}`).subscribe(res => {
      this.workStatus = parseInt(res.toString());
    })
  }




}
