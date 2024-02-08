Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061E014007
	for <linux-cxl@vger.kernel.org>; Thu,  8 Feb 2024 01:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707354127; cv=none; b=T4Hi71l5lqcmcD6/uXQ4/hubFYsW3+RVmVSZIfvAlvF6xhNhgXr011/DZUp1P+mvXab2KKBNZjGMFUhEsQXUOYLVoGex839n6KjRUOwg3eJP92hhzdyplNNMiqIbtaGKsm4cXaPoZs/ztfIYTzBH3ReEpp6hHKcipEn29oSn1L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707354127; c=relaxed/simple;
	bh=sg75Nzd0Nfpa+tECk4dpxR+hOqypAdcjo1sTuoZWf9Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KEYLfB+gbABahjh29mrs2GuZVX/WDSBP21xuxdVwlw7dZl4EbxXbqcPpazTBmr3MoI+NnetriNKwb931gNCoxm7QTlJPu6BltbB28+jlPwGHDk4roe3rrxyEpyRgkKl3DnykawDg+bOKwEGpLKoz+/iKrC6Wu/quomq+GbGzS2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lQIFcOQk; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lQIFcOQk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707354126; x=1738890126;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sg75Nzd0Nfpa+tECk4dpxR+hOqypAdcjo1sTuoZWf9Q=;
  b=lQIFcOQkSEP5Leg5max5H27bqdtLUfcIwu9ffhRpWTZi4Z0r1s3WuE7e
   75BLzJOeIBXRBUiLVi9ucXqQOuTpqNhADUR1kBVyvp6jFqF9DolQlWfZQ
   JML2CnTfwyHx2uBo3o7ETA6kUCPCj0J702Kckv7KtPQ0T0NJRTSzdBbQQ
   5HNs2fTehgFbcF0z7Vs9b8BI1H7zZfBcDRMMLA5ztkIPx6TijMJWGY9sh
   EH4lJXxiIG5qUI5bv03wAMMtNfS69EUMO39Ccvo2C4x/cSkiFyB3SXI5p
   74NNml0y97CDt0kJ3y4x/j1izRxIlBggxg31HsTYm/cHJhgOWQTxlZQiF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="18629895"
X-IronPort-AV: E=Sophos;i="6.05,252,1701158400"; 
   d="scan'208";a="18629895"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 17:01:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,252,1701158400"; 
   d="scan'208";a="1529258"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.105.224])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 17:01:50 -0800
From: alison.schofield@intel.com
To: Vishal Verma <vishal.l.verma@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>
Subject: [ndctl PATCH v7 2/7] cxl: add an optional pid check to event parsing
Date: Wed,  7 Feb 2024 17:01:41 -0800
Message-Id: <de525a392411945fa3c81bd743bd71209857ffd3.1707351560.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1707351560.git.alison.schofield@intel.com>
References: <cover.1707351560.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

When parsing CXL events, callers may only be interested in events
that originate from the current process. Introduce an optional
argument to the event trace context: event_pid. When event_pid is
present, simply skip the parsing of events without a matching pid.
It is not a failure to see other, non matching events.

The initial use case for this is device poison listings where
only the media-error records requested by this process are wanted.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
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

