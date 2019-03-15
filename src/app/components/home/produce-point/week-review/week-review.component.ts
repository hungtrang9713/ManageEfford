import { Component, OnInit } from '@angular/core';

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
  displayedColumns = ['Week', 'EffortPoint', 'MinusPoint', 'FinalScore'];

  transactions: Transaction[] = [
    {
      Week: 1,
      EffortPoint: 30.5,
      MinusPoint: 0,
      FinalScore: 0
    },
    {
      Week: 2,
      EffortPoint: 0,
      MinusPoint: 0,
      FinalScore: 0
    },
    {
      Week: 3,
      EffortPoint: 0,
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
  constructor() { }

  ngOnInit() {
  }

  getFinalScore(t: Transaction) {
    t.FinalScore = t.EffortPoint - t.MinusPoint;
    return t.FinalScore;

  }
  /** Gets the total cost of all transactions. */
  getTotalScore() {
    return this.transactions.map(t => t.FinalScore).reduce((acc, value) => acc + value, 0);
  }
}
