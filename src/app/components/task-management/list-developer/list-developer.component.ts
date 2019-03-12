import { Component, OnInit, ViewChild } from '@angular/core';
import { MatPaginator, MatTableDataSource } from '@angular/material';

/**
 * @title Table with pagination
 */
@Component({
  selector: 'app-list-developer',
  templateUrl: './list-developer.component.html',
  styleUrls: ['./list-developer.component.scss']
})
export class ListDeveloperComponent implements OnInit {
  public displayedColumns: string[] = ['position', 'name', 'weight', 'symbol', 'col5', 'col6', 'col7', 'col8', 'col9', 'col10', 'col11'];
  public dataSource = new MatTableDataSource<PeriodicElement>(ELEMENT_DATA);

  @ViewChild(MatPaginator) paginator: MatPaginator;

  ngOnInit() {
    this.dataSource.paginator = this.paginator;
  }
}

export interface PeriodicElement {
  position: number;
  name: string;
  weight: string;
  symbol: string;
  col5: string;
  col6: string;
  col7: string;
  col8: string;
  col9: string;
  col10: string;
  col11: string;
}

const ELEMENT_DATA: PeriodicElement[] = [
  {
    position: 1, name: 'B06-2211', weight: 'Nguyễn văn A', symbol: '1', col5: '100%',
    col6: '0.00',
    col7: '0.00',
    col8: '0.00',
    col9: '0.00',
    col10: '0.00',
    col11: '0.00'
  },
  {
    position: 2, name: 'B06-0371', weight: 'Nguyễn việt Cường', symbol: '1', col5: '100%',
    col6: '0.00',
    col7: '0.00',
    col8: '0.00',
    col9: '0.00',
    col10: '0.00',
    col11: '0.00'
  },
];

