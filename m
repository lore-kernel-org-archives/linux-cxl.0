Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SLPbBLPz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4881735
	for <linux-cxl@vger.kernel.org>; Thu,  7 Dec 2023 14:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701989959; x=1733525959;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q7kXGZVdKcM7oGiIAFYeIGr5tb6dO9RfTvfLOEAEsZw=;
  b=SLPbBLPzmTqmR+q4SrOBjhy7FA+hyddlZIAmHUSH9IYiFFFTt8cn8w8P
   +g33kRBSEGNbb1uhMlu/RX4b86pRsykaj2jCCGxZQq/xf/aSCdOSBIZ2C
   i0jL7LJMfH8Kb54opWWpUZ5Bosmq/FM1gMhGMBR/uY9UmtDyRAR/vEGTd
   PzQOrdmBkRMe4uZql3Dc06i3OQ+NT75UtegdMbrS5aUYA3Md/2C6bFJ1e
   DtT7vLhG6wexXjw7yv+CS7GIyfJauDYB2EgXGivXUlkGhe80TqEKjVhmy
   nFB9J4du6lHrBswiEivebT3D226Saqv4WrgtsJOAiSjzgWWtc9FTu8Fp2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="1185230"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="1185230"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 14:59:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="842380466"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="842380466"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.213.168.225])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 14:59:17 -0800
Subject: [PATCH v13 09/19] cxl: Add callback to parse the DSLBIS subtable from
 CDAT
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date: Thu, 07 Dec 2023 15:59:17 -0700
Message-ID: <170198995712.3522351.4009211687790893974.stgit@djiang5-mobl3>
In-Reply-To: <170198976423.3522351.8359845516235306693.stgit@djiang5-mobl3>
References: <170198976423.3522351.8359845516235306693.stgit@djiang5-mobl3>
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
v13:
- Convert list usage to xarray (Dan)
---
 drivers/cxl/core/cdat.c |  100 ++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/cxl/cxl.h       |    2 +
 2 files changed, 100 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index 7b11c6631491..e8587406441d 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -2,6 +2,7 @@
 /* Copyright(c) 2023 Intel Corporation. All rights reserved. */
 #include <linux/acpi.h>
 #include <linux/fw_table.h>
+#include <linux/overflow.h>
 #include "cxlpci.h"
 #include "cxl.h"
 
@@ -43,10 +44,105 @@ static int cdat_dsmas_handler(union acpi_subtable_headers *header, void *arg,
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
+	struct xarray *dsmas_xa = arg;
+	struct dsmas_entry *dent;
+	__le64 le_base;
+	__le16 le_val;
+	u64 val;
+	u16 len;
+	int rc;
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
+	/* Not a memory type, skip */
+	if ((dslbis->flags & ACPI_HMAT_MEMORY_HIERARCHY) != ACPI_HMAT_MEMORY)
+		return 0;
+
+	dent = xa_load(dsmas_xa, dslbis->handle);
+	if (!dent) {
+		pr_warn("No matching DSMAS entry for DSLBIS entry.\n");
+		return 0;
+	}
+
+	le_base = (__force __le64)dslbis->entry_base_unit;
+	le_val = (__force __le16)dslbis->entry[0];
+	rc = check_mul_overflow(le64_to_cpu(le_base),
+				le16_to_cpu(le_val), &val);
+	if (rc)
+		pr_warn("DSLBIS value overflowed.\n");
+
+	cxl_access_coordinate_set(&dent->coord, dslbis->data_type, val);
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
 int cxl_cdat_endpoint_process(struct cxl_port *port, struct xarray *dsmas_xa)
 {
-	return cdat_table_parse(ACPI_CDAT_TYPE_DSMAS, cdat_dsmas_handler,
-				dsmas_xa, port->cdat.table);
+	int rc;
+
+	rc = cdat_table_parse(ACPI_CDAT_TYPE_DSMAS, cdat_dsmas_handler,
+			      dsmas_xa, port->cdat.table);
+	rc = cdat_table_parse_output(rc);
+	if (rc)
+		return rc;
+
+	rc = cdat_table_parse(ACPI_CDAT_TYPE_DSLBIS, cdat_dslbis_handler,
+			      dsmas_xa, port->cdat.table);
+	return cdat_table_parse_output(rc);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_cdat_endpoint_process, CXL);
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 7e694120b15d..5f73cb1d4512 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -7,6 +7,7 @@
 #include <linux/libnvdimm.h>
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
+#include <linux/node.h>
 #include <linux/log2.h>
 #include <linux/io.h>
 
@@ -843,6 +844,7 @@ static inline struct cxl_dax_region *to_cxl_dax_region(struct device *dev)
 struct dsmas_entry {
 	struct range dpa_range;
 	u8 handle;
+	struct access_coordinate coord;
 };
 
 int cxl_cdat_endpoint_process(struct cxl_port *port, struct xarray *dsmas_xa);


