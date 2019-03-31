import { Component, OnInit, OnDestroy } from '@angular/core';
import { Router } from '@angular/router';
import { MatDialog } from '@angular/material';
import { NotifierService } from 'angular-notifier';
import { EditUserPopupComponent } from '../edit-user-popup/edit-user-popup.component';
import { EmployeeManagement } from 'src/app/shared/models/user';
import { Subscription } from 'rxjs';
import { UserService } from 'src/app/shared/services/user.service';

@Component({
  selector: 'app-list-employee',
  templateUrl: './list-employee.component.html',
  styleUrls: ['./list-employee.component.scss']
})
export class ListEmployeeComponent implements OnInit, OnDestroy {
  //#region prop
  currentDate = new Date();
  employees: EmployeeManagement;
  subscription: Array<Subscription> = [];
  constructor(private navigator: Router,
    public editUserDialog: MatDialog,
    public notifier: NotifierService,
    private userSV: UserService
  ) { }

  ngOnInit() {
    this.getDataEmployees();
  }
  ngOnDestroy(): void {
    this.subscription.forEach(e => {
      e.unsubscribe();
    });
  }
  //#region function
  navigateSchedule(userID: string, fullName: string) {
    this.navigator.navigate([`/home/work-schedule/schedule`, userID, fullName]);
  }

  navigateEffort(userID: string) {
    const month = this.currentDate.getMonth() + 1, year = this.currentDate.getFullYear();
    this.navigator.navigate([`/home/produce-point/employee/`, userID, month, year]);
  }
  getDataEmployees() {
    const listDataSub = this.userSV.getListUser().subscribe(data => {
      this.employees = data;
    },
      err => {
        alert(` Có lỗi xảy ra`);
      });
  }

  editUser(user) {
    const dialogRef = this.editUserDialog.open(EditUserPopupComponent, {
      data: user
    });
    dialogRef.afterClosed().subscribe(result => {
      // get lại dữ liệu
      if (result) {
        this.getDataEmployees();
        this.notifier.notify('success', 'Sửa thành công');
      }
    });
  }
  /**
   * xóa user
   */
  deleteUser(user) {
    const deleteSub = this.userSV.deleteUser(user).subscribe(data => {
        this.getDataEmployees();
        this.notifier.notify('success', 'Xóa thành công');
    },
      err => alert(err));
  }
}
