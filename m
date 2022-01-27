Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B7CC433F5
	for <linux-cxl@archiver.kernel.org>; Thu, 27 Jan 2022 21:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbiA0V3g (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 27 Jan 2022 16:29:36 -0500
Received: from mga03.intel.com ([134.134.136.65]:30536 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229610AbiA0V3g (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 27 Jan 2022 16:29:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643318976; x=1674854976;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gQO89et669dzx6ow2bGppQogeEOsPa/FRO7ZoBM0oT4=;
  b=Wt7qivZIL0RZrGtT28zq1I3LsyZ822Y9uv6/MFORpBrhrR6AHf3DNzqE
   zg02RffYttELEW2EW6ZcfOjNPiq4ZwxKndf6OC06bTlpFNfHTyD97JBnB
   I4MMDA9jjxo5m6OD4Dt7jsW2rB+d8w1SLwe0AEX+6l/X838xxIxMdKrZM
   hp8ULzb0d5Ica8zPaJARxNM7MeoZylD3IbvD25COOSJIaY6y/jjm6ph2Q
   FL8hPNJ1QiSJ/AvuMr1g4I6VV4h21FAVZ19zcdyVRHSzZsV0adSgLE5Ql
   DLu2azI4APXZQkTzKxsKGqAVCIej4cte8PWZWI3vXbar8jF6LO4hjEQWK
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="246914534"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="246914534"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 13:29:33 -0800
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="521402187"
Received: from vrao2-mobl1.gar.corp.intel.com (HELO localhost.localdomain) ([10.252.129.6])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 13:29:32 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     patches@lists.linux.dev, Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 1/4] cxl/acpi: Store interleave granularity absolutely
Date:   Thu, 27 Jan 2022 13:29:08 -0800
Message-Id: <20220127212911.127741-2-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220127212911.127741-1-ben.widawsky@intel.com>
References: <20220127212911.127741-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

This matches the usages everywhere else in the driver and matches the
existing kernel documentation defined for CXL decoders.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index f64d98bfcb3b..f99cad8350fd 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -11,7 +11,7 @@
 
 /* Encode defined in CXL 2.0 8.2.5.12.7 HDM Decoder Control Register */
 #define CFMWS_INTERLEAVE_WAYS(x)	(1 << (x)->interleave_ways)
-#define CFMWS_INTERLEAVE_GRANULARITY(x)	((x)->granularity + 8)
+#define CFMWS_INTERLEAVE_GRANULARITY(x)	(1 << ((x)->granularity + 8))
 
 static unsigned long cfmws_to_decoder_flags(int restrictions)
 {
-- 
2.35.0

