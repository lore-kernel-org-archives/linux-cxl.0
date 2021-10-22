Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFC4C433FE
	for <linux-cxl@archiver.kernel.org>; Fri, 22 Oct 2021 18:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 147A16054F
	for <linux-cxl@archiver.kernel.org>; Fri, 22 Oct 2021 18:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233831AbhJVSje (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 22 Oct 2021 14:39:34 -0400
Received: from mga02.intel.com ([134.134.136.20]:5577 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233713AbhJVSjd (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 22 Oct 2021 14:39:33 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10145"; a="216528923"
X-IronPort-AV: E=Sophos;i="5.87,173,1631602800"; 
   d="scan'208";a="216528923"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2021 11:37:14 -0700
X-IronPort-AV: E=Sophos;i="5.87,173,1631602800"; 
   d="scan'208";a="445854588"
Received: from aagregor-mobl3.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.134.35])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2021 11:37:14 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, Chet Douglas <chet.r.douglas@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [RFC PATCH v2 01/28] cxl: Rename CXL_MEM to CXL_PCI
Date:   Fri, 22 Oct 2021 11:36:42 -0700
Message-Id: <20211022183709.1199701-2-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211022183709.1199701-1-ben.widawsky@intel.com>
References: <20211022183709.1199701-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

With the upcoming introduction of a driver to control the non-PCI
aspects of CXL.mem, such as interleave set creation and configuration,
there will be an opportunity to disconnection control over CXL device
memory and CXL device manageability. CXL device manageability is
implemented by the cxl_pci driver. Doing this rename allows the CXL
memory driver to be enabled by a new config option independently of CXL
device manageability through CXL.io/PCI mechanisms.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/Kconfig  | 13 ++++++-------
 drivers/cxl/Makefile |  2 +-
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index e6de221cc568..23773d0ac896 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -13,14 +13,13 @@ menuconfig CXL_BUS
 
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
+	  The CXL specification defines a set of interfaces which are controlled
+	  through well known PCI configuration mechanisms. Such access is
+	  referred to CXL.io in the specification.
 
 	  Say 'y/m' to enable a driver that will attach to CXL.mem devices for
 	  configuration and management primarily via the mailbox interface. See
@@ -31,7 +30,7 @@ config CXL_MEM
 
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
2.33.1

