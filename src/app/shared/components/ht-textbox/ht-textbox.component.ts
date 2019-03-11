import { Component, OnInit, Input, ViewChild, ElementRef, forwardRef } from '@angular/core';
import { BaseControl } from '../base-control';
import { ControlValueAccessor, NG_VALUE_ACCESSOR } from '@angular/forms';

@Component({
  selector: 'ht-textbox',
  templateUrl: './ht-textbox.component.html',
  styleUrls: ['./ht-textbox.component.scss'],
  providers: [
    {
      provide: NG_VALUE_ACCESSOR,
      useExisting: forwardRef(() => HtTextboxComponent),
      multi: true
    }
  ]
})

export class HtTextboxComponent extends BaseControl implements OnInit, ControlValueAccessor {

  //#region LifeCycle
  constructor() {
    super();
  }

  ngOnInit() {
  }
  //#endregion

  //#region Property

  onChange: any;

  onTouched: any;

  _value: string;

  get value(): any {
    return this._value;
  };

  set value(val: any) {
    this._value = val;
    this.onChange(val);
    this.onTouched();
  }
  //#endregion

  //#region Method
  writeValue(val: any): void {
    if (val) {
      this._value = val;
    }
  }
  registerOnChange(fn: any): void {
    this.onChange = fn;
  }
  registerOnTouched(fn: any): void {
    this.onTouched = fn;
  }
  setDisabledState?(isDisabled: boolean): void {
    throw new Error("Method not implemented.");
  }
  //#endregion

}
