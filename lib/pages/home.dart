import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news/services/news.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> categories = [
    "all",
    "science",
    "technology",
    "business",
    "sports",
    "politics",
    "world",
    "startup",
    "entertainment",
    "miscellaneous",
    "hatke",
    "automobile",
  ];

  List news = [];

  bool loading = true;

  void getNewsData(String category) async {
    setState(() {
      loading = true;
    });
    List data = await getNews(category);
    setState(() {
      news = data;
      if(news.isNotEmpty){
        loading = false;
      }
    });
  }

  int initial = 0;

  void launchReamMore(String url) async {
    launchUrl(Uri.parse(url));
  }

  @override
  void initState() {
    getNewsData(categories[0]);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        backgroundColor: Colors.teal,
        centerTitle: true,
        shadowColor: Colors.blueGrey,
        iconTheme: const IconThemeData(
          color: Colors.white,
          size: 23,
        ),
        title: Text(
          "Inshort News",
          style: GoogleFonts.antic(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        leading: const Icon(
          Icons.menu,
        ),
      ),
      body: !loading ? SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton(
                value: initial,
                items: [
                  ...List.generate(
                    categories.length, 
                    (index) => DropdownMenuItem(
                      value: index,
                      onTap: (){
                        getNewsData(categories[index]);
                      },
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: categories[index][0].toUpperCase(),
                              style: TextStyle(
                                color: Colors.grey[900],
                              ),
                            ),
                            TextSpan(
                              text: categories[index].substring(1, categories[index].length),
                              style: TextStyle(
                                color: Colors.grey[900],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ], 
                onChanged: (val){
                  setState(() {
                    initial = val!;
                  });
                }
              ),
            ),
            ...List.generate(
              news.length, 
              (index) => Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 2,
                ),
                child: Container(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.75,
                    minHeight: MediaQuery.of(context).size.width * 0.55,
                    minWidth: MediaQuery.of(context).size.width,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.shade700
                    )
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.grey[100],
                              child: const Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  news[index]["author"],
                                  style: GoogleFonts.antic(
                                    fontSize: 14,
                                    color: Colors.grey[900],
                                    letterSpacing: 1.1,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  news[index]["time"],
                                  style: GoogleFonts.antic(
                                    fontSize: 12,
                                    color: Colors.grey,
                                    letterSpacing: 1.1,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          news[index]["title"],
                          style: GoogleFonts.antic(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[900],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Image(
                          image: NetworkImage(news[index]["imageUrl"]),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          news[index]["content"],
                          style: GoogleFonts.antic(
                            color: Colors.grey[900],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: (){
                            launchReamMore(news[index]["readMoreUrl"]);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "Read more",
                                style: GoogleFonts.antic(
                                  color: Colors.blue,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(width: 6),
                              const Icon(
                                Icons.read_more,
                                color: Colors.blue,
                                size: 18,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ) : const Center(
        child: CircularProgressIndicator(
          color: Colors.teal,
        ),
      ),
    );
  }
}