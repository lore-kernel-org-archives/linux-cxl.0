Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71127C6FA86
	for <linux-cxl@archiver.kernel.org>; Fri, 16 Sep 2022 01:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiIPBab (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 15 Sep 2022 21:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiIPBab (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 15 Sep 2022 21:30:31 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4941D3C8E3
        for <linux-cxl@vger.kernel.org>; Thu, 15 Sep 2022 18:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663291830; x=1694827830;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qmIBc4deWyyhQxCfLTAjO3Vf0KzTaCv6uY5wjofv82g=;
  b=KqjVFBPo1xCQqoveaIPX5cg5c9OkuSzmaTbHLwq6g/eBh5E9bD9mVWhG
   M+2ndW5MFUA1wtRVD2NsGdSUy1J+YaQc0cNxVXnYzFcgrG+OwGnbvPuY/
   k+9QmJDZkTcFsrSbX5sBOB5GJKmSiyCPBDTs2B9zwkEfnscvbbwmmDm1a
   sZvmfV3L0bfAWlLJc/Vz32L1Oyef5DxGQyv3A7LrDCy8FWPAKq/bRjuRJ
   5tC/q1cIMXDVilmEpLiTQHa9ymGaJ0lX9PV+4BSx9GqHfLTHv56HMCl+8
   plz5SVg8tkyyZ5UklXtS06bPpt17ByKsYp9gFz+87NbdWHiHfoeTb7HqD
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10471"; a="281913022"
X-IronPort-AV: E=Sophos;i="5.93,319,1654585200"; 
   d="scan'208";a="281913022"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 18:30:29 -0700
X-IronPort-AV: E=Sophos;i="5.93,319,1654585200"; 
   d="scan'208";a="617502235"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.120.139])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 18:30:29 -0700
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH v3 1/3] For ACPICA: Add the CXIMS structure definition to the CEDT table
Date:   Thu, 15 Sep 2022 18:30:22 -0700
Message-Id: <2252a180fca53c2cc1bf46efb451eff91587eac7.1663291370.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1663291370.git.alison.schofield@intel.com>
References: <cover.1663291370.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

A linux-ized ACPI patch is included here for reference. The ACPI
pull request has been merged and we expect the upstream version
shortly. https://github.com/acpica/acpica/pull/787

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

