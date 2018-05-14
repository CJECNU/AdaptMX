<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="redis.clients.jedis.Jedis"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.*"%>
 
<%! 
  private int num=1;
%>
<% 
	response.setHeader("Access-Control-Allow-Origin", "*");
	String host="127.0.0.1";
	int port=6379;
	long len;
	int done=0;
	Jedis client=new Jedis(host,port);
	ArrayList<String> arrayList = new ArrayList<String>();
	ArrayList<String> arrayList2 = new ArrayList<String>();
	len=client.llen("load"+num);
	List<String> list = client.lrange("load"+num, 0 ,len-1); 
	//String[] b = list.get(0).split("\\|");
	for(int i=0;i<len;i++){
		String[] b = list.get(i).split("\\|");
		arrayList.add(b[0]);
		arrayList2.add(b[1]);
	}
	if(!client.exists("load"+(++num))){
		num=1;
		done=1;
		}
%>
{ "len":<%=len%>,"x":<%=arrayList%>,"y":<%=arrayList2%>,"done":<%=done%>}