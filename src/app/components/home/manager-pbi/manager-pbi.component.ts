import { Component, OnInit } from '@angular/core';
import { HttpClient } from '@angular/common/http';

@Component({
  selector: 'app-manager-pbi',
  templateUrl: './manager-pbi.component.html',
  styleUrls: ['./manager-pbi.component.scss']
})
export class ManagerPbiComponent implements OnInit {

  constructor(
    private http: HttpClient
  ) { }

  ngOnInit() {
  }

  sendRequest() {
    this.http.get('http://localhost:50999/test').subscribe(res => {
      console.log(res);
    })
  }
}
