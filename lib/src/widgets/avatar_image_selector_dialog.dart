import 'package:flutter/material.dart';
import 'package:tecnonautas_app/core/bloc/edit_profile/edit_profile_bloc.dart';
import 'package:tecnonautas_app/core/bloc/register/register_bloc.dart';
import 'package:tecnonautas_app/src/resources/app_colors.dart';

class AvatarImageSelectorDialog extends StatelessWidget {
  
  EditProfileBloc mEditProfileBloc;

  AvatarImageSelectorDialog();

  AvatarImageSelectorDialog.edit({
    @required this.mEditProfileBloc
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Scaffold(
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(width: double.infinity,),

                Container(
                  padding: EdgeInsets.all(24),
                  child: Text('Selecciona tu avatar', style: Theme.of(context).textTheme.headline6),
                ),

                Container(
                  width: double.infinity,
                  child: Wrap(
                    runSpacing: 18,
                    alignment: WrapAlignment.spaceEvenly,
                    children: List.generate(52, (index) {

                        if (mEditProfileBloc != null) {
                          return AvatarItem.edit(
                            mNombreImagen: "${index + 1}",
                            mEditProfileBloc: this.mEditProfileBloc,
                          );
                        }

                        return AvatarItem(
                          mNombreImagen: "${index + 1}",
                        );

                      } 
                    ),
                  )
                )

              ],
            ),
          ),
        ),

        floatingActionButton: FloatingActionButton(
          backgroundColor: primary,
          child: Text("OK", style: TextStyle(fontWeight: FontWeight.bold)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }
}

class AvatarItem extends StatelessWidget {
  
  final String mNombreImagen;
  EditProfileBloc mEditProfileBloc;

  AvatarItem({
    @required this.mNombreImagen,
  });

  AvatarItem.edit({
    @required this.mNombreImagen,
    @required this.mEditProfileBloc
  });
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: StreamBuilder(
        initialData: "",
        stream: mEditProfileBloc != null ? mEditProfileBloc.avatarStream : registerBloc.avatarStream,
        builder: (context, snapshot) {
          String selectedAvatar = snapshot.data;
          
          return Opacity(
            opacity: selectedAvatar == "$mNombreImagen" ? 1.0 : 0.8,
            child: AnimatedContainer(
              foregroundDecoration: selectedAvatar == "$mNombreImagen"
                                    ? null
                                    : BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey,
                                      backgroundBlendMode: BlendMode.saturation
                                    ),
              duration: Duration(milliseconds: 600),
              curve: Curves.easeInOut,
              height: selectedAvatar == "$mNombreImagen" ? 90 : 80,
              width: selectedAvatar == "$mNombreImagen" ? 90 : 80,
              decoration: BoxDecoration(
                border: selectedAvatar == "$mNombreImagen"
                        ? Border.all(color: accent, width: 7.5)
                        : null,
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/images/avatars/$mNombreImagen.png')
                )
              ),
            ),
          );

        }
      ),

      onTap: () {
        print(mNombreImagen);

        if (mEditProfileBloc != null) {
          mEditProfileBloc.changeAvatar(mNombreImagen);
        } else {
          registerBloc.changeAvatar(mNombreImagen);
        }
      },
    );
  }
}