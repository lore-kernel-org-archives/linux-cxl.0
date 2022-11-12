Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBAE1C433FE
	for <linux-cxl@archiver.kernel.org>; Sat, 12 Nov 2022 04:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234480AbiKLEli (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 11 Nov 2022 23:41:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234508AbiKLElf (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 11 Nov 2022 23:41:35 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2A2E0BE
        for <linux-cxl@vger.kernel.org>; Fri, 11 Nov 2022 20:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668228094; x=1699764094;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=opuUnnypySteFynkOwHk8TNiZs+eO9J2vj6mPLnCtXA=;
  b=jpaP7ZsM0XuANKnsjsg61PHaoQQzHWeVJjGB4RAOSViGccVXYRdZDEHY
   JO9R0rQNTLeZaotD8a+f8CWaL4TYF3Xp2hM0dWzX6GQMPvyet9lkiBfUm
   +PsyPkWSD8nnqPzkZSWiBYJ3tqyq9nxf1pRKcyGhBa4Xvk+Y3PFZOUwZf
   qbpZBczgU+GNXs7Vyoh1C58lazjORezg5yB/yjKWUFlWaOhveebOGTMa2
   Bz//b76INcdVQSOqqAya2V7obKOKFPdLgqEoAzpnkoDlZ1g8U2O5NdQJ/
   Nql6Ts6TesUW9gqsxnmcn63TgcjjMpRSFaGFkb/+Si9eLq7De0JBqONYk
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="375968588"
X-IronPort-AV: E=Sophos;i="5.96,158,1665471600"; 
   d="scan'208";a="375968588"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 20:41:34 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="670920046"
X-IronPort-AV: E=Sophos;i="5.96,158,1665471600"; 
   d="scan'208";a="670920046"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.252.134.249])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 20:41:33 -0800
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org, Bob Moore <robert.moore@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v6 1/3] ACPICA commit 2d8dc0383d3c908389053afbdc329bbd52f009ce
Date:   Fri, 11 Nov 2022 20:41:27 -0800
Message-Id: <182f7f8c03fc38bd02426280e72f944188563671.1668227077.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1668227077.git.alison.schofield@intel.com>
References: <cover.1668227077.git.alison.schofield@intel.com>
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

