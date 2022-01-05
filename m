Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBEC9C433FE
	for <linux-cxl@archiver.kernel.org>; Wed,  5 Jan 2022 21:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244426AbiAEVei (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 5 Jan 2022 16:34:38 -0500
Received: from mga14.intel.com ([192.55.52.115]:63626 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244458AbiAEVeI (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Wed, 5 Jan 2022 16:34:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641418448; x=1672954448;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VvqYIlkRHgJ9qXPmwzXXUh/RgXfXlalF6pCDeVGVYq4=;
  b=d9y0psjJuPnytsFHWqp0rxzRQeSuHOv4GWY39qvqT3T9rD2WtF6aUOP0
   zvYXo+W+PawMOutJqd4zbXxJDUTl6FH3Ya9YrWjAiFvEUmjrcSljhPXAF
   wUkYPOFBfz84RtSEoEGd0LDb4xbYovUsVI487LJhRSmholv3TjIJDVAuo
   G3//1+xpLIEFL+AT1I40QVgbty036OyIj/DeMc/HlAAMlH+MEKezH5ahe
   MCAsbpSAWR1NsvZxYhzUQnBjG4s2D/taf4nvXK6WfisaHjmnO0gXH7o6x
   O6VHjrTBhfOMJuL3BUl0KZLn9ESDcqFlZm9ERU+sDAymEz5CDVcls0Y3z
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="242746608"
X-IronPort-AV: E=Sophos;i="5.88,264,1635231600"; 
   d="scan'208";a="242746608"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 13:32:00 -0800
X-IronPort-AV: E=Sophos;i="5.88,264,1635231600"; 
   d="scan'208";a="488727326"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 13:32:00 -0800
Subject: [ndctl PATCH v3 04/16] ndctl/test: Initialize the label area by
 default
From:   Dan Williams <dan.j.williams@intel.com>
To:     vishal.l.verma@intel.com
Cc:     nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org
Date:   Wed, 05 Jan 2022 13:32:00 -0800
Message-ID: <164141832017.3990253.10383328274835531066.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164141829899.3990253.17547886681174580434.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164141829899.3990253.17547886681174580434.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The removal of BLK-mode support causes nfit_test regions to not be
'aliased' by default, which means that the only way to enable labels is to
initialize the namespace label index block. In support of that the common
'reset()' helper is updated to initialize v1.1 labels instead of zero them.
Additionally, it highlighted that some btt tests have silent assumptions of
v1.1 vs v1.2 label support. Add a 'resetV()' alternative to the common
'reset()' function that initializes the label area to v1.2.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 test/btt-errors.sh     |    4 ++--
 test/btt-pad-compat.sh |    2 +-
 test/common            |   11 +++++++++--
 test/label-compat.sh   |    2 +-
 4 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/test/btt-errors.sh b/test/btt-errors.sh
index 5a20d26fe6d5..6e69178cc3cf 100755
--- a/test/btt-errors.sh
+++ b/test/btt-errors.sh
@@ -45,7 +45,7 @@ trap 'err $LINENO cleanup' ERR
 
 # setup (reset nfit_test dimms)
 modprobe nfit_test
-reset
+resetV
 
 rc=1
 
@@ -124,7 +124,7 @@ dd if=$MNT/$FILE of=/dev/null iflag=direct bs=4096 count=1
 
 # reset everything to get a clean log
 if grep -q "$MNT" /proc/mounts; then umount $MNT; fi
-reset
+resetV
 dev="x"
 json=$($NDCTL create-namespace -b $NFIT_TEST_BUS0 -t pmem -m sector)
 eval "$(echo "$json" | json2var)"
diff --git a/test/btt-pad-compat.sh b/test/btt-pad-compat.sh
index be538b761151..005316a205c8 100755
--- a/test/btt-pad-compat.sh
+++ b/test/btt-pad-compat.sh
@@ -148,7 +148,7 @@ do_tests()
 	verify_idx 0 1
 
 	# do the same with an old format namespace
-	reset
+	resetV
 	create_oldfmt_ns
 	verify_idx 0 2
 
diff --git a/test/common b/test/common
index 3c54d633251f..b6d47128f209 100644
--- a/test/common
+++ b/test/common
@@ -49,14 +49,21 @@ err()
 reset()
 {
 	$NDCTL disable-region -b $NFIT_TEST_BUS0 all
-	$NDCTL zero-labels -b $NFIT_TEST_BUS0 all
+	$NDCTL init-labels -f -b $NFIT_TEST_BUS0 all
+	$NDCTL enable-region -b $NFIT_TEST_BUS0 all
+}
+
+resetV()
+{
+	$NDCTL disable-region -b $NFIT_TEST_BUS0 all
+	$NDCTL init-labels -f -V 1.2 -b $NFIT_TEST_BUS0 all
 	$NDCTL enable-region -b $NFIT_TEST_BUS0 all
 }
 
 reset1()
 {
 	$NDCTL disable-region -b $NFIT_TEST_BUS1 all
-	$NDCTL zero-labels -b $NFIT_TEST_BUS1 all
+	$NDCTL init-labels -f -b $NFIT_TEST_BUS1 all
 	$NDCTL enable-region -b $NFIT_TEST_BUS1 all
 }
 
diff --git a/test/label-compat.sh b/test/label-compat.sh
index 8ab285878d84..7ae4d5efd0ff 100755
--- a/test/label-compat.sh
+++ b/test/label-compat.sh
@@ -17,7 +17,7 @@ trap 'err $LINENO' ERR
 # setup (reset nfit_test dimms)
 modprobe nfit_test
 $NDCTL disable-region -b $NFIT_TEST_BUS0 all
-$NDCTL zero-labels -b $NFIT_TEST_BUS0 all
+$NDCTL init-labels -f -b $NFIT_TEST_BUS0 all
 
 # grab the largest pmem region on -b $NFIT_TEST_BUS0
 query=". | sort_by(.available_size) | reverse | .[0].dev"

