Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E34C433F5
	for <linux-cxl@archiver.kernel.org>; Thu, 28 Apr 2022 23:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350389AbiD1X6F (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 28 Apr 2022 19:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbiD1X6F (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 28 Apr 2022 19:58:05 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204D3B3DCF
        for <linux-cxl@vger.kernel.org>; Thu, 28 Apr 2022 16:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651190089; x=1682726089;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9ghc5xys4b5mMhFTJ7wpef3dneV4GyoA6BP0qu8W56o=;
  b=XenYEgd5P4m2iE5sI3WB7+tbmWn0h8kaEG3ORFayQThrGJQvN/A1QhoA
   FsDDgPL/6WlHtQ3QojzuScIZdHZg3/6rgBh0ksiD6YwUuDpRhwADKLOl1
   UkLzrtQs/uJfAbfqLRx0w46DIfpY9akLNyGiyPkhfxHbYSEPeXIqSSQlX
   pewt/AeoPrX/oQKf03mpb4vI9AizLtfa5EuZa21ZC6RQNyAwNJBc5VTpC
   ECqG3Yaua/1jQDjnf+ksCszQaygG6rjkZ2OI0EFbv5yYmAY5hpXuhZXK9
   T6hmdg8KBSFn742oVYR9JwE1mFtAQKftqH5XvulzLptBXtHW+PGDA4DOU
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="266280637"
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="266280637"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 16:54:48 -0700
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="581720253"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 16:54:48 -0700
Subject: [ndctl PATCH] ndctl/dimm: Flush invalidated labels after overwrite
From:   Dan Williams <dan.j.williams@intel.com>
To:     vishal.l.verma@intel.com
Cc:     Jeff Moyer <jmoyer@redhat.com>, Dave Jiang <dave.jiang@intel.com>,
        linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev
Date:   Thu, 28 Apr 2022 16:54:48 -0700
Message-ID: <165119008839.1783158.3766085644383173318.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Similar to "ndctl write-labels", after "ndctl sanitize-dimm --overwrite"
the kernel may contain a cached copy of the label area that has been
invalidated by the overwrite. Toggle the enabled state of the dimm-device
to trigger the kernel to release the cached copy.

Cc: Jeff Moyer <jmoyer@redhat.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Link: https://lore.kernel.org/all/165118817010.1772793.5101398830527716084.stgit@dwillia2-desk3.amr.corp.intel.com/
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 ndctl/dimm.c |   34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/ndctl/dimm.c b/ndctl/dimm.c
index d9718a33b22f..ac7c5270e971 100644
--- a/ndctl/dimm.c
+++ b/ndctl/dimm.c
@@ -354,6 +354,23 @@ static int rw_bin(FILE *f, struct ndctl_cmd *cmd, ssize_t size,
 	return 0;
 }
 
+static int revalidate_labels(struct ndctl_dimm *dimm)
+{
+	int rc;
+
+	/*
+	 * If the dimm is already disabled the kernel is not holding a cached
+	 * copy of the label space.
+	 */
+	if (!ndctl_dimm_is_enabled(dimm))
+		return 0;
+
+	rc = ndctl_dimm_disable(dimm);
+	if (rc)
+		return rc;
+	return ndctl_dimm_enable(dimm);
+}
+
 static int action_write(struct ndctl_dimm *dimm, struct action_context *actx)
 {
 	struct ndctl_cmd *cmd_read, *cmd_write;
@@ -377,18 +394,10 @@ static int action_write(struct ndctl_dimm *dimm, struct action_context *actx)
 
 	size = ndctl_cmd_cfg_read_get_size(cmd_read);
 	rc = rw_bin(actx->f_in, cmd_write, size, param.offset, WRITE);
-
-	/*
-	 * If the dimm is already disabled the kernel is not holding a cached
-	 * copy of the label space.
-	 */
-	if (!ndctl_dimm_is_enabled(dimm))
-		goto out;
-
-	rc = ndctl_dimm_disable(dimm);
 	if (rc)
 		goto out;
-	rc = ndctl_dimm_enable(dimm);
+
+	rc = revalidate_labels(dimm);
 
  out:
 	ndctl_cmd_unref(cmd_read);
@@ -1043,7 +1052,7 @@ static int action_security_freeze(struct ndctl_dimm *dimm,
 static int action_sanitize_dimm(struct ndctl_dimm *dimm,
 		struct action_context *actx)
 {
-	int rc;
+	int rc = 0;
 	enum ndctl_key_type key_type;
 
 	if (ndctl_dimm_get_security(dimm) < 0) {
@@ -1085,9 +1094,10 @@ static int action_sanitize_dimm(struct ndctl_dimm *dimm,
 		rc = ndctl_dimm_overwrite_key(dimm);
 		if (rc < 0)
 			return rc;
+		rc = revalidate_labels(dimm);
 	}
 
-	return 0;
+	return rc;
 }
 
 static int action_wait_overwrite(struct ndctl_dimm *dimm,

