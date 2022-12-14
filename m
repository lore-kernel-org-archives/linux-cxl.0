Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B760C4332F
	for <linux-cxl@archiver.kernel.org>; Wed, 14 Dec 2022 00:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237456AbiLNA0F (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 13 Dec 2022 19:26:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237346AbiLNAZ5 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 13 Dec 2022 19:25:57 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A2313D11
        for <linux-cxl@vger.kernel.org>; Tue, 13 Dec 2022 16:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670977546; x=1702513546;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JquNgRK/UoSKHUyZvjaqtUYZHzjpaqkSLJvYYN00Fck=;
  b=CsPGjtZzED/tziQrFP+SLg5eo+ZHFkaQB8Sw7Z7kuoYU27MsNjmYfBkI
   Nk/fz+szy/sCVcyrdBHmgWyLNS03vB0S552ap5MS8d4NNqghAsOjSHRRH
   fs6q+mpkROn+J40PklVkTvZzxMocbgJTsj4UcEnoMHeAbFbPU53VVI6Fa
   m7jFXu4wmNzVWIPnTi+c+u8xn8OEpLCSNvPkROuLGMwiI/qn5AuVZXZO6
   7FY/9cGGzUWjIr9vc6vRj+3lU9e5oLjlRgR0OdxZONDFutLpiIpu00PyS
   4vW55QgFdB8+1sRdvRqWkeg4kA4G88vUtX5yK8Q8BOBsLrOLEr+oODKD0
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="404540195"
X-IronPort-AV: E=Sophos;i="5.96,242,1665471600"; 
   d="scan'208";a="404540195"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 16:25:44 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="823084761"
X-IronPort-AV: E=Sophos;i="5.96,242,1665471600"; 
   d="scan'208";a="823084761"
Received: from mesplin-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.37.170])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 16:25:43 -0800
Subject: [ndctl PATCH 4/5] cxl/test: Fix cxl-topology.sh expectations
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     vishal.l.verma@intel.com, vishal.l.verma@intel.com,
        patches@lists.linux.dev
Date:   Tue, 13 Dec 2022 16:25:43 -0800
Message-ID: <167097754348.1189953.15721727640159522971.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <167097752151.1189953.3189708700022130101.stgit@dwillia2-xfh.jf.intel.com>
References: <167097752151.1189953.3189708700022130101.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

When cxl_test includes an RCD there will be 4 host-bridge and 11 memdevs
adjust the test expectations accodingly.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 test/cxl-topology.sh |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/test/cxl-topology.sh b/test/cxl-topology.sh
index fc3bbbe6b84a..89d01a89ccb1 100644
--- a/test/cxl-topology.sh
+++ b/test/cxl-topology.sh
@@ -117,7 +117,8 @@ fi
 # pmem size of 256M, or 1G
 json=$($CXL list -b cxl_test -M)
 count=$(jq "map(select(.pmem_size == $pmem_size)) | length" <<< $json)
-((bridges == 2 && count == 8 || bridges == 3 && count == 10)) || err "$LINENO"
+((bridges == 2 && count == 8 || bridges == 3 && count == 10 ||
+  bridges == 4 && count == 11)) || err "$LINENO"
 
 
 # check that switch ports disappear after all of their memdevs have been

