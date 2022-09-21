Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE4AECAAD8
	for <linux-cxl@archiver.kernel.org>; Wed, 21 Sep 2022 21:02:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiIUVC4 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 21 Sep 2022 17:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiIUVCz (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 21 Sep 2022 17:02:55 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C008AA5724
        for <linux-cxl@vger.kernel.org>; Wed, 21 Sep 2022 14:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663794174; x=1695330174;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y30YXkRh4cbpEprKVR9xFEyO8hqXIzBu1K5s03TlUmg=;
  b=M97NOTXd01taWXQXqEu5qQIZouYxkns7ed3lcWcoqW0rnD04qbCzoLDj
   mgRD/U0uprP+ZaXY9ZivBcws2SJaWtA/Ard9dqAiXV92Ea+8Iz0kjqAi6
   7aAY9xUqTW1gQoP80dMCnSxk12q1TE6Yi+O845xXl4upU5LeYCLsZF6CS
   b0ucAV6B5f94PeKCyDzvCV3NzRrS4O2m6fHGdSg2bVRu+c5/hmAp5uXkt
   17oyj70vqZpOWrOHt1BAuMsLk4TnMzXxuCmH55TqRPX8q1Xw/NGPZuxTY
   WoVZupGOlKNqh61y0e9hQKY33cNadh+2YKJRf1J0eWCpenNMdVasLPJpt
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="287199716"
X-IronPort-AV: E=Sophos;i="5.93,334,1654585200"; 
   d="scan'208";a="287199716"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 14:02:54 -0700
X-IronPort-AV: E=Sophos;i="5.93,334,1654585200"; 
   d="scan'208";a="681934802"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 14:02:53 -0700
Subject: [PATCH 3/4] ndctl/libndctl: Add retrieving of unique_id for cxl mem
 dev
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev
Cc:     vishal.l.verma@intel.com
Date:   Wed, 21 Sep 2022 14:02:53 -0700
Message-ID: <166379417347.433612.4934530706825880453.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166379397620.433612.13099557870939895846.stgit@djiang5-desk3.ch.intel.com>
References: <166379397620.433612.13099557870939895846.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

With bus_prefix, retrieve the unique_id of cxl mem device. This will
allow selecting a specific cxl mem device for the security test code.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 ndctl/lib/libndctl.c |   28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
index d2e800bc840a..c569178b9a3a 100644
--- a/ndctl/lib/libndctl.c
+++ b/ndctl/lib/libndctl.c
@@ -1749,6 +1749,33 @@ NDCTL_EXPORT void ndctl_dimm_refresh_flags(struct ndctl_dimm *dimm)
 		parse_papr_flags(dimm, buf);
 }
 
+static int populate_cxl_dimm_attributes(struct ndctl_dimm *dimm,
+					const char *dimm_base)
+{
+	int rc = 0;
+	char buf[SYSFS_ATTR_SIZE];
+	struct ndctl_ctx *ctx = dimm->bus->ctx;
+	char *path = calloc(1, strlen(dimm_base) + 100);
+	const char *bus_prefix = dimm->bus_prefix;
+
+	if (!path)
+		return -ENOMEM;
+
+	sprintf(path, "%s/%s/id", dimm_base, bus_prefix);
+	if (sysfs_read_attr(ctx, path, buf) == 0) {
+		dimm->unique_id = strdup(buf);
+		if (!dimm->unique_id) {
+			rc = -ENOMEM;
+			goto err_read;
+		}
+	}
+
+ err_read:
+
+	free(path);
+	return rc;
+}
+
 static int populate_dimm_attributes(struct ndctl_dimm *dimm,
 				    const char *dimm_base)
 {
@@ -2018,6 +2045,7 @@ static void *add_dimm(void *parent, int id, const char *dimm_base)
 			rc = -ENOMEM;
 			goto out;
 		}
+		rc = populate_cxl_dimm_attributes(dimm, dimm_base);
 	}
 
 	if (rc == -ENODEV) {


