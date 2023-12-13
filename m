Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CA6c02rA"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4966DD
	for <linux-cxl@vger.kernel.org>; Wed, 13 Dec 2023 08:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702485734; x=1734021734;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FPtRRIYU/ZFzsXmfbDooGx76pze7yZzdmOCP6vwtDVk=;
  b=CA6c02rALcbPeE6PbZygCW2kFqu9A+/PDBu5rYSwmN17eyBkMKawzKm7
   7oygvnjNjtI5N573BNzQbVd/OBHGyQKUbSrtH64iUc5yoSQknFAzYlg6q
   4geHeWRkyOLpY7j3kzQcSOVEq5hFUoUbObI2If0SZ8HptzMoFI9cs00aJ
   E6607fVslqbmdXlnn2wQq16KZn5CY8+vGfccUbsvYJYBBnTOLWL24LOHY
   svVsicD/jBl7OzOH7jXqzCOdRfcaro+O9gpj2BXKbhOsam/E6UZMsDila
   jqNfpIzNV6cGmWeD7yvvOmw57rgNhfKiP18P9aBUbaGrfKtRbnu/xu748
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="398833567"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="398833567"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 08:42:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="774009573"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="774009573"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.76.225])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 08:42:13 -0800
Subject: [PATCH v14 09/19] cxl: Add callback to parse the DSLBIS subtable from
 CDAT
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date: Wed, 13 Dec 2023 09:42:13 -0700
Message-ID: <170248573312.801570.17830885755356886237.stgit@djiang5-mobl3>
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
v14:
- Move all CDAT processing to core/cdat.c (Dan)
---
 drivers/cxl/core/cdat.c |  102 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 100 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index 9bf4f53bf77f..97d8ef8848c6 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -3,12 +3,15 @@
 #include <linux/acpi.h>
 #include <linux/xarray.h>
 #include <linux/fw_table.h>
+#include <linux/node.h>
+#include <linux/overflow.h>
 #include "cxlpci.h"
 #include "cxl.h"
 
 struct dsmas_entry {
 	struct range dpa_range;
 	u8 handle;
+	struct access_coordinate coord;
 };
 
 static int cdat_dsmas_handler(union acpi_subtable_headers *header, void *arg,
@@ -49,11 +52,106 @@ static int cdat_dsmas_handler(union acpi_subtable_headers *header, void *arg,
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
 static int cxl_cdat_endpoint_process(struct cxl_port *port,
 				     struct xarray *dsmas_xa)
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
 
 static void discard_dsmas(struct xarray *xa)


