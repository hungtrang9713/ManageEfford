import { Component, OnInit } from '@angular/core';

declare var $: any;

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.scss']
})
export class HomeComponent implements OnInit {

  constructor() { }
  employeeID: number;
  ngOnInit() {
    $("mat-toolbar-row").on("click", function () {
      $("mat-toolbar-row").removeClass("selected");
      $(this).addClass("selected");
    })
  }
  /**
   * hàm get link chấm điểm năng suất cho nhân viên
   */
  getRouteForEmployee(): string {
    const today = new Date();
    // lấy userID qua service, ID hiện tại đang fake
    this.employeeID = 1;
    return `/home/produce-point/employee/${this.employeeID}/${today.getMonth() + 1}/${today.getFullYear()}`;
  }
}
