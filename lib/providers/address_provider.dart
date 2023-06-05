import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:soni_store_app/models/address.dart';
import 'package:soni_store_app/models/models.dart' as models;

class AddressProvider with ChangeNotifier {
  final List<models.Address> _addressesList = [];
  List<models.Address> get addressesList => _addressesList;

  int get length => addressesList.length;

  models.Address _selectedAddress = const Address(
    uid: '',
    addressId: '',
    pincode: '',
    addressType: '',
    address: '',
    phone: '',
  );
  models.Address get selectedAddress => _selectedAddress;

  Future<void> addAddress(models.Address address, String uid) async {
    try {
      final addressesData = address.toMap();
      if (addressesData.isEmpty) {
        log('Addresses data is null ... ');
        throw Exception('Addresses data is null');
      }

      final addressCollection = FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection("addresses");

      // Generate a new unique document ID for the address
      final newAddressDoc = addressCollection.doc();
      final addressId = newAddressDoc.id;

      // Set the new address document with the generated addressId
      await newAddressDoc.set({
        'addressId': addressId,
        ...addressesData,
      });

      log('New address document created with addressId: $addressId');

      notifyListeners();
    } catch (error) {
      log('Failed to add address: $error');
    }
  }

  Future<List<models.Address>> fetchAddresses(String uid) async {
    try {
      final addressCollection = FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection("addresses");

      final addressesSnapshot = await addressCollection.get();

      _addressesList.clear(); // Clear the existing addresses list

      for (var doc in addressesSnapshot.docs) {
        var addressData = doc.data();
        _addressesList.add(Address.fromMap(addressData));
      }

      return _addressesList;
    } catch (error) {
      log('Failed to fetch addresses: $error');
      return [];
    }
  }

  Future<void> selectAddress(String addressId, String uid) async {
    try {
      _selectedAddress =
          addressesList.firstWhere((address) => address.addressId == addressId);
      notifyListeners();

      // Update the selected address in the user's collection UID document
      final userDocRef =
          FirebaseFirestore.instance.collection('users').doc(uid);
      final userDocSnapshot = await userDocRef.get();

      if (userDocSnapshot.exists) {
        final userData = userDocSnapshot.data();
        final selectedAddressData = {'addressId': addressId};

        // Check if the user document already has a selectedAddress field
        if (userData != null && userData.containsKey('selectedAddress')) {
          // Update the selectedAddress field
          await userDocRef.update({'selectedAddress': selectedAddressData});
          log('Selected address updated in the user document');
        } else {
          // Add the selectedAddress field
          await userDocRef.set({'selectedAddress': selectedAddressData},
              SetOptions(merge: true));
          log('Selected address added to the user document');
        }
      }
    } catch (error) {
      log('Failed to select address: $error');
    }
  }
}
