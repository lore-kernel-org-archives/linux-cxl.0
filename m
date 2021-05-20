Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C5DC433B4
	for <linux-cxl@archiver.kernel.org>; Thu, 20 May 2021 18:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2205561246
	for <linux-cxl@archiver.kernel.org>; Thu, 20 May 2021 18:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235664AbhETSnH (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 20 May 2021 14:43:07 -0400
Received: from mga06.intel.com ([134.134.136.31]:28903 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232681AbhETSnH (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 20 May 2021 14:43:07 -0400
IronPort-SDR: lLM11IPu6anYqSPY8KL8MjK2XOE/aJAtYYndAoaJrH6F0zeBdbGsIGAAmbnmI/MavvoQIfqPRf
 iSRTcMallJ3A==
X-IronPort-AV: E=McAfee;i="6200,9189,9990"; a="262528476"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="262528476"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 11:41:44 -0700
IronPort-SDR: NL3PMamPdW6oe5VdjbL0DQYjD0CdhQQsJfjHBbyOdjwMxl669F34qEY8C8WZYnY0ps4XkR/AnA
 jTi/fnDevWyw==
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="440574579"
Received: from santoshi-mobl1.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.133.11])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 11:41:43 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>
Subject: [PATCH v2] cxl: Rename mem to pci
Date:   Thu, 20 May 2021 11:41:38 -0700
Message-Id: <20210520184138.996337-1-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210510182952.00006e49@Huawei.com>
References: <20210510182952.00006e49@Huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

As the driver has undergone development, it's become clear that the
majority [entirety?] of the current functionality in mem.c is actually a
layer encapsulating functionality exposed through PCI based
interactions. This layer can be used either in isolation or to provide
functionality for higher level functionality.

CXL capabilities exist in a parallel domain to PCIe. CXL devices are
enumerable and controllable via "legacy" PCIe mechanisms; however, their
CXL capabilities are a superset of PCIe. For example, a CXL device may
be connected to a non-CXL capable PCIe root port, and therefore will not
be able to participate in CXL.mem or CXL.cache operations, but can still
be accessed through PCIe mechanisms for CXL.io operations.

To properly represent the PCI nature of this driver, and in preparation for
introducing a new driver for the CXL.mem / HDM decoder (Host-managed Device
Memory) capabilities of a CXL memory expander, rename mem.c to pci.c so that
mem.c is available for this new driver.

The result of the change is that there is a clear layering distinction
in the driver, and a systems administrator may load only the cxl_pci
module and gain access to such operations as, firmware update, offline
provisioning of devices, and error collection. In addition to freeing up
the file name for another purpose, there are two primary reasons this is
useful,
    1. Acting upon devices which don't have full CXL capabilities. This
       may happen for instance if the CXL device is connected in a CXL
       unaware part of the platform topology.
    2. Userspace-first provisioning for devices without kernel driver
       interference. This may be useful when provisioning a new device
       in a specific manner that might otherwise be blocked or prevented
       by the real CXL mem driver.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
v2: Makes it clear that the main motivation for this patch is for proper
layering and that administrative PCI-only activities is a secondary benefit.

I'm proposing we take the hit now and merge this as our next patch for cxl/next.

---
 Documentation/driver-api/cxl/memory-devices.rst |  6 +++---
 drivers/cxl/Kconfig                             | 13 ++++---------
 drivers/cxl/Makefile                            |  5 +++--
 drivers/cxl/{mem.c => pci.c}                    |  9 ++++-----
 4 files changed, 14 insertions(+), 19 deletions(-)
 rename drivers/cxl/{mem.c => pci.c} (99%)

diff --git a/Documentation/driver-api/cxl/memory-devices.rst b/Documentation/driver-api/cxl/memory-devices.rst
index 71495ed77069..a927169db984 100644
--- a/Documentation/driver-api/cxl/memory-devices.rst
+++ b/Documentation/driver-api/cxl/memory-devices.rst
@@ -22,10 +22,10 @@ This section covers the driver infrastructure for a CXL memory device.
 CXL Memory Device
 -----------------
 
-.. kernel-doc:: drivers/cxl/mem.c
-   :doc: cxl mem
+.. kernel-doc:: drivers/cxl/pci.c
+   :doc: cxl pci
 
-.. kernel-doc:: drivers/cxl/mem.c
+.. kernel-doc:: drivers/cxl/pci.c
    :internal:
 
 CXL Core
diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 97dc4d751651..5483ba92b6da 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -21,15 +21,10 @@ config CXL_MEM
 	  as if the memory was attached to the typical CPU memory
 	  controller.
 
-	  Say 'y/m' to enable a driver (named "cxl_mem.ko" when built as
-	  a module) that will attach to CXL.mem devices for
-	  configuration, provisioning, and health monitoring. This
-	  driver is required for dynamic provisioning of CXL.mem
-	  attached memory which is a prerequisite for persistent memory
-	  support. Typically volatile memory is mapped by platform
-	  firmware and included in the platform memory map, but in some
-	  cases the OS is responsible for mapping that memory. See
-	  Chapter 2.3 Type 3 CXL Device in the CXL 2.0 specification.
+	  Say 'y/m' to enable a driver that will attach to CXL.mem devices for
+	  configuration and management primarily via the mailbox interface. See
+	  Chapter 2.3 Type 3 CXL Device in the CXL 2.0 specification for more
+	  details.
 
 	  If unsure say 'm'.
 
diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
index 3808e39dd31f..10b204025d3b 100644
--- a/drivers/cxl/Makefile
+++ b/drivers/cxl/Makefile
@@ -1,7 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_CXL_BUS) += cxl_core.o
-obj-$(CONFIG_CXL_MEM) += cxl_mem.o
+obj-$(CONFIG_CXL_MEM) += cxl_pci.o
 
 ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=CXL
 cxl_core-y := core.o
-cxl_mem-y := mem.o
+cxl_pci-y := pci.o
+cxl_acpi-y := acpi.o
diff --git a/drivers/cxl/mem.c b/drivers/cxl/pci.c
similarity index 99%
rename from drivers/cxl/mem.c
rename to drivers/cxl/pci.c
index c5fdf2c57181..c7996c2a2054 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/pci.c
@@ -16,10 +16,11 @@
 #include "mem.h"
 
 /**
- * DOC: cxl mem
+ * DOC: cxl pci
  *
- * This implements a CXL memory device ("type-3") as it is defined by the
- * Compute Express Link specification.
+ * This implements the PCI exclusive functionality for a CXL device as it is
+ * defined by the Compute Express Link specification. CXL devices may surface
+ * certain functionality even if it isn't CXL enabled.
  *
  * The driver has several responsibilities, mainly:
  *  - Create the memX device and register on the CXL bus.
@@ -27,8 +28,6 @@
  *  - Probe the device attributes to establish sysfs interface.
  *  - Provide an IOCTL interface to userspace to communicate with the device for
  *    things like firmware update.
- *  - Support management of interleave sets.
- *  - Handle and manage error conditions.
  */
 
 #define cxl_doorbell_busy(cxlm)                                                \
-- 
2.31.1

