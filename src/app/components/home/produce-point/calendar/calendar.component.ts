import { Component, OnInit, Output, EventEmitter, Input, OnDestroy } from '@angular/core';
import { MatDialog } from '@angular/material';
import { CalendarEvent } from 'calendar-utils';
import {
  startOfDay,
  endOfDay,
  subDays,
  addDays,
  endOfMonth,
  isSameDay,
  isSameMonth,
  addHours
} from 'date-fns';
import { TaskService } from 'src/app/shared/services/task/task.service';
import { Subscription } from 'rxjs';

const colors: any = {
  red: {
    primary: '#ad2121',
    secondary: '#FAE3E3'
  },
  blue: {
    primary: '#1e90ff',
    secondary: '#D1E8FF'
  },
  yellow: {
    primary: '#e3bc08',
    secondary: '#FDF1BA'
  }
};
@Component({
  selector: 'app-calendar',
  templateUrl: './calendar.component.html',
  styleUrls: ['./calendar.component.scss']
})
export class CalendarComponent implements OnInit, OnDestroy {

  title = 'Đã chấm công';
  monthSelected: number;
  yearSelected: number;
  viewDate: Date;
  @Input() viewDateInput: Date;
  @Input() userID: string;
  @Output() date: EventEmitter<any> = new EventEmitter<any>();
  subscription: Array<Subscription> = [];

  events: CalendarEvent[] = [];
  constructor(public dialog: MatDialog, public taskSV: TaskService) {

  }

  ngOnInit() {
    this.monthSelected = this.viewDateInput.getMonth();
    this.yearSelected = this.viewDateInput.getFullYear();
    this.setViewDate(this.yearSelected, this.monthSelected - 1);
    this.getCheckedDate(this.monthSelected, this.yearSelected, this.userID);
  }
  ngOnDestroy() {
    this.subscription.forEach(e => {
      e.unsubscribe();
    });
  }
  /***
   * lấy ra bảng lịch
   */
  setViewDate(y, m) {
    this.viewDate = new Date(y, m, 10);
  }
  /**
   * lấy những ngày có event
   * @param m 
   * @param y 
   * @param id 
   */
  getCheckedDate(m, y, id) {
    const getChecked = this.taskSV.getCheckedDate(m, y, id).subscribe(result => {
      if (result.length > 0) {
        this.events = [];
        result.forEach(e => {
          this.events.push({ start: startOfDay(e.DateWorking), title: this.title });
        });
      }
    });
    this.subscription.push(getChecked);
  }
  //
  getBookingJob(m, y, id) {
    const getjob = this.taskSV.getBookingJobMonth(m, y, id).subscribe(result => {
      if (result.length > 0) {
        result.forEach(e => {
          this.events.push({ start: startOfDay(e.DateWorking), title: `Xin nghỉ` });
        });
      }
    });
    this.subscription.push(getjob);
  }
  /**
   * 
   * @param chọn ngày
   */
  clickDay(date: Date) {
    // todo
    this.date.emit(date);
  }
}
