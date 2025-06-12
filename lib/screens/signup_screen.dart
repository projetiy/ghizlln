import 'package:flutter/material.dart';
import 'package:studium/constants/sizes.dart';
import 'package:studium/constants/textes.dart';
import 'package:studium/constants/images.dart';
import 'package:studium/constants/colors.dart';
import 'package:iconsax/iconsax.dart';
import 'package:studium/screens/signup_student_screen.dart';
import 'package:studium/screens/signup_teacher_screen.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';


class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  String? selectedRole;

  final List<String> wilayas = [
    'Adrar',
    'Chlef',
    'Laghouat',
    'Oum El Bouaghi',
    'Batna',
    'Béjaïa',
    'Biskra',
    'Béchar',
    'Blida',
    'Bouira',
    'Tamanrasset',
    'Tébessa',
    'Tlemcen',
    'Tiaret',
    'Tizi Ouzou',
    'Alger',
    'Djelfa',
    'Jijel',
    'Sétif',
    'Saïda',
    'Skikda',
    'Sidi Bel Abbès',
    'Annaba',
    'Guelma',
    'Constantine',
    'Médéa',
    'Mostaganem',
    'M’Sila',
    'Mascara',
    'Ouargla',
    'Oran',
    'El Bayadh',
    'Illizi',
    'Bordj Bou Arréridj',
    'Boumerdès',
    'El Tarf',
    'Tindouf',
    'Tissemsilt',
    'El Oued',
    'Khenchela',
    'Souk Ahras',
    'Tipaza',
    'Mila',
    'Aïn Defla',
    'Naâma',
    'Aïn Témouchent',
    'Ghardaïa',
    'Relizane',
    'Timimoun',
    'Bordj Badji Mokhtar',
    'Ouled Djellal',
    'Béni Abbès',
    'In Salah',
    'In Guezzam',
    'Touggourt',
    'Djanet',
    'El M’Ghair',
    'El Meniaa',
  ];
  String? selectedWilaya;



  File? _profileImage;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Title
              Text(
                TTexts.create_Account,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              Center(
                child: GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: TColors.primary,
                    backgroundImage: _profileImage != null ? FileImage(_profileImage!) : null,
                    child: _profileImage == null
                        ? const Icon(Iconsax.camera, color: Colors.white, size: 30)
                        : null,
                  ),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Form
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    /// Firstname and Lastname
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: "firstname",
                              prefixIcon: Icon(Iconsax.user),
                            ),
                          ),
                        ),
                        const SizedBox(width: TSizes.spaceBtwInputFields),
                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: "lastname",
                              prefixIcon: Icon(Iconsax.user),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),

                    /// Username
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Username",
                        prefixIcon: Icon(Iconsax.user_edit),
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),

                    /// Email
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: "E-mail",
                        prefixIcon: Icon(Iconsax.direct),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer un email';
                        }
                        if (!value.contains('@')) {
                          return 'Email invalide';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),

                    /// Password
                    TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: "Password",
                        prefixIcon: Icon(Iconsax.password_check),
                        suffixIcon: Icon(Iconsax.eye_slash),
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),

                    /// Phone Number
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: "PhoneNumber",
                        prefixIcon: Icon(Iconsax.microphone),
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),

                    DropdownButtonFormField<String>(
                      value: selectedWilaya,
                      hint: const Text("Wilaya de résidence"),
                      items: wilayas.map((wilaya) {
                        return DropdownMenuItem<String>(
                          value: wilaya,
                          child: Text(wilaya),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedWilaya = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Veuillez choisir votre wilaya';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),


                    /// Role selector
                    DropdownButtonFormField<String>(
                      value: selectedRole,
                      hint: const Text("Vous êtes ?"),
                      items: const [
                        DropdownMenuItem(value: 'student', child: Text('Étudiant')),
                        DropdownMenuItem(value: 'teacher', child: Text('Enseignant')),
                      ],
                      onChanged: (value) {
                        setState(() {
                          selectedRole = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Veuillez choisir un rôle';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: TSizes.spaceBtwSections),

                    /// Create Account Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (selectedRole == 'student') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const SignupStudentScreen()),
                              );
                            } else if (selectedRole == 'teacher') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const SignupTeacherScreen()),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Veuillez choisir un rôle")),
                              );
                            }
                          }
                        },
                        child: const Text("Create Account"),
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwSections),

                    /// Social Footer
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(width: TSizes.spaceBtwItems),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: TColors.grey),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: IconButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                if (selectedRole == 'student') {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const SignupStudentScreen()),
                                  );
                                } else if (selectedRole == 'teacher') {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const SignupTeacherScreen()),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("Veuillez choisir un rôle")),
                                  );
                                }
                              }
                            },
                            icon: const Image(
                              width: TSizes.iconMd,
                              image: AssetImage(TImages.google),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
