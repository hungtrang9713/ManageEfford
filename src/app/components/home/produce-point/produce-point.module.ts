import { NgModule } from '@angular/core';
import {A11yModule} from '@angular/cdk/a11y';
import { CommonModule } from '@angular/common';
import { ListDeveloperComponent } from './list-developer/list-developer.component';
import { ProducePointRoutingModule } from './produce-point-routing.module';
import { ProducePointComponent } from './produce-point.component';
import { MatTableModule, MatPaginatorModule, MatInputModule, MatDialog, MatDialogModule, MatSelectModule } from '@angular/material';
import { AddTaskComponent } from './add-task/add-task.component';
import { WeekReviewComponent } from './week-review/week-review.component';
import { FormsModule } from '@angular/forms';
import { CalendarComponent } from './calendar/calendar.component';
import { CalendarModule, DateAdapter } from 'angular-calendar';
import { adapterFactory } from 'angular-calendar/date-adapters/date-fns';


@NgModule({
  declarations: [
    ListDeveloperComponent,
    ProducePointComponent,
    AddTaskComponent,
    WeekReviewComponent,
    CalendarComponent
  ],
  imports: [
    CommonModule,
    ProducePointRoutingModule,
    MatTableModule,
    MatPaginatorModule,
    MatInputModule,
    MatDialogModule,
    FormsModule,
    MatSelectModule,
    A11yModule,
    CalendarModule.forRoot({
      provide: DateAdapter,
      useFactory: adapterFactory
    })
  ],
  entryComponents: [
    AddTaskComponent
  ]
})
export class ProducePointModule { }
