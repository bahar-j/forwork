package org.forwork.service.ScrumBoard;

import java.util.List;
import java.util.Map;

import org.forwork.domain.Project;
import org.forwork.domain.Task;
import org.forwork.domain.TaskLog;

public interface TaskService {

	public int insertTask(Task task);

	public List<Task> listTask();

	public int deleteTask(int task_id);

	public int updateTask(Task task);

	public Task detailTask(int task_id);
	
	public int moveTask(Map<String, String> changeData);
	
	public int addRes(int task_id, String member_id);
	
	public TaskLog getLog(int task_id);
	
	public List<TaskLog> getLogs(int task_id);
	
	public int getSprintId(int task_id);
	
	public Project getPr(int project_id);

	public int modifyTaskSprintRelation(String sprint_id, String task_id);
	
	public int sendTodo(int task_id);
	
}

