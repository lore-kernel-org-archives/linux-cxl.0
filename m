Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC199C433FE
	for <linux-cxl@archiver.kernel.org>; Wed, 13 Apr 2022 18:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235218AbiDMSkP (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 13 Apr 2022 14:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237753AbiDMSkO (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 13 Apr 2022 14:40:14 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473C953E2A
        for <linux-cxl@vger.kernel.org>; Wed, 13 Apr 2022 11:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649875072; x=1681411072;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rab7+/1vK899gfd3hJN113ssNf+C+OwnTeELqFJrFc0=;
  b=ai/Vf+d+Vej/bpPBJvpNcXGVLt+J3tOMStDO3VECS6UCmiTDZpYXyeuJ
   OeJQOKh8inPJPSuY/kmQSo4B73OLxNUohah1hXhdClvqVzPXbjWj4WDOA
   Lx2CgLTeL3m13f8I20aJjft9MKXcIXRcQq6xdYCuXrH2H3k+TM+CtUmno
   EOoxtYbSjMGpM1KAvLwaPhojeC6YcF4cVZGJye88Sm8y3MxaAyp+zOZCW
   V3h0F6jLYQXuiBoG9MKE0S9kZO5D1i59AEuq93j0X3xWM4h9x7AblKY/q
   Gy2sEH6bMm5sv7tsFx+sCL6KjcQJ+iPN+IgJRFhgM4iSoeznTcAvJMxBG
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="262497748"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="262497748"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 11:37:51 -0700
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="725013619"
Received: from sushobhi-mobl.amr.corp.intel.com (HELO localhost.localdomain) ([10.252.131.238])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 11:37:50 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev
Cc:     patches@lists.linux.dev, Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [RFC PATCH 11/15] cxl/acpi: Use common IW/IG decoding
Date:   Wed, 13 Apr 2022 11:37:16 -0700
Message-Id: <20220413183720.2444089-12-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220413183720.2444089-1-ben.widawsky@intel.com>
References: <20220413183720.2444089-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Now that functionality to decode interleave ways and granularity is in
a common place, use that functionality in the cxl_acpi driver.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/acpi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index a6b0c3181d0e..50e54e5d58c0 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -11,8 +11,8 @@
 #include "cxl.h"
 
 /* Encode defined in CXL 2.0 8.2.5.12.7 HDM Decoder Control Register */
-#define CFMWS_INTERLEAVE_WAYS(x)	(1 << (x)->interleave_ways)
-#define CFMWS_INTERLEAVE_GRANULARITY(x)	((x)->granularity + 8)
+#define CFMWS_INTERLEAVE_WAYS(x)	(cxl_to_interleave_ways((x)->interleave_ways))
+#define CFMWS_INTERLEAVE_GRANULARITY(x)	(cxl_to_interleave_granularity((x)->granularity))
 
 static unsigned long cfmws_to_decoder_flags(int restrictions)
 {
-- 
2.35.1

