import { Component, OnInit, Input, Output, EventEmitter } from '@angular/core';

@Component({
  selector: 'ht-button',
  templateUrl: './ht-button.component.html',
  styleUrls: ['./ht-button.component.scss']
})
export class HtButtonComponent implements OnInit {

  //#region LifeCycle
  constructor() { }

  ngOnInit() {
  }
  //#endregion
  //#region Property
  @Input()
  name: string;

  @Input()
  text: string;

  @Input()
  icon: string;

  @Input()
  type: string = "btn-basic";

  @Output()
  buttonAction: EventEmitter<any> = new EventEmitter();

  get btnClass() {
    switch (this.type) {
      case "basic":
        return "btn-basic"
      case "primary":
        return "btn-primary"
      case "danger":
        return "btn-danger"
      case "link":
        return "btn-link"
      default:
        return ""
    }
  }
  //#endregion
  //#region Method
  onClick() {
    this.buttonAction.emit();
  }
  //#endregion
}
