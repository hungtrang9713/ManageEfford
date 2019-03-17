import { Component, OnInit, ViewChild } from '@angular/core';
import { MatPaginator, MatTableDataSource } from '@angular/material';
import { Router } from '@angular/router';
import { CalendarTodayDirective } from 'angular-calendar/modules/common/calendar-today.directive';

/**
 * @title Table with pagination
 */
@Component({
  selector: 'app-list-developer',
  templateUrl: './list-developer.component.html',
  styleUrls: ['./list-developer.component.scss']
})
export class ListDeveloperComponent implements OnInit {
  today = new Date();
  years: Array<number> = [2018, 2019, 2020];
  months: Array<number> = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
  // chọn năm
  yearSelected = this.today.getFullYear();
  // lấy thời điểm hiện tại
  // chọn tháng
  monthSelected = this.today.getMonth() + 1;
  // danh sách các trường được hiển thị
  public displayedColumns: string[] = [`Position`,
    `EmployeeCode`,
    `EmployeeName`,
    `Week1`,
    `Week2`,
    `Week3`,
    `Week4`,
    `TotalScore`,
    `Note`
  ];
  public dataSource = new MatTableDataSource<PeriodicElement>(ELEMENT_DATA);

  @ViewChild(MatPaginator) paginator: MatPaginator;
  constructor(private navigator: Router) {
  }
  ngOnInit() {
    this.dataSource.paginator = this.paginator;
  }
  /**
   * hàm xử lý khi xem chi tiết nv
   */
  clickRow(row) {
    console.log(row);
    this.navigator.navigate([`/home/produce-point/employee`, row.id, this.monthSelected, this.yearSelected]);
  }
  /**
   * hàm lấy chi tiết nhân viên theo thánng
   */
  getDataByDate(){
    // gọi api
  }
}
// đối tượng hứng data để đổ ra grid
export interface PeriodicElement {
  Position: number;
  EmployeeCode: string;
  EmployeeName: string;
  Week1: number;
  Week2: number;
  Week3: number;
  Week4: number;
  TotalScore: number;
  Note: string;
  id: number;
}
// fake dữ liệu
const ELEMENT_DATA: PeriodicElement[] = [
  {
    Position: 1,
    EmployeeCode: `B06-0371`,
    EmployeeName: `Nvcuong`,
    Week1: 12,
    Week2: 13.4,
    Week3: 14.5,
    Week4: 16.9,
    TotalScore: 36.8,
    Note: ``,
    id: 1,
  }
];

