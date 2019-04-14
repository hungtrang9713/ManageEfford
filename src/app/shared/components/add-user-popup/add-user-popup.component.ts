import { Component, OnInit, Inject, OnDestroy } from '@angular/core';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material';
import { Validators, FormBuilder, FormGroup } from '@angular/forms';
import { Observable, Subscription } from 'rxjs';
import { startWith, map } from 'rxjs/operators';
import { UserService } from '../../services/user.service';
import { User } from '../../models/user';
import { ActionState } from '../../enums/action-state';

export class Lead {
  UserID: string;
  FullName: string;
  IsPM: boolean;
  constructor() {
    this.UserID = '';
    this.FullName = '';
    this.IsPM = false;
  }
}

@Component({
  selector: 'app-add-user-popup',
  templateUrl: './add-user-popup.component.html',
  styleUrls: ['./add-user-popup.component.scss']
})

export class AddUserPopupComponent implements OnInit, OnDestroy {
  //#region property
  // reference form contact
  rfContact: FormGroup;
  // mảng tên lead
  leads: Lead[] = [];
  // subcription
  subs: Array<Subscription> = [];
  //#region life cycle
  constructor(public dialogRef: MatDialogRef<AddUserPopupComponent>,
    @Inject(MAT_DIALOG_DATA) public data: any,
    private fb: FormBuilder,
    private userSV: UserService
  ) { }
  // khởi tạo các đối tượng form control
  ngOnInit() {
    // lấy data combo
    this.getLeadInfo();
    this.rfContact = this.fb.group({
      UserName: this.fb.control('B06-', [Validators.required]),
      FullName: this.fb.control('', [Validators.required]),
      Password: this.fb.control('', [Validators.required]),
      IsLead: this.fb.control(0),
      LeadID: this.fb.control('cf577878-5b80-41c4-9901-b71b8b53c649', [Validators.required])
    });
  }
  ngOnDestroy() {
    this.subs.forEach(e => {
      e.unsubscribe();
    });
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
    let user = new User(ActionState.Add);
    user = this.rfContact.value;
    user.state = ActionState.Add;
    const addSub = this.userSV.addUser(user).subscribe(data => {
      this.dialogRef.close(this.rfContact.value);
    }, err => {
      alert('có lỗi xảy ra!');
    });
  }
  // đóng dialog
  cancelDialog() {
    this.dialogRef.close(false);
  }
}
