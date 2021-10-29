Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BCEC433F5
	for <linux-cxl@archiver.kernel.org>; Fri, 29 Oct 2021 19:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39D6A6101E
	for <linux-cxl@archiver.kernel.org>; Fri, 29 Oct 2021 19:55:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbhJ2T6R (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 29 Oct 2021 15:58:17 -0400
Received: from mga01.intel.com ([192.55.52.88]:59923 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229886AbhJ2T6Q (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 29 Oct 2021 15:58:16 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10152"; a="254325920"
X-IronPort-AV: E=Sophos;i="5.87,193,1631602800"; 
   d="scan'208";a="254325920"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2021 12:55:47 -0700
X-IronPort-AV: E=Sophos;i="5.87,193,1631602800"; 
   d="scan'208";a="466634860"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2021 12:55:47 -0700
Subject: [PATCH] cxl/pmem: Fix reference counting for delayed work
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     ira.weiny@intel.com, ben.widawsky@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com
Date:   Fri, 29 Oct 2021 12:55:47 -0700
Message-ID: <163553734757.2509761.3305231863616785470.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

There is a potential race between queue_work() returning and the
queued-work running that could result in put_device() running before
get_device(). Introduce the cxl_nvdimm_bridge_state_work() helper that
takes the reference unconditionally, but drops it if no new work was
queued, to keep the references balanced.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/pmem.c |   17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
index ceb2115981e5..38bcbb4e9409 100644
--- a/drivers/cxl/pmem.c
+++ b/drivers/cxl/pmem.c
@@ -266,14 +266,24 @@ static void cxl_nvb_update_state(struct work_struct *work)
 	put_device(&cxl_nvb->dev);
 }
 
+static void cxl_nvdimm_bridge_state_work(struct cxl_nvdimm_bridge *cxl_nvb)
+{
+	/*
+	 * Take a reference that the workqueue will drop if new work
+	 * gets queued.
+	 */
+	get_device(&cxl_nvb->dev);
+	if (!queue_work(cxl_pmem_wq, &cxl_nvb->state_work))
+		put_device(&cxl_nvb->dev);
+}
+
 static void cxl_nvdimm_bridge_remove(struct device *dev)
 {
 	struct cxl_nvdimm_bridge *cxl_nvb = to_cxl_nvdimm_bridge(dev);
 
 	if (cxl_nvb->state == CXL_NVB_ONLINE)
 		cxl_nvb->state = CXL_NVB_OFFLINE;
-	if (queue_work(cxl_pmem_wq, &cxl_nvb->state_work))
-		get_device(&cxl_nvb->dev);
+	cxl_nvdimm_bridge_state_work(cxl_nvb);
 }
 
 static int cxl_nvdimm_bridge_probe(struct device *dev)
@@ -294,8 +304,7 @@ static int cxl_nvdimm_bridge_probe(struct device *dev)
 	}
 
 	cxl_nvb->state = CXL_NVB_ONLINE;
-	if (queue_work(cxl_pmem_wq, &cxl_nvb->state_work))
-		get_device(&cxl_nvb->dev);
+	cxl_nvdimm_bridge_state_work(cxl_nvb);
 
 	return 0;
 }

