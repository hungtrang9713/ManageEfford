import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { MatDialogRef, MatDialog } from '@angular/material';
import { AddTaskComponent } from '../add-task/add-task.component';

export interface Transaction {
  Week: number;
  EffortPoint: number;
  MinusPoint: number;
  FinalScore: number;
}
@Component({
  selector: 'app-week-review',
  templateUrl: './week-review.component.html',
  styleUrls: ['./week-review.component.scss']
})

export class WeekReviewComponent implements OnInit {
  // các trường được hiển thị
  displayedColumns = ['Week', 'EffortPoint', 'MinusPoint', 'FinalScore'];
  emID: number;
  // ngày đang chọn
  selectedDate: Date;
  // fake dữ liệu
  transactions: Transaction[] = [
    {
      Week: 1,
      EffortPoint: 30.5,
      MinusPoint: 10,
      FinalScore: 0
    },
    {
      Week: 2,
      EffortPoint: 10,
      MinusPoint: 2,
      FinalScore: 0
    },
    {
      Week: 3,
      EffortPoint: 10,
      MinusPoint: 0,
      FinalScore: 0
    },
    {
      Week: 4,
      EffortPoint: 0,
      MinusPoint: 0,
      FinalScore: 0
    }
  ];
  constructor(private activatedRoute: ActivatedRoute,
    public taskDialog: MatDialog
  ) { }

  ngOnInit() {
    this.emID = this.activatedRoute.snapshot.params.id;
  }

  getFinalScore(t: Transaction) {
    t.FinalScore = t.EffortPoint - t.MinusPoint;
    return t.FinalScore;

  }
  /** Gets the total cost of all transactions. */
  getTotalScore() {
    return this.transactions.map(t => t.FinalScore).reduce((acc, value) => acc + value, 0);
  }
  /**
   * chọn ngày
   */
  selectDate(date: Date) {
    this.selectedDate = date;
    this.clickViewDetail();
  }
  /**
   * xem chi tiết công việc trong ngày
   */
  clickViewDetail() {
    this.taskDialog.open(AddTaskComponent, {
      data: { date: this.selectedDate, emID: this.emID }
    });
  }
}
