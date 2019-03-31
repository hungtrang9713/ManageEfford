import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { WorkScheduleComponent } from './work-schedule.component';

const routes: Routes = [
    {
      path: '',
      redirectTo: `schedule/${localStorage.getItem('UserID')}/${localStorage.getItem('FullName')}`,
      pathMatch: 'full'
    },
    {
      path: 'schedule/:userID/:fullName',
      component: WorkScheduleComponent
    }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class WorkScheduleRoutingModule { }
