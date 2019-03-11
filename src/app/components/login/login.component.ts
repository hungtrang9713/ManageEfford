import { Component, OnInit } from '@angular/core';
import { ConfigService } from 'src/app/shared/services/config.service';
import { HttpClient } from '@angular/common/http';

declare var $ :any;

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss']
})
export class LoginComponent implements OnInit {

  //#region LifeCycle
  constructor(
    private configSV: ConfigService,
    private http: HttpClient
  ) { }

  ngOnInit() {
  }
  //#endregion
  //#region Property
  currentData = {
    username: '',
    password: ''
  }
  
  //#endregion
  //#region Method
  login() {
    
  }
  //#endregion

}
