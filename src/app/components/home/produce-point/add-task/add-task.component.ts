import { Component, OnInit, Inject } from '@angular/core';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material';
export interface Task {
  ID: string;
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
  constructor(public dialogRef: MatDialogRef<AddTaskComponent>,
    @Inject(MAT_DIALOG_DATA) public data: any
  ) { }

  ngOnInit() {
    // fake du lieu
    this.tasks = [{
      ID: `123`,
      PBI: 1997,
      TaskName: `Đi học`,
      EffortPoint: 4,
      MinusPoint: 0,
      FinalScore: 4,
      Note: ``
    }, {
      ID: `124`,
      PBI: 1997,
      TaskName: `Đi ăn`,
      EffortPoint: 4,
      MinusPoint: 0,
      FinalScore: 4,
      Note: `chậm trể`
    }];
  }
  /**
   * hàm thêm mới task
   */
  addTask() {
    const taskNew: Task = {
      ID: `${Math.floor((Math.random() * 100) + 1)}`,
      PBI: 1997,
      TaskName: ``,
      EffortPoint: 0,
      MinusPoint: 0,
      FinalScore: 0,
      Note: ``
    };
    this.tasks.push(taskNew);
  }
  /**
   * hàm xóa task
   */
  deleteTask(task: Task) {
    for (let i = 0; i < this.tasks.length; i++) {
      if (task.ID === this.tasks[i].ID) {
        this.tasks.splice(i, 1);
        break;
      }
    }
  }
  /**
   * hàm lưu công việc
   */
  saveData() {
    console.log(this.tasks);
    // call service here
    this.dialogRef.close();
  }
  cancelDialog() {
    this.dialogRef.close();
  }
}
