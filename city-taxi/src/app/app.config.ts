export interface AppSettings {
  dir: 'ltr' | 'rtl';
  theme: string;
  sidenavOpened: boolean;
  sidenavCollapsed: boolean;
  boxed: boolean;
  horizontal: boolean;
  activeTheme: string;
  language: string;
  cardBorder: boolean;
  navPos: 'side' | 'top';
}

export const defaults: AppSettings = {
  dir: 'ltr',
  theme: 'light',
  sidenavOpened: false,
  sidenavCollapsed: false,
  boxed: true,
  horizontal: false,
  cardBorder: false,
  activeTheme: 'blue_theme',
  language: 'en-us',
  navPos: 'side',
};

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