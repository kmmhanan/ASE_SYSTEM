import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class MapService {
  map: google.maps.Map;

  constructor() {}

  initMap(mapContainer: HTMLElement): void {
    const mapOptions: google.maps.MapOptions = {
      center: { lat: 51.678418, lng: 7.809007 },
      zoom: 8
    };
    this.map = new google.maps.Map(mapContainer, mapOptions);
  }

  getCoordinates(event: google.maps.MouseEvent): { lat: number, lng: number } {
    const lat = event.latLng.lat();
    const lng = event.latLng.lng();
    return { lat, lng };
  }
}