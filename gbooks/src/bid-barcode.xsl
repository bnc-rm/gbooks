<?xml version="1.0" ?>
<xsl:stylesheet version="1.0"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:marc="http://www.loc.gov/MARC21/slim">
	<xsl:output method="text" indent="yes" />

	<xsl:template match="/marc:collection">
		<xsl:apply-templates select="marc:record" />
	</xsl:template>

	<xsl:template match="marc:record">
<!-- 		<xsl:if test="marc:datafield[@tag='260']"> -->
			<xsl:apply-templates select="marc:controlfield[@tag='001']" />
			<xsl:apply-templates select="marc:datafield[@tag='955']" />
			<xsl:text>
</xsl:text>
<!-- 		</xsl:if> -->
	</xsl:template>

	<xsl:template match="/marc:record/marc:controlfield[@tag='001']">
		<xsl:value-of select="@tag" />
	</xsl:template>

	<xsl:template match="//marc:datafield[@tag='955']">
		<xsl:for-each select="marc:subfield[@code='b']">
			<xsl:text>	</xsl:text>
			<xsl:value-of select="." />
		</xsl:for-each>
	</xsl:template>


</xsl:stylesheet>
