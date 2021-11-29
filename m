Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0007AC433F5
	for <linux-cxl@archiver.kernel.org>; Mon, 29 Nov 2021 21:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbhK2V56 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 29 Nov 2021 16:57:58 -0500
Received: from mga18.intel.com ([134.134.136.126]:46994 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232517AbhK2Vz6 (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 29 Nov 2021 16:55:58 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="222968502"
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="222968502"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 13:47:25 -0800
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="458596088"
Received: from ajsteine-mobl13.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.141.244])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 13:47:25 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 3/9] cxl/pci: Extract device status check
Date:   Mon, 29 Nov 2021 13:47:15 -0800
Message-Id: <20211129214721.1668325-4-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211129214721.1668325-1-ben.widawsky@intel.com>
References: <20211129214721.1668325-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The Memory Device Status register is inspected in the same way for at
least two flows in the CXL Type 3 Memory Device Software Guide
(Revision: 1.0): 2.13.9 Device discovery and mailbox ready sequence,
and 2.13.10 Media ready sequence. Extract this common functionality for
use by both.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/pci.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index a6ea9811a05b..6c8d09fb3a17 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -182,6 +182,27 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_state *cxlds,
 	return 0;
 }
 
+/*
+ * Implements roughly the bottom half of Figure 42 of the CXL Type 3 Memory
+ * Device Software Guide
+ */
+static int check_device_status(struct cxl_dev_state *cxlds)
+{
+	const u64 md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
+
+	if (md_status & CXLMDEV_DEV_FATAL) {
+		dev_err(cxlds->dev, "Fatal: replace device\n");
+		return -EIO;
+	}
+
+	if (md_status & CXLMDEV_FW_HALT) {
+		dev_err(cxlds->dev, "FWHalt: reset or replace device\n");
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
 /**
  * cxl_pci_mbox_get() - Acquire exclusive access to the mailbox.
  * @cxlds: The device state to gain access to.
@@ -231,17 +252,13 @@ static int cxl_pci_mbox_get(struct cxl_dev_state *cxlds)
 	 * Hardware shouldn't allow a ready status but also have failure bits
 	 * set. Spit out an error, this should be a bug report
 	 */
-	rc = -EFAULT;
-	if (md_status & CXLMDEV_DEV_FATAL) {
-		dev_err(dev, "mbox: reported ready, but fatal\n");
+	rc = check_device_status(cxlds);
+	if (rc)
 		goto out;
-	}
-	if (md_status & CXLMDEV_FW_HALT) {
-		dev_err(dev, "mbox: reported ready, but halted\n");
-		goto out;
-	}
+
 	if (CXLMDEV_RESET_NEEDED(md_status)) {
 		dev_err(dev, "mbox: reported ready, but reset needed\n");
+		rc = -EFAULT;
 		goto out;
 	}
 
-- 
2.34.1

