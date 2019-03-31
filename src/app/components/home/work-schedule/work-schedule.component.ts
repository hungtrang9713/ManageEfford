import { Component, OnInit } from '@angular/core';
import * as moment from 'moment'
import { ActivatedRoute } from '@angular/router';

@Component({
  selector: 'app-work-schedule',
  templateUrl: './work-schedule.component.html',
  styleUrls: ['./work-schedule.component.scss']
})
export class WorkScheduleComponent implements OnInit {
  fullName: string;
  constructor(
    private activatedroute: ActivatedRoute
  ) { }

  currentTime: any;

  selectedWeekNumber: number = 0;
  mondayWeekSelected = moment().weekday(1 + this.selectedWeekNumber * 7).format("DD/MM/YYYY");
  saturdayWeekSelected = moment().weekday(6 + this.selectedWeekNumber * 7).format("DD/MM/YYYY");

  ngOnInit() {
    this.fullName = this.activatedroute.snapshot.params.fullName;
    this.currentTime = moment();
  }

  get selectedWeek() {
    return `${moment().weekday(1 + this.selectedWeekNumber * 7).format("DD/MM/YYYY")} - ${moment().weekday(6 + this.selectedWeekNumber * 7).format("DD/MM/YYYY")}`;
  }

  prevWeek() {
    this.selectedWeekNumber--;
  }

  nextWeek() {
    this.selectedWeekNumber++;
  }


}
