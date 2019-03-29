import { TestBed } from '@angular/core/testing';

import { JobBookingService } from './job-booking.service';

describe('JobBookingService', () => {
  beforeEach(() => TestBed.configureTestingModule({}));

  it('should be created', () => {
    const service: JobBookingService = TestBed.get(JobBookingService);
    expect(service).toBeTruthy();
  });
});
