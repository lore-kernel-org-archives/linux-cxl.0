Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB919C4338F
	for <linux-cxl@archiver.kernel.org>; Sat, 31 Jul 2021 16:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A69AB6044F
	for <linux-cxl@archiver.kernel.org>; Sat, 31 Jul 2021 16:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbhGaQgB (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 31 Jul 2021 12:36:01 -0400
Received: from mga04.intel.com ([192.55.52.120]:28561 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229475AbhGaQgB (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Sat, 31 Jul 2021 12:36:01 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10062"; a="211374211"
X-IronPort-AV: E=Sophos;i="5.84,284,1620716400"; 
   d="scan'208";a="211374211"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2021 09:35:54 -0700
X-IronPort-AV: E=Sophos;i="5.84,284,1620716400"; 
   d="scan'208";a="567878777"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2021 09:35:53 -0700
Subject: [PATCH v4 1/6] cxl: Move cxl_core to new directory
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>, Jonathan.Cameron@huawei.com
Date:   Sat, 31 Jul 2021 09:35:53 -0700
Message-ID: <162774927110.4094313.9743731504096769799.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <162767562078.3322476.8145564536868277034.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <162767562078.3322476.8145564536868277034.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Ben Widawsky <ben.widawsky@intel.com>

CXL core is growing, and it's already arguably unmanageable. To support
future growth, move core functionality to a new directory and rename the
file to represent just bus support. Future work will remove non-bus
functionality.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
Changes since v3:

Fix support for building in a separate build directory (0day)

 Documentation/driver-api/cxl/memory-devices.rst |    2 +-
 drivers/cxl/Makefile                            |    4 +---
 drivers/cxl/core/Makefile                       |    5 +++++
 drivers/cxl/core/bus.c                          |    4 ++--
 4 files changed, 9 insertions(+), 6 deletions(-)
 create mode 100644 drivers/cxl/core/Makefile
 rename drivers/cxl/{core.c => core/bus.c} (99%)

diff --git a/Documentation/driver-api/cxl/memory-devices.rst b/Documentation/driver-api/cxl/memory-devices.rst
index 487ce4f41d77..a86e2c7c551a 100644
--- a/Documentation/driver-api/cxl/memory-devices.rst
+++ b/Documentation/driver-api/cxl/memory-devices.rst
@@ -36,7 +36,7 @@ CXL Core
 .. kernel-doc:: drivers/cxl/cxl.h
    :internal:
 
-.. kernel-doc:: drivers/cxl/core.c
+.. kernel-doc:: drivers/cxl/core/bus.c
    :doc: cxl core
 
 External Interfaces
diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
index 32954059b37b..d1aaabc940f3 100644
--- a/drivers/cxl/Makefile
+++ b/drivers/cxl/Makefile
@@ -1,11 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_CXL_BUS) += cxl_core.o
+obj-$(CONFIG_CXL_BUS) += core/
 obj-$(CONFIG_CXL_MEM) += cxl_pci.o
 obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
 obj-$(CONFIG_CXL_PMEM) += cxl_pmem.o
 
-ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=CXL
-cxl_core-y := core.o
 cxl_pci-y := pci.o
 cxl_acpi-y := acpi.o
 cxl_pmem-y := pmem.o
diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
new file mode 100644
index 000000000000..ad137f96e5c8
--- /dev/null
+++ b/drivers/cxl/core/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_CXL_BUS) += cxl_core.o
+
+ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=CXL -I$(srctree)/drivers/cxl
+cxl_core-y := bus.o
diff --git a/drivers/cxl/core.c b/drivers/cxl/core/bus.c
similarity index 99%
rename from drivers/cxl/core.c
rename to drivers/cxl/core/bus.c
index a2e4d54fc7bc..6ce04e3976d2 100644
--- a/drivers/cxl/core.c
+++ b/drivers/cxl/core/bus.c
@@ -6,8 +6,8 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/idr.h>
-#include "cxl.h"
-#include "mem.h"
+#include <cxl.h>
+#include <mem.h>
 
 /**
  * DOC: cxl core

