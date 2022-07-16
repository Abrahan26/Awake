import 'package:flutter/material.dart';

class notita extends StatelessWidget {
  const notita({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
                              children: [
                                Container(
                                  height: 150,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(15),
                                          topLeft: Radius.circular(15)),
                                      border: Border.all(
                                          color: Colors.grey.withOpacity(0.5))),
                                  child: TextField(
                                    maxLines: 6,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Agrega una descripcion aqui",
                                    ),
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.2),
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(15),
                                          bottomLeft: Radius.circular(15)),
                                      border: Border.all(
                                          color: Colors.grey.withOpacity(0.5))),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.attach_file,
                                            color: Colors.grey,
                                          ),
                                          onPressed: () {},
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            );
  }
}