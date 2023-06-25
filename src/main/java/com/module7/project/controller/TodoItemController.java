package com.module7.project.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.module7.project.models.TodoItem;
import com.module7.project.repositories.*;

import java.util.List;

@RestController
@RequestMapping("/apis")
public class TodoItemController {
	
		@Autowired
		private TodoItemRepository todoItemRepo;
		
	    @GetMapping(value = "/todoitems")
	    public List<TodoItem> getAllCourses() {
	        return todoItemRepo.findAll();
	    }
	    
	    @PostMapping(value = "/addTodoItem")
	    public List<TodoItem> addCourse(@RequestBody TodoItem todoItem) {
	    	todoItemRepo.save(todoItem);
	    	return todoItemRepo.findAll();
	    }
	
}