import { Component, OnInit, Output, EventEmitter, Input } from '@angular/core';
import { MatDialog } from '@angular/material';

@Component({
  selector: 'app-calendar',
  templateUrl: './calendar.component.html',
  styleUrls: ['./calendar.component.scss']
})
export class CalendarComponent implements OnInit {

  title = 'crm-job-booking';
  @Input() viewDate: Date;
  @Output() date: EventEmitter<any> = new EventEmitter<any>();

  constructor(public dialog: MatDialog) {

  }

  ngOnInit() {
  }


  clickDay(date: Date) {
    // todo
    this.date.emit(date);
  }
}
