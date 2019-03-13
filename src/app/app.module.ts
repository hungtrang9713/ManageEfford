import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';

import { AppComponent } from './app.component';
import { AppRoutingModule } from './app-routing.module';
import {BrowserAnimationsModule} from '@angular/platform-browser/animations';
import { HttpClientModule } from '@angular/common/http';
import { LoginComponent } from './components/login/login.component';
import { SharedComponentModule } from './shared/components/shared-component.module';
import { FormsModule } from '@angular/forms';
import { AddTaskComponent } from './components/task-management/add-task/add-task.component';
import { ListDeveloperComponent } from './components/task-management/list-developer/list-developer.component';
import { MatPaginatorModule, MatTableModule, MatInputModule } from '@angular/material';
import { WeekReviewComponent } from './components/task-management/week-review/week-review.component';

@NgModule({
  declarations: [
    AppComponent,
    LoginComponent,
    AddTaskComponent,
    ListDeveloperComponent,
    WeekReviewComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    BrowserAnimationsModule,
    HttpClientModule,
    SharedComponentModule,
    FormsModule,
    MatPaginatorModule,
    MatTableModule,
    MatInputModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
