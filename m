Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90701C7EE24
	for <linux-cxl@archiver.kernel.org>; Wed, 10 May 2023 18:44:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjEJSov (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 10 May 2023 14:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236038AbjEJSos (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 10 May 2023 14:44:48 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5AC65A0
        for <linux-cxl@vger.kernel.org>; Wed, 10 May 2023 11:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683744275; x=1715280275;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=queWowh+a2U/UwG0y21u4XRP0gutO0bVFUA/7debRvg=;
  b=gnDY3WMFdt1GnOVq1iiiZRtDjCmPSd0nIk3SwHbm1CK030eCqltNLG7M
   EqoedN/OcJZfOK4d757UTPoALxBmC+98uSMo8PP0AHeFE00BtohmUN9hF
   909GXGaPhZzLC/h+HT8RaMyQyATv50lm19xL8ZWVKeAl5H/VzV3vJK3wJ
   EdGDp/Bn1Bse4/Xq9AZmZLgQJ4v8vtjHy+XWzNbrbWpiBikjjIZvAEH52
   h6iDgFtPLg/eKDzgLEL8zPZh2HANb8EY8GQmqRDTooUfaUCWJ0Bda9oHL
   oLpsJaVMhB4R/x+qVAqIH1A+gxAEjspZPIBqxCJUi6f/1caczXKbxdJ++
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="353370143"
X-IronPort-AV: E=Sophos;i="5.99,265,1677571200"; 
   d="scan'208";a="353370143"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2023 11:44:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="769004638"
X-IronPort-AV: E=Sophos;i="5.99,265,1677571200"; 
   d="scan'208";a="769004638"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.34.89])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2023 11:44:32 -0700
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [RFC 1/3] x86/numa: Introduce numa_find_node(start, end)
Date:   Wed, 10 May 2023 11:44:26 -0700
Message-Id: <6bf1866161446f03105ec50c3a09de194d830bc3.1683742429.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1683742429.git.alison.schofield@intel.com>
References: <cover.1683742429.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

phys_to_target_node(phys_addr_t start) returns a NUMA node id for
a single physical address. In order to discover if there is a NUMA
node assigned to any, in a range of addressses, there is no solution.

Repeatedly calling phys_to_target_node() from start/end is too
expensive to consider. Examining the numa memblks is nicer.

Introduce numa_find_node(start, end) to return the first NUMA node
found anywhere in the start/end HPA range.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 arch/x86/include/asm/numa.h |  1 +
 arch/x86/mm/numa.c          | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/x86/include/asm/numa.h b/arch/x86/include/asm/numa.h
index e3bae2b60a0d..5f2b811f1a5f 100644
--- a/arch/x86/include/asm/numa.h
+++ b/arch/x86/include/asm/numa.h
@@ -34,6 +34,7 @@ extern nodemask_t numa_nodes_parsed __initdata;
 
 extern int __init numa_add_memblk(int nodeid, u64 start, u64 end);
 extern void __init numa_set_distance(int from, int to, int distance);
+extern int __init numa_find_node(u64 start, u64 end);
 
 static inline void set_apicid_to_node(int apicid, s16 node)
 {
diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 2aadb2019b4f..62990977f720 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -225,6 +225,20 @@ static void __init alloc_node_data(int nid)
 	node_set_online(nid);
 }
 
+/* find node with any memblk start/end */
+int __init numa_find_node(u64 start, u64 end)
+{
+	struct numa_meminfo *mi = &numa_meminfo;
+
+	for (int i = 0; i < mi->nr_blks; i++) {
+		struct numa_memblk *bi = &mi->blk[i];
+
+		if (start <= bi->start && end >= bi->end)
+			return bi->nid;
+	}
+	return NUMA_NO_NODE;
+}
+
 /**
  * numa_cleanup_meminfo - Cleanup a numa_meminfo
  * @mi: numa_meminfo to clean up
-- 
2.37.3

