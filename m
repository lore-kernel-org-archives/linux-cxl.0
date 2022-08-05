Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93857C00140
	for <linux-cxl@archiver.kernel.org>; Fri,  5 Aug 2022 20:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236380AbiHEUiB (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 5 Aug 2022 16:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234198AbiHEUiA (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 5 Aug 2022 16:38:00 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7264331F
        for <linux-cxl@vger.kernel.org>; Fri,  5 Aug 2022 13:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659731879; x=1691267879;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zfjsMIkbOzg0Kth9pZ5DX0mgXo6XF1g850I23O2ZjSQ=;
  b=FlQTps70HjWnvXLjlr69NE8jUteSdpkOeb6xCNd2P/X2CQLnGRrbv7fj
   35UVXQW7pRbtRgPR2BW1qqzu/VJ8NU1tj1hyWk1mzXYXXU617FcQodRnO
   t+x2S/tdAcN4l1ydeGlctLu1aEgUMJBVJgmJ8X4ougSgJ37lPUn5opm6x
   oxa++2ejl4dufuVkKe9glocidLD9ULGkTu/FDc+yJbSAWHYE8rlQ/oVau
   T6VRjBnaGf7eOuGWZ1wsJ56r5RxoriWL2m5phyANKHN6CIpHlirPK4Jjn
   GaakBjg7KwTMiJhTFZZOwGPkIIkOfl7drRJep7PfjzxC3T0lnvFfVdtWg
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="277209716"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="277209716"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 13:37:59 -0700
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="931355660"
Received: from jivaldiv-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.255.228.201])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 13:37:57 -0700
Subject: [ndctl PATCH 1/6] cxl/test: Validate endpoint interleave geometry
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        vishal.l.verma@intel.com, dave.jiang@intel.com,
        ira.weiny@intel.com, alison.schofield@intel.com
Date:   Fri, 05 Aug 2022 13:37:56 -0700
Message-ID: <165973187660.1528532.13832323649814892720.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <165973187080.1528532.8097010788284626448.stgit@dwillia2-xfh.jf.intel.com>
References: <165973187080.1528532.8097010788284626448.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Check that endpoint interleave geometry settings are updated once the
endpoint decoders are associated with a region.

Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 test/cxl-region-sysfs.sh |   20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/test/cxl-region-sysfs.sh b/test/cxl-region-sysfs.sh
index 2582edb3f306..110e03709e39 100644
--- a/test/cxl-region-sysfs.sh
+++ b/test/cxl-region-sysfs.sh
@@ -44,8 +44,8 @@ uuidgen > /sys/bus/cxl/devices/$region/uuid
 # setup interleave geometry
 nr_targets=${#endpoint[@]}
 echo $nr_targets > /sys/bus/cxl/devices/$region/interleave_ways
-g=$(cat /sys/bus/cxl/devices/$decoder/interleave_granularity)
-echo $g > /sys/bus/cxl/devices/$region/interleave_granularity
+r_ig=$(cat /sys/bus/cxl/devices/$decoder/interleave_granularity)
+echo $r_ig > /sys/bus/cxl/devices/$region/interleave_granularity
 echo $((nr_targets * (256<<20))) > /sys/bus/cxl/devices/$region/size
 
 # grab the list of memdevs grouped by host-bridge interleave position
@@ -96,6 +96,22 @@ do
 done
 echo "$region added ${#endpoint[@]} targets: ${endpoint[@]}"
 
+# validate all endpoint decoders have the correct setting
+region_size=$(cat /sys/bus/cxl/devices/$region/size)
+region_base=$(cat /sys/bus/cxl/devices/$region/resource)
+for i in ${endpoint[@]}
+do
+	iw=$(cat /sys/bus/cxl/devices/$i/interleave_ways)
+	ig=$(cat /sys/bus/cxl/devices/$i/interleave_granularity)
+	[ $iw -ne $nr_targets ] && err "$LINENO: decoder: $i iw: $iw targets: $nr_targets"
+	[ $ig -ne $r_ig] && err "$LINENO: decoder: $i ig: $ig root ig: $r_ig"
+
+	sz=$(cat /sys/bus/cxl/devices/$i/size)
+	res=$(cat /sys/bus/cxl/devices/$i/start)
+	[ $sz -ne $region_size ] && err "$LINENO: decoder: $i sz: $sz region_size: $region_size"
+	[ $res -ne $region_base ] && err "$LINENO: decoder: $i base: $res region_base: $region_base"
+done
+
 # walk up the topology and commit all decoders
 echo 1 > /sys/bus/cxl/devices/$region/commit
 

