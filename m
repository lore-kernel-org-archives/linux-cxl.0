Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C76C25B06
	for <linux-cxl@archiver.kernel.org>; Thu, 11 Aug 2022 20:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236059AbiHKUvn (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 11 Aug 2022 16:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235974AbiHKUvj (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 11 Aug 2022 16:51:39 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0459683BDA
        for <linux-cxl@vger.kernel.org>; Thu, 11 Aug 2022 13:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660251099; x=1691787099;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ynIvCN9mbugg709Ev1X1Qsngn1II0ABSLMI8r3XMQsQ=;
  b=lCYaZo1doqOdrk4IzNPt73PGongNGS99zIYK4pWoC5m+Xt3Ld3K9qcOg
   0HPO+iyVuinH0EG3s/9M0fJPD3E0jDz9l8b0FkfVdu7RNmIVLfP2xzw2W
   syo+uaczcnfnSsVNWoCECjPg2TlgvWncXIHraCPw3rQA7Mqg/4kH4mfTO
   5ukLSCO8395C2CPx0M4i5SLN/dTbG5MiI/jN/4cBwHl6sbPoFzMQOVc3P
   w0Tp4kEchmghcN2NzYn9cuMvRkWPmjwMwVeRFdfTbI29a/tSsP4xBu1re
   7CczogXmtNzN7jmPVqUKUqwYz5CUl+FbU3FvAI4lfPxyNJ7LZLPHQCE1m
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10436"; a="292720487"
X-IronPort-AV: E=Sophos;i="5.93,230,1654585200"; 
   d="scan'208";a="292720487"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 13:51:38 -0700
X-IronPort-AV: E=Sophos;i="5.93,230,1654585200"; 
   d="scan'208";a="851345660"
Received: from alison-desk.jf.intel.com (HELO localhost) ([10.54.74.41])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 13:51:38 -0700
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH v2 1/2] For ACPICA: Add the CXIMS structure definition to the CEDT table
Date:   Thu, 11 Aug 2022 13:49:11 -0700
Message-Id: <74738bc84997117ecd75d49a40dc54789396cfb4.1660250360.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1660250360.git.alison.schofield@intel.com>
References: <cover.1660250360.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

A linux-ized ACPI patch is included here for reference. The actual
pull request is pending: https://github.com/acpica/acpica/pull/787

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

