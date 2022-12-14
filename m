Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C5BC4332F
	for <linux-cxl@archiver.kernel.org>; Wed, 14 Dec 2022 00:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237796AbiLNAiW (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 13 Dec 2022 19:38:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237991AbiLNAiA (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 13 Dec 2022 19:38:00 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5394A264B2
        for <linux-cxl@vger.kernel.org>; Tue, 13 Dec 2022 16:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670978111; x=1702514111;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=1xuOfqweshP0ycJZMrJBaoNwtn5tIBCn5UAUVEELhn4=;
  b=ntE15OZCRRMyow+AK9OEQcjObKiDOgUpaZ/KhE0ZCE3vcfuh/6fUpHDM
   ctRtlBFVd2ffApq30tcxZYCmkmwkrY+7SnGmOPo+7MS5/0UeYyiCiWHXW
   0L110PLKS1YuhBZigYUcemfoB99tN06OVB4okTpo18RRbUXLz6JKDcH7O
   VYFXNJk3n6MLs351h4PoHEGh7CBmQAZv8Gyai03EK3/PEOZVn0uSwOL2C
   0YoKuoWcIsKNlBbQQ4SjjfZ2/BRGIiguLtpmPg54zmoJHLliQAAeAtbvc
   dAKrjSStC1o6RW6MK83s7QdPg+Sl0kDDVR+gYElcHx3rHOaE9rpRUsA6p
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="298621982"
X-IronPort-AV: E=Sophos;i="5.96,242,1665471600"; 
   d="scan'208";a="298621982"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 16:34:56 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="681341620"
X-IronPort-AV: E=Sophos;i="5.96,242,1665471600"; 
   d="scan'208";a="681341620"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.209.105.179])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 16:34:55 -0800
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Tue, 13 Dec 2022 16:34:52 -0800
Subject: [PATCH] hw/cxl/device: Add Flex Bus Port DVSEC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221213-ira-flexbus-port-v1-1-86afd4f30be6@intel.com>
X-B4-Tracking: v=1; b=H4sIACwamWMC/x2NSwrCUAwAr1KyNmAiingVcfE+qQ08XktipVB6d
 4PLGRhmBxdTcXgMO5h81XXuAXQaoEypvwW1BgOfmYnpgmoJxyZbXh2X2T5Y5Mq3KnciqhBZTi6Y
 LfUyRdjX1kIuJqNu/8/zdRw/DRAiQncAAAA=
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Dave Jiang <dave.jiang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ben Widawsky <bwidawsk@kernel.org>, qemu-devel@nongnu.org,
        linux-cxl@vger.kernel.org
X-Mailer: b4 0.11.0-dev-141d4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1670978094; l=1847;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=1xuOfqweshP0ycJZMrJBaoNwtn5tIBCn5UAUVEELhn4=;
 b=/yW7hsV8Rrx7qOHpbWHWXJSZXyVPBJSPJlcu/GTQO4jlwdlHi1Xg8OP7sjmP6Uk2amraw62UV146
 iuB1M73LDFCDPqyXBlLRTpppv9mBAysw07QbL+QInnTYmxw7eE5K
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
 hw/mem/cxl_type3.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 0317bd96a6fb..27f6ac0cb3c1 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -416,6 +416,17 @@ static void build_dvsecs(CXLType3Dev *ct3d)
     cxl_component_create_dvsec(cxl_cstate, CXL2_TYPE3_DEVICE,
                                GPF_DEVICE_DVSEC_LENGTH, GPF_DEVICE_DVSEC,
                                GPF_DEVICE_DVSEC_REVID, dvsec);
+
+    dvsec = (uint8_t *)&(CXLDVSECPortFlexBus){
+        .cap                     = 0x27, /* Cache, IO, Mem, non-MLD */
+        .ctrl                    = 0x02, /* IO always enabled */
+        .status                  = 0x27, /* same as capabilities */
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
