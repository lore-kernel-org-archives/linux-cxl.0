Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDAF2C10F1B
	for <linux-cxl@archiver.kernel.org>; Tue, 27 Dec 2022 14:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiL0OwV (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 27 Dec 2022 09:52:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiL0OwU (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 27 Dec 2022 09:52:20 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F0ADA9
        for <linux-cxl@vger.kernel.org>; Tue, 27 Dec 2022 06:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672152739; x=1703688739;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=4qn4Ms2qtvaVNYwLEt2mgGd9BoWoDHUke8BWo+2QOcA=;
  b=IROiYwups1TwFsHvQvuIKzrWzBb9QFg7Lh6s/ibNWIc1wjkUppGYFYhc
   BBxU4MtttpQcDYdf8SKz5FUGr1Zy6ixy2DzvkmQhkqc8fLSWu5goBwRQU
   LI5i3+ESdXdmI128vPmumKs0oldnPFbVEULeobpcJTnuqr/Bv9KRgho8n
   TkyaGmjDc6q0qzASHjy4sQxKTtmPWVodcxB8xzTQen8mVOI32xc3HwHJl
   TWAKeyX79CAMZt82jzK3Drxhsl44ON++vsTBuIO96oBA56/dPFhxB3PiA
   qh5d3M84ptMB727T/t+yMO+n4txAamZjCdlbIWohh2vqZktA+WS36816T
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="300398214"
X-IronPort-AV: E=Sophos;i="5.96,278,1665471600"; 
   d="scan'208";a="300398214"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2022 06:52:19 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="777175363"
X-IronPort-AV: E=Sophos;i="5.96,278,1665471600"; 
   d="scan'208";a="777175363"
Received: from yguan1-mobl.amr.corp.intel.com (HELO localhost) ([10.212.93.223])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2022 06:52:18 -0800
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Tue, 27 Dec 2022 06:52:09 -0800
Subject: [PATCH 1/3] cxl/mem: Fix command comment
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221222-cxl-misc-v1-1-9343bab16e72@intel.com>
References: <20221222-cxl-misc-v1-0-9343bab16e72@intel.com>
In-Reply-To: <20221222-cxl-misc-v1-0-9343bab16e72@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Jiang, Dave" <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linux-cxl@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>
X-Mailer: b4 0.11.0-dev-e429b
X-Developer-Signature: v=1; a=ed25519-sha256; t=1672152737; l=981;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=4qn4Ms2qtvaVNYwLEt2mgGd9BoWoDHUke8BWo+2QOcA=;
 b=Xhsuuv+yawEVXFBujVFkGNIeQDvT6MxjSbUx81xQr4ndeMPCfNjzSqQWpW3c4SlH1pyLEKJDI97r
 UU8jVUHJDsftKjnGOuiIC6S/ST+s0t4AwYfAGB2lMsNLrtOmrQIo
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=brwqReAJklzu/xZ9FpSsMPSQ/qkSalbg6scP3w809Ec=
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The command comment had some minor grammatical errors.

Fix them.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 include/uapi/linux/cxl_mem.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
index c71021a2a9ed..555f9140e2bc 100644
--- a/include/uapi/linux/cxl_mem.h
+++ b/include/uapi/linux/cxl_mem.h
@@ -11,9 +11,9 @@
 /**
  * DOC: UAPI
  *
- * Not all of all commands that the driver supports are always available for use
- * by userspace. Userspace must check the results from the QUERY command in
- * order to determine the live set of commands.
+ * Not all of the commands that the driver supports are available for use by
+ * userspace at all times.  Userspace must check the results from the QUERY
+ * command in order to determine the live set of commands.
  */
 
 #define CXL_MEM_QUERY_COMMANDS _IOR(0xCE, 1, struct cxl_mem_query_commands)

-- 
2.38.1
