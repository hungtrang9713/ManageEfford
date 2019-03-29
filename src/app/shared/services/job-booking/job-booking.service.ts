import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { HttpClient } from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})
export class JobBookingService {

  public API_URL = 'http://localhost:55465/Schedule';

  constructor(public http: HttpClient) { }

  getBookingJobMonth(month, year, userID): Observable<any> {
    return this.http.get<any>(`${this.API_URL}/${month}/${year}/${userID}`);
  }
}
