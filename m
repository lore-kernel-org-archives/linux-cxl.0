Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B6226AC0
	for <linux-cxl@vger.kernel.org>; Tue, 14 Nov 2023 23:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ePZM185t"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8CDDF
	for <linux-cxl@vger.kernel.org>; Tue, 14 Nov 2023 15:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700003108; x=1731539108;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OXAw+80/2GsMzJEVujkBdmSsNy+tJEEihVXz42gK0Qc=;
  b=ePZM185t+vOoVcILgB4cKL3XP1ZbrHovZqjV0+2p3Fj0o3KhlB3SCM8U
   ayv6zXgt/LBtRHI6DnS0S/kjMyR9aVwP79AnEJ0fGyNxPRIKw/RG2OZmD
   e2awgpI/yRi6JHJkd3MzwLke2vRze8T/NLXKa/tKdZWqnR/1Yki+Do2KA
   SWKdoM2gZa4aEiy9JpF4vznkVcR8TrrlDRB6HmZpQ1wlxMBy/gGcx2D7W
   Fu0PCHAm4CM42ikxEP/QNqnFRgmRXG3yAM0xlgB0C8n9+lZbIzBG7SJSo
   W5sBeGH/HcgxTWx243Ztjjc/bRRgFieQ4Cs1CO9GUi2bFgIyDJhb+wAVG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="389617279"
X-IronPort-AV: E=Sophos;i="6.03,303,1694761200"; 
   d="scan'208";a="389617279"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 15:05:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="764804934"
X-IronPort-AV: E=Sophos;i="6.03,303,1694761200"; 
   d="scan'208";a="764804934"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.87.32])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 15:05:07 -0800
Subject: [PATCH v12 10/18] cxl: Add callback to parse the SSLBIS subtable from
 CDAT
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date: Tue, 14 Nov 2023 16:05:06 -0700
Message-ID: <170000310683.1974471.17733007158430004767.stgit@djiang5-mobl3>
In-Reply-To: <170000290509.1974471.16084327074615798619.stgit@djiang5-mobl3>
References: <170000290509.1974471.16084327074615798619.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

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
v12:
- Change dport->coord to dport->sw_coord to clarify variable naming
---
 drivers/cxl/core/cdat.c |   93 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h       |    3 ++
 drivers/cxl/port.c      |    6 +++
 3 files changed, 102 insertions(+)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index 361983393666..48be43de2388 100644
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
+				cxl_access_coordinate_set(&dport->sw_coord,
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
index 8460fff8bae5..f971eef19fb0 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -636,6 +636,7 @@ struct cxl_rcrb_info {
  * @rch: Indicate whether this dport was enumerated in RCH or VH mode
  * @port: reference to cxl_port that contains this downstream port
  * @regs: Dport parsed register blocks
+ * @sw_coord: access coordinates (performance) for switch from CDAT
  */
 struct cxl_dport {
 	struct device *dport_dev;
@@ -645,6 +646,7 @@ struct cxl_dport {
 	bool rch;
 	struct cxl_port *port;
 	struct cxl_regs regs;
+	struct access_coordinate sw_coord;
 };
 
 /**
@@ -851,6 +853,7 @@ struct dsmas_entry {
 
 int cxl_cdat_endpoint_process(struct cxl_port *port, struct list_head *list);
 void cxl_cdat_dsmas_list_destroy(struct list_head *dsmas_list);
+int cxl_cdat_switch_process(struct cxl_port *port);
 
 /*
  * Unit test builds overrides this to __weak, find the 'strong' version
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


