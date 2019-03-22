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
  @Input() viewDate: Date;
  @Input() userID: string;
  @Output() date: EventEmitter<any> = new EventEmitter<any>();
  subscription: Array<Subscription> = [];

  events: CalendarEvent[] = [];
  constructor(public dialog: MatDialog, public taskSV: TaskService) {

  }

  ngOnInit() {
    this.monthSelected = this.viewDate.getMonth() + 1;
    this.yearSelected = this.viewDate.getFullYear();
    this.getCheckedDate(this.monthSelected, this.yearSelected, this.userID);
  }
  ngOnDestroy() {
    this.subscription.forEach(e => {
      e.unsubscribe();
    });
  }
  getCheckedDate(m, y, id) {
    const getChecked = this.taskSV.getCheckedDate(m, y, id).subscribe(result => {
      if (result.length > 0) {
        result.forEach(e => {
          this.events.push({ start: startOfDay(e.DateWorking), title: this.title });
        });
      }
    });
    this.subscription.push(getChecked);
  }

  clickDay(date: Date) {
    // todo
    this.date.emit(date);
  }
}
