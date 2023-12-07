Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BtrUgTl5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904321720
	for <linux-cxl@vger.kernel.org>; Thu,  7 Dec 2023 14:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701989953; x=1733525953;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uOaB8CxWSdUQlOLNTICBgrMGiAndEW5FdEyhcMv3OJo=;
  b=BtrUgTl5to5I6y62meo3ogckLnqwZFaN3MQQD8VqWQV+r25Ih6p7FNlv
   8dZFE2k0uA/0IRv7uCck84psM1pwnp4bn5yz0uCbvnAqiO7LO0vsr0APu
   szIHjqkjm4GcqkNFOguScW8BaxxE3P78etiycc71UMaR10tiP5PndmPTp
   I0pPv5Rgx4k4gTPbZ2HAZbJq6d1A7hH0XFDVJKC5ZSONENrZF/EomUZPt
   nGRVjLUFbo3t5VsUIQbzQrvLhXM1Ia7HUcJjy/HpmrQweTB1R/Doc88hG
   FAeqWAjb/UUQGpKfwOyMTwXyHX7nNLJL0/qaO7nG2IxivDDEr9hwfY05O
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="1185214"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="1185214"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 14:59:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="842380436"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="842380436"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.213.168.225])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 14:59:11 -0800
Subject: [PATCH v13 08/19] cxl: Add callback to parse the DSMAS subtables from
 CDAT
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date: Thu, 07 Dec 2023 15:59:11 -0700
Message-ID: <170198995130.3522351.4477346549256837518.stgit@djiang5-mobl3>
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

Provide a callback function to the CDAT parser in order to parse the Device
Scoped Memory Affinity Structure (DSMAS). Each DSMAS structure contains the
DPA range and its associated attributes in each entry. See the CDAT
specification for details. The device handle and the DPA range is saved and
to be associated with the DSLBIS locality data when the DSLBIS entries are
parsed. The xarray is a local variable. When the total path performance data is
calculated and storred this xarray can be discarded.

Coherent Device Attribute Table 1.03 2.1 Device Scoped memory Affinity
Structure (DSMAS)

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v13:
- Convert dsmas list to xarray (Dan)
---
 drivers/cxl/Kconfig       |    1 +
 drivers/cxl/core/Makefile |    1 +
 drivers/cxl/core/cdat.c   |   66 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h         |    9 ++++++
 drivers/cxl/port.c        |   12 ++++++++
 tools/testing/cxl/Kbuild  |    1 +
 6 files changed, 90 insertions(+)
 create mode 100644 drivers/cxl/core/cdat.c

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 8ea1d340e438..a1ae35bd1afc 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -5,6 +5,7 @@ menuconfig CXL_BUS
 	select FW_LOADER
 	select FW_UPLOAD
 	select PCI_DOE
+	select FIRMWARE_TABLE
 	help
 	  CXL is a bus that is electrically compatible with PCI Express, but
 	  layers three protocols on that signalling (CXL.io, CXL.cache, and
diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index 1f66b5d4d935..9259bcc6773c 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -13,5 +13,6 @@ cxl_core-y += mbox.o
 cxl_core-y += pci.o
 cxl_core-y += hdm.o
 cxl_core-y += pmu.o
+cxl_core-y += cdat.o
 cxl_core-$(CONFIG_TRACING) += trace.o
 cxl_core-$(CONFIG_CXL_REGION) += region.o
diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
new file mode 100644
index 000000000000..7b11c6631491
--- /dev/null
+++ b/drivers/cxl/core/cdat.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2023 Intel Corporation. All rights reserved. */
+#include <linux/acpi.h>
+#include <linux/fw_table.h>
+#include "cxlpci.h"
+#include "cxl.h"
+
+static int cdat_dsmas_handler(union acpi_subtable_headers *header, void *arg,
+			      const unsigned long end)
+{
+	struct acpi_cdat_header *hdr = &header->cdat;
+	struct acpi_cdat_dsmas *dsmas;
+	int size = sizeof(*hdr) + sizeof(*dsmas);
+	struct xarray *dsmas_xa = arg;
+	struct dsmas_entry *dent;
+	u16 len;
+	int rc;
+
+	len = le16_to_cpu((__force __le16)hdr->length);
+	if (len != size || (unsigned long)hdr + len > end) {
+		pr_warn("Malformed DSMAS table length: (%u:%u)\n", size, len);
+		return -EINVAL;
+	}
+
+	/* Skip common header */
+	dsmas = (struct acpi_cdat_dsmas *)(hdr + 1);
+
+	dent = kzalloc(sizeof(*dent), GFP_KERNEL);
+	if (!dent)
+		return -ENOMEM;
+
+	dent->handle = dsmas->dsmad_handle;
+	dent->dpa_range.start = le64_to_cpu((__force __le64)dsmas->dpa_base_address);
+	dent->dpa_range.end = le64_to_cpu((__force __le64)dsmas->dpa_base_address) +
+			      le64_to_cpu((__force __le64)dsmas->dpa_length) - 1;
+
+	rc = xa_insert(dsmas_xa, dent->handle, dent, GFP_KERNEL);
+	if (rc) {
+		kfree(dent);
+		return rc;
+	}
+
+	return 0;
+}
+
+int cxl_cdat_endpoint_process(struct cxl_port *port, struct xarray *dsmas_xa)
+{
+	return cdat_table_parse(ACPI_CDAT_TYPE_DSMAS, cdat_dsmas_handler,
+				dsmas_xa, port->cdat.table);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_cdat_endpoint_process, CXL);
+
+void cxl_cdat_dsmas_xa_destroy(struct xarray *dsmas_xa)
+{
+	struct dsmas_entry *dentry;
+	unsigned long index;
+
+	xa_for_each(dsmas_xa, index, dentry) {
+		xa_erase(dsmas_xa, index);
+		kfree(dentry);
+	}
+	xa_destroy(dsmas_xa);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_cdat_dsmas_xa_destroy, CXL);
+
+MODULE_IMPORT_NS(CXL);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 687043ece101..7e694120b15d 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -839,6 +839,15 @@ static inline struct cxl_dax_region *to_cxl_dax_region(struct device *dev)
 }
 #endif
 
+/* CDAT related bits */
+struct dsmas_entry {
+	struct range dpa_range;
+	u8 handle;
+};
+
+int cxl_cdat_endpoint_process(struct cxl_port *port, struct xarray *dsmas_xa);
+void cxl_cdat_dsmas_xa_destroy(struct xarray *dsmas_xa);
+
 /*
  * Unit test builds overrides this to __weak, find the 'strong' version
  * of these symbols in tools/testing/cxl/.
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 47bc8e0b8590..1bae77913c82 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -136,6 +136,18 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 	device_for_each_child(&port->dev, root, discover_region);
 	put_device(&root->dev);
 
+	if (port->cdat.table) {
+		DEFINE_XARRAY(dsmas_xa);
+
+		rc = cxl_cdat_endpoint_process(port, &dsmas_xa);
+		if (rc < 0)
+			dev_dbg(&port->dev, "Failed to parse CDAT: %d\n", rc);
+
+		/* Performance data processing */
+
+		cxl_cdat_dsmas_xa_destroy(&dsmas_xa);
+	}
+
 	return 0;
 }
 
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 90f3c9802ffb..e3a59b0c5564 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -58,6 +58,7 @@ cxl_core-y += $(CXL_CORE_SRC)/mbox.o
 cxl_core-y += $(CXL_CORE_SRC)/pci.o
 cxl_core-y += $(CXL_CORE_SRC)/hdm.o
 cxl_core-y += $(CXL_CORE_SRC)/pmu.o
+cxl_core-y += $(CXL_CORE_SRC)/cdat.o
 cxl_core-$(CONFIG_TRACING) += $(CXL_CORE_SRC)/trace.o
 cxl_core-$(CONFIG_CXL_REGION) += $(CXL_CORE_SRC)/region.o
 cxl_core-y += config_check.o


