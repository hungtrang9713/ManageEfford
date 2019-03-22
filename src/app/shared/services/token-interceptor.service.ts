import { Injectable } from '@angular/core';
import { HttpInterceptor } from '@angular/common/http';

@Injectable()
export class TokenInterceptorService implements HttpInterceptor {

  constructor() { }
  intercept(req, next) {
    const tokenReq = req.clone({
      setHeaders: {
        Authorization: `Basic ${localStorage.getItem('Token')}`
      }
    })
    return next.handle(tokenReq);
  }
}
