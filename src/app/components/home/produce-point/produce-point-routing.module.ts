import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { ProducePointComponent } from './produce-point.component';

const routes: Routes = [
  {
    path: '',
    component: ProducePointComponent
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class ProducePointRoutingModule { }
