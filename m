Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3494EC433FE
	for <linux-cxl@archiver.kernel.org>; Wed,  5 Jan 2022 21:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244497AbiAEVdk (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 5 Jan 2022 16:33:40 -0500
Received: from mga05.intel.com ([192.55.52.43]:46270 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244541AbiAEVcc (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Wed, 5 Jan 2022 16:32:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641418352; x=1672954352;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YG9eeeLnbMrLQY6Q0GuYOl0nHLjVehSnzpcQ/ICYIL0=;
  b=EMEUzUdOs2hqO7iQfm/KJFZQWLvSkunqRdc4Akf4NV5BAfPOSLj4dw57
   rHoKExNsWN/8KLmDItcNhLpVEmLIB3GMz8mX1g6g7ksz9r50+Cmsph6vh
   1CPoRGfNW+GD4AtgP3/n7BnhcRtsGEvlgr15cCWNVr/zT6XPgw0dqgsv2
   5JtkNwu2VFLb4jZOVQLMaJfgy7F8PvzGqExfMpFBG40giMvMNRccLZAPk
   JW/usvspBQn1T7iMQp0gRK9w4u5in/JqZgAEejZou+1uwzErQCq16+dmd
   NgSmxiRVAAD7NUenZxldk3oy230qFHEWSzT4U+PgDiHAw9af6Wujqz1LR
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="328888202"
X-IronPort-AV: E=Sophos;i="5.88,264,1635231600"; 
   d="scan'208";a="328888202"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 13:32:10 -0800
X-IronPort-AV: E=Sophos;i="5.88,264,1635231600"; 
   d="scan'208";a="689157245"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 13:32:10 -0800
Subject: [ndctl PATCH v3 06/16] ndctl/test: Move sector-mode to a different
 region
From:   Dan Williams <dan.j.williams@intel.com>
To:     vishal.l.verma@intel.com
Cc:     nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org
Date:   Wed, 05 Jan 2022 13:32:10 -0800
Message-ID: <164141833068.3990253.15694496866707006837.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164141829899.3990253.17547886681174580434.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164141829899.3990253.17547886681174580434.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Previously the largest region on the nfit_test.1 bus belonged to a BLK-mode
region. With the removal of BLK-mode support update the test to instead
find a suitable PMEM region to perform the checkout.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 test/sector-mode.sh |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/test/sector-mode.sh b/test/sector-mode.sh
index 439ef331adaf..f70b0f1786f4 100755
--- a/test/sector-mode.sh
+++ b/test/sector-mode.sh
@@ -19,11 +19,11 @@ reset
 reset1
 
 rc=1
-query=". | sort_by(.size) | reverse | .[0].dev"
-NAMESPACE=$($NDCTL list -b $NFIT_TEST_BUS1 -N | jq -r "$query")
-REGION=$($NDCTL list -R --namespace=$NAMESPACE | jq -r "(.[]) | .dev")
+query=". | sort_by(.available_size) | reverse | .[0].dev"
+REGION=$($NDCTL list -R -b $NFIT_TEST_BUS1 | jq -r "$query")
 echo 0 > /sys/bus/nd/devices/$REGION/read_only
-$NDCTL create-namespace --no-autolabel -e $NAMESPACE -m sector -f -l 4K
+echo $ALIGN_SIZE > /sys/bus/nd/devices/$REGION/align
+NAMESPACE=$($NDCTL create-namespace --no-autolabel -r $REGION -m sector -f -l 4K | jq -r ".dev")
 $NDCTL create-namespace --no-autolabel -e $NAMESPACE -m dax -f -a $ALIGN_SIZE
 $NDCTL create-namespace --no-autolabel -e $NAMESPACE -m sector -f -l 4K
 

