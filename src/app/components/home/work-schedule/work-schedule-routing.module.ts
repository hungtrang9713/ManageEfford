import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { WorkScheduleComponent } from './work-schedule.component';

const routes: Routes = [
  {
    path: '',
    component: WorkScheduleComponent
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class WorkScheduleRoutingModule { }
