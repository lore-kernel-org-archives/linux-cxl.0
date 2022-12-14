Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 642D8C4332F
	for <linux-cxl@archiver.kernel.org>; Wed, 14 Dec 2022 20:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbiLNUyU (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 14 Dec 2022 15:54:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiLNUyT (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 14 Dec 2022 15:54:19 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADF62C65C
        for <linux-cxl@vger.kernel.org>; Wed, 14 Dec 2022 12:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671051259; x=1702587259;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=mjGK07+sSzfJoPQKszWPOFrvFHEnWxC/xVIdOYLYUWA=;
  b=C3awA0nWzRlPkQSFi/OfVGkwa0kOsX1O2QChrZYJ6VgCOutwOwXPFm6S
   FG/6DipTaQTmRn7MrQk279jf/f1TdbL1WEsNdG4ZNDA1BvZrFQlRFPUAv
   KKiWaH+c8vXWZrTAoycahM6tHkLFukp3TsQVoOkj5ww3wk7DMde9p17N4
   RjpSPYxa30zNzjs4Be60G1fIFIxw+GtW2zdHfWMLQWLTulpbd0TtUSq7+
   aLBqVWgUqdpRukLIPHD/daODDdx8oR2M3IcbnaOaH/wTR43iV6N+T4Wua
   XXiVW4BRdMcUuUkjQziDf8J+/aWI/UUk0rJAo/ftjTNIXnfhaxyWzPuFZ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="317220248"
X-IronPort-AV: E=Sophos;i="5.96,245,1665471600"; 
   d="scan'208";a="317220248"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2022 12:54:18 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="773463121"
X-IronPort-AV: E=Sophos;i="5.96,245,1665471600"; 
   d="scan'208";a="773463121"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.209.87.120])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2022 12:54:18 -0800
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Wed, 14 Dec 2022 12:54:11 -0800
Subject: [PATCH v2] hw/cxl/device: Add Flex Bus Port DVSEC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221213-ira-flexbus-port-v2-1-eaa48d0e0700@intel.com>
X-B4-Tracking: v=1; b=H4sIAPM3mmMC/32NSwqDMBQAryJZ9xVfbEW66j3ERT4v9UGaSKJiE
 e/e1AN0OQPD7CJTYsriUe0i0cqZYyggL5UwowovAraFhaylRIkNcFLgPG16yTDFNIOhu2wtdYho
 Rcm0ygQ6qWDGEobF+yKnRI6389MPhUfOc0yfc7viz/45rAgIXaucvbmm1tQ+Oczkrya+xXAcxxe
 E2n+5xQAAAA==
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Dave Jiang <dave.jiang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ben Widawsky <bwidawsk@kernel.org>, qemu-devel@nongnu.org,
        linux-cxl@vger.kernel.org
X-Mailer: b4 0.11.0-dev-141d4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1671051257; l=2197;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=mjGK07+sSzfJoPQKszWPOFrvFHEnWxC/xVIdOYLYUWA=;
 b=AcgVs4IfdIYYMqd+htoRC/7UTrT67+vLPVT5C8skB4e2QPJmeBQPLycEnz5x7Hs65wcI/htaP9k8
 Osu4qCtJDbuBzYQXLn+xYDGke6Ov9DuOlYGLE7Wuc1Gh6Z6B8iM+
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The Flex Bus Port DVSEC was missing on type 3 devices which was blocking
RAS checks.[1]

Add the Flex Bus Port DVSEC to type 3 devices as per CXL 3.0 8.2.1.3.

[1] https://lore.kernel.org/linux-cxl/167096738875.2861540.11815053323626849940.stgit@djiang5-desk3.ch.intel.com/

Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Ben Widawsky <bwidawsk@kernel.org>
Cc: qemu-devel@nongnu.org
Cc: linux-cxl@vger.kernel.org
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
Changes in v2:
        Jonathan                                                            
                type 3 device does not support CACHE                        
                Comment the 68B bit                                         

- Link to v1: https://lore.kernel.org/r/20221213-ira-flexbus-port-v1-1-86afd4f30be6@intel.com
---
 hw/mem/cxl_type3.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 0317bd96a6fb..e6beac143fc1 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -416,6 +416,17 @@ static void build_dvsecs(CXLType3Dev *ct3d)
     cxl_component_create_dvsec(cxl_cstate, CXL2_TYPE3_DEVICE,
                                GPF_DEVICE_DVSEC_LENGTH, GPF_DEVICE_DVSEC,
                                GPF_DEVICE_DVSEC_REVID, dvsec);
+
+    dvsec = (uint8_t *)&(CXLDVSECPortFlexBus){
+        .cap                     = 0x26, /* 68B, IO, Mem, non-MLD */
+        .ctrl                    = 0x02, /* IO always enabled */
+        .status                  = 0x26, /* same as capabilities */
+        .rcvd_mod_ts_data_phase1 = 0xef, /* WTF? */
+    };
+    cxl_component_create_dvsec(cxl_cstate, CXL2_TYPE3_DEVICE,
+                               PCIE_FLEXBUS_PORT_DVSEC_LENGTH_2_0,
+                               PCIE_FLEXBUS_PORT_DVSEC,
+                               PCIE_FLEXBUS_PORT_DVSEC_REVID_2_0, dvsec);
 }
 
 static void hdm_decoder_commit(CXLType3Dev *ct3d, int which)

---
base-commit: e11b57108b0cb746bb9f3887054f34a2f818ed79
change-id: 20221213-ira-flexbus-port-ce526de8111d

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>
