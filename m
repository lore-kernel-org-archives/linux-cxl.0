Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293017949A
	for <linux-cxl@vger.kernel.org>; Thu, 21 Dec 2023 22:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MWVHxEl1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703196195; x=1734732195;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IcbgluwSxdfxDflII0Z8dJY69887tA+ZsHbhWBXKtUo=;
  b=MWVHxEl1j2dpyalQWBtDrXmhAXtmIeT/ROeTK0ELqvIG78pEi6hUm4QQ
   Qh5xncMHmvF+j7c0/dhiHl3nc4P91ZzZSE3h8BA7VYq5K1SvCtqSQgQRh
   425cP5czXW+Rcn6B/hIYN8Us9bFpFtCeiz0/XqxXIunuXETX90l75GNnj
   6kkAIy9Wff05BpreynV01pvjqugbjADhhDfqPO50CJ0mDQiQbz9ISDB2r
   YuodkJloBHpx14YmFBi57Rd4jW3X4xoBeK1TJ0FbPwaiIGkEGO93kKrdO
   4roh5/7XSPypVzg5Jo6OUznPTOa7dabLCGC7PzL1tuJNLQFozvq14l3LW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="2873850"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="2873850"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 14:03:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="770083790"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="770083790"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.31.86])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 14:03:14 -0800
Subject: [PATCH v15 08/19] cxl: Add callback to parse the DSMAS subtables from
 CDAT
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date: Thu, 21 Dec 2023 15:03:13 -0700
Message-ID: <170319619355.2212653.2675953129671561293.stgit@djiang5-mobl3>
In-Reply-To: <170319606771.2212653.5435838660860735129.stgit@djiang5-mobl3>
References: <170319606771.2212653.5435838660860735129.stgit@djiang5-mobl3>
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
 drivers/cxl/Kconfig       |    3 +
 drivers/cxl/core/Makefile |    1 
 drivers/cxl/core/cdat.c   |   92 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h         |    2 +
 drivers/cxl/port.c        |    1 
 tools/testing/cxl/Kbuild  |    1 
 6 files changed, 100 insertions(+)
 create mode 100644 drivers/cxl/core/cdat.c

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 8ea1d340e438..67998dbd1d46 100644
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
@@ -54,8 +55,10 @@ config CXL_MEM_RAW_COMMANDS
 config CXL_ACPI
 	tristate "CXL ACPI: Platform Support"
 	depends on ACPI
+	depends on ACPI_NUMA
 	default CXL_BUS
 	select ACPI_TABLE_LIB
+	select ACPI_HMAT
 	help
 	  Enable support for host managed device memory (HDM) resources
 	  published by a platform's ACPI CXL memory layout description.  See
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
index 000000000000..9bf4f53bf77f
--- /dev/null
+++ b/drivers/cxl/core/cdat.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2023 Intel Corporation. All rights reserved. */
+#include <linux/acpi.h>
+#include <linux/xarray.h>
+#include <linux/fw_table.h>
+#include "cxlpci.h"
+#include "cxl.h"
+
+struct dsmas_entry {
+	struct range dpa_range;
+	u8 handle;
+};
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
+static int cxl_cdat_endpoint_process(struct cxl_port *port,
+				     struct xarray *dsmas_xa)
+{
+	return cdat_table_parse(ACPI_CDAT_TYPE_DSMAS, cdat_dsmas_handler,
+				dsmas_xa, port->cdat.table);
+}
+
+static void discard_dsmas(struct xarray *xa)
+{
+	unsigned long index;
+	void *ent;
+
+	xa_for_each(xa, index, ent) {
+		xa_erase(xa, index);
+		kfree(ent);
+	}
+	xa_destroy(xa);
+}
+DEFINE_FREE(dsmas, struct xarray *, if (_T) discard_dsmas(_T))
+
+void cxl_endpoint_parse_cdat(struct cxl_port *port)
+{
+	struct xarray __dsmas_xa;
+	struct xarray *dsmas_xa __free(dsmas) = &__dsmas_xa;
+	int rc;
+
+	xa_init(&__dsmas_xa);
+	if (!port->cdat.table)
+		return;
+
+	rc = cxl_cdat_endpoint_process(port, dsmas_xa);
+	if (rc < 0) {
+		dev_dbg(&port->dev, "Failed to parse CDAT: %d\n", rc);
+		return;
+	}
+
+	/* Performance data processing */
+}
+EXPORT_SYMBOL_NS_GPL(cxl_endpoint_parse_cdat, CXL);
+
+MODULE_IMPORT_NS(CXL);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 687043ece101..be3b5eda875c 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -839,6 +839,8 @@ static inline struct cxl_dax_region *to_cxl_dax_region(struct device *dev)
 }
 #endif
 
+void cxl_endpoint_parse_cdat(struct cxl_port *port);
+
 /*
  * Unit test builds overrides this to __weak, find the 'strong' version
  * of these symbols in tools/testing/cxl/.
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 47bc8e0b8590..a889c4e6cb27 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -109,6 +109,7 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 
 	/* Cache the data early to ensure is_visible() works */
 	read_cdat_data(port);
+	cxl_endpoint_parse_cdat(port);
 
 	get_device(&cxlmd->dev);
 	rc = devm_add_action_or_reset(&port->dev, schedule_detach, cxlmd);
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


