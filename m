Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF38C4167B
	for <linux-cxl@archiver.kernel.org>; Tue, 27 Dec 2022 14:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiL0OwX (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 27 Dec 2022 09:52:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiL0OwV (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 27 Dec 2022 09:52:21 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336CDD6D
        for <linux-cxl@vger.kernel.org>; Tue, 27 Dec 2022 06:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672152741; x=1703688741;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=4TE5evIcDl4bL6+AaBU5LuBIdWPE8Ql2QBbd/s9ke04=;
  b=Z4GBiAMsE2tR0J35KG+0Y6jYZFj6aWUIAIMcbLMTgFUy1o4BGjYtoGQY
   FtjAnHc9mmRLfRNpuep8B5meFbKEc2ef8q/hxp12AQcVWEuU23oN5oRu5
   gZEV9mQjBtOYh5rqo1+5JNz1wmdAWEaS6Xu/BKTp2Taqr8+vr0kt6fMUX
   rd79P8jq1k89fZ96RMCqSO0svh5zRRp8/z4/qGJjMsaxXjjZX7hg1xG07
   itS+Fn6mZhx2GmNMjsFEuz9w1I7+m+nuy/T3d2UESR9uLDxhrxR1UagVh
   XvmnHbTKlGDq0Tk9wTYN1jCDwPnoDr3HCwtdIKgiKE4NlCKfHtsWpPjlN
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="300398224"
X-IronPort-AV: E=Sophos;i="5.96,278,1665471600"; 
   d="scan'208";a="300398224"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2022 06:52:21 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="777175372"
X-IronPort-AV: E=Sophos;i="5.96,278,1665471600"; 
   d="scan'208";a="777175372"
Received: from yguan1-mobl.amr.corp.intel.com (HELO localhost) ([10.212.93.223])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2022 06:52:20 -0800
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Tue, 27 Dec 2022 06:52:11 -0800
Subject: [PATCH 3/3] cxl/uapi: Add warning on CXL command enum
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221222-cxl-misc-v1-3-9343bab16e72@intel.com>
References: <20221222-cxl-misc-v1-0-9343bab16e72@intel.com>
In-Reply-To: <20221222-cxl-misc-v1-0-9343bab16e72@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Jiang, Dave" <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linux-cxl@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>
X-Mailer: b4 0.11.0-dev-e429b
X-Developer-Signature: v=1; a=ed25519-sha256; t=1672152737; l=1089;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=4TE5evIcDl4bL6+AaBU5LuBIdWPE8Ql2QBbd/s9ke04=;
 b=A/0v2qGRvvOjvq5O5cLJp/yFc+9aKD2qqfi8RtC/4DLWQqb/YPYyzoLsXYKeoOj1pJiiDEUzlcXZ
 aqSE4dXzC1hJCXjtNSgFPRbJrCzCxfwBo8boPWGLEt9sIzdQ5IRH
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=brwqReAJklzu/xZ9FpSsMPSQ/qkSalbg6scP3w809Ec=
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The CXL command enum is exported to user space and must maintain
backwards compatibility.

Add comment that new defines must be added to the end of the list.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 include/uapi/linux/cxl_mem.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
index 555f9140e2bc..b3fd46af70f8 100644
--- a/include/uapi/linux/cxl_mem.h
+++ b/include/uapi/linux/cxl_mem.h
@@ -19,6 +19,10 @@
 #define CXL_MEM_QUERY_COMMANDS _IOR(0xCE, 1, struct cxl_mem_query_commands)
 #define CXL_MEM_SEND_COMMAND _IOWR(0xCE, 2, struct cxl_send_command)
 
+/*
+ * NOTE: New defines must be added to the end of the list to preserve
+ * compatibility because this enum is exported to user space.
+ */
 #define CXL_CMDS                                                          \
 	___C(INVALID, "Invalid Command"),                                 \
 	___C(IDENTIFY, "Identify Command"),                               \

-- 
2.38.1
