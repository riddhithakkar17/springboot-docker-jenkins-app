package com.module7.project.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.module7.project.models.TodoItem;

import java.util.List;

@Repository
public interface TodoItemRepository extends JpaRepository<TodoItem, Integer> {
    TodoItem findById(int id);

    List<TodoItem> findAllByName(String name);
}