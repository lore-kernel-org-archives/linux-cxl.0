Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDD1C636D6
	for <linux-cxl@archiver.kernel.org>; Sat, 18 Feb 2023 00:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjBRApb (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 17 Feb 2023 19:45:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjBRApX (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 17 Feb 2023 19:45:23 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7889953818
        for <linux-cxl@vger.kernel.org>; Fri, 17 Feb 2023 16:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676681091; x=1708217091;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=9UeQUR+hYc76x7YfmfwMiEJR1+Ro6FeZ9RipZ0udPiY=;
  b=iUe8jc2QwijtlU/ZDcuyoNm2NtDA0odBfc4syymg4F7Z8bPB34RAkmX6
   QQnsT2u6zOdquLfkfeS1nMLE7XWvrCQf5Ogjw2NM8wx8AcefkaIsmrsXM
   F5puc4AzXANGeZBcashBqAqD9EivUWVj9Xwaw7Fg19BD6BqHMjrxupNaf
   c8l/Ci+Z/y88fAJGp32o6EMuUffDsV0qtIEwPpwmtMU10FN4iC9u7ToGv
   03yr2mbH/LlHjUYwQxsERIWOaPagbil3FmrZersnL/jM7YbYCchK2N2h+
   1i4P7RVG0/FRMp2PHThqaQ5sfuDnT6+B4yIzrmIdNYaUO+0oprp2r/uNP
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="311754224"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="311754224"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 16:40:32 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="844749005"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="844749005"
Received: from basavana-mobl.amr.corp.intel.com (HELO vverma7-desk1.local) ([10.209.2.127])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 16:40:32 -0800
From:   Vishal Verma <vishal.l.verma@intel.com>
Date:   Fri, 17 Feb 2023 17:40:23 -0700
Subject: [PATCH ndctl 2/3] cxl/monitor: retain error code in
 monitor_event()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230217-coverity-fixes-v1-2-043fac896a40@intel.com>
References: <20230217-coverity-fixes-v1-0-043fac896a40@intel.com>
In-Reply-To: <20230217-coverity-fixes-v1-0-043fac896a40@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     nvdimm@lists.linux.dev, Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
X-Mailer: b4 0.13-dev-ada30
X-Developer-Signature: v=1; a=openpgp-sha256; l=1113;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=9UeQUR+hYc76x7YfmfwMiEJR1+Ro6FeZ9RipZ0udPiY=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDMkf5Oq7Dz7oPdK202man3ff7srrsX2e1t6rzix8utVA3
 9vz82r9jlIWBjEuBlkxRZa/ez4yHpPbns8TmOAIM4eVCWQIAxenAEzk5U6Gf6o3Ox4vXb1mb3bk
 bcl1SXfSZE2vme8+HnE4SuMZb/+CjXcY/lfYH5H58mD1Nb0LU9ze3eKatvb1V8tFhz1ObRK4WXX
 Dt58BAA==
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp;
 fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Static analysis reports that the error unwinding path in monitor_event()
overwrites 'rc' with the return from cxl_event_tracing_disable(). This
masks the actual error code from either epoll_wait() or
cxl_parse_events() which is the one that should be propagated.

Print a spot error in case there's an error while disabling tracing, but
otherwise retain the rc from the main body of the function.

Fixes: 299f69f974a6 ("cxl/monitor: add a new monitor command for CXL trace events")
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 cxl/monitor.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/cxl/monitor.c b/cxl/monitor.c
index 31e6f98..749f472 100644
--- a/cxl/monitor.c
+++ b/cxl/monitor.c
@@ -130,7 +130,8 @@ static int monitor_event(struct cxl_ctx *ctx)
 	}
 
 parse_err:
-	rc = cxl_event_tracing_disable(inst);
+	if (cxl_event_tracing_disable(inst) < 0)
+		err(&monitor, "failed to disable tracing\n");
 event_en_err:
 epoll_ctl_err:
 	close(fd);

-- 
2.39.1

