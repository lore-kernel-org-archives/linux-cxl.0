Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D2BC47088
	for <linux-cxl@archiver.kernel.org>; Wed, 30 Nov 2022 22:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbiK3Wrg (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 30 Nov 2022 17:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiK3Wrf (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 30 Nov 2022 17:47:35 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164D527D
        for <linux-cxl@vger.kernel.org>; Wed, 30 Nov 2022 14:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669848452; x=1701384452;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kU9CQf5le4qcPUecfPa2rwZNfYfqviF4g10RYcJgAsQ=;
  b=la3yzuBdyO8SP2BWOcM8GrzT0wZ+m406vPKb9wL5fJMFOsPFwnKLlLGi
   yDhrfVUmfkCw7llSGLmFcws0snrqofPB7XJMu98KT4g2YKTZwhEkt9sf7
   Z+ShI6ahsISynZhMfXTKtl3348qqc2mquuXG194nV5Z8Xy0VWTnWvLsgA
   uZtGMgyWXioSlkcn/rHnt4kCcZGBDb7R5eodo4kHJ9iIvB9KBX8TAwI8z
   67GBarJrKhId0IwKtmRqjhLvOnI8zHKtNAUrE4n1PH7ENhC2TBD4YO8Ye
   xoTw01szWEJFrA7/Q7cDdYWJ3ii1KW54AfA7SYNe+KVD7RV/NTzVJ2P1M
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="316682635"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="316682635"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 14:47:30 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="769003140"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="769003140"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.3.88])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 14:47:30 -0800
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH v9 1/3] ACPICA commit 2d8dc0383d3c908389053afbdc329bbd52f009ce
Date:   Wed, 30 Nov 2022 14:47:24 -0800
Message-Id: <62d3f6a43fb8ef892965a8257fad17dbfb1afae4.1669847017.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1669847017.git.alison.schofield@intel.com>
References: <cover.1669847017.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

The CXL 3.0 Specification [1] adds two new structures to
the CXL Early Discovery Table (CEDT). The CEDT may include
zero or more entries of these types:

CXIMS: CXL XOR Interleave Math Structure
       Enables the host to find a targets position in an
       Interleave Target List when XOR Math is used.

RDPAS: RCEC Downstream Post Association Structure
       Enables the host to locate the Downstream Port(s)
       that report errors to a given Root Complex Event
       Collector (RCEC).

Link: https://www.computeexpresslink.org/spec-landing # [1]
Link: https://github.com/acpica/acpica/commit/2d8dc038
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Removed Bob and Rafael SOBs to prevent spamming them on my every rev.
---
 include/acpi/actbl1.h | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 15c78678c5d3..2aba6f516e70 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -329,7 +329,9 @@ struct acpi_cedt_header {
 enum acpi_cedt_type {
 	ACPI_CEDT_TYPE_CHBS = 0,
 	ACPI_CEDT_TYPE_CFMWS = 1,
-	ACPI_CEDT_TYPE_RESERVED = 2,
+	ACPI_CEDT_TYPE_CXIMS = 2,
+	ACPI_CEDT_TYPE_RDPAS = 3,
+	ACPI_CEDT_TYPE_RESERVED = 4,
 };
 
 /* Values for version field above */
@@ -380,6 +382,7 @@ struct acpi_cedt_cfmws_target_element {
 /* Values for Interleave Arithmetic field above */
 
 #define ACPI_CEDT_CFMWS_ARITHMETIC_MODULO   (0)
+#define ACPI_CEDT_CFMWS_ARITHMETIC_XOR      (1)
 
 /* Values for Restrictions field above */
 
@@ -389,6 +392,36 @@ struct acpi_cedt_cfmws_target_element {
 #define ACPI_CEDT_CFMWS_RESTRICT_PMEM       (1<<3)
 #define ACPI_CEDT_CFMWS_RESTRICT_FIXED      (1<<4)
 
+/* 2: CXL XOR Interleave Math Structure */
+
+struct acpi_cedt_cxims {
+	struct acpi_cedt_header header;
+	u16 reserved1;
+	u8 hbig;
+	u8 nr_xormaps;
+	u64 xormap_list[];
+};
+
+/* 3: CXL RCEC Downstream Port Association Structure */
+
+struct acpi_cedt_rdpas {
+	struct acpi_cedt_header header;
+	u8 reserved1;
+	u16 length;
+	u16 segment;
+	u16 bdf;
+	u8 protocol;
+	u64 address;
+};
+
+/* Masks for bdf field above */
+#define ACPI_CEDT_RDPAS_BUS_MASK            0xff00
+#define ACPI_CEDT_RDPAS_DEVICE_MASK         0x00f8
+#define ACPI_CEDT_RDPAS_FUNCTION_MASK       0x0007
+
+#define ACPI_CEDT_RDPAS_PROTOCOL_IO        (0)
+#define ACPI_CEDT_RDPAS_PROTOCOL_CACHEMEM  (1)
+
 /*******************************************************************************
  *
  * CPEP - Corrected Platform Error Polling table (ACPI 4.0)
-- 
2.37.3

