Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 388DBC77B7F
	for <linux-cxl@archiver.kernel.org>; Thu, 18 May 2023 02:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjERCqS (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 17 May 2023 22:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjERCqN (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 17 May 2023 22:46:13 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64AEA40DF
        for <linux-cxl@vger.kernel.org>; Wed, 17 May 2023 19:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684377967; x=1715913967;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=46y0FaBxziwuSbTAR4YOkMaktxaMBddzA2VrCi6VZS8=;
  b=ShLqbcxbur7kcUeKoCv/HTZsvnKM9QtqpNbScZAUJxp9+vZpZtvNtsOD
   vZlsVXeUUmSZZTvtTv2KZB1iImgWuiSa8kDxnDqMuBXRJYAhGbsFUHkt/
   Ur1JBaqkoter3x1MQW28FGu2gVaOF4QvBawRprF7FKRHVK7k6/0Der+h2
   iTosZCJ7fuoJAFIzmqMdohsMw3t7KM8Y1QuaZVM2uRhkN0tls9xLlyFlB
   CnFdobVobK/u0c6S/hmhI2KmsCq0A4VkzjUmHFvrQ0iIp5NLHJrUAlsqU
   2GmzXGnDIo3Z5sIObABsZf5NsNpBVV8gULhlA4f7x+fph/x/yeqzktW1E
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="380147111"
X-IronPort-AV: E=Sophos;i="5.99,284,1677571200"; 
   d="scan'208";a="380147111"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 19:46:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="652466741"
X-IronPort-AV: E=Sophos;i="5.99,284,1677571200"; 
   d="scan'208";a="652466741"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.209.143.168])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 19:46:05 -0700
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Wed, 17 May 2023 19:45:57 -0700
Subject: [PATCH RFC 4/5] hw/cxl/accel: Add Back-Invalidate decoder
 capbility structure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230517-rfc-type2-dev-v1-4-6eb2e470981b@intel.com>
References: <20230517-rfc-type2-dev-v1-0-6eb2e470981b@intel.com>
In-Reply-To: <20230517-rfc-type2-dev-v1-0-6eb2e470981b@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
        Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
X-Mailer: b4 0.13-dev-9a8cd
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684377956; l=3758;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=46y0FaBxziwuSbTAR4YOkMaktxaMBddzA2VrCi6VZS8=;
 b=Tkagk9parcBDGYn7JPISiNLaEp7zYK69R4NQPXePCpSdSOpb2z/s+4AHvAKQ/quxnhs3APqae
 lCSEEGALSI9D2QWgJyqJl/rTjUs087YuKIgDiLdsbb2DJ8AVIAj1DyX
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The presence of the Back-Invalidate (BI) decoder capability structure
indicates a CXL downstream port, root port, or device supports the BI
messages.

Add the BI capability structure to the accelerator device.

Not-Yet-Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 hw/cxl/cxl-component-utils.c   |  5 +++++
 hw/mem/cxl_type3.c             | 11 +++++++++++
 include/hw/cxl/cxl_component.h | 11 +++++++++--
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index 7949d12b7351..a9efa252b4ae 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -228,6 +228,7 @@ void cxl_component_register_init_common(uint32_t *reg_state, uint32_t *write_msk
         init_cap_reg(EXTSEC, 6, 1);
         init_cap_reg(SNOOP, 8, 1);
         /* FALL THROUGH */
+    case CXL3_TYPE2_DEVICE:
     case CXL2_UPSTREAM_PORT:
     case CXL2_TYPE3_DEVICE:
     case CXL2_LOGICAL_DEVICE:
@@ -246,6 +247,10 @@ void cxl_component_register_init_common(uint32_t *reg_state, uint32_t *write_msk
         abort();
     }
 
+    if (type == CXL3_TYPE2_DEVICE) {
+        init_cap_reg(BI_DECODER, 12, 1);
+    }
+
     ARRAY_FIELD_DP32(reg_state, CXL_CAPABILITY_HEADER, ARRAY_SIZE, caps);
 #undef init_cap_reg
 }
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index c7eafd76d1ea..95fdaaa18f37 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1692,6 +1692,16 @@ static void ct3d_registers(void)
 
 type_init(ct3d_registers);
 
+static void accel_reset(DeviceState *dev)
+{
+    CXLAccelDev *acceld = CXL_ACCEL(dev);
+    uint32_t *reg_state = acceld->parent_obj.cxl_cstate.crb.cache_mem_registers;
+    uint32_t *write_msk = acceld->parent_obj.cxl_cstate.crb.cache_mem_regs_write_mask;
+
+    cxl_component_register_init_common(reg_state, write_msk, CXL3_TYPE2_DEVICE);
+    cxl_device_register_init_common(&acceld->parent_obj.cxl_dstate);
+}
+
 static void cxl_accel_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
@@ -1703,6 +1713,7 @@ static void cxl_accel_class_init(ObjectClass *oc, void *data)
     pc->revision = 1;
 
     dc->desc = "CXL Accelerator Device (Type 2)";
+    dc->reset = accel_reset;
 }
 
 static const TypeInfo cxl_accel_dev_info = {
diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
index 7c08c02c5e9d..a5b5512aed94 100644
--- a/include/hw/cxl/cxl_component.h
+++ b/include/hw/cxl/cxl_component.h
@@ -28,6 +28,7 @@ enum reg_type {
     CXL2_UPSTREAM_PORT,
     CXL2_DOWNSTREAM_PORT,
     CXL3_SWITCH_MAILBOX_CCI,
+    CXL3_TYPE2_DEVICE,
 };
 
 /*
@@ -66,6 +67,7 @@ CXLx_CAPABILITY_HEADER(LINK, 2)
 CXLx_CAPABILITY_HEADER(HDM, 3)
 CXLx_CAPABILITY_HEADER(EXTSEC, 4)
 CXLx_CAPABILITY_HEADER(SNOOP, 5)
+CXLx_CAPABILITY_HEADER(BI_DECODER, 6)
 
 /*
  * Capability structures contain the actual registers that the CXL component
@@ -185,9 +187,14 @@ HDM_DECODER_INIT(3);
     (CXL_IDE_REGISTERS_OFFSET + CXL_IDE_REGISTERS_SIZE)
 #define CXL_SNOOP_REGISTERS_SIZE   0x8
 
+/* CXL 3.0 8.2.4.26 - CXL BI Decoder Capability Structure */
+#define CXL_BI_DECODER_REGISTERS_OFFSET \
+    (CXL_SNOOP_REGISTERS_OFFSET + CXL_SNOOP_REGISTERS_SIZE)
+#define CXL_BI_DECODER_REGISTERS_SIZE   0xC
+
 /* CXL 3.0 8.2.3 Table 8-21 */
-QEMU_BUILD_BUG_MSG((CXL_SNOOP_REGISTERS_OFFSET +
-                    CXL_SNOOP_REGISTERS_SIZE) >= CXL2_COMPONENT_CM_REGION_SIZE,
+QEMU_BUILD_BUG_MSG((CXL_BI_DECODER_REGISTERS_OFFSET +
+                    CXL_BI_DECODER_REGISTERS_SIZE) >= CXL2_COMPONENT_CM_REGION_SIZE,
                    "No space for registers");
 
 typedef struct component_registers {

-- 
2.40.0

