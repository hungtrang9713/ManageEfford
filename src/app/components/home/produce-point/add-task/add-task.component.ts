import { Component, OnInit, Inject, OnDestroy, Output, EventEmitter } from '@angular/core';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material';
import { Task } from 'src/app/shared/models/Task';
import { TaskService } from 'src/app/shared/services/task/task.service';
import { Subscription } from 'rxjs';
import { getWeekOfMonth } from 'src/app/shared/fn/get-week-in-month';
import { ActionState } from 'src/app/shared/enums/action-state';

@Component({
  selector: 'app-add-task',
  templateUrl: './add-task.component.html',
  styleUrls: ['./add-task.component.scss']
})

export class AddTaskComponent implements OnInit, OnDestroy {
  // id hứng từ bản ghi
  ID: number;
  // tạo một mảng quản lý các task
  tasks: Array<Task> = [];

  subscription: Array<Subscription> = [];
  //#region life cycle
  constructor(public dialogRef: MatDialogRef<AddTaskComponent>,
    @Inject(MAT_DIALOG_DATA) public data: any,
    private taskSV: TaskService
  ) { }

  ngOnInit() {
    this.getDataDay(this.data.date, this.data.emID);
  }
  ngOnDestroy(): void {
    this.subscription.forEach(sub => {
      sub.unsubscribe();
    });
  }
  //#region function

  /**
   * hàm get dữ liệu ngày
   */
  getDataDay(day: Date, userID: string) {
    // chuyển datetime => date (y-m-d)
    const dataSend = `${day.getFullYear()}-${day.getMonth() + 1}-${day.getDate()}`;
    const getDataDaySub = this.taskSV.getDataDay(dataSend, userID).subscribe(data => {
      // nếu data trả về chưa có thì là thêm mới, còn nếu đã có thì chuyển các tasks sang state sửa
      if (data.length !== 0) {
        this.handleStateTask(data);
      } else {
        const taskNew = new Task(userID, getWeekOfMonth(day), day);
        taskNew.State = ActionState.Add;
        this.tasks.push(taskNew);
      }
    });
    this.subscription.push(getDataDaySub);
  }
  /**
   * hàm đổi trạng thái nếu mở form sửa
   * @param data dữ liệu get về đc
   */
  handleStateTask(data) {
    data.forEach(function (element, index) {
      if (element.State === ActionState.Delete) {
        data.splice(index, 1);
      } else {
        element.State = ActionState.Edit;
      }
    });
    this.tasks = data;
  }
  /**
   * hàm thêm mới task
   */
  addTask() {
    const userID = this.data.emID, weekNumber = getWeekOfMonth(this.data.date);
    const taskNew = new Task(userID, weekNumber, this.data.date);
    taskNew.State = ActionState.Add;
    this.tasks.push(taskNew);
  }
  /**
   * hàm xóa task
   */
  deleteTask(task: Task) {
    for (let i = 0; i < this.tasks.length; i++) {
      if (task.TaskID === this.tasks[i].TaskID) {
        if (this.tasks.length <= 1 || task.TaskName !== '') {
          task.State = ActionState.Delete;
          task.Deleted = true;
        } else {
          task.State = ActionState.Delete;
          this.tasks.splice(i, 1);
        }
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
    let validate = true;
    if (this.tasks.length !== 0) {
      this.tasks.forEach(Element => {
        if (Element.TaskName === '') {
          validate = false;
        } else
          if (Element.State === ActionState.Add) {
            // nếu là add thì phải convert sang string
            // tslint:disable-next-line:max-line-length
            Element.DateWorking = `${Element.DateWorking.getFullYear()}-${Element.DateWorking.getMonth() + 1}-${Element.DateWorking.getDate()}`;
          } else { }
      });
      if (validate) {
        // call service here
        const updateDatasub = this.taskSV.updateDataTask(this.tasks).subscribe(data => {
          if (data) {
            this.dialogRef.close(true);
          }
        });
        this.subscription.push(updateDatasub);
      } else {
        alert('Tên Công việc không được để trống');
      }
    }
  }
  // đóng dialog
  cancelDialog() {
    this.dialogRef.close(false);
  }
}
