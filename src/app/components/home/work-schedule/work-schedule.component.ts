import { Component, OnInit } from '@angular/core';
import * as moment from 'moment'

@Component({
  selector: 'app-work-schedule',
  templateUrl: './work-schedule.component.html',
  styleUrls: ['./work-schedule.component.scss']
})
export class WorkScheduleComponent implements OnInit {

  constructor() { }

  currentTime: any;

  selectedWeekNumber: number = 0;
  mondayWeekSelected = moment().weekday(1 + this.selectedWeekNumber*7).format("DD/MM/YYYY");
  saturdayWeekSelected = moment().weekday(6 + this.selectedWeekNumber*7).format("DD/MM/YYYY");

  ngOnInit() {
    this.currentTime = moment();
  }

  get selectedWeek() {
    return `${moment().weekday(1 + this.selectedWeekNumber*7).format("DD/MM/YYYY")} - ${moment().weekday(6 + this.selectedWeekNumber*7).format("DD/MM/YYYY")}`;
  }

  prevWeek() {
    this.selectedWeekNumber--;
  }

  nextWeek() {
    this.selectedWeekNumber++;
  }

  
}
