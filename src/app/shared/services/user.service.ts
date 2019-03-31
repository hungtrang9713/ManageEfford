import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { ConfigService } from './config.service';
import { Observable } from 'rxjs';
import { User } from '../models/user';
import { ActionState } from '../enums/action-state';

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
  /**
   * lấy danh sách lead
   */
  getListLead(): Observable<any> {
    return this.http.get<any>(`${this.API_URL}/listLead`);
  }
  /**
   * lấy danh sách user nhóm theo lead
   */
  getListUser(): Observable<any> {
    return this.http.get<any>(`${this.API_URL}/listEmployee`);
  }
  /**
   * thêm user
   */
  addUser(user: User): Observable<any> {
    user.state = ActionState.Add;
    return this.http.post<any>(`${this.API_URL}`, user);
  }
  /**
   * sửa user
   */
  editUser(user: User): Observable<any> {
    user.state = ActionState.Edit;
    return this.http.post<any>(`${this.API_URL}`, user);
  }
  /**
   * xóa user
   * trạng thái là delete
   */
  deleteUser(user: User): Observable<any> {
    user.state = ActionState.Delete;
    return this.http.post<any>(`${this.API_URL}`, user);
  }
}
