import { Component, OnInit, Inject } from '@angular/core';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material';
import { Task } from 'src/app/shared/models/Task';
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
    console.log(`ID: ${this.data.emID} và ngày : ${this.data.date}`);
    const taskNew = new Task(1, 2, this.data.date);
    this.tasks.push(taskNew);
  }
  /**
   * hàm thêm mới task
   */
  addTask() {
    const taskNew = new Task(1, 2, this.data.date);
    this.tasks.push(taskNew);
  }
  /**
   * hàm xóa task
   */
  deleteTask(task: Task) {
    for (let i = 0; i < this.tasks.length; i++) {
      if (task.TaskID === this.tasks[i].TaskID) {
        this.tasks.splice(i, 1);
        break;
      }
    }
  }
  /**hàm get điểm ghi nhận */
  getFinalScore(t: Task) {
    t.FinalScore = t.EffortScore - t.MinusScore;
    return t.FinalScore;
  }
  /** Gets the total cost of all tasks. */
  getTotalScore() {
    return this.tasks.map(t => t.FinalScore).reduce((acc, value) => acc + value, 0);
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
