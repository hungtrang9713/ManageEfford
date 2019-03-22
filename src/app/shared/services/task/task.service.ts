import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Task } from 'src/app/shared/models/Task';
import { DataMonth } from '../../models/data-month';
@Injectable({
  providedIn: 'root'
})
export class TaskService {
  public API_URL = 'http://localhost:55465/task';
  constructor(public http: HttpClient) { }

  /**
   * hàm lấy dữ liệu tổng hợp theo tháng
   */
  getDataMonth(month, year): Observable<any> {
    return this.http.get<any>(`${this.API_URL}/${month}/${year}`);
  }
  /**
   * hàm lấy dữ liệu task theo tuần
   */
  getDataWeek(month, year, userID): Observable<any> {
    return this.http.get<any>(`${this.API_URL}/${month}/${year}/${userID}`);
  }
  /**
   * hàm thêm mới,sửa,xóa Tasks
   * truyền vào mảng task
   */
  updateDataTask(tasks: Array<Task>): Observable<any> {
    return this.http.post<Task[]>(`${this.API_URL}/list`, tasks);
  }
  /**
   * hàm lấy dữ liệu tasks theo ngày đối với 1 user
   */
  getDataDay(dateWorking, userID): Observable<any> {
    return this.http.get<any>(`${this.API_URL}/day/${dateWorking}/${userID}`);
  }
  /**
   * hàm lấy dữ liệu tasks theo ngày đối với 1 user
   */
  getCheckedDate(month, year, userID): Observable<any> {
    return this.http.get<any>(`${this.API_URL}/dateworking/${month}/${year}/${userID}`);
  }
  /**
   * các hàm xử lý api
   */
  // getAll(): Observable<any> {
  //   return this.http.get<any>(`${this.API_URL}/getall`);
  // }
  // /**
  //  * thêm mới
  //  * @param task : object task
  //  */
  // add(task: Task): Observable<Task[]> {
  //   return this.http.post<Task[]>(`${this.API_URL}/add`, {
  //     title: task.Title,
  //     completed: task.Completed
  //   });
  // }
  // /**
  //  * sửa trạng thái
  //  * @param id id
  //  * @param status trạng thái
  //  */
  // updateStatus(id: number, status: boolean): Observable<any> {
  //   return this.http.get<any>(`${this.API_URL}/status/${id}/${status}`);
  // }
  // /**
  //  * hàm sửa
  //  */
  // update(task: Task): Observable<Task[]> {
  //   return this.http.put<Task[]>(`${this.API_URL}/update`, {
  //     id: task.Id,
  //     title: task.Title,
  //     completed: task.Completed
  //   });
  // }
  // /**
  //  * hàm xóa
  //  */
  // delete(task: Task): Observable<Task[]> {
  //   return this.http.post<Task[]>(`${this.API_URL}/delete`, {
  //     id: task.Id,
  //     title: task.Title,
  //     completed: task.Completed
  //   });
  // }
}
