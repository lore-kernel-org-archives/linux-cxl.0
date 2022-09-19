Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0814FC6FA82
	for <linux-cxl@archiver.kernel.org>; Mon, 19 Sep 2022 23:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiISXrB (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 19 Sep 2022 19:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbiISXq7 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 19 Sep 2022 19:46:59 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B244F3BB
        for <linux-cxl@vger.kernel.org>; Mon, 19 Sep 2022 16:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663631219; x=1695167219;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jj/klAsednkgzjq3ps6XLuoWHoRTcKi+tAqH8UUDsqQ=;
  b=i+zrkz26sYT7w4BuXTa+cLanXB6hZrfgljRu9ObbYZURvjn4RfyDcoVK
   k8usmUoiiddIYc+X1kUO6LV544PGV1jCYb/SUKBnZyMVv1j+0DkHUzxw4
   8WGLNAdBLSiuPcC5xIc3cU5c1kTSOMsQSznnfu0fKQ0lhsws9WIp6YqIa
   EJfH12dOjCiViE4ZccCZ/8PsEKlKMGEG7aphKNfl/bZPhPcCGObVi79Za
   927IBIO6jeXj0soNL9CZcAvb6e7wM9kNxbIZaiJnZVJHWvk1gqObno9Wy
   Gnss3zlb0r/9ewQHDtG8BypssrbEGRmDHbs2usIVdTfXwT9sGxy0tIdyn
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="279278331"
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; 
   d="scan'208";a="279278331"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 16:46:58 -0700
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; 
   d="scan'208";a="618690412"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 16:46:58 -0700
Subject: [PATCH v2 4/9] cxl: add common function to disable event trace
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, dan.j.williams@intel.com,
        nafonten@amd.com, nvdimm@lists.linux.dev
Date:   Mon, 19 Sep 2022 16:46:57 -0700
Message-ID: <166363121739.3861186.14270734583823747080.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166363103019.3861186.3067220004819656109.stgit@djiang5-desk3.ch.intel.com>
References: <166363103019.3861186.3067220004819656109.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Add a common function for cxl command that disables the event trace for the
instance created.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 cxl/event_trace.c |    8 ++++++++
 cxl/event_trace.h |    1 +
 2 files changed, 9 insertions(+)

diff --git a/cxl/event_trace.c b/cxl/event_trace.c
index ca2fb94f2eba..33d6812510a3 100644
--- a/cxl/event_trace.c
+++ b/cxl/event_trace.c
@@ -218,3 +218,11 @@ int cxl_event_tracing_enable(struct tracefs_instance *inst, const char *system)
 	tracefs_trace_on(inst);
 	return 0;
 }
+
+int cxl_event_tracing_disable(struct tracefs_instance *inst)
+{
+	if (!tracefs_trace_is_on(inst))
+		return 0;
+
+	return tracefs_trace_off(inst);
+}
diff --git a/cxl/event_trace.h b/cxl/event_trace.h
index 1fb905664625..9aafa942bbb2 100644
--- a/cxl/event_trace.h
+++ b/cxl/event_trace.h
@@ -18,5 +18,6 @@ struct event_ctx {
 
 int cxl_parse_events(struct tracefs_instance *inst, struct event_ctx *ectx);
 int cxl_event_tracing_enable(struct tracefs_instance *inst, const char *system);
+int cxl_event_tracing_disable(struct tracefs_instance *inst);
 
 #endif


