Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5215CCE79A5
	for <linux-cxl@archiver.kernel.org>; Mon, 25 Sep 2023 22:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjIYWQn (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 25 Sep 2023 18:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjIYWQn (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 25 Sep 2023 18:16:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6799107
        for <linux-cxl@vger.kernel.org>; Mon, 25 Sep 2023 15:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695680196; x=1727216196;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=OaB6hJF19s8EbOqBpmYN3HuqmyKNHrKoXf6QHQzEAfY=;
  b=mAkVa7gDe8ndv7BauTx1oQTYDO0IV/CFCvb4tA6NIwMuQPz0rvA2Nfv7
   xKc6kwZmIXhoKA00RnNzNjDaQmXXr6Ovp3X89b8q3oq69pZNQloKC+2DC
   lJre7qWhUHDF2vRPwVYvH9aR2nq99w/z1KKUSNNZ5DRJ7FaStJwT6eVzf
   XZMEOPi2Ez75TyX5UeYA9XU5jcVmHrxDKF8kkQ1fj/Nk+yWJzYkhBPSwB
   D8rvOtyW/5Hs2GMt+DA6ay+Nw+e8IyJ9f5jcNa6cLydeUmvaGUoGtWC0P
   PyxIyChieDerWLVTtDM+Mvycv39Sd2f4SUTezgSlbkzERW4nfOylPlahI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="412335634"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; 
   d="scan'208";a="412335634"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 15:16:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="742088741"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; 
   d="scan'208";a="742088741"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.212.66.94])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 15:16:16 -0700
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Mon, 25 Sep 2023 15:16:09 -0700
Subject: [PATCH ndctl RESEND] test/cxl-event: Skip cxl event testing if
 cxl-test is not available
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230925-skip-cxl-events-v1-1-bdad7cceb80b@intel.com>
X-B4-Tracking: v=1; b=H4sIAKgGEmUC/3WNsQ6CMBRFf4W82WdoFQxODrI66GgY2vqQF6GQl
 jQYwr9b2B3vuTk5M3hyTB7OyQyOAnvubRxil4BplH0T8itukKk8pIXM0H94QDO1SIHs6PFUizz
 NpC7MkSBaWnlC7ZQ1zep1iu2KB0c1T1voCffyUd6uUEXesB979936QWzv31QQKFAqnYssl3Vhx
 IXtSO3e9B1Uy7L8AO6LTzXNAAAA
To:     Vishal Verma <vishal.l.verma@intel.com>
Cc:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
X-Mailer: b4 0.13-dev-0f7f0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695680176; l=970;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=OaB6hJF19s8EbOqBpmYN3HuqmyKNHrKoXf6QHQzEAfY=;
 b=APA6/NsmFmqiiRw5ZWfgLuwM/JS/PPa7wvzZd2jJi/MkfvwKpe6zmh50oPNMO8OAoMeMJ3gmh
 B2cAFPdxm2tDiFvduQIEYexywEp6MCVxaBf6tr1mt7OEnWuU1RDn6JN
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=brwqReAJklzu/xZ9FpSsMPSQ/qkSalbg6scP3w809Ec=
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

CXL event testing is only appropriate when the cxl-test modules are
available.

Return error 77 (skip) if cxl-test modules are not available.

Reported-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
Changes for resend:
- iweiny: properly cc the mailing lists
---
 test/cxl-events.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/test/cxl-events.sh b/test/cxl-events.sh
index 33b68daa6ade..fe702bf98ad4 100644
--- a/test/cxl-events.sh
+++ b/test/cxl-events.sh
@@ -10,6 +10,8 @@ num_fatal_expected=2
 num_failure_expected=16
 num_info_expected=3
 
+rc=77
+
 set -ex
 
 trap 'err $LINENO' ERR
@@ -18,6 +20,7 @@ check_prereq "jq"
 
 modprobe -r cxl_test
 modprobe cxl_test
+rc=1
 
 dev_path="/sys/bus/platform/devices"
 

---
base-commit: a871e6153b11fe63780b37cdcb1eb347b296095c
change-id: 20230925-skip-cxl-events-7f16052b9c4e

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>

