Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80123C433EF
	for <linux-cxl@archiver.kernel.org>; Sat,  4 Sep 2021 02:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 693FD60E8B
	for <linux-cxl@archiver.kernel.org>; Sat,  4 Sep 2021 02:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350398AbhIDCWI (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 3 Sep 2021 22:22:08 -0400
Received: from mga18.intel.com ([134.134.136.126]:21563 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240791AbhIDCWH (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 3 Sep 2021 22:22:07 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10096"; a="206678324"
X-IronPort-AV: E=Sophos;i="5.85,267,1624345200"; 
   d="scan'208";a="206678324"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 19:21:06 -0700
X-IronPort-AV: E=Sophos;i="5.85,267,1624345200"; 
   d="scan'208";a="511732558"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 19:21:06 -0700
Subject: [PATCH 6/6] cxl/registers: Fix Documentation warning
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>, alison.schofield@intel.com,
        ben.widawsky@intel.com, Jonathan.Cameron@huawei.com
Date:   Fri, 03 Sep 2021 19:21:06 -0700
Message-ID: <163072206675.2250120.3527179192933919995.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <163072203373.2250120.8373702699578427249.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <163072203373.2250120.8373702699578427249.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Commit 0f06157e0135 ("cxl/core: Move register mapping infrastructure")
neglected to add a DOC header for the new drivers/core/regs.c file.

Reported-by: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/driver-api/cxl/memory-devices.rst |    2 +-
 drivers/cxl/core/regs.c                         |   15 ++++++++++++++-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/driver-api/cxl/memory-devices.rst b/Documentation/driver-api/cxl/memory-devices.rst
index df799cdf1c3f..50ebcda17ad0 100644
--- a/Documentation/driver-api/cxl/memory-devices.rst
+++ b/Documentation/driver-api/cxl/memory-devices.rst
@@ -43,7 +43,7 @@ CXL Core
    :doc: cxl pmem
 
 .. kernel-doc:: drivers/cxl/core/regs.c
-   :internal:
+   :doc: cxl registers
 
 External Interfaces
 ===================
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 8535a7b94f28..41de4a136ecd 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -1,12 +1,25 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2020 Intel Corporation. */
-
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/device.h>
 #include <linux/slab.h>
 #include <linux/pci.h>
 #include <cxlmem.h>
 
+/**
+ * DOC: cxl registers
+ *
+ * CXL device capabilities are enumerated by PCI DVSEC (Designated
+ * Vendor-specific) and / or descriptors provided by platform firmware.
+ * They can be defined as a set like the device and component registers
+ * mandated by CXL Section 8.1.12.2 Memory Device PCIe Capabilities and
+ * Extended Capabilities, or they can be individual capabilities
+ * appended to bridged and endpoint devices.
+ *
+ * Provide common infrastructure for enumerating and mapping these
+ * discrete capabilities.
+ */
+
 /**
  * cxl_probe_component_regs() - Detect CXL Component register blocks
  * @dev: Host device of the @base mapping

