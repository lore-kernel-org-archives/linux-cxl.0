Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5607C433EF
	for <linux-cxl@archiver.kernel.org>; Wed, 18 May 2022 23:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbiERXep (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 18 May 2022 19:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiERXep (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 18 May 2022 19:34:45 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBFDF5B8
        for <linux-cxl@vger.kernel.org>; Wed, 18 May 2022 16:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652916884; x=1684452884;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kdH08Bkq/R6M8QWrCQW99fPMWN5nySh6oM+XFB+z3gQ=;
  b=hFhkzqhAJ0echRSe4f4K7FJkcOkzlj3aBcPCVYZifAEPubeqi4Q4HtL8
   r3jh2OUecXMUdulR+Zqv75dhTI2Pkgky3PRwmN2BbqtHLRx0mxDZPRoR6
   gN4ULmVSH11qqV0MXdfEvH0dlLZah/4lRzOWDR6STbk4TOQZBbTlprNU1
   8L5WZzoAyS5pXWSfrF5oe93DpL+Fw6B+gDQODcNtvfHE73niq+XkcU1Up
   1gXUS4MjnPKZpEHZPhi02nQvVzemTcUaUapUD46jrliCliLdNZg3/eN6G
   ljm06ZQ/LwDB82hL9BBf387L1X9w+4l65rBmEcdz5hFpZh1GG/BEymAm1
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="358346102"
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="358346102"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 16:34:43 -0700
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="700850107"
Received: from vgarg-mobl2.amr.corp.intel.com (HELO [192.168.1.101]) ([10.209.5.211])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 16:34:43 -0700
Subject: [PATCH v3 06/13] cxl/pci: Move cxl_await_media_ready() to the core
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date:   Wed, 18 May 2022 16:34:43 -0700
Message-ID: <165291688340.1426646.4755627801983775011.stgit@dwillia2-xfh>
In-Reply-To: <165291684910.1426646.8615474651213855015.stgit@dwillia2-xfh>
References: <165291684910.1426646.8615474651213855015.stgit@dwillia2-xfh>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Allow cxl_await_media_ready() to be mocked for testing purposes rather
than carrying the maintenance burden of an indirect function call in the
mainline driver.

With the move cxl_await_media_ready() can no longer reuse the mailbox
timeout override, so add a media_ready_timeout module parameter to the
core to backfill.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/pci.c        |   48 +++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxlmem.h          |    3 +--
 drivers/cxl/mem.c             |    2 +-
 drivers/cxl/pci.c             |   45 +-------------------------------------
 tools/testing/cxl/Kbuild      |    1 +
 tools/testing/cxl/test/mem.c  |    7 ------
 tools/testing/cxl/test/mock.c |   15 +++++++++++++
 7 files changed, 67 insertions(+), 54 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index c9a494d6976a..603945f49174 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -1,8 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2021 Intel Corporation. All rights reserved. */
+#include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/device.h>
+#include <linux/delay.h>
 #include <linux/pci.h>
 #include <cxlpci.h>
+#include <cxlmem.h>
 #include <cxl.h>
 #include "core.h"
 
@@ -13,6 +16,10 @@
  * a set of helpers for CXL interactions which occur via PCIe.
  */
 
+static unsigned short media_ready_timeout = 60;
+module_param(media_ready_timeout, ushort, 0644);
+MODULE_PARM_DESC(media_ready_timeout, "seconds to wait for media ready");
+
 struct cxl_walk_context {
 	struct pci_bus *bus;
 	struct cxl_port *port;
@@ -94,3 +101,44 @@ int devm_cxl_port_enumerate_dports(struct cxl_port *port)
 	return ctx.count;
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_port_enumerate_dports, CXL);
+
+/*
+ * Wait up to @media_ready_timeout for the device to report memory
+ * active.
+ */
+int cxl_await_media_ready(struct cxl_dev_state *cxlds)
+{
+	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
+	int d = cxlds->cxl_dvsec;
+	bool active = false;
+	u64 md_status;
+	int rc, i;
+
+	for (i = media_ready_timeout; i; i--) {
+		u32 temp;
+
+		rc = pci_read_config_dword(
+			pdev, d + CXL_DVSEC_RANGE_SIZE_LOW(0), &temp);
+		if (rc)
+			return rc;
+
+		active = FIELD_GET(CXL_DVSEC_MEM_ACTIVE, temp);
+		if (active)
+			break;
+		msleep(1000);
+	}
+
+	if (!active) {
+		dev_err(&pdev->dev,
+			"timeout awaiting memory active after %d seconds\n",
+			media_ready_timeout);
+		return -ETIMEDOUT;
+	}
+
+	md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
+	if (!CXLMDEV_READY(md_status))
+		return -EIO;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_await_media_ready, CXL);
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 7235d2f976e5..843916c1dab6 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -192,7 +192,6 @@ struct cxl_endpoint_dvsec_info {
  * @info: Cached DVSEC information about the device.
  * @serial: PCIe Device Serial Number
  * @mbox_send: @dev specific transport for transmitting mailbox commands
- * @wait_media_ready: @dev specific method to await media ready
  *
  * See section 8.2.9.5.2 Capacity Configuration and Label Storage for
  * details on capacity parameters.
@@ -227,7 +226,6 @@ struct cxl_dev_state {
 	u64 serial;
 
 	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
-	int (*wait_media_ready)(struct cxl_dev_state *cxlds);
 };
 
 enum cxl_opcode {
@@ -348,6 +346,7 @@ struct cxl_mem_command {
 int cxl_mbox_send_cmd(struct cxl_dev_state *cxlds, u16 opcode, void *in,
 		      size_t in_size, void *out, size_t out_size);
 int cxl_dev_state_identify(struct cxl_dev_state *cxlds);
+int cxl_await_media_ready(struct cxl_dev_state *cxlds);
 int cxl_enumerate_cmds(struct cxl_dev_state *cxlds);
 int cxl_mem_create_range_info(struct cxl_dev_state *cxlds);
 struct cxl_dev_state *cxl_dev_state_create(struct device *dev);
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 80e75a410499..8c3a1c85a7ae 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -165,7 +165,7 @@ static int cxl_mem_probe(struct device *dev)
 	if (rc)
 		return rc;
 
-	rc = cxlds->wait_media_ready(cxlds);
+	rc = cxl_await_media_ready(cxlds);
 	if (rc) {
 		dev_err(dev, "Media not active (%d)\n", rc);
 		return rc;
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 91b266911e52..1bf880fa1fb8 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -48,8 +48,7 @@
  */
 static unsigned short mbox_ready_timeout = 60;
 module_param(mbox_ready_timeout, ushort, 0644);
-MODULE_PARM_DESC(mbox_ready_timeout,
-		 "seconds to wait for mailbox ready / memory active status");
+MODULE_PARM_DESC(mbox_ready_timeout, "seconds to wait for mailbox ready");
 
 static int cxl_pci_mbox_wait_for_doorbell(struct cxl_dev_state *cxlds)
 {
@@ -419,46 +418,6 @@ static int wait_for_valid(struct cxl_dev_state *cxlds)
 	return -ETIMEDOUT;
 }
 
-/*
- * Wait up to @mbox_ready_timeout for the device to report memory
- * active.
- */
-static int cxl_await_media_ready(struct cxl_dev_state *cxlds)
-{
-	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
-	int d = cxlds->cxl_dvsec;
-	bool active = false;
-	u64 md_status;
-	int rc, i;
-
-	for (i = mbox_ready_timeout; i; i--) {
-		u32 temp;
-
-		rc = pci_read_config_dword(
-			pdev, d + CXL_DVSEC_RANGE_SIZE_LOW(0), &temp);
-		if (rc)
-			return rc;
-
-		active = FIELD_GET(CXL_DVSEC_MEM_ACTIVE, temp);
-		if (active)
-			break;
-		msleep(1000);
-	}
-
-	if (!active) {
-		dev_err(&pdev->dev,
-			"timeout awaiting memory active after %d seconds\n",
-			mbox_ready_timeout);
-		return -ETIMEDOUT;
-	}
-
-	md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
-	if (!CXLMDEV_READY(md_status))
-		return -EIO;
-
-	return 0;
-}
-
 /*
  * Return positive number of non-zero ranges on success and a negative
  * error code on failure. The cxl_mem driver depends on ranges == 0 to
@@ -589,8 +548,6 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		dev_warn(&pdev->dev,
 			 "Device DVSEC not present, skip CXL.mem init\n");
 
-	cxlds->wait_media_ready = cxl_await_media_ready;
-
 	rc = cxl_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
 	if (rc)
 		return rc;
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 82e49ab0937d..6007fe770122 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -8,6 +8,7 @@ ldflags-y += --wrap=devm_cxl_port_enumerate_dports
 ldflags-y += --wrap=devm_cxl_setup_hdm
 ldflags-y += --wrap=devm_cxl_add_passthrough_decoder
 ldflags-y += --wrap=devm_cxl_enumerate_decoders
+ldflags-y += --wrap=cxl_await_media_ready
 
 DRIVERS := ../../../drivers
 CXL_SRC := $(DRIVERS)/cxl
diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index b6b726eff3e2..c519ace17b41 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -237,12 +237,6 @@ static int cxl_mock_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *
 	return rc;
 }
 
-static int cxl_mock_wait_media_ready(struct cxl_dev_state *cxlds)
-{
-	msleep(100);
-	return 0;
-}
-
 static void label_area_release(void *lsa)
 {
 	vfree(lsa);
@@ -278,7 +272,6 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 
 	cxlds->serial = pdev->id;
 	cxlds->mbox_send = cxl_mock_mbox_send;
-	cxlds->wait_media_ready = cxl_mock_wait_media_ready;
 	cxlds->payload_size = SZ_4K;
 
 	rc = cxl_enumerate_cmds(cxlds);
diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
index 6e8c9d63c92d..2c01d81ab014 100644
--- a/tools/testing/cxl/test/mock.c
+++ b/tools/testing/cxl/test/mock.c
@@ -193,6 +193,21 @@ int __wrap_devm_cxl_port_enumerate_dports(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_port_enumerate_dports, CXL);
 
+int __wrap_cxl_await_media_ready(struct cxl_dev_state *cxlds)
+{
+	int rc, index;
+	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
+
+	if (ops && ops->is_mock_dev(cxlds->dev))
+		rc = 0;
+	else
+		rc = cxl_await_media_ready(cxlds);
+	put_cxl_mock_ops(index);
+
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(__wrap_cxl_await_media_ready, CXL);
+
 MODULE_LICENSE("GPL v2");
 MODULE_IMPORT_NS(ACPI);
 MODULE_IMPORT_NS(CXL);

