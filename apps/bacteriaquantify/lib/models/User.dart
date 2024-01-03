import 'package:http/http.dart' as http;
import 'dart:convert';

class User{
	
	String fullName;	 
	final String username;
	final String token;
	bool isEmpty = true;
	
	User({
		required this.fullName,
		required this.username,
		required this.token		
	});
	String getfullName(){
		return fullName;
	}
  void setfullName(String fname){
		this.fullName = fname;
	}
 
	factory User.fromJson(Map<String, dynamic> json) {
		return User(
		  fullName: json['fullName'],		  
		  username: json['username'],		  
		  token: json['token'],      
		);
	}
	
	Map<String, dynamic> toJson() =>
    {
      'fullName': fullName,      
      'username': username,            
      'token': token,      
    };
}
