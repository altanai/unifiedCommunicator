package userprofile.beanclass;

public class registration {
private String displayName;
private String publicIdentity;
private String privateIdentity;
private String password;
private String WSUri;
private String realm;
private String SecretQuestion;
private String SecretAnswer;
public String getDisplayName() {
	return displayName;
}
public void setDisplayName(String displayName) {
	this.displayName = displayName;
}
public String getPublicIdentity() {
	return publicIdentity;
}
public void setPublicIdentity(String publicIdentity) {
	this.publicIdentity = publicIdentity;
}
public String getPrivateIdentity() {
	return privateIdentity;
}
public void setPrivateIdentity(String privateIdentity) {
	this.privateIdentity = privateIdentity;
}
public String getPassword() {
	return password;
}
public void setPassword(String password) {
	this.password = password;
}
public String getWSUri() {
	return WSUri;
}
public void setWSUri(String wSUri) {
	WSUri = wSUri;
}
public String getRealm() {
	return realm;
}
public void setRealm(String realm) {
	this.realm = realm;
}
public String getSecretQuestion() {
	return SecretQuestion;
}
public void setSecretQuestion(String secretQuestion) {
	SecretQuestion = secretQuestion;
}
public String getSecretAnswer() {
	return SecretAnswer;
}
public void setSecretAnswer(String secretAnswer) {
	SecretAnswer = secretAnswer;
}
}
