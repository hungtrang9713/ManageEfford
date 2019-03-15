import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ListDeveloperComponent } from './list-developer/list-developer.component';
import { ProducePointRoutingModule } from './produce-point-routing.module';
import { ProducePointComponent } from './produce-point.component';
import { MatTableModule, MatPaginatorModule, MatInputModule } from '@angular/material';
import { AddTaskComponent } from './add-task/add-task.component';
import { WeekReviewComponent } from './week-review/week-review.component';

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
    MatInputModule
  ]
})
export class ProducePointModule { }
