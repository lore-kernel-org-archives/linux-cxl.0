Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC98C77B7D
	for <linux-cxl@archiver.kernel.org>; Thu, 18 May 2023 23:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjERXiX (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 18 May 2023 19:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjERXiX (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 18 May 2023 19:38:23 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21161F4
        for <linux-cxl@vger.kernel.org>; Thu, 18 May 2023 16:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684453102; x=1715989102;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eLXUvvBZLn5N4um3EyEfS+f6gIDh6Wzl1UgOOedzj/E=;
  b=K2GRshpCB3CH7lKG0ipzA7nZVFUwPKKW3SYu3qdM7/B0/94vCZfXri66
   Kwtq1azoEqqSKrJT+eKWxmJ7w3AStiske67wju2801JHVK8nTIOK4QdgJ
   bTKSbWrhyIqIjJ08NIg2XyuK74zALBqA+ri5gSWj75igT1nCkweyovCyc
   qraG40y31zIYKSkCHkDdZ5fR9rhdbHXZe0NvKwyIG0uoXdcgiZEBJS08A
   PrM+nBqj1o5GZFmeVQz/LviAoNZLIcaeUs3OKhkCKJBwCXWAiJrwT52mz
   cNfEk78njpfi5b45OWYTp7won4Z9ThnXPQ3Daf9/uPSt4iwI187FE+kcv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="351061463"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; 
   d="scan'208";a="351061463"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 16:38:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="735293378"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; 
   d="scan'208";a="735293378"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.16.136])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 16:38:20 -0700
Subject: [PATCH v5 2/2] cxl: Move cxl_await_media_ready() to before capacity
 info retrieval
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, dan.j.williams@intel.com
Cc:     Ira Weiny <ira.weiny@intel.com>
Date:   Thu, 18 May 2023 16:38:20 -0700
Message-ID: <168445310026.3251520.8124296540679268206.stgit@djiang5-mobl3>
In-Reply-To: <168445102304.3241714.10279441298179336657.stgit@djiang5-mobl3>
References: <168445102304.3241714.10279441298179336657.stgit@djiang5-mobl3>
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
v5:
- Rebase on top of v6.4-rc2
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
index 23b9ff920d7e..2c8dc7e2b84d 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1028,7 +1028,7 @@ static int cxl_mem_get_partition_info(struct cxl_dev_state *cxlds)
  * cxl_dev_state_identify() - Send the IDENTIFY command to the device.
  * @cxlds: The device data for the operation
  *
- * Return: 0 if identify was executed successfully.
+ * Return: 0 if identify was executed successfully or media not ready.
  *
  * This will dispatch the identify command to the device and on success populate
  * structures to be exported to sysfs.
@@ -1041,6 +1041,9 @@ int cxl_dev_state_identify(struct cxl_dev_state *cxlds)
 	u32 val;
 	int rc;
 
+	if (!cxlds->media_ready)
+		return 0;
+
 	mbox_cmd = (struct cxl_mbox_cmd) {
 		.opcode = CXL_MBOX_OP_IDENTIFY,
 		.size_out = sizeof(id),
@@ -1115,10 +1118,12 @@ int cxl_mem_create_range_info(struct cxl_dev_state *cxlds)
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
index db12b6313afb..a2845a7a69d8 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -266,6 +266,7 @@ struct cxl_poison_state {
  * @regs: Parsed register blocks
  * @cxl_dvsec: Offset to the PCIe device DVSEC
  * @rcd: operating in RCD mode (CXL 3.0 9.11.8 CXL Devices Attached to an RCH)
+ * @media_ready: Indicate whether the device media is usable
  * @payload_size: Size of space for payload
  *                (CXL 2.0 8.2.8.4.3 Mailbox Capabilities Register)
  * @lsa_size: Size of Label Storage Area
@@ -303,6 +304,7 @@ struct cxl_dev_state {
 	int cxl_dvsec;
 
 	bool rcd;
+	bool media_ready;
 	size_t payload_size;
 	size_t lsa_size;
 	struct mutex mbox_mutex; /* Protects device mailbox and firmware */
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 10caf180b3fa..519edd0eb196 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -124,6 +124,9 @@ static int cxl_mem_probe(struct device *dev)
 	struct dentry *dentry;
 	int rc;
 
+	if (!cxlds->media_ready)
+		return -EBUSY;
+
 	/*
 	 * Someone is trying to reattach this device after it lost its port
 	 * connection (an endpoint port previously registered by this memdev was
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index f7a5b8e9c102..0872f2233ed0 100644
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
index eb57324c4ad4..07c5ac598da1 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -113,12 +113,6 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
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


