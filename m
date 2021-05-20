Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 821FCC433B4
	for <linux-cxl@archiver.kernel.org>; Thu, 20 May 2021 19:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53AE9611ED
	for <linux-cxl@archiver.kernel.org>; Thu, 20 May 2021 19:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234183AbhETTxn (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 20 May 2021 15:53:43 -0400
Received: from mga17.intel.com ([192.55.52.151]:16850 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233763AbhETTxm (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 20 May 2021 15:53:42 -0400
IronPort-SDR: u4DC7rcYQe/xOWkpqSk4EcV7FVQLJ2MRTftq5otwnfLGPffJhOiqrspQVGT20Q4XjcUCQLO7EN
 sqpWpFtFp8SA==
X-IronPort-AV: E=McAfee;i="6200,9189,9990"; a="181604440"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="181604440"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 12:52:21 -0700
IronPort-SDR: aPMiNXv8XaXiaDgsfwGGnQJc34xwApQd6g2nGI987XMjxD6q/IMjU/+iJhu1AZ2QO8cl5jJPpQ
 t4EruJpehwkQ==
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="412308735"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 12:52:20 -0700
Subject: [PATCH] cxl/docs: Fix "Title underline too short" warning
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>
Date:   Thu, 20 May 2021 12:52:20 -0700
Message-ID: <162154034053.1995075.17047445540000243300.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

When "Bus" was renamed to "Core" the header underline update was missed.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Fixes: 5f653f7590ab ("cxl/core: Rename bus.c to core.c")
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/driver-api/cxl/memory-devices.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/driver-api/cxl/memory-devices.rst b/Documentation/driver-api/cxl/memory-devices.rst
index 71495ed77069..73f6b246c583 100644
--- a/Documentation/driver-api/cxl/memory-devices.rst
+++ b/Documentation/driver-api/cxl/memory-devices.rst
@@ -29,7 +29,7 @@ CXL Memory Device
    :internal:
 
 CXL Core
--------
+--------
 .. kernel-doc:: drivers/cxl/core.c
    :doc: cxl core
 

