import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { WorkScheduleRoutingModule } from './work-schedule-routing.module';
import { WorkScheduleComponent } from './work-schedule.component';

@NgModule({
  declarations: [WorkScheduleComponent],
  imports: [
    CommonModule,
    WorkScheduleRoutingModule
  ]
})
export class WorkScheduleModule { }
