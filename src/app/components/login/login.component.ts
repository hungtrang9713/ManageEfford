import { Component, OnInit } from '@angular/core';
import { ConfigService } from 'src/app/shared/services/config.service';
import { HttpClient } from '@angular/common/http';
import { Subscription } from 'rxjs';
import { UserService } from 'src/app/shared/services/user.service';
import { Router } from '@angular/router';

declare var $: any;

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss']
})
export class LoginComponent implements OnInit {
  //#region Property
  currentData = {
    username: '',
    password: ''
  }
  sub: Subscription;
  //#region LifeCycle
  constructor(
    private configSV: ConfigService,
    private userSV: UserService,
    private http: HttpClient,
    private navigator: Router
  ) { }

  ngOnInit() {
  }
  //#endregion


  //#endregion
  //#region Method
  login() {
    this.sub = this.userSV.login(this.currentData).subscribe(data => {
      localStorage.setItem('Token', data.Token);
      localStorage.setItem('UserName', data.UserInfo.UserName);
      localStorage.setItem('FullName', data.UserInfo.FullName);
      localStorage.setItem('IsLead', data.UserInfo.IsLead);
      localStorage.setItem('UserID', data.UserInfo.UserID);
      this.navigator.navigate([`/home/`]);
    },
      err => {
        alert('Tên đăng nhập hoặc mật khẩu không đúng!')
      });
  }
  //#endregion

}
