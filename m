Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2670DC25B06
	for <linux-cxl@archiver.kernel.org>; Fri,  5 Aug 2022 20:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234198AbiHEU1t (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 5 Aug 2022 16:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241265AbiHEU1s (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 5 Aug 2022 16:27:48 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513841EAD7
        for <linux-cxl@vger.kernel.org>; Fri,  5 Aug 2022 13:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659731267; x=1691267267;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PefBthYFNcXmD0ngjLtBQzW6Hi3DAaM/+fOCkGKfQyA=;
  b=RBCmCuzBHxO9n/JcLJ3Y0acQIS5Ae3XD3si/mwXgL6ljOMv8nJdv0HVS
   KmzqOvpLN1rdU3sEj4Yc1PBjcopfHgy9IELouzNs1aMSvPoTPXs9/UIAS
   hhnkcf1nLsCCBJv1W55yFVpkEGyZJxSSVCmH5V/a1//m/UWupw58bcYCO
   NQBnkW52Jtw5Q3yACLmuJ+jZzlldeikrj9ddoiRRGU91oMpAX/gz1PwZ5
   sfG8+pb5HtbG+XIWledqRjNx7MB7l4PIVdo+Jvm3+pgazWdf1uUVTg1JT
   HprBZ/xIg/dc8wmzeG4EqbXPASFkOAWg42RaLxBlS7jjLSk7t4lyK9vcl
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="273331425"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="273331425"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 13:27:46 -0700
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="663123821"
Received: from jivaldiv-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.255.228.201])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 13:27:46 -0700
Subject: [PATCH v2 2/3] cxl/region: Fix x1 interleave to greater than x1
 interleave routing
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        vishal.l.verma@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, alison.schofield@intel.com,
        dave.jiang@intel.com
Date:   Fri, 05 Aug 2022 13:27:45 -0700
Message-ID: <165973126583.1526540.657948655360009242.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <165973125417.1526540.14425647258796609596.stgit@dwillia2-xfh.jf.intel.com>
References: <165973125417.1526540.14425647258796609596.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

In cases where the decode fans out as it traverses downstream, the
interleave granularity needs to increment to identify the port selector
bits out of the remaining address bits. For example, recall that with an
x2 parent port intereleave (IW == 1), the downstream decode for children
of those ports will either see address bit IG+8 always set, or address
bit IG+8 always clear. So if the child port needs to select a downstream
port it can only use address bits starting at IG+9 (where IG and IW are
the CXL encoded values for interleave granularity (ilog2(ig) - 8) and
ways (ilog2(iw))).

When the parent port interleave is x1 no such masking occurs and the
child port can maintain the granularity that was routed to the parent
port.

Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/region.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index e71077beb021..641bc6344a4a 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1025,7 +1025,11 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 		return rc;
 	}
 
-	if (cxl_rr->nr_targets > 1) {
+	/*
+	 * If @parent_port is masking address bits, pick the next unused address
+	 * bit to route @port's targets.
+	 */
+	if (parent_iw > 1 && cxl_rr->nr_targets > 1) {
 		u32 address_bit = max(peig + peiw, eiw + peig);
 
 		eig = address_bit - eiw + 1;

