<?xml version="1.0" ?>
<xsl:stylesheet version="1.0"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:marc="http://www.loc.gov/MARC21/slim">
	<xsl:output method="text" indent="yes" />

	<xsl:template match="/marc:collection">
		<xsl:apply-templates select="marc:record" />
	</xsl:template>

	<xsl:template match="marc:record">
		<xsl:if test="marc:datafield[@tag='260']">
			<xsl:apply-templates select="marc:controlfield[@tag='001']" />
			<xsl:text>	</xsl:text>
			<xsl:apply-templates select="marc:datafield[@tag='260']" />
			<xsl:text>	</xsl:text>
			<xsl:apply-templates select="marc:datafield[@tag='955']" />
			<xsl:text>	</xsl:text>
			<xsl:text>
</xsl:text>
		</xsl:if>
	</xsl:template>

	<xsl:template match="/marc:record/marc:controlfield[@tag='001']">
		<xsl:value-of select="@tag" />
	</xsl:template>

	<xsl:template match="//marc:datafield[@tag='955']">
		<xsl:value-of select="marc:subfield[@code='b']" />
		<xsl:text>	</xsl:text>
		<xsl:value-of select="marc:subfield[@code='3']" />
	</xsl:template>

	<!-- Se il 260$c è presente, purtroppo può essere multiplo, come verificato 
		in alcuni file di input. Quindi è il caso di segnalare il numero di ripetizioni. 
		Ma c'è anche il caso in cui manca, e in questo caso è necessario lasciare 
		vuoto il posto per ottenere una tabella coerente. Si verifica  -->

	<xsl:template match="//marc:datafield[@tag='260']">
		<xsl:value-of select="count(marc:subfield[@code='c'])" />
		<xsl:text>	</xsl:text>
		<xsl:for-each select="marc:subfield[@code='c']">
			<xsl:choose>
			 <xsl:when test="translate(substring(., 1, 4), '123456789', '000000000') = '0000'">
				<xsl:value-of select="." />
			</xsl:when>
			<xsl:when test="translate(substring(., 2, 4), '123456789', '000000000') = '0000'">
				<xsl:value-of select="." />
			</xsl:when>
			<xsl:when test="translate(substring(., 2, 3), '123456789', '000000000') = '000'">
				<xsl:value-of select="." />
			</xsl:when>
			<xsl:when test="translate(substring(., 8, 4), '123456789', '000000000') = '0000'">
				<xsl:value-of select="." />
			</xsl:when>
			</xsl:choose>
		</xsl:for-each>
		<xsl:if test="not(marc:subfield[@code='c'])">
			<xsl:text></xsl:text>
		</xsl:if>
	</xsl:template>

	<!-- <xsl:template match="//marc:subfield"> <xsl:if test="translate(@code['c'], 
		'123456789', '000000000') = '0000'"> <xsl:value-of select="@code['c']"/> 
		</xsl:if> </xsl:template> -->

</xsl:stylesheet>
