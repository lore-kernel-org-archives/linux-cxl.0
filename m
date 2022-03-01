Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52345C433EF
	for <linux-cxl@archiver.kernel.org>; Tue,  1 Mar 2022 02:49:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbiCACt5 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 28 Feb 2022 21:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbiCACt4 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 28 Feb 2022 21:49:56 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8C04704B;
        Mon, 28 Feb 2022 18:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646102952; x=1677638952;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0g12nHhygb9mDTBwhhm5NizRvH7d3c8Rr3u2nwGyQZM=;
  b=hf9+oi5hrkF0ECMyRg+QnvmqMbop5Y1aCgLWTgFa5gyFzCZ5kN76KYIy
   TefVh4RlTrZKcwm+emLyf9eGfDqygMLiAFmt0Sx2+KvdU0fqLv91Sj9CY
   aNM8ISFqXUrlXwmCXQAoOT+yac/bN5mzrxfUVoCXYMxXYNuquokeXaQO0
   t+Lf7t49LusFjtb/lHAtQZ+vP33LnbvZPpRxBco2F754HG5sUBhL3Lz6v
   /b4lfs/FKH2XNOpiPdvslcKdU2KocasTD+6xz7jkrhoIvSB+TRf/vMRlk
   G1VIXZyhGghXt/J5errK4dqDuT6K9zrOzTBAkNf23Z9XHnhQaLuk8SZMm
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="252774048"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="252774048"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 18:49:12 -0800
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="507645813"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 18:49:11 -0800
Subject: [PATCH 04/11] cxl/core: Clamp max lock_class
From:   Dan Williams <dan.j.williams@intel.com>
To:     gregkh@linuxfoundation.org, rafael.j.wysocki@intel.com
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        nvdimm@lists.linux.dev
Date:   Mon, 28 Feb 2022 18:49:11 -0800
Message-ID: <164610295187.2682974.18123746840987009597.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164610292916.2682974.12924748003366352335.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164610292916.2682974.12924748003366352335.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

MAX_LOCKDEP_SUBCLASSES limits the depth of the CXL topology that can be
validated by lockdep. Given that the cxl_test topology is already at
this limit collapse some of the levels and clamp the max depth.

Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/cxl.h |   21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 97e6ca7e4940..1357a245037d 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -501,20 +501,33 @@ enum cxl_lock_class {
 	CXL_ANON_LOCK,
 	CXL_NVDIMM_LOCK,
 	CXL_NVDIMM_BRIDGE_LOCK,
-	CXL_PORT_LOCK,
+	CXL_PORT_LOCK = 2,
 	/*
 	 * Be careful to add new lock classes here, CXL_PORT_LOCK is
 	 * extended by the port depth, so a maximum CXL port topology
-	 * depth would need to be defined first.
+	 * depth would need to be defined first. Also, the max
+	 * validation depth is limited by MAX_LOCKDEP_SUBCLASSES.
 	 */
 };
 
+static inline int clamp_lock_class(struct device *dev, int lock_class)
+{
+	if (lock_class >= MAX_LOCKDEP_SUBCLASSES) {
+		dev_warn_once(dev,
+			      "depth: %d, disabling lockdep for this device\n",
+			      lock_class);
+		return 0;
+	}
+
+	return lock_class;
+}
+
 static inline int cxl_lock_class(struct device *dev)
 {
 	if (is_cxl_port(dev)) {
 		struct cxl_port *port = to_cxl_port(dev);
 
-		return CXL_PORT_LOCK + port->depth;
+		return clamp_lock_class(dev, CXL_PORT_LOCK + port->depth);
 	} else if (is_cxl_decoder(dev)) {
 		struct cxl_port *port = to_cxl_port(dev->parent);
 
@@ -522,7 +535,7 @@ static inline int cxl_lock_class(struct device *dev)
 		 * A decoder is the immediate child of a port, so set
 		 * its lock class equal to other child device siblings.
 		 */
-		return CXL_PORT_LOCK + port->depth + 1;
+		return clamp_lock_class(dev, CXL_PORT_LOCK + port->depth + 1);
 	} else if (is_cxl_nvdimm_bridge(dev))
 		return CXL_NVDIMM_BRIDGE_LOCK;
 	else if (is_cxl_nvdimm(dev))

