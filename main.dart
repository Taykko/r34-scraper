//imports the scraper
import 'scraper.dart' as scraper;
//main function
void main() async {
  //starts to loop
  while (true) {
    //scrape image and download it
    await scraper.scrape_image();
  }
}