Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9383C54EBC
	for <linux-cxl@archiver.kernel.org>; Tue, 10 Jan 2023 23:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234339AbjAJXKD (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 10 Jan 2023 18:10:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234570AbjAJXJz (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 10 Jan 2023 18:09:55 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB29DEB7
        for <linux-cxl@vger.kernel.org>; Tue, 10 Jan 2023 15:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673392194; x=1704928194;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=P4hPdW8+bePoAaxzhoqscfaaJ238PGmVdQhKGufS+7Y=;
  b=bPkspPORTOYXqHYrSYOpr3bUUj1cfNzhmIjLOiO+U4snCbEayd8lJWBh
   BWZCISiAMEGXU1EMh0YpDiO+rMWEuWMAW2dwoeeINNfWDLAXYb65ST8LH
   TfOxe7qLZtzPXbGTzOlBdbhny12fLguP7yroNofFPp/pbJMJ/jmgu8ONb
   e2Xk/5iVcUG0al7tuR837EPG26sDqCjAlkA/ENOjfqXIy3EGHpPIfCNnV
   W8VYW/45Adr6ZZ0ujTQ459A8qUHaUzhECkDP8d4YyH88cCAihWw5F6pG9
   Z7UHagb9spaCEpRJOWY5RAw07AhtLX4eKmybmmvRM2z8AH0OgI92acIN2
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="321981273"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="321981273"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 15:09:53 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="659155916"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="659155916"
Received: from ffallaha-mobl.amr.corp.intel.com (HELO vverma7-desk1.local) ([10.212.116.179])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 15:09:52 -0800
From:   Vishal Verma <vishal.l.verma@intel.com>
Date:   Tue, 10 Jan 2023 16:09:17 -0700
Subject: [PATCH ndctl 4/4] cxl/region: fix a comment typo
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230110-vv-coverity-fixes-v1-4-c7ee6c76b200@intel.com>
References: <20230110-vv-coverity-fixes-v1-0-c7ee6c76b200@intel.com>
In-Reply-To: <20230110-vv-coverity-fixes-v1-0-c7ee6c76b200@intel.com>
To:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev
Cc:     Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
X-Mailer: b4 0.12-dev-cc11a
X-Developer-Signature: v=1; a=openpgp-sha256; l=813;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=P4hPdW8+bePoAaxzhoqscfaaJ238PGmVdQhKGufS+7Y=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDMl7P9j/r16f9PzrvM5ly4XUb3J2ZxTtZuTbwnm5JnjBxVsp
 WVtndpSyMIhxMciKKbL83fOR8Zjc9nyewARHmDmsTCBDGLg4BWAiRnMZGbY/O7iLP3LWkt25mcxZ5f
 eeaIaI9LgWVXoeyTju12Q5SZmR4eP8cx/tX2y9N29qZ8x+Zp6HG753JGTNqzpbs/dos26DJysA
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp;
 fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Fix a typo: s/separted/separated/

Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 cxl/region.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cxl/region.c b/cxl/region.c
index 89be9b5..efe05aa 100644
--- a/cxl/region.c
+++ b/cxl/region.c
@@ -103,7 +103,7 @@ static const struct option destroy_options[] = {
 
 /*
  * Convert an array of strings that can be a mixture of single items, a
- * command separted list, or a space separated list, into a flattened
+ * command separated list, or a space separated list, into a flattened
  * comma-separated string. That single string can then be used as a
  * filter argument to cxl_filter_walk(), or an ordering constraint for
  * json_object_array_sort()

-- 
2.39.0
