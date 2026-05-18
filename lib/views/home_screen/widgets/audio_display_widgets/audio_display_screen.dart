import 'package:flutter/material.dart';
import '../../../../models/audio_model/audio_model.dart';
import '../../../../controllers/audio_controller.dart';
import './audio_list_item.dart';


class AudioDisplayScreen extends StatelessWidget{

  final AudioController audioController;
  final VoidCallback onUpdate;
  const AudioDisplayScreen({
    super.key,
    required this.audioController,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context){
    return  ListView.builder(
            itemCount: audioController.audioList.length,
            itemBuilder: (context,index){
              AudioModel audio = audioController.audioList[index];

              return AudioListItem(audioController: audioController, onUpdate: onUpdate, audio: audio, index: index);
              
            },
            

          );
  }


}
