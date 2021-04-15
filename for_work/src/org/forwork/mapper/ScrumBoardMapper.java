package org.forwork.mapper;

import java.util.List;

import org.forwork.domain.Task;

public interface ScrumBoardMapper {
	int insertTask(Task task);
	List<Task> listTask();
	int deleteTask(int seq);
	int getStoriesIndex();
	Task getTask(String task_id);
	int updateTask(Task task);
	int increaseIndex(Task task);
	int decreaseIndex(Task task);
}
