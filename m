Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C03CEC4332F
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Nov 2022 04:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234814AbiKREdh (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 17 Nov 2022 23:33:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234710AbiKREdf (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 17 Nov 2022 23:33:35 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13AEBB870
        for <linux-cxl@vger.kernel.org>; Thu, 17 Nov 2022 20:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668746014; x=1700282014;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=opuUnnypySteFynkOwHk8TNiZs+eO9J2vj6mPLnCtXA=;
  b=KiA7OpVzcqSkJSOWSMYfZNgykkcL8Y8cEK529mMvkDmu+OlfyJd7/Scu
   MV5PXa3HkRMQFrHsW1cfSiUc5BQ5lFLinjvUNs39PryKavgdna4zQBfr2
   954ZQPlVlq/JX2Gn92b2mrJ5wORxSWoemo2BCye6v0cjKFU2SP/FFHcjA
   okZbbQDmCZHyzHJNskFjCVrc/M+NhDBxB1lLvpU383QUg4BxMytt8nIUV
   08TfOCFuq2f3JRIlEBSuakXBZt17SHB3txKE9T0DHrx5hD2KC/3Xg3fFS
   YFvcx48rwOT5e6JL9BSG4cyNgbPe6OUEUqTpqUmSDDiayB3YJ4cWpu0Bh
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="377321662"
X-IronPort-AV: E=Sophos;i="5.96,173,1665471600"; 
   d="scan'208";a="377321662"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 20:33:32 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="634304315"
X-IronPort-AV: E=Sophos;i="5.96,173,1665471600"; 
   d="scan'208";a="634304315"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.84.12])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 20:33:32 -0800
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org, Bob Moore <robert.moore@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v7 1/3] ACPICA commit 2d8dc0383d3c908389053afbdc329bbd52f009ce
Date:   Thu, 17 Nov 2022 20:33:27 -0800
Message-Id: <57ed3952356f62e20f819896606e19b71737bbf6.1668745515.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1668745515.git.alison.schofield@intel.com>
References: <cover.1668745515.git.alison.schofield@intel.com>
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
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
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

