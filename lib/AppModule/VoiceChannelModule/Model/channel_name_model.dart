
import 'dart:convert';

List<ChannelNameModel> ChannelNameModelFromJson(String str) => List<ChannelNameModel>.from(json.decode(str).map((x) => ChannelNameModel.fromJson(x)));

String ChannelNameModelToJson(List<ChannelNameModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChannelNameModel {
    String? channelName;
    String? token;
  

    ChannelNameModel({
        this.channelName,
         this.token,
    });

    factory ChannelNameModel.fromJson(Map<String, dynamic> json) => ChannelNameModel(
        channelName: json["channelName"],
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "channelName": channelName,
        "token": token,
    };
}
