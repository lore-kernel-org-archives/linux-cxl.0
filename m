Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 381B4C4332F
	for <linux-cxl@archiver.kernel.org>; Wed, 14 Dec 2022 00:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237361AbiLNA0H (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 13 Dec 2022 19:26:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237365AbiLNAZ7 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 13 Dec 2022 19:25:59 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2AA81402A
        for <linux-cxl@vger.kernel.org>; Tue, 13 Dec 2022 16:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670977549; x=1702513549;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mLXEzoSwM14S/kiHtmzzux6iUbcUUXezKFN/hACEsUg=;
  b=FdrAY2E6+6Os0f+pFu6cb6VPgRMhuwsr2xj3WW+CyLZRiEwyDKB+TuAc
   4JjhiCN7CVuNDWwikqDSq1Hbqcnz3yZBtCtkQPYTXNzo/VxgVqslm5J1A
   jtNM6lM2wV2cqu7Ap2ZRHEX5bkSKYAXaNjZs5QMzZ8f4rkW4NwA9beWRx
   WLla27KiJKmHIOQYtgXv3wGWjlra3Yvt79WQDdFncpbwfuYmD6JUjOhA9
   rDoX4yOOMZ+M6zYfCwcyTihyo8sWP7IUIrhPzdIe/eJPjwH61ePEuUCNY
   nG3BIAyZKyOKcXW8JvTxhMM61KsBepr0ZqzD5eFcdT6DH9Z34xOfIcAI+
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="404540216"
X-IronPort-AV: E=Sophos;i="5.96,242,1665471600"; 
   d="scan'208";a="404540216"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 16:25:49 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="823084778"
X-IronPort-AV: E=Sophos;i="5.96,242,1665471600"; 
   d="scan'208";a="823084778"
Received: from mesplin-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.37.170])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 16:25:49 -0800
Subject: [ndctl PATCH 5/5] cxl/test: More backtrace detection
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     vishal.l.verma@intel.com, vishal.l.verma@intel.com,
        patches@lists.linux.dev
Date:   Tue, 13 Dec 2022 16:25:49 -0800
Message-ID: <167097754909.1189953.2852545346689990149.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <167097752151.1189953.3189708700022130101.stgit@dwillia2-xfh.jf.intel.com>
References: <167097752151.1189953.3189708700022130101.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Make sure that backtraces are attributed to the expected test, and add more
backtrace detection to other tests.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 test/common               |    1 +
 test/cxl-create-region.sh |    2 ++
 test/cxl-labels.sh        |    2 ++
 3 files changed, 5 insertions(+)

diff --git a/test/common b/test/common
index 44cc352f6009..248ca3eaa485 100644
--- a/test/common
+++ b/test/common
@@ -138,6 +138,7 @@ json2var()
 check_dmesg()
 {
 	# validate no WARN or lockdep report during the run
+	sleep 1
 	log=$(journalctl -r -k --since "-$((SECONDS+1))s")
 	grep -q "Call Trace" <<< $log && err $1
 	true
diff --git a/test/cxl-create-region.sh b/test/cxl-create-region.sh
index 02161661b28f..658b9b8ff58a 100644
--- a/test/cxl-create-region.sh
+++ b/test/cxl-create-region.sh
@@ -149,4 +149,6 @@ for mem in ${mems[@]}; do
 	create_subregions "$mem"
 done
 
+check_dmesg "$LINENO"
+
 modprobe -r cxl_test
diff --git a/test/cxl-labels.sh b/test/cxl-labels.sh
index b38ca2f4693f..36b0341c8039 100644
--- a/test/cxl-labels.sh
+++ b/test/cxl-labels.sh
@@ -66,4 +66,6 @@ for nmem in ${nmems[@]}; do
 	test_label_ops "$nmem"
 done
 
+check_dmesg "$LINENO"
+
 modprobe -r cxl_test

