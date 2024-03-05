import { Component, OnInit } from '@angular/core';
import { AngularFireList } from '@angular/fire/compat/database';
import { FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { MatTableDataSource } from '@angular/material/table';
import { Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { FirebaseService } from 'src/app/services/firebase.service';

@Component({
  selector: 'app-reservation-add',
  templateUrl: './reservation-add.component.html',
  styleUrls: ['./reservation-add.component.scss']
})
export class AppReservationAddComponent implements OnInit{
  form: FormGroup;
  selectedTime: string = '';

  constructor(
    private fb: FormBuilder,
    private firebaseService: FirebaseService,
    private toastr: ToastrService,
    public router: Router,
  ) {
    this.initForm();
  }

  ngOnInit(): void {
  }

  initForm(){
    const currentDate = new Date();
    const pickupDate = this.formatDate(currentDate);
    const pickupTime = this.formatTime(currentDate);

    this.form = this.fb.group({
      passengerMobileNo: new FormControl('', [Validators.required]),
      vehicleType: new FormControl('', [Validators.required]),
      pickupDate: [pickupDate, [Validators.required]],
      pickupTime: [pickupTime, [Validators.required]],
      pickLocationAddress: new FormControl('',),
      pickLocationLatitudes: new FormControl('', [Validators.required]),
      pickLocationLongitudes: new FormControl('', [Validators.required]),
      dropLocationAddress: new FormControl('',),
      dropLocationLatitudes: new FormControl('',),
      dropLocationLongitudes: new FormControl('',),
    });
  }

  private formatDate(date: Date): string {
    return date.toISOString().slice(0, 10); // YYYY-MM-DD
  }

  private formatTime(date: Date): string {
    return date.toTimeString().slice(0, 5); // HH:mm
  }
  
  onTimeChanged(event: Event) {
    const inputElement = event.target as HTMLInputElement;
    this.selectedTime = inputElement.value;
    console.log('Selected time:', this.selectedTime);
  }

  handleLocationSelected(event: { latitude: number, longitude: number }) {
    console.log('Selected Location:', event.latitude, event.longitude);
    // You can now use the selected coordinates here
  }

  handlePickLocationResponse(coordinates: { address:any, lat: any, lng: any}){
    console.log('Received coordinates from map picker:', coordinates);
    this.form.patchValue({
      pickLocationAddress: coordinates.address,
    });
    this.form.patchValue({
      pickLocationLatitudes: coordinates.lat,
    });
    this.form.patchValue({
      pickLocationLongitudes: coordinates.lng
    });
  }

  handleDropLocationResponse(coordinates: { address:any, lat: any, lng: any}){
    this.form.patchValue({
      dropLocationAddress: coordinates.address,
    });
    this.form.patchValue({
      dropLocationLatitudes: coordinates.lat,
    });
    this.form.patchValue({
      dropLocationLongitudes: coordinates.lng
    });
    console.log('Received coordinates from map picker:', coordinates);
  }

  onSubmit() {

    if (this.form.valid) {
      const formData = this.form.value;
      this.firebaseSubmit(formData);

    } else {
      this.form.markAllAsTouched();
      this.toastr.warning("Please select pick location", 'Missing data');
    }
    console.log('Form submitted');
  }

  firebaseSubmit(data:any): void {
    console.log("firebaseSubmit",data);

    const collectionRef: AngularFireList<any> = this.firebaseService.addData('reservations', data);
    collectionRef.push(data)
      .then(() => {
        this.router.navigate(['ui-components/reservation']);
        this.toastr.success("Successfully added a new reservation", 'Success');
      })
      .catch(error => {
        console.error('Error adding data:', error);
      });
  }
  

}
