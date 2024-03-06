import { Component, ElementRef, EventEmitter, Input, OnInit, Output, ViewChild } from '@angular/core';
import { FormControl } from '@angular/forms';

@Component({
  selector: 'app-map-picker',
  templateUrl: './google-map-dropdown.component.html',
  styleUrls: ['./google-map-dropdown.component.scss']
})
export class MapPickerComponent {
  @Output() coordinatesSelected = new EventEmitter<{ address:any, lat: any, lng: any }>();
  @Input() inputNameText: any;

  addressControl = new FormControl();
  filteredPredictions: google.maps.places.AutocompletePrediction[] = [];
  autocompleteService: google.maps.places.AutocompleteService;
  geocoder: google.maps.Geocoder;

  constructor() {
    this.autocompleteService = new google.maps.places.AutocompleteService();
    this.geocoder = new google.maps.Geocoder();
    this.addressControl.valueChanges.subscribe(value => {
      if (value) {
        this.autocompleteService.getPlacePredictions({ input: value }, predictions => {
          this.filteredPredictions = predictions || [];
        });
      } else {
        this.filteredPredictions = [];
      }
    });
  }

  onOptionSelected(event: any): void {
    const selectedAddress = event.option.value;
    this.geocodeAddress(selectedAddress, (coordinates: google.maps.LatLng) => {
      console.log('Selected Address:', selectedAddress);
      console.log('Coordinates:', coordinates.lat(), coordinates.lng());
      this.coordinatesSelected.emit({ address:selectedAddress , lat: coordinates.lat(), lng: coordinates.lng()});
      // You can use the coordinates as needed
    });
  }

  geocodeAddress(address: string, callback: (coordinates: google.maps.LatLng) => void): void {
    this.geocoder.geocode({ address }, (results, status) => {
      if (status === 'OK' && results && results.length > 0) {
        const location = results[0].geometry.location;
        callback(location);
      } else {
        console.error('Geocode was not successful for the following reason:', status);
      }
    });
  }
}