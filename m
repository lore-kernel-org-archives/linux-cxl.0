Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hFPkqSXW"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3D4113
	for <linux-cxl@vger.kernel.org>; Tue, 21 Nov 2023 10:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700593136; x=1732129136;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qw6ErE+N/Zs5mIaQY8NIOuKAGUcYqneo1GoEkWUjLLw=;
  b=hFPkqSXWzKszuGBNRhTD8dDMOn5DuX1Un9Ld0HjOPqMbtlNlB77z7/1y
   mQZacj9cLubLhBgIpGIXC+DfU9NY6RCmNh9d1yuIfHYAZ2C6nFaMkF0/s
   2YJu6avhOs+ek8plc5oJuotwtyVLMAgBN0XaluD265xQzm9rV2zazLp7/
   9I95lQUmEjBFkzr+5udUw89+jYqEsFCsf9qv6SileIFXVZln8z9tbSLIk
   waEvmGqgRDKUTFSRLVSMT1tf9xSkUYdP9UVkYmaymSnMTLEIDauEG+98Q
   IMB9vEgEKkrM5pDioug9rpMFFrnZMfJDNYB+vE/zfhEm4k8oPKRITonbr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="376939705"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="376939705"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 10:58:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="743139570"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="743139570"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.90.75])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 10:58:54 -0800
From: alison.schofield@intel.com
To: Vishal Verma <vishal.l.verma@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [ndctl PATCH v4 2/5] cxl: add an optional pid check to event parsing
Date: Tue, 21 Nov 2023 10:58:48 -0800
Message-Id: <e00713d31e84d5ff29869f2c8391b952670184e3.1700591754.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1700591754.git.alison.schofield@intel.com>
References: <cover.1700591754.git.alison.schofield@intel.com>
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

