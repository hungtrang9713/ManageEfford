import { Input } from "@angular/core";

export class BaseControl {
    @Input()
    name: string;
  
    @Input()
    label: string;
  
    @Input()
    width: string = "100%";
  
    @Input()
    labelWidth: string;
  
    @Input()
    isVertical: boolean = false;
  
    height: string = "32px";

}
