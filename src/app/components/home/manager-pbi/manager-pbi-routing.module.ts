import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { ManagerPbiComponent } from './manager-pbi.component';

const routes: Routes = [
  {
    path: '',
    component: ManagerPbiComponent
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class ManagerPbiRoutingModule { }
