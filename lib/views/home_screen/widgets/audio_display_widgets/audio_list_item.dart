import 'package:flutter/material.dart';
import '../../../../models/audio_model/audio_model.dart';
import '../../../../controllers/audio_controller.dart';

class AudioListItem extends StatelessWidget{

  final AudioController audioController ;
  final VoidCallback onUpdate;
  final AudioModel audio;
  final int index;
  const AudioListItem({
    super.key,
    required this.audioController,
    required this.onUpdate,
    required this.audio,
    required this.index,
  });

  @override
  Widget build(BuildContext context){
    return ListTile(
                title: Text(audio.path.split('/').last),
                leading: IconButton(onPressed: ()async{
                   await audioController.play(audio);
                   onUpdate();

                }, icon: Icon(audio.isPlaying ? Icons.pause : Icons.play_arrow)) ,
                subtitle: Text(audio.recordingDuration),
                trailing: IconButton(onPressed:()async{
                  await audioController.removeAudio(index);
                  onUpdate();
                } , icon: Icon(Icons.delete)),
                onTap: () {
                
                  
                },


              );
  }
}
