Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC837C433F5
	for <linux-cxl@archiver.kernel.org>; Thu, 28 Apr 2022 22:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbiD1WNe (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 28 Apr 2022 18:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352787AbiD1WNe (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 28 Apr 2022 18:13:34 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B2825EB3
        for <linux-cxl@vger.kernel.org>; Thu, 28 Apr 2022 15:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651183817; x=1682719817;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nfv2zG5A8V35hocGwBFBf7FQQxSyBEnkJuli4Ie8N4s=;
  b=AwjWn+JUs2fHCziwcFzos9M8wjlxXHH0BvsQHY5kBCki55tZ1G0F9woH
   dyzZ/SSzp/uQUn26HPJan3GyyfhjMFQH3kZllGj7f6um9Qw1J+mjmeKmZ
   YVe7HoDfgagKiv3gANnH1kL4v1E0Pw1JcVIdjRW3UWvDnA1Jhz25xC5bH
   jZxRLln2nVrKNY1N0rpL5+sBM9ZNdmPO6b/66MmNAUls743Q3J0KgMek0
   3hbkZ+ggfLMTlK7GSbi5YFawxqdxg7x1mqOPMMdxiBdOnbrxaa5G35qca
   sfmnqePwaIi7mHzEHFRLZDC/2sIGp5eBsYAwJrmiHQXDtYQJZz7TY8vU9
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="326933496"
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="326933496"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 15:10:17 -0700
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="565821458"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 15:10:16 -0700
Subject: [ndctl PATCH 03/10] util: Pretty print terabytes
From:   Dan Williams <dan.j.williams@intel.com>
To:     vishal.l.verma@intel.com
Cc:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev
Date:   Thu, 28 Apr 2022 15:10:16 -0700
Message-ID: <165118381648.1676208.1686584406206186723.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <165118380037.1676208.7644295506592461996.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <165118380037.1676208.7644295506592461996.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

CXL capacities are such that gigabytes are too small of a unit for
displaying capacities. Add terabyte support to the display_size()
helper.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 util/json.c |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/util/json.c b/util/json.c
index ebdf8d9eedd9..1d5c6bc7822e 100644
--- a/util/json.c
+++ b/util/json.c
@@ -37,11 +37,16 @@ static int display_size(struct json_object *jobj, struct printbuf *pbuf,
 
 			c = snprintf(buf, sizeof(buf), "\"%ld.%02ld MiB",
 					cMiB/100 , cMiB % 100);
-		} else {
+		} else if (bytes < 2*SZ_1T) {
 			long cGiB = (bytes * 200LL / SZ_1G+1) /2;
 
 			c = snprintf(buf, sizeof(buf), "\"%ld.%02ld GiB",
 					cGiB/100 , cGiB % 100);
+		} else {
+			long cTiB = (bytes * 200LL / SZ_1T+1) /2;
+
+			c = snprintf(buf, sizeof(buf), "\"%ld.%02ld TiB",
+					cTiB/100 , cTiB % 100);
 		}
 
 		/* JEDEC */
@@ -50,12 +55,18 @@ static int display_size(struct json_object *jobj, struct printbuf *pbuf,
 
 			snprintf(buf + c, sizeof(buf) - c, " (%ld.%02ld MB)\"",
 					cMB/100, cMB % 100);
-		} else {
+		} else if (bytes < 2*SZ_1T) {
 			long cGB  = (bytes / (1000000000LL/200LL) + 1) / 2;
 
 			snprintf(buf + c, sizeof(buf) - c, " (%ld.%02ld GB)\"",
 					cGB/100 , cGB % 100);
+		} else {
+			long cTB  = (bytes / (1000000000000LL/200LL) + 1) / 2;
+
+			snprintf(buf + c, sizeof(buf) - c, " (%ld.%02ld TB)\"",
+					cTB/100 , cTB % 100);
 		}
+
 	}
 
 	return printbuf_memappend(pbuf, buf, strlen(buf));

