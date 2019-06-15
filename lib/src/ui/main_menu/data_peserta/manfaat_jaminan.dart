import 'package:flutter/material.dart';
import 'package:jasindo_app/src/blocs/adcps_blocs/getbenefit_bloc.dart';
import 'package:jasindo_app/src/models/adcps/get_benefit.dart';
import 'package:jasindo_app/src/models/adcps/get_plans.dart';
import 'package:jasindo_app/src/models/requests/do_req_benefit.dart';
import 'package:jasindo_app/widgets/TextWidget.dart';

class BenefitGuaranty extends StatefulWidget {
  GetPlansModel plans;
  String cardNumber, birthDate;

  BenefitGuaranty({this.plans, this.cardNumber, this.birthDate});

  final bloc = GetBenefitBloc();

  @override
  State<StatefulWidget> createState() {
    return BenefitGuarantyState();
  }
}

class BenefitGuarantyState extends State<BenefitGuaranty> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListView.builder(
          itemBuilder: (BuildContext context, int index) => widget.plans != null
              ? EntryItem(
                  widget.plans, index, widget.cardNumber, widget.birthDate)
              : Center(
                  child: CircularProgressIndicator(),
                ),
          itemCount: widget.plans != null ? widget.plans.data.length : 0,
        ),
      ),
    );
  }
}

class EntryItem extends StatelessWidget {
  const EntryItem(this.plans, this.index, this.cardNumber, this.birthDate);

  //final Entry entry;
  final GetPlansModel plans;
  final int index;
  final String cardNumber, birthDate;

  Widget _buildTiles(GetPlansModel plan) {
    return Card(
      child: ExpansionTile(
          onExpansionChanged: ((isExpand) {
            if (isExpand) {
              _fetchBenefit(cardNumber, birthDate, plan.data[index].planId);
            }
          }),
          title: _buildHeader(plans, index),
          children: <Widget>[
            new StreamBuilder(
                stream: bloc.getBenefit,
                builder: (context, AsyncSnapshot<GetBenefitModel> snapshot) {
                  if (snapshot.hasData) {
                    return _viewChildren(snapshot);
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  return Container(
                    child: CircularProgressIndicator(),
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                  );
                })
          ]),
      elevation: 4,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(plans);
  }

  Widget _buildHeader(GetPlansModel plans, int index) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 8, top: 8),
            child: TextWidget(
              txt: plans.data[index].planType,
              txtSize: 16,
              color: Colors.blue,
            ),
          ),
          Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextWidget(
                    txt: 'Policy Date',
                    txtSize: 14,
                  ),
                  TextWidget(
                    txt: 'Max',
                    txtSize: 14,
                  ),
                  TextWidget(
                    txt: 'Current Limit',
                    txtSize: 14,
                  ),
                ],
              ),
              Spacer(flex: 5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextWidget(
                    txt:
                        "${plans.data[index].policyStartDate.replaceAll("-", "/")} - ${plans.data[index].policyEndDate.replaceAll("-", "/")}",
                    txtSize: 14,
                  ),
                  TextWidget(
                    txt: plans.data[index].maxIdr.contains('9') &&
                            plans.data[index].maxIdr.length >= 8
                        ? "As Charged"
                        : "${plans.data[index].maxIdr} ${plans.data[index].frequencyDesc}",
                    txtSize: 14,
                  ),
                  TextWidget(
                    txt: plans.data[index].currentLimit,
                    txtSize: 14,
                  ),
                ],
              ),
              Spacer(flex: 5),
            ],
          ),
        ],
      ),
    );
  }

  _fetchBenefit(cardNumb, birthDate, planId) {
    final request = ReqGetBenefit(
        cardNumber: cardNumb, birthDate: birthDate, planId: planId);
    bloc.fetchBenefit(request.toMap());
  }

  Widget _viewChildren(AsyncSnapshot<GetBenefitModel> snapshot) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: snapshot.data.data.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.only(left: 17.0, bottom: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Divider(height: 3),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 2, top: 8),
                  child: TextWidget(
                    txt: snapshot.data.data[index].benefitName.toString(),
                    txtSize: 14,
                    color: Colors.blue,
                  ),
                ),
                Row(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextWidget(
                          txt: 'Max',
                          txtSize: 12,
                        ),
                        TextWidget(
                          txt: 'Available Limit',
                          txtSize: 12,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextWidget(
                          txt: snapshot.data.data[index].maxIdr.contains('9') &&
                                  snapshot.data.data[index].maxIdr.length >= 8
                              ? "As Charged"
                              : "${snapshot.data.data[index].maxIdr} ${snapshot.data.data[index].frequencyDesc}",
                          txtSize: 10,
                        ),
                        TextWidget(
                          txt: snapshot.data.data[index].available
                                      .contains('9') &&
                                  snapshot.data.data[index].available.length >=
                                      8
                              ? "As Charged"
                              : snapshot.data.data[index].available,
                          txtSize: 10,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
