import { Injectable } from '@angular/core';
import { AngularFireDatabase, AngularFireList } from '@angular/fire/compat/database';
import { ThenableReference } from '@angular/fire/database';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class FirebaseService {
  constructor(private db: AngularFireDatabase) {}

  getData(collection: string): Observable<any[]> {
    return this.db.list<any>(collection).valueChanges();
  }

  addData(collection: string, data: any): AngularFireList<any> {
    return this.db.list<any>(collection);
  }
}
