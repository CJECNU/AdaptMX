<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="redis.clients.jedis.Jedis"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.*"%>
 
<%! 
  private int num=-1;
  private int num2=0;
  private int first=0;
%>
<% 
	response.setHeader("Access-Control-Allow-Origin", "*");

	String host="127.0.0.1";
	int port=6379;
	int row,col;
	long pl;
	int done=0;
	String total;
	Jedis client=new Jedis(host,port);
	ArrayList<String> arrayList = new ArrayList<String>();
	ArrayList<String> arrayList2 = new ArrayList<String>();
	if(first!=1){row=1;col=1;pl=0;arrayList.add(0, "0");done=0;first=1;total="0";}
	else {
	//List<String> list = client.lrange("matrix", 0 ,0); 
	String a = client.lindex("matrix", num--);
	//System.out.println(num+1);
	//System.out.println(a);
	String[] b = a.split("\\|");
	String[] c;
	row = b.length;
	c=b[0].split(" ");
	col=c.length;
	for(int i=0;i<row;i++){
		c=b[i].split(" ");
		for(int j=0;j<col;j++){
			arrayList.add(c[j]);
		}
	}
	
	List<String> d = client.lrange("plan_items"+num2, 0, -1);
	pl=client.llen("plan_items"+num2);
	total=client.get("total" + num2);
	num2++;
	for(int i=0;i<pl;i++){
		c=d.get(i).split(" ");
		for(int j=0;j<4;j++){
			arrayList2.add(c[j]);
		}
	}
	if(!client.exists("plan_items"+num2)){
		num=-1; num2=0;  //最后一次刷新
		done=1;
		//num=num+1; num2=num2-1;//最后一次不刷新
		}
	//if(num<-3) {num=-1; num2=0;} //有了3个矩阵数据测试用
	//System.out.println(row);
	//System.out.println(col);
	//System.out.println(arrayList);
	//System.out.println(pl);
	//System.out.println(d);
	}
%>
{ "row":<%=row%>,"col":<%=col%>,"Matrix":<%=arrayList%>,"plan_items":<%=arrayList2%>,"pl":<%=pl%>,"total":<%=total%>,"done":<%=done%>}