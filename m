Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA7D1C77B73
	for <linux-cxl@archiver.kernel.org>; Thu, 18 May 2023 23:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjERXDq (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 18 May 2023 19:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjERXDp (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 18 May 2023 19:03:45 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D681B18D
        for <linux-cxl@vger.kernel.org>; Thu, 18 May 2023 16:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684451024; x=1715987024;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5B6HA81tVbn/5OxvvIy+Re4+yOeE/xFsC6hTJ1cCxaY=;
  b=X2qgEJUCHri3A/4GkcaOn1oDrUDE3mm5Jqg1ZMgNuH2xoQ3Xbyq0YQ+J
   H8MVZieEyp31YK/QD/gKsEOW7ouAWsCIuBQNyVYjFUGYdj31WrXy/JpMZ
   HuIlZxQxmuUZQk4yZ0Og65dwrvIML2EE86QAZet4cVMyK66Jh/PpaMbJT
   02zvPJab8Jaiuty5q2DpM5uUn4UZgucWtllDEZS40I9VQs6xKZBfDIXm8
   SLIeYuMrtBuTA0sNfLF4RDHAJBwtTj7wGfgxIsDRaz+KEIl7O2bH7GKEp
   s2mDpE08il0fX9iz84jzJFB9n2lSXZhjLkYWmcIcqxkUKwUUCGFSgxEi5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="355434325"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; 
   d="scan'208";a="355434325"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 16:03:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="679832130"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; 
   d="scan'208";a="679832130"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.16.136])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 16:03:43 -0700
Subject: [PATCH v4 2/2] cxl: Move cxl_await_media_ready() to before capacity
 info retrieval
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, dan.j.williams@intel.com
Cc:     Ira Weiny <ira.weiny@intel.com>
Date:   Thu, 18 May 2023 16:03:43 -0700
Message-ID: <168445102304.3241714.10279441298179336657.stgit@djiang5-mobl3>
In-Reply-To: <6466a10d32f3d_682c1294f8@dwillia2-xfh.jf.intel.com.notmuch>
References: <6466a10d32f3d_682c1294f8@dwillia2-xfh.jf.intel.com.notmuch>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Move cxl_await_media_ready() to cxl_pci probe before driver starts issuing
IDENTIFY and retrieving memory device information to ensure that the
device is ready to provide the information. Allow pci_probe() to succeed
even if media is not ready. Cache the media failure in cxlds and don't ask
the device for any media information.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Fixes: b39cb1052a5c ("cxl/mem: Register CXL memX devices")
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---
v4:
- Fail mem_probe() if media not ready. (Dan)
v3:
- Allow pci_probe() to succeed even when media is not ready. (Dan)
- Cache media failure and skip any operation probing the media. (Dan)
---
 drivers/cxl/core/mbox.c |   15 ++++++++++-----
 drivers/cxl/cxlmem.h    |    2 ++
 drivers/cxl/mem.c       |    3 +++
 drivers/cxl/pci.c       |    6 ++++++
 drivers/cxl/port.c      |    6 ------
 5 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index f2addb457172..114e15d02bde 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -984,7 +984,7 @@ static int cxl_mem_get_partition_info(struct cxl_dev_state *cxlds)
  * cxl_dev_state_identify() - Send the IDENTIFY command to the device.
  * @cxlds: The device data for the operation
  *
- * Return: 0 if identify was executed successfully.
+ * Return: 0 if identify was executed successfully or media not ready.
  *
  * This will dispatch the identify command to the device and on success populate
  * structures to be exported to sysfs.
@@ -996,6 +996,9 @@ int cxl_dev_state_identify(struct cxl_dev_state *cxlds)
 	struct cxl_mbox_cmd mbox_cmd;
 	int rc;
 
+	if (!cxlds->media_ready)
+		return 0;
+
 	mbox_cmd = (struct cxl_mbox_cmd) {
 		.opcode = CXL_MBOX_OP_IDENTIFY,
 		.size_out = sizeof(id),
@@ -1065,10 +1068,12 @@ int cxl_mem_create_range_info(struct cxl_dev_state *cxlds)
 				   cxlds->persistent_only_bytes, "pmem");
 	}
 
-	rc = cxl_mem_get_partition_info(cxlds);
-	if (rc) {
-		dev_err(dev, "Failed to query partition information\n");
-		return rc;
+	if (cxlds->media_ready) {
+		rc = cxl_mem_get_partition_info(cxlds);
+		if (rc) {
+			dev_err(dev, "Failed to query partition information\n");
+			return rc;
+		}
 	}
 
 	rc = add_dpa_res(dev, &cxlds->dpa_res, &cxlds->ram_res, 0,
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 001dabf0231b..b24796862e13 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -227,6 +227,7 @@ struct cxl_event_state {
  * @regs: Parsed register blocks
  * @cxl_dvsec: Offset to the PCIe device DVSEC
  * @rcd: operating in RCD mode (CXL 3.0 9.11.8 CXL Devices Attached to an RCH)
+ * @media_ready: Indicate whether the device media is usable
  * @payload_size: Size of space for payload
  *                (CXL 2.0 8.2.8.4.3 Mailbox Capabilities Register)
  * @lsa_size: Size of Label Storage Area
@@ -263,6 +264,7 @@ struct cxl_dev_state {
 	int cxl_dvsec;
 
 	bool rcd;
+	bool media_ready;
 	size_t payload_size;
 	size_t lsa_size;
 	struct mutex mbox_mutex; /* Protects device mailbox and firmware */
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 39c4b54f0715..71d7eafb6c94 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -104,6 +104,9 @@ static int cxl_mem_probe(struct device *dev)
 	struct dentry *dentry;
 	int rc;
 
+	if (!cxlds->media_ready)
+		return -EBUSY;
+
 	/*
 	 * Someone is trying to reattach this device after it lost its port
 	 * connection (an endpoint port previously registered by this memdev was
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index ea38bd49b0cf..8e761c122966 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -708,6 +708,12 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
 
+	rc = cxl_await_media_ready(cxlds);
+	if (rc == 0)
+		cxlds->media_ready = true;
+	else
+		dev_warn(&pdev->dev, "Media not active (%d)\n", rc);
+
 	rc = cxl_pci_setup_mailbox(cxlds);
 	if (rc)
 		return rc;
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index a49f5eb149f1..bfb948e00c42 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -108,12 +108,6 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 	if (rc)
 		return rc;
 
-	rc = cxl_await_media_ready(cxlds);
-	if (rc) {
-		dev_err(&port->dev, "Media not active (%d)\n", rc);
-		return rc;
-	}
-
 	rc = devm_cxl_enumerate_decoders(cxlhdm, &info);
 	if (rc)
 		return rc;


