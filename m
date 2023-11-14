Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0111B26AD1
	for <linux-cxl@vger.kernel.org>; Tue, 14 Nov 2023 23:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kjf4UJvm"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768B4D0
	for <linux-cxl@vger.kernel.org>; Tue, 14 Nov 2023 15:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700003102; x=1731539102;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8oerv+J8v2Dq8mG9TwkwVmC+4X9DQ4eOrA6iboNDLhU=;
  b=Kjf4UJvmGUfn7YgEwkZz/gHKXRQ4CbdiUt71bES7X95Ib141EQQ/ZG6n
   s+vi+4P1skaQBcMkRbOqpUi/HntUMtIIP9RymLl0kmDO6LGOm1ybgO64J
   QHZDytIh4YAqLomlLNzvnlrrFh5COS4IcQVAaqFYshyuPmFje6jvHy9sm
   WUW/rwv289n5ESzfQvYSgJ7j0z01iisyIbnH2PwpqeOJ5PuI9TXOt0/7Z
   mF7Q3tcbXLa9WdgfOeA581ekwLUy6d2J2aERZ/IGiJ30ki+nStdLK9Y8U
   N7Dga7EnSk9BX1s8o1/dOkse05MBavvhdCvT1WjZyCnooEZyPZ3YGY70/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="389617270"
X-IronPort-AV: E=Sophos;i="6.03,303,1694761200"; 
   d="scan'208";a="389617270"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 15:05:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="764804910"
X-IronPort-AV: E=Sophos;i="6.03,303,1694761200"; 
   d="scan'208";a="764804910"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.87.32])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 15:05:01 -0800
Subject: [PATCH v12 09/18] cxl: Add callback to parse the DSLBIS subtable from
 CDAT
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date: Tue, 14 Nov 2023 16:05:00 -0700
Message-ID: <170000310041.1974471.14223245481796965869.stgit@djiang5-mobl3>
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

Provide a callback to parse the Device Scoped Latency and Bandwidth
Information Structure (DSLBIS) in the CDAT structures. The DSLBIS
contains the bandwidth and latency information that's tied to a DSMAS
handle. The driver will retrieve the read and write latency and
bandwidth associated with the DSMAS which is tied to a DPA range.

Coherent Device Attribute Table 1.03 2.1 Device Scoped Latency and
Bandwidth Information Structure (DSLBIS)

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/cdat.c |  102 ++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/cxl/cxl.h       |    2 +
 2 files changed, 102 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index a858fd1b5744..361983393666 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -2,6 +2,7 @@
 /* Copyright(c) 2023 Intel Corporation. All rights reserved. */
 #include <linux/acpi.h>
 #include <linux/fw_table.h>
+#include <linux/overflow.h>
 #include "cxlpci.h"
 #include "cxl.h"
 
@@ -37,10 +38,107 @@ static int cdat_dsmas_handler(union acpi_subtable_headers *header, void *arg,
 	return 0;
 }
 
+static void cxl_access_coordinate_set(struct access_coordinate *coord,
+				      int access, unsigned int val)
+{
+	switch (access) {
+	case ACPI_HMAT_ACCESS_LATENCY:
+		coord->read_latency = val;
+		coord->write_latency = val;
+		break;
+	case ACPI_HMAT_READ_LATENCY:
+		coord->read_latency = val;
+		break;
+	case ACPI_HMAT_WRITE_LATENCY:
+		coord->write_latency = val;
+		break;
+	case ACPI_HMAT_ACCESS_BANDWIDTH:
+		coord->read_bandwidth = val;
+		coord->write_bandwidth = val;
+		break;
+	case ACPI_HMAT_READ_BANDWIDTH:
+		coord->read_bandwidth = val;
+		break;
+	case ACPI_HMAT_WRITE_BANDWIDTH:
+		coord->write_bandwidth = val;
+		break;
+	}
+}
+
+static int cdat_dslbis_handler(union acpi_subtable_headers *header, void *arg,
+			       const unsigned long end)
+{
+	struct acpi_cdat_header *hdr = &header->cdat;
+	struct acpi_cdat_dslbis *dslbis;
+	int size = sizeof(*hdr) + sizeof(*dslbis);
+	struct list_head *dsmas_list = arg;
+	struct dsmas_entry *dent;
+	u16 len;
+
+	len = le16_to_cpu((__force __le16)hdr->length);
+	if (len != size || (unsigned long)hdr + len > end) {
+		pr_warn("Malformed DSLBIS table length: (%u:%u)\n", size, len);
+		return -EINVAL;
+	}
+
+	/* Skip common header */
+	dslbis = (struct acpi_cdat_dslbis *)(hdr + 1);
+
+	/* Skip unrecognized data type */
+	if (dslbis->data_type > ACPI_HMAT_WRITE_BANDWIDTH)
+		return 0;
+
+	list_for_each_entry(dent, dsmas_list, list) {
+		__le64 le_base;
+		__le16 le_val;
+		u64 val;
+		int rc;
+
+		if (dslbis->handle != dent->handle)
+			continue;
+
+		/* Not a memory type, skip */
+		if ((dslbis->flags & ACPI_HMAT_MEMORY_HIERARCHY) !=
+		    ACPI_HMAT_MEMORY)
+			return 0;
+
+		le_base = (__force __le64)dslbis->entry_base_unit;
+		le_val = (__force __le16)dslbis->entry[0];
+		rc = check_mul_overflow(le64_to_cpu(le_base),
+					le16_to_cpu(le_val), &val);
+		if (rc)
+			pr_warn("DSLBIS value overflowed.\n");
+
+		cxl_access_coordinate_set(&dent->coord, dslbis->data_type, val);
+		break;
+	}
+
+	return 0;
+}
+
+static int cdat_table_parse_output(int rc)
+{
+	if (rc < 0)
+		return rc;
+	if (rc == 0)
+		return -ENOENT;
+
+	return 0;
+}
+
 int cxl_cdat_endpoint_process(struct cxl_port *port, struct list_head *list)
 {
-	return cdat_table_parse(ACPI_CDAT_TYPE_DSMAS, cdat_dsmas_handler,
-				list, port->cdat.table);
+	int rc;
+
+	rc = cdat_table_parse(ACPI_CDAT_TYPE_DSMAS, cdat_dsmas_handler,
+			      list, port->cdat.table);
+	rc = cdat_table_parse_output(rc);
+	if (rc)
+		return rc;
+
+	rc = cdat_table_parse(ACPI_CDAT_TYPE_DSLBIS, cdat_dslbis_handler,
+			      list, port->cdat.table);
+	return cdat_table_parse_output(rc);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_cdat_endpoint_process, CXL);
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index be75ffb22e00..8460fff8bae5 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -8,6 +8,7 @@
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/list.h>
+#include <linux/node.h>
 #include <linux/log2.h>
 #include <linux/io.h>
 
@@ -845,6 +846,7 @@ struct dsmas_entry {
 	struct list_head list;
 	struct range dpa_range;
 	u8 handle;
+	struct access_coordinate coord;
 };
 
 int cxl_cdat_endpoint_process(struct cxl_port *port, struct list_head *list);


