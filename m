Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DC014E2C9
	for <linux-cxl@vger.kernel.org>; Wed, 27 Mar 2024 19:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711569159; cv=none; b=bWbIlA3yVXfZs1SStuVtZszFl2AYCIKUEmXvqy4RbRpO0yOTpP6FZHiN8QQKgAjQNpRyusR+tjtrC5YQvYu8YkGbq/rS+Y8oWXFbFJ0QE29ShtT0y80hsuuE1iSY5FIlQ/rYGFrhrMsQMHtcSM4BnjD/en61c7Dk471o8SPdEsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711569159; c=relaxed/simple;
	bh=XISgranDwa4ij9bgE4Mun2LrZs7N9ulXb55CaoAbkp0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qeqCwyVlintzKIjpTpOKPpMje1alp/cZ8Cnce8SviUEX8iYSB19X+hWOOlvMF6eUcn/LQb0G9dYxPvqN+QpiDWmKivNu5QlKgryIPHVd2sIxbUDyNUo+MZnbogDFEWV5r/+j0AIFFoBq6uVsiB9HhxddbXz6wDw7LEPeTdlG8Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HT2TvD2w; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HT2TvD2w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711569158; x=1743105158;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XISgranDwa4ij9bgE4Mun2LrZs7N9ulXb55CaoAbkp0=;
  b=HT2TvD2w68WJzdA84cU4pz8z1EFCMJchjm4/iUxot5XyKNG8uaD5rUqx
   GTBeAmfpNQf4DUNO8896kryzAJyf6N3BS6SPMmqCE7ftUaCmCWjTEths+
   D20LgCnfl0sS8KHgid+44UupaEh6uMdAmkU8kKF+BnZl2Xez3m43lgdI0
   Y/O8C4ONkgZcFxV05yU6a6pHum13vdMfBY1gqAuzP2LbMUbfKD42rvp1C
   mPWMESxjnJQhhUp584EMcYh2CJCQhEd6FAptS26RaquuNsNEkpJQRob1i
   l3+VpQgRcZ/L5O97uo9oi2jA6lw7NriLfSTBsFWQoO575QZ1uZ0au5Gbs
   Q==;
X-CSE-ConnectionGUID: IYy7lkhgSCeL/snQGdx6lw==
X-CSE-MsgGUID: JXv/ipOJRiWVmn1hjh/nmQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="6560206"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="6560206"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 12:52:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="47616303"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.82.250])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 12:52:36 -0700
From: alison.schofield@intel.com
To: Vishal Verma <vishal.l.verma@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org
Subject: [ndctl PATCH v12 3/8] util/trace: pass an event_ctx to its own parse_event method
Date: Wed, 27 Mar 2024 12:52:24 -0700
Message-Id: <a3984549969ff77441979229a30dd0ca24b93044.1711519822.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1711519822.git.alison.schofield@intel.com>
References: <cover.1711519822.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

Tidy-up the calling convention used in trace event parsing by
passing the entire event_ctx to its parse_event method. This
makes it explicit that a parse_event operates on an event_ctx
object and it allows the parse_event function to access any
members of the event_ctx structure.

This is in preparation for adding a private parser requiring more
context for cxl_poison events.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 util/event_trace.c | 9 ++++-----
 util/event_trace.h | 2 +-
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/util/event_trace.c b/util/event_trace.c
index 57318e2adace..1f5c180a030b 100644
--- a/util/event_trace.c
+++ b/util/event_trace.c
@@ -60,7 +60,7 @@ static struct json_object *num_to_json(void *num, int elem_size, unsigned long f
 }
 
 static int event_to_json(struct tep_event *event, struct tep_record *record,
-			 struct list_head *jlist_head)
+			 struct event_ctx *ctx)
 {
 	struct json_object *jevent, *jobj, *jarray;
 	struct tep_format_field **fields;
@@ -190,7 +190,7 @@ static int event_to_json(struct tep_event *event, struct tep_record *record,
 		}
 	}
 
-	list_add_tail(jlist_head, &jnode->list);
+	list_add_tail(&ctx->jlist_head, &jnode->list);
 	return 0;
 
 err_jevent:
@@ -220,10 +220,9 @@ static int event_parse(struct tep_event *event, struct tep_record *record,
 	}
 
 	if (event_ctx->parse_event)
-		return event_ctx->parse_event(event, record,
-					      &event_ctx->jlist_head);
+		return event_ctx->parse_event(event, record, event_ctx);
 
-	return event_to_json(event, record, &event_ctx->jlist_head);
+	return event_to_json(event, record, event_ctx);
 }
 
 int trace_event_parse(struct tracefs_instance *inst, struct event_ctx *ectx)
diff --git a/util/event_trace.h b/util/event_trace.h
index 6586e1dc254d..9c53eba7533f 100644
--- a/util/event_trace.h
+++ b/util/event_trace.h
@@ -17,7 +17,7 @@ struct event_ctx {
 	const char *event_name; /* optional */
 	int event_pid; /* optional */
 	int (*parse_event)(struct tep_event *event, struct tep_record *record,
-			   struct list_head *jlist_head); /* optional */
+			   struct event_ctx *ctx);
 };
 
 int trace_event_parse(struct tracefs_instance *inst, struct event_ctx *ectx);
-- 
2.37.3

