Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99803C433F5
	for <linux-cxl@archiver.kernel.org>; Mon, 24 Jan 2022 00:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240651AbiAXAw2 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 23 Jan 2022 19:52:28 -0500
Received: from mga01.intel.com ([192.55.52.88]:60680 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240634AbiAXAw0 (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Sun, 23 Jan 2022 19:52:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642985546; x=1674521546;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZNGHY0cT9LQDpRcqY5thPwqY3sGbSI02GaDkgIUyU8w=;
  b=QCadECg11/R17m5yQCPA/3riYKgBvE55NLfHa2UG1JBLFOet3nM1/yv/
   pJDnksAJ7aQAlwgt7zNMEcHm69IG4sJi0Wq4/kAE1GlwLARl2uVM6jyEl
   X4rLr4+YQwaAFJw7HcMItrX8SeGI0dXf7aONCqQS4eBY8S5OemnX5cE7j
   pKapAZRwhZGoU32mdnBf92yI02ZXMsG9td7vt5yrWp3ARxsdj7i9zcw6Z
   5S5qQmst/gpgYSE6TVK6d6D3S1zW4ADJE02EAgj96G1XKgtELjAGn07f1
   hy2rBIvFHMXcVlLL8sxFTJWSVcfs9Rut+HSOgCNCu8bJ7/adUH9nboHbu
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="270369960"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="270369960"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:52:26 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="627309169"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:52:26 -0800
Subject: [ndctl PATCH 07/37] cxl/list: Support comma separated lists
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Vishal Verma <vishal.l.verma@intel.com>
Date:   Sun, 23 Jan 2022 16:52:26 -0800
Message-ID: <164298554612.3021641.3315920699556984273.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164298550885.3021641.11210386002804544864.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164298550885.3021641.11210386002804544864.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

In addition to supporting a syntax like:

   cxl list -m "0 1 2"

...support:

   cxl list -m 0,1,2

Reported-by: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 cxl/filter.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/cxl/filter.c b/cxl/filter.c
index efafaf5a3197..405b653d80b2 100644
--- a/cxl/filter.c
+++ b/cxl/filter.c
@@ -6,6 +6,15 @@
 #include <cxl/libcxl.h>
 #include "filter.h"
 
+static const char *which_sep(const char *filter)
+{
+	if (strchr(filter, ' '))
+		return " ";
+	if (strchr(filter, ','))
+		return ",";
+	return " ";
+}
+
 struct cxl_memdev *util_cxl_memdev_filter(struct cxl_memdev *memdev,
 					  const char *__ident)
 {
@@ -20,8 +29,8 @@ struct cxl_memdev *util_cxl_memdev_filter(struct cxl_memdev *memdev,
 	if (!ident)
 		return NULL;
 
-	for (name = strtok_r(ident, " ", &save); name;
-	     name = strtok_r(NULL, " ", &save)) {
+	for (name = strtok_r(ident, which_sep(__ident), &save); name;
+	     name = strtok_r(NULL, which_sep(__ident), &save)) {
 		if (strcmp(name, "all") == 0)
 			break;
 

