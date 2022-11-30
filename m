Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F9CC47088
	for <linux-cxl@archiver.kernel.org>; Wed, 30 Nov 2022 23:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiK3XVB (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 30 Nov 2022 18:21:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiK3XUn (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 30 Nov 2022 18:20:43 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BAEBB0309
        for <linux-cxl@vger.kernel.org>; Wed, 30 Nov 2022 15:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669850008; x=1701386008;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3+37oeQ0PtgjSuwYZMHdr1Unz7CY6Ph996OtgGAlrBo=;
  b=Lzbj3nuonzo4K7nS/XmjytYR8ANQ3G9q7H5EVZCorTKP3Nq3Lc3zo/fd
   F+LkRINmc+EOHVu37g1cdnCMoVlSCBb96DxHtkd0RuC81vWFWSLVsCZGH
   lRr+oFAWCcaZiGVEJS8zpm6R8DajMcd1dWRd/XMPf1d6i2hYO+cfP4vh1
   FxVj0ALE2qs2yBVraswxoLSFfGdYGVjwjTgEsZSHCYgg5GQ8Vu9JfAaS3
   2ij+cOCSPrjkpdXBV0xlzk6tmIAvPTRfuCPNYPy5T6PV+W9KFQrILBxVt
   StKEaxRe0JqYXbZ06dvTstCm323Qgf2FLRBhQgjLsO5TihU1IIpfEJd3I
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="379812083"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="379812083"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 15:12:56 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="733171128"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="733171128"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 15:12:55 -0800
Subject: [RFC PATCH 7/8] cxl: suppress component register discovery failure
 warning for RCD
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com, rrichter@amd.com, terry.bowman@amd.com
Date:   Wed, 30 Nov 2022 16:12:55 -0700
Message-ID: <166984997536.2805382.16376618769262720267.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166984987659.2805382.17264896576424996856.stgit@djiang5-desk3.ch.intel.com>
References: <166984987659.2805382.17264896576424996856.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

For an RCD, it is expected that component register won't be discovered by
cxl_pci. Suppress warning if RCD.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/pci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 73ff6c33a0c0..d808da838909 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -486,7 +486,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	 */
 	cxlds->component_reg_phys = CXL_RESOURCE_NONE;
 	rc = cxl_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
-	if (rc)
+	if (rc && !cxlds->rcd)
 		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
 
 	cxlds->component_reg_phys = cxl_regmap_to_base(pdev, &map);


