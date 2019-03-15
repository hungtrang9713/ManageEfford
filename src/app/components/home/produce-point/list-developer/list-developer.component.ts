import { Component, OnInit, ViewChild } from '@angular/core';
import { MatPaginator, MatTableDataSource } from '@angular/material';
import { Router } from '@angular/router';

/**
 * @title Table with pagination
 */
@Component({
  selector: 'app-list-developer',
  templateUrl: './list-developer.component.html',
  styleUrls: ['./list-developer.component.scss']
})
export class ListDeveloperComponent implements OnInit {
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
    this.navigator.navigate([`/home/produce-point/employee`, row.id]);
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

