Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E41FC43219
	for <linux-cxl@archiver.kernel.org>; Mon,  3 Jan 2022 20:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbiACULg (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 3 Jan 2022 15:11:36 -0500
Received: from mga12.intel.com ([192.55.52.136]:35292 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229472AbiACULe (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 3 Jan 2022 15:11:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641240694; x=1672776694;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jAsYLLBNz+SUKss7Qz28lVyYvm19aggyMmIkH5M2KtU=;
  b=S8y3rgcCnlr6tP69JZDhkIUhfImB4BCZEAjO9q1EOxlXbZ5IEWAsOY/s
   LW7zozTago4JDo0rwfXtcPGKJoCsd0thTqf+It7MWqWJGgTXu5bxk3Xks
   KcWpMmXpavwqSVpGAcwrczYVWkPLCSilSX8kb1HOgcVhBNrCG0UJEhp7J
   zQZtEqjmPpQXzWJq8k9qs0o8iqzW5pa8ahOdh9pu4Hn8iDTZnQoqSaLjq
   OVmyHFextVLbPnAZY7Zwbcq28f07+XZ1Pd2z1k39dzXBemkqDDgL7+xBm
   6hehMU3Jk11CSAdJqRUrpG0Is3SuLO3Dwar0LqUr5Zot3mVJ2NjFGpldY
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10216"; a="222105780"
X-IronPort-AV: E=Sophos;i="5.88,258,1635231600"; 
   d="scan'208";a="222105780"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2022 12:11:34 -0800
X-IronPort-AV: E=Sophos;i="5.88,258,1635231600"; 
   d="scan'208";a="525709408"
Received: from alison-desk.jf.intel.com (HELO localhost) ([10.54.74.41])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2022 12:11:33 -0800
From:   alison.schofield@intel.com
To:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org
Subject: [ndctl PATCH 6/7] ndctl, util: use 'unsigned long long' type in OPT_U64 define
Date:   Mon,  3 Jan 2022 12:16:17 -0800
Message-Id: <4653004cf532c2e14f79a45bddf0ebaac09ef4e6.1641233076.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1641233076.git.alison.schofield@intel.com>
References: <cover.1641233076.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

The OPT_U64 define failed in check_vtype() with unknown 'u64' type.
Replace with 'unsigned long long' to make the OPT_U64 define usable.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 util/parse-options.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/parse-options.h b/util/parse-options.h
index 9318fe7..91b7932 100644
--- a/util/parse-options.h
+++ b/util/parse-options.h
@@ -124,7 +124,7 @@ struct option {
 #define OPT_INTEGER(s, l, v, h)     { .type = OPTION_INTEGER, .short_name = (s), .long_name = (l), .value = check_vtype(v, int *), .help = (h) }
 #define OPT_UINTEGER(s, l, v, h)    { .type = OPTION_UINTEGER, .short_name = (s), .long_name = (l), .value = check_vtype(v, unsigned int *), .help = (h) }
 #define OPT_LONG(s, l, v, h)        { .type = OPTION_LONG, .short_name = (s), .long_name = (l), .value = check_vtype(v, long *), .help = (h) }
-#define OPT_U64(s, l, v, h)         { .type = OPTION_U64, .short_name = (s), .long_name = (l), .value = check_vtype(v, u64 *), .help = (h) }
+#define OPT_U64(s, l, v, h)         { .type = OPTION_U64, .short_name = (s), .long_name = (l), .value = check_vtype(v, unsigned long long *), .help = (h) }
 #define OPT_STRING(s, l, v, a, h)   { .type = OPTION_STRING,  .short_name = (s), .long_name = (l), .value = check_vtype(v, const char **), (a), .help = (h) }
 #define OPT_FILENAME(s, l, v, a, h) { .type = OPTION_FILENAME, .short_name = (s), .long_name = (l), .value = check_vtype(v, const char **), (a), .help = (h) }
 #define OPT_DATE(s, l, v, h) \
-- 
2.31.1

