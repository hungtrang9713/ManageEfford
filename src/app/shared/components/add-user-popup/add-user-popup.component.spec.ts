import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { AddUserPopupComponent } from './add-user-popup.component';

describe('AddUserPopupComponent', () => {
  let component: AddUserPopupComponent;
  let fixture: ComponentFixture<AddUserPopupComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ AddUserPopupComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(AddUserPopupComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
