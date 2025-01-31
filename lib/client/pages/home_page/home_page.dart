import 'package:archive/archive.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mined_2025/client/apis/init/config.dart';
import 'package:mined_2025/client/helper_functions/toasts.dart';
import 'package:mined_2025/client/pages/home_page/pod_cast_part.dart';
import 'package:mined_2025/client/providers/bucket_provider.dart';
import 'package:mined_2025/client/providers/user_provider.dart';
import 'package:mined_2025/client/utils/buttons/custom_button.dart';
import 'package:mined_2025/client/utils/theme/theme.dart';
import 'package:mined_2025/client/utils/widgets/custom_containers/history_card.dart';
import 'package:mined_2025/client/utils/widgets/logo.dart';
import 'package:mined_2025/client/utils/widgets/navbar/custom_button.dart';
import 'package:mined_2025/main.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  static const route = "/home";
  static const fullRoute = "/home";
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool _isSidebarExpanded = true;
  String currentChatData = '';
  List<String> chatHistory = [];

  void init(WebUserProvider webUserProvider) async {
    await webUserProvider.initUser();
  }

  bool isFirst = true;
  String _summary = '';
  bool _sending = false;
  String? fileName;
  Uint8List? fileBytes;
  FilePickerResult? pdf;

  List<String> extractedFiles = [];


  Future<void> pickAndUnzipFile() async {
    // Pick the zip file
    final result = await FilePicker.platform.pickFiles(
      allowedExtensions: ['zip'],
      type: FileType.custom,
    );

    if (result == null) return;

    final bytes = result.files.single.bytes;

    final archive = ZipDecoder().decodeBytes(bytes!);

    List<String> extractedFiles = [];

    for (final file in archive) {
      if (file.isFile) {
        extractedFiles.add(file.name);
      }
    }

    extractedFiles.sort((a, b) {
      final aNum = int.tryParse(RegExp(r'\d+').firstMatch(a)?.group(0) ?? '0');
      final bNum = int.tryParse(RegExp(r'\d+').firstMatch(b)?.group(0) ?? '0');
      return aNum!.compareTo(bNum!);
    });

    setState(() {
      extractedFiles = extractedFiles;

    });

    if (extractedFiles.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No audio files found in the zip.')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${extractedFiles.length} audio file(s) extracted')),
      );
    }
  }

  Future<void> takePdf() async {
    pdf = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (pdf != null) {

      WebToasts.showToastification(
          "Success",
          "Pdf Successfully Uploaded",
          Icon(
            Icons.error_outline_rounded,
            color: Colors.red,
          ),
          context);

      setState(() {
        fileName = pdf?.files.single.name;
        fileBytes = pdf?.files.single.bytes;
      });
    }
  }

  Future<void> sendPDF() async {

    if (pdf != null) {
      Uint8List? fileBytes = pdf?.files.single.bytes;

      if (fileBytes != null) {
        final Uri apiUrl = Uri.parse('http://10.3.109.45:5000/convert-pdf');

        var request = http.MultipartRequest('POST', apiUrl)
          ..files.add(http.MultipartFile.fromBytes(
            'file',
            fileBytes,
            filename: pdf?.files.single.name,
          ));

        try {

          var response = await request.send();

          if (response.statusCode == 200) {
            final responseBody = await response.stream.bytesToString();
            setState(() {
              _summary = responseBody;
            });
          } else {
            setState(() {
              print("#status code ${response.statusCode}");
            });
          }
        } catch (e) {
          setState(() {
            print("#pdf upload error ${e}");
            WebToasts.showToastification(
                "Error",
                "Request Failed",
                Icon(
                  Icons.error_outline_rounded,
                  color: Colors.red,
                ),
                context);
          });
        }
      } else {
        setState(() {
          // _summary = 'Error: No file bytes received';
          WebToasts.showToastification(
              "Upload PDF Error",
              "No file bytes received",
              Icon(
                Icons.error_outline_rounded,
                color: Colors.red,
              ),
              context);
        });
      }
    } else {
      setState(() {
        WebToasts.showToastification(
            "Upload PDF Error",
            "No file selected",
            Icon(
              Icons.error_outline_rounded,
              color: Colors.red,
            ),
            context);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Consumer2<BucketsProvider, WebUserProvider>(
        builder: (context, bucketProvider, webUserProvider, child) {
      if (isFirst) {
        init(webUserProvider);
        isFirst = false;
      }
      return Scaffold(
        backgroundColor: Colors.white,
        body: Row(
          children: [

            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              width: _isSidebarExpanded ? mq.width * 0.15 : mq.width * 0.05,
              decoration: BoxDecoration(
                  border: Border.all(
                color: Colors.grey.shade300,
              )),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  _isSidebarExpanded
                      ? Center(
                          child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Logo(),
                              MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      chatHistory
                                          .add('Hello, how can I help you?');
                                      currentChatData =
                                          'Hello, how can I help you?';
                                    });
                                  },
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: AppColors.theme['deepPurpleColor'],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ))
                      : Container(),
                  const Divider(),
                  if (chatHistory.isEmpty)
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: mq.height * 0.35),
                      child: Text(
                        "No Chats",
                        style: GoogleFonts.poppins(
                            color: AppColors.theme['secondaryColor']),
                      ),
                    ),
                  Expanded(
                      child: ListView.builder(
                    // reverse: true,
                    itemCount: chatHistory.length,
                    itemBuilder: (context, index) {
                      return HistoryCard(
                        data: chatHistory[index],
                        onTap: () {
                          setState(() {
                            currentChatData = chatHistory[index];
                          });
                        },
                        onRemove: () {
                          setState(() {
                            chatHistory.removeAt(index);
                          });
                        },
                      );
                    },
                  )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: mq.width * 0.15,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 5,
                            spreadRadius: 0.4,
                            offset: Offset(0, 2),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.person,
                              color: AppColors.theme['secondaryColor'],
                            ),
                            SizedBox(width: 5),
                            Text(
                              webUserProvider.user?.name ?? "Name",
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Chat Box and Voice Section
            Expanded(
              child: Container(
                child: Column(
                  children: [
                    Container(
                      width: mq.width*1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                        border: Border.all(color: Colors.grey.shade300)
                      ),
                      height:  mq.height * 0.1,
                      child: Center(
                        child: Text(
                          "Title : ",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      )  ,
                    ),
                    Expanded(
                      child: Container(
                        child: Center(
                          child: currentChatData.isEmpty ? Text(
                              "Select a chat to view or create chat",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ) :   PodCastPart(extractedFiles: extractedFiles,),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 100.0, vertical: 20),
                      child: Container(
                        width: mq.width * 0.6,
                        decoration: BoxDecoration(),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 5,
                                spreadRadius: 0.4,
                                offset: Offset(0, 2),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Choose PDF and Know about paper with Paper2X",
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          color: AppColors
                                              .theme['secondaryColor']),
                                    ),
                                    SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        MouseRegion(
                                          cursor: SystemMouseCursors.click,
                                          child: GestureDetector(
                                            onTap: () async {
                                              // await takePdf();
                                              await pickAndUnzipFile();
                                            },
                                            child: Container(
                                              // width: 120 ,
                                              height: 35,
                                              child: Center(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "Choose PDF",
                                                    style: GoogleFonts.poppins(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: AppColors
                                                    .theme['deepPurpleColor'],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        if (pdf != null)
                                          Text(
                                            fileName ?? "",
                                            style: GoogleFonts.poppins(
                                                color: AppColors
                                                    .theme['secondaryColor']),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                                MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: InkWell(
                                    onTap: () async {
                                      if (pdf == null) {
                                        WebToasts.showToastification(
                                            "Request",
                                            "Please wait for upload PDF or Upload PDF",
                                            Icon(
                                              Icons.handshake,
                                              color: Colors.green,
                                            ),
                                            context);
                                      } else {
                                        setState(() {
                                          _sending = true;
                                        });

                                        await sendPDF();

                                        setState(() {
                                          _sending = false;
                                        });
                                      }
                                    },
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: _sending
                                            ? Center(
                                                child: Container(
                                                height: 20,
                                                width: 20,
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Colors.white,
                                                ),
                                              ))
                                            : Icon(
                                                Icons.send_outlined,
                                                color: Colors.white,
                                              ),
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color:
                                            AppColors.theme['deepPurpleColor'],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

            Container(
              width: mq.width * 0.25,
              child: Column(
                children: [
                  Container(
                    width: mq.width*1,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300)
                    ),
                    height:  mq.height * 0.1,
                    child: Center(
                      child: Text(
                        "Summary",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    )  ,
                  ),
                  Expanded(
                    child: Container(
                      height: mq.height * 0.3,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Center(child: Text("VIDEO HERE")),
                    ),
                  ),
                  Container(
                    height: mq.height * 0.3,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(10)),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Container(
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 5,
                                  spreadRadius: 0.4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            borderRadius:BorderRadius.circular(10),
                          ),
                          child: Row(

                            children: [

                              Image.asset("assets/images/ppt_image.png",height: 50,width: 50,),


                            ],

                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
