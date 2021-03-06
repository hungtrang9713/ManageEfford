import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { ListDeveloperComponent } from './list-developer/list-developer.component';
import { AddTaskComponent } from './add-task/add-task.component';
import { ProducePointComponent } from './produce-point.component';
import { WeekReviewComponent } from './week-review/week-review.component';

const routes: Routes = [
  {
    path: '',
    component: ProducePointComponent,
    children: [
      {
        path: '',
        redirectTo: 'List',
        pathMatch: 'full'
      },
      {
        path: 'List',
        component: ListDeveloperComponent
      },
      {
        path: 'employee/:id/:month/:year',
        component: WeekReviewComponent
      }
    ]
  }
];
@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class ProducePointRoutingModule { }
