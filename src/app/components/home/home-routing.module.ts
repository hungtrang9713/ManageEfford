import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { HomeComponent } from './home.component';

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
      },
      {
        path: 'produce-point',
        loadChildren: './produce-point/produce-point.module#ProducePointModule'
      },
      {
        path: 'manage-group',
        loadChildren: './manage-group/manage-group.module#ManageGroupModule'
      },
    ]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class HomeRoutingModule { }
