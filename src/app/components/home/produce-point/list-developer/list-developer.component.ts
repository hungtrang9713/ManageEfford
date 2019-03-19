import { Component, OnInit, ViewChild, OnDestroy } from '@angular/core';
import { MatPaginator, MatTableDataSource } from '@angular/material';
import { Router } from '@angular/router';
import { CalendarTodayDirective } from 'angular-calendar/modules/common/calendar-today.directive';
import { Month } from 'src/app/shared/array/moth';
import { Year } from 'src/app/shared/array/year';
import { Subscription } from 'rxjs';
import { TaskService } from 'src/app/shared/services/task/task.service';
import { DataMonth } from 'src/app/shared/models/data-month';

/**
 * @title Table with pagination
 */
@Component({
  selector: 'app-list-developer',
  templateUrl: './list-developer.component.html',
  styleUrls: ['./list-developer.component.scss']
})
export class ListDeveloperComponent implements OnInit, OnDestroy {
  //#region property
  today = new Date();
  years: Array<number> = Year;
  months: Array<number> = Month;

  subcription: Array<Subscription> = [];
  // chọn năm
  yearSelected = this.today.getFullYear();
  // lấy thời điểm hiện tại
  // chọn tháng
  monthSelected = this.today.getMonth() + 1;
  // danh sách các trường được hiển thị
  public displayedColumns: string[] = [
    `Position`,
    `UserName`,
    `FullName`,
    `Week1`,
    `Week2`,
    `Week3`,
    `Week4`,
    `Total`,
    `Note`
  ];
  // fake dữ liệu
  ELEMENT_DATA: DataMonth[] = [
  ];
  public dataSource = new MatTableDataSource<DataMonth>(this.ELEMENT_DATA);

  @ViewChild(MatPaginator) paginator: MatPaginator;
  constructor(private navigator: Router, private taskSV: TaskService) {
  }
  //#endregion property

  //#region life cycle
  ngOnInit() {
    this.dataSource.paginator = this.paginator;
    // gọi hàm getdataMoth
    this.getDataMonth(this.monthSelected, this.yearSelected);
  }
  ngOnDestroy(): void {
    this.subcription.forEach(sub => {
      sub.unsubscribe();
    });
  }
  //#endregion

  //#region functions
  getDataMonth(m, y) {
    const dataMonthSub = this.taskSV.getDataMonth(m, y).subscribe(data => {
      this.ELEMENT_DATA = data;
      this.dataSource = new MatTableDataSource<DataMonth>(this.ELEMENT_DATA);
    });
    this.subcription.push(dataMonthSub);
  }

  /**
   * hàm xử lý khi xem chi tiết nv
   */
  clickRow(row) {
    console.log(row);
    this.navigator.navigate([`/home/produce-point/employee`, row.UserID, this.monthSelected, this.yearSelected]);
  }
  /**
   * hàm lấy chi tiết nhân viên theo thánng
   */
  getDataByDate() {
    // gọi api
    this.getDataMonth(this.monthSelected, this.yearSelected);
  }
  /**
   * thêm mới user
   */
  addEvent() {
    //do smt
  }
}


