Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C50C61DB3
	for <linux-cxl@archiver.kernel.org>; Tue, 10 Jan 2023 23:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbjAJXKA (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 10 Jan 2023 18:10:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234848AbjAJXJz (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 10 Jan 2023 18:09:55 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CDAA5566E
        for <linux-cxl@vger.kernel.org>; Tue, 10 Jan 2023 15:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673392194; x=1704928194;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=t2rn+Iy4jdDZV+5z4dc6ZLrjqjVRNl6oqWZfHBzRwBA=;
  b=U53m4qffQPdg5IwQjwZRJlqoPvwJcPSltiSHNMGuywPFWnzhBY/BTba6
   HWjqsKRIyICkSx1DKsE7z5fReH64BYgngEAjqRO6ciphcVsgWRioxKc0e
   HQlqWDNxjl2iHP55FNlq4M2fz1thR2PYQCBLuzKz/ihznjwRMKA1HvTsA
   ypvr8dhDcTBbvCdbLx8B8hpqW6nyNDUYo+1m2+5RR72UtbxE0SiXk9oV0
   dApysWPkIu2C83OD+2RGmi6252ZSbmdWXoNt+FkDJB3tc2hus8SMe99Yi
   OxEVTSaPEbOnJzrgA8Ccay/Gh772lZvBSjxBIihxfnoqOIbW4wsQPlhUb
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="321981267"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="321981267"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 15:09:52 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="659155907"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="659155907"
Received: from ffallaha-mobl.amr.corp.intel.com (HELO vverma7-desk1.local) ([10.212.116.179])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 15:09:52 -0800
From:   Vishal Verma <vishal.l.verma@intel.com>
Date:   Tue, 10 Jan 2023 16:09:15 -0700
Subject: [PATCH ndctl 2/4] cxl/region: fix a resource leak in to_csv()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230110-vv-coverity-fixes-v1-2-c7ee6c76b200@intel.com>
References: <20230110-vv-coverity-fixes-v1-0-c7ee6c76b200@intel.com>
In-Reply-To: <20230110-vv-coverity-fixes-v1-0-c7ee6c76b200@intel.com>
To:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev
Cc:     Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
X-Mailer: b4 0.12-dev-cc11a
X-Developer-Signature: v=1; a=openpgp-sha256; l=984;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=t2rn+Iy4jdDZV+5z4dc6ZLrjqjVRNl6oqWZfHBzRwBA=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDMl7P9jzLc3u1Z8pvcD56LEnYR6pE2Yk3PjykifSs+AH06TK
 ppKKjlIWBjEuBlkxRZa/ez4yHpPbns8TmOAIM4eVCWQIAxenAExEcDojw87Y75XR26fyRHLtVFdqTr
 A9ffBWspXkmsXvvyz/8eJY1QNGhg3JbBy/rzxmzuF2fynFJu20L29yA49FzdSmKWnGAlLXGAA=
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp;
 fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Static analysis reports there can be a memory leak in to_csv as an exit
path returns from the function before freeing 'csv'. Since this is the
only errpr path exit point after the allocation, just free() before
returning.

Fixes: 3d6cd829ec08 ("cxl/region: Use cxl_filter_walk() to gather create-region targets")
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 cxl/region.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/cxl/region.c b/cxl/region.c
index bb3a10a..9a81113 100644
--- a/cxl/region.c
+++ b/cxl/region.c
@@ -146,8 +146,10 @@ static const char *to_csv(int *count, const char **strings)
 		return NULL;
 	for (i = 0; i < *count; i++) {
 		list = strdup(strings[i]);
-		if (!list)
+		if (!list) {
+			free(csv);
 			return NULL;
+		}
 
 		for (arg = strtok_r(list, which_sep(list), &save); arg;
 		     arg = strtok_r(NULL, which_sep(list), &save)) {

-- 
2.39.0
