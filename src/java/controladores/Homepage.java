package controladores;

import ParentWeb.Profesor;
import ParentWeb.Observation;
import ParentWeb.Objective;
import ParentWeb.DBConect;
import ParentWeb.DataWhatDoing;
import ParentWeb.Subject;
import ParentWeb.LoginVerification;
import ParentWeb.Step;
import ParentWeb.User;
import atg.taglib.json.util.JSONObject;
import com.google.gson.Gson;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import static java.lang.System.in;
import java.sql.*;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import javax.imageio.ImageIO;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import mapcusts.Getcusts;
import quickbooksync.*;
import javax.servlet.http.HttpSession;
import org.springframework.context.ApplicationContext;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.commons.net.ftp.FTP;
import org.apache.commons.net.ftp.FTPClient;

@RequestMapping("/")
public class Homepage extends MultiActionController {

    Connection cn;
    DBConect c;

    private Object getBean(String nombrebean, ServletContext servlet) {
        ApplicationContext contexto = WebApplicationContextUtils.getRequiredWebApplicationContext(servlet);
        Object beanobject = contexto.getBean(nombrebean);
        return beanobject;
    }

    public ModelAndView inicio(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        return new ModelAndView("userform");
        //  return new ModelAndView("homepage");
    }

    @RequestMapping
    public ModelAndView login(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        DBConect.close();
        c = new DBConect(hsr, hsr1);
        HttpSession session = hsr.getSession();
        User user = new User();

        boolean result = true;
        LoginVerification login = new LoginVerification();
        if ("QuickBook".equals(hsr.getParameter("txtusuario"))) {
            ModelAndView mv = new ModelAndView("redirect:/suhomepage.htm?opcion=loadconfig");
            return mv;
        } else {
            user = login.consultUserDB(hsr.getParameter("txtusuario"), hsr.getParameter("txtpassword"));
        }

        if (user.getId() == 0) {
            ModelAndView mv = new ModelAndView("userform");
            String message = "Username or password incorrect";
            mv.addObject("message", message);
            return mv;
        } else {
            HashMap<Integer, String> mapSons = login.getSons(user.getId());
            if (!mapSons.isEmpty()) {

                ModelAndView mv = new ModelAndView("homepage");
                String message = "welcome user";
                int termId = 1, yearId = 1;
                ResultSet rs2 = DBConect.ah.executeQuery("select defaultyearid,defaulttermid from ConfigSchool where configschoolid = 1");
                while (rs2.next()) {
                    termId = rs2.getInt("defaulttermid");
                    yearId = rs2.getInt("defaultyearid");
                }
                session.setAttribute("user", user);
                session.setAttribute("termId", termId);
                session.setAttribute("yearId", yearId);

                String nameTerm = "", nameYear = "";
                ResultSet rs3 = DBConect.ah.executeQuery("select name from SchoolTerm where TermID = " + termId + " and YearID = " + yearId);
                while (rs3.next()) {
                    nameTerm = "" + rs3.getString("name");
                }
                ResultSet rs4 = DBConect.ah.executeQuery("select SchoolYear from SchoolYear where yearID = " + yearId);
                while (rs4.next()) {
                    nameYear = "" + rs4.getString("SchoolYear");
                }
                session.setAttribute("termYearName", nameTerm + " / " + nameYear);

                SchoolData_Singleton schoolData = SchoolData_Singleton.getData();

                HashMap<Integer, Subject> mapSubjects = schoolData.getMapSubjects();
                HashMap<Integer, Profesor> mapProfesor = schoolData.getMapProfesor();
                HashMap<Integer, Step> mapStep = schoolData.getMapSteps();
                HashMap<Integer, Objective> mapOb = schoolData.getMapObjectives();

                mv.addObject("mapSubjects", new Gson().toJson(mapSubjects));
                mv.addObject("mapProfesor", new Gson().toJson(mapProfesor));
                mv.addObject("mapSteps", new Gson().toJson(mapStep));
                mv.addObject("mapObjectives", new Gson().toJson(mapOb));

                mv.addObject("sons", new Gson().toJson(mapSons));
                mv.addObject("message", message);
                mv.addObject("username", user.getName());

                return mv;
            } else {
                ModelAndView mv = new ModelAndView("userform");
                String message = "Username or Password incorrect";
                mv.addObject("message", message);
                return mv;
            }
        }

    }

    @RequestMapping("/getSubjectsStudents.htm")
    @ResponseBody
    public String getSubjectsStudents(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        /*String id = hsr.getParameter("seleccion");   
        
        List<Subject> subs = getSubjects(Integer.parseInt(id));
        return new Gson().toJson(subs);*/

        String id = hsr.getParameter("seleccion");
        JSONObject json = new JSONObject();

        List<String> subs = getSubjects(Integer.parseInt(id));

        json.put("subjects", new Gson().toJson(subs));
        json.put("mapFinalRatings", new Gson().toJson(getfinalrating(id)));

        return json.toString();

    }

    @RequestMapping("/getCommentsDay.htm")
    @ResponseBody
    public String getCommentsDay(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {

        String fecha = hsr.getParameter("fecha");
        String numberWeek = fecha.split("-")[0];
        String monthSelected = fecha.split("-")[1];
        String yearSelected = fecha.split("-")[2];
        String studentId = hsr.getParameter("idStudent");

        DateFormat formatoFecha;// = new SimpleDateFormat("M/d/yyyy"); 
        if (monthSelected.length() == 1) {
            monthSelected = "0" + monthSelected;
        }
        String date = yearSelected + "-" + monthSelected + "-01";

        LocalDate convertedDate = LocalDate.parse(date, DateTimeFormatter.ofPattern("yyyy-M-d"));
        convertedDate = convertedDate.withDayOfMonth(convertedDate.getMonth().length(convertedDate.isLeapYear()));

        int DIAS_MAX = convertedDate.getDayOfMonth();

        int days = 0, logId = -1;

        Observation oAux = new Observation();

        formatoFecha = new SimpleDateFormat("yyyy-MM-dd");
        String dateSelected = yearSelected + "-" + monthSelected + "-" + "01";

        ArrayList<ArrayList<Observation>> arrayObservations = new ArrayList<ArrayList<Observation>>();
        ArrayList<Observation> arrayComments = new ArrayList<Observation>();
        String consulta = "SELECT * FROM public.classobserv WHERE student_id = " + studentId + " AND commentdate = '" + dateSelected + "'";
        try {
            boolean sameWeek = false;
            while (days < DIAS_MAX) {
                sameWeek = false;
                arrayComments.clear();
                consulta = "SELECT * FROM classobserv WHERE student_id = " + studentId + " AND commentdate = '" + dateSelected + "' ORDER BY commentdate";
                ResultSet rs = DBConect.eduweb.executeQuery(consulta);

                while (rs.next()) {

                    java.util.Date d = rs.getDate("commentdate");

                    oAux.setCommentDate("" + d);
                    Calendar cal = Calendar.getInstance();
                    cal.setTime(d);
                    cal.setMinimalDaysInFirstWeek(1);
                    oAux.setNumSemana("" + cal.get(Calendar.WEEK_OF_MONTH));

                    if (numberWeek.equals("" + cal.get(Calendar.WEEK_OF_MONTH))) {
                        sameWeek = true;
                        oAux.setId(rs.getInt("id"));
                        logId = rs.getInt("logged_by");
                        oAux.setNameTeacher("" + logId);
                        oAux.setLogged_by(logId);
                        oAux.setDate("" + rs.getDate("date_created"));
                        oAux.setObservation(rs.getString("comment"));
                        oAux.setType(rs.getString("category"));
                        oAux.setStudentid(Integer.parseInt(studentId));

                        if (logId != -1) {

                            SchoolData_Singleton schoolData = SchoolData_Singleton.getData();
                            oAux.setTeacherFoto("");
                            if (schoolData.getMapProfesor().containsKey(logId)) {
                                String path = schoolData.getMapProfesor().get(logId).getPathFoto();
                                if (path != null) {
                                    oAux.setTeacherFoto(getImageTeacher(hsr, hsr1, path));
                                }
                                oAux.setTeacherGender(schoolData.getMapProfesor().get(logId).getGender());
                            }
                        }
                        if (rs.getBoolean("foto")) {
                            oAux.setFoto(getImage(hsr, hsr1, "" + oAux.getId()));
                        } else {
                            oAux.setFoto("false");
                        }
                        arrayComments.add(new Observation(oAux));
                    }

                }

                if (sameWeek) {
                    arrayObservations.add(new ArrayList<Observation>(arrayComments));
                }
                days++;
                dateSelected = getNextDate(dateSelected);

            }
        } catch (SQLException ex) {
            StringWriter errors = new StringWriter();
            ex.printStackTrace(new PrintWriter(errors));
        }
        return new Gson().toJson(arrayObservations);

    }

    private String getNextDate(String curDate) throws ParseException {
        final SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        final java.util.Date date = format.parse(curDate);
        final Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        calendar.add(Calendar.DAY_OF_YEAR, 1);
        return format.format(calendar.getTime());
    }

    private List<String> getSubjects(int studentid) throws SQLException {
        List<String> subjects = new ArrayList<>();
        String termid = "", yearid = "";
        try {
            ResultSet rs = DBConect.ah.executeQuery("select defaultyearid,defaulttermid from ConfigSchool where configschoolid = 1");
            while (rs.next()) {
                termid = "" + rs.getInt("defaulttermid");
                yearid = "" + rs.getInt("defaultyearid");
            }
            String consulta = "select distinct courses.courseid,courses.rcplacement, courses.title, courses.active from roster    inner join classes on roster.classid=classes.classid\n"
                    + "                 inner join courses on courses.courseid=classes.courseid\n"
                    + "                  where roster.studentid = " + studentid + " and roster.enrolled" + termid + " =1 and courses.active = 1 and courses.reportcard = 1 and classes.yearid = '" + yearid + "' order by courses.rcplacement DESC";
            ResultSet rs1 = DBConect.ah.executeQuery(consulta);// the term and year need to be dynamic, check with vincent
            while (rs1.next()) {
                subjects.add(rs1.getString("courseid"));
            }
        } catch (SQLException ex) {
            System.out.println("Error leyendo Subjects: " + ex);
            StringWriter errors = new StringWriter();
            ex.printStackTrace(new PrintWriter(errors));
        }

        return subjects;
    }

    @RequestMapping("/getDataWhat.htm")
    @ResponseBody
    public String getDataWhat(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {

        String id = hsr.getParameter("seleccion");
        JSONObject json = new JSONObject();
        ArrayList<DataWhatDoing> arrayAttemp = new ArrayList<>();
        ArrayList<DataWhatDoing> arrayMastered = new ArrayList<>();
        ArrayList<DataWhatDoing> arrayFuture = new ArrayList<>();
        int diasSemana = 360;

        // QUEDA PENDIENTE AGREGAR LA RESTRICCION DEL ID_STUDENT
        String termid = "", yearid = "";
        try {
            ResultSet rs = DBConect.ah.executeQuery("select defaultyearid,defaulttermid from ConfigSchool where configschoolid = 1");
            while (rs.next()) {
                termid = "" + rs.getInt("defaulttermid");
                yearid = "" + rs.getInt("defaultyearid");
            }

            Calendar cal = Calendar.getInstance();
            Timestamp timestampBefore = new Timestamp(cal.getTimeInMillis());
            String currentDate = "" + timestampBefore;

            //pruebas
            cal.add(Calendar.DAY_OF_YEAR, diasSemana * -1);

            //cal.add( Calendar.DAY_OF_YEAR, -diasSemana);
            timestampBefore = new Timestamp(cal.getTimeInMillis());
            String beforeDate = "" + timestampBefore;

           
            String consulta = "SELECT * FROM (progress_report inner join rating on rating.id = rating_id) a inner join objective on objective.id = a.objective_id where a.student_id = "+id+" and a.yearterm_id=" + yearid + " and a.term_id= " + termid + " and a.comment_date between '" + beforeDate + "' and '" + currentDate + "'";
            //pruebas
            //String consulta = "SELECT * FROM (progress_report inner join rating on rating.id = rating_id) a inner join objective on objective.id = a.objective_id where a.comment_date between '" + beforeDate + "' and '" + currentDate + "'";

            ResultSet rs1 = DBConect.eduweb.executeQuery(consulta);// the term and year need to be dynamic, check with vincent
            while (rs1.next()) {
                String steps = rs1.getString("step_id");
                String numSteps = "0";
                DataWhatDoing auxData = new DataWhatDoing();

                if (steps != null && !steps.equals("0") && !steps.equals("")) {
                    String[] parts = steps.split(",");
                    numSteps = "" + parts.length;
                }
                auxData.setIdObjective(rs1.getString("objective_id")); // idobjective
                auxData.setObjectivesSuccess(numSteps); //numSteps
                auxData.setIdSubject("" + rs1.getInt("subject_id"));
                
                String nameAux = rs1.getString("name");
                if (nameAux.equals("Mastered")) {
                    arrayMastered.add(auxData);
                } else if(nameAux.equals("Attempted")){
                    arrayAttemp.add(auxData);
                }

            }

            beforeDate = currentDate;
            //pruebas
            cal.add(Calendar.DAY_OF_YEAR, diasSemana * 2);

            //cal.add( Calendar.DAY_OF_YEAR, -7);
            timestampBefore = new Timestamp(cal.getTimeInMillis());
            currentDate = "" + timestampBefore;

            //String consulta = "SELECT rating_id,student_id,objective_id,step_id,rating.name FROM progress_report inner join rating on rating.id = rating_id where yearterm_id="+yearid+" and student_id="+id+" and term_id= "+termid+" and comment_date between '"+beforeDate+"' and '"+currentDate+"'";    
            consulta = "SELECT DISTINCT objective_id,subject_id FROM lesson_stud_att inner join lessons on lesson_stud_att.lesson_id = lessons.id where  lesson_stud_att.student_id = "+id+" and lessons.yearterm_id=" + yearid + " and lessons.term_id= " + termid + " and lessons.start between '" + beforeDate + "' and '" + currentDate + "' order by subject_id";

            ResultSet rs2 = DBConect.eduweb.executeQuery(consulta);// the term and year need to be dynamic, check with vincent
            while (rs2.next()) {
           
                DataWhatDoing auxData = new DataWhatDoing();
                auxData.setIdObjective(rs2.getString("objective_id")); // idobjective
                auxData.setObjectivesSuccess("0"); //numSteps
                auxData.setIdSubject("" + rs2.getInt("subject_id"));

                arrayFuture.add(auxData);
            }

        } catch (SQLException ex) {
            System.out.println("Error leyendo Subjects: " + ex);
            StringWriter errors = new StringWriter();
            ex.printStackTrace(new PrintWriter(errors));
        }

        json.put("arrayAttempted", new Gson().toJson(arrayAttemp));
        json.put("arrayMastered", new Gson().toJson(arrayMastered));
        json.put("arrayFuture", new Gson().toJson(arrayFuture));

        return json.toString();

    }

    private HashMap<String, String> getfinalrating(String id) throws SQLException {
        HashMap<String, String> result = new HashMap<>();
        try {
            ResultSet rs1 = DBConect.eduweb.executeQuery("SELECT rating.name,student_id,objective_id FROM rating inner join (select rating_id,student_id,objective_id from progress_report a where comment_date = (select max(comment_date) from progress_report \n"
                    + "                                                        where student_id = " + id + " AND objective_id =a.objective_id and rating_id not in(6,7))) c ON id = c.rating_id");
            while (rs1.next()) {
                result.put(rs1.getInt("student_id") + "_" + rs1.getInt("objective_id"), rs1.getString("name"));
            }
        } catch (SQLException ex) {
            System.out.println("Error: " + ex);
            StringWriter errors = new StringWriter();
            ex.printStackTrace(new PrintWriter(errors));
        }
        return result;
    }

    public ModelAndView save(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        ModelAndView mv = new ModelAndView("suhomepage");
        String qbdburl = hsr.getParameter("qbdburl");
        String rwdburl = hsr.getParameter("rwdburl");
        String edudburl = hsr.getParameter("edudburl");
        String qbdbuser = hsr.getParameter("qbdbuser");
        String qbdbpswd = hsr.getParameter("qbdbpswd");
        String rwdbuser = hsr.getParameter("rwdbuser");
        String rwdbpswd = hsr.getParameter("rwdbpswd");
        String edudbuser = hsr.getParameter("edudbuser");
        String edudbpswd = hsr.getParameter("edudbpswd");
        String startdate = hsr.getParameter("startdate");
        String itemname = hsr.getParameter("itemname");
        DriverManagerDataSource dataSource;

        dataSource = (DriverManagerDataSource) this.getBean("dataSourceEDU", hsr.getServletContext());
        this.cn = dataSource.getConnection();
        Statement ps = this.cn.createStatement(1004, 1007);
        ResultSet rs = ps.executeQuery("select * from syncconfig");

        if (rs.next()) {
            int id = rs.getInt("id");
            ps.executeUpdate("update syncconfig set qbdburl ='" + qbdburl + "',qbdbuser ='" + qbdbuser + "',qbdbpswd = '" + qbdbpswd + "',edudburl = '" + edudburl + "',edudbuser= '" + edudbuser + "',edudbpswd= '" + edudbpswd + "',rwdburl= '" + rwdburl + "', rwdbuser = '" + rwdbuser + "',rwdbpswd = '" + rwdbpswd + "',startdate ='" + startdate + "',itemname='" + itemname + "' where id= " + id);
        } else {
            ps.executeUpdate("insert into syncconfig(qbdburl,qbdbuser,qbdbpswd,edudburl,edudbuser,edudbpswd,rwdburl,rwdbuser,rwdbpswd,startdate,itemname) values ('" + qbdburl + "','" + qbdbuser + "','" + qbdbpswd + "','" + edudburl + "','" + edudbuser + "','" + edudbpswd + "','" + rwdburl + "','" + rwdbuser + "','" + rwdbpswd + "','" + startdate + "','" + itemname + "')");
        }

        String message = "Configuration setting saved";
        mv.addObject("message1", message);
        return mv;

    }

    public ModelAndView runsync(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        ModelAndView mv
                = new ModelAndView("suhomepage");

        Config config = new Config();
        GetConfig get = new GetConfig();
        config = get.getConfig();

        if (config.getQbdburl() != null && config.getQbdbuser() != null && config.getQbdbpswd() != null & config.getRwdburl() != null && config.getRwdbuser() != null && config.getRwdbpswd() != null && config.getEdudburl() != null && config.getEdudbuser() != null && config.getEdudbpswd() != null && config.getStartdate() != null && config.getItemname() != null) {
            Runsync s = new Runsync();
            s.runsync(config);

            mv.addObject("message1", "QuickBooks synchronized");
        } else {
            mv.addObject("message1", "A configuration setting is missing");

        }
        return mv;

    }

    public ModelAndView map(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        ModelAndView mv = new ModelAndView("familymap2");
        Getcusts l = new Getcusts();
        List<QBCustomer> allcustomer = new ArrayList<>();
        Config config = new Config();
        GetConfig get = new GetConfig();
        config = get.getConfig();
        allcustomer = l.getCustomer();
        List<RWFamily> allfamily = new ArrayList<>();
        allfamily = l.getFamily();
        mv.addObject("allcustomer", allcustomer);
        mv.addObject("allfamily", allfamily);

        return mv;

    }

    public ModelAndView custsync(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        ModelAndView mv = new ModelAndView("suhomepage");

        Config config = new Config();
        GetConfig get = new GetConfig();
        config = get.getConfig();

        CustomerSync s = new CustomerSync();
        s.customersync(config);

        mv.addObject("message1", "QuickBooks Customers synchronized");
        return mv;

    }

    public ModelAndView paysync(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        ModelAndView mv = new ModelAndView("suhomepage");

        Config config = new Config();
        GetConfig get = new GetConfig();
        config = get.getConfig();

        PaymentSync s = new PaymentSync();
        s.paymentsync(config);

        mv.addObject("message1", "QuickBooks Payments synchronized");
        return mv;

    }

    public ModelAndView invoicesync(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        ModelAndView mv = new ModelAndView("suhomepage");
        Config config = new Config();
        GetConfig get = new GetConfig();
        config = get.getConfig();

        InvoiceSync s = new InvoiceSync();
        s.invoicesync(config);

        mv.addObject("message1", "QuickBooks Invoices synchronized");
        return mv;

    }

    public ModelAndView loadconfig(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        ModelAndView mv
                = new ModelAndView("suhomepage");
        DriverManagerDataSource dataSource;
        dataSource = (DriverManagerDataSource) this.getBean("dataSourceEDU", hsr.getServletContext());
        this.cn = dataSource.getConnection();
        Statement ps = this.cn.createStatement(1004, 1007);
        ResultSet rs = ps.executeQuery("Select * from syncconfig");

        Config config = new Config();
        while (rs.next()) {
            config.setQbdburl(rs.getString("qbdburl"));
            config.setQbdbuser(rs.getString("qbdbuser"));
            config.setQbdbpswd(rs.getString("qbdbpswd"));
            config.setRwdburl(rs.getString("rwdburl"));
            config.setRwdbuser(rs.getString("rwdbuser"));
            config.setRwdbpswd(rs.getString("rwdbpswd"));
            config.setEdudburl(rs.getString("edudburl"));
            config.setEdudbuser(rs.getString("edudbuser"));
            config.setEdudbpswd(rs.getString("edudbpswd"));
            config.setStartdate(rs.getDate("startdate").toString());
            config.setItemname(rs.getString("itemname"));
        }
        int checkpoint = 0;
        if (config.getQbdburl() != null && config.getQbdbuser() != null && config.getQbdbpswd() != null & config.getRwdburl() != null && config.getRwdbuser() != null && config.getRwdbpswd() != null && config.getEdudburl() != null && config.getEdudbuser() != null && config.getEdudbpswd() != null && config.getStartdate() != null && config.getItemname() != null) {
            checkpoint = 1;
        }

        mv.addObject("config", config);
        mv.addObject("check", checkpoint);
        return mv;

    }

    public String getImage(HttpServletRequest request, HttpServletResponse response, String idComment) throws Exception {
        String obsid = idComment;
        String server = "192.168.1.36";
        int port = 21;
        String user = "david";
        String pass = "david";

        String filePath = "/MontessoriObservations/" + obsid + "/";
        FTPClient ftpClient = new FTPClient();
        ftpClient.connect(server, port);
        ftpClient.login(user, pass);
        ftpClient.setFileType(FTP.BINARY_FILE_TYPE);

        if (ftpClient.changeWorkingDirectory(filePath)) {
            JSONObject json = new JSONObject();
            String s[] = ftpClient.listNames();
            filePath = s[0];
            InputStream inStream = ftpClient.retrieveFileStream(s[0]);
            // obtains ServletContext
            ServletContext context = request.getServletContext();
            String appPath = context.getRealPath("");
            System.out.println("appPath = " + appPath);

            // gets MIME type of the file
            String mimeType = context.getMimeType(filePath);
            if (mimeType == null) {
                // set to binary type if MIME mapping not found
                mimeType = "application/octet-stream";
            }

            //
            /*  
           
             */
            //inStream.reset();
            ByteArrayOutputStream buffer = new ByteArrayOutputStream();
            int nRead;
            byte[] data = new byte[1024];
            while ((nRead = inStream.read(data, 0, data.length)) != -1) {
                buffer.write(data, 0, nRead);
            }

            buffer.flush();
            byte[] buf = buffer.toByteArray();

            //
            // byte[] buf = new byte[inStream.available()];
            InputStream AuxIn = new ByteArrayInputStream(buf);

            BufferedImage auxImg = ImageIO.read(AuxIn);
            int width = auxImg.getWidth();
            int height = auxImg.getHeight();

            inStream.read(buf);
            String imagen = Base64.getEncoder().encodeToString(buf);
            json.put("imagen", imagen);
            json.put("ext", mimeType);
            json.put("naturalHeight", height);
            json.put("naturalWidth", width);
            ftpClient.disconnect();
            return json.toString();
        }
        ftpClient.disconnect();
        //response.sendRedirect(request.getContextPath());
        return "";
    }

    public String getImageTeacher(HttpServletRequest request, HttpServletResponse response, String teacherPath) throws Exception {
        try {
            /*URL url = new URL("ftp://AH-ZAF:e3f14+7mANDp@ftp2.renweb.com/Pictures/" + photoName);
            URLConnection conn = url.openConnection();
            InputStream inStream = conn.getInputStream();*/
            //***********

            String server = "192.168.1.36";
            int port = 21;
            String user = "david";
            String pass = "david";

            JSONObject json = new JSONObject();

            String filepath = "/Pictures/" + teacherPath;
            FTPClient ftpClient = new FTPClient();
            ftpClient.connect(server, port);
            ftpClient.login(user, pass);
            ftpClient.setFileType(FTP.BINARY_FILE_TYPE);
            //LIMITAR NO EXISTE

            InputStream inStream = ftpClient.retrieveFileStream(filepath);
            if (inStream != null) {
                // gets MIME type of the file
                String mimeType = "";
                //String filepath = url.getPath();
                int i = filepath.length() - 1;
                while (filepath.charAt(i) != '.') {
                    mimeType = filepath.charAt(i) + mimeType;
                    i--;
                }
                mimeType = '.' + mimeType;

                //
                ByteArrayOutputStream buffer = new ByteArrayOutputStream();
                int nRead;
                byte[] data = new byte[1024];
                while ((nRead = inStream.read(data, 0, data.length)) != -1) {
                    buffer.write(data, 0, nRead);
                }

                buffer.flush();
                byte[] buf = buffer.toByteArray();
                //
                // byte[] buf = new byte[inStream.available()];
                inStream.read(buf);
                String imagen = Base64.getEncoder().encodeToString(buf);
                json.put("imagen", imagen);
                json.put("ext", mimeType);
                ftpClient.disconnect();
                return json.toString();
                //**********
            }
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return "";
    }
}
