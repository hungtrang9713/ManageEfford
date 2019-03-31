import { NgModule } from '@angular/core';
import { A11yModule } from '@angular/cdk/a11y';
import { CommonModule } from '@angular/common';
import { ListDeveloperComponent } from './list-developer/list-developer.component';
import { ProducePointRoutingModule } from './produce-point-routing.module';
import { ProducePointComponent } from './produce-point.component';
// tslint:disable-next-line:max-line-length
import { MatTableModule, MatPaginatorModule, MatInputModule, MatDialogModule, MatSelectModule, MatButton, MatButtonModule } from '@angular/material';
import { AddTaskComponent } from './add-task/add-task.component';
import { WeekReviewComponent } from './week-review/week-review.component';
import { FormsModule } from '@angular/forms';
import { CalendarComponent } from './calendar/calendar.component';
import { CalendarModule, DateAdapter } from 'angular-calendar';
import { adapterFactory } from 'angular-calendar/date-adapters/date-fns';
import { NotifierModule, NotifierOptions } from 'angular-notifier';
import { SharedComponentModule } from 'src/app/shared/components/shared-component.module';
import { AddUserPopupComponent } from 'src/app/shared/components/add-user-popup/add-user-popup.component';
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
      distance: 528,
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
  declarations: [
    ListDeveloperComponent,
    ProducePointComponent,
    AddTaskComponent,
    WeekReviewComponent,
    CalendarComponent
  ],
  imports: [
    CommonModule,
    ProducePointRoutingModule,
    SharedComponentModule,
    MatTableModule,
    MatInputModule,
    MatDialogModule,
    MatButtonModule,
    FormsModule,
    MatSelectModule,
    A11yModule,
    NotifierModule.withConfig(customNotifierOptions),
    CalendarModule.forRoot({
      provide: DateAdapter,
      useFactory: adapterFactory
    })
  ],
  entryComponents: [
    AddTaskComponent,
    AddUserPopupComponent
  ]
})
export class ProducePointModule { }
