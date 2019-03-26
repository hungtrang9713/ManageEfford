import { Component, OnInit, Inject } from '@angular/core';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material';
import { FormControl, Validators, FormBuilder, FormGroup } from '@angular/forms';
import { Observable } from 'rxjs';
import { startWith, map } from 'rxjs/operators';

@Component({
  selector: 'app-add-user-popup',
  templateUrl: './add-user-popup.component.html',
  styleUrls: ['./add-user-popup.component.scss']
})
export class AddUserPopupComponent implements OnInit {
  //#region property
  // reference form contact
  rfContact: FormGroup;
  // mảng tên lead
  foods: any[] = [
    { value: 'cf577878-5b80-41c4-9901-b71b8b53c649', viewValue: 'Nguyễn Đình Nghĩa' },
    { value: 'pizza-1', viewValue: 'Pizza' },
    { value: 'tacos-2', viewValue: 'Tacos' }
  ];
  //#region life cycle
  constructor(public dialogRef: MatDialogRef<AddUserPopupComponent>,
    @Inject(MAT_DIALOG_DATA) public data: any,
    private fb: FormBuilder
  ) { }
  // khởi tạo các đối tượng form control
  ngOnInit() {
    this.rfContact = this.fb.group({
      UserName: this.fb.control('B06-', [Validators.required]),
      FullName: this.fb.control('', [Validators.required]),
      Password: this.fb.control('', [Validators.required]),
      IsLead: this.fb.control(0),
      LeadID: this.fb.control('cf577878-5b80-41c4-9901-b71b8b53c649', [Validators.required])
    });

  }
  //#region function
  // hiện lỗi
  getErrorMessage() {
    return this.rfContact.controls.UserName.hasError('required') ? 'Mã nhân viên không được để trống' :
      this.rfContact.controls.FullName.hasError('required') ? 'Tên nhân viên không được để trống' :
        this.rfContact.controls.Password.hasError('required') ? 'Mật khẩu không được để trống' : 'lỗi khác';
  }

  /**
 * hàm lưu công việc
 */
  saveData() {

  }
  onSubmit() {
    console.log(this.rfContact.value);
    this.dialogRef.close(this.rfContact.value);
  }
  // đóng dialog
  cancelDialog() {
    this.dialogRef.close(false);
  }
}
