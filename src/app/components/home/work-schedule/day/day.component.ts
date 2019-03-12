import { Component, OnInit, Input } from '@angular/core';
import { Day } from 'src/app/shared/enums/day';

@Component({
  selector: 'app-day',
  templateUrl: './day.component.html',
  styleUrls: ['./day.component.scss']
})
export class DayComponent implements OnInit {

  constructor() { }

  ngOnInit() {
  }

  @Input()
  Week: Number;

  @Input()
  Day: Day;

}
