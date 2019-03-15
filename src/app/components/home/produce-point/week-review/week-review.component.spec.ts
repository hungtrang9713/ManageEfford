import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { WeekReviewComponent } from './week-review.component';

describe('WeekReviewComponent', () => {
  let component: WeekReviewComponent;
  let fixture: ComponentFixture<WeekReviewComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ WeekReviewComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(WeekReviewComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
