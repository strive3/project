package com.mywork.project.exception;

import com.mywork.project.util.JsonResult;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;


//全局异常捕获机制
@ControllerAdvice
public class GlobalExceptionHandler {
	
	@ExceptionHandler(Exception.class)
	@ResponseBody
	public JsonResult handlerException(Exception e){
		return new JsonResult(e);
	}
	
}
