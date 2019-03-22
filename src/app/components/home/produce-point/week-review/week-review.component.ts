import { Component, OnInit, OnDestroy } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { MatDialogRef, MatDialog } from '@angular/material';
import { AddTaskComponent } from '../add-task/add-task.component';
import { Month } from 'src/app/shared/array/moth';
import { Year } from 'src/app/shared/array/year';
import { Subscription } from 'rxjs';
import { TaskService } from 'src/app/shared/services/task/task.service';
import { NotifierService } from 'angular-notifier';

export interface Transaction {
  Week: number;
  EffortScore: number;
  MinusScore: number;
  FinalScore: number;
}
@Component({
  selector: 'app-week-review',
  templateUrl: './week-review.component.html',
  styleUrls: ['./week-review.component.scss']
})

export class WeekReviewComponent implements OnInit, OnDestroy {
  private readonly notifier: NotifierService;
  // các trường được hiển thị
  displayedColumns = ['Week', 'EffortScore', 'MinusScore', 'FinalScore'];
  emID: any;
  emName: string;
  // list tháng năm
  months = Month;
  years = Year;
  // month and year was select
  monthSelected: number;
  yearSelected: number;
  // ngày đang chọn
  selectedDate: Date;
  // subcription
  subcription: Array<Subscription> = [];
  // fake dữ liệu
  transactions: Transaction[] = [
    {
      Week: 1,
      EffortScore: 0,
      MinusScore: 0,
      FinalScore: 0
    },
    {
      Week: 2,
      EffortScore: 0,
      MinusScore: 0,
      FinalScore: 0
    },
    {
      Week: 3,
      EffortScore: 0,
      MinusScore: 0,
      FinalScore: 0
    },
    {
      Week: 4,
      EffortScore: 0,
      MinusScore: 0,
      FinalScore: 0
    }
  ];
  //#region life cycle
  constructor(private activatedRoute: ActivatedRoute,
    public taskDialog: MatDialog,
    private taskSV: TaskService,
    notifierService: NotifierService
  ) { this.notifier = notifierService; }

  ngOnInit() {
    this.emID = this.activatedRoute.snapshot.params.id;
    // tslint:disable-next-line:radix
    this.monthSelected = parseInt(this.activatedRoute.snapshot.params.month);
    // tslint:disable-next-line:radix
    this.yearSelected = parseInt(this.activatedRoute.snapshot.params.year);
    // get dữ liệu
    this.getDataWeek(this.monthSelected, this.yearSelected, this.emID);
  }
  ngOnDestroy() {
    this.subcription.forEach(sub => {
      sub.unsubscribe();
    });
  }
  //#region function
  /**
   * 
   * @param m tháng
   * @param y năm
   * @param id UserID
   */
  getDataWeek(m, y, id) {
    const dataWeekSub = this.taskSV.getDataWeek(m, y, id).subscribe(data => {
      this.emName = data[0].FullName;
      this.resetData();
      for (let i = 0; i < data.length; i++) {
        const weekNum = data[i].Week;
        this.transactions[weekNum - 1].EffortScore = data[i].EffortScore;
        this.transactions[weekNum - 1].MinusScore = data[i].MinusScore;
        this.transactions[weekNum - 1].FinalScore = data[i].FinalScore;
      }
    });
    this.subcription.push(dataWeekSub);
  }
  /**
   * hàm reset data khi load lại dữ liệu
   */
  resetData() {
    this.transactions = [
      {
        Week: 1,
        EffortScore: 0,
        MinusScore: 0,
        FinalScore: 0
      },
      {
        Week: 2,
        EffortScore: 0,
        MinusScore: 0,
        FinalScore: 0
      },
      {
        Week: 3,
        EffortScore: 0,
        MinusScore: 0,
        FinalScore: 0
      },
      {
        Week: 4,
        EffortScore: 0,
        MinusScore: 0,
        FinalScore: 0
      }
    ];
  }
  /**
   * tính điểm ghi nhận
   * @param đối tượng hàng
   */
  getFinalScore(t: Transaction) {
    t.FinalScore = t.EffortScore - t.MinusScore;
    return t.FinalScore;

  }
  /** Gets the total cost of all transactions. */
  getTotalScore() {
    return this.transactions.map(t => t.FinalScore).reduce((acc, value) => acc + value, 0);
  }
  /**
   * hàm lấy ngày
   */
  getDate(): Date {
    const day = new Date().getDay();
    const date = new Date(this.yearSelected, this.monthSelected - 1, day);
    return date;
  }
  /**
   * lấy data theo tháng, năm đã chọn
   */
  getDataByDate(year, month) {
    this.yearSelected = year;
    this.monthSelected = month;
    // gọi service
    this.getDataWeek(month, year, this.emID);
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
    const dialogRef = this.taskDialog.open(AddTaskComponent, {
      data: { date: this.selectedDate, emID: this.emID }
    });
    dialogRef.afterClosed().subscribe(result => {
      // get lại dữ liệu
      if (result) {
        this.getDataWeek(this.monthSelected, this.yearSelected, this.emID);
        this.notifier.notify('success', 'Lưu thành công');
      }
    });
  }
  /**
 * Show a notification
 *
 * @param {string} type    Notification type
 * @param {string} message Notification message
 */
  public showNotification(type: string, message: string): void {
    this.notifier.notify(type, message);
  }
}
