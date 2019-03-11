import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { ManagerPbiRoutingModule } from './manager-pbi-routing.module';
import { ManagerPbiComponent } from './manager-pbi.component';

@NgModule({
  declarations: [ManagerPbiComponent],
  imports: [
    CommonModule,
    ManagerPbiRoutingModule
  ]
})
export class ManagerPbiModule { }
