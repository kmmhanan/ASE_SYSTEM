import { Component, OnInit } from '@angular/core';
import { FormControl } from '@angular/forms';
import { MatTableDataSource } from '@angular/material/table';
import { FirebaseService } from 'src/app/services/firebase.service';

@Component({
  selector: 'app-reservation',
  templateUrl: './reservation.component.html',
  styleUrls: ['./reservation.component.scss']
})
export class AppReservationComponent implements OnInit{

  dataSource: MatTableDataSource<any>;
  displayedColumns: string[] = ['passengerMobileNo', 'vehicleType', 'pickupDate', 'pickLocationAddress', 'dropLocationAddress'];
  data: any[] = [];

  constructor(
    private firebaseService: FirebaseService,
  ) {
    this.loadData();
  
  }

  ngOnInit(): void {
  }

 loadData(){
    // this.data = [
    //   { 
    //     id: "11021",
    //     passenger: 'Viloshani Gunawardana', 
    //     driver: 'Mark Perera', 
    //     vehicle_type: 'Car',
    //     reserve_date: '26 Feb 2024 - 12:30PM',
    //     amount: 550,
    //     status: 'Completed',
    //   },
    //   { 
    //     id: "11021",
    //     passenger: 'Viloshani Gunawardana', 
    //     driver: 'Mark Perera', 
    //     vehicle_type: 'Car',
    //     reserve_date: '26 Feb 2024 - 12:30PM',
    //     amount: 550,
    //     status: 'Completed',
    //   }
    // ];
    this.firebaseService.getData('reservations').subscribe(data => {
      this.data = data
      this.dataSource = new MatTableDataSource(this.data);
      console.log('loadData - reservations:', data);
    });
  }
 

}
