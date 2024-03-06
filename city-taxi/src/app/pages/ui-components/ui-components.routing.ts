import { Routes } from '@angular/router';

import { AppReservationComponent } from './reservation/reservation.component';
import { AppReservationAddComponent } from './reservation/reservation-add/reservation-add.component';

export const UiComponentsRoutes: Routes = [
  {
    path: '',
    children: [
      {
        path: 'reservation',
        component: AppReservationComponent,
      },
      {
        path: 'reservation/add',
        component: AppReservationAddComponent,
      },
    ],
  },
];
