import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { ManageGroupRoutingModule } from './manage-group-routing.module';
import { ManageGroupComponent } from './manage-group.component';
import { ListEmployeeComponent } from './list-employee/list-employee.component';
import { EditUserPopupComponent } from './edit-user-popup/edit-user-popup.component';
import { NotifierModule, NotifierOptions } from 'angular-notifier';
import { MatDialogModule, MatCheckboxModule, MatInputModule, MatFormFieldModule } from '@angular/material';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
/*
 * Custom angular notifier options
 */
const customNotifierOptions: NotifierOptions = {
  position: {
    horizontal: {
      position: 'right',
      distance: 12
    },
    vertical: {
      position: 'bottom',
      distance: 12,
      gap: 10
    }
  },
  theme: 'material',
  behaviour: {
    autoHide: 4000,
    onClick: 'hide',
    onMouseover: 'pauseAutoHide',
    showDismissButton: true,
    stacking: 4
  },
  animations: {
    enabled: true,
    show: {
      preset: 'slide',
      speed: 300,
      easing: 'ease'
    },
    hide: {
      preset: 'fade',
      speed: 300,
      easing: 'ease',
      offset: 50
    },
    shift: {
      speed: 300,
      easing: 'ease'
    },
    overlap: 150
  }
};
@NgModule({
  declarations: [ManageGroupComponent, ListEmployeeComponent, EditUserPopupComponent],
  imports: [
    MatDialogModule,
    CommonModule,
    NotifierModule.withConfig(customNotifierOptions),
    FormsModule,
    ManageGroupRoutingModule,
    MatCheckboxModule,
    ReactiveFormsModule,
    MatInputModule,
    MatFormFieldModule,
  ],
  entryComponents: [
    EditUserPopupComponent
  ]
})
export class ManageGroupModule { }
