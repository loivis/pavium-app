// Import the test package and Counter class
import 'package:flutter_test/flutter_test.dart';
import 'package:pavium/util/paginator.dart';

void main() {
  test('Pages should be calculated', () {
    String content =
        "A curated list of samples\n Contained in this list are sample apps, demos, and examples that can help you grow your Flutter skills. Some are maintained here by the Flutter team, but many have been created by the Flutter community and are kept in other repos in and out of GitHub. \n This is not an exhaustive list of samples, and just because a project isn't listed here doesn't mean that it's not worth exploring. Similarly, while the Flutter team works to keep this list up to date, there are plenty of others created by the community, such as Awesome Flutter from @Solido. \n Please don't submit pull requests directly updating this file. While we're always happy to learn of new samples from the community, we need to keep this file small. There are plenty of user-maintained indices (like Awesome Flutter) that are meant to be exhaustive, and those are great places for submitting your own work.";
    var pages = Paginator.getPages(content, 800.0, 400.0, 30);

    expect(pages.length, 4);
  });
}
