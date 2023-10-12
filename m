Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7522AB39
	for <linux-cxl@vger.kernel.org>; Thu, 12 Oct 2023 18:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aG1DGOYi"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA5983
	for <linux-cxl@vger.kernel.org>; Thu, 12 Oct 2023 11:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697136899; x=1728672899;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vvw6Skq+8irwDNvPcYNrT1WoIuqx7oL4Z5LZvjbOtIw=;
  b=aG1DGOYicJIm6CckPj9U7rgk/A3m7iAXkVmV2y7Wyv4A1mKzZwsKcUo4
   8c+9VAr8H2qj5Ezux+ZIipCyJEyNvW4/OInDuNR/waVP10X0hSiTs+oBo
   9TvjksXCwNuu6rxP7IS28p6BUsijnTWqXNzKVDjXeX8p9VqwGzFDTfJJG
   zKUH4pC5UrDvtQfs16ZA4U2SHYAPlDc40BY27FTDuPJr6e6OnUcbHLfe0
   8J43vZ45K6n3u78Yn2ioVMLOehHd6F0NXbcmPhqZvPUQ8nlDAgk8Ta8Dx
   BktJwilPQeS9zu85c+0mODEQaT9hX9SG1V95tus4+bjzd9/B4YKgejV5G
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="388880305"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="388880305"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 11:54:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="870711400"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="870711400"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.15.16])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 11:54:43 -0700
Subject: [PATCH v11 12/22] cxl: Add callback to parse the DSMAS subtables from
 CDAT
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date: Thu, 12 Oct 2023 11:54:43 -0700
Message-ID: <169713688328.2205276.14682106535163902532.stgit@djiang5-mobl3>
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

Provide a callback function to the CDAT parser in order to parse the Device
Scoped Memory Affinity Structure (DSMAS). Each DSMAS structure contains the
DPA range and its associated attributes in each entry. See the CDAT
specification for details. The device handle and the DPA range is saved and
to be associated with the DSLBIS locality data when the DSLBIS entries are
parsed. The list is a local list. When the total path performance data is
calculated and storred this list can be discarded.

Coherent Device Attribute Table 1.03 2.1 Device Scoped memory Affinity
Structure (DSMAS)

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/Kconfig       |    1 +
 drivers/cxl/core/Makefile |    1 +
 drivers/cxl/core/cdat.c   |   58 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h         |   23 ++++++++++++++++++
 drivers/cxl/port.c        |   12 +++++++++
 5 files changed, 95 insertions(+)
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
index 1f66b5d4d935..f4eabfdd50ce 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -13,5 +13,6 @@ cxl_core-y += mbox.o
 cxl_core-y += pci.o
 cxl_core-y += hdm.o
 cxl_core-y += pmu.o
+cxl_core-$(CONFIG_FIRMWARE_TABLE) += cdat.o
 cxl_core-$(CONFIG_TRACING) += trace.o
 cxl_core-$(CONFIG_CXL_REGION) += region.o
diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
new file mode 100644
index 000000000000..a858fd1b5744
--- /dev/null
+++ b/drivers/cxl/core/cdat.c
@@ -0,0 +1,58 @@
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
+	struct list_head *dsmas_list = arg;
+	struct dsmas_entry *dent;
+	u16 len;
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
+	list_add_tail(&dent->list, dsmas_list);
+
+	return 0;
+}
+
+int cxl_cdat_endpoint_process(struct cxl_port *port, struct list_head *list)
+{
+	return cdat_table_parse(ACPI_CDAT_TYPE_DSMAS, cdat_dsmas_handler,
+				list, port->cdat.table);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_cdat_endpoint_process, CXL);
+
+void cxl_cdat_dsmas_list_destroy(struct list_head *dsmas_list)
+{
+	struct dsmas_entry *dentry, *n;
+
+	list_for_each_entry_safe(dentry, n, dsmas_list, list) {
+		list_del(&dentry->list);
+		kfree(dentry);
+	}
+}
+EXPORT_SYMBOL_NS_GPL(cxl_cdat_dsmas_list_destroy, CXL);
+
+MODULE_IMPORT_NS(CXL);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index eb7924648cb0..be2fd8dcb37b 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -7,6 +7,7 @@
 #include <linux/libnvdimm.h>
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
+#include <linux/list.h>
 #include <linux/log2.h>
 #include <linux/io.h>
 
@@ -824,6 +825,28 @@ static inline struct cxl_dax_region *to_cxl_dax_region(struct device *dev)
 }
 #endif
 
+/* CDAT related bits */
+struct dsmas_entry {
+	struct list_head list;
+	struct range dpa_range;
+	u8 handle;
+};
+
+#ifdef CONFIG_FIRMWARE_TABLE
+int cxl_cdat_endpoint_process(struct cxl_port *port, struct list_head *list);
+void cxl_cdat_dsmas_list_destroy(struct list_head *dsmas_list);
+#else
+static inline int cxl_cdat_endpoint_process(struct cxl_port *port,
+					    struct list_head *list)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void cxl_cdat_dsmas_list_destroy(struct list_head *dsmas_list)
+{
+}
+#endif
+
 /*
  * Unit test builds overrides this to __weak, find the 'strong' version
  * of these symbols in tools/testing/cxl/.
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 47bc8e0b8590..cceee9dbae2c 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -136,6 +136,18 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 	device_for_each_child(&port->dev, root, discover_region);
 	put_device(&root->dev);
 
+	if (port->cdat.table) {
+		LIST_HEAD(dsmas_list);
+
+		rc = cxl_cdat_endpoint_process(port, &dsmas_list);
+		if (rc < 0)
+			dev_dbg(&port->dev, "Failed to parse CDAT: %d\n", rc);
+
+		/* Performance data processing */
+
+		cxl_cdat_dsmas_list_destroy(&dsmas_list);
+	}
+
 	return 0;
 }
 


