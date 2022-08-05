Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D739DC00140
	for <linux-cxl@archiver.kernel.org>; Fri,  5 Aug 2022 20:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236727AbiHEUi3 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 5 Aug 2022 16:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237607AbiHEUi1 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 5 Aug 2022 16:38:27 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41965E03
        for <linux-cxl@vger.kernel.org>; Fri,  5 Aug 2022 13:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659731907; x=1691267907;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rWsllSkyx2RG5Grpr1DiiLPjziQsHokfjNNJ9pf0mqc=;
  b=kSNV39Z9j1jx41ZSvXgrUkxYHZVswuluM27j11//j3LDTGN2+uCX7lsv
   6oPTVc65ebF4QWOmm1CEU+ZbjwVR9s8ivPjHV/OhoJuhUzAa08Jpt8mgi
   8t15MXruuSmb+JY5UGC/sjjqO008hDBrHmaHILKwVPFX4Q4bQo3d4a8RK
   uUrrFD/QKx+DMPh809fqJs0khZPM3E9SmZPd0BytwlEwZL93oK02jpDkB
   RXoq5NYF0BiYw54gfuzwwRiQdR5S19iENWB9f6QeTuibLSHzaD6Kfcfrs
   JlxV20DR/eRsQW3oFtSJJBXR1yl0CBzBZ2aYhex3vAdYvfiWlSrcOKr0Y
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="289044334"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="289044334"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 13:38:27 -0700
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="671815294"
Received: from jivaldiv-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.255.228.201])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 13:38:26 -0700
Subject: [ndctl PATCH 6/6] cxl/test: Validate switch port settings in
 cxl-region-sysfs.sh
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     vishal.l.verma@intel.com, dave.jiang@intel.com,
        ira.weiny@intel.com, alison.schofield@intel.com
Date:   Fri, 05 Aug 2022 13:38:26 -0700
Message-ID: <165973190625.1528532.12244196912617964754.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <165973187080.1528532.8097010788284626448.stgit@dwillia2-xfh.jf.intel.com>
References: <165973187080.1528532.8097010788284626448.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

A recent kernel fix to add the missing update of endpoint decoder HPA range
settings regressed switch decoder HPA range settings. Add validation for
switch port settings to avoid regressions like that going forward.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 test/cxl-region-sysfs.sh |   32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/test/cxl-region-sysfs.sh b/test/cxl-region-sysfs.sh
index 110e03709e39..ae0f55653814 100644
--- a/test/cxl-region-sysfs.sh
+++ b/test/cxl-region-sysfs.sh
@@ -112,6 +112,38 @@ do
 	[ $res -ne $region_base ] && err "$LINENO: decoder: $i base: $res region_base: $region_base"
 done
 
+# validate all switch decoders have the correct settings
+nr_switches=$((nr_targets/2))
+nr_host_bridges=$((nr_switches/2))
+nr_switch_decoders=$((nr_switches + nr_host_bridges))
+
+json=$($CXL list -D -r $region -d switch)
+readarray -t switch_decoders < <(echo $json | jq -r ".[].decoder")
+
+[ ${#switch_decoders[@]} -ne $nr_switch_decoders ] && err \
+"$LINENO: expected $nr_switch_decoders got ${#switch_decoders[@]} switch decoders"
+
+for i in ${switch_decoders[@]}
+do
+	decoder=$(echo $json | jq -r ".[] | select(.decoder == \"$i\")")
+	id=${i#decoder}
+	port_id=${id%.*}
+	depth=$($CXL list -p $port_id -S | jq -r ".[].depth")
+	iw=$(echo $decoder | jq -r ".interleave_ways")
+	ig=$(echo $decoder | jq -r ".interleave_granularity")
+
+	[ $iw -ne 2 ] && err "$LINENO: decoder: $i iw: $iw targets: 2"
+	[ $ig -ne $((r_ig << depth)) ] && err \
+	"$LINENO: decoder: $i ig: $ig switch_ig: $((r_ig << depth))"
+
+	res=$(echo $decoder | jq -r ".resource")
+	sz=$(echo $decoder | jq -r ".size")
+	[ $sz -ne $region_size ] && err \
+	"$LINENO: decoder: $i sz: $sz region_size: $region_size"
+	[ $res -ne $region_base ] && err \
+	"$LINENO: decoder: $i base: $res region_base: $region_base"
+done
+
 # walk up the topology and commit all decoders
 echo 1 > /sys/bus/cxl/devices/$region/commit
 

