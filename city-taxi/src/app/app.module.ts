import { Injectable, NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { BrowserAnimationsModule, provideAnimations } from '@angular/platform-browser/animations';
import { HttpClientModule } from '@angular/common/http';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';

// icons
import { TablerIconsModule } from 'angular-tabler-icons';
import * as TablerIcons from 'angular-tabler-icons/icons';

//Import all material modules
import { MaterialModule } from './material.module';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';

//Import Layouts
import { FullComponent } from './layouts/full/full.component';
import { BlankComponent } from './layouts/blank/blank.component';

// Vertical Layout
import { SidebarComponent } from './layouts/full/sidebar/sidebar.component';
import { HeaderComponent } from './layouts/full/header/header.component';
import { BrandingComponent } from './layouts/full/sidebar/branding.component';
import { AppNavItemComponent } from './layouts/full/sidebar/nav-item/nav-item.component';

import { AngularFireModule } from '@angular/fire/compat';
import { AngularFireAuthModule } from '@angular/fire/compat/auth';
import { AngularFireStorageModule } from '@angular/fire/compat/storage';
import { AngularFirestoreModule } from '@angular/fire/compat/firestore';
import { AngularFireDatabaseModule } from '@angular/fire/compat/database';
import { ToastrModule, provideToastr } from 'ngx-toastr';
import { AgmCoreModule, LazyMapsAPILoaderConfigLiteral } from '@agm/core';
import { Config } from 'firebase/auth';

const firebaseConfig = {
  apiKey: "AIzaSyDSxH0Pr6ip8qFqNmEL5Pn7yqVTttibKKc",
  authDomain: "city-taxi-93be1.firebaseapp.com",
  databaseURL: "https://city-taxi-93be1-default-rtdb.firebaseio.com",
  projectId: "city-taxi-93be1",
  storageBucket: "city-taxi-93be1.appspot.com",
  messagingSenderId: "364495813911",
  appId: "1:364495813911:web:0a0b25c5eae677ca214b52",
  measurementId: "G-4F9CXQQ488"
};



@NgModule({
  declarations: [
    AppComponent,
    FullComponent,
    BlankComponent,
    SidebarComponent,
    HeaderComponent,
    BrandingComponent,
    AppNavItemComponent,
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    HttpClientModule,
    BrowserAnimationsModule,
    FormsModule,
    ReactiveFormsModule,
    MaterialModule,
    TablerIconsModule.pick(TablerIcons),
    ToastrModule.forRoot(),

    
    


    AngularFireModule.initializeApp(firebaseConfig),
    AngularFireAuthModule,
    AngularFirestoreModule,
    AngularFireStorageModule,
    AngularFireDatabaseModule,
    
    
  ],
  exports: [TablerIconsModule],
  bootstrap: [AppComponent],
  providers: [
    provideAnimations(), // required animations providers
    provideToastr(), // Toastr providers
  ]
})
export class AppModule {}

