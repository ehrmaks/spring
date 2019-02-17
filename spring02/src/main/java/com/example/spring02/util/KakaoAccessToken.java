package com.example.spring02.util;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicNameValuePair;

import com.example.spring02.model.member.dto.MemberDTO;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

public class KakaoAccessToken {
	public JsonNode getAccessToken(String autorize_code) {

		final String RequestUrl = "https://kauth.kakao.com/oauth/token";

		final List<NameValuePair> postParams = new ArrayList<NameValuePair>();

		// 포스트 파라미터의 grant_type이라는 명칭에 authorization_code를 추가한다 아래도 동일
		postParams.add(new BasicNameValuePair("grant_type", "authorization_code"));

		postParams.add(new BasicNameValuePair("client_id", "4df0a212b67066319be28e560b93c078"));

		postParams.add(new BasicNameValuePair("redirect_uri", "https://test.kjsfk.com/kakaologin")); // 예 :
																								// http://아이피:포트/최상위폴더/리다이렉션경로

		postParams.add(new BasicNameValuePair("code", autorize_code));
		// 기타 설명은 생략 자세히 알고 싶으면 구글링하세요.
		final HttpClient client = HttpClientBuilder.create().build();

		final HttpPost post = new HttpPost(RequestUrl);

		JsonNode returnNode = null;

		try {

			post.setEntity(new UrlEncodedFormEntity(postParams));

			final HttpResponse response = client.execute(post);

			ObjectMapper mapper = new ObjectMapper();

			returnNode = mapper.readTree(response.getEntity().getContent());

		} catch (UnsupportedEncodingException e) {

			e.printStackTrace();

		} catch (ClientProtocolException e) {

			e.printStackTrace();

		} catch (IOException e) {

			e.printStackTrace();

		} finally {

		}
		return returnNode;
	}

	public JsonNode Logout(String autorize_code) {
		final String RequestUrl = "https://kapi.kakao.com/v1/user/logout";

		final HttpClient client = HttpClientBuilder.create().build();

		final HttpPost post = new HttpPost(RequestUrl);

		post.addHeader("Authorization", "Bearer " + autorize_code);

		JsonNode returnNode = null;

		try {

			final HttpResponse response = client.execute(post);

			ObjectMapper mapper = new ObjectMapper();

			returnNode = mapper.readTree(response.getEntity().getContent());

		} catch (UnsupportedEncodingException e) {

			e.printStackTrace();

		} catch (ClientProtocolException e) {

			e.printStackTrace();

		} catch (IOException e) {

			e.printStackTrace();

		} finally {

		}

		return returnNode;

	}
	
	
	public static JsonNode getKakaoUserInfo(String autorize_code) {

		final String RequestUrl = "https://kapi.kakao.com/v1/user/me";

		final HttpClient client = HttpClientBuilder.create().build();
		final HttpPost post = new HttpPost(RequestUrl);

		// add header
		post.addHeader("Authorization", "Bearer " + autorize_code);

		JsonNode returnNode = null;

		try {
			final HttpResponse response = client.execute(post);
			final int responseCode = response.getStatusLine().getStatusCode();

			System.out.println("\nSending 'POST' request to URL : " + RequestUrl);
			System.out.println("Response Code : " + responseCode);

			// JSON 형태 반환값 처리
			ObjectMapper mapper = new ObjectMapper();
			returnNode = mapper.readTree(response.getEntity().getContent());

		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (ClientProtocolException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			// clear resources
		}
		return returnNode;

	}

	public static MemberDTO changeData(JsonNode userInfo) {
		MemberDTO dto = new MemberDTO();

		dto.setUserid(userInfo.path("id").asText()); // id -> vo 넣기
	
		if (userInfo.path("kaccount_email_verified").asText().equals("true")) { // 이메일 받기 허용 한 경우
			dto.setEmail(userInfo.path("kaccount_email").asText()); // email -> vo 넣기

		} else { // 이메일 거부 할 경우 코드 추후 개발

		}

		JsonNode properties = userInfo.path("properties"); // 추가정보 받아오기
		if (properties.has("nickname"))
			dto.setName(properties.path("nickname").asText());
			//dto.setUser_profileImagePath(properties.path("profile_image").asText());
		return dto;
	}

}