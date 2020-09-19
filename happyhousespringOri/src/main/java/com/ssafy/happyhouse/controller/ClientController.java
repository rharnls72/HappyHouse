package com.ssafy.happyhouse.controller;

import java.nio.ByteBuffer;
import java.security.AlgorithmParameters;
import java.security.SecureRandom;
import java.util.Base64;
import java.util.List;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.PBEKeySpec;
import javax.crypto.spec.SecretKeySpec;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ssafy.happyhouse.model.dto.Client;
import com.ssafy.happyhouse.model.dto.HappyHouseException;
import com.ssafy.happyhouse.model.service.ClientService;


@RequestMapping("/log.do")
@Controller
public class ClientController{
	@Autowired
	private ClientService clientService;

	@ExceptionHandler
	public ModelAndView handler(Exception e) {
		ModelAndView mav = new ModelAndView("error/error");
		mav.addObject("msg", e.getMessage());
		return mav;
	}
	@GetMapping("mvlogin")
	public String mvlogin() {
		return "client/login";
	}
	@GetMapping("mvjoin")
	public String mvjoin() {
		return "client/join";
	}
	@PostMapping("login")
	private String login(Client user, String idsave, HttpSession session, HttpServletResponse response) {
		try {
			String key = "secret key";
			Client client = clientService.search(user.getId());
			if(client != null && user.getPassword().equals(decryptAES256(client.getPassword(), key))) {
				session.setAttribute("userinfo", client);

				Cookie cookie = new Cookie("ssafy_id", user.getId());
				if("saveok".equals(idsave)) {//아이디 저장을 체크 했다면.
					cookie.setMaxAge(60 * 60 * 24 * 365 * 40);//40년간 저장.
				} else {//아이디 저장을 해제 했다면.
					cookie.setMaxAge(0);
				}
				response.addCookie(cookie);
			}else {
				throw new Exception();
			}
		} catch (Exception e) {
			throw new HappyHouseException("아이디 또는 비밀번호 확인 후 로그인해 주세요.");
		}
		return "index";
	}
	@GetMapping("logout")
	private String logout(HttpSession session) {
		//		session.removeAttribute("userinfo");
		session.invalidate();
		return "index";
	}
	@PostMapping("register")
	private String client_register(Client clientdto) {
		try {
			if(clientService.search(clientdto.getId())!=null)
				throw new HappyHouseException();
			String key = "secret key";
			String encrypted = encryptAES256(clientdto.getPassword(), key);
			clientdto.setPassword(encrypted);
			clientService.add(clientdto);
			return "redirect:/log.do/mvlogin";
		} catch (HappyHouseException e) {
			throw new HappyHouseException("중복된 아이디 입니다.");
		}catch (Exception e) {
			e.printStackTrace();
			throw new HappyHouseException("회원 가입 중 문제가 발생했습니다.");
		}
	}
	@GetMapping("mypage")
	private String moveModifyArticle(HttpSession session, Model model)  {
		try {
			Client client = (Client)session.getAttribute("userinfo");
			client = clientService.search(client.getId());
			String key = "secret key";
			client.setPassword(decryptAES256(client.getPassword(), key));
			model.addAttribute("client", client);
			return "client/mypage";
		} catch (Exception e) {
			e.printStackTrace();
			throw new HappyHouseException("회원 조회 중 문제가 발생했습니다.");
		}
	}
	@PostMapping("modify")
	private String client_modify(Client clientdto, HttpSession session){
		try {
			String key = "secret key";
			clientdto.setPassword(encryptAES256(clientdto.getPassword(), key));
			clientService.update(clientdto);
			session.invalidate();
			return "redirect:/log.do/mvlogin";
		} catch (Exception e) {
			e.printStackTrace();
			throw new HappyHouseException("회원정보 수정 중 문제가 발생했습니다.");
		}
	}
	@GetMapping("delete/{id}")
	private String client_delete(@PathVariable String id, HttpSession session)  {
		try {
			clientService.remove(id);
			session.invalidate();
			return "redirect:/log.do/mvlogin";
		} catch (Exception e) {
			e.printStackTrace();
			throw new HappyHouseException("회원 삭제 중 문제가 발생했습니다.");
		}
	}
	@RequestMapping("manage")
	private String client_search(String key,String word, Model model) {
		try {
			List<Client> list = clientService.clientlist(key, word);
			model.addAttribute("articles", list);
			return "client/list";
		} catch (Exception e) {
			e.printStackTrace();
			throw new HappyHouseException("회원 리스트 조회 중 문제가 발생했습니다.");
		}
	}
	@GetMapping("mvfindpwd")
	private String mvfindpwd() {
		return "client/pwd";
	}
	@PostMapping("findpwd")
	private String search_pwd(Client user, Model model) {
		try {
			Client client = clientService.search(user.getId());
			if(client == null || !client.getName().equals(user.getName())){
				throw new HappyHouseException();
			}else{
				String key = "secret key";
				client.setPassword(decryptAES256(client.getPassword(), key));
				model.addAttribute("cli", client);
				return "client/search_sucess";
			}
		} catch (HappyHouseException e) {
			throw new HappyHouseException("아이디 또는 이름이 틀렸습니다.");
		} catch (Exception e) {
			e.printStackTrace();
			throw new HappyHouseException("비밀번호 찾던 도중 문제가 발생했습니다.");
		}
	}
	@PostMapping("deleteids")
	private String clients_delete(String[] deleteid) {
		if(deleteid == null) {
			throw new HappyHouseException("탈퇴할 회원을 선택하지 않았습니다.");
		}
		for (String id : deleteid) {
			try {
				clientService.remove(id);
			} catch (Exception e) {
				e.printStackTrace();
				throw new HappyHouseException("회원 탈퇴 처리 중 에러가 발생했습니다.");
			}
		}
		return "redirect:/log.do/manage";
	}

	public static String encryptAES256(String msg, String key) throws Exception {
		SecureRandom random = new SecureRandom();
		byte bytes[] = new byte[20];
		random.nextBytes(bytes);
		byte[] saltBytes = bytes;
		// Password-Based Key Derivation function 2
		SecretKeyFactory factory = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA1");
		// 70000번 해시하여 256 bit 길이의 키를 만든다.
		PBEKeySpec spec = new PBEKeySpec(key.toCharArray(), saltBytes, 70000, 256);
		SecretKey secretKey = factory.generateSecret(spec);
		SecretKeySpec secret = new SecretKeySpec(secretKey.getEncoded(), "AES");
		// 알고리즘/모드/패딩
		// CBC : Cipher Block Chaining Mode
		Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
		cipher.init(Cipher.ENCRYPT_MODE, secret);
		AlgorithmParameters params = cipher.getParameters();
		// Initial Vector(1단계 암호화 블록용)
		byte[] ivBytes = params.getParameterSpec(IvParameterSpec.class).getIV();
		byte[] encryptedTextBytes = cipher.doFinal(msg.getBytes("UTF-8"));
		byte[] buffer = new byte[saltBytes.length + ivBytes.length + encryptedTextBytes.length];
		System.arraycopy(saltBytes, 0, buffer, 0, saltBytes.length);
		System.arraycopy(ivBytes, 0, buffer, saltBytes.length, ivBytes.length);
		System.arraycopy(encryptedTextBytes, 0, buffer, saltBytes.length + ivBytes.length, encryptedTextBytes.length);
		return Base64.getEncoder().encodeToString(buffer);
	}
	public static String decryptAES256(String msg, String key) throws Exception {
		Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
		ByteBuffer buffer = ByteBuffer.wrap(Base64.getDecoder().decode(msg));
		byte[] saltBytes = new byte[20];
		buffer.get(saltBytes, 0, saltBytes.length);
		byte[] ivBytes = new byte[cipher.getBlockSize()];
		buffer.get(ivBytes, 0, ivBytes.length);
		byte[] encryoptedTextBytes = new byte[buffer.capacity() - saltBytes.length - ivBytes.length];
		buffer.get(encryoptedTextBytes);
		SecretKeyFactory factory = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA1");
		PBEKeySpec spec = new PBEKeySpec(key.toCharArray(), saltBytes, 70000, 256);
		SecretKey secretKey = factory.generateSecret(spec);
		SecretKeySpec secret = new SecretKeySpec(secretKey.getEncoded(), "AES");
		cipher.init(Cipher.DECRYPT_MODE, secret, new IvParameterSpec(ivBytes));
		byte[] decryptedTextBytes = cipher.doFinal(encryoptedTextBytes);
		return new String(decryptedTextBytes);
	}
}
