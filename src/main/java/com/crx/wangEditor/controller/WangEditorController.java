package com.crx.wangEditor.controller;

import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class WangEditorController {
	
	@RequestMapping("/testFileUpload")
	public String testFileUpload(@RequestParam("desc") String desc,
				@RequestParam("file")MultipartFile file) throws Exception {
		System.out.println("desc:" + desc);
		System.out.println("OriginalFilename:" + file.getOriginalFilename());
		System.out.println("InputStream:" + file.getInputStream());
		
//		InputStream in = file.getInputStream();
//		byte [] buf = new byte[in.available()];
//		OutputStream out = new FileOutputStream("e:/" + file.getOriginalFilename());
//		int len;
//		while((len = in.read(buf))!= -1) {
//			out.write(buf, 0, len);
//		}
//		out.close();
//		in.close();
		
		return "success";
	}
	
}
