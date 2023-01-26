Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2835FC61DA3
	for <linux-cxl@archiver.kernel.org>; Thu, 26 Jan 2023 18:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbjAZSIM (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 26 Jan 2023 13:08:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjAZSIL (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 26 Jan 2023 13:08:11 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C928521FC
        for <linux-cxl@vger.kernel.org>; Thu, 26 Jan 2023 10:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674756490; x=1706292490;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=l1I6/T4zyQnPJZVoVcaHZ2pJED6Bo2HR8YzE059/uqQ=;
  b=mCNZk3UVb1RBzRkojKo6j3QanmHVeToXn9hCpRFSxC9oRp/g3VlZvZ/f
   3Qqjeht1ixJlwVaIsT5jaDkDta5k8bCHEuRjiaERbZ8xWgpVY9d/N6ttU
   A+uzc/e9nOYsxRuDcIBuZAY25+/s+pe7DiPhwWIsTeWcd+ZSkyhUs/ilN
   SV0ap53GLPJehf2FlwujtpCDJHfkYA5eHU1+U8Td6YaPvtbKSqAGOoXuG
   0PFmDu0hX2jY3G5rIJ/1DQ5hFgn7fqR7m9+xNbnhL63ciUkAPSKD8ZRKP
   HK9Rny/3DffNQaq+iVDF0kEsofVfdfl2zAzd+8rU9ThGGI3bf9yIrED93
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="328157204"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="328157204"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 10:07:40 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="640405916"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="640405916"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO djiang5-mobl3.local) ([10.212.112.115])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 10:07:39 -0800
Subject: [PATCH] hw/cxl: Add QTG _DSM support for ACPI0017 device
From:   Dave Jiang <dave.jiang@intel.com>
To:     Jonathan.Cameron@huawei.com
Cc:     mst@redhat.com, bwidawsk@kernel.org, peter.maydell@linaro.org,
        qemu-devel@nongnu.org, linux-cxl@vger.kernel.org
Date:   Thu, 26 Jan 2023 11:07:37 -0700
Message-ID: <167475645654.1386523.7101990863993668595.stgit@djiang5-mobl3.local>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Add a simple _DSM call support for the ACPI0017 device to return a fake QTG
ID value. Given the current CXL implementation does not involve switches,
a faked value of 0 can be returned for the QTG ID. The enabling is for _DSM
plumbing testing from the OS.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 hw/acpi/cxl.c         |   57 +++++++++++++++++++++++++++++++++++++++++++++++++
 hw/i386/acpi-build.c  |    1 +
 include/hw/acpi/cxl.h |    1 +
 3 files changed, 59 insertions(+)

diff --git a/hw/acpi/cxl.c b/hw/acpi/cxl.c
index 2bf8c0799359..cd6839c24416 100644
--- a/hw/acpi/cxl.c
+++ b/hw/acpi/cxl.c
@@ -30,6 +30,63 @@
 #include "qapi/error.h"
 #include "qemu/uuid.h"
 
+void build_cxl_dsm_method(Aml *dev)
+{
+    Aml *method, *ifctx, *ifctx2;
+
+    method = aml_method("_DSM", 4, AML_SERIALIZED);
+    {
+        Aml *function, *uuid;
+
+        uuid = aml_arg(0);
+        function = aml_arg(2);
+        /* CXL spec v3.0 9.17.3.1 *, QTG ID _DSM */
+        ifctx = aml_if(aml_equal(
+            uuid, aml_touuid("F365F9A6-A7DE-4071-A66A-B40C0B4F8E52")));
+
+        /* Function 0, standard DSM query function */
+        ifctx2 = aml_if(aml_equal(function, aml_int(0)));
+        {
+            uint8_t byte_list[1] = { 0x01 }; /* functions 1 only */
+
+            aml_append(ifctx2,
+                       aml_return(aml_buffer(sizeof(byte_list), byte_list)));
+        }
+        aml_append(ifctx, ifctx2);
+
+        /*
+         * Function 1
+         * A return value of {1, {0}} inciate that
+         * max supported QTG ID of 1 and recommended QTG is 0.
+         * The values here are faked to simplify emulation.
+         */
+        ifctx2 = aml_if(aml_equal(function, aml_int(1)));
+        {
+            uint16_t word_list[1] = { 0x01 };
+            uint16_t word_list2[1] = { 0 };
+            uint8_t *byte_list = (uint8_t *)word_list;
+            uint8_t *byte_list2 = (uint8_t *)word_list2;
+            Aml *pak, *pak1;
+
+            /*
+             * The return package is a package of a WORD and another package.
+             * The embedded package contains 0 or more WORDs for the
+             * recommended QTG IDs.
+             */
+            pak1 = aml_package(1);
+            aml_append(pak1, aml_buffer(sizeof(uint16_t), byte_list2));
+            pak = aml_package(2);
+            aml_append(pak, aml_buffer(sizeof(uint16_t), byte_list));
+            aml_append(pak, pak1);
+
+            aml_append(ifctx2, aml_return(pak));
+        }
+        aml_append(ifctx, ifctx2);
+    }
+    aml_append(method, ifctx);
+    aml_append(dev, method);
+}
+
 static void cedt_build_chbs(GArray *table_data, PXBDev *cxl)
 {
     SysBusDevice *sbd = SYS_BUS_DEVICE(cxl->cxl.cxl_host_bridge);
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 285829802b1a..623f26a16db3 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1313,6 +1313,7 @@ static void build_acpi0017(Aml *table)
     method = aml_method("_STA", 0, AML_NOTSERIALIZED);
     aml_append(method, aml_return(aml_int(0x01)));
     aml_append(dev, method);
+    build_cxl_dsm_method(dev);
 
     aml_append(scope, dev);
     aml_append(table, scope);
diff --git a/include/hw/acpi/cxl.h b/include/hw/acpi/cxl.h
index acf441888683..8f22c71530d8 100644
--- a/include/hw/acpi/cxl.h
+++ b/include/hw/acpi/cxl.h
@@ -25,5 +25,6 @@ void cxl_build_cedt(GArray *table_offsets, GArray *table_data,
                     BIOSLinker *linker, const char *oem_id,
                     const char *oem_table_id, CXLState *cxl_state);
 void build_cxl_osc_method(Aml *dev);
+void build_cxl_dsm_method(Aml *dev);
 
 #endif


