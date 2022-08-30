Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD11EECAAA1
	for <linux-cxl@archiver.kernel.org>; Tue, 30 Aug 2022 18:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiH3SLL (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 30 Aug 2022 14:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232260AbiH3SLI (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 30 Aug 2022 14:11:08 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3E278BEC
        for <linux-cxl@vger.kernel.org>; Tue, 30 Aug 2022 11:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661883065; x=1693419065;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LXAFPY72XW6xQRTSp/0fWqf22YPEySpnW1R9UtF44SI=;
  b=fgohhQsWERSzWvygZ70IDAH0+mCjCjMzDxkRtdgr40rS93B34HyBanQV
   HieFGiz/bofwgidEV6oj8223ze4qds5CEwJ53PNt0L5hnxRYFQegqUVIb
   gb7ixTlxFg0k0ExD4b02sTtlAlrMj3xqHVsCgHcKcp3DOBPS/fzEESFwn
   E7RFu4Hk8fH1xf9wz3MIezENP1bb8+6egu3N3DxhEW0DrDd0cTWT3sIsA
   HEVs24Lf3cMXgNmd2m/DC6Kor9PhNGRrkyRTfxKiI72mElZdwXd/fcxOZ
   5VgTorFOyEquiYoYNt/goeEVIz1/GypKttyL9Mrv9PnDI0G6vuUmAxdE+
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="296049563"
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="296049563"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 11:11:05 -0700
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="644937907"
Received: from lehman1-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.212.188.127])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 11:11:05 -0700
Subject: [ndctl PATCH] cxl/test: Skip tests in the absence of the cxl_test
 module
From:   Dan Williams <dan.j.williams@intel.com>
To:     vishal.l.verma@intel.com
Cc:     Yi Zhang <yi.zhang@redhat.com>, linux-cxl@vger.kernel.org
Date:   Tue, 30 Aug 2022 11:11:05 -0700
Message-ID: <166188306499.3409478.15310054338186313752.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Similar to cases when nfit_test is missing, SKIP rather than FAIL the tests
that depend on cxl_test.ko when it is missing.

Link: https://github.com/pmem/ndctl/issues/221
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 test/cxl-create-region.sh |    3 ++-
 test/cxl-labels.sh        |    3 ++-
 test/cxl-region-sysfs.sh  |    3 ++-
 test/cxl-topology.sh      |    3 ++-
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/test/cxl-create-region.sh b/test/cxl-create-region.sh
index 66df38f41549..82aad3a7285a 100644
--- a/test/cxl-create-region.sh
+++ b/test/cxl-create-region.sh
@@ -4,7 +4,7 @@
 
 . $(dirname $0)/common
 
-rc=1
+rc=77
 
 set -ex
 
@@ -14,6 +14,7 @@ check_prereq "jq"
 
 modprobe -r cxl_test
 modprobe cxl_test
+rc=1
 udevadm settle
 
 destroy_regions()
diff --git a/test/cxl-labels.sh b/test/cxl-labels.sh
index e782e2dec246..3bf1e6e995b6 100644
--- a/test/cxl-labels.sh
+++ b/test/cxl-labels.sh
@@ -4,7 +4,7 @@
 
 . $(dirname $0)/common
 
-rc=1
+rc=77
 
 set -ex
 
@@ -14,6 +14,7 @@ check_prereq "jq"
 
 modprobe -r cxl_test
 modprobe cxl_test
+rc=1
 udevadm settle
 
 test_label_ops()
diff --git a/test/cxl-region-sysfs.sh b/test/cxl-region-sysfs.sh
index ae0f55653814..63186b60dfec 100644
--- a/test/cxl-region-sysfs.sh
+++ b/test/cxl-region-sysfs.sh
@@ -4,7 +4,7 @@
 
 . $(dirname $0)/common
 
-rc=1
+rc=77
 
 set -ex
 
@@ -14,6 +14,7 @@ check_prereq "jq"
 
 modprobe -r cxl_test
 modprobe cxl_test
+rc=1
 udevadm settle
 
 # THEORY OF OPERATION: Create a x8 interleave across the pmem capacity
diff --git a/test/cxl-topology.sh b/test/cxl-topology.sh
index f7da83e60f7a..5148e6dd79f4 100644
--- a/test/cxl-topology.sh
+++ b/test/cxl-topology.sh
@@ -4,7 +4,7 @@
 
 . $(dirname $0)/common
 
-rc=1
+rc=77
 
 set -ex
 
@@ -14,6 +14,7 @@ check_prereq "jq"
 
 modprobe -r cxl_test
 modprobe cxl_test
+rc=1
 udevadm settle
 
 # THEORY OF OPERATION: Validate the hard coded assumptions of the

