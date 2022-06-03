import 'package:flutter/material.dart';
import 'package:flutter_blood_bank_app/bottom_sheet/rating_bottom_sheet.dart';

class AboutUs extends StatefulWidget {
  AboutUs({Key? key}) : super(key: key);

  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  List faqList = [];
  List faqContent = [];
  int? expandedTile;

  @override
  Widget build(BuildContext context) {
    fetchFaqs();
    return Container(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.09,),
            Expanded(
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) => Container(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16.5),
                    margin: EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey[50],
                    ),
                    child: Theme(
                      data: Theme.of(context)
                          .copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        tilePadding: EdgeInsets.zero,
                        onExpansionChanged: (isExpanded) {
                          setState(() {
                            if (isExpanded) {
                              expandedTile = index;
                            } else {
                              expandedTile = null;
                            }
                          });
                        },
                        title: Text(
                          faqList[index],
                        ),
                        trailing: Icon(
                          expandedTile == index
                              ? Icons.arrow_drop_up
                              : Icons.arrow_drop_down,
                        ),
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: 20),
                            child: Text(
                              faqContent[index],
                            ),
                          ),
                        ],
                      ),
                    )),
                itemCount: faqList.length,
              ),
            ),
            InkWell(
              onTap: (){
                 showModalBottomSheet(context: context, builder: (context){
                   return EndEpisodeBottomSheet();
                 });
              },
              child: Text('Rate Us',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  decoration: TextDecoration.underline
                ),
              ),
            )
          ],
        ),
    );
  }

  void fetchFaqs() {
    faqList = ['About SMDS', 'TEAM', 'Question3'];
    faqContent = ['Answer 1', 'Answer 2', 'Answer 3'];
  }
}
