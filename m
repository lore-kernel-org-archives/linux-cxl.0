Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDBAC77B7C
	for <linux-cxl@archiver.kernel.org>; Wed, 10 May 2023 18:44:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235987AbjEJSou (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 10 May 2023 14:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjEJSot (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 10 May 2023 14:44:49 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325812D59
        for <linux-cxl@vger.kernel.org>; Wed, 10 May 2023 11:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683744276; x=1715280276;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HwzxLzZHwXP/JxDwYJyWdZLl983+BiFLh6gVRvAii8c=;
  b=WlEzew1axwkBbDHHBCvN02M95DRjrZmiTCrw90qOxOOe2XhXp9UoiZKW
   67UXFM9Wmjhrgb95cJQFZYzLfXN0RWsKql3JuwBpD25cI5+iC7jUc41UO
   Ps+wSJtkmB7ChdV/OrywVClaa38jJ4UqkP4gkAOi33QMHViTyTuFb74FG
   cdcXf4/w8BDoat/LeOqJYROXPQ8EK29raRq8k+PaCVQTM2A/m61LKPERv
   0jGgBtpQ/c/rtDl5/UcOGaSclmWxTBEQnXSbvUv6iY2MHtYoGkmjd9Dzj
   iL2CIhEXpNttsTIRRo/RfyFem6v6ZaC3ZdmReTN5bgRaxxJRRkwnKhMtT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="353370151"
X-IronPort-AV: E=Sophos;i="5.99,265,1677571200"; 
   d="scan'208";a="353370151"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2023 11:44:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="769004646"
X-IronPort-AV: E=Sophos;i="5.99,265,1677571200"; 
   d="scan'208";a="769004646"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.34.89])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2023 11:44:33 -0700
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [RFC 2/3] x86/numa: Introduce numa_remove_memblks(node, start, end)
Date:   Wed, 10 May 2023 11:44:27 -0700
Message-Id: <57bc9bb8823a295dc71d7e8ff8ae93a3af8c0be3.1683742429.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1683742429.git.alison.schofield@intel.com>
References: <cover.1683742429.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

Add support for removing memblks from numa_meminfo that are
within a start/end range, and of a node.

numa_add_memblk() allows in kernel users to add a memblk to
a NUMA node. There is no method exposed to remove a memblk.

The use case here is to allow the ACPI driver to remove
redundant memblks when it knows they exist, rather than
implementing a cleanup that needlessly walks all memblks
during a cleanup phase.

numa_cleanup_meminfo() exists for merging memblks, however,
it only considers adjacent memblks, and, it actually moves the
memblks to numa_reserved_meminfo, before doing the cleanup.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 arch/x86/include/asm/numa.h |  1 +
 arch/x86/mm/numa.c          | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/arch/x86/include/asm/numa.h b/arch/x86/include/asm/numa.h
index 5f2b811f1a5f..cb8b9a8cae32 100644
--- a/arch/x86/include/asm/numa.h
+++ b/arch/x86/include/asm/numa.h
@@ -35,6 +35,7 @@ extern nodemask_t numa_nodes_parsed __initdata;
 extern int __init numa_add_memblk(int nodeid, u64 start, u64 end);
 extern void __init numa_set_distance(int from, int to, int distance);
 extern int __init numa_find_node(u64 start, u64 end);
+extern void __init numa_remove_memblks(int node, u64 start, u64 end);
 
 static inline void set_apicid_to_node(int apicid, s16 node)
 {
diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 62990977f720..42d70f01ca0a 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -239,6 +239,28 @@ int __init numa_find_node(u64 start, u64 end)
 	return NUMA_NO_NODE;
 }
 
+/**
+ * numa_remove_memblks - Remove memblocks from a node
+ * @node: node
+ * @start: start addr of memblks to remove
+ * @end: end addr of memblks to remove
+ *
+ * Remove any memblks of node within start/end range
+ */
+void __init numa_remove_memblks(int node, u64 start, u64 end)
+{
+	struct numa_meminfo *mi = &numa_meminfo;
+
+	for (int i = 0; i < mi->nr_blks; i++) {
+		struct numa_memblk *bi = &mi->blk[i];
+
+		if (bi->nid != node)
+			continue;
+		if (start <= bi->start && end >= bi->end)
+			numa_remove_memblk_from(i--, &numa_meminfo);
+	}
+}
+
 /**
  * numa_cleanup_meminfo - Cleanup a numa_meminfo
  * @mi: numa_meminfo to clean up
-- 
2.37.3

