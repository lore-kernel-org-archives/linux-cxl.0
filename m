Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UrqlA5XE"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9698E
	for <linux-cxl@vger.kernel.org>; Wed, 13 Dec 2023 08:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702485741; x=1734021741;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I41UaSk1YI5CVNyHeLfQhSypM46oo+wdfHOOJ9yxhqA=;
  b=UrqlA5XEM88DgFug3gj/4oRupJel02KSUMUja8s/FwEtF8p7JJxRo4VJ
   VdrDEKgzY3Lr5Nfe9An1ZTZrMNS8H0OFWKxzrR0ILQgxiF1c8qbEKWp53
   X7w9MxUP0jyPbo3VaxkYJ5QWlvrm1acRYsT9I5Ja6FfiXQbaIjPE6sOqo
   iU88THs0OSAp547T8z4jz9HsG03Osp/rDYv6CrkOm9TtQsQKowrjDsdrC
   V6OOOKFxYN4yXCD/YT0mfLudxC7Cytd0XYSNPT7mkQp52emAW8aPYHD45
   nr6myNVJzRTtBmnTdMlMiSDrU3LC7bkHCDNdd580YYPsb1OKdp9vJsAOG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="398833594"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="398833594"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 08:42:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="774009631"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="774009631"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.76.225])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 08:42:20 -0800
Subject: [PATCH v14 10/19] cxl: Add callback to parse the SSLBIS subtable from
 CDAT
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date: Wed, 13 Dec 2023 09:42:19 -0700
Message-ID: <170248573948.801570.10389626752781417811.stgit@djiang5-mobl3>
In-Reply-To: <170248552797.801570.14580769385012396142.stgit@djiang5-mobl3>
References: <170248552797.801570.14580769385012396142.stgit@djiang5-mobl3>
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
v14:
- Change to cxl_switch_parse_cdat() to keep naming consistent.
- Move parse of switch cdat to right after dport enumeration.
---
 drivers/cxl/core/cdat.c |   98 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h       |    4 ++
 drivers/cxl/port.c      |    2 +
 3 files changed, 104 insertions(+)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index 97d8ef8848c6..b3ab47d250e1 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -187,4 +187,102 @@ void cxl_endpoint_parse_cdat(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_endpoint_parse_cdat, CXL);
 
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
+void cxl_switch_parse_cdat(struct cxl_port *port)
+{
+	int rc;
+
+	if (!port->cdat.table)
+		return;
+
+	rc = cdat_table_parse(ACPI_CDAT_TYPE_SSLBIS, cdat_sslbis_handler,
+			      port, port->cdat.table);
+	rc = cdat_table_parse_output(rc);
+	if (rc)
+		dev_dbg(&port->dev, "Failed to parse SSLBIS: %d\n", rc);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_switch_parse_cdat, CXL);
+
 MODULE_IMPORT_NS(CXL);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index be3b5eda875c..22f664b9f4c6 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -8,6 +8,7 @@
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/log2.h>
+#include <linux/node.h>
 #include <linux/io.h>
 
 /**
@@ -634,6 +635,7 @@ struct cxl_rcrb_info {
  * @rch: Indicate whether this dport was enumerated in RCH or VH mode
  * @port: reference to cxl_port that contains this downstream port
  * @regs: Dport parsed register blocks
+ * @sw_coord: access coordinates (performance) for switch from CDAT
  */
 struct cxl_dport {
 	struct device *dport_dev;
@@ -643,6 +645,7 @@ struct cxl_dport {
 	bool rch;
 	struct cxl_port *port;
 	struct cxl_regs regs;
+	struct access_coordinate sw_coord;
 };
 
 /**
@@ -840,6 +843,7 @@ static inline struct cxl_dax_region *to_cxl_dax_region(struct device *dev)
 #endif
 
 void cxl_endpoint_parse_cdat(struct cxl_port *port);
+void cxl_switch_parse_cdat(struct cxl_port *port);
 
 /*
  * Unit test builds overrides this to __weak, find the 'strong' version
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index a889c4e6cb27..da3c3a08bd62 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -69,6 +69,8 @@ static int cxl_switch_port_probe(struct cxl_port *port)
 	if (rc < 0)
 		return rc;
 
+	cxl_switch_parse_cdat(port);
+
 	cxlhdm = devm_cxl_setup_hdm(port, NULL);
 	if (!IS_ERR(cxlhdm))
 		return devm_cxl_enumerate_decoders(cxlhdm, NULL);


