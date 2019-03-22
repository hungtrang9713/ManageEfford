import { Component, OnInit, Input } from '@angular/core';
import { Day } from 'src/app/shared/enums/day';
import { WorkingState } from 'src/app/shared/enums/work-status';

class DayData {
  Day: Day;
  WorkStatus: WorkingState;
}

@Component({
  selector: 'app-week',
  templateUrl: './week.component.html',
  styleUrls: ['./week.component.scss']
})
export class WeekComponent implements OnInit {

  constructor() { }

  ngOnInit() {
  }

  daysOfWeek: Array<Day> = [Day.Monday, Day.Tuesday, Day.Wednesday, Day.Thursday, Day.Friday, Day.Saturday];

  @Input()
  week: number;
  
}
