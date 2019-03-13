import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { WorkScheduleRoutingModule } from './work-schedule-routing.module';
import { WorkScheduleComponent } from './work-schedule.component';
import {MatIconModule} from '@angular/material/icon';
import { DayComponent } from './day/day.component';
import { WeekComponent } from './week/week.component';
import { MatMenuModule } from '@angular/material/menu';

@NgModule({
  declarations: [WorkScheduleComponent, DayComponent, WeekComponent],
  imports: [
    CommonModule,
    WorkScheduleRoutingModule,
    MatIconModule,
    MatMenuModule
  ]
})
export class WorkScheduleModule { }
