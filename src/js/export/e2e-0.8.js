/*!
 * Export to Excel v0.8
 * Author: ShareFeng
 * Date: Sun Oct 23 21:13:30 2011 +0800
 * http://code.google.com/p/export2excel
 * Depends:
 *	jquery 1.4+;
 *	Base64
 * Sample:
 * 	$('#table_id').e2e();
 *	$('#table_id').e2e({
 *		createDate : new Date(),
 *		sheetName : 'Sheet1',
 *		author : 'ShareFeng'
 *	});
 */
$.e2e = function(options){
	var defaults = {
		createDate : new Date(),
		sheetName : 'Sheet1',
		author : 'Cerb',
		byTdClass : false,
		//IEErrorMessage: '系统无权执行ActiveX控件\n需要将游览器安全级别\n===================\n工具 -> Internet 选项 -> 安全 -> \n自定义安全级别 -> ActiveX 控件与插件 ->\n对未标记为可安全执行脚本的ActiveX 控件初始化并执行\n=================\n设置为 -->提示<--'
		IEErrorMessage : 'System not entitled to execute ActiveX controls \n need to explore the security level is \n =================== \n Tools -> Internet Options -> Security -> \n custom security levels for ActiveX controls that are not marked as safe for scripting initialization and execution \n ================= \n set -> Tip <-'
	};
	this._s = $.extend(defaults, options);
	this._tableArray = new Array();
	this._ExpandedColumnCount = 0;
	this._ExpandedRowCount = 0;
	this._xml;
	this._oXL;
}
$.e2e.prototype = {
	_buildArray : function(_Table){
		var _tableArray = this._tableArray;
		var _ExpandedColumnCount = this._ExpandedColumnCount;
		var _ExpandedRowCount = this._ExpandedRowCount;
		var _trs = _Table.find("TR");
		_trs.each(function(i){
			_tableArray[i] = new Array();
		});
		var i = 0;
		var j = 0;
		_trs.each(function(){
			var _tds = $(this).find("TD");
			j = 0;
			_tds.each(function(){
				var _td = $(this);
				while(_tableArray[i][j] != null){
					j++;
				}
				_tableArray[i][j] = new Td(this,i,j);
				if(_td.attr("colspan")>1&&_td.attr("rowspan")>1){
					for(var t = 0;t<_td.attr("colspan");t++){
						for(var r = 0;r<_td.attr("rowspan");r++){
							if(t+r==0)continue;
							_tableArray[i+r][j+t] = new Td(null,i,j);
						}
					}
				}
				else if(_td.attr("colspan")>1){
					for(var t = 1;t<_td.attr("colspan");t++){
						_tableArray[i][j+t] = new Td(null,i,j);
					}
				}else if(_td.attr("rowspan")>1){
					for(var r = 1;r<_td.attr("rowspan");r++){
						_tableArray[i+r][j] = new Td(null,i,j);
					}
				}
				j++;
				_ExpandedColumnCount = (j > _ExpandedColumnCount)?j:_ExpandedColumnCount;
			});
			i++;
		});
		_ExpandedRowCount = i;
		this._ExpandedColumnCount = _ExpandedColumnCount;
		this._ExpandedRowCount = _ExpandedRowCount;
	},
	_buildXlsHead : function(_create_date){
		var d = (typeof this._s.createDate == 'string')?this._s.createDate:this._s.createDate.getFullYear()
			+'-'+(this._s.createDate.getMonth()+1)+'-'+this._s.createDate.getDate()
			+'T'+this._s.createDate.getHours()+':'+this._s.createDate.getMinutes()+':'+this._s.createDate.getSeconds()+'Z';
		_xml = '<xml version="1.0" encoding="utf-8">';
		_xml += '<?mso-application progid="Excel.Sheet"?>';
		_xml += '<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet"';
		_xml += ' xmlns:o="urn:schemas-microsoft-com:office:office"';
		_xml += ' xmlns:x="urn:schemas-microsoft-com:office:excel"';
		_xml += ' xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"';
		_xml += ' xmlns:html="http://www.w3.org/TR/REC-html40">';
		_xml += ' <DocumentProperties xmlns="urn:schemas-microsoft-com:office:office">';
		_xml += '  <Author>Cerb</Author>';
		_xml += '  <LastAuthor>Cerb</LastAuthor>';
		_xml += '  <Created>' + d + '</Created>';
		_xml += '  <Company>Microsoft</Company>';
		_xml += '  <Version>11.5606</Version>';
		_xml += ' </DocumentProperties>';
		_xml += ' <OfficeDocumentSettings xmlns="urn:schemas-microsoft-com:office:office">';
		_xml += '  <RemovePersonalInformation/>';
		_xml += ' </OfficeDocumentSettings>';
		_xml += ' <ExcelWorkbook xmlns="urn:schemas-microsoft-com:office:excel">';
		_xml += '  <WindowHeight>4530</WindowHeight>';
		_xml += '  <WindowWidth>8505</WindowWidth>';
		_xml += '  <WindowTopX>480</WindowTopX>';
		_xml += '  <WindowTopY>120</WindowTopY>';
		_xml += '  <AcceptLabelsInFormulas/>';
		_xml += '  <ProtectStructure>False</ProtectStructure>';
		_xml += '  <ProtectWindows>False</ProtectWindows>';
		_xml += ' </ExcelWorkbook>';
		_xml += ' <Styles>';
		_xml += '  <Style ss:ID="Default" ss:Name="Normal">';
		_xml += '   <Alignment ss:Vertical="Center"/>';
		_xml += '   <Borders/>';
		_xml += '   <Font ss:FontName="宋体" x:CharSet="134" ss:Size="11" ss:Color="#000000"/>';
		_xml += '   <Interior/>';
		_xml += '   <NumberFormat/>';
		_xml += '   <Protection/>';
		_xml += '  </Style>';
		_xml += '  <Style ss:ID="String"><!-- String -->';
		_xml += '   <Font ss:FontName="Arial" x:Family="Swiss"/>';
		_xml += '  </Style>';
		_xml += '  <Style ss:ID="ShortTime"><!-- DateTime -->';
		_xml += '   <Font ss:FontName="Arial" x:Family="Swiss"/>';
		_xml += '   <NumberFormat ss:Format="Short Time"/>';
		_xml += '  </Style>';
		_xml += '  <Style ss:ID="ShortDate"><!-- DateTime -->';
		_xml += '   <Font ss:FontName="Arial" x:Family="Swiss"/>';
		_xml += '   <NumberFormat ss:Format="Short Date"/>';
		_xml += '  </Style>';
		_xml += '  <Style ss:ID="DateTime"><!-- DateTime -->';
		_xml += '   <Font ss:FontName="Arial" x:Family="Swiss"/>';
		_xml += '   <NumberFormat ss:Format="yyyy\-m\-d h:mm:ss"/>';
		_xml += '  </Style>';
		_xml += '  <Style ss:ID="Number"><!-- Number -->';
		_xml += '   <Font ss:FontName="Arial" x:Family="Swiss"/>';
		_xml += '  </Style>';
		_xml += '  <Style ss:ID="Point2"><!-- Number -->';
		_xml += '   <Font ss:FontName="Arial" x:Family="Swiss"/>';
		_xml += '   <NumberFormat ss:Format="0.00_ "/>';
		_xml += '  </Style>';
		_xml += '  <Style ss:ID="Percent"><!-- Number -->';
		_xml += '   <Font ss:FontName="Arial" x:Family="Swiss"/>';
		_xml += '   <NumberFormat ss:Format="Percent"/>';
		_xml += '  </Style>';
		_xml += ' </Styles>';
	},
	_buildXlsFoot : function(){
		_xml += '</Workbook>';
	},
	_buildSheetHead : function(){
		_xml += '<Worksheet ss:Name="'+this._s.sheetName+'">';
		_xml += '  <Table ss:ExpandedColumnCount="'+this._ExpandedColumnCount+'" ss:ExpandedRowCount="'+this._ExpandedRowCount+'" x:FullColumns="1"';
		_xml += '   x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="13.5">';
	},
	_buildSheetFoot : function(){
		_xml += '  </Table>';
		_xml += '  <WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">';
		_xml += '   <PageSetup>';
		_xml += '    <Header x:Margin="0.3"/>';
		_xml += '    <Footer x:Margin="0.3"/>';
		_xml += '    <PageMargins x:Bottom="0.75" x:Left="0.7" x:Right="0.7" x:Top="0.75"/>';
		_xml += '   </PageSetup>';
		_xml += '   <Unsynced/>';
		_xml += '   <Selected/>';
		_xml += '   <Panes>';
		_xml += '    <Pane>';
		_xml += '     <Number>3</Number>';
		_xml += '     <ActiveRow>5</ActiveRow>';
		_xml += '     <ActiveCol>2</ActiveCol>';
		_xml += '    </Pane>';
		_xml += '   </Panes>';
		_xml += '   <ProtectObjects>False</ProtectObjects>';
		_xml += '   <ProtectScenarios>False</ProtectScenarios>';
		_xml += '  </WorksheetOptions>';
		_xml += ' </Worksheet>';
	},
	_buildSheetBody : function(){
		$(this._tableArray).each(function(i){
			_xml += '<Row ss:AutoFitHeight="0">';
			$(this).each(function(j){
				if(this.isNull()){
				}else{
					if(this.isNum()){
						_xml += '<Cell ss:Index="'+(j+1)+'"';
						if(this.MergeAcross)
							_xml += ' ss:MergeAcross="'+this.MergeAcross+'"';
						if(this.MergeDown)
							_xml += ' ss:MergeDown="'+this.MergeDown+'"';
						_xml += ' ss:StyleID="Number">';
						_xml += '<Data ss:Type="Number">'+this.getNum()+'</Data>';
					}else if(this.isShortTime()){
						_xml += '<Cell ss:Index="'+(j+1)+'"';
						if(this.MergeAcross)
							_xml += ' ss:MergeAcross="'+this.MergeAcross+'"';
						if(this.MergeDown)
							_xml += ' ss:MergeDown="'+this.MergeDown+'"';
						_xml += ' ss:StyleID="ShortTime">';
						_xml += '<Data ss:Type="DateTime">'+this.getShortTime()+'</Data>';
					}
					else if(this.isShortDate()){
						_xml += '<Cell ss:Index="'+(j+1)+'"';
						if(this.MergeAcross)
							_xml += ' ss:MergeAcross="'+this.MergeAcross+'"';
						if(this.MergeDown)
							_xml += ' ss:MergeDown="'+this.MergeDown+'"';
						_xml += ' ss:StyleID="ShortDate">';
						_xml += '<Data ss:Type="DateTime">'+this.getShortDate()+'</Data>';
					}
					else if(this.isPercent()){
						_xml += '<Cell ss:Index="'+(j+1)+'"';
						if(this.MergeAcross)
							_xml += ' ss:MergeAcross="'+this.MergeAcross+'"';
						if(this.MergeDown)
							_xml += ' ss:MergeDown="'+this.MergeDown+'"';
						_xml += ' ss:StyleID="Percent">';
						_xml += '<Data ss:Type="Number">'+this.getPercent()+'</Data>';
					}
					else{
						_xml += '<Cell ss:Index="'+(j+1)+'"';
						if(this.MergeAcross)
							_xml += ' ss:MergeAcross="'+this.MergeAcross+'"';
						if(this.MergeDown)
							_xml += ' ss:MergeDown="'+this.MergeDown+'"';
						_xml += ' ss:StyleID="String">';
						_xml += '<Data ss:Type="String">'+this.getText()+'</Data>';
					}
					_xml += '</Cell>';
				}
			});
			_xml += '</Row>';
		});
	},
	_bulidActiveX : function(){
		var _oWB;
		var _oSheet;
		try{
			_oXL = new ActiveXObject("Excel.Application"); 
			_oWB = _oXL.Workbooks.Add(); 
			_oSheet = _oWB.ActiveSheet;
		}catch(err){
			alert(this._s.IEErrorMessage);
		}
		_oSheet.name = this._s.sheetName;
		$(this._tableArray).each(function(i){
			$(this).each(function(j){
				if(!this.isNull()){
					_oSheet.Cells(i + 1, j + 1).value = this.getText();
					if( this.MergeAcross || this.MergeDown ){
						_oSheet.Range(_oSheet.Cells(i+1,j+1),_oSheet.Cells(i+1+this.MergeDown,j+1+this.MergeAcross)).mergecells=true;
					}
				}
			})
		});
	},
	_OpenXmlExcel : function(){
		document.location = 'data:application/vnd.ms-excel;base64,' + Base64.encode(_xml); 
		var t = _xml;
	},
	_OpenActiveXExcel : function(){
		_oXL.Visible = true;
	}
}

$.fn.e2e = function(options){
	
	var _Table = this;
	var x = new $.e2e(options);
	x._buildArray(this);
	//if ($.browser.msie) {
	if (document.all) {
		x._bulidActiveX();
		x._OpenActiveXExcel();
	}else{ 
		x._buildXlsHead();
		x._buildSheetHead();
		x._buildSheetBody();
		x._buildSheetFoot();
		x._buildXlsFoot();
		x._OpenXmlExcel();
	}
};

var Td = function (td,x,y){
	this.nvll = (td==null);
	if(!this.nvll){
		var _td = $(td);
		this.text = _td.text();
		this.MergeAcross = _td.attr('colspan')-1;
		this.MergeDown = _td.attr('rowspan')-1;
		this.x = x;
		this.y = y;
	}
}
Td.prototype={
	isNull:function(){  
		return this.nvll;
	},
	isNum:function(){
		var r,re;
		re = /^\d*\.?\d*$/;
		r = this.text.match(re);
		return (r==this.text)?true:false;
	},
	getNum:function(){
		var r,re;
		re = /^\d*\.?\d*$/;
		r = this.text.match(re);
		return r;
	},
	isShortTime:function(){
		var r,re;
		re = /^[0,1,2]\d[:][0-5]\d[:][0-5]\d$/; 
		r = this.text.match(re);
		return (r==this.text)?true:false;
	},
	getShortTime:function(){
		var rh,reh,rm,rem,rs,res,r;
		r = /\d{2}/;
		reh = /^[0,1,2]\d[:]/;
		rh = this.text.match(reh).toString().match(r);
		rem = /[:][0-5]\d[:]/;
		rm = this.text.match(rem).toString().match(r);
		res = /[:][0-5]\d$/;
		rs = this.text.match(res).toString().match(r);
		return '1899-12-31T'+rh+':'+rm+':'+rs+'.000';
	},
	isShortDate:function(){
	    var r,re;
		re = /^\d{4}[-/?]\d{2}[-/?]\d{2}$/; 
		r = this.text.match(re);
		return (r==this.text)?true:false;
	},
	getShortDate:function(){
		var ry,rey,rm,rem,rd,red;
		r1 = /\d{4}/;
		r2 = /\d{2}/;
		rey = /^\d{4}[-/?]/;
		ry = this.text.match(rey).toString().match(r1);
		rem = /[-/?]\d{2}[-/?]/;
		rm = this.text.match(rem).toString().match(r2);
		red = /[-/?]\d{2}$/;
		rd = this.text.match(red).toString().match(r2);
		return ry + '-' + rm + '-' + rd + 'T00:00:00.000';
	},
	isPercent:function(){
		var r,re;
		re = /^\d*\.?\d*%$/; 
		r = this.text.match(re);
		return (r==this.text)?true:false;
	},
	getPercent:function(){
		var r,re;
		re = /^\d*\.?\d*/; 
		r = this.text.match(re);
		return r/100;
	},
	getText:function(){
		return this.text;
	}
};
