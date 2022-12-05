Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F849C4332F
	for <linux-cxl@archiver.kernel.org>; Mon,  5 Dec 2022 20:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbiLEUVn (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 5 Dec 2022 15:21:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbiLEUVm (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 5 Dec 2022 15:21:42 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B84A526560
        for <linux-cxl@vger.kernel.org>; Mon,  5 Dec 2022 12:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670271701; x=1701807701;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oRyH+Iy8pTXfDWv4ssBMMdEbCLOjHQz6sCDJR1RI+tY=;
  b=K0VN9JOmDvxynRclSCRLyMbVQWZP/iaAvNo2V7P/SrBHQyr80yLIYo2Y
   Q711HnIDXZsMaBMtOid1h28/xieuHqWiekPQp39gW5bPLjz7/iyfzHxZn
   f+si0lfMf9f1kyVT1ygdAmJfPpb1UQGuxxNAgb8AcZBDGBxvW0mUgfHdh
   +Ji7VnyP+qED2kTYzy5xonSuIKRyrj7YFJhv56syIJxzCgr6txhrARZs+
   zbx7W0Hx7OTcLEvEQ4ASmZ0BOigEILzZDk03tIBNBe6ysG//YTYc0CZAR
   ZTDbMUC94KJgwcTpDppL7qnkhvcZMm/p31wSstGI+H7ldPyvdqly4vgUP
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="343472331"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="343472331"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 12:21:41 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="891109070"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="891109070"
Received: from bmnebren-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.114.171])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 12:21:41 -0800
Subject: [PATCH] cxl/acpi: Warn about an invalid CHBCR in an existing CHBS
 entry
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Robert Richter <rrichter@amd.com>
Date:   Mon, 05 Dec 2022 12:21:40 -0800
Message-ID: <167027170051.3542509.10494781536638424397.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Robert Richter <rrichter@amd.com>

After parsing for a CHBCR in cxl_get_chbcr() the case of (ctx.chbcr ==
CXL_RESOURCE_NONE) is a slighly different error reason than the
!ctx.chbcr case. In the first case the CHBS was found but the CHBCR
was invalid or something else failed to determine it, while in the
latter case no CHBS entry exists at all.

Update the warning message to reflect this. The log messages for both
cases can be differentiated now and the reason for a failure can be
determined better.

Signed-off-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/acpi.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 420e322c85a1..f495f3ce45d1 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -455,7 +455,8 @@ static int add_host_bridge_dport(struct device *match, void *arg)
 		dev_dbg(match, "RCRB found for UID %lld: %pa\n", uid, &ctx.rcrb);
 
 	if (ctx.chbcr == CXL_RESOURCE_NONE) {
-		dev_warn(match, "No CHBS found for Host Bridge (UID %lld)\n", uid);
+		dev_warn(match, "CHBCR invalid for Host Bridge (UID %lld)\n",
+			 uid);
 		return 0;
 	}
 

