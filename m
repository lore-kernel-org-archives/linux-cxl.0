Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07D9ECAAA1
	for <linux-cxl@archiver.kernel.org>; Fri, 16 Sep 2022 23:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiIPXVI (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 16 Sep 2022 19:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiIPXVG (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 16 Sep 2022 19:21:06 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5531BADA9
        for <linux-cxl@vger.kernel.org>; Fri, 16 Sep 2022 16:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663370465; x=1694906465;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=L8EduR/mppBDbl2nQY47xP/BT3mN7O0CNNqYSLy6bpg=;
  b=g1oW4DyBPZFAoTVKFGyZPbZj8ZHlouLe5wY42WhC+prXWkIlgz/PpOEz
   R5BWbY8dTcTyinMBnBhBvet4VCGWp42z3ZDWgz5JzHgfqQyUUvKJRWcvk
   d6o2pEtC/qiu7TFAPSjtKzri9BxsGUKwhT9ZZ6mZPx8i1vXe+ayX0N9S1
   ZMcY74P/+tXhE5F3y2cgchvRp8BbMawbeyaRSL36NUuFALz4zjXeMkv5L
   I62KX15EZa7o5vcLeiAu8ynpoZMZSCEY5aW6wFKAjVG4E2yd3p+mcHqCW
   EFtl/wV+pF3yA+hm7+l+K8rhGCEx7VwKfi8ev5IoPTHMx7VPQuY+8fER1
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="299089004"
X-IronPort-AV: E=Sophos;i="5.93,321,1654585200"; 
   d="scan'208";a="299089004"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 16:21:05 -0700
X-IronPort-AV: E=Sophos;i="5.93,321,1654585200"; 
   d="scan'208";a="620248468"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.54.10])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 16:21:05 -0700
From:   alison.schofield@intel.com
To:     Robert Moore <robert.moore@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [ACPICA PATCH] Add CXL 3.0 structures (CXIMS & RDPAS) to the CEDT table
Date:   Fri, 16 Sep 2022 16:21:02 -0700
Message-Id: <20220916232102.673102-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

Prologue: The CXIMS addition to ACPICA was reverted, so, while I was
at it, decided to collect both CEDT changes in one patch for ACPICA.
Please review here, or on ACPICA github:
https://github.com/acpica/acpica/pull/795
Thanks,
Alison


The CXL 3.0 Specification[1] adds two new structures to
the CXL Early Discovery Table (CEDT). The CEDT may include
zero or more entries of these types:

CXIMS: CXL XOR Interleave Math Structure
       Enables the host to find a targets position in an
       Interleave Target List when XOR Math is used.

RDPAS: RCEC Downstream Post Association Structure
       Enables the host to locate the Downstream Port(s)
       that report errors to a given Root Complex Event
       Collector (RCEC).

[1]https://www.computeexpresslink.org/spec-landing

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 source/include/actbl1.h | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/source/include/actbl1.h b/source/include/actbl1.h
index 3de78b0d8f01..6041e8f4c289 100644
--- a/source/include/actbl1.h
+++ b/source/include/actbl1.h
@@ -525,7 +525,9 @@ enum AcpiCedtType
 {
     ACPI_CEDT_TYPE_CHBS                 = 0,
     ACPI_CEDT_TYPE_CFMWS                = 1,
-    ACPI_CEDT_TYPE_RESERVED             = 2,
+    ACPI_CEDT_TYPE_CXIMS                = 2,
+    ACPI_CEDT_TYPE_RDPAS                = 3,
+    ACPI_CEDT_TYPE_RESERVED             = 4,
 };
 
 /* Values for version field above */
@@ -583,6 +585,7 @@ typedef struct acpi_cedt_cfmws_target_element
 /* Values for Interleave Arithmetic field above */
 
 #define ACPI_CEDT_CFMWS_ARITHMETIC_MODULO   (0)
+#define ACPI_CEDT_CFMWS_ARITHMETIC_XOR      (1)
 
 /* Values for Restrictions field above */
 
@@ -592,6 +595,35 @@ typedef struct acpi_cedt_cfmws_target_element
 #define ACPI_CEDT_CFMWS_RESTRICT_PMEM       (1<<3)
 #define ACPI_CEDT_CFMWS_RESTRICT_FIXED      (1<<4)
 
+/* 2: CXL XOR Interleave Math Structure */
+
+struct acpi_cedt_cxims {
+    ACPI_CEDT_HEADER        Header;
+    UINT16                  Reserved1;
+    UINT8                   Hbig;
+    UINT8                   NrXormaps;
+    UINT64                  XormapList[];
+};
+
+/* 3: CXL RCEC Downstream Port Association Structure */
+
+struct acpi_cedt_rdpas {
+    ACPI_CEDT_HEADER        Header;
+    UINT8                   Reserved1;
+    UINT16                  Length;
+    UINT16                  Segment;
+    UINT16                  Bdf;
+    UINT8                   Protocol;
+    UINT64                  Address;
+};
+
+/* Masks for bdf field above */
+#define ACPI_CEDT_RDPAS_BUS_MASK            0xff00
+#define ACPI_CEDT_RDPAS_DEVICE_MASK         0x00f8
+#define ACPI_CEDT_RDPAS_FUNCTION_MASK       0x0007
+
+#define ACPI_CEDT_RDPAS_PROTOCOL_IO        (0)
+#define ACPI_CEDT_RDPAS_PROTOCOL_CACHEMEM  (1)
 
 /*******************************************************************************
  *
-- 
2.31.1

