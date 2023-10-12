Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF6F2AB39
	for <linux-cxl@vger.kernel.org>; Thu, 12 Oct 2023 18:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CknMZ7Sn"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF22C0
	for <linux-cxl@vger.kernel.org>; Thu, 12 Oct 2023 11:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697136902; x=1728672902;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0ME855GyU48qI0eE3OisiPHzr9ullnbGHFfAJjngQPE=;
  b=CknMZ7Sn6LhTMZNuflbg3+JaC5BzGZHHYp/nDRtTxd0QW/FzFeSmSJB3
   tbpjhAvvY0BxLaxht+RUTwSR1AfoS0vTVs4VeCkn65b5vDrSZFayWg7lZ
   tqRbDuT0Vq5cAQWzT+iX46TPUpDAFfkquzzW+B6vmio3zxxQAxW/cf2A2
   qaKfe69BbP/+Sp1sB+/+oBhCNmIP6H4p1D13xsMw1/QCcqdg9e7v0nCQ0
   ptiYY9KDTvYEKu0v+3yYwwef7FDbSrkdExBt9fMfpHRf6tTJFJfvshrDd
   aZbnHhJ366om3KWX3N4d2D1TSRs8aG/YuErm07OBmOqVcHX/6YoeKgjeS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="388880345"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="388880345"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 11:54:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="870711520"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="870711520"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.15.16])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 11:54:55 -0700
Subject: [PATCH v11 14/22] cxl: Add callback to parse the SSLBIS subtable from
 CDAT
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date: Thu, 12 Oct 2023 11:54:54 -0700
Message-ID: <169713689498.2205276.17152557836753299107.stgit@djiang5-mobl3>
In-Reply-To: <169713674328.2205276.10184241477215488339.stgit@djiang5-mobl3>
References: <169713674328.2205276.10184241477215488339.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Provide a callback to parse the Switched Scoped Latency and Bandwidth
Information Structure (SSLBIS) in the CDAT structures. The SSLBIS
contains the bandwidth and latency information that's tied to the
CXL switch that the data table has been read from. The extracted
values are stored to the cxl_dport correlated by the port_id
depending on the SSLBIS entry.

Coherent Device Attribute Table 1.03 2.1 Switched Scoped Latency
and Bandwidth Information Structure (DSLBIS)

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/cdat.c |   93 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h       |    8 ++++
 drivers/cxl/port.c      |    6 +++
 3 files changed, 107 insertions(+)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index 361983393666..f233cebca37a 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -153,4 +153,97 @@ void cxl_cdat_dsmas_list_destroy(struct list_head *dsmas_list)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_cdat_dsmas_list_destroy, CXL);
 
+static int cdat_sslbis_handler(union acpi_subtable_headers *header, void *arg,
+			       const unsigned long end)
+{
+	struct acpi_cdat_sslbis *sslbis;
+	int size = sizeof(header->cdat) + sizeof(*sslbis);
+	struct cxl_port *port = arg;
+	struct device *dev = &port->dev;
+	struct acpi_cdat_sslbe *entry;
+	int remain, entries, i;
+	u16 len;
+
+	len = le16_to_cpu((__force __le16)header->cdat.length);
+	remain = len - size;
+	if (!remain || remain % sizeof(*entry) ||
+	    (unsigned long)header + len > end) {
+		dev_warn(dev, "Malformed SSLBIS table length: (%u)\n", len);
+		return -EINVAL;
+	}
+
+	/* Skip common header */
+	sslbis = (struct acpi_cdat_sslbis *)((unsigned long)header +
+					     sizeof(header->cdat));
+
+	/* Unrecognized data type, we can skip */
+	if (sslbis->data_type > ACPI_HMAT_WRITE_BANDWIDTH)
+		return 0;
+
+	entries = remain / sizeof(*entry);
+	entry = (struct acpi_cdat_sslbe *)((unsigned long)header + sizeof(*sslbis));
+
+	for (i = 0; i < entries; i++) {
+		u16 x = le16_to_cpu((__force __le16)entry->portx_id);
+		u16 y = le16_to_cpu((__force __le16)entry->porty_id);
+		__le64 le_base;
+		__le16 le_val;
+		struct cxl_dport *dport;
+		unsigned long index;
+		u16 dsp_id;
+		u64 val;
+
+		switch (x) {
+		case ACPI_CDAT_SSLBIS_US_PORT:
+			dsp_id = y;
+			break;
+		case ACPI_CDAT_SSLBIS_ANY_PORT:
+			switch (y) {
+			case ACPI_CDAT_SSLBIS_US_PORT:
+				dsp_id = x;
+				break;
+			case ACPI_CDAT_SSLBIS_ANY_PORT:
+				dsp_id = ACPI_CDAT_SSLBIS_ANY_PORT;
+				break;
+			default:
+				dsp_id = y;
+				break;
+			}
+			break;
+		default:
+			dsp_id = x;
+			break;
+		}
+
+		le_base = (__force __le64)sslbis->entry_base_unit;
+		le_val = (__force __le16)entry->latency_or_bandwidth;
+
+		if (check_mul_overflow(le64_to_cpu(le_base),
+				       le16_to_cpu(le_val), &val))
+			dev_warn(dev, "SSLBIS value overflowed!\n");
+
+		xa_for_each(&port->dports, index, dport) {
+			if (dsp_id == ACPI_CDAT_SSLBIS_ANY_PORT ||
+			    dsp_id == dport->port_id)
+				cxl_access_coordinate_set(&dport->coord,
+							  sslbis->data_type,
+							  val);
+		}
+
+		entry++;
+	}
+
+	return 0;
+}
+
+int cxl_cdat_switch_process(struct cxl_port *port)
+{
+	int rc;
+
+	rc = cdat_table_parse(ACPI_CDAT_TYPE_SSLBIS, cdat_sslbis_handler,
+			      port, port->cdat.table);
+	return cdat_table_parse_output(rc);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_cdat_switch_process, CXL);
+
 MODULE_IMPORT_NS(CXL);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index dc3b3b746c70..2d1fd6d0cce5 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -630,6 +630,7 @@ struct cxl_rcrb_info {
  * @rcrb: Data about the Root Complex Register Block layout
  * @rch: Indicate whether this dport was enumerated in RCH or VH mode
  * @port: reference to cxl_port that contains this downstream port
+ * @coord: access coordinates (performance) for switch from CDAT
  */
 struct cxl_dport {
 	struct device *dport_dev;
@@ -638,6 +639,7 @@ struct cxl_dport {
 	struct cxl_rcrb_info rcrb;
 	bool rch;
 	struct cxl_port *port;
+	struct access_coordinate coord;
 };
 
 /**
@@ -837,6 +839,7 @@ struct dsmas_entry {
 #ifdef CONFIG_FIRMWARE_TABLE
 int cxl_cdat_endpoint_process(struct cxl_port *port, struct list_head *list);
 void cxl_cdat_dsmas_list_destroy(struct list_head *dsmas_list);
+int cxl_cdat_switch_process(struct cxl_port *port);
 #else
 static inline int cxl_cdat_endpoint_process(struct cxl_port *port,
 					    struct list_head *list)
@@ -847,6 +850,11 @@ static inline int cxl_cdat_endpoint_process(struct cxl_port *port,
 static inline void cxl_cdat_dsmas_list_destroy(struct list_head *dsmas_list)
 {
 }
+
+static inline int cxl_cdat_switch_process(struct cxl_port *port)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 
 /*
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index cceee9dbae2c..f5e2be79f217 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -78,6 +78,12 @@ static int cxl_switch_port_probe(struct cxl_port *port)
 		return PTR_ERR(cxlhdm);
 	}
 
+	if (port->cdat.table) {
+		rc = cxl_cdat_switch_process(port);
+		if (rc < 0)
+			dev_warn(&port->dev, "Failed to parse SSLBIS: %d\n", rc);
+	}
+
 	if (rc == 1) {
 		dev_dbg(&port->dev, "Fallback to passthrough decoder\n");
 		return devm_cxl_add_passthrough_decoder(port);


