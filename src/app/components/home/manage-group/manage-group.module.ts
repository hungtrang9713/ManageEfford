import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { ManageGroupRoutingModule } from './manage-group-routing.module';
import { ManageGroupComponent } from './manage-group.component';
import { ListEmployeeComponent } from './list-employee/list-employee.component';

@NgModule({
  declarations: [ManageGroupComponent, ListEmployeeComponent],
  imports: [
    CommonModule,
    ManageGroupRoutingModule
  ]
})
export class ManageGroupModule { }
