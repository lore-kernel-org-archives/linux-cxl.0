Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC89C636D4
	for <linux-cxl@archiver.kernel.org>; Mon, 13 Feb 2023 20:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjBMU2s (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 13 Feb 2023 15:28:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjBMU2q (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 13 Feb 2023 15:28:46 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5886DC
        for <linux-cxl@vger.kernel.org>; Mon, 13 Feb 2023 12:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676320125; x=1707856125;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7nSlvn5QcvmtDsAAZLWn2gRqS0155OYTIUrKzXqIoeo=;
  b=DQ2+EyI5guDjwlr7TcCrkfayhgwxkX3v7WmcA8zS46fpYi8DZ9Z7yEXU
   qsXEC0WGTGlDLDpaMWOfUe2LDDcrlZv1u1h7sTDURFD5W40j5+mCQNPLp
   kqsoU2rDAF5UoOXUp1+WGBCX/lsWenYEQfz/oFI/Yu4B/XUtF3fmmBq7S
   Oi1R16oRIEGp6sMPuBlsGImC0+U1H/utp3kSXLzNKxDIGCrRxsEJcpdM4
   0auTWRkXeBfh32iBtSngO+lAjbvd2OAZcvzvOVUe1tD9MqcF6W+8bApVU
   5Gyw+U7SfPP+z11qLTKwRJpJvWV6BYfLyri076y+PR7JSm8opTIfWpzMi
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="393392704"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="393392704"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 12:28:45 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="701406469"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="701406469"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO djiang5-mobl3.local) ([10.212.99.85])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 12:28:44 -0800
Subject: [PATCH] cxl: remove unnecessary calling of
 pci_enable_pcie_error_reporting()
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, bhelgaas@google.com, ira.weiny@intel.com,
        Jonathan.Cameron@Huawei.com, lukas@wunner.de
Date:   Mon, 13 Feb 2023 13:28:42 -0700
Message-ID: <167632012093.4153151.5360778069735064322.stgit@djiang5-mobl3.local>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

With this [1] commit upstream, pci_enable_pci_error_report() is no longer
necessary for the driver to call. Remove call and related cleanups.

[1]: f26e58bf6f54 ("PCI/AER: Enable error reporting when AER is native")

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/pci.c |   11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 4cf9a2191602..c87340095a8a 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -412,11 +412,6 @@ static bool is_cxl_restricted(struct pci_dev *pdev)
 	return pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END;
 }
 
-static void disable_aer(void *pdev)
-{
-	pci_disable_pcie_error_reporting(pdev);
-}
-
 static void free_event_buf(void *buf)
 {
 	kvfree(buf);
@@ -733,12 +728,6 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
-	if (cxlds->regs.ras) {
-		pci_enable_pcie_error_reporting(pdev);
-		rc = devm_add_action_or_reset(&pdev->dev, disable_aer, pdev);
-		if (rc)
-			return rc;
-	}
 	pci_save_state(pdev);
 
 	return rc;


