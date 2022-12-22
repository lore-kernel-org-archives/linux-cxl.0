Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11AF9C4332F
	for <linux-cxl@archiver.kernel.org>; Thu, 22 Dec 2022 04:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbiLVEZW (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 21 Dec 2022 23:25:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234634AbiLVEY7 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 21 Dec 2022 23:24:59 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E75DB6
        for <linux-cxl@vger.kernel.org>; Wed, 21 Dec 2022 20:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671683098; x=1703219098;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Ka/aRsnXmQ7dCrsF+L+URsGC7uaO2uU2ffcMYWdbxuQ=;
  b=m5Ip5fScnetn9rLcrF0eLBF+4sF0swipIkTr/riinsXkoYWSf/yMXirt
   PgzyZUT4Z9P5t0AHV2I4OCC5nnGam0jgjxAquA2sl72bD3q2q1y0GiYBa
   I6XXeJCg01VXXBoncCecOSdl4WTtnvZtcy2MhZ8patJiSdNcJhlWKR40K
   Ye1D+7TXFPB2lVW+5xEOpNGPFhaax7WyzaMa6g/Qq8Qjsb4C06Tnc8a5I
   HjPRHd73j/aQG2ckPJiFfRc71BOZ1j1D7vS3Jk10Nn+6D/Pk/8K/G2x0R
   rlhywGQfD2WxZJf6873mni2rubKDt+VChpQ3aM3JHwIL6SNYNfzOiXfL3
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="321957597"
X-IronPort-AV: E=Sophos;i="5.96,264,1665471600"; 
   d="scan'208";a="321957597"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2022 20:24:57 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="601733196"
X-IronPort-AV: E=Sophos;i="5.96,264,1665471600"; 
   d="scan'208";a="601733196"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.212.20.211])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2022 20:24:56 -0800
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Wed, 21 Dec 2022 20:24:33 -0800
Subject: [PATCH v2 3/8] hw/cxl/mailbox: Use new UUID network order define for cel_uuid
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221221-ira-cxl-events-2022-11-17-v2-3-2ce2ecc06219@intel.com>
References: <20221221-ira-cxl-events-2022-11-17-v2-0-2ce2ecc06219@intel.com>
In-Reply-To: <20221221-ira-cxl-events-2022-11-17-v2-0-2ce2ecc06219@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>, qemu-devel@nongnu.org,
        linux-cxl@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>
X-Mailer: b4 0.11.0-dev-141d4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1671683093; l=3634;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=Ka/aRsnXmQ7dCrsF+L+URsGC7uaO2uU2ffcMYWdbxuQ=;
 b=v1sW8DWicc1820I2mSk+v4TqYL/w1ukeAaC82Yk4A/sCJ5D+6nLJ8soRE7vvHqoOGJxFbOOBgxcz
 HURse14cB7EXA1zKfqFrZ3LYtd3FkW95yreN/fMG4XcVYlUCFPtB
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The cel_uuid was programatically generated previously because there was
no static initializer for network order UUIDs.

Use the new network order initializer for cel_uuid.  Adjust
cxl_initialize_mailbox() because it can't fail now.

Update specification reference.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from RFC:
	New patch.
---
 hw/cxl/cxl-device-utils.c   |  4 ++--
 hw/cxl/cxl-mailbox-utils.c  | 14 +++++++-------
 include/hw/cxl/cxl_device.h |  2 +-
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
index 21845dbfd050..34697064714e 100644
--- a/hw/cxl/cxl-device-utils.c
+++ b/hw/cxl/cxl-device-utils.c
@@ -267,7 +267,7 @@ void cxl_device_register_init_common(CXLDeviceState *cxl_dstate)
     cxl_device_cap_init(cxl_dstate, MEMORY_DEVICE, 0x4000);
     memdev_reg_init_common(cxl_dstate);
 
-    assert(cxl_initialize_mailbox(cxl_dstate, false) == 0);
+    cxl_initialize_mailbox(cxl_dstate, false);
 }
 
 void cxl_device_register_init_swcci(CXLDeviceState *cxl_dstate)
@@ -289,5 +289,5 @@ void cxl_device_register_init_swcci(CXLDeviceState *cxl_dstate)
     cxl_device_cap_init(cxl_dstate, MEMORY_DEVICE, 0x4000);
     memdev_reg_init_common(cxl_dstate);
 
-    assert(cxl_initialize_mailbox(cxl_dstate, true) == 0);
+    cxl_initialize_mailbox(cxl_dstate, true);
 }
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index c1183614b9a4..157c01255ee3 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -321,7 +321,11 @@ static ret_code cmd_timestamp_set(struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
-static QemuUUID cel_uuid;
+/* CXL 3.0 8.2.9.5.2.1 Command Effects Log (CEL) */
+static QemuUUID cel_uuid = {
+        .data = UUID(0x0da9c0b5, 0xbf41, 0x4b78, 0x8f, 0x79,
+                     0x96, 0xb1, 0x62, 0x3b, 0x3f, 0x17)
+};
 
 /* 8.2.9.4.1 */
 static ret_code cmd_logs_get_supported(struct cxl_cmd *cmd,
@@ -684,16 +688,14 @@ void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
                      DOORBELL, 0);
 }
 
-int cxl_initialize_mailbox(CXLDeviceState *cxl_dstate, bool switch_cci)
+void cxl_initialize_mailbox(CXLDeviceState *cxl_dstate, bool switch_cci)
 {
-    /* CXL 2.0: Table 169 Get Supported Logs Log Entry */
-    const char *cel_uuidstr = "0da9c0b5-bf41-4b78-8f79-96b1623b3f17";
-
     if (!switch_cci) {
         cxl_dstate->cxl_cmd_set = cxl_cmd_set;
     } else {
         cxl_dstate->cxl_cmd_set = cxl_cmd_set_sw;
     }
+
     for (int set = 0; set < 256; set++) {
         for (int cmd = 0; cmd < 256; cmd++) {
             if (cxl_dstate->cxl_cmd_set[set][cmd].handler) {
@@ -707,6 +709,4 @@ int cxl_initialize_mailbox(CXLDeviceState *cxl_dstate, bool switch_cci)
             }
         }
     }
-
-    return qemu_uuid_parse(cel_uuidstr, &cel_uuid);
 }
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 1b366b739c62..3be2e37b3e4c 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -238,7 +238,7 @@ CXL_DEVICE_CAPABILITY_HEADER_REGISTER(MEMORY_DEVICE,
                                       CXL_DEVICE_CAP_HDR1_OFFSET +
                                           CXL_DEVICE_CAP_REG_SIZE * 2)
 
-int cxl_initialize_mailbox(CXLDeviceState *cxl_dstate, bool switch_cci);
+void cxl_initialize_mailbox(CXLDeviceState *cxl_dstate, bool switch_cci);
 void cxl_process_mailbox(CXLDeviceState *cxl_dstate);
 
 #define cxl_device_cap_init(dstate, reg, cap_id)                           \

-- 
2.38.1
