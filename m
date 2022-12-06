Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BEF5C352A1
	for <linux-cxl@archiver.kernel.org>; Tue,  6 Dec 2022 04:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbiLFE2n (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 5 Dec 2022 23:28:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiLFE2l (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 5 Dec 2022 23:28:41 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3CDDED
        for <linux-cxl@vger.kernel.org>; Mon,  5 Dec 2022 20:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670300920; x=1701836920;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QGq9B2kwQ+fXNW5092tDUoCD+7HSV9wrZ6gnkxQtSu4=;
  b=Qnv3xrr0Z6B4rxqPD/B+OwT0zTH0awjGycyzy9FSsFA/AppnxkEi/Zfk
   ue+yFa5uFIR/7+gEFJMUlYnqyIU6xZ37kRcmsilTD/WPRVLL/oXfauKeZ
   mVvyyfUAN1JPOUTdZ3URwYKyA+V6ySvL1fYBmyG0R6aI+5ij9JGzco+K+
   1Q5NT0yZFw24Kb2lQ16EdQ1RJZ4ePcY9plsbl8rlTpbiY3YqU/htgqb8G
   +YoUTuaWL1EeX5MwuI1eBZv0UlsJE7IaQS19G9ZmsMnpsa1hJHTz2a+Zx
   FS0YWk7WtAcNbbu2VGPyv5pTGAnxt1+UwU2zishjFZ8Wq/YjM9QErFS9P
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="304152049"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="304152049"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 20:28:40 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="770591599"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="770591599"
Received: from bmnebren-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.114.171])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 20:28:40 -0800
Subject: [PATCH] cxl/pci: Remove endian confusion
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>, dave.jiang@intel.com
Date:   Mon, 05 Dec 2022 20:28:40 -0800
Message-ID: <167030092025.4045167.10651070153523351093.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

readl() already handles endian conversion. That's the main difference
between readl() and __raw_readl(). This is benign on little-endian
systems, but big endian systems will end up byte-swabbing twice.

Fixes: 2905cb5236cb ("cxl/pci: Add (hopeful) error handling support")
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/pci.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index cced4a0df3d1..33083a522fd1 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -548,15 +548,14 @@ static bool cxl_report_and_clear(struct cxl_dev_state *cxlds)
 		return false;
 
 	addr = cxlds->regs.ras + CXL_RAS_UNCORRECTABLE_STATUS_OFFSET;
-	status = le32_to_cpu((__force __le32)readl(addr));
+	status = readl(addr);
 	if (!(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK))
 		return false;
 
 	/* If multiple errors, log header points to first error from ctrl reg */
 	if (hweight32(status) > 1) {
 		addr = cxlds->regs.ras + CXL_RAS_CAP_CONTROL_OFFSET;
-		fe = BIT(le32_to_cpu((__force __le32)readl(addr)) &
-				     CXL_RAS_CAP_CONTROL_FE_MASK);
+		fe = BIT(FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK, readl(addr)));
 	} else {
 		fe = status;
 	}
@@ -641,7 +640,7 @@ static void cxl_cor_error_detected(struct pci_dev *pdev)
 		return;
 
 	addr = cxlds->regs.ras + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
-	status = le32_to_cpu(readl(addr));
+	status = readl(addr);
 	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
 		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
 		trace_cxl_aer_correctable_error(dev, status);

