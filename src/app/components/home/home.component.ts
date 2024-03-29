import { Component, OnInit } from '@angular/core';
import { UserService } from 'src/app/shared/services/user.service';
import { Router } from '@angular/router';
import { NgxSpinnerService } from 'ngx-spinner';

declare var $: any;

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.scss']
})
export class HomeComponent implements OnInit {

  constructor(private router: Router, private spinner: NgxSpinnerService) { }
  employeeID = localStorage.getItem('UserID');
  employeeName = localStorage.getItem('FullName');
  fullName: string;
  isLead = false;
  ngOnInit() {
    this.spinner.show();

    setTimeout(() => {
      /** spinner ends after 5 seconds */
      this.spinner.hide();
    }, 500);
    this.fullName = localStorage.getItem('FullName');
    if (localStorage.getItem('IsLead') === 'true') {
      this.isLead = true;
    };
  }
  /**
   * hàm get link chấm điểm năng suất cho nhân viên
   */
  getRouteForEmployee(): string {
    const today = new Date();
    // lấy userID qua service, ID hiện tại đang fake
    return `/home/produce-point/employee/${this.employeeID}/${today.getMonth() + 1}/${today.getFullYear()}`;
  }

  getRouteForSchedule() {
    return `/home/work-schedule/schedule/${this.employeeID}/${this.employeeName}/1`;
  }
  logout() {
    localStorage.removeItem('Token');
    localStorage.removeItem('UserName');
    localStorage.removeItem('FullName');
    localStorage.removeItem('IsLead');
    localStorage.removeItem('UserID');
    this.router.navigate(['/login']);
  }
}
