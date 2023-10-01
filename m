Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 054C3E7849B
	for <linux-cxl@archiver.kernel.org>; Sun,  1 Oct 2023 22:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234055AbjJAWbq (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 1 Oct 2023 18:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjJAWbp (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 1 Oct 2023 18:31:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336E8D3
        for <linux-cxl@vger.kernel.org>; Sun,  1 Oct 2023 15:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696199500; x=1727735500;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qw6ErE+N/Zs5mIaQY8NIOuKAGUcYqneo1GoEkWUjLLw=;
  b=mg91a4mll6xhrKkCgTehH8ZFCuW4UIoq4AmRZpzK9y3MBhIWsBh/0Pvc
   BQrPr/9xnfzBU2Td+z4+Kcyz81b4MhlqhC1Fd5po6Vs/YzkG2Q70eAU8U
   REJuXXS3iQSeSXpHXY+AZBimvW8Y5woC/iAEmtSd7W6EAz+EJI+JHdnv7
   eEBBE6EMXwH+4o8188BBCrkgjRhaQOER/TVl7oqWGQnCkIZzaTDDxYXs6
   Jh2+OoQgFTw1hftRNME7SlVreLrAkUFgUV3N0h9wa80TtLnRhSciou89x
   qY2GyWtV94ibcnh/Ivyre+zsKzEiDJTsNnVltf9NB2XJ5GkBv5nvmPzNs
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="367618316"
X-IronPort-AV: E=Sophos;i="6.03,193,1694761200"; 
   d="scan'208";a="367618316"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2023 15:31:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="779781956"
X-IronPort-AV: E=Sophos;i="6.03,193,1694761200"; 
   d="scan'208";a="779781956"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.251.20.198])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2023 15:31:39 -0700
From:   alison.schofield@intel.com
To:     Vishal Verma <vishal.l.verma@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [ndctl PATCH v2 2/5] cxl: add an optional pid check to event parsing
Date:   Sun,  1 Oct 2023 15:31:32 -0700
Message-Id: <f539e392ff6987147c17ff0c95af8ebf84256da5.1696196382.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1696196382.git.alison.schofield@intel.com>
References: <cover.1696196382.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

When parsing CXL events, callers may only be interested in events
that originate from the current process. Introduce an optional
argument to the event trace context: event_pid. When event_pid is
present, only include events with a matching pid in the returned
JSON list. It is not a failure to see other, non matching results.
Simply skip those.

The initial use case for this is device poison listings where
only the poison error records requested by this process are wanted.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 cxl/event_trace.c | 5 +++++
 cxl/event_trace.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/cxl/event_trace.c b/cxl/event_trace.c
index db8cc85f0b6f..269060898118 100644
--- a/cxl/event_trace.c
+++ b/cxl/event_trace.c
@@ -208,6 +208,11 @@ static int cxl_event_parse(struct tep_event *event, struct tep_record *record,
 			return 0;
 	}
 
+	if (event_ctx->event_pid) {
+		if (event_ctx->event_pid != tep_data_pid(event->tep, record))
+			return 0;
+	}
+
 	if (event_ctx->parse_event)
 		return event_ctx->parse_event(event, record,
 					      &event_ctx->jlist_head);
diff --git a/cxl/event_trace.h b/cxl/event_trace.h
index ec6267202c8b..7f7773b2201f 100644
--- a/cxl/event_trace.h
+++ b/cxl/event_trace.h
@@ -15,6 +15,7 @@ struct event_ctx {
 	const char *system;
 	struct list_head jlist_head;
 	const char *event_name; /* optional */
+	int event_pid; /* optional */
 	int (*parse_event)(struct tep_event *event, struct tep_record *record,
 			   struct list_head *jlist_head); /* optional */
 };
-- 
2.37.3

