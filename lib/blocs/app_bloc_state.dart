import 'package:equatable/equatable.dart';

class AppState extends Equatable {
  final AppStatus status;

  const AppState._({this.status = AppStatus.unknown});

  const AppState.unknown() : this._();

  const AppState.generatingData() : this._(status: AppStatus.generatingDataset);

  const AppState.datasetGenerated()
      : this._(status: AppStatus.datasetGenerated);

  const AppState.fillingSack() : this._(status: AppStatus.fillingSack);

  const AppState.sackFilled() : this._(status: AppStatus.sackFilled);

  @override
  List<Object?> get props => [status];
}

enum AppStatus {
  unknown,
  generatingDataset,
  datasetGenerated,
  fillingSack,
  sackFilled
}
