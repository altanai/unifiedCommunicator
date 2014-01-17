package com.tcs.billmanagement.controller;

import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;

import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import com.tcs.billmanagement.bean.Bill;
import com.tcs.billmanagement.bean.BillInvoice;
import com.tcs.billmanagement.bean.Customer;
import com.tcs.billmanagement.bean.Order;
import com.tcs.billmanagement.dao.BillDAO;
import com.tcs.billmanagement.dao.CustomerDAO;

/**
 * Servlet implementation class PDFGenerator
 */
public class PDFGenerator extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	public static String file="billInvoice.pdf";
	public static String file1="billDetails.pdf";
	public static String file2="customerDetails.pdf";
	private static Font titlefont=new Font(Font.FontFamily.TIMES_ROMAN,20,Font.BOLD,BaseColor.GRAY);
	private static Font subfont=new Font(Font.FontFamily.TIMES_ROMAN,12,Font.NORMAL);
	private static Font titlefont1=new Font(Font.FontFamily.TIMES_ROMAN,16,Font.BOLD,BaseColor.GRAY);
	
	
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PDFGenerator() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		System.out.println("Inside PDF generation Servlet");
		if("billInvoicePDF".equalsIgnoreCase(request.getParameter("action")))
		{
			String orderId=request.getParameter("order");
			String billId=request.getParameter("bill");
			BillInvoice invoice=null;
			BillDAO dao=new BillDAO();
			try {
				invoice=dao.getDetailsForInvoice(orderId,billId);
			}
			catch (ClassNotFoundException e1) 
			{
				e1.printStackTrace();
			} catch (SQLException e1)
			{
				e1.printStackTrace();
			}
			try
			{
				Document doc=new Document();
				System.out.println("Creating doc");
				//PdfWriter.getInstance(doc, new FileOutputStream(file));
				PdfWriter.getInstance(doc, response.getOutputStream());
				response.setHeader("Content-Disposition", "attachment; filename=\"" +file+ "\"");
				doc.open();
				addContentBillInvoice(doc,invoice);
				doc.close();
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
			
			
		}
		if("customerPDF".equalsIgnoreCase(request.getParameter("action")))
		{
			ArrayList<Customer> customerList=null;
			CustomerDAO dao=new CustomerDAO();
			try 
			{
				customerList=dao.getNewDetailsOfCustomer();
			} 
			catch (ClassNotFoundException e) 
			{
				e.printStackTrace();
			} 
			catch (SQLException e) 
			{
				e.printStackTrace();
			}
			try
			{
				Document doc=new Document();
				System.out.println("Creating doc");
				//PdfWriter.getInstance(doc, new FileOutputStream(file2));
				PdfWriter.getInstance(doc, response.getOutputStream());
				response.setHeader("Content-Disposition", "attachment; filename=\"" +file2+ "\"");
				doc.open();
				addContentCustomer(doc,customerList);
				doc.close();
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
			
		}
		if("billPDF".equalsIgnoreCase(request.getParameter("action")))
		{
			ArrayList<Bill> billList=null;
			BillDAO dao=new BillDAO();
			try 
			{
				billList=dao.getAllBills();
			}
			catch (ClassNotFoundException e) 
			{
				e.printStackTrace();
			} 
			catch (SQLException e) 
			{
				e.printStackTrace();
			}
			try
			{
				Document doc=new Document();
				System.out.println("Creating doc");
				//PdfWriter.getInstance(doc, new FileOutputStream(file1));
				PdfWriter.getInstance(doc, response.getOutputStream());
				response.setHeader("Content-Disposition", "attachment; filename=\"" +file1+ "\"");
				doc.open();
				addContentBill(doc,billList);
				doc.close();
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
		}
	}
	
	//CODE FOR PDF OF ALL BILLS
	private void addContentBill(Document doc,ArrayList<Bill> billList) throws DocumentException
	{
		SimpleDateFormat df=new SimpleDateFormat("d-MMM-yyyy");
		Paragraph content=new Paragraph("Bills",titlefont);
		content.setAlignment(Element.ALIGN_CENTER);
		addEmptyLine(content, 1);
		content.add(new Paragraph("List of all the bills generated:",subfont));
		
		content.setIndentationLeft((float) 0.0);
		addEmptyLine(content, 1);
		doc.add(content);
		
		PdfPTable table = new PdfPTable(6);
		table.setWidthPercentage(100);
		table.setHorizontalAlignment(Element.ALIGN_CENTER);

		PdfPCell c1 = new PdfPCell(new Phrase("Bill Id",FontFactory.getFont(FontFactory.TIMES_BOLD, 12)));
	    c1.setHorizontalAlignment(Element.ALIGN_CENTER);
	    c1.setBackgroundColor(BaseColor.LIGHT_GRAY);
	    c1.setVerticalAlignment(Element.ALIGN_MIDDLE);
	    c1.setFixedHeight((float) 30.0);
	    table.addCell(c1);

	    c1 = new PdfPCell(new Phrase("OrderId",FontFactory.getFont(FontFactory.TIMES_BOLD, 12)));
	    c1.setHorizontalAlignment(Element.ALIGN_CENTER);
	    c1.setBackgroundColor(BaseColor.LIGHT_GRAY);
	    c1.setVerticalAlignment(Element.ALIGN_MIDDLE);
	    c1.setFixedHeight((float) 30.0);
	    table.addCell(c1);

	    c1 = new PdfPCell(new Phrase("ServiceProvider",FontFactory.getFont(FontFactory.TIMES_BOLD, 12)));
	    c1.setHorizontalAlignment(Element.ALIGN_CENTER);
	    c1.setBackgroundColor(BaseColor.LIGHT_GRAY);
	    c1.setVerticalAlignment(Element.ALIGN_MIDDLE);
	    c1.setFixedHeight((float) 30.0);
	    table.addCell(c1);


	    c1 = new PdfPCell(new Phrase("Generation Date",FontFactory.getFont(FontFactory.TIMES_BOLD, 12)));
	    c1.setHorizontalAlignment(Element.ALIGN_CENTER);
	    c1.setBackgroundColor(BaseColor.LIGHT_GRAY);
	    c1.setVerticalAlignment(Element.ALIGN_MIDDLE);
	    c1.setFixedHeight((float) 30.0);
	    table.addCell(c1);
	    
	    c1 = new PdfPCell(new Phrase("Amount(INR)",FontFactory.getFont(FontFactory.TIMES_BOLD, 12)));
	    c1.setHorizontalAlignment(Element.ALIGN_CENTER);
	    c1.setBackgroundColor(BaseColor.LIGHT_GRAY);
	    c1.setVerticalAlignment(Element.ALIGN_MIDDLE);
	    c1.setFixedHeight((float) 30.0);
	    table.addCell(c1);

	    c1 = new PdfPCell(new Phrase("Payment Status",FontFactory.getFont(FontFactory.TIMES_BOLD, 12)));
	    c1.setHorizontalAlignment(Element.ALIGN_CENTER);
	    c1.setBackgroundColor(BaseColor.LIGHT_GRAY);
	    c1.setVerticalAlignment(Element.ALIGN_MIDDLE);
	    c1.setFixedHeight((float) 30.0);
	    table.addCell(c1);
	    
	    table.setHeaderRows(1);
	    for(Bill bill:billList)
	    {	
	    	PdfPCell c2 = new PdfPCell(new Phrase(bill.getBillId(),FontFactory.getFont(FontFactory.TIMES_ROMAN,12)));
	    	c2.setHorizontalAlignment(Element.ALIGN_CENTER);
	    	table.addCell(c2);
	    	c2=new PdfPCell(new Phrase(bill.getOrderId(),FontFactory.getFont(FontFactory.TIMES_ROMAN,12)));
	    	c2.setHorizontalAlignment(Element.ALIGN_CENTER);
	    	table.addCell(c2);
	    	c2=new PdfPCell(new Phrase(bill.getServiceProvider(),FontFactory.getFont(FontFactory.TIMES_ROMAN,12)));
	    	c2.setHorizontalAlignment(Element.ALIGN_CENTER);
	    	table.addCell(c2);
	    	c2=new PdfPCell(new Phrase(df.format(bill.getGenerationDate()),FontFactory.getFont(FontFactory.TIMES_ROMAN,12)));
	    	c2.setHorizontalAlignment(Element.ALIGN_CENTER);
	    	table.addCell(c2);
	    	c2=new PdfPCell(new Phrase(Double.toString(bill.getAmount()),FontFactory.getFont(FontFactory.TIMES_ROMAN,12)));
	    	c2.setHorizontalAlignment(Element.ALIGN_CENTER);
	    	table.addCell(c2);
	    	c2=new PdfPCell(new Phrase(bill.getPaymentStatus(),FontFactory.getFont(FontFactory.TIMES_ROMAN,12)));
	    	c2.setHorizontalAlignment(Element.ALIGN_CENTER);
	    	table.addCell(c2);
	    	/*if(bill.getPaymentDate()==null)
	    	{
	    		table.addCell("---");
	    	}
	    	else
	    	{
	    		c2=new PdfPCell(new Phrase(bill.getPaymentDate().toString()));
	    		c2.setHorizontalAlignment(Element.ALIGN_CENTER);
		    	table.addCell(c2);
	    	}
	    	if(bill.getTransactionId()==null) table.addCell("---");
	    	else{
	    		c2=new PdfPCell(new Phrase(bill.getTransactionId()));
	    		c2.setHorizontalAlignment(Element.ALIGN_CENTER);
	    		table.addCell(c2);
	    		}*/
	    }
	    doc.add(table);
	}
	
	//CODE FOR PDF OF ALL CUSTOMERS
	private void addContentCustomer(Document doc,ArrayList<Customer> cList) throws DocumentException
	{
		Paragraph content=new Paragraph("Customers",titlefont);
		content.setAlignment(Element.ALIGN_CENTER);
		addEmptyLine(content, 1);
		content.add(new Paragraph("List of all Customers",subfont));
		addEmptyLine(content, 1);
		doc.add(content);
		
		PdfPTable table = new PdfPTable(3);
		table.setWidthPercentage(100);
		table.setHorizontalAlignment(Element.ALIGN_CENTER);
		

		PdfPCell c1 = new PdfPCell(new Phrase("CustomerId",FontFactory.getFont(FontFactory.TIMES_BOLD, 12)));
	    c1.setHorizontalAlignment(Element.ALIGN_CENTER);
	    c1.setBackgroundColor(BaseColor.LIGHT_GRAY);
	    c1.setVerticalAlignment(Element.ALIGN_MIDDLE);
	    c1.setFixedHeight((float) 30.0);
	    table.addCell(c1);

	    c1 = new PdfPCell(new Phrase("Customer Name",FontFactory.getFont(FontFactory.TIMES_BOLD, 12)));
	    c1.setHorizontalAlignment(Element.ALIGN_CENTER);
	    c1.setBackgroundColor(BaseColor.LIGHT_GRAY);
	    c1.setVerticalAlignment(Element.ALIGN_MIDDLE);
	    c1.setFixedHeight((float) 30.0);
	    table.addCell(c1);

	    c1 = new PdfPCell(new Phrase("Address",FontFactory.getFont(FontFactory.TIMES_BOLD, 12)));
	    c1.setHorizontalAlignment(Element.ALIGN_CENTER);
	    c1.setBackgroundColor(BaseColor.LIGHT_GRAY);
	    c1.setVerticalAlignment(Element.ALIGN_MIDDLE);
	    c1.setFixedHeight((float) 30.0);
	    table.addCell(c1);
	    
	    float[] columnWidths = new float[] {25f, 35f, 90f};
        table.setWidths(columnWidths);
	    
	    table.setHeaderRows(1);
	    
	    for(Customer cust:cList)
	    {
	    	PdfPCell c2 = new PdfPCell(new Phrase(cust.getCustomerId(),FontFactory.getFont(FontFactory.TIMES_ROMAN,10)));
	    	c2.setHorizontalAlignment(Element.ALIGN_CENTER);
	    	table.addCell(c2);

	    	c2 = new PdfPCell(new Phrase(cust.getName(),FontFactory.getFont(FontFactory.TIMES_ROMAN,10)));
	    	c2.setHorizontalAlignment(Element.ALIGN_CENTER);
	    	table.addCell(c2);
	    	
	    	c2 = new PdfPCell(new Phrase(cust.getAddress(),FontFactory.getFont(FontFactory.TIMES_ROMAN,10)));
	    	table.addCell(c2);
	
	    }
	    doc.add(table);
		
	}
	
	//CODE FOR PDF OF BILL INVOICE
	private void addContentBillInvoice(Document doc,BillInvoice invoice) throws DocumentException
	{
		double a1,a2,a3,a4;
		a1=Double.parseDouble(invoice.getOrderDetails().getSinglePrepaid())*10.0;
		a2=Double.parseDouble(invoice.getOrderDetails().getSinglePostpaid())*10.0;
		a3=Double.parseDouble(invoice.getOrderDetails().getDualPrepaid())*10.0;
		a4=Double.parseDouble(invoice.getOrderDetails().getDualPostpaid())*10.0;
		
		SimpleDateFormat df=new SimpleDateFormat("d-MMM-yyyy");
		System.out.println("Creating Invoice");
		Paragraph headcontent = new Paragraph("SP Limited\nSIMS Building, Technopark, Trivandrum, Kerala\n-------------------------------------------------------------------------------------------------------------------------------------------------------------------\n",FontFactory.getFont(
				FontFactory.TIMES_ROMAN,12,Font.BOLD));
		headcontent.setAlignment(Element.ALIGN_CENTER);
		addEmptyLine(headcontent, 1);
		doc.add(headcontent);
		
		Paragraph content2 = new Paragraph("Toll Free Number: 1800 1234 5698\nMobile: +91 9847493938 \nEmail: sp_pvt@global.in",FontFactory.getFont(
				FontFactory.TIMES_ROMAN, 8));
		content2.setAlignment(Element.ALIGN_RIGHT);
		
		addEmptyLine(content2, 1);
		doc.add(content2);
		
		
		Paragraph content=new Paragraph("Bill Invoice",titlefont1);
		content.setAlignment(Element.ALIGN_CENTER);
		addEmptyLine(content, 2);
	/*	content.add(new Paragraph("Bill details",subfont));
		content.setIndentationLeft((float) 55.0);
		addEmptyLine(content, 1);*/
		doc.add(content);
		
		PdfPTable table = new PdfPTable(5);
		table.setWidthPercentage(100);
		table.setHorizontalAlignment(Element.ALIGN_CENTER);
		
		PdfPCell c1 = new PdfPCell(new Phrase("Service Provider:"+invoice.getServiceProviderName(),FontFactory.getFont(FontFactory.TIMES_BOLD, 12)));
		c1.setRowspan(2);
		table.addCell(c1);
		c1=new PdfPCell(new Phrase("BillId:",FontFactory.getFont(FontFactory.TIMES_BOLD, 10)));
		table.addCell(c1);
		c1=new PdfPCell(new Phrase(invoice.getBillDetails().getBillId(),FontFactory.getFont(FontFactory.TIMES_ROMAN,12)));
		table.addCell(c1);
		c1=new PdfPCell(new Phrase("Bill Date:",FontFactory.getFont(FontFactory.TIMES_BOLD, 10)));
		table.addCell(c1);
		c1=new PdfPCell(new Phrase(df.format(invoice.getBillDetails().getGenerationDate()),FontFactory.getFont(FontFactory.TIMES_ROMAN,12)));
		table.addCell(c1);
		c1=new PdfPCell(new Phrase("OrderId:",FontFactory.getFont(FontFactory.TIMES_BOLD, 10)));
		table.addCell(c1);
		c1=new PdfPCell(new Phrase(invoice.getOrderDetails().getOrderId(),FontFactory.getFont(FontFactory.TIMES_ROMAN,12)));
		table.addCell(c1);
		c1=new PdfPCell(new Phrase("Order Date:",FontFactory.getFont(FontFactory.TIMES_BOLD, 10)));
		table.addCell(c1);
		c1=new PdfPCell(new Phrase(df.format(invoice.getOrderDetails().getOrderDate()),FontFactory.getFont(FontFactory.TIMES_ROMAN,12)));
		table.addCell(c1);
		
		float[] columnWidths = new float[] {50f, 20f, 20f, 20f,22f};
          table.setWidths(columnWidths);

		doc.add(table);
		System.out.println("added table1");
		
		PdfPTable table2 = new PdfPTable(5);
		table2.setWidthPercentage(100);
		table2.setHorizontalAlignment(Element.ALIGN_CENTER);
		

		PdfPCell c2 = new PdfPCell(new Phrase("S.No.",FontFactory.getFont(FontFactory.TIMES_BOLD, 12)));
	    c2.setHorizontalAlignment(Element.ALIGN_CENTER);
	    c2.setBackgroundColor(BaseColor.LIGHT_GRAY);
	    c2.setVerticalAlignment(Element.ALIGN_MIDDLE);
	    table2.addCell(c2);

	    c2 = new PdfPCell(new Phrase("Description",FontFactory.getFont(FontFactory.TIMES_BOLD, 12)));
	    c2.setHorizontalAlignment(Element.ALIGN_CENTER);
	    c2.setBackgroundColor(BaseColor.LIGHT_GRAY);
	    c2.setVerticalAlignment(Element.ALIGN_MIDDLE);
	    table2.addCell(c2);

	    c2 = new PdfPCell(new Phrase("Quatity",FontFactory.getFont(FontFactory.TIMES_BOLD, 12)));
	    c2.setHorizontalAlignment(Element.ALIGN_CENTER);
	    c2.setBackgroundColor(BaseColor.LIGHT_GRAY);
	    c2.setVerticalAlignment(Element.ALIGN_MIDDLE);
	    table2.addCell(c2);
	    
	    c2 = new PdfPCell(new Phrase("Rate",FontFactory.getFont(FontFactory.TIMES_BOLD, 12)));
	    c2.setHorizontalAlignment(Element.ALIGN_CENTER);
	    c2.setBackgroundColor(BaseColor.LIGHT_GRAY);
	    c2.setVerticalAlignment(Element.ALIGN_MIDDLE);
	    table2.addCell(c2);
	    
	    c2 = new PdfPCell(new Phrase("Amount(INR)",FontFactory.getFont(FontFactory.TIMES_BOLD, 12)));
	    c2.setHorizontalAlignment(Element.ALIGN_CENTER);
	    c2.setBackgroundColor(BaseColor.LIGHT_GRAY);
	    c2.setVerticalAlignment(Element.ALIGN_MIDDLE);
	    table2.addCell(c2);
		
	    float[] columnWidth2 = new float[] {10f, 60f, 20f, 20f,22f};
        table2.setWidths(columnWidth2);
	    table2.setHeaderRows(1);
	    
	    c2=new PdfPCell(new Phrase("1",FontFactory.getFont(FontFactory.TIMES_ROMAN,12)));
	    c2.setFixedHeight((float) 25.0);
		table2.addCell(c2);
		c2=new PdfPCell(new Phrase("Single-Prepaid",FontFactory.getFont(FontFactory.TIMES_ROMAN,12)));
		c2.setFixedHeight((float) 25.0);
		table2.addCell(c2);
		c2=new PdfPCell(new Phrase(invoice.getOrderDetails().getSinglePrepaid(),FontFactory.getFont(FontFactory.TIMES_ROMAN,12)));
		c2.setFixedHeight((float) 25.0);
		c2.setHorizontalAlignment(Element.ALIGN_MIDDLE);
		table2.addCell(c2);
		c2=new PdfPCell(new Phrase("10.0",FontFactory.getFont(FontFactory.TIMES_ROMAN,12)));
		c2.setFixedHeight((float) 25.0);
		c2.setHorizontalAlignment(Element.ALIGN_MIDDLE);
		table2.addCell(c2);
		c2=new PdfPCell(new Phrase(Double.toString(a1),FontFactory.getFont(FontFactory.TIMES_ROMAN,12)));
		c2.setFixedHeight((float) 25.0);
		c2.setHorizontalAlignment(Element.ALIGN_MIDDLE);
		table2.addCell(c2);

	    c2=new PdfPCell(new Phrase("2",FontFactory.getFont(FontFactory.TIMES_ROMAN,12)));
	    c2.setFixedHeight((float) 25.0);
		table2.addCell(c2);
		c2=new PdfPCell(new Phrase("Single-Postpaid",FontFactory.getFont(FontFactory.TIMES_ROMAN,12)));
		c2.setFixedHeight((float) 25.0);
		table2.addCell(c2);
		c2=new PdfPCell(new Phrase(invoice.getOrderDetails().getSinglePrepaid(),FontFactory.getFont(FontFactory.TIMES_ROMAN,12)));
		c2.setFixedHeight((float) 25.0);
		c2.setHorizontalAlignment(Element.ALIGN_MIDDLE);
		table2.addCell(c2);
		c2=new PdfPCell(new Phrase("10.0",FontFactory.getFont(FontFactory.TIMES_ROMAN,12)));
		c2.setFixedHeight((float) 25.0);
		c2.setHorizontalAlignment(Element.ALIGN_MIDDLE);
		table2.addCell(c2);
		c2=new PdfPCell(new Phrase(Double.toString(a2),FontFactory.getFont(FontFactory.TIMES_ROMAN,12)));
		c2.setFixedHeight((float) 25.0);
		c2.setHorizontalAlignment(Element.ALIGN_MIDDLE);
		table2.addCell(c2);


	    c2=new PdfPCell(new Phrase("3",FontFactory.getFont(FontFactory.TIMES_ROMAN,12)));
	    c2.setFixedHeight((float) 25.0);
		table2.addCell(c2);
		c2=new PdfPCell(new Phrase("Dual-Prepaid",FontFactory.getFont(FontFactory.TIMES_ROMAN,12)));
		c2.setFixedHeight((float) 25.0);
		table2.addCell(c2);
		c2=new PdfPCell(new Phrase(invoice.getOrderDetails().getDualPrepaid(),FontFactory.getFont(FontFactory.TIMES_ROMAN, 12)));
		c2.setFixedHeight((float) 25.0);
		c2.setHorizontalAlignment(Element.ALIGN_MIDDLE);
		table2.addCell(c2);
		c2=new PdfPCell(new Phrase("10.0",FontFactory.getFont(FontFactory.TIMES_ROMAN,12)));
		c2.setFixedHeight((float) 25.0);
		c2.setHorizontalAlignment(Element.ALIGN_MIDDLE);
		table2.addCell(c2);
		c2=new PdfPCell(new Phrase(Double.toString(a3),FontFactory.getFont(FontFactory.TIMES_ROMAN,12)));
		c2.setFixedHeight((float) 25.0);
		c2.setHorizontalAlignment(Element.ALIGN_MIDDLE);
		table2.addCell(c2);


	    c2=new PdfPCell(new Phrase("4",FontFactory.getFont(FontFactory.TIMES_ROMAN,12)));
	    c2.setFixedHeight((float) 25.0);
		table2.addCell(c2);
		c2=new PdfPCell(new Phrase("Dual-Postpaid",FontFactory.getFont(FontFactory.TIMES_ROMAN,12)));
		c2.setFixedHeight((float) 25.0);
		table2.addCell(c2);
		c2=new PdfPCell(new Phrase(invoice.getOrderDetails().getDualPostpaid(),FontFactory.getFont(FontFactory.TIMES_ROMAN,12)));
		c2.setFixedHeight((float) 25.0);
		c2.setHorizontalAlignment(Element.ALIGN_MIDDLE);
		table2.addCell(c2);
		c2=new PdfPCell(new Phrase("10.0",FontFactory.getFont(FontFactory.TIMES_ROMAN,12)));
		c2.setFixedHeight((float) 25.0);
		c2.setHorizontalAlignment(Element.ALIGN_MIDDLE);
		table2.addCell(c2);
		c2=new PdfPCell(new Phrase(Double.toString(a4),FontFactory.getFont(FontFactory.TIMES_ROMAN,12)));
		c2.setFixedHeight((float) 25.0);
		c2.setHorizontalAlignment(Element.ALIGN_MIDDLE);
		table2.addCell(c2);
		
	    doc.add(table2);
	    System.out.println("added table2");
	    
	    PdfPTable table3 = new PdfPTable(3);
		table3.setWidthPercentage(100);
		table3.setHorizontalAlignment(Element.ALIGN_CENTER);
	    
		PdfPCell c3 = new PdfPCell(new Phrase(""));
	    c3.setHorizontalAlignment(Element.ALIGN_CENTER);
	    c3.setVerticalAlignment(Element.ALIGN_MIDDLE);
	    table3.addCell(c3);

	    c3 = new PdfPCell(new Phrase("Sub-total",FontFactory.getFont(FontFactory.TIMES_BOLD, 10)));
	//    c3.setHorizontalAlignment(Element.ALIGN_CENTER);
	    c3.setVerticalAlignment(Element.ALIGN_MIDDLE);
	    table3.addCell(c3);

	    c3 = new PdfPCell(new Phrase(Double.toString(invoice.getBillDetails().getAmount()),FontFactory.getFont(FontFactory.TIMES_ROMAN,12)));
				
	   // c3.setHorizontalAlignment(Element.ALIGN_CENTER);
	    c3.setVerticalAlignment(Element.ALIGN_MIDDLE);
	    table3.addCell(c3);
	    
	    float[] columnWidth3 = new float[] {90f, 20f, 22f,};
        table3.setWidths(columnWidth3);
        
        c3=new PdfPCell(new Phrase("Terms and conditions:",FontFactory.getFont(FontFactory.TIMES_BOLD, 10)));
		table3.addCell(c3);
		c3=new PdfPCell(new Phrase("Transportation:",FontFactory.getFont(FontFactory.TIMES_BOLD, 10)));
		table3.addCell(c3);
		c3=new PdfPCell(new Phrase("---"));
		table3.addCell(c3);
		
		c3 = new PdfPCell(new Phrase(
				"1). Payment must be done within 7 days from date of bill:",FontFactory.getFont(FontFactory.TIMES_ROMAN,10)));
		table3.addCell(c3);
		c3 = new PdfPCell(new Phrase("Penalty:",FontFactory.getFont(FontFactory.TIMES_BOLD, 10)));
		table3.addCell(c3);
		c3 = new PdfPCell(new Phrase("---"));
		table3.addCell(c3);

		c3 = new PdfPCell(new Phrase(
				"2). 2% interest will be charged if payment is delayed:",FontFactory.getFont(FontFactory.TIMES_ROMAN,10)));
		table3.addCell(c3);
		c3 = new PdfPCell(new Phrase("Grand-Total:",FontFactory.getFont(FontFactory.TIMES_BOLD, 10)));
		table3.addCell(c3);
		c3 = new PdfPCell(new Phrase(Double.toString(invoice.getBillDetails()
				.getAmount()),FontFactory.getFont(FontFactory.TIMES_ROMAN,12)));
		table3.addCell(c3);
		
		doc.add(table3);
		
		System.out.println("added table3");
		Paragraph foot=new Paragraph("");
		addEmptyLine(foot, 1);
		doc.add(foot);
		
		Paragraph footer=new Paragraph("*Goods once sold shall not be exchanged or returned",FontFactory.getFont(FontFactory.TIMES_ROMAN,8));
		doc.add(footer);
		
	}
	
	private static void addEmptyLine(Paragraph paragraph, int number) 
	{
		System.out.println("adding spaces");
	    for (int i = 0; i < number; i++) 
	    {
	      paragraph.add(new Paragraph(" "));
	    }
	}
	  

}
