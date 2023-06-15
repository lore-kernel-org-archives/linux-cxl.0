Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 700BCEB64D9
	for <linux-cxl@archiver.kernel.org>; Thu, 15 Jun 2023 01:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236909AbjFOBag (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 14 Jun 2023 21:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237002AbjFOBad (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 14 Jun 2023 21:30:33 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390762125
        for <linux-cxl@vger.kernel.org>; Wed, 14 Jun 2023 18:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686792632; x=1718328632;
  h=subject:from:to:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=6MjfyQWWmtxlSd+nOeVy+ZaSTbDkcyWNJ3LH8vOJIT0=;
  b=ejTAo3uqvJMpD69bj2svwN5oFzOgq4DLnPoFuyx60aZvuZLUVWq/Sada
   sLcnk0a/aXdk6CcSQd9Kl1dT5n8L0TaM7uE6xpLKzDQAzFS5GErANlDxp
   3wzIp5CvH7UJm45TF5pShUDerrqUYuzM43F7OXswAG06sb8fMdHPkL7P5
   /WGa+3wYprBvzbXVC9NWzLBwGqU06U9G9SV8v87/z69MVc5ggXOoBO+ZU
   ls9OHV/1Ioz/mSpbhJUlcoXzzqLCjGnrv9mMP20iU9h/bdinNE4waHmp4
   bsBBkaD7VMIVRbwP9Ixt1+T7/jfxV9iHxZNeQkDOdscKZ4IfX8QTzPeTV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="338412426"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="338412426"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 18:30:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="782307513"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="782307513"
Received: from rtpearso-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.87.28])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 18:30:31 -0700
Subject: [PATCH v2 10/12] cxl/pci: Unconditionally unmask 256B Flit errors
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Date:   Wed, 14 Jun 2023 18:30:31 -0700
Message-ID: <168679263124.3436160.6228910132469454346.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <168679257511.3436160.9707734364766526576.stgit@dwillia2-xfh.jf.intel.com>
References: <168679257511.3436160.9707734364766526576.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The current check for 256B Flit mode is incomplete and unnecessary. It
is incomplete because it fails to consider the link speed, or check for
CXL link capabilities. It is unnecessary because unconditionally
unmasking 256B Flit errors is a nop when 256B Flit operation is not
available.

Remove this check in preparation for creating a cxl_probe_link() helper
to centralize this detection.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/pci.c |   18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 4e2845b7331a..3f78082014cc 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -368,19 +368,6 @@ static bool is_cxl_restricted(struct pci_dev *pdev)
 	return pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END;
 }
 
-/*
- * CXL v3.0 6.2.3 Table 6-4
- * The table indicates that if PCIe Flit Mode is set, then CXL is in 256B flits
- * mode, otherwise it's 68B flits mode.
- */
-static bool cxl_pci_flit_256(struct pci_dev *pdev)
-{
-	u16 lnksta2;
-
-	pcie_capability_read_word(pdev, PCI_EXP_LNKSTA2, &lnksta2);
-	return lnksta2 & PCI_EXP_LNKSTA2_FLIT;
-}
-
 static int cxl_pci_ras_unmask(struct pci_dev *pdev)
 {
 	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
@@ -407,9 +394,8 @@ static int cxl_pci_ras_unmask(struct pci_dev *pdev)
 		addr = cxlds->regs.ras + CXL_RAS_UNCORRECTABLE_MASK_OFFSET;
 		orig_val = readl(addr);
 
-		mask = CXL_RAS_UNCORRECTABLE_MASK_MASK;
-		if (!cxl_pci_flit_256(pdev))
-			mask &= ~CXL_RAS_UNCORRECTABLE_MASK_F256B_MASK;
+		mask = CXL_RAS_UNCORRECTABLE_MASK_MASK |
+		       CXL_RAS_UNCORRECTABLE_MASK_F256B_MASK;
 		val = orig_val & ~mask;
 		writel(val, addr);
 		dev_dbg(&pdev->dev,

