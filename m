Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB435C4332F
	for <linux-cxl@archiver.kernel.org>; Mon, 29 Nov 2021 21:52:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbhK2V4B (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 29 Nov 2021 16:56:01 -0500
Received: from mga18.intel.com ([134.134.136.126]:47142 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232816AbhK2VyA (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 29 Nov 2021 16:54:00 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="222968500"
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="222968500"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 13:47:25 -0800
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="458596082"
Received: from ajsteine-mobl13.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.141.244])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 13:47:24 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 1/9] cxl: Rename CXL_MEM to CXL_PCI
Date:   Mon, 29 Nov 2021 13:47:13 -0800
Message-Id: <20211129214721.1668325-2-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211129214721.1668325-1-ben.widawsky@intel.com>
References: <20211129214721.1668325-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The cxl_mem module was renamed cxl_pci in commit 21e9f76733a8 ("cxl:
Rename mem to pci"). In preparation for adding an ancillary driver for
cxl_memdev devices (registered on the cxl bus by cxl_pci), go ahead and
rename CONFIG_CXL_MEM to CONFIG_CXL_PCI. Free up the CXL_MEM name for
that new driver to manage CXL.mem endpoint operations.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/Kconfig  | 23 ++++++++++++-----------
 drivers/cxl/Makefile |  2 +-
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 67c91378f2dd..ef05e96f8f97 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -13,25 +13,26 @@ menuconfig CXL_BUS
 
 if CXL_BUS
 
-config CXL_MEM
-	tristate "CXL.mem: Memory Devices"
+config CXL_PCI
+	tristate "PCI manageability"
 	default CXL_BUS
 	help
-	  The CXL.mem protocol allows a device to act as a provider of
-	  "System RAM" and/or "Persistent Memory" that is fully coherent
-	  as if the memory was attached to the typical CPU memory
-	  controller.
+	  The CXL specification defines a "CXL memory device" sub-class in the
+	  PCI "memory controller" base class of devices. Device's identified by
+	  this class code provide support for volatile and / or persistent
+	  memory to be mapped into the system address map (Host-managed Device
+	  Memory (HDM)).
 
-	  Say 'y/m' to enable a driver that will attach to CXL.mem devices for
-	  configuration and management primarily via the mailbox interface. See
-	  Chapter 2.3 Type 3 CXL Device in the CXL 2.0 specification for more
-	  details.
+	  Say 'y/m' to enable a driver that will attach to CXL memory expander
+	  devices enumerated by the memory device class code for configuration
+	  and management primarily via the mailbox interface. See Chapter 2.3
+	  Type 3 CXL Device in the CXL 2.0 specification for more details.
 
 	  If unsure say 'm'.
 
 config CXL_MEM_RAW_COMMANDS
 	bool "RAW Command Interface for Memory Devices"
-	depends on CXL_MEM
+	depends on CXL_PCI
 	help
 	  Enable CXL RAW command interface.
 
diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
index d1aaabc940f3..cf07ae6cea17 100644
--- a/drivers/cxl/Makefile
+++ b/drivers/cxl/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_CXL_BUS) += core/
-obj-$(CONFIG_CXL_MEM) += cxl_pci.o
+obj-$(CONFIG_CXL_PCI) += cxl_pci.o
 obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
 obj-$(CONFIG_CXL_PMEM) += cxl_pmem.o
 
-- 
2.34.1

