Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 138EEC67871
	for <linux-cxl@archiver.kernel.org>; Thu, 27 Oct 2022 04:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbiJ0EIA (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 27 Oct 2022 00:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234434AbiJ0EHx (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 27 Oct 2022 00:07:53 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DFC7152C48
        for <linux-cxl@vger.kernel.org>; Wed, 26 Oct 2022 21:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666843672; x=1698379672;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ioqKbHx5qRbY5tFOwrT66pXS/ozj08Q58SMunjqZi7w=;
  b=LsCH9mjE/oBymxSll5HH1xnGwwFXf8gocmHkmh6V/dHq+3S+Y4rlSXvS
   mAMgqi7e00RGga42Gmy3uVXa1ldT7Yr8XZqq/sgADGZ/5ikkPJb545u8W
   gVSJX9YVg99g6WK7KHoFg2TAF57lspy8cvWSKqzh3MVa3IcIV4/30CTSY
   iQ9tQU4y/kdGGue4p4bJ/peiMTSiwrSlY0TurL+qUoic0PfiwwPQN9xVg
   eoBsaKhLUh5quq9T6Wn+EMOPRZikK4AAePOOHCYo7IZp4Q98GbSyh/27h
   PhwV3iaGtDA22bWjINpPdecPG5mY3sDBOYKEvwow3X9XQ7ODyZfaw1t2x
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="295533031"
X-IronPort-AV: E=Sophos;i="5.95,215,1661842800"; 
   d="scan'208";a="295533031"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 21:07:51 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="961475575"
X-IronPort-AV: E=Sophos;i="5.95,215,1661842800"; 
   d="scan'208";a="961475575"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.1.141])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 21:07:50 -0700
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH v5 1/3] For ACPICA: Add the CXIMS structure definition to the CEDT table
Date:   Wed, 26 Oct 2022 21:07:41 -0700
Message-Id: <a8832a0e46cad02e76648cc79181392113dabcf7.1666841669.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1666841669.git.alison.schofield@intel.com>
References: <cover.1666841669.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

A linux-ized ACPI patch is included here for reference. The ACPI
pull request has been merged and we expect the upstream version
shortly. https://github.com/acpica/acpica/pull/795

The CXL XOR Interleave Math Structure (CXIMS) is added to the
CXL Early Discovery Table (CEDT). This new structure is defined
in the CXL 3.0 specification Section 9.17.1.4

https://www.computeexpresslink.org/spec-landing

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 include/acpi/actbl1.h | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 15c78678c5d3..f96f4fe5328d 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -329,7 +329,8 @@ struct acpi_cedt_header {
 enum acpi_cedt_type {
 	ACPI_CEDT_TYPE_CHBS = 0,
 	ACPI_CEDT_TYPE_CFMWS = 1,
-	ACPI_CEDT_TYPE_RESERVED = 2,
+	ACPI_CEDT_TYPE_CXIMS = 2,
+	ACPI_CEDT_TYPE_RESERVED = 3,
 };
 
 /* Values for version field above */
@@ -380,6 +381,7 @@ struct acpi_cedt_cfmws_target_element {
 /* Values for Interleave Arithmetic field above */
 
 #define ACPI_CEDT_CFMWS_ARITHMETIC_MODULO   (0)
+#define ACPI_CEDT_CFMWS_ARITHMETIC_XOR	    (1)
 
 /* Values for Restrictions field above */
 
@@ -389,6 +391,16 @@ struct acpi_cedt_cfmws_target_element {
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
 /*******************************************************************************
  *
  * CPEP - Corrected Platform Error Polling table (ACPI 4.0)
-- 
2.37.3

