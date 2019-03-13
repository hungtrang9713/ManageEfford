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
import { MatPaginatorModule, MatTableModule } from '@angular/material';

@NgModule({
  declarations: [
    AppComponent,
    LoginComponent,
    AddTaskComponent,
    ListDeveloperComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    BrowserAnimationsModule,
    HttpClientModule,
    SharedComponentModule,
    FormsModule,
    MatPaginatorModule,
    MatTableModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
