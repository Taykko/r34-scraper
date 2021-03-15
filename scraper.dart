//import packages
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart';
import 'package:path/path.dart';
import 'dart:io';
//scraper function
void scrape_image() async {
  //send request
  http.Response response = await http.get(Uri.parse('https://rule34.xxx/index.php?page=post&s=random'));
  //parse html document
  Document document = parser.parse(response.body);
  //if there isnt any error it will continue
  try {
    //get image element
    var src = document.getElementById("right-col").getElementsByClassName("flexi")[0].getElementsByTagName("div")[0].getElementsByTagName("img")[0];
    //get image source attribute
    var imgUrl = src.attributes['src'];
    //send request to image source
    http.Response response2 = await http.get(Uri.parse(imgUrl));
    //create a new image file
    File img = new File('./images/${imgUrl.split('/')[imgUrl.split('/').length-1].split('?')[0]}');
    //if image doesnt exists, skip it
    if (img.existsSync()) {
      print("File already exists, skipping...");
    //if it does, download it
    } else {
      //write image source to the new image file created
      img.writeAsBytesSync(response2.bodyBytes);
      //end the function printing to the console
      return print("Downloaded file: ${basename(img.path)}; size: ${img.lengthSync() / 1000000} MBs"); 
    }
  //if there is, its going to skip the file
  } catch(e) {
    print("Skipped one file");
  }
}