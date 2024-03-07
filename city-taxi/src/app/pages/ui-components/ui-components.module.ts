import { NgModule } from '@angular/core';
import { RouterModule } from '@angular/router';
import { CommonModule } from '@angular/common';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { MaterialModule } from '../../material.module';

// icons
import { TablerIconsModule } from 'angular-tabler-icons';
import * as TablerIcons from 'angular-tabler-icons/icons';

import { UiComponentsRoutes } from './ui-components.routing';


import { AppReservationComponent } from './reservation/reservation.component';
import { AppReservationAddComponent } from './reservation/reservation-add/reservation-add.component';
import { NgxMaterialTimepickerModule } from 'ngx-material-timepicker';
import { MatNativeDateModule } from '@angular/material/core';
import { MapPickerComponent } from 'src/app/components/google-map-dropdown/google-map-dropdown.component';
import { MatAutocompleteModule } from '@angular/material/autocomplete';

@NgModule({
  imports: [
    CommonModule,
    RouterModule.forChild(UiComponentsRoutes),
    MaterialModule,
    FormsModule,
    ReactiveFormsModule,
    TablerIconsModule.pick(TablerIcons),    
    MatNativeDateModule,
    NgxMaterialTimepickerModule,
    MatAutocompleteModule
    
  ],
  declarations: [
    AppReservationComponent,
    AppReservationAddComponent,
    MapPickerComponent
    
    
  ],
})
export class UicomponentsModule {}
