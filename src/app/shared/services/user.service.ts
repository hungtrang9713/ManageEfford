import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { ConfigService } from './config.service';

@Injectable({
  providedIn: 'root'
})
export class UserService {

  constructor(
    private http: HttpClient,
    private configSV: ConfigService
  ) {}

  loginAPI: string;

  login(data) {
    this.configSV.getConfig().subscribe( config => {
      // return this.http.post(config['loginAPI'], data);
      this.loginAPI = config['loginAPI'];
      debugger
    });
    debugger
    return this.http.post<any>(this.loginAPI, data);
  }
}
