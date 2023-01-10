Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE9AC46467
	for <linux-cxl@archiver.kernel.org>; Tue, 10 Jan 2023 23:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235153AbjAJXKB (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 10 Jan 2023 18:10:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235068AbjAJXJz (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 10 Jan 2023 18:09:55 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F5A5951B
        for <linux-cxl@vger.kernel.org>; Tue, 10 Jan 2023 15:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673392194; x=1704928194;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=mL6lmpUYl41ULhtrwC9KKvuRtlC9LZqv9zJejcRxHKI=;
  b=MYKpfl+5038HGEZGym8ke5hCeJAedJUleond+Z+gmCV/Pffs0eTC3Oqi
   TBFFIQNFFAZR7zz2ZG5mjdjGPGsuymizgRyDn6b6EtqO6hA+ItXwbcf2S
   EU/4yWVnqQSwlQgW8Uo3BSwzA49O4Fyi0dgdNqjQ/iKmHJIROzJX51v7J
   FwM0lZhpNWTnFj4i007/B0lqw9Hq3DydcgQQFICVZdK/3qaWpgZjA5ZDu
   JjceIIls0lgAJ5+IhrOf9P0Jz8M26hxKoPnAQhhdoq0qDch595k7flG0N
   MWJNbhvrtZLMkvSwxcRoBQrvSprpzrVj5eLmNYjWB9gnR2PRRqpkEcGRU
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="321981272"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="321981272"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 15:09:53 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="659155910"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="659155910"
Received: from ffallaha-mobl.amr.corp.intel.com (HELO vverma7-desk1.local) ([10.212.116.179])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 15:09:52 -0800
From:   Vishal Verma <vishal.l.verma@intel.com>
Date:   Tue, 10 Jan 2023 16:09:16 -0700
Subject: [PATCH ndctl 3/4] cxl/region: fix an out of bounds access in to_csv()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230110-vv-coverity-fixes-v1-3-c7ee6c76b200@intel.com>
References: <20230110-vv-coverity-fixes-v1-0-c7ee6c76b200@intel.com>
In-Reply-To: <20230110-vv-coverity-fixes-v1-0-c7ee6c76b200@intel.com>
To:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev
Cc:     Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
X-Mailer: b4 0.12-dev-cc11a
X-Developer-Signature: v=1; a=openpgp-sha256; l=943;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=mL6lmpUYl41ULhtrwC9KKvuRtlC9LZqv9zJejcRxHKI=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDMl7P9i71vl8ObSwPOnXlmuyv2yt/Z9MWTHb5+5O3axzGi5H
 62f1d5SyMIhxMciKKbL83fOR8Zjc9nyewARHmDmsTCBDGLg4BWAitb8YGQ6c2zHdzpLbs1ezdop3+4
 TVx3fLHuqO+hc5xYXzUnZssRUjw6TFNt9nfPX/1ZawhNnqZ/vr1QdfP6mwcXmxb/PStuAF51gA
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp;
 fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Static analysis reports that when 'csv' is allocated for 'len' bytes,
writing to csv[len] results in an out of bounds access. Fix this
truncation operation to instead write the NUL terminator to csv[len -
1], which is the last byte of the memory allocated.

Fixes: 3d6cd829ec08 ("cxl/region: Use cxl_filter_walk() to gather create-region targets")
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 cxl/region.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cxl/region.c b/cxl/region.c
index 9a81113..89be9b5 100644
--- a/cxl/region.c
+++ b/cxl/region.c
@@ -156,7 +156,7 @@ static const char *to_csv(int *count, const char **strings)
 			cursor += snprintf(csv + cursor, len - cursor, "%s%s",
 					   arg, i + 1 < new_count ? "," : "");
 			if (cursor >= len) {
-				csv[len] = 0;
+				csv[len - 1] = 0;
 				break;
 			}
 		}

-- 
2.39.0
