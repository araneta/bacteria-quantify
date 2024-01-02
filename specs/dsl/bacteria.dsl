module bacteria{
	root User{
		string email {unique;}
		string password;
		timestamp? forgottenPasswordTime;
		string? forgottenPasswordCode;
		timestamp? lastAccess;
		string fullName;
timestamp? createdAt;
timestamp? updatedAt;
timestamp? deletedAt;
	}
	root History{
		User *User;
		string localFileImage;
		string sampleName {unique;}
timestamp? createdAt;
timestamp? updatedAt;
timestamp? deletedAt;
	}
	root HistoryDetail{
		History *History;
		string species;
		int totalColony;
timestamp? createdAt;
timestamp? updatedAt;
timestamp? deletedAt;
	}
}
