import '../models/booking_history_model.dart';
import '../provider/book_employee.dart';
import '../provider/booking_history.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../shared/components/components.dart';
import '../shared/styles/colors.dart';

class BookingHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /* final bookHistory = Provider.of<AllBookingProvider>(context);
    final bookingData = bookHistory.items;*/
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 12.0,
        titleSpacing: 20.0,
        centerTitle: true,
        title: Text(
          "ارشيف الطلبات",
          style: TextStyle(color: Colors.white),
          //textDirection: TextDirection.rtl,
        ),
      ),
      body: FutureBuilder(
          future: Provider.of<AllBookingProvider>(context, listen: false)
              .fetchAllBooking(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              print("waiting");
              return Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.hasError) {
                print("error snap  error  error${snapshot.error}");
                return Center(
                  child: Text('An error occurred!'),
                );
              } else {
                print("success $snapshot");
                return Consumer<AllBookingProvider>(
                  builder: (ctx, bookingData, child) => SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 15.0, left: 15.0, right: 15.0, bottom: 15.0),
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white.withOpacity(0.5),
                              ),
                              child: buildEmployeeItem(
                                  context, bookingData.items[index])),
                          separatorBuilder: (context, index) => Column(
                            children: [
                              SizedBox(
                                height: 15.0,
                              )
                            ],
                          ),
                          itemCount: bookingData.items.length,
                        ),
                      ),
                    ),
                  ),
                );
              }
            }
          }),
    );
  }

  Widget buildEmployeeItem(context, BookingHistoryModel bookData) => Column(
        children: [
          Card(
            elevation: 10.0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 70.0,
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (bookData.status == "waiting")
                      Padding(
                        padding: const EdgeInsets.only(top: 21.0, left: 18.0),
                        child: Container(
                            child: Text(
                          "في انتظار القبول",
                          style: Theme.of(context).textTheme.caption.copyWith(
                              color: Theme.of(context).primaryColor
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          //textDirection: TextDirection.rtl,
                        )),
                      ),
                    if (bookData.status == "refused")
                      Padding(
                        padding: const EdgeInsets.only(top: 21.0, left: 18.0),
                        child: Container(
                            child: Text(
                          "لم تتم الموافقة",
                              style: Theme.of(context).textTheme.caption.copyWith(
                                  color: Colors.red
                              ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          //textDirection: TextDirection.rtl,
                        )),
                      ),
                    if (bookData.status == "approve")
                      Padding(
                        padding: const EdgeInsets.only(top: 21.0, left: 18.0),
                        child: Container(
                            child: Text(
                          "تمت الموافقة",
                              style: Theme.of(context).textTheme.caption.copyWith(
                                  color: defaultColor
                              ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          //textDirection: TextDirection.rtl,
                        )),
                      ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [


                          Text(
                            bookData.employeeName,
                            style: Theme.of(context).textTheme.bodyText1,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            //textDirection: TextDirection.rtl,
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              DateFormat("yyyy-MM-dd  hh:mm").format(
                                DateTime.parse(bookData.createdAt),
                              ),
                              style: Theme.of(context).textTheme.bodyText2,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              //textDirection: TextDirection.rtl,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
}
