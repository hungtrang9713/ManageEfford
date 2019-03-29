import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { ManageGroupComponent } from './manage-group.component';
import { ListEmployeeComponent } from './list-employee/list-employee.component';

const routes: Routes = [
  {
    path: '',
    component: ManageGroupComponent,
    children: [
      {
        path: '',
        redirectTo: 'List',
        pathMatch: 'full'
      },
      {
        path: 'List',
        component: ListEmployeeComponent
      },
    ]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class ManageGroupRoutingModule { }
