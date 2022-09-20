Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F0A0ECAAD8
	for <linux-cxl@archiver.kernel.org>; Tue, 20 Sep 2022 15:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiITPjd (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 20 Sep 2022 11:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiITPjc (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 20 Sep 2022 11:39:32 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51AE410FB
        for <linux-cxl@vger.kernel.org>; Tue, 20 Sep 2022 08:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663688371; x=1695224371;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9FWPtZOmI1QGxD04E1vIbzu8X5qIclXkGCUprYIMZDk=;
  b=TgOEoeGGtsGPkLDb/2Z8UDfBEbJZI1mim052BFr03QNxauDVsUgbYUGH
   eQYxNvTvv4cbBAZjtK1wqPw2ACsAqj+K8924wOOCLTbC9CyO2gNap/uwn
   yipZoVirPAgJ5SYROacPJ28zdOA2bPSXkSHotuA+St2gcHARH3vuXU5SM
   GbVPtvu6XT24MJhUv5F2B3H+sQUk+8VJJ8H6n2VELnkB3cakMuSYwycIU
   ihHIEJVaf6YvK7bCkCFnVtwZWX/Bk5WT4SF+lGcpH7vDKjgpiWyvkpMnf
   HUIetoovwoFXYGp/Vu/fB5O7dwo7VnUOgqzXq/fvCOTkOlFymzF15RWDo
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="301110856"
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="301110856"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 08:39:30 -0700
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="794302318"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.139.149])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 08:39:29 -0700
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH v4 1/3] For ACPICA: Add the CXIMS structure definition to the CEDT table
Date:   Tue, 20 Sep 2022 08:39:24 -0700
Message-Id: <f64aa41b63d8af9953f6b23f505b3d86b03d891b.1663687681.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1663687681.git.alison.schofield@intel.com>
References: <cover.1663687681.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

A linux-ized ACPI patch is included here for reference. The actual
ACPICA pull request is pending: https://github.com/acpica/acpica/pull/795

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
2.31.1

