import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { HtTextboxComponent } from './ht-textbox/ht-textbox.component';
import { HtButtonComponent } from './ht-button/ht-button.component';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { AddUserPopupComponent } from './add-user-popup/add-user-popup.component';
import { MatFormFieldModule, MatInputModule, MatCheckboxModule, MatOptionModule, MatSelectModule } from '@angular/material';

@NgModule({
  declarations: [
    HtTextboxComponent,
    HtButtonComponent,
    AddUserPopupComponent
  ],
  imports: [
    CommonModule,
    FormsModule,
    MatFormFieldModule,
    MatInputModule,
    FormsModule,
    ReactiveFormsModule,
    MatCheckboxModule,
    MatOptionModule,
    MatSelectModule
  ],
  exports: [
    HtTextboxComponent,
    HtButtonComponent
  ]
})
export class SharedComponentModule { }
