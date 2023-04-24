Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C13BC7EE20
	for <linux-cxl@archiver.kernel.org>; Mon, 24 Apr 2023 20:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbjDXUAA (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 24 Apr 2023 16:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232648AbjDXT7t (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 24 Apr 2023 15:59:49 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A26AA
        for <linux-cxl@vger.kernel.org>; Mon, 24 Apr 2023 12:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682366389; x=1713902389;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/hYsZFVbuB7rXLCiq+RG514NSTK5FRfnbKf2UZYDzDA=;
  b=c/qjsd5yoRLdrLLAdYpHltqXG9IppXyGt0ugNqZbz+9AvE46YcHrW1gr
   +h/oDkPdZQyaAwIO0hGWV+WvsqbLw0Z+nkIS7S6YsnixRwFee8Lvr5cIs
   mVpNwWbbZttw+siMkWYdkHLcEzR/poSjCKAkRu8GjFjD67zDfIZYAZvvp
   hemgN7uRMEZOnMpD+ENlmL4F6m9R2U3cKfKjN1fKY5l7w8bRCKdgRjqTr
   9/lYWwRpCk0LiQw9qQOUoXuuHwYBF75Cthkao6X4ub9iDfJk+bpyGq/dg
   SsH+EcJ0Skez8X8mXAGbMGre/LKIYceC8ZP5z1aEsW9gVHfFGyvPndnEy
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="326157375"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="326157375"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 12:59:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="670622085"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="670622085"
Received: from fbirang-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.88.12])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 12:59:48 -0700
Subject: [PATCH 3/4] test: Support test modules located in 'updates' instead
 of 'extra'
From:   Dan Williams <dan.j.williams@intel.com>
To:     vishal.l.verma@intel.com
Cc:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev
Date:   Mon, 24 Apr 2023 12:59:48 -0700
Message-ID: <168236638863.1027628.11883188611397194858.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <168236637159.1027628.7560967008080605819.stgit@dwillia2-xfh.jf.intel.com>
References: <168236637159.1027628.7560967008080605819.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Since kernel commit:

b74d7bb7ca24 ("kbuild: Modify default INSTALL_MOD_DIR from extra to updates")

...the kernel build process deposits the nfit_test can cxl_test modules in
/lib/modules/$KVER/updates. This is more widely supported across multiple
distributions as a default override for modules that ship in their native
directory.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 test/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/core.c b/test/core.c
index 5d1aa23723f1..a354f41dcba0 100644
--- a/test/core.c
+++ b/test/core.c
@@ -209,7 +209,7 @@ retry:
 			break;
 		}
 
-		if (!strstr(path, "/extra/")) {
+		if (!strstr(path, "/extra/") && !strstr(path, "/updates/")) {
 			log_err(&log_ctx, "%s.ko: appears to be production version: %s\n",
 					name, path);
 			break;

