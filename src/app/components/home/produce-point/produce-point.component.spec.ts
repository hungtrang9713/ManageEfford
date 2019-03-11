import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { ProducePointComponent } from './produce-point.component';

describe('ProducePointComponent', () => {
  let component: ProducePointComponent;
  let fixture: ComponentFixture<ProducePointComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ ProducePointComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ProducePointComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
