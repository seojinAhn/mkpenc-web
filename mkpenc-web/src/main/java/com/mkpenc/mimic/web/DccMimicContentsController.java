package com.mkpenc.mimic.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.mkpenc.mimic.model.DccSearchMimic;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Controller
@RequestMapping("/dcc/mimic/")
public class DccMimicContentsController {

	private static Logger logger = LoggerFactory.getLogger(DccMimicContentsController.class);
	
	private String menuName = "MIMIC";
	
	@RequestMapping("lzc_1")
	public ModelAndView lzc_1(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ lzc_1");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchMimic.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }

        return mav;
    }
	
	@RequestMapping("lzc_2")
	public ModelAndView lzc_2(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ lzc_2");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchMimic.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
      
        return mav;
    }
	
	@RequestMapping("pht")
	public ModelAndView pht(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ pht");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchMimic.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
      
        return mav;
    }	
	
	@RequestMapping("phtctrl")
	public ModelAndView phtctrl(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ phtctrl");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchMimic.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
      
        return mav;
    }	
	
	@RequestMapping("moderator")
	public ModelAndView moderator(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ moderator");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchMimic.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
      
        return mav;
    }			
	
	
	@RequestMapping("phtpuri")
	public ModelAndView phtpuri(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ phtpuri");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchMimic.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
      
        return mav;
    }		
	
	@RequestMapping("ecc")
	public ModelAndView ecc(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ ecc");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchMimic.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
      
        return mav;
    }		
	
	@RequestMapping("mainsteam")
	public ModelAndView mainsteam(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ mainsteam");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchMimic.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
      
        return mav;
    }		
	
	@RequestMapping("feedwater")
	public ModelAndView feedwater(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ feedwater");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchMimic.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
      
        return mav;
    }		
	
	@RequestMapping("condensate")
	public ModelAndView condensate(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ condensate");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchMimic.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
      
        return mav;
    }		
	
	
	@RequestMapping("fuelhandlingmenu")
	public ModelAndView fuelhandlingmenu(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ fuelhandlingmenu");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchMimic.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
      
        return mav;
    }		
	
	@RequestMapping("d2octrla")
	public ModelAndView d2octrla(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ d2octrla");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchMimic.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
      
        return mav;
    }	
	
	@RequestMapping("d2octrlc")
	public ModelAndView d2octrlc(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ d2octrlc");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchMimic.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
      
        return mav;
    }		
	
	@RequestMapping("radmain")
	public ModelAndView radmain(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ radmain");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchMimic.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
      
        return mav;
    }	
	
	@RequestMapping("rbbase")
	public ModelAndView rbbase(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ rbbase");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchMimic.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
      
        return mav;
    }		
	
	@RequestMapping("rb1f")
	public ModelAndView rb1f(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ rb1f");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchMimic.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
      
        return mav;
    }		
	
	@RequestMapping("rb2f")
	public ModelAndView rb2f(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ rb2f");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchMimic.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
      
        return mav;
    }		
	
	@RequestMapping("rb3f")
	public ModelAndView rb3f(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ rb3f");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchMimic.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
      
        return mav;
    }	
	
	@RequestMapping("rb4f")
	public ModelAndView rb4f(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ rb4f");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchMimic.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
      
        return mav;
    }
	
	@RequestMapping("rb5f")
	public ModelAndView rb5f(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ rb4f");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchMimic.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
      
        return mav;
    }	
	
	@RequestMapping("sbbase")
	public ModelAndView sbbase(DccSearchMimic dccSearchMimic, HttpServletRequest request) {
        
		ModelAndView mav = new ModelAndView();

        logger.info("############ sbbase");
        
        if(request.getSession().getAttribute("USER_INFO") != null) {
        	
        	dccSearchMimic.setMenuName(this.menuName);
        	
        	mav.addObject("BaseSearch", dccSearchMimic);
        	mav.addObject("UserInfo", request.getSession().getAttribute("USER_INFO"));
        	
        }
      
        return mav;
    }		
	
}
