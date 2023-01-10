Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE62C54EBC
	for <linux-cxl@archiver.kernel.org>; Tue, 10 Jan 2023 23:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235071AbjAJXKA (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 10 Jan 2023 18:10:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234942AbjAJXJy (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 10 Jan 2023 18:09:54 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B612659514
        for <linux-cxl@vger.kernel.org>; Tue, 10 Jan 2023 15:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673392193; x=1704928193;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Gtf6WAW/csOf427X3LRR5XcQfg7g7JRMlkKoYsNZ8zk=;
  b=XGQHG+ZIssvH4ZhbWH5ZfXTZm6X/o71zNqppDr6lTvE2NSOWs+Qz8Sq1
   wCDbkRMZqnEsP+N7pAFYarwkUFDCQ6v969dCR0AMZvTrA3e4sAW7LKGrH
   TUtgsNU3R7p4ZraQUA2oBO1l54sgVY00vEbzV5FMnxCAVQkMzOiHDrk6S
   +KYSJQYMOU6qjarba83sSUSsHYg8A36Jc5Yqh/jLZZr0i/0bLCuXwLo1e
   FTV1Ah9J2EX4tjATEdJqyfYRlerQotLYlBY84EVuTmJAPPCmkOT8Mxgso
   L775xdd5BGa1Rdq3haxYgcaoqZZmn4vpClAWV+hagzQf87YlZrNiDP/Vy
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="321981265"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="321981265"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 15:09:52 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="659155904"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="659155904"
Received: from ffallaha-mobl.amr.corp.intel.com (HELO vverma7-desk1.local) ([10.212.116.179])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 15:09:52 -0800
From:   Vishal Verma <vishal.l.verma@intel.com>
Date:   Tue, 10 Jan 2023 16:09:14 -0700
Subject: [PATCH ndctl 1/4] ndctl/lib: fix usage of a non NUL-terminated string
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230110-vv-coverity-fixes-v1-1-c7ee6c76b200@intel.com>
References: <20230110-vv-coverity-fixes-v1-0-c7ee6c76b200@intel.com>
In-Reply-To: <20230110-vv-coverity-fixes-v1-0-c7ee6c76b200@intel.com>
To:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev
Cc:     Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
X-Mailer: b4 0.12-dev-cc11a
X-Developer-Signature: v=1; a=openpgp-sha256; l=872;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=Gtf6WAW/csOf427X3LRR5XcQfg7g7JRMlkKoYsNZ8zk=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDMl7P9irFeUyXWHr15r8dsMkn/UNJ6wnKFrKaMzPzi6K353o
 bvito5SFQYyLQVZMkeXvno+Mx+S25/MEJjjCzGFlAhnCwMUpABPRnMPwT/lQ6enUJdbypnX9c9Q9XX
 ZctvxccnjyacUlbnVd26euXwJU0a3cvUFfdS+DSUjX+/NFs5TP+j35525+ni37eI6prAcnAA==
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp;
 fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Static analysis reports that in add_region(), a buffer from pread()
won't have NUL-termination. Hence passing it to strtol subsequently can
be wrong. Manually add the termination after pread() to fix this.

Fixes: c64cc150a21e ("ndctl: add support in libndctl to provide deep flush")
Cc: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 ndctl/lib/libndctl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
index f32f704..ddbdd9a 100644
--- a/ndctl/lib/libndctl.c
+++ b/ndctl/lib/libndctl.c
@@ -2750,6 +2750,8 @@ static void *add_region(void *parent, int id, const char *region_base)
 		goto out;
 	}
 
+	/* pread() doesn't add NUL termination */
+	buf[1] = 0;
 	perm = strtol(buf, NULL, 0);
 	if (perm == 0) {
 		close(region->flush_fd);

-- 
2.39.0
