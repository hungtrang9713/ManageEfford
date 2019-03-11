import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { HtButtonComponent } from './ht-button.component';

describe('HtButtonComponent', () => {
  let component: HtButtonComponent;
  let fixture: ComponentFixture<HtButtonComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ HtButtonComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(HtButtonComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
