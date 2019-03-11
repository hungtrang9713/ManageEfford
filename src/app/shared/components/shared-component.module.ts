import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { HtTextboxComponent } from './ht-textbox/ht-textbox.component';
import { HtButtonComponent } from './ht-button/ht-button.component';
import { FormsModule } from '@angular/forms';

@NgModule({
  declarations: [
    HtTextboxComponent,
    HtButtonComponent
  ],
  imports: [
    CommonModule,
    FormsModule
  ],
  exports: [
    HtTextboxComponent,
    HtButtonComponent
  ]
})
export class SharedComponentModule { }
