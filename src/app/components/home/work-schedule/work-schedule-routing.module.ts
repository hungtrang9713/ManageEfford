import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { WorkScheduleComponent } from './work-schedule.component';
// flag 0 lấy thông tin từ route, 1 lấy từ local storage
const routes: Routes = [
    {
      path: '',
      redirectTo: `schedule/hello/hihi/1`,
      pathMatch: 'full'
    },
    {
      path: 'schedule/:userID/:fullName/:flag',
      component: WorkScheduleComponent
    }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class WorkScheduleRoutingModule { }
