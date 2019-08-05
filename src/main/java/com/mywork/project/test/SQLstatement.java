package com.mywork.project.test;

import com.mywork.project.util.ExcelUtil;
import org.junit.jupiter.api.Test;

import java.io.FileInputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

/**
 * @author 杜晓鹏
 * @create 2019-08-05 21:57
 */
public class SQLstatement {
    public static void main(String[] args) {
        List<List<Object>> listob;
        List<Pojo> pojos = new ArrayList<>();
        try {
            InputStream in = new FileInputStream("C:\\Users\\96184\\Documents\\WeChat Files\\weixiao15655\\FileStorage\\File\\2019-08\\单位汇总.xlsx");
            listob = ExcelUtil.getBankListByExcel(in, "单位汇总.xlsx");
        } catch (Exception e) {
            throw new RuntimeException("文件解析失败，请重新导入！");
        }
        //遍历listob数据，把数据放到List中
        for (int i = 0; i < listob.size(); i++) {

            List<Object> ob = listob.get(i);
            Pojo pojo = new Pojo();
            if (ob.size() == 7) {
                if (ob.get(0)!= null){
                    String sheng = String.valueOf(ob.get(0));
                    pojo.setSheng(sheng);
                }
                if (ob.get(1)!= null){
                    String code = String.valueOf(ob.get(1));
                    pojo.setCode(code);
                }
                if (ob.get(2)!= null){
                    String parentcode = String.valueOf(ob.get(2));
                    pojo.setParentcode(parentcode);
                }
                if (ob.get(3)!= null){
                    String name = String.valueOf(ob.get(3));
                    pojo.setName(name);
                }
                if (ob.get(4)!= null){
                    String nm = String.valueOf(ob.get(4));
                    pojo.setNm(nm);
                }
                if (ob.get(5)!= null){
                    String status = String.valueOf(ob.get(5));
                    pojo.setStatus(status);
                }
                if (ob.get(6)!= null){
                    String error = String.valueOf(ob.get(6));
                    pojo.setError(error);
                }
            } else if (ob.size() == 8) {
                if (ob.get(0)!= null){
                    String sheng = String.valueOf(ob.get(0));
                    pojo.setSheng(sheng);
                }
                if (ob.get(1)!= null){
                    String code = String.valueOf(ob.get(1));
                    pojo.setCode(code);
                }
                if (ob.get(2)!= null){
                    String parentcode = String.valueOf(ob.get(2));
                    pojo.setParentcode(parentcode);
                }
                if (ob.get(3)!= null){
                    String name = String.valueOf(ob.get(3));
                    pojo.setName(name);
                }
                if (ob.get(4)!= null){
                    String nm = String.valueOf(ob.get(4));
                    pojo.setNm(nm);
                }
                if (ob.get(5)!= null){
                    String status = String.valueOf(ob.get(5));
                    pojo.setStatus(status);
                }
                if (ob.get(6)!= null){
                    String error = String.valueOf(ob.get(6));
                    pojo.setError(error);
                }
                if (ob.get(7)!= null){
                    String msg = String.valueOf(ob.get(7));
                    pojo.setMsg(msg);
                }
            } else {
                if (ob.get(0)!= null){
                    String sheng = String.valueOf(ob.get(0));
                    pojo.setSheng(sheng);
                }
                if (ob.get(1)!= null){
                    String code = String.valueOf(ob.get(1));
                    pojo.setCode(code);
                }
                if (ob.get(2)!= null){
                    String parentcode = String.valueOf(ob.get(2));
                    pojo.setParentcode(parentcode);
                }
                if (ob.get(3)!= null){
                    String name = String.valueOf(ob.get(3));
                    pojo.setName(name);
                }
                if (ob.get(4)!= null){
                    String nm = String.valueOf(ob.get(4));
                    pojo.setNm(nm);
                }
                if (ob.get(5)!= null){
                    String status = String.valueOf(ob.get(5));
                    pojo.setStatus(status);
                }
                if (ob.get(6)!= null){
                    String error = String.valueOf(ob.get(6));
                    pojo.setError(error);
                }
                if (ob.get(7)!= null){
                    String msg = String.valueOf(ob.get(7));
                    pojo.setMsg(msg);
                }
                if (ob.get(8)!=null){
                    String dont = String.valueOf(8);
                    pojo.setDont(dont);
                }
            }
            pojos.add(pojo);

        }
        System.out.println(pojos);

        del(pojos);




    }

    private static void del(List<Pojo> pojos){
        StringBuffer sqldel = new StringBuffer();
        StringBuffer sqladd = new StringBuffer();
        sqldel.append("update gh_sys_dept_union t1 set \n" +
                "t1.ghflag = '0',t1.prflag = '0',\n" +
                "\n" +
                "t1.stflag = '0',t1.inflag = '0',\n" +
                "t1.qkjflag ='0',t1.dyjrflag ='0'\n" +
                ",t1.gsghflag= '0',t1.dbflag ='0'\n" +
                ",t1.fzzdflag ='0',t1.compflag ='0',\n" +
                "t1.modelflag ='0' where t1.deptcode in (");
        sqladd.append(
                "insert into gh_sys_dept_union t1\n" +
                        "(t1.plat,t1.platparentcode,t1.deptcode,t1.parentcode,t1.deptname,t1.deptsimpname,t1.comptype,t1.keysort,t1.ghflag,t1.prflag,\n" +
                        "\n" +
                        "t1.stflag,t1.inflag,t1.qkjflag,t1.dyjrflag,t1.gsghflag,t1.dbflag,t1.fzzdflag,t1.compflag,t1.modelflag,t1.isort,\n" +
                        "\n" +
                        "t1.stsort,t1.city,t1.compnature,t1.qbdeptcode,t1.areacode,t1.areaname,t1.pmscode,\n" +
                        "\n" +
                        "t1.countytype,t1.province,t1.compjoincode,t1.cantoncode,t1.ghsort,t1.presort,t1.qkjsort,t1.dyjrsort,t1.gsghsort,t1.uncheckkind,\n" +
                        "\n" +
                        "t1.compkind,t1.areatype,t1.remark,t1.isrural,t1.mapid,t1.jijiancode,t1.phdeptname,t1.echartsdeptsimpname,t1.i6000code,t1.isccode,\n" +
                        "\n" +
                        "t1.relationquestioncode,t1.supplyareaname,t1.supplyareacode)\n" +
                        "values ("
        );

        for (Pojo pojo: pojos) {
            if (pojo.getError().equals("删除")){
                 sqldel.append(pojo.getCode()).append(",");
            }
            if (pojo.getError().equals("新增")){
                if (pojo.getMsg()!= null && !pojo.getMsg().equals("")){
                    sqladd.append("'").append(getNum(pojo.getMsg())).append("',");
                }
                if (pojo.getDont()!=null && !pojo.getDont().equals("")){
                    sqladd.append("'").append(getNum(pojo.getMsg())).append("',");
                }
                if (pojo.getName()!= null && !pojo.getName().equals("")){
                    sqladd.append("'").append(pojo.getName()).append("',");
                }
                if (pojo.getSheng() != null && !pojo.getSheng().equals("")){
                    sqladd.append("'").append(pojo.getSheng()).append("',");
                }
                if (pojo.getNm() != null && !pojo.getNm().equals("")){
                    sqladd.append("'").append(pojo.getNm()).append("',");
                }
                sqladd.append("),(");
            }
        }
        System.out.println(sqldel.toString());
        System.out.println(sqladd.toString());


    }


    @Test
    public void test(){
        String str = "新增单位，该单位对应关系的普华编码为21311042422803001";
        String[] ss = str.split("\\D");
        for (String sss:ss) {
            System.out.print(sss);
        }
    }
    private static String getNum(String str){
        String[] ss = str.split("\\D");
        String num = "";
        for (String sss:ss) {
            num = sss;
        }
        return num;
    }



}
