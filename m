Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F19C636D7
	for <linux-cxl@archiver.kernel.org>; Wed, 22 Feb 2023 01:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjBVBvd (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 21 Feb 2023 20:51:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjBVBvc (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 21 Feb 2023 20:51:32 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2129232E6B
        for <linux-cxl@vger.kernel.org>; Tue, 21 Feb 2023 17:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677030680; x=1708566680;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=14YqTa0U8+c+3LccPxripPxep20sWrhwibkZ53hbTO4=;
  b=llAchxKryPoYYomPZQE+X8JhLZx+SrnNrRALy5kXI8YGMK7GJ60qawB1
   jmS099RU9Ax5/25BjvRvyFXqMV2t6pTgW4sgnUu6jofpSRwl+uF9OS32Y
   EABpJV/ulm7JfTEWF05Elr0oyNB2vCACnMXhg7Vvx8mOQ1vLQ8IZVmRyF
   bVS1MtygJFHFp/wgYTjNGzSBhDnnmH2vCRLgFbQEZhvO9q7/hyDAmN3cP
   +FG/1GpBcYj0bcDFq0c2lzPQ2bVFXUlA8LUx9v7524hokQ3DW8QZaYct+
   v6nzDSyS308Yx3N3e9/xQvHlduqHlRbG9nRCa8DBgcP/8Gnap02ZFMzkq
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="360287997"
X-IronPort-AV: E=Sophos;i="5.97,317,1669104000"; 
   d="scan'208";a="360287997"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 17:51:19 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="621737201"
X-IronPort-AV: E=Sophos;i="5.97,317,1669104000"; 
   d="scan'208";a="621737201"
Received: from pjois-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.101.5])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 17:51:19 -0800
Subject: [PATCH 1/2] cxl/hdm: Fix double allocation of @cxlhdm
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dave.jiang@intel.com
Date:   Tue, 21 Feb 2023 17:51:19 -0800
Message-ID: <167703067936.185722.7908921750127154779.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <167703067373.185722.16579529992799939220.stgit@dwillia2-xfh.jf.intel.com>
References: <167703067373.185722.16579529992799939220.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

devm_cxl_setup_emulated_hdm() reallocates an instance of @cxlhdm that
was already allocated at the start of devm_cxl_setup_hdm(). Only one is
needed and devm_cxl_setup_emulated_hdm() does not do enough to warrant
being an explicit helper.

Fixes: 4474ce565ee4 ("cxl/hdm: Create emulated cxl_hdm for devices that do not have HDM decoders")
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/hdm.c |   34 ++++++----------------------------
 1 file changed, 6 insertions(+), 28 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 45deda18ed32..520814130928 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -101,27 +101,6 @@ static int map_hdm_decoder_regs(struct cxl_port *port, void __iomem *crb,
 				      BIT(CXL_CM_CAP_CAP_ID_HDM));
 }
 
-static struct cxl_hdm *devm_cxl_setup_emulated_hdm(struct cxl_port *port,
-						   struct cxl_endpoint_dvsec_info *info)
-{
-	struct device *dev = &port->dev;
-	struct cxl_hdm *cxlhdm;
-
-	if (!info->mem_enabled)
-		return ERR_PTR(-ENODEV);
-
-	cxlhdm = devm_kzalloc(dev, sizeof(*cxlhdm), GFP_KERNEL);
-	if (!cxlhdm)
-		return ERR_PTR(-ENOMEM);
-
-	cxlhdm->port = port;
-	cxlhdm->decoder_count = info->ranges;
-	cxlhdm->target_count = info->ranges;
-	dev_set_drvdata(&port->dev, cxlhdm);
-
-	return cxlhdm;
-}
-
 /**
  * devm_cxl_setup_hdm - map HDM decoder component registers
  * @port: cxl_port to map
@@ -138,13 +117,14 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
 	cxlhdm = devm_kzalloc(dev, sizeof(*cxlhdm), GFP_KERNEL);
 	if (!cxlhdm)
 		return ERR_PTR(-ENOMEM);
-
 	cxlhdm->port = port;
-	crb = ioremap(port->component_reg_phys, CXL_COMPONENT_REG_BLOCK_SIZE);
-	if (!crb) {
-		if (info && info->mem_enabled)
-			return devm_cxl_setup_emulated_hdm(port, info);
+	dev_set_drvdata(dev, cxlhdm);
 
+	crb = ioremap(port->component_reg_phys, CXL_COMPONENT_REG_BLOCK_SIZE);
+	if (!crb && info && info->mem_enabled) {
+		cxlhdm->decoder_count = info->ranges;
+		cxlhdm->target_count = info->ranges;
+	} else if (!crb) {
 		dev_err(dev, "No component registers mapped\n");
 		return ERR_PTR(-ENXIO);
 	}
@@ -160,8 +140,6 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
 		return ERR_PTR(-ENXIO);
 	}
 
-	dev_set_drvdata(dev, cxlhdm);
-
 	return cxlhdm;
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_setup_hdm, CXL);

