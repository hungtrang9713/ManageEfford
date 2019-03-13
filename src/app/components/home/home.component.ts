import { Component, OnInit } from '@angular/core';

declare var $: any;

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.scss']
})
export class HomeComponent implements OnInit {

  constructor() { }

  ngOnInit() {
    $("mat-toolbar-row").on("click", function() {
      $("mat-toolbar-row").removeClass("selected");
      $(this).addClass("selected");
    })
  }

}
