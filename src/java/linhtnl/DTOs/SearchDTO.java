/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package linhtnl.DTOs;

import java.io.Serializable;

/**
 *
 * @author ASUS
 */
public class SearchDTO implements Serializable{
    private String content,subID,status;


    public SearchDTO(String content, String subID,String status) {
        if(content == null) content="";
        if(subID==null) content="";
        if(status==null)status="";
        this.content = content;
        this.subID = subID;
        this.status = status;
    }

    public SearchDTO() {
    }
    
    public String getContent() {
        return content;
    }

    public String getSubID() {
        return subID;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

   
    public void setContent(String content) {
        this.content = content;
    }

 

    public void setSubID(String subID) {
        this.subID = subID;
    }
    
}
