Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC3F1C7EE29
	for <linux-cxl@archiver.kernel.org>; Fri, 19 May 2023 17:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjESRJ3 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 19 May 2023 13:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbjESRJC (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 19 May 2023 13:09:02 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FA01705
        for <linux-cxl@vger.kernel.org>; Fri, 19 May 2023 10:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684516118; x=1716052118;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jjGKx2gla6Qd9r3Lj4J6pwZJuuB1yYj0apRSBqvEKKc=;
  b=Iw31fw/WeXFE/Yr9hB7a4p6jmj7+RyOnqxXtqNlGQh2XcDq8Cj6cmDAg
   rF+iMDTmiD6o5ueZ8rmKNyU5o2xIEnFErfTsQ2ZRIWPMZNLhgeb335tWC
   3eKvv6splVIIFK6qajnEl1D6A7VHlsk30mUwLib9IPfmjggZE7WFfRzNP
   QHPrI5oYovK1/ute92HMASZwwEVTgk8dy0S9mK4eFhsc+y/7OGgpP68oP
   TkQJrzHWT6RPo6FXGYri98Pi0aVU9IPXAdC19S59GnXxW0/oEHEG+DDuu
   bRLn8oo57GBcgZosavUF8CGlp3QStuY7etCYHWGm3CZ15bz9acPZ2eFB0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10715"; a="438778231"
X-IronPort-AV: E=Sophos;i="6.00,177,1681196400"; 
   d="scan'208";a="438778231"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2023 10:06:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10715"; a="876910767"
X-IronPort-AV: E=Sophos;i="6.00,177,1681196400"; 
   d="scan'208";a="876910767"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.29.189])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2023 10:06:46 -0700
Subject: [PATCH v6 02/11] cxl: Add callback to parse the DSLBIS subtable from
 CDAT
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com
Date:   Fri, 19 May 2023 10:06:46 -0700
Message-ID: <168451600640.3470703.3461483051303767270.stgit@djiang5-mobl3>
In-Reply-To: <168451588868.3470703.3527256859632103687.stgit@djiang5-mobl3>
References: <168451588868.3470703.3527256859632103687.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

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
v6:
- Clarify cxl_cdat_endpoint_process() error paths for readability. (Jonathan)
- Adjust dslbis ptr from header.
v5:
- Remove macro for common headers. (Jonathan)
- Use acpi_table_parse_cdat().
- Remove unlikely(). (Dan)
v3:
- Added spec section in commit header. (Alison)
- Remove void * recast. (Alison)
- Rework comment. (Alison)
- Move CDAT parse to cxl_endpoint_port_probe()
- Convert to use 'struct node_hmem_attrs'

v2:
- Add size check to DSLIBIS table. (Lukas)
- Remove unnecessary entry type check. (Jonathan)
- Move data_type check to after match. (Jonathan)
- Skip unknown data type. (Jonathan)
- Add overflow check for unit multiply. (Jonathan)
- Use dev_warn() when entries parsing fail. (Jonathan)
---
 drivers/cxl/core/cdat.c |  102 ++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/cxl/cxl.h       |    2 +
 2 files changed, 102 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index f70a3a146901..464e69a9c8e4 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2023 Intel Corporation. All rights reserved. */
 #include <linux/acpi.h>
+#include <linux/overflow.h>
 #include "cxlpci.h"
 #include "cxl.h"
 
@@ -36,10 +37,107 @@ static int cdat_dsmas_handler(union acpi_subtable_headers *header, void *arg,
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
index f119f030e2e8..87b9e80d834c 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -8,6 +8,7 @@
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/list.h>
+#include <linux/node.h>
 #include <linux/log2.h>
 #include <linux/io.h>
 
@@ -797,6 +798,7 @@ struct dsmas_entry {
 	struct list_head list;
 	struct range dpa_range;
 	u8 handle;
+	struct access_coordinate coord;
 };
 
 #ifdef CONFIG_ACPI_TABLES_LIB


