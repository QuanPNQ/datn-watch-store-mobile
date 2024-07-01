import 'package:equatable/equatable.dart';

abstract class BrandEvent extends Equatable {
  const BrandEvent();

  @override
  List<Object> get props => [];
}

class GetListBrandEvent extends BrandEvent {
  final bool isViewAll;
  final int? page;
  final int? limit;

  const GetListBrandEvent({this.isViewAll = false, this.page, this.limit});
}
