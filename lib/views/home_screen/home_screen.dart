import 'package:flutter/material.dart';
import 'package:voice_note_ai/controllers/ai_speech_text_controller.dart';
import 'package:voice_note_ai/views/home_screen/widgets/audio_display_widgets/audio_display_screen.dart';
import 'package:voice_note_ai/views/home_screen/widgets/summaries_audio_screen.dart';
import '../../controllers/audio_controller.dart';




class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen>{

  final AudioController _audioController = AudioController();
  final AiSpeechTextController _aiSpeechTextController = AiSpeechTextController();


  int selectedIndexBN = 0;

   bool _isLoading = true;  

  @override
  void initState() {
    super.initState();
    _initializeControllers();  
  }

  //  Properly wait for async initialization
  Future<void> _initializeControllers() async {
    try {
      // Wait for both controllers to initialize
      await Future.wait([
        _audioController.init(),
        _aiSpeechTextController.init(),
      ]);

      // Then load data
      await Future.wait([
        _audioController.loadAudios(),
        _aiSpeechTextController. loadAudiosSpeechText(),
      ]);

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      debugPrint("Error initializing:  $e");
      setState(() {
        _isLoading = false;
      });
    }
  }


  @override
  void dispose() {
    _audioController.dispose();
    _aiSpeechTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){

    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    List<Widget> screens =[
      AudioDisplayScreen(audioController: _audioController, onUpdate: ()=>
      setState(() {}),
      ),
      SummariesAudioScreen(aiSpeechTextController: _aiSpeechTextController,onUpdate: ()=>
      setState(() {}),),
    ];
    
    IconData fabIcon = Icons.mic;
    IconData fabIcon2 = Icons.mic;

    if (_audioController.isRecording && !_audioController.isPaused && selectedIndexBN==0) {
      fabIcon = Icons.pause;
    } else if (_audioController.isPaused && selectedIndexBN==0 ) {
      fabIcon = Icons.play_arrow;
    }


    if(_aiSpeechTextController.isResumed && !_aiSpeechTextController.isPaused && selectedIndexBN==1 ){
      fabIcon2 = Icons.pause;
      
    }else if(_aiSpeechTextController.isPaused && selectedIndexBN==1){
      fabIcon2 = Icons.play_arrow;

    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Voice Note AI"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
      ),

      body: Padding(
        padding: EdgeInsets.all(16),
        child: screens[selectedIndexBN],
        
        ), 
      

      floatingActionButton: selectedIndexBN==0 ? GestureDetector(
        onLongPress: () async{
          await _audioController.handleFabLongPress();
          setState(() {
            
          });
          },//_onFabLongPress,//_onFabLongPress,
        child: FloatingActionButton(
          onPressed: () async{
            await _audioController.handleFabPressed();
            setState(() {
              
            });
            },//_onFabPressed,//_onFabPressed,
          child: Icon(fabIcon),

        ),

      ):
      
     GestureDetector(
        onLongPress: () async{
          await _aiSpeechTextController.handleFabLongPress();
          setState(() {
            
          });
          },//_onFabLongPress,//_onFabLongPress,
        child: FloatingActionButton(
          onPressed: () async{
            await _aiSpeechTextController.handleFabPressed();
            setState(() {
              
            });
            },//_onFabPressed,//_onFabPressed,
          child: Icon(fabIcon2),

        ),

      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndexBN,
        onTap: (index)async{
          // Stop active recording/listening before switching
          if (selectedIndexBN == 0 && _audioController.isRecording) {
            await _audioController.stopRecording();
          } else if (selectedIndexBN == 1 && _aiSpeechTextController.isResumed) {
            await _aiSpeechTextController.handleFabLongPress();
          }
          setState(() {
             selectedIndexBN = index;
          });
         

        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.audiotrack ),
            label: "Audio",


            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.summarize),
              label: "Summaries",
            ),

        ],
      ),


    );
  }

  

 
}