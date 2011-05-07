<?xml version='1.0' encoding='utf-8'?>

<!-- XHTML-to-Article converter by Fletcher Penney
	specifically designed for use with Markdown created XHTML
	
	Uses the LaTeX article class for output
	
	Version 2.1.1
-->

<!--
/======================================================================= 
|	Minor modifications by Timothy Vismor
|	May 2010 
|=======================================================================
|	
|	This file generates an article (one-sided) with a table of contents.
|
|   Most of the grunt work is delegated to the stylesheet:
|   article_c_only_xhtml2latex.xslt
|	
|	Modifications are intended to make output more compatible with 
|	the static page maintenance workflow at vismor.com.
|	
|   For a more complete picture of the changes, diff this file against
|   article.xslt in the standard MMD distribution. You can also search 
|   this file for "vismor" to find modifed areas.
\=======================================================================
-->

<!-- 
# Copyright (C) 2005  Fletcher T. Penney <fletcher@freeshell.org>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the
#    Free Software Foundation, Inc.
#    59 Temple Place, Suite 330
#    Boston, MA 02111-1307 USA
-->

<!-- To Do
-->
	
<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:html="http://www.w3.org/1999/xhtml"
	version="1.0">

	<!-- ===== vismor ===== -->
	<xsl:import href="article_c_xhtml2latex.xslt"/>
	<!-- ================== -->

	<xsl:output method='text' encoding='utf-8' omit-xml-declaration = 'yes'/>

	<xsl:strip-space elements="*" />

	<xsl:template match="/">
		<xsl:apply-templates select="html:html/html:head"/>
		<xsl:apply-templates select="html:html/html:body"/>
		<xsl:call-template name="latex-footer"/>
	</xsl:template>
	
	<xsl:template name="latex-document-class">
<xsl:text>\documentclass[11pt,oneside]{article}
	</xsl:text>
	</xsl:template>
	
	<!-- Convert headers into sections, etc -->
	
	<xsl:template match="html:h1">
		<xsl:text>\section{</xsl:text>
		<xsl:apply-templates select="node()"/>
		<xsl:text>}</xsl:text>
		<xsl:value-of select="$newline"/>
		<xsl:text>\label{</xsl:text>
		<xsl:value-of select="@id"/>
		<xsl:text>}</xsl:text>
		<xsl:value-of select="$newline"/>
		<xsl:value-of select="$newline"/>
	</xsl:template>

	<xsl:template match="html:h2">
		<xsl:text>\subsection{</xsl:text>
		<xsl:apply-templates select="node()"/>
		<xsl:text>}</xsl:text>
		<xsl:value-of select="$newline"/>
		<xsl:text>\label{</xsl:text>
		<xsl:value-of select="@id"/>
		<xsl:text>}</xsl:text>
		<xsl:value-of select="$newline"/>
		<xsl:value-of select="$newline"/>
	</xsl:template>

	<xsl:template match="html:h3">
		<xsl:text>\subsubsection{</xsl:text>
		<xsl:apply-templates select="node()"/>
		<xsl:text>}</xsl:text>
		<xsl:value-of select="$newline"/>
		<xsl:text>\label{</xsl:text>
		<xsl:value-of select="@id"/>
		<xsl:text>}</xsl:text>
		<xsl:value-of select="$newline"/>
		<xsl:value-of select="$newline"/>
	</xsl:template>

	<xsl:template match="html:h4">
		<xsl:text>\textbf{</xsl:text>
		<xsl:apply-templates select="node()"/>
		<xsl:text>}</xsl:text>
		<xsl:value-of select="$newline"/>
		<xsl:text>\label{</xsl:text>
		<xsl:value-of select="@id"/>
		<xsl:text>}</xsl:text>
		<xsl:value-of select="$newline"/>
		<xsl:value-of select="$newline"/>
	</xsl:template>

	<xsl:template match="html:h5">
		<xsl:text>{\itshape </xsl:text>
		<xsl:apply-templates select="node()"/>
		<xsl:value-of select="$newline"/>
		<xsl:text>\label{</xsl:text>
		<xsl:value-of select="@id"/>
		<xsl:text>}</xsl:text>
		<xsl:value-of select="$newline"/>
		<xsl:value-of select="$newline"/>
	</xsl:template>

	<xsl:template match="html:h6">
		<xsl:apply-templates select="node()"/>
		<xsl:value-of select="$newline"/>
		<xsl:text>\label{</xsl:text>
		<xsl:value-of select="@id"/>
		<xsl:text>}</xsl:text>
		<xsl:value-of select="$newline"/>
		<xsl:value-of select="$newline"/>
	</xsl:template>

	<!-- code block -->
	<xsl:template match="html:pre[child::html:code]">
		<xsl:text>\begin{verbatim}

</xsl:text>
		<xsl:value-of select="./html:code"/>
		<xsl:text>

\end{verbatim}

</xsl:text>
	</xsl:template>

	<!-- support for abstracts -->
	
	<xsl:template match="html:h1[1][translate(.,'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
	'abcdefghijklmnopqrstuvwxyz') = 'abstract']">
		<xsl:text>\begin{abstract}</xsl:text>
		<xsl:value-of select="$newline"/>
		<xsl:text>\label{</xsl:text>
		<xsl:value-of select="@id"/>
		<xsl:text>}</xsl:text>
		<xsl:value-of select="$newline"/>
		<xsl:value-of select="$newline"/>
	</xsl:template>
	
	<xsl:template match="html:h1[position()='2'][preceding-sibling::html:h1[position()='1'][translate(.,'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
		'abcdefghijklmnopqrstuvwxyz') = 'abstract']]">
		<xsl:text>\end{abstract}</xsl:text>
		<xsl:value-of select="$newline"/>
		<xsl:value-of select="$newline"/>
		<xsl:choose>
			<xsl:when test="substring(node(), (string-length(node()) - string-length('*')) + 1) = '*'">
				<xsl:text>\section*{}</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>\section{</xsl:text>
				<xsl:apply-templates select="node()"/>
				<xsl:text>}</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:value-of select="$newline"/>
		<xsl:text>\label{</xsl:text>
		<xsl:value-of select="@id"/>
		<xsl:text>}</xsl:text>
		<xsl:value-of select="$newline"/>
		<xsl:value-of select="$newline"/>
	</xsl:template>
	
</xsl:stylesheet>