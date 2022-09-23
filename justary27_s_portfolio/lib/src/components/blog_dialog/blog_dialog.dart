// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:justary27_s_portfolio/src/components/blog_dialog/blogDialog_constraints.dart';
import 'package:justary27_s_portfolio/src/models/blog_model.dart';

const Map _cf = ConstraintFactors;

Widget blogProvider(Size size, Blog blog, String deviceType) {
  return Container(
    width: 0.75 * size.width,
    height: 0.8 * size.height,
    decoration: BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            Color.fromRGBO(241, 245, 245, 1.0),
            // Color.fromRGBO(218, 224, 224, 1.0),
          ]),
      borderRadius: BorderRadius.circular(15),
    ),
    child: (deviceType == 'mobiles390-' ||
            deviceType == 'mobiles450-' ||
            deviceType == 'tablets768-')
        ? Column(
            children: [
              Container(
                height: 0.18 * size.height,
                width: 0.75 * size.width,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(252, 220, 102, 1.0),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 0.025 * size.height,
                    horizontal: 0.025 * size.width,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        blog.blogTitle,
                        style: TextStyle(
                          fontFamily: "Caveat",
                          color: Colors.white,
                          fontSize: _cf['blogTitle'][deviceType] * size.width,
                        ),
                      ),
                      Text(
                        blog.blogTagLine,
                        style: TextStyle(
                          fontFamily: "Ubuntu",
                          fontStyle: FontStyle.italic,
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ),
                      SizedBox(
                        height: 0.015 * size.height,
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.date_range_outlined,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                blog.blogCreatedOn,
                                style: TextStyle(
                                  fontFamily: "Ubuntu",
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.link_rounded,
                                  color: Colors.white,
                                ),
                              ),
                              TextButton(
                                onPressed: () =>
                                    window.open(blog.link, 'New Tab'),
                                child: Text(
                                  blog.link.substring(0, 10) + "...",
                                  style: TextStyle(
                                    fontFamily: "Ubuntu",
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: 0.60 * size.height,
                padding: EdgeInsets.symmetric(
                  vertical: 0.05 * size.height,
                  horizontal: 0.025 * size.width,
                ),
                child: SingleChildScrollView(
                  child: Text(
                    blog.blogDescription.trim(),
                    style: TextStyle(
                      fontFamily: "ABeeZee",
                      color: Colors.black,
                    ),
                  ),
                ),
              )
            ],
          )
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: 0.55 * size.width,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 0.05 * size.height,
                      horizontal: 0.025 * size.width,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          blog.blogTitle,
                          style: TextStyle(
                            fontFamily: "Caveat",
                            color: Color.fromRGBO(252, 220, 102, 1.0),
                            fontSize: _cf['blogTitle'][deviceType] * size.width,
                          ),
                        ),
                        Text(
                          blog.blogTagLine,
                          style: TextStyle(
                            fontFamily: "Ubuntu",
                            fontStyle: FontStyle.italic,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 0.05 * size.height,
                        ),
                        Text(
                          blog.blogDescription.trim(),
                          style: TextStyle(
                            fontFamily: "ABeeZee",
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: 0.20 * size.width,
                padding: EdgeInsets.symmetric(
                  vertical: 0.075 * size.height,
                  horizontal: 0.025 * size.width,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  color: Color.fromRGBO(252, 220, 102, 1.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "CREATED ON",
                      style: TextStyle(
                        fontFamily: "Ubuntu",
                        color: Colors.white.withOpacity(0.75),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.date_range_outlined,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          blog.blogCreatedOn,
                          style: TextStyle(
                            fontFamily: "Ubuntu",
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 0.05 * size.height,
                    ),
                    Text(
                      "ATTACHMENTS",
                      style: TextStyle(
                        fontFamily: "Ubuntu",
                        color: Colors.white.withOpacity(0.75),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.link_rounded,
                            color: Colors.white,
                          ),
                        ),
                        TextButton(
                          onPressed: () => window.open(blog.link, 'New Tab'),
                          child: Text(
                            blog.link.substring(0, 10) + "...",
                            style: TextStyle(
                              fontFamily: "Ubuntu",
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
  );
}
