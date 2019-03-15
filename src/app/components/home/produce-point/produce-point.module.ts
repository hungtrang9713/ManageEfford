import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ListDeveloperComponent } from './list-developer/list-developer.component';
import { ProducePointRoutingModule } from './produce-point-routing.module';
import { ProducePointComponent } from './produce-point.component';
import { MatTableModule, MatPaginatorModule, MatInputModule, MatDialog, MatDialogModule } from '@angular/material';
import { AddTaskComponent } from './add-task/add-task.component';
import { WeekReviewComponent } from './week-review/week-review.component';
import { FormsModule } from '@angular/forms';

@NgModule({
  declarations: [
    ListDeveloperComponent,
    ProducePointComponent,
    AddTaskComponent,
    WeekReviewComponent
  ],
  imports: [
    CommonModule,
    ProducePointRoutingModule,
    MatTableModule,
    MatPaginatorModule,
    MatInputModule,
    MatDialogModule,
    FormsModule
  ],
  entryComponents: [
    AddTaskComponent
  ]
})
export class ProducePointModule { }
