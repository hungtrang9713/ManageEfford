import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { HomeComponent } from './home.component';
import { WorkScheduleComponent } from './work-schedule/work-schedule.component';
import { ManagerPbiComponent } from './manager-pbi/manager-pbi.component';

const routes: Routes = [
  {
    path: '',
    component: HomeComponent,
    children: [
      {
        path: '',
        redirectTo: 'work-schedule',
        pathMatch: 'full'
      },
      {
        path: 'work-schedule',
        loadChildren: './work-schedule/work-schedule.module#WorkScheduleModule'
      },
      {
        path: 'manager-pbi',
        loadChildren: './manager-pbi/manager-pbi.module#ManagerPbiModule'
      }
    ]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class HomeRoutingModule { }
