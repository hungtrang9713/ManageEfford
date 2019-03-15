import { Component, OnInit, Inject } from '@angular/core';
import { MAT_DIALOG_DATA } from '@angular/material';
export interface Task {
  PBI: number;
  TaskName: string;
  EffortPoint: number;
  MinusPoint: number;
  FinalScore: number;
  Note: string;
}
@Component({
  selector: 'app-add-task',
  templateUrl: './add-task.component.html',
  styleUrls: ['./add-task.component.scss']
})

export class AddTaskComponent implements OnInit {
  // id hứng từ bản ghi
  ID: number;
  // tạo một mảng quản lý các task
  tasks: Array<Task> = [];
  constructor(
    @Inject(MAT_DIALOG_DATA) public data: any
  ) { }

  ngOnInit() {
    // fake du lieu
    this.tasks = [{
      PBI: 1997,
      TaskName: `Đi học`,
      EffortPoint: 4,
      MinusPoint: 0,
      FinalScore: 4,
      Note: ``
    }, {
      PBI: 1997,
      TaskName: `Đi ăn`,
      EffortPoint: 4,
      MinusPoint: 0,
      FinalScore: 4,
      Note: `chậm trể`
    }];
  }

}
