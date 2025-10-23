import 'package:mothmerah_app/views/profile/data/profile_model.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final ProfileModel profile;

  ProfileLoaded(this.profile);
}

class ProfileError extends ProfileState {
  final String error;

  ProfileError(this.error);
}

class ProfileUpdated extends ProfileState {
  final ProfileModel profile;

  ProfileUpdated(this.profile);
}

class ProfileImageUploaded extends ProfileState {
  final String imageUrl;

  ProfileImageUploaded(this.imageUrl);
}

class ProfileDeleted extends ProfileState {}

class ProfileLogout extends ProfileState {}
