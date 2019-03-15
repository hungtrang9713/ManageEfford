import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';

@Component({
  selector: 'app-add-task',
  templateUrl: './add-task.component.html',
  styleUrls: ['./add-task.component.scss']
})
export class AddTaskComponent implements OnInit {
  employeeID: number;
  constructor(private route: ActivatedRoute) { }

  ngOnInit() {
    this.employeeID = this.route.snapshot.params.id;
    console.log(this.employeeID);
  }

}
