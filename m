Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB011BC43
	for <linux-cxl@vger.kernel.org>; Sat,  6 Jul 2024 06:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720247103; cv=none; b=qyeyqha5Jgm255+e4zNaXPYw7hb8SgJA3dJeAPlXWmaGLQ0gGgjsJUGFMSc2T9g07XyQ7mfWFrb9rWDefTDvWBrHxvqZEanq/r7xq9cxGnrhgf0DEd3esgqHRY0ziLTrfyUJjTzw71ehbtdSs0GaYPjWVTObIKDlJAar3lqgrCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720247103; c=relaxed/simple;
	bh=roIYcf7YeNI5tK4KPiAUUtFVUrvSOClHX7/lSK37xJk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lMVCov2WJtEzfwhFYXGZZc/SQ62oE6LAjCAI8VEFGbZcWRGGzu/sgPu5NRjNCVk627OmyYxBcvPQ6JWPel4uaHIC4iUTObL3F4m4xEtE1rig0YNvdDi5oQnclXRiQlIPjkeWOLg0kDofpnKUk9uPZGjKGUvnpgww0bzm7AM2oNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mJEGCWIt; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mJEGCWIt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720247102; x=1751783102;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=roIYcf7YeNI5tK4KPiAUUtFVUrvSOClHX7/lSK37xJk=;
  b=mJEGCWItRzSLQIuRb/mFuOT6jE68lxnzYXuMrunEwYt5zLQQDjECGl5M
   EgwpHJ/kgHEOq5QHt55gV3/PHZmNJD1uB6JJRr3s1+kXropH9MK7yVm/r
   KCGQgC0cUNaVVVgae8JWE5axabAc/shsbjBz4Xk71DiHHuiH4qaHD49hN
   bf55B+xJQyf1ZP83XGRbFYC5rbl7crP2CTcpf1yg52Az8byM0fVUn5/M+
   Ku90bBbgSzmNsNnEPpIqIA7ym+HXynSsy0tQkGoEAca7WT7IsRJ6lpTF9
   KPEA3P6+sbJsHD8eqT/Fz8EBVITKSbKBPdNAG2d9kdeRxIbsNAEWg+sKL
   g==;
X-CSE-ConnectionGUID: OE6HQZkeQJ+uTvGGL06tXA==
X-CSE-MsgGUID: b0AmoVrFTGq1tg7LGjYbyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="17166930"
X-IronPort-AV: E=Sophos;i="6.09,187,1716274800"; 
   d="scan'208";a="17166930"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2024 23:25:00 -0700
X-CSE-ConnectionGUID: ejVAxJL7SA+XVqDpLTXl1g==
X-CSE-MsgGUID: UzfHbPpSSAKbdMVYva4KTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,187,1716274800"; 
   d="scan'208";a="78172492"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.72.84])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2024 23:25:00 -0700
From: alison.schofield@intel.com
To: nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org
Cc: Alison Schofield <alison.schofield@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>
Subject: [ndctl PATCH v13 2/8] util/trace: add an optional pid check to event parsing
Date: Fri,  5 Jul 2024 23:24:48 -0700
Message-Id: <78e904ed934820f217f96d19603acf64e322184a.1720241079.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1720241079.git.alison.schofield@intel.com>
References: <cover.1720241079.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

When parsing events, callers may only be interested in events
that originate from the current process. Introduce an optional
argument to the event trace context: event_pid. When event_pid is
present, simply skip the parsing of events without a matching pid.
It is not a failure to see other, non matching events.

The initial use case for this is CXL device poison listings where
only the media-error records requested by this process are wanted.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 util/event_trace.c | 5 +++++
 util/event_trace.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/util/event_trace.c b/util/event_trace.c
index 16013412bc06..57318e2adace 100644
--- a/util/event_trace.c
+++ b/util/event_trace.c
@@ -214,6 +214,11 @@ static int event_parse(struct tep_event *event, struct tep_record *record,
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
diff --git a/util/event_trace.h b/util/event_trace.h
index 37c39aded871..6586e1dc254d 100644
--- a/util/event_trace.h
+++ b/util/event_trace.h
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

