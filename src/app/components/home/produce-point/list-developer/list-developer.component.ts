import { Component, OnInit, ViewChild } from '@angular/core';
import { MatPaginator, MatTableDataSource } from '@angular/material';
import { Router } from '@angular/router';
import { HttpClient, HttpHeaders } from '@angular/common/http';

/**
 * @title Table with pagination
 */
@Component({
  selector: 'app-list-developer',
  templateUrl: './list-developer.component.html',
  styleUrls: ['./list-developer.component.scss']
})
export class ListDeveloperComponent implements OnInit {
  public displayedColumns: string[] = ['FullName', 'Week1', 'Week2', 'Week3', 'Week4', 'Total', 'UserName', 'Note'];
  public dataSource = new MatTableDataSource<Working>(ELEMENT_DATA);

  @ViewChild(MatPaginator) paginator: MatPaginator;
  constructor(private navigator: Router, private http: HttpClient) {
  }
  ngOnInit() {
    this.dataSource.paginator = this.paginator;
    
    this.http.get<Working[]>("http://localhost:50999/api/Working/Summary/3").subscribe(res => {
      let uuid = 1;
      res.forEach(element => {
        element.ID = uuid++;
      });
      this.dataSource = new MatTableDataSource<Working>(res)
    })
  }
  /**
   * hàm xử lý khi xem chi tiết nv
   */
  clickRow(row) {
    debugger
    this.navigator.navigate([`/home/produce-point/employee`, row.ID]);
  }
}

export interface Working {
  FullName: string;
  Week1: number;
  Week2: number;
  Week3: number;
  Week4: number;
  UserName: string;
  Total: number;
  Note: string;
  ID: number;
}

const ELEMENT_DATA: Working[] = [];

