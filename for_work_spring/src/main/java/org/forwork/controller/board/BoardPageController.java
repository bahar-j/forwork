package org.forwork.controller.board;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.forwork.domain.Criteria;
import org.forwork.dto.PageDto;
import org.forwork.service.board.BoardService;
import org.forwork.service.board.PostService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board/*")
@AllArgsConstructor
public class BoardPageController {

	private BoardService boardService;
	private PostService postService;
	
	@GetMapping("/main")
	public void main(int project_id, Model model) {
		log.info("?λ‘μ ?Έλ³? κ²μ? λ©μΈ");
		
		boardService.init(project_id); // ? ?λ‘μ ?Έ κ³΅μ? ?¬?­, κΈ°λ³Έ κ²μ? ??±
		
		model.addAttribute("menu", boardService.getList(project_id)); // κ²μ? λ©λ΄
		model.addAttribute("notice", postService.getNotice(project_id)); // κ³΅μ? ?¬?­
		model.addAttribute("board", postService.getBoard(project_id)); // μ΅μ  κΈ?
		model.addAttribute("project_id", project_id);
	}
	
	@GetMapping("/list")
	public void list(int project_id, Long board_id, Criteria cri, Model model) {
		log.info("κ²μ?λ³? κ²μκΈ? λͺ©λ‘");
		log.info("cri: " + cri);
		
		int total = postService.getTotal(cri, board_id);
		
		if (total < 10) {
			cri.setAmount(total);
		} else {
			cri.setAmount(10);
		}
		
		model.addAttribute("menu", boardService.getList(project_id));
		model.addAttribute("board", boardService.get(board_id)); // κ²μ? ?΄λ¦?
		model.addAttribute("list", postService.getListPage(cri, board_id)); // κ²μκΈ? λͺ©λ‘
		model.addAttribute("pageMaker", new PageDto(cri, total));
	}

	@GetMapping("/manager")
	public void manager(int project_id, Long board_id, Model model) {
		log.info("κ²μ? κ΄?λ¦? ??΄μ§?");
		
		model.addAttribute("menu", boardService.getList(project_id));
		model.addAttribute("project_id", project_id);
	}
	
	@GetMapping("/post")
	public void post(@RequestParam("project_id") int project_id, @RequestParam("board_id") Long board_id, 
			@RequestParam("post_id") Long post_id, @ModelAttribute("cri") Criteria cri, Model model) {
		log.info("κ²μκΈ? ??Έ λ³΄κΈ°");
		postService.addHitcount(post_id); // μ‘°ν ?
		model.addAttribute("menu", boardService.getList(project_id));
		model.addAttribute("board", boardService.get(board_id)); 
		model.addAttribute("post", postService.get(post_id));
	}

	@GetMapping("/updatePost")
	public void updatePost(@RequestParam("project_id") int project_id, @RequestParam("board_id") Long board_id, 
			@RequestParam("post_id") Long post_id, @ModelAttribute("cri") Criteria cri, Model model) {
		log.info("κ²μκΈ? ??  ??΄μ§?");
		model.addAttribute("menu", boardService.getList(project_id));
		model.addAttribute("board", boardService.get(board_id)); 
		model.addAttribute("post", postService.get(post_id));
	}

	@GetMapping("/insertPost")
	public void insertPost(int project_id, Long board_id, Model model) {
		log.info("κ²μκΈ? ?±λ‘? ??΄μ§?");
		
		model.addAttribute("menu", boardService.getList(project_id));
		model.addAttribute("board", boardService.get(board_id)); 
	}
	
}
