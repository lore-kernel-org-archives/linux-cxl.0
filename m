Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C40EE3F39
	for <linux-cxl@archiver.kernel.org>; Wed, 13 Sep 2023 00:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237899AbjIMAO7 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 12 Sep 2023 20:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237936AbjIMAO7 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 12 Sep 2023 20:14:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB291706
        for <linux-cxl@vger.kernel.org>; Tue, 12 Sep 2023 17:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694564095; x=1726100095;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=DSdRVhy3C5u46k2nXC8RZThfkMrgaNDCoun018r8RHo=;
  b=nTltjT3PulrSQMoHt2/2csF/vrEzUwSla15RjycUMip7Ml64aXofZSGw
   gEvYqNalWUDousn0Fg7/lw9VFqrUCGR9DhVFH1T3ZSoxQDaIFsau0u/Pp
   YeDyqkek91f9MxxofbRdV2cpKIvsMnP/mqW3zHYueWVhMjhkYkMm5P9bp
   3yGVYuxCXgulvKfIIK9XyHr9xVRXzm+dDLGtyTf45QbgWj4SE5kbrJxkM
   V+whM0E+zUCBImdhXxPVQoxHVr0qDj2KlhoeAPcmxctGZraSQMDwdqp1k
   1A4TNt0QRn75CIYPRdEQqjU39iIBKSaabTPtPw93ntXCHSeRbRuyakd05
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="363561870"
X-IronPort-AV: E=Sophos;i="6.02,141,1688454000"; 
   d="scan'208";a="363561870"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 17:14:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="814035050"
X-IronPort-AV: E=Sophos;i="6.02,141,1688454000"; 
   d="scan'208";a="814035050"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.209.169.202])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 17:14:52 -0700
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Tue, 12 Sep 2023 17:14:51 -0700
Subject: [PATCH ndctl] test/cxl-update-firmware: Fix checksum sysfs query
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230912-cxl-fw-test-fix-v1-1-bc544002cd02@intel.com>
X-B4-Tracking: v=1; b=H4sIAPr+AGUC/x2N0QqDMAxFf0XyvEBTJ8P9ythD2kUNzG40ooL47
 1Yfz+Ee7gYmWcXgWW2QZVbTXypAtwriwKkX1E9h8M7XriWPcf1it+AkNmGnKzaBKDyaO3l2UKr
 AJhgypzic3ciaTv3PUtbX0eu97wdQlj3ueAAAAA==
To:     Vishal Verma <vishal.l.verma@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>
X-Mailer: b4 0.13-dev-0f7f0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694564091; l=1415;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=DSdRVhy3C5u46k2nXC8RZThfkMrgaNDCoun018r8RHo=;
 b=p6X33ikiCC7wMahF5mCAaF3COV6hPjGUHLFgrKmNP8VRuh+W7uR9D2jCj6cRvbp4uxqrMmYzy
 Mi+g77GG11iAw1siZD5rU2kXZ63hE7wQqSL38F6Q+9R/QnHJLgkgu8m
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=brwqReAJklzu/xZ9FpSsMPSQ/qkSalbg6scP3w809Ec=
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The cxl-update-firmware test is failing on 6.5 and recent 6.6-rc
kernels.

The checksum check incorrectly uses the mem device id to form the host
name when checking the firmware checksum.

Get the host value from the mem device and use that in the query.

Fixes: 813809ed318f ("test/cxl-update-firmware: add a unit test for firmware update")
Cc: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 test/cxl-update-firmware.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/test/cxl-update-firmware.sh b/test/cxl-update-firmware.sh
index c6cd7429bb85..f326868977a9 100755
--- a/test/cxl-update-firmware.sh
+++ b/test/cxl-update-firmware.sh
@@ -118,14 +118,15 @@ validate_staged_slot()
 check_sha()
 {
 	mem="$1"
+	host=$($CXL list -m $mem | jq -r '.[].host')
 	file="$2"
-	csum_path="/sys/bus/platform/devices/cxl_mem.${mem#mem}/fw_buf_checksum"
+	csum_path="/sys/bus/platform/devices/${host}/fw_buf_checksum"
 
 	mem_csum="$(cat "$csum_path")"
 	file_csum="$(sha256sum "$file" | awk '{print $1}')"
 
 	if [[ $mem_csum != $file_csum ]]; then
-		echo "checksum failure for mem$mem"
+		echo "checksum failure for mem=$mem"
 		err "$LINENO"
 	fi
 }

---
base-commit: a871e6153b11fe63780b37cdcb1eb347b296095c
change-id: 20230912-cxl-fw-test-fix-5b11b75412a0

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>

