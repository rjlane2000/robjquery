<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:forms="http://xmlns.oracle.com/Forms">
<xsl:output method="html" indent="no" encoding="UTF-8"/>

<!--
Oracle Forms XML Explorer
http://www.geocities.com/oranails/
-->

<xsl:param name="initialexpand" select="3"/>

<xsl:variable name="productName" select="'Oracle Forms XML Explorer'"/>
<xsl:variable name="productVersion" select="'1.0'"/>
<xsl:variable name="apos">&#39;</xsl:variable>

<xsl:template match="/">
  <html>
  <head>
     <title><xsl:value-of select="$productName"/></title>
     <style type="text/css">
       .window    {border-right: 2px solid #555555; border-bottom: 2px solid #555555; border-top: 2px solid lightgrey; border-left: 2px solid lightgrey}
       .titlebar  {height: 18px; padding-left: 5px; font-family: Verdana; font-size:11px; font-weight:bold; color:white; background-color:#336699; cursor:default; border-style:outset}
       .toolbar   {border-left: 1px solid white; border-top: 1px solid white; background-color: lightgrey}
       .butover   {border: 1px outset; cursor: pointer}
       .butout    {border: 1px solid lightgrey;}
       .butpress  {border: 1px outset; cursor: wait}
       .navbar    {padding-top: 10px}
       .icon      {width: 16px; height: 16px; border: 0; vertical-align: center;}
       .hiericon  {width: 19px; height: 16px; border: 0; vertical-align: center;}
       .nodegroup {padding-left: 2px; font-family: Verdana; font-size: 11px; font-weight: bold; font-color: black; cursor:default}
       .nodeitem  {padding-left: 2px; font-family: Verdana; font-size: 11px; font-color: black; cursor:pointer}
       .nodeprop  {padding-left: 5px; font-family: Verdana; font-size: 11px; font-color: black; border-bottom: 1px solid black; border-right: 1px solid black}
       .nodevalue {padding-left: 5px; font-family: Verdana; font-size: 11px; font-color: black; border-bottom: 1px solid black}
     </style>

  <script language="Javascript">
  <![CDATA[

    function whenNodeClicked(node) {
      if (node.src.match(node.getAttribute("src_closed")) == node.getAttribute("src_closed")) {
        expand(node);
      }
      else if (node.src.match(node.getAttribute("src_opened")) == node.getAttribute("src_opened")) {
        collapse(node);
      }
    }


    function whenNodeSelected(node) {
      var divNode = node;
      var i;
      while (divNode.tagName.toUpperCase() != "DIV") divNode = divNode.parentNode;
      for(i=1; i <divNode.childNodes.length; i++) {
        if (divNode.childNodes[i].tagName) { 
          if(divNode.childNodes[i].tagName.toUpperCase() == "DIV" && divNode.childNodes[i].id.substr(0, 14) == "nodeProperties") {
            document.getElementById('propertyPalette').innerHTML = divNode.childNodes[i].innerHTML;
          }
        }
      }
    }


    function expand(node) {
      var divNode = node;
      var i;
      node.src = node.getAttribute("src_opened");
      while (divNode.tagName.toUpperCase() != "DIV") divNode = divNode.parentNode;
      for(i=0; i <divNode.childNodes.length; i++) {
        if (divNode.childNodes[i].tagName) { 
          if(divNode.childNodes[i].tagName.toUpperCase() == "DIV" && divNode.childNodes[i].id.substr(0, 8) == "treeNode") {
            divNode.childNodes[i].style.display = ""
          }
        }
      }
    }


    function collapse(node) {
      var divNode = node;
      var i;
      node.src = node.getAttribute("src_closed");
      while (divNode.tagName.toUpperCase() != "DIV") divNode = divNode.parentNode;
      for(i=0; i <divNode.childNodes.length; i++) {
        if (divNode.childNodes[i].tagName) { 
          if(divNode.childNodes[i].tagName.toUpperCase() == "DIV" && divNode.childNodes[i].id.substr(0, 8) == "treeNode") {
            divNode.childNodes[i].style.display = "none"
          }
        }
      }
    }


    function expandAll(node) {
      var i;
      for(i=0; i<node.childNodes.length; i++) {
        if (node.childNodes[i].tagName) {
          if (node.childNodes[i].tagName.toUpperCase() == "IMG" && node.childNodes[i].id.substr(0, 11) == "nodeControl") {
            expand(node.childNodes[i])
          }
          else if (node.childNodes[i].id.substr(0, 14) != "nodeProperties") {
            expandAll(node.childNodes[i]);
          }
        }
      }
    }


    function collapseAll(node) {
      var i;
      for(i=0; i<node.childNodes.length; i++) {
        if (node.childNodes[i].tagName) {
          if (node.childNodes[i].tagName.toUpperCase() == "IMG" && node.childNodes[i].id.substr(0, 11) == "nodeControl") {
            collapse(node.childNodes[i])
          }
          else if (node.childNodes[i].id.substr(0, 14) != "nodeProperties") {
            collapseAll(node.childNodes[i]);
          }
        }
      }
    }


    var button;
    var oldClassName;

    function longTimeOperation(butObject, command) {
      button = butObject;
      oldClassName = button.className;
      button.className='butpress';
      button.disabled=true;
      window.status='Wait please...';
      setTimeout(command + '; button.className=oldClassName; button.disabled=false;window.status=\'\'', 10);
    }

    function syntaxHighlight(plsqlSource) {
      if (!navigator.userAgent.match(/mozilla\/[4-9].*(msie [6-9]|rv:[1-9])/i)) return (plsqlSource);
      var pls = plsqlSource;
      var hl = new Array;
      pls = pls.replace(/\*\//g, '\x01');
      pls = pls.replace(/(\/\*[^\x01]*\x01)/g, function r($0, $1){hl.push('<font color="green"><i>'+$1+'</i></font>'); return('{'+(hl.length-1)+'}')});
      pls = pls.replace(/<br>/ig, '\n');
      pls = pls.replace(/(--.*)/g, function r($0, $1){hl.push('<font color="green"><i>'+$1+'</i></font>'); return('{'+(hl.length-1)+'}')});
      pls = pls.replace(/\n/g, '<br>');
      pls = pls.replace(/(\'[^\']*\')/g, function r($0, $1){hl.push('<font color="#808000">'+$1+'</font>'); return('{'+(hl.length-1)+'}')});
      pls = pls.replace(/<br>/ig, '\n');
      pls = pls.replace(/\b(if|then|else|elsif|end\s*if)\b/gi, function r($0, $1){hl.push('<font color="blue">'+$1+'</font>'); return('{'+(hl.length-1)+'}')});
      pls = pls.replace(/\b(while|for|loop|reverse|end\s*loop|exit)\b/gi, function r($0, $1){hl.push('<font color="blue">'+$1+'</font>'); return('{'+(hl.length-1)+'}')});
      pls = pls.replace(/\b(create\s*or\s*replace|package\s*body|package|procedure|function|is\s*\n|pragma|declare|begin|exception|when|end|return)\b/gi, function r($0, $1){hl.push('<font color="blue"><b>'+$1+'</b></font>'); return('{'+(hl.length-1)+'}')});
      pls = pls.replace(/\b(in|out|is|not|null|like)\b/gi, function r($0, $1){hl.push('<font color="blue">'+$1+'</font>'); return('{'+(hl.length-1)+'}')});
      pls = pls.replace(/\b(select|insert|update|delete|into|from|where|exists|union|minus|order\s*by|group\s*by|having|connect\s*by|prior|between|and|or)\b/gi, function r($0, $1){hl.push('<font color="blue">'+$1+'</font>'); return('{'+(hl.length-1)+'}')});
      pls = pls.replace(/\b(type|subtype|record|table|of|index\s*by|varray|cursor|constant)\b/gi, function r($0, $1){hl.push('<font color="blue">'+$1+'</font>'); return('{'+(hl.length-1)+'}')});
      pls = pls.replace(/\b(boolean|varchar2|varchar|char|date|number|float|real|binary_integer|pls_integer|integer|decimal|natural|positive|rowid|long\s*raw|blob|clob|bfile)\b/gi, function r($0, $1){hl.push('<font color="#800080">'+$1+'</font>'); return('{'+(hl.length-1)+'}')});
      pls = pls.replace(/(\.\.|\+|\-|\*|\/|:=|=|\(|\)|&lt;&gt;|<=|>=|>|<|!=|\|\|)/gi, function r($0, $1){hl.push('<font color="red">'+$1+'</font>'); return('{'+(hl.length-1)+'}')});

      for (i=0; i<hl.length; i++) pls = pls.replace('{'+i+'}', hl[i]);
      pls = pls.replace(/\x01/g, '\*\/');
      return (pls);
    }


    function showText(winId, winTitle, winText) {
      popWin= open("", winId, "width=580,height=320,status=no,toolbar=no,menubar=no,scrollbars=yes,resizable=yes");
      popWin.document.open();
      popWin.document.write("<html><head><title>");
      popWin.document.write(winTitle);
      popWin.document.write("</title></head><body><div style='font-family: Lucida Console; font-size: 11px'><pre>");
      popWin.document.write(syntaxHighlight(winText));
      popWin.document.write("</pre></div></body></html>");
      popWin.document.close();  
    }

    function aboutProgram() {
      document.getElementById('propertyPalette').innerHTML = document.getElementById('about').innerHTML;
    }

  ]]>
  </script>


  </head>
  <body id="body">
<TABLE border="0" CELLSPACING="0" CELLPADDING="0" HEIGHT="100%" WIDTH="100%">
  <TR height="100%">

    <TD WIDTH="340" height="100%" NOWRAP="true" VALIGN="TOP">

      <table class="window" border="0" width="100%" height="100%" cellspacing="0" cellpadding="1">
      <tr class="titlebar">
        <td align="center" width="20"><img class="icon" src="images/ObjectNavigator.gif"/></td>
        <td width="100%" nowrap="true">Object Navigator</td>
      </tr>
      <tr valign="top">
        <td class="toolbar" width="20" style="padding-top: 10px">
          <table border="0" cellspacing="0" cellpadding="1">
          <tr><td class="butout" title="Expand All" onmouseover="this.className='butover'" onmouseout="this.className='butout'" onclick="node=document.getElementById('objectNavigator'); longTimeOperation(this, 'expandAll(node)')"><img class="icon" src="images/ExpandAll.png" /></td></tr>
          <tr><td class="butout" title="Collapse All" onmouseover="this.className='butover'" onmouseout="this.className='butout'" onclick="node=document.getElementById('objectNavigator'); longTimeOperation(this, 'collapseAll(node)')"><img class="icon" src="images/CollapseAll.png" /></td></tr>
          <tr><td class="butout" title="About" onmouseover="this.className='butover'" onmouseout="this.className='butout'" onclick="aboutProgram()"><img class="icon" src="images/About.png" /></td></tr>
          </table>
        </td>

        <!-- Navigator tree -->
        <td width="100%" height="100%">
          <div id="objectNavigator" style="width:100%; height:100%; overflow:auto">
            <table id="paddingTop" border="0" height="10px"><tr><td></td></tr></table> <!-- padding-top imitation due to mozilla 1.0 bug -->
            <xsl:apply-templates mode="render"/>
          </div>
        </td>
      </tr>
      </table>

    </TD>
    <TD width="100%" height="100%" ID="content" VALIGN="TOP">
      <table class="window" border="0" align="center" width="95%" height="100%" cellspacing="0" cellpadding="1">
      <tr class="titlebar">
        <td align="center" width="20"><img class="icon" src="images/PropertyPalette.gif"/></td>
        <td width="100%" nowrap="true">Property Palette</td>
      </tr>
      <tr valign="top">

        <!-- Property Palette -->
        <td width="100%" height="100%" colspan="2">
          <div id="propertyPalette" style="padding-top:0px; width:100%; height:100%; overflow:auto">
          </div>
        </td>
      </tr>
      </table>

    </TD>
  </TR>
</TABLE>


  <!-- About -->
  <div id="about" style="display: none">
    <table border="0" cellspacing="0" cellpadding="1" width="100%">
    <tr class="toolbar" height="20">
      <td class="nodevalue" nowrap="true" colspan="2">About program</td>
    </tr>
    <tr height="22">
      <td class="nodeprop" nowrap="true" width="150">Name</td>
      <td class="nodevalue" nowrap="true"><xsl:value-of select="$productName"/></td>
    </tr>
    <tr height="22">
      <td class="nodeprop" nowrap="true" width="150">Version</td>
      <td class="nodevalue" nowrap="true"><xsl:value-of select="$productVersion"/></td>
    </tr>
    <tr height="22">
      <td class="nodeprop" nowrap="true" width="150">Copyright</td>
      <td class="nodevalue" nowrap="true">2002 OraNails</td>
    </tr>
    <tr height="22">
      <td class="nodeprop" nowrap="true" width="150">License</td>
      <td class="nodevalue" nowrap="true">Free for non-commercial use</td>
    </tr>
    <tr height="22">
      <td class="nodeprop" nowrap="true" width="150">Home page</td>
      <td class="nodevalue" nowrap="true"><a href="http://www.geocities.com/oranails" target="_blank">http://www.geocities.com/oranails</a></td>
    </tr>

    </table>
  </div>

  </body>
  </html>
</xsl:template>


<xsl:template match="forms:FormModule" mode="render"><xsl:param name="hierarchy"/>
  <xsl:variable name="hier"><xsl:value-of select="$hierarchy"/>L</xsl:variable>
  <div>
    <xsl:call-template name="treenode">
      <xsl:with-param name="hierarchy"><xsl:value-of select="$hier"/></xsl:with-param>
      <xsl:with-param name="label"><xsl:call-template name="nodelabel"/></xsl:with-param>
    </xsl:call-template>

    <xsl:call-template name="nodegroup">
      <xsl:with-param name="hierarchy"><xsl:value-of select="$hier"/>T</xsl:with-param>
      <xsl:with-param name="label">Triggers</xsl:with-param>
      <xsl:with-param name="node-set" select="forms:Trigger"/>
    </xsl:call-template>
    <xsl:call-template name="nodegroup">
      <xsl:with-param name="hierarchy"><xsl:value-of select="$hier"/>T</xsl:with-param>
      <xsl:with-param name="label">Alerts</xsl:with-param>
      <xsl:with-param name="node-set" select="forms:Alert"/>
    </xsl:call-template>
    <xsl:call-template name="nodegroup">
      <xsl:with-param name="hierarchy"><xsl:value-of select="$hier"/>T</xsl:with-param>
      <xsl:with-param name="label">Attached Libraries</xsl:with-param>
      <xsl:with-param name="node-set" select="forms:AttachedLibrary"/>
    </xsl:call-template>
    <xsl:call-template name="nodegroup">
      <xsl:with-param name="hierarchy"><xsl:value-of select="$hier"/>T</xsl:with-param>
      <xsl:with-param name="label">Blocks</xsl:with-param>
      <xsl:with-param name="node-set" select="forms:Block"/>
    </xsl:call-template>
    <xsl:call-template name="nodegroup">
      <xsl:with-param name="hierarchy"><xsl:value-of select="$hier"/>T</xsl:with-param>
      <xsl:with-param name="label">Canvases</xsl:with-param>
      <xsl:with-param name="node-set" select="forms:Canvas"/>
    </xsl:call-template>
    <xsl:call-template name="nodegroup">
      <xsl:with-param name="hierarchy"><xsl:value-of select="$hier"/>T</xsl:with-param>
      <xsl:with-param name="label">Editors</xsl:with-param>
      <xsl:with-param name="node-set" select="forms:Editor"/>
    </xsl:call-template>
    <xsl:call-template name="nodegroup">
      <xsl:with-param name="hierarchy"><xsl:value-of select="$hier"/>T</xsl:with-param>
      <xsl:with-param name="label">Parameters</xsl:with-param>
      <xsl:with-param name="node-set" select="forms:ModuleParameter"/>
    </xsl:call-template>
    <xsl:call-template name="nodegroup">
      <xsl:with-param name="hierarchy"><xsl:value-of select="$hier"/>T</xsl:with-param>
      <xsl:with-param name="label">LOVs</xsl:with-param>
      <xsl:with-param name="node-set" select="forms:LOV"/>
    </xsl:call-template>
    <xsl:call-template name="nodegroup">
      <xsl:with-param name="hierarchy"><xsl:value-of select="$hier"/>T</xsl:with-param>
      <xsl:with-param name="label">Popup Menus</xsl:with-param>
      <xsl:with-param name="node-set" select="forms:Menu"/>
    </xsl:call-template>
    <xsl:call-template name="nodegroup">
      <xsl:with-param name="hierarchy"><xsl:value-of select="$hier"/>T</xsl:with-param>
      <xsl:with-param name="label">Object Groups</xsl:with-param>
      <xsl:with-param name="node-set" select="forms:ObjectGroup"/>
    </xsl:call-template>
    <xsl:call-template name="nodegroup">
      <xsl:with-param name="hierarchy"><xsl:value-of select="$hier"/>T</xsl:with-param>
      <xsl:with-param name="label">Program Units</xsl:with-param>
      <xsl:with-param name="node-set" select="forms:ProgramUnit"/>
    </xsl:call-template>
    <xsl:call-template name="nodegroup">
      <xsl:with-param name="hierarchy"><xsl:value-of select="$hier"/>T</xsl:with-param>
      <xsl:with-param name="label">Property Classes</xsl:with-param>
      <xsl:with-param name="node-set" select="forms:PropertyClass"/>
    </xsl:call-template>
    <xsl:call-template name="nodegroup">
      <xsl:with-param name="hierarchy"><xsl:value-of select="$hier"/>T</xsl:with-param>
      <xsl:with-param name="label">Record Groups</xsl:with-param>
      <xsl:with-param name="node-set" select="forms:RecordGroup"/>
    </xsl:call-template>
    <xsl:call-template name="nodegroup">
      <xsl:with-param name="hierarchy"><xsl:value-of select="$hier"/>T</xsl:with-param>
      <xsl:with-param name="label">Reports</xsl:with-param>
      <xsl:with-param name="node-set" select="forms:Report"/>
    </xsl:call-template>
    <xsl:call-template name="nodegroup">
      <xsl:with-param name="hierarchy"><xsl:value-of select="$hier"/>T</xsl:with-param>
      <xsl:with-param name="label">Visual Attributes</xsl:with-param>
      <xsl:with-param name="node-set" select="forms:VisualAttribute"/>
    </xsl:call-template>
    <xsl:call-template name="nodegroup">
      <xsl:with-param name="hierarchy"><xsl:value-of select="$hier"/>L</xsl:with-param>
      <xsl:with-param name="label">Windows</xsl:with-param>
      <xsl:with-param name="node-set" select="forms:Window"/>
    </xsl:call-template>
  </div>
</xsl:template>


<xsl:template match="forms:Block" mode="render"><xsl:param name="hierarchy"/>
  <xsl:variable name="nodecontrol"><xsl:call-template name="nodecontrol"/></xsl:variable>
  <xsl:variable name="hier"><xsl:value-of select="concat($hierarchy, translate($nodecontrol, 'tl', 'TL'))"/></xsl:variable>
  <div>
    <xsl:call-template name="treenode">
      <xsl:with-param name="hierarchy"><xsl:value-of select="$hier"/></xsl:with-param>
      <xsl:with-param name="label"><xsl:call-template name="nodelabel"/></xsl:with-param>
    </xsl:call-template>

    <xsl:call-template name="nodegroup">
      <xsl:with-param name="hierarchy"><xsl:value-of select="$hier"/>T</xsl:with-param>
      <xsl:with-param name="label">Triggers</xsl:with-param>
      <xsl:with-param name="node-set" select="forms:Trigger"/>
    </xsl:call-template>
    <xsl:call-template name="nodegroup">
      <xsl:with-param name="hierarchy"><xsl:value-of select="$hier"/>T</xsl:with-param>
      <xsl:with-param name="label">Items</xsl:with-param>
      <xsl:with-param name="node-set" select="forms:Item"/>
    </xsl:call-template>
    <xsl:call-template name="nodegroup">
      <xsl:with-param name="hierarchy"><xsl:value-of select="$hier"/>L</xsl:with-param>
      <xsl:with-param name="label">Relations</xsl:with-param>
      <xsl:with-param name="node-set" select="forms:Relation"/>
    </xsl:call-template>
  </div>
</xsl:template>


<xsl:template match="forms:Item" mode="render"><xsl:param name="hierarchy"/>
  <xsl:variable name="nodecontrol"><xsl:call-template name="nodecontrol"/></xsl:variable>
  <xsl:variable name="hier"><xsl:value-of select="concat($hierarchy, translate($nodecontrol, 'tl', 'TL'))"/></xsl:variable>
  <div>
    <xsl:call-template name="treenode">
      <xsl:with-param name="hierarchy"><xsl:value-of select="$hier"/></xsl:with-param>
      <xsl:with-param name="label"><xsl:call-template name="nodelabel"/></xsl:with-param>
    </xsl:call-template>

    <xsl:call-template name="nodegroup">
      <xsl:with-param name="hierarchy"><xsl:value-of select="$hier"/>L</xsl:with-param>
      <xsl:with-param name="label">Triggers</xsl:with-param>
      <xsl:with-param name="node-set" select="forms:Trigger"/>
    </xsl:call-template>
  </div>
</xsl:template>


<xsl:template match="forms:Item[@ItemType = 'Radio Group']" mode="render"><xsl:param name="hierarchy"/>
  <xsl:variable name="nodecontrol"><xsl:call-template name="nodecontrol"/></xsl:variable>
  <xsl:variable name="hier"><xsl:value-of select="concat($hierarchy, translate($nodecontrol, 'tl', 'TL'))"/></xsl:variable>
  <div>
    <xsl:call-template name="treenode">
      <xsl:with-param name="hierarchy"><xsl:value-of select="$hier"/></xsl:with-param>
      <xsl:with-param name="label"><xsl:call-template name="nodelabel"/></xsl:with-param>
    </xsl:call-template>

    <xsl:call-template name="nodegroup">
      <xsl:with-param name="hierarchy"><xsl:value-of select="$hier"/>T</xsl:with-param>
      <xsl:with-param name="label">Triggers</xsl:with-param>
      <xsl:with-param name="node-set" select="forms:Trigger"/>
    </xsl:call-template>

    <xsl:call-template name="nodegroup">
      <xsl:with-param name="hierarchy"><xsl:value-of select="$hier"/>L</xsl:with-param>
      <xsl:with-param name="label">Radio Buttons</xsl:with-param>
      <xsl:with-param name="node-set" select="forms:RadioButton"/>
    </xsl:call-template>
  </div>
</xsl:template>

<xsl:template match="forms:Item[@ItemType = 'List Item']" mode="render"><xsl:param name="hierarchy"/>
  <xsl:variable name="nodecontrol"><xsl:call-template name="nodecontrol"/></xsl:variable>
  <xsl:variable name="hier"><xsl:value-of select="concat($hierarchy, translate($nodecontrol, 'tl', 'TL'))"/></xsl:variable>
  <div>
    <xsl:call-template name="treenode">
      <xsl:with-param name="hierarchy"><xsl:value-of select="$hier"/></xsl:with-param>
      <xsl:with-param name="label"><xsl:call-template name="nodelabel"/></xsl:with-param>
    </xsl:call-template>

    <xsl:call-template name="nodegroup">
      <xsl:with-param name="hierarchy"><xsl:value-of select="$hier"/>T</xsl:with-param>
      <xsl:with-param name="label">Triggers</xsl:with-param>
      <xsl:with-param name="node-set" select="forms:Trigger"/>
    </xsl:call-template>

    <xsl:call-template name="nodegroup">
      <xsl:with-param name="hierarchy"><xsl:value-of select="$hier"/>L</xsl:with-param>
      <xsl:with-param name="label">List Item Elements</xsl:with-param>
      <xsl:with-param name="node-set" select="forms:ListItemElement"/>
    </xsl:call-template>
  </div>
</xsl:template>




<xsl:template match="forms:Canvas[not(@CanvasType='Tab' or descendant::forms:TabPage)]|forms:TabPage" mode="render"><xsl:param name="hierarchy"/>
  <xsl:variable name="nodecontrol"><xsl:call-template name="nodecontrol"/></xsl:variable>
  <xsl:variable name="hier"><xsl:value-of select="concat($hierarchy, translate($nodecontrol, 'tl', 'TL'))"/></xsl:variable>
  <div>
    <xsl:call-template name="treenode">
      <xsl:with-param name="hierarchy"><xsl:value-of select="$hier"/></xsl:with-param>
      <xsl:with-param name="label"><xsl:call-template name="nodelabel"/></xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="nodegroup">
      <xsl:with-param name="hierarchy"><xsl:value-of select="$hier"/>L</xsl:with-param>
      <xsl:with-param name="label">Graphics</xsl:with-param>
      <xsl:with-param name="node-set" select="forms:Graphics"/>
    </xsl:call-template>
  </div>
</xsl:template>

<xsl:template match="forms:LOV" mode="render"><xsl:param name="hierarchy"/>
  <xsl:variable name="nodecontrol"><xsl:call-template name="nodecontrol"/></xsl:variable>
  <xsl:variable name="hier"><xsl:value-of select="concat($hierarchy, translate($nodecontrol, 'tl', 'TL'))"/></xsl:variable>
  <div>
    <xsl:call-template name="treenode">
      <xsl:with-param name="hierarchy"><xsl:value-of select="$hier"/></xsl:with-param>
      <xsl:with-param name="label"><xsl:call-template name="nodelabel"/></xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="nodegroup">
      <xsl:with-param name="hierarchy"><xsl:value-of select="$hier"/>L</xsl:with-param>
      <xsl:with-param name="label">Column Mapping</xsl:with-param>
      <xsl:with-param name="node-set" select="forms:LOVColumnMapping"/>
    </xsl:call-template>
  </div>
</xsl:template>

<xsl:template match="forms:Menu" mode="render"><xsl:param name="hierarchy"/>
  <xsl:variable name="nodecontrol"><xsl:call-template name="nodecontrol"/></xsl:variable>
  <xsl:variable name="hier"><xsl:value-of select="concat($hierarchy, translate($nodecontrol, 'tl', 'TL'))"/></xsl:variable>
  <div>
    <xsl:call-template name="treenode">
      <xsl:with-param name="hierarchy"><xsl:value-of select="$hier"/></xsl:with-param>
      <xsl:with-param name="label"><xsl:call-template name="nodelabel"/></xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="nodegroup">
      <xsl:with-param name="hierarchy"><xsl:value-of select="$hier"/>L</xsl:with-param>
      <xsl:with-param name="label">Items</xsl:with-param>
      <xsl:with-param name="node-set" select="forms:MenuItem"/>
    </xsl:call-template>
  </div>
</xsl:template>

<xsl:template match="forms:PropertyClass" mode="render"><xsl:param name="hierarchy"/>
  <xsl:variable name="nodecontrol"><xsl:call-template name="nodecontrol"/></xsl:variable>
  <xsl:variable name="hier"><xsl:value-of select="concat($hierarchy, translate($nodecontrol, 'tl', 'TL'))"/></xsl:variable>
  <div>
    <xsl:call-template name="treenode">
      <xsl:with-param name="hierarchy"><xsl:value-of select="$hier"/></xsl:with-param>
      <xsl:with-param name="label"><xsl:call-template name="nodelabel"/></xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="nodegroup">
      <xsl:with-param name="hierarchy"><xsl:value-of select="$hier"/>L</xsl:with-param>
      <xsl:with-param name="label">Triggers</xsl:with-param>
      <xsl:with-param name="node-set" select="forms:Trigger"/>
    </xsl:call-template>
  </div>
</xsl:template>

<xsl:template match="forms:RecordGroup" mode="render"><xsl:param name="hierarchy"/>
  <xsl:variable name="nodecontrol"><xsl:call-template name="nodecontrol"/></xsl:variable>
  <xsl:variable name="hier"><xsl:value-of select="concat($hierarchy, translate($nodecontrol, 'tl', 'TL'))"/></xsl:variable>
  <div>
    <xsl:call-template name="treenode">
      <xsl:with-param name="hierarchy"><xsl:value-of select="$hier"/></xsl:with-param>
      <xsl:with-param name="label"><xsl:call-template name="nodelabel"/></xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="nodegroup">
      <xsl:with-param name="hierarchy"><xsl:value-of select="$hier"/>L</xsl:with-param>
      <xsl:with-param name="label">Column Specifications</xsl:with-param>
      <xsl:with-param name="node-set" select="forms:RecordGroupColumn"/>
    </xsl:call-template>
  </div>
</xsl:template>

<xsl:template match="forms:RecordGroupColumn" mode="render"><xsl:param name="hierarchy"/>
  <xsl:variable name="nodecontrol"><xsl:call-template name="nodecontrol"/></xsl:variable>
  <xsl:variable name="hier"><xsl:value-of select="concat($hierarchy, $nodecontrol)"/></xsl:variable>
  <div>
    <xsl:call-template name="treenode">
      <xsl:with-param name="hierarchy"><xsl:value-of select="$hier"/></xsl:with-param>
      <xsl:with-param name="label"><xsl:call-template name="nodelabel"/></xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="nodegroup">
      <xsl:with-param name="hierarchy"><xsl:value-of select="$hier"/>L</xsl:with-param>
      <xsl:with-param name="label">Column Values</xsl:with-param>
      <xsl:with-param name="node-set" select="forms:RecordGroupColumnRow"/>
    </xsl:call-template>
  </div>
</xsl:template>



<xsl:template match="forms:*" mode="render"><xsl:param name="hierarchy"/>
  <xsl:variable name="nodecontrol"><xsl:call-template name="nodecontrol"/></xsl:variable>
  <xsl:variable name="hier"><xsl:value-of select="concat($hierarchy, $nodecontrol)"/></xsl:variable>
  <div>
    <xsl:call-template name="treenode">
      <xsl:with-param name="hierarchy"><xsl:value-of select="$hier"/></xsl:with-param>
      <xsl:with-param name="label"><xsl:call-template name="nodelabel"/></xsl:with-param>
    </xsl:call-template>
    <xsl:apply-templates mode="render">
      <xsl:with-param name="hierarchy"><xsl:value-of select="$hier"/></xsl:with-param>
    </xsl:apply-templates>
  </div>
</xsl:template>




<xsl:template name="nodegroup"><xsl:param name="hierarchy"/><xsl:param name="label"/><xsl:param name="node-set"/>
  <xsl:variable name="hier">
    <xsl:choose>
    <xsl:when test="count($node-set)=0">
      <xsl:value-of select="substring($hierarchy,1,string-length($hierarchy)-1)"/>
      <xsl:value-of select="translate(substring($hierarchy,string-length($hierarchy)),'TL','tl')"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="$hierarchy"/>
    </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <div>
    <xsl:call-template name="treenode">
      <xsl:with-param name="hierarchy" select="$hier"/>
      <xsl:with-param name="label" select="$label"/>
    </xsl:call-template>

    <xsl:choose>
    <xsl:when test="$node-set/@Index">
      <xsl:apply-templates select="$node-set" mode="render">
        <xsl:with-param name="hierarchy" select="$hier"/>
        <xsl:sort select="@Index"/>
      </xsl:apply-templates>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-templates select="$node-set" mode="render">
        <xsl:with-param name="hierarchy" select="$hier"/>
      </xsl:apply-templates>
    </xsl:otherwise>
    </xsl:choose>
  </div>
</xsl:template>




<xsl:template name="treenode"><xsl:param name="hierarchy"/><xsl:param name="label"/>

  <xsl:variable name="opened" select="string-length($hierarchy) &lt; $initialexpand"/>
  <xsl:variable name="hidden" select="string-length($hierarchy) &gt; $initialexpand"/>

  <xsl:attribute name="onselectstart"><xsl:text>return false</xsl:text></xsl:attribute>
  <xsl:attribute name="ondragstart"><xsl:text>return false</xsl:text></xsl:attribute>
  <xsl:attribute name="id">treeNode<xsl:value-of select="generate-id()"/></xsl:attribute>
  <xsl:attribute name="style"><xsl:if test="$hidden">display: none;</xsl:if></xsl:attribute>

  <table border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td>
        <xsl:call-template name="nodehierarchy">
          <xsl:with-param name="hierarchy" select="$hierarchy"/>
          <xsl:with-param name="opened" select="$opened"/>
        </xsl:call-template>
      </td>

      <xsl:choose>
      <xsl:when test="substring($label,1,1)='#'">
        <td valign="middle" onclick="whenNodeSelected(this)">
          <img  class="icon" style="cursor: pointer">
          <xsl:attribute name="src">
          <xsl:text>images/</xsl:text>
          <xsl:choose>
            <xsl:when test="self::forms:Item and contains(@ItemType, '(Obsolete)')"><xsl:value-of select="translate(substring-before(@ItemType, '(Obsolete)'), ' ', '')"/></xsl:when>
            <xsl:when test="self::forms:Item and @ItemType"><xsl:value-of select="translate(@ItemType, ' ', '')"/></xsl:when>
            <xsl:when test="self::forms:Item">TextItem</xsl:when>
            <xsl:when test="self::forms:Canvas and @CanvasType='Content'">Canvas</xsl:when>
            <xsl:when test="self::forms:Canvas and @CanvasType"><xsl:value-of select="translate(@CanvasType, ' ', '')"/></xsl:when>
            <xsl:when test="self::forms:Canvas and descendant::forms:TabPage">Tab</xsl:when>
            <xsl:when test="self::forms:Canvas">Canvas</xsl:when>
            <xsl:when test="self::forms:Graphics and @GraphicsType"><xsl:value-of select="translate(@GraphicsType, ' ', '')"/></xsl:when>
            <xsl:when test="self::forms:Graphics">Rectangle</xsl:when>
            <xsl:when test="self::forms:ObjectGroupChild and @Type"><xsl:value-of select="translate(@Type, ' ', '')"/></xsl:when>
            <xsl:otherwise><xsl:value-of select="name()"/></xsl:otherwise>
          </xsl:choose>
          <xsl:if test="@ParentName or @SubclassSubObject='true'">Sub</xsl:if>
          <xsl:text>.png</xsl:text>
          </xsl:attribute>
          </img>
        </td>
        <td valign="middle" nowrap="true" class="nodeitem" onclick="whenNodeSelected(this)">
          <xsl:value-of select="substring($label, 2)"/>
        </td>
      </xsl:when>
      <xsl:otherwise>
        <td valign="middle" nowrap="true" class="nodegroup">
          <xsl:value-of select="$label"/>
        </td>
      </xsl:otherwise>
      </xsl:choose>
    </tr>
  </table>

  <div>
    <xsl:attribute name="id">nodeProperties<xsl:value-of select="generate-id()"/></xsl:attribute>
    <xsl:attribute name="style">display: none;</xsl:attribute>
    <table border="0" cellspacing="0" cellpadding="1" width="100%">
    <tr class="toolbar" height="20">
    <td class="nodevalue" nowrap="true" colspan="2"><xsl:value-of select="concat(name(), ': ', translate($label, '#', ''))"/></td>
    </tr>
    <xsl:for-each select="@*|forms:Coordinate/@*[ancestor::forms:FormModule]">
      <tr height="22">
      <td class="nodeprop" nowrap="true" width="150"><xsl:value-of select="name()"/></td>
      <td class="nodevalue" nowrap="true">
        <xsl:choose>
        <xsl:when test="string-length(.)&gt;40 or contains(., '&amp;#')">
          <input type="button" class="nodevalue" name="More" value="More...">
          <xsl:attribute name="ONCLICK">
            <xsl:text>showText(</xsl:text>
              <xsl:text>'</xsl:text><xsl:value-of select="translate($label, '#-$ ', '')"/><xsl:text>', </xsl:text>
              <xsl:text>'</xsl:text><xsl:value-of select="concat(name(), ': ', translate($label, '#', ''))"/><xsl:text>', </xsl:text>

              <xsl:text>'</xsl:text>
                <xsl:call-template name="replace-string">
                <xsl:with-param name="text">
                  <xsl:call-template name="replace-string">
                  <xsl:with-param name="text">
                    <xsl:call-template name="replace-string">
                    <xsl:with-param name="text" select="."/>
                    <xsl:with-param name="from" select="'\'"/>
                    <xsl:with-param name="to" select="'\\'"/>
                    </xsl:call-template>
                  </xsl:with-param>
                  <xsl:with-param name="from" select="$apos"/>
                  <xsl:with-param name="to" select="concat('\',$apos)"/>
                  </xsl:call-template>
                </xsl:with-param>
                <xsl:with-param name="from" select="'&amp;#10;'"/>
                <xsl:with-param name="to" select="'&lt;br&gt;'"/>
                </xsl:call-template>
              <xsl:text>')</xsl:text>

          </xsl:attribute>
          </input>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="."/>&#160;
        </xsl:otherwise>
        </xsl:choose>
      </td>

      </tr>
    </xsl:for-each>
    </table>
  </div>

</xsl:template>



<xsl:template name="nodehierarchy"><xsl:param name="hierarchy"/><xsl:param name="opened"/>
  <xsl:variable name="icon"><xsl:value-of select="substring($hierarchy,1,1)"/></xsl:variable>
  <xsl:choose>
  <xsl:when test="substring($hierarchy, 2)">
    <xsl:choose>
    <xsl:when test="$icon='T' or $icon='t'">
      <img class="hiericon" src="images/I.png"/>
    </xsl:when>
    <xsl:when test="$icon='L' or $icon='l'">
      <img class="hiericon" src="images/blank.png"/>
    </xsl:when>
    </xsl:choose>

    <xsl:call-template name="nodehierarchy">
      <xsl:with-param name="hierarchy" select="substring($hierarchy, 2)"/>
      <xsl:with-param name="opened" select="$opened"/>
    </xsl:call-template>
  </xsl:when>
  <xsl:otherwise>
    <xsl:choose>
    <xsl:when test="$icon='T'">
      <img class="hiericon" src="images/Tplus.png" src_opened="images/Tminus.png" src_closed="images/Tplus.png" onclick="whenNodeClicked(this)">
      <xsl:if test="$opened"><xsl:attribute name="src">images/Tminus.png</xsl:attribute></xsl:if>
      <xsl:attribute name="id">nodeControl<xsl:value-of select="generate-id()"/></xsl:attribute>
      </img>
    </xsl:when>
    <xsl:when test="$icon='L'">
      <img class="hiericon" src="images/Lplus.png" src_opened="images/Lminus.png" src_closed="images/Lplus.png" onclick="whenNodeClicked(this)">
      <xsl:if test="$opened"><xsl:attribute name="src">images/Lminus.png</xsl:attribute></xsl:if>
      <xsl:attribute name="id">nodeControl<xsl:value-of select="generate-id()"/></xsl:attribute>
      </img>
    </xsl:when>
    <xsl:when test="$icon='t'">
      <img class="hiericon" src="images/T.png"/>
    </xsl:when>
    <xsl:when test="$icon='l'">
      <img class="hiericon" src="images/L.png"/>
    </xsl:when>
    </xsl:choose>
  </xsl:otherwise>
  </xsl:choose>

</xsl:template>


<xsl:template name="nodelabel">
  <xsl:choose>
    <xsl:when test="self::forms:Module"><xsl:text>Forms</xsl:text></xsl:when>
    <xsl:when test="@Name">#<xsl:value-of select="@Name"/></xsl:when>
    <xsl:when test="@Label">#<xsl:value-of select="@Label"/></xsl:when>
    <xsl:when test="@Value">#<xsl:value-of select="@Value"/></xsl:when>
    <xsl:otherwise>#<xsl:value-of select="name()"/></xsl:otherwise>
  </xsl:choose>
</xsl:template>


<xsl:template name="nodecontrol">
  <xsl:variable name="node-set"><xsl:value-of select="name()"/></xsl:variable>
  <xsl:choose>
    <xsl:when test="child::node()">
      <xsl:choose>
        <xsl:when test="count(following-sibling::*[name() = $node-set]) &gt; 0">T</xsl:when>
        <xsl:otherwise>L</xsl:otherwise>
      </xsl:choose>
    </xsl:when>
    <xsl:otherwise>
      <xsl:choose>
        <xsl:when test="count(following-sibling::*[name() = $node-set]) &gt; 0">t</xsl:when>
        <xsl:otherwise>l</xsl:otherwise>
      </xsl:choose>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>


<xsl:template name="replace-string">
  <xsl:param name="text"/>
  <xsl:param name="from"/>
  <xsl:param name="to"/>
  <xsl:choose>
    <xsl:when test="contains($text, $from)">
      <xsl:variable name="before" select="substring-before($text, $from)"/>
      <xsl:variable name="after" select="substring-after($text, $from)"/>
      <xsl:variable name="prefix" select="concat($before, $to)"/>
      <xsl:value-of select="concat($before,$to)"/>
      <xsl:call-template name="replace-string">
        <xsl:with-param name="text" select="$after"/>
        <xsl:with-param name="from" select="$from"/>
        <xsl:with-param name="to" select="$to"/>
      </xsl:call-template>
    </xsl:when> 
    <xsl:otherwise>
      <xsl:value-of select="$text"/>  
    </xsl:otherwise>
  </xsl:choose>            
</xsl:template>


</xsl:stylesheet>
