class States {
  int? totalResidences;
  int? totalResidencesActive;
  int? totalResidencesInactive;
  int? totalReservation;
  int? totalReservationsCompleted;
  int? totalReservationsCancelled;
  int? totatMyReservation;
  int? totalMyReservationsCompleted;
  int? totalMyReservationsCancelled;

  States({
    this.totalResidences,
    this.totalResidencesActive,
    this.totalResidencesInactive,
    this.totalReservation,
    this.totalReservationsCompleted,
    this.totalReservationsCancelled,
    this.totatMyReservation,
    this.totalMyReservationsCompleted,
    this.totalMyReservationsCancelled,
  });

  States.fromJson(Map<String, dynamic> json) {
    totalResidences = json['total_residences'];
    totalResidencesActive = json['total_residences_active'];
    totalResidencesInactive = json['total_residences_inactive'];
    totalReservation = json['total_reservation'];
    totalReservationsCompleted = json['total_reservations_completed'];
    totalReservationsCancelled = json['total_reservations_cancelled'];
    totatMyReservation = json['totat_my_reservation'];
    totalMyReservationsCompleted = json['total_my_reservations_completed'];
    totalMyReservationsCancelled = json['total_my_reservations_cancelled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_residences'] = totalResidences;
    data['total_residences_active'] = totalResidencesActive;
    data['total_residences_inactive'] = totalResidencesInactive;
    data['total_reservation'] = totalReservation;
    data['total_reservations_completed'] = totalReservationsCompleted;
    data['total_reservations_cancelled'] = totalReservationsCancelled;
    data['totat_my_reservation'] = totatMyReservation;
    data['total_my_reservations_completed'] = totalMyReservationsCompleted;
    data['total_my_reservations_cancelled'] = totalMyReservationsCancelled;
    return data;
  }
}
