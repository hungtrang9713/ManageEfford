import { Component, OnInit, Inject, OnDestroy } from '@angular/core';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { User } from 'src/app/shared/models/user';
import { UserService } from 'src/app/shared/services/user.service';
import { Subscription } from 'rxjs';
import { ActionState } from 'src/app/shared/enums/action-state';
export interface Lead {
  UserID: string;
  FullName: string;
}
@Component({
  selector: 'app-edit-user-popup',
  templateUrl: './edit-user-popup.component.html',
  styleUrls: ['./edit-user-popup.component.scss']
})
export class EditUserPopupComponent implements OnInit, OnDestroy {
  //#region prop
  // mảng tên lead
  leads: Lead[] = [];
  // reference form contact
  rfContact: FormGroup;
  // subcription
  subs: Array<Subscription> = [];
  //#region life cy
  constructor(public dialogRef: MatDialogRef<EditUserPopupComponent>,
    @Inject(MAT_DIALOG_DATA) public data: User,
    private fb: FormBuilder,
    private userSV: UserService
  ) { }

  ngOnInit() {
    this.rfContact = this.fb.group({
      UserName: this.fb.control(this.data.UserName, [Validators.required]),
      FullName: this.fb.control(this.data.FullName, [Validators.required]),
      Password: this.fb.control(this.data.PassWord, [Validators.required]),
      IsLead: this.fb.control(this.data.IsLead),
      LeadID: this.fb.control(this.data.LeadID, [Validators.required])
    });
    // lấy data combo
    this.getLeadInfo();
  }
  ngOnDestroy() {
    this.subs.forEach(e => e.unsubscribe());
  }

  //#region function
  // hiện lỗi
  getErrorMessage() {
    return this.rfContact.controls.UserName.hasError('required') ? 'Mã nhân viên không được để trống' :
      this.rfContact.controls.FullName.hasError('required') ? 'Tên nhân viên không được để trống' :
        this.rfContact.controls.Password.hasError('required') ? 'Mật khẩu không được để trống' : 'lỗi khác';
  }
  // lấy ds lead
  getLeadInfo() {
    const leadInfoSub = this.userSV.getListLead().subscribe(data => {
      this.leads = data;
    });
    this.subs.push(leadInfoSub);
  }

  /**
* hàm lưu công việc
*/
  onSubmit() {
    let user = new User(ActionState.Edit);
    user = this.rfContact.value;
    user.UserID = this.data.UserID;
    const addSub = this.userSV.editUser(user).subscribe(data => {
      this.dialogRef.close(true);
    }, err => {
      alert('có lỗi xảy ra!');
    });
  }
  // đóng dialog
  cancelDialog() {
    this.dialogRef.close(false);
  }
}
