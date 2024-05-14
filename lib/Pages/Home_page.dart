import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:voiceassistant/Pages/feature_box.dart';
import 'package:voiceassistant/Services/login_or_register.dart';
import 'package:voiceassistant/components/pallete.dart';
import 'package:voiceassistant/openai_service.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Pallete.blackColor,
        title: Text(
          'About Us',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to the Voice Assistant App!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Our app is designed to assist you in various tasks using the latest AI technologies. With ChatGPT, you can converse with your virtual assistant to get organized and stay informed. DALL-E integration allows you to get creative by generating images based on your ideas.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Pallete.blackColor,
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('User Profile'),
            onTap: () {
              // Navigate to user profile page
            },
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip),
            title: const Text('Privacy'),
            onTap: () {
              // Navigate to privacy page
            },
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('History'),
            onTap: () {
              // Navigate to history page
            },
          ),
          ListTile(
            leading: const Icon(Icons.star),
            title: const Text('Premium Membership'),
            onTap: () {
              // Navigate to premium membership page
            },
          ),
          ListTile(
            leading: const Icon(Icons.share),
            title: const Text('Share'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginOrRegister()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final speechToText = SpeechToText();
  final flutterTts = FlutterTts();
  String lastWords = '';
  int start = 200;
  int delay = 200;
  final OpenAIService openAIService = OpenAIService();
  String? generatedContent;
  String? generatedUrl;

  @override
  void initState() {
    super.initState();
    initSpeechToText();
    initTextToSpeech();
  }

  Future<void> initTextToSpeech() async {
    await flutterTts.setSharedInstance(true);
    setState(() {});
  }

  Future<void> initSpeechToText() async {
    speechToText.initialize();
    setState(() {});
  }

  Future<void> startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
    setState(() {});
  }

  Future<void> stopListening() async {
    await speechToText.stop();
    setState(() {});
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
    });
  }

  Future<void> systemSpeak(String content) async {
    await flutterTts.speak(content);
  }

  @override
  void dispose() {
    super.dispose();
    speechToText.stop();
    flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BounceInDown(child: const Text("Minion")),
        centerTitle: true,
        backgroundColor: Pallete.blackColor,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          const SizedBox(height: 16), // Adding a gap below the app bar
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ZoomIn(
                    child: Stack(
                      children: [
                        Center(
                          child: Container(
                            height: 120,
                            width: 120,
                            margin: const EdgeInsets.only(top: 4),
                            decoration: const BoxDecoration(
                                color: Pallete.assistantCircleColor,
                                shape: BoxShape.circle),
                          ),
                        ),
                        Container(
                          height: 130,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/voice.jpg'))),
                        )
                      ],
                    ),
                  ),
                  // Chat Bubble part
                  FadeInRight(
                    child: Visibility(
                      visible: generatedUrl == null,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        margin:
                            const EdgeInsets.symmetric(horizontal: 40).copyWith(
                          top: 30,
                        ),
                        decoration: BoxDecoration(
                            // color: Colors.black,
                            border: Border.all(
                              color: Pallete.blackColor,
                            ),
                            borderRadius: BorderRadius.circular(20).copyWith(
                                topLeft: Radius.zero,
                                bottomRight: Radius.zero)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            generatedContent == null
                                ? 'Heyy Hii, I am Minion! your virtual assistant...'
                                : lastWords,
                            style: TextStyle(
                                color: Pallete.mainFontColor,
                                fontSize: generatedContent == null ? 20 : 18,
                                fontFamily: 'Cera Pro'),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 0,
                  ),
                  Visibility(
                    visible: generatedUrl == null,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      margin:
                          const EdgeInsets.symmetric(horizontal: 40).copyWith(
                        top: 30,
                      ),
                      decoration: BoxDecoration(
                          // color: Colors.black,
                          border: Border.all(
                            color: Pallete.blackColor,
                          ),
                          borderRadius: BorderRadius.circular(20).copyWith(
                              topLeft: Radius.zero, bottomRight: Radius.zero)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          generatedContent == null
                              ? 'You can ask me anything'
                              : generatedContent!,
                          style: TextStyle(
                              color: Pallete.mainFontColor,
                              fontSize: generatedContent == null ? 20 : 18,
                              fontFamily: 'Cera Pro'),
                        ),
                      ),
                    ),
                  ),
                  SlideInLeft(
                    child: Visibility(
                      visible: generatedContent == null && generatedUrl == null,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(top: 20, left: 22),
                        child: const Text(
                          "These are the features of the Minion",
                          style: TextStyle(
                            fontFamily: 'Cera Pro',
                            color: Pallete.mainFontColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // features list
                  if (generatedUrl != null)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: (Container(child: Text(lastWords))),
                    ),
                  if (generatedUrl != null)
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(generatedUrl!)),
                    ),
                  Visibility(
                    visible: generatedContent == null && generatedUrl == null,
                    child: Column(
                      children: [
                        SlideInRight(
                          delay: Duration(milliseconds: start),
                          child: const FeatureBox(
                            color: Pallete.blackColor,
                            headerText: "ChatGPT",
                            descriptionText:
                                "A smarter way to stay organised and informed with chatGPT",
                          ),
                        ),
                        SlideInRight(
                          delay: Duration(milliseconds: start + delay),
                          child: const FeatureBox(
                              color: Pallete.blackColor,
                              headerText: "Dall-E",
                              descriptionText:
                                  "Get inspired and stay creative with your personal assistant powered by Dall-E"),
                        ),
                        SlideInUp(
                          delay: Duration(milliseconds: start),
                          child: FeatureBox(
                              color: Pallete.blackColor,
                              headerText: "Smarter Voice Assistant",
                              descriptionText:
                                  "Get the best of both worlds with a voice assistant powered by Dall-E and ChatGPT"),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Pallete.blackColor,
        backgroundColor: Colors.white,
        onPressed: () async {
          if (await speechToText.hasPermission && speechToText.isNotListening) {
            await startListening();
          } else if (speechToText.isListening) {
            final speech = await openAIService.isArtPrompAPI(lastWords);
            if (speech.contains('https')) {
              generatedContent = null;
              generatedUrl = speech;
              setState(() {});
            } else {
              generatedContent = speech;
              generatedUrl = null;
              setState(() {});
              await systemSpeak(speech);
            }

            await stopListening();
            print(speech);
            print(lastWords);
          } else {
            initSpeechToText();
          }
        },
        child: Icon(speechToText.isListening ? Icons.stop : Icons.mic),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const UserAccountsDrawerHeader(
              accountName: Text('Minion'),
              accountEmail: null,
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                child: FlutterLogo(size: 42.0),
              ),
              decoration: BoxDecoration(
                color: Pallete.blackColor,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.contacts),
              title: const Text('Contact Us'),
              onTap: () {
                // Add logic to handle contact us
              },
            ),
            ListTile(
              leading: const Icon(Icons.color_lens),
              title: const Text('Theme'),
              onTap: () {
                // Add logic to handle theme
              },
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Help'),
              onTap: () {
                // Add logic to handle help
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text("About us"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutUsPage()),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
