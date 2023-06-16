Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE97EB64D8
	for <linux-cxl@archiver.kernel.org>; Fri, 16 Jun 2023 21:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjFPVlr (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 16 Jun 2023 17:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjFPVlq (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 16 Jun 2023 17:41:46 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F52E30F7
        for <linux-cxl@vger.kernel.org>; Fri, 16 Jun 2023 14:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686951705; x=1718487705;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a3s4kmtFjRsis1qgXToGSFGZk+eO5uT3HLdyxNRuonI=;
  b=ESY7luedVyioCwcV+hoUgkXIiMwqlqLkjiETN0uDmIr83PCFANQ7Kvln
   yjZv0bJCiwGz8GDhq6plFKeP6Hw2ApcC8CsnUfS/gioANd1Pj50evgJIP
   +1jAx9fXtOB6IIfjh3oZktOc5TBg/pB4PW/AJVLSHDBkv3pKQ4Htkauar
   hrYlnk/HJFGfgKjNUCg/tpriKT9RMOLR0t04Re3vniidLcgDwDyJ7iZLs
   drcH8iXZRKBkn83FG8Z2FlJvCNNBI6E6xiF4TPsjpyrnMC9MoXi3Ws1Fy
   /e6v/GFRlGqH9xzXM1MC8Y/4w0rsBGn+lLfr+67BUkc0uRP36EwKfDvd9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="422973115"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="422973115"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 14:41:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="713028856"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="713028856"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.16.91])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 14:41:44 -0700
Subject: [PATCH v7 01/11] cxl: Add callback to parse the DSMAS subtables from
 CDAT
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com
Date:   Fri, 16 Jun 2023 14:41:43 -0700
Message-ID: <168695170395.3031571.3242055294889411521.stgit@djiang5-mobl3>
In-Reply-To: <168695160531.3031571.4875512229068707023.stgit@djiang5-mobl3>
References: <168695160531.3031571.4875512229068707023.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

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
v7:
- Fix stray line (Jonathan)
v6:
- Adjust dsmas offset w/o common header.
- Move dsmas list destroy to core/cdat. (Jonathan)
v5:
- Update commit log to indicate what list is used for. (Jonathan, Dan)
- Use acpi_table_parse_cdat()
- Isolate cdat code behind CONFIG_ACPI
v3:
- Add spec section number. (Alison)
- Remove cast from void *. (Alison)
- Refactor cxl_port_probe() block. (Alison)
- Move CDAT parse to cxl_endpoint_port_probe()

v2:
- Add DSMAS table size check. (Lukas)
- Use local DSMAS header for LE handling.
- Remove dsmas lock. (Jonathan)
- Fix handle size (Jonathan)
- Add LE to host conversion for DSMAS address and length.
- Make dsmas_list local
---
 drivers/cxl/Kconfig       |    1 +
 drivers/cxl/core/Makefile |    1 +
 drivers/cxl/core/cdat.c   |   58 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h         |   23 ++++++++++++++++++
 drivers/cxl/port.c        |   12 +++++++++
 5 files changed, 95 insertions(+)
 create mode 100644 drivers/cxl/core/cdat.c

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index ff4e78117b31..75ba070f83b2 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -3,6 +3,7 @@ menuconfig CXL_BUS
 	tristate "CXL (Compute Express Link) Devices Support"
 	depends on PCI
 	select PCI_DOE
+	select FIRMWARE_TABLE
 	help
 	  CXL is a bus that is electrically compatible with PCI Express, but
 	  layers three protocols on that signalling (CXL.io, CXL.cache, and
diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index ca4ae31d8f57..1aa8a77a09a8 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -12,5 +12,6 @@ cxl_core-y += memdev.o
 cxl_core-y += mbox.o
 cxl_core-y += pci.o
 cxl_core-y += hdm.o
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
index 7e4f6a0af4b8..f4b6b34721f9 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -7,6 +7,7 @@
 #include <linux/libnvdimm.h>
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
+#include <linux/list.h>
 #include <linux/log2.h>
 #include <linux/io.h>
 
@@ -792,6 +793,28 @@ static inline struct cxl_dax_region *to_cxl_dax_region(struct device *dev)
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
index cf071292acbc..3b861c41a579 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -137,6 +137,18 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
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
 


