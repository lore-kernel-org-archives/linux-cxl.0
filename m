Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81EDEC25B0E
	for <linux-cxl@archiver.kernel.org>; Tue, 16 Aug 2022 18:16:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236243AbiHPSQB (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 16 Aug 2022 14:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236658AbiHPSP7 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 16 Aug 2022 14:15:59 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3000F83BE9
        for <linux-cxl@vger.kernel.org>; Tue, 16 Aug 2022 11:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660673757; x=1692209757;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HprWPGLeEfrDn4uyJ3dwLOW4H/r0/YURaEKH0ygYtv4=;
  b=Qy6SnjHZZLN25cuTaJikzzbiFbRU1D1/DMABWCSdzVLHu8dAGDMs3L0S
   SDTJnMGsULqzJBzu3N4wC5vPsN21WBYyVGf0ZgkhJr+49Eh7Rb5SkVmQ5
   ErZjqv5OzpIOgYfXr+eLLSvy3fxzrqe2xjf3tEiPh06U++2dGJCTylSQM
   twEfXeu1RAR4QZIwUOFWhRgDLFJ8DpqRfzG8ufD3KgDCksEbsmDPWJM1c
   phYc8iUailhrJb7WD8fWst1OkmieC5+N62K/PLoaQBV096j9UPD/sDZs7
   ICo78XfaFG2u1HAZi2bVdd0Xr0FO69EOe/EbAfh8AGaV3gv7fJYg5lD2i
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="275348219"
X-IronPort-AV: E=Sophos;i="5.93,241,1654585200"; 
   d="scan'208";a="275348219"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 11:15:56 -0700
X-IronPort-AV: E=Sophos;i="5.93,241,1654585200"; 
   d="scan'208";a="607139047"
Received: from djiang5-desk4.jf.intel.com ([10.165.157.96])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 11:15:56 -0700
Subject: [PATCH 2/2] cxl: export intereleave capability as port sysfs
 attribute
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, alison.schofield@intel.com
Date:   Tue, 16 Aug 2022 11:15:56 -0700
Message-ID: <166067375610.1614719.3464893539111383781.stgit@djiang5-desk4.jf.intel.com>
In-Reply-To: <62f5c76060f1f_3ce6829494@dwillia2-xfh.jf.intel.com.notmuch>
References: <62f5c76060f1f_3ce6829494@dwillia2-xfh.jf.intel.com.notmuch>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Export the interleave capability as a sysfs attribute for a port. The
exported mask is interpreted from the CXL HDM Decoder Capability Register
(CXL spec v 8.2.4.19.1). Each bit in the mask represents the number of
interleave ways the decoder supports. For example, CXL devices designed
from CXL spec v2.0 supports 1, 2, 4, and 8 interleave ways. The exported
mask would show 0x116. The exported sysfs attribute will help user region
creation to do more valid configuration checking.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/port.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index e3e93e1b663e..231cfe888918 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -135,8 +135,21 @@ static ssize_t interleave_mask_show(struct device *dev, struct device_attribute
 }
 static DEVICE_ATTR_RO(interleave_mask);
 
+static ssize_t interleave_cap_show(struct device *dev, struct device_attribute *attr,
+				   char *buf)
+{
+	struct cxl_hdm *cxlhdm = dev_get_drvdata(dev);
+
+	if (!cxlhdm)
+		return 0;
+
+	return sysfs_emit(buf, "%#lx\n", cxlhdm->interleave_cap);
+}
+static DEVICE_ATTR_RO(interleave_cap);
+
 static struct attribute *cxl_port_info_attributes[] = {
 	&dev_attr_interleave_mask.attr,
+	&dev_attr_interleave_cap.attr,
 	NULL,
 };
 


