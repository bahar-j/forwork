package org.forwork.service.board;

import java.util.List;

import org.springframework.stereotype.Service;
import org.forwork.domain.Criteria;
import org.forwork.domain.Post;
import org.forwork.mapper.PostMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class PostServiceImpl implements PostService {
	
	private PostMapper mapper;

	@Override
	public int register(Post post) {
		log.info("? ๊ฒ์๊ธ? ?ฑ๋ก?..." + post);
		
		return mapper.insertPostSelectKey(post);
	}

	@Override
	public Post get(Long post_id) {
		log.info("๊ฒ์๊ธ? ??ธ ๋ณด๊ธฐ..." + post_id);
		
		return mapper.getPost(post_id);
	}
	
	@Override
	public int addHitcount(Long post_id) {
		log.info("๊ฒ์๊ธ? ์กฐํ ?");
		
		return mapper.updateHitcount(post_id);
	}

	@Override
	public int modify(Post post) {
		log.info("๊ฒ์๊ธ? ?? ..." + post);
		
		return mapper.updatePost(post);
	}

	@Override
	public int remove(Long post_id) {
		log.info("๊ฒ์๊ธ? ?ญ? ..." + post_id);
		
		return mapper.deletePost(post_id);
	}

	@Override
	public List<Post> getList(Long board_id) {
		log.info("๊ฒ์๊ธ? ๋ชฉ๋ก..." + board_id);
		
		return mapper.listPost(board_id);
	}

	@Override
	public List<Post> getListPage(Criteria cri, Long board_id) {
		return mapper.listPostWithPaging(cri, board_id);
	}
	
	@Override
	public int getTotal(Criteria cri, Long board_id) {
		log.info("get total count");
		return mapper.getCountByBno(cri, board_id);
	}	
	
	@Override
	public List<Post> getNotice(int project_id) {
		log.info("?๋ก์ ?ธ๋ณ? ๊ณต์? ?ฌ?ญ ๋ฏธ๋ฆฌ ๋ณด๊ธฐ...");
		
		return mapper.listNotice(project_id);
	}

	@Override
	public List<Post> getBoard(int project_id) {
		log.info("?๋ก์ ?ธ๋ณ? ์ต์  ๊ธ? ๋ชฉ๋ก...");
		
		return mapper.listBoard(project_id);
	}

}
