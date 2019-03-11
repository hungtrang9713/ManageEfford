import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { ManagerPbiComponent } from './manager-pbi.component';

describe('ManagerPbiComponent', () => {
  let component: ManagerPbiComponent;
  let fixture: ComponentFixture<ManagerPbiComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ ManagerPbiComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ManagerPbiComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
