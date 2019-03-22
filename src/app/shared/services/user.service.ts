import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { ConfigService } from './config.service';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class UserService {
  public API_URL = 'http://localhost:55465/user';

  loginAPI: string;
  dataLogin: any;
  userInfor: any;
  constructor(
    private http: HttpClient,
    private configSV: ConfigService
  ) { }

  login(data): Observable<any> {
    this.dataLogin = data;
    return this.http.post<any>(`${this.API_URL}/login`, data);
  }
  /**
   * lấy thông tin user đang đăng nhập( k dùng session )
   */
  getUserInfor(): any {
    this.http.post<any>(`${this.API_URL}/login`, this.dataLogin).subscribe(result => {
      this.userInfor = result;
    });
    return this.userInfor;
  }
}
