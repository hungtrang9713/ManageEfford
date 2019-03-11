import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { HtTextboxComponent } from './ht-textbox.component';

describe('HtTextboxComponent', () => {
  let component: HtTextboxComponent;
  let fixture: ComponentFixture<HtTextboxComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ HtTextboxComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(HtTextboxComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
