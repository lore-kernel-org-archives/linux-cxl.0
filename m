Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6DC2AB39
	for <linux-cxl@vger.kernel.org>; Thu, 12 Oct 2023 18:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A4DswgIN"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD61B7
	for <linux-cxl@vger.kernel.org>; Thu, 12 Oct 2023 11:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697136901; x=1728672901;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PNrprlIB9YWPsV23/DDHjo938JNKr71o1O2ok5LuLzw=;
  b=A4DswgIN8MZyOe8DbO6A4L0SsIOOivln1gZSl+zWXFizBW3D8BGnCB0e
   JxstKwk2clA8wI1ukGWM8Dt8M9TIsling4DUEQdtjfHg0Nujy+8kObtQ1
   howQMw2/TFkxuW5aHNrm6oprS9d9fJUiGDGRKRRBM+5uIOoQAcDbJv26v
   zr5GEcBnXKeH5s3FFiokgH2gj6VjDILJzG7bQ86YgdAYAYKthM1NwWvdS
   Ig8UwyYfgAECKMjiuyxM1vECYSVGfnhktwMvwPFP8KKtTTsyMy/sKlGtB
   E1V2ERSQZcc46A5O9Q6u5GxhuUO4j4bP6RpCBjY1MTM81mRFAvXFQ63b3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="388880325"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="388880325"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 11:54:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="870711490"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="870711490"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.15.16])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 11:54:49 -0700
Subject: [PATCH v11 13/22] cxl: Add callback to parse the DSLBIS subtable from
 CDAT
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date: Thu, 12 Oct 2023 11:54:49 -0700
Message-ID: <169713688916.2205276.18437749333119431904.stgit@djiang5-mobl3>
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
index be2fd8dcb37b..dc3b3b746c70 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -8,6 +8,7 @@
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/list.h>
+#include <linux/node.h>
 #include <linux/log2.h>
 #include <linux/io.h>
 
@@ -830,6 +831,7 @@ struct dsmas_entry {
 	struct list_head list;
 	struct range dpa_range;
 	u8 handle;
+	struct access_coordinate coord;
 };
 
 #ifdef CONFIG_FIRMWARE_TABLE


