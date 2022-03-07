import 'package:flutter/material.dart';


class SliderModel{

  String imageAssetPath;
  String title;
  String desc;

  SliderModel({this.imageAssetPath,this.title,this.desc});

  void setImageAssetPath(String getImageAssetPath){
    imageAssetPath = getImageAssetPath;
  }

  void setTitle(String getTitle){
    title = getTitle;
  }

  void setDesc(String getDesc){
    desc = getDesc;
  }

  String getImageAssetPath(){
    return imageAssetPath;
  }

  String getTitle(){
    return title;
  }

  String getDesc(){
    return desc;
  }

}


List<SliderModel> getSlides(){

  List<SliderModel> slides = new List<SliderModel>();
  SliderModel sliderModel = new SliderModel();

  //1
  sliderModel.setDesc("Create a New Card using the feature");
  sliderModel.setTitle("New Card");
  sliderModel.setImageAssetPath("assets/img.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //2
  sliderModel.setDesc("Configure the valid Details to connect your Credit Card");
  sliderModel.setTitle("Configure ");
  sliderModel.setImageAssetPath("assets/img_1.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //3
  sliderModel.setDesc("Get the created Card with details");
  sliderModel.setTitle("Ready!");
  sliderModel.setImageAssetPath("assets/img_2.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  return slides;
}
