Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17AF0C433F5
	for <linux-cxl@archiver.kernel.org>; Mon, 29 Nov 2021 21:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbhK2V6D (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 29 Nov 2021 16:58:03 -0500
Received: from mga18.intel.com ([134.134.136.126]:47152 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232663AbhK2V4D (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 29 Nov 2021 16:56:03 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="222968505"
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="222968505"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 13:47:26 -0800
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="458596095"
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
Subject: [PATCH 5/9] cxl/pci: Don't poll doorbell for mailbox access
Date:   Mon, 29 Nov 2021 13:47:17 -0800
Message-Id: <20211129214721.1668325-6-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211129214721.1668325-1-ben.widawsky@intel.com>
References: <20211129214721.1668325-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The expectation is that the mailbox interface ready bit will be set at
the start of any access through the mailbox interface. Therefore,
waiting for the doorbell busy bit to be clear would imply that the
mailbox interface is ready. The original driver implementation used the
doorbell timeout for the Mailbox Interface Ready bit to piggyback off
of, since the latter doesn't have a defined timeout (introduced in
commit 8adaf747c9f0 ("cxl/mem: Find device capabilities"), a timeout has
since been defined with an ECN to the 2.0 spec). With the current driver
waiting for mailbox interface ready as a part of probe() it's no longer
necessary to use the piggyback.

With the piggybacking no longer necessary it doesn't make sense to check
doorbell status when acquiring the mailbox. It will be checked during
the normal mailbox exchange protocol.

While here, make minor whitespace fix in the comment describing the
behavior.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com> (v1)
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
Changes since v1:
Reword commit message (Jonathan)
Drop comment block altogether (Dan)
Don't check IF ready in mbox_get() (Dan)
---
 drivers/cxl/pci.c | 36 +-----------------------------------
 1 file changed, 1 insertion(+), 35 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index b28c220d48ea..ada0d67c8194 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -219,46 +219,12 @@ static int cxl_pci_mbox_get(struct cxl_dev_state *cxlds)
 
 	mutex_lock_io(&cxlds->mbox_mutex);
 
-	/*
-	 * XXX: There is some amount of ambiguity in the 2.0 version of the spec
-	 * around the mailbox interface ready (8.2.8.5.1.1).  The purpose of the
-	 * bit is to allow firmware running on the device to notify the driver
-	 * that it's ready to receive commands. It is unclear if the bit needs
-	 * to be read for each transaction mailbox, ie. the firmware can switch
-	 * it on and off as needed. Second, there is no defined timeout for
-	 * mailbox ready, like there is for the doorbell interface.
-	 *
-	 * Assumptions:
-	 * 1. The firmware might toggle the Mailbox Interface Ready bit, check
-	 *    it for every command.
-	 *
-	 * 2. If the doorbell is clear, the firmware should have first set the
-	 *    Mailbox Interface Ready bit. Therefore, waiting for the doorbell
-	 *    to be ready is sufficient.
-	 */
-	rc = cxl_pci_mbox_wait_for_doorbell(cxlds);
-	if (rc) {
-		dev_warn(dev, "Mailbox interface not ready\n");
-		goto out;
-	}
-
-	md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
-	if (!(md_status & CXLMDEV_MBOX_IF_READY && CXLMDEV_READY(md_status))) {
-		dev_err(dev, "mbox: reported doorbell ready, but not mbox ready\n");
-		rc = -EBUSY;
-		goto out;
-	}
-
-	/*
-	 * Hardware shouldn't allow a ready status but also have failure bits
-	 * set. Spit out an error, this should be a bug report
-	 */
 	rc = check_device_status(cxlds);
 	if (rc)
 		goto out;
 
 	if (CXLMDEV_RESET_NEEDED(md_status)) {
-		dev_err(dev, "mbox: reported ready, but reset needed\n");
+		dev_err(dev, "mbox: reset needed\n");
 		rc = -EFAULT;
 		goto out;
 	}
-- 
2.34.1

