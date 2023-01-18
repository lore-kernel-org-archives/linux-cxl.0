Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5CAC38159
	for <linux-cxl@archiver.kernel.org>; Wed, 18 Jan 2023 18:10:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjARSKM (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 18 Jan 2023 13:10:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjARSJm (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 18 Jan 2023 13:09:42 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79EBE5B5A0
        for <linux-cxl@vger.kernel.org>; Wed, 18 Jan 2023 10:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674065355; x=1705601355;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f5We0gxzI+ZoQsfM01B4W0v0AfqH/ogFtztSXpExvRA=;
  b=UtnWlzuJuRdNiVy1jHgyQRnfG8lOlnAlIGhDtxCkdQwWb+fmqHYKe+dI
   uY1MMNFZHEn6uO+8woUtChT/jokQevLZp10f8Ttp7/If6xzY4dVlfRmc4
   zXppEyUHRu1DKX5gLbrOVO7WIpL42BhMcBprKUhKPTwEDGGZpOGOgKhMQ
   vuLqw3BNJ9EHEBnjxSG9CbHPibPiDdJLb5sNzorq51J2fk9/BXSa/Y7/6
   kEDRuj5ZkMQhuaDgejoLphKnD+pp3EL6wIwrWpu0ZQWailcnHwtfQhjJP
   ISS2dMj7/Q7WD608R+Vv8PFfvzpC0lvGA/bRYK/2/WX8tXbqgTh/+ozEP
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="387406192"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="387406192"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 10:09:15 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="905195471"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="905195471"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO djiang5-mobl3.local) ([10.213.179.103])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 10:09:14 -0800
Subject: [PATCH v3 6/8] cxl: create emulated decoders for devices without HDM
 decoders
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        jonathan.cameron@huawei.com
Date:   Wed, 18 Jan 2023 11:09:12 -0700
Message-ID: <167406535137.1455071.12470540886828540377.stgit@djiang5-mobl3.local>
In-Reply-To: <167406522720.1455071.8837344641950166822.stgit@djiang5-mobl3.local>
References: <167406522720.1455071.8837344641950166822.stgit@djiang5-mobl3.local>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

CXL rev3.0 spec 8.1.3

RCDs may not have HDM register blocks. Create fake decoders based on CXL
PCIe DVSEC registers. The DVSEC Range Registers provide the memory range
for these decoder structs. For the RCD, there can be up to 2 decoders
depending on the DVSEC Capability register HDM_count.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---
v3:
- Drop unrelated bits from patch. (Jonathan)
---
 drivers/cxl/core/hdm.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 86fe1be2e961..cbec955db4c9 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -748,6 +748,13 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 	if (is_endpoint_decoder(&cxld->dev))
 		cxled = to_cxl_endpoint_decoder(&cxld->dev);
 
+	if (!hdm) {
+		if (!cxled)
+			return -EINVAL;
+
+		return cxl_setup_hdm_decoder_from_dvsec(port, cxld, which, info);
+	}
+
 	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(which));
 	base = ioread64_hi_lo(hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(which));
 	size = ioread64_hi_lo(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(which));


