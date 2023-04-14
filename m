Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25A5C77B73
	for <linux-cxl@archiver.kernel.org>; Fri, 14 Apr 2023 18:54:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjDNSyX (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 14 Apr 2023 14:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjDNSyX (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 14 Apr 2023 14:54:23 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF87AF35
        for <linux-cxl@vger.kernel.org>; Fri, 14 Apr 2023 11:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681498457; x=1713034457;
  h=subject:from:to:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=nZhSAffzSCP9/c2+9QO3fRLWfPDgKc4G8cLMX8DgQYE=;
  b=n+GRy4MfZuOtpkLMj0BKIUDG+B9YmZ5Ho2qt9l/bmZ0KnaKwfr6Hd/pC
   28f1iSZmiAGsPYKhRd7nqf4GCPRAphDVphefMWJN8q2lWxiCQdIPBwN1m
   tbk5y+TFbvD28isrWyxOeHPXHhID2iWhW7HHn8TSFJBvKsgErHYzsgWfR
   HxoCyK/lWa8JF0wDWodWKrbp1lSadeMlbxQmiKNFfyV5ZJLDPINKWNyNr
   2POBwaVgD8Yt3LarpRQyK7Pgi9Gt14YYJw6uuXfsykKzuxWVLY5/fxQW5
   lYAbmgyiHltUgK6numX7px4IEdDpffhc/qzz46koPJoaIlDMSfDF1iHAR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="347270305"
X-IronPort-AV: E=Sophos;i="5.99,197,1677571200"; 
   d="scan'208";a="347270305"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 11:54:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="683437767"
X-IronPort-AV: E=Sophos;i="5.99,197,1677571200"; 
   d="scan'208";a="683437767"
Received: from rkulesho-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.41.243])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 11:54:16 -0700
Subject: [PATCH 5/5] cxl/hdm: Add more HDM decoder debug messages at startup
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Date:   Fri, 14 Apr 2023 11:54:16 -0700
Message-ID: <168149845668.792294.11814353796371419167.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <168149842935.792294.13212627946146993066.stgit@dwillia2-xfh.jf.intel.com>
References: <168149842935.792294.13212627946146993066.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

A recent debug session yielded a couple debug messages that were useful
for determining the reason why the driver was or was not falling back
to CXL range register emulation, and for identifying decoder setting
enumeration problems.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/hdm.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index abe3877cfa63..7889ff203a34 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -130,6 +130,14 @@ static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
 	 */
 	for (i = 0; i < cxlhdm->decoder_count; i++) {
 		ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(i));
+		dev_dbg(&info->port->dev,
+			"decoder%d.%d: committed: %ld base: %#x_%.8x size: %#x_%.8x\n",
+			info->port->id, i,
+			FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl),
+			readl(hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(i)),
+			readl(hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(i)),
+			readl(hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(i)),
+			readl(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(i)));
 		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl))
 			return false;
 	}
@@ -868,6 +876,10 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 	if (rc)
 		return rc;
 
+	dev_dbg(&port->dev, "decoder%d.%d: range: %#llx-%#llx iw: %d ig: %d\n",
+		port->id, cxld->id, cxld->hpa_range.start, cxld->hpa_range.end,
+		cxld->interleave_ways, cxld->interleave_granularity);
+
 	if (!info) {
 		lo = readl(hdm + CXL_HDM_DECODER0_TL_LOW(which));
 		hi = readl(hdm + CXL_HDM_DECODER0_TL_HIGH(which));

