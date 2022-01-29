import 'package:attandance_system/Screens/detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class employe_screen extends StatefulWidget {
  const employe_screen({Key? key}) : super(key: key);

  @override
  State<employe_screen> createState() => _employe_screenState();
}

// ignore: camel_case_types
class _employe_screenState extends State<employe_screen> {
  final emailcontroller = TextEditingController();
  final addresscontroller = TextEditingController();
  final phonenumercontroller = TextEditingController();
  final firstnameControler = TextEditingController();
  final lastnameControler = TextEditingController();
  final passwordcontroller = TextEditingController();
  final citycontroller = TextEditingController();


  


  DateTime dateTime = DateTime(1970);
  TextEditingController dateinput = TextEditingController(); 

  


  Future<void> addUser() async {
    var fuser = FirebaseAuth.instance.currentUser;
  
      
      
    
    
    return FirebaseFirestore.instance.collection('EmployeDetails').doc(fuser?.uid)
    .set({
      'firstname':firstnameControler.text,
          'lastname':lastnameControler.text,
          'email': emailcontroller.text, // John Doe
          'address': addresscontroller.text,
          'phonenumber': phonenumercontroller.text,
          'password':passwordcontroller.text,
          'city':citycontroller.text,
          'uid':fuser!.uid,

    }).then((value) =>Navigator.pushNamed(context, '/detail'));
        
  }

  void SelectDate() async 
  {
      DateTime ? newdate = await showDatePicker(context: context,
       initialDate: dateTime firstDate: DateTime(1900), lastDate:DateTime(2012));
       if(newdate!=null){
         setState(() {
           dateTime = newdate;
         });
       }
  }

  // LocalAuthentication auth = LocalAuthentication();

  // Future<void> _authenticateWithBiometrics() async {
  //   bool _isauthenticated = false;
  //   try {
  //     _isauthenticated = await auth.authenticate(
  //         localizedReason: 'Scan your fingerprint to give attandance',
  //         useErrorDialogs: true,
  //         stickyAuth: true,
  //         biometricOnly: true);
  //   } on PlatformException catch (e) {
  //     print(e.message);
  //   }
  //   if (_isauthenticated) {
  //     Navigator.pushNamed(context, '/');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
  width: 150,
  height: 150,
  decoration: BoxDecoration(
    color:Colors.amber,
    image: DecorationImage(
      fit: BoxFit.cover,
      image: Image.asset(
        'assets/employe.png',
      ).image,
    ),
    shape: BoxShape.circle,
  ),
)


              ],
            ),
            const SizedBox(
              height: 40,
            ),
            buildform(),
            //   const SizedBox(
            //     height: 10,
            //   ),
            //   Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       const Text(
            //         'Don\'t have an account ?',
            //         style: TextStyle(fontWeight: FontWeight.bold),
            //       ),
            //       TextButton(
            //           onPressed: () {},
            //           child: Text(
            //             'Register',
            //             style: TextStyle(
            //               fontWeight: FontWeight.bold,
            //               color: Colors.orange[800],
            //             ),
            //           )),
            //     ],
            //   ),
            //   button('give Attandance', () => _authenticateWithBiometrics())
          ],
        ),
      ),
    );
  }

  Form buildform() {
    return Form(
              child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: textfield(
                          controller: firstnameControler, hint: 'First Name',keyboardtype: TextInputType.name,),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: textfield(
                            controller: lastnameControler,
                            hint: 'Last Name',
                            keyboardtype: TextInputType.name,)),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                       Expanded(
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey[200],
                        ),

                        child: TextFormField(
                         controller:dateinput,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                              onPressed: () {SelectDate();},
                              icon: Icon(Icons.calendar_today)),
                              border: InputBorder.none,
                              contentPadding:EdgeInsets.only(left: 14, top: 17),
                                  
                              hintText:'${dateTime.day}/${dateTime.month}/${dateTime.year}',
                              hintStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.5)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: textfield(
                            controller: citycontroller,
                            hint: 'City', keyboardtype:TextInputType.text,),
                            ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                textfield(controller: emailcontroller, hint: 'Email',keyboardtype: TextInputType.emailAddress,),
                const SizedBox(
                  height: 20,
                ),
                 textfield(controller: passwordcontroller, hint: 'password',keyboardtype: TextInputType.emailAddress,),    
                const SizedBox(height: 20,),
                textfield(
                    controller: phonenumercontroller, hint: 'Phone No',keyboardtype: TextInputType.phone,),
                const SizedBox(
                  height: 20,
                ),
                textfield(controller: addresscontroller, hint: 'Address',keyboardtype:TextInputType.streetAddress,),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    button('Register', () {
                      signup();
                      addUser();
            
                    }),
                    
                  ],
                )
              ],
            ),
          ));
  }

  Widget button(String title, Function() onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 40,
        width: 140,
        decoration: BoxDecoration(
          color: Colors.orange.withOpacity(.7),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Center(
            child: Text(
          title,
          style:
              const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2),
        )),
      ),
    );
  }

  final auth = FirebaseAuth.instance;

  signup(){
    auth.createUserWithEmailAndPassword(email:emailcontroller.text, password: passwordcontroller.text).whenComplete(() =>print('done'));
  }
}

class textfield extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final TextInputType keyboardtype;
  textfield({Key? key, required this.controller, required this.hint,required this.keyboardtype})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[200],
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(left: 14, top: 10),
            hintText: hint,
            hintStyle: const TextStyle(
                fontWeight: FontWeight.bold, letterSpacing: 1.5)),
      ),
    );
  }
}

// class employe_screen extends StatefulWidget {
//   const employe_screen({Key? key}) : super(key: key);

//   @override
//   _employe_screenState createState() => _employe_screenState();
// }

// class _employe_screenState extends State<employe_screen> {
//     @override
//   void initState() {
//     // TODO: implement initState
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: ElevatedButton(
//             onPressed: () => _authenticateWithBiometrics(),
//             child: Text('Give Attadance')),
//       ),
//     );
//   }
// }



class _Dropedownitem extends StatefulWidget {
  const _Dropedownitem({ Key? key }) : super(key: key);

  @override
  __DropedownitemState createState() => __DropedownitemState();
}

class __DropedownitemState extends State<_Dropedownitem> {
  String? selectedValue = null;
  final _dropdownFormKey = GlobalKey<FormState>();

  List<DropdownMenuItem<String>> get dropdownItems{
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("USA"),value: "USA"),
    DropdownMenuItem(child: Text("Canada"),value: "Canada"),
    DropdownMenuItem(child: Text("Brazil"),value: "Brazil"),
    DropdownMenuItem(child: Text("England"),value: "England"),
  ];
  return menuItems;
}

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _dropdownFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButtonFormField(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    
                    borderRadius: BorderRadius.circular(20),
                  ),
                  border: OutlineInputBorder(
                   
                    borderRadius: BorderRadius.circular(20),
                  ),
                  
                  fillColor: Colors.white,
                ),
                validator: (value) => value == null ? "Select a country" : null,
                dropdownColor: Colors.blueAccent,
                value: selectedValue,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedValue = newValue!;
                  });
                },
                items: dropdownItems),
           
          ],
        ));
  }
}

