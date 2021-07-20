Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD09DC07E9B
	for <linux-cxl@archiver.kernel.org>; Tue, 20 Jul 2021 18:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A47BE6108B
	for <linux-cxl@archiver.kernel.org>; Tue, 20 Jul 2021 18:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbhGTR1w (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 20 Jul 2021 13:27:52 -0400
Received: from mga11.intel.com ([192.55.52.93]:47801 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230478AbhGTR1Z (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Tue, 20 Jul 2021 13:27:25 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10051"; a="208185118"
X-IronPort-AV: E=Sophos;i="5.84,255,1620716400"; 
   d="scan'208";a="208185118"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2021 11:07:49 -0700
X-IronPort-AV: E=Sophos;i="5.84,255,1620716400"; 
   d="scan'208";a="494950516"
Received: from lesliemu-mobl1.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.136.56])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2021 11:07:48 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH v2 1/6] cxl: Move cxl_core to new directory
Date:   Tue, 20 Jul 2021 11:07:42 -0700
Message-Id: <20210720180742.89992-1-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <CAPcyv4gbiNyKtzKkp2FgM5+k=FuodP0wKdNgh4ohH=E8fxQXwA@mail.gmail.com>
References: <CAPcyv4gbiNyKtzKkp2FgM5+k=FuodP0wKdNgh4ohH=E8fxQXwA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

CXL core is growing, and it's already arguably unmanageable. To support
future growth, move core functionality to a new directory and rename the
file to represent just bus support. Future work will remove non-bus
functionality.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
v2: Create new Makefile for core (Dan)

---
 Documentation/driver-api/cxl/memory-devices.rst | 2 +-
 drivers/cxl/Makefile                            | 4 +---
 drivers/cxl/core/Makefile                       | 5 +++++
 drivers/cxl/{core.c => core/bus.c}              | 4 ++--
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
index 000000000000..c65e9f61abe9
--- /dev/null
+++ b/drivers/cxl/core/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_CXL_BUS) += cxl_core.o
+
+ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=CXL -I./drivers/cxl
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
-- 
2.32.0

