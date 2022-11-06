Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF13C4332F
	for <linux-cxl@archiver.kernel.org>; Sun,  6 Nov 2022 23:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbiKFXsK (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 6 Nov 2022 18:48:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiKFXsJ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 6 Nov 2022 18:48:09 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC736D2E0
        for <linux-cxl@vger.kernel.org>; Sun,  6 Nov 2022 15:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667778488; x=1699314488;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uHF4kHUiDLdEGXoKPH1GQDDdXLqRw/iHWnfJ4FfHogc=;
  b=MUQDUbLji3eTXezOmWT8qZAs+A1LKQ9MwfWrhgKw8X+OdQ39C4/RC6ou
   A86akgChiQpM2MK667FUNVYJFnSzmSKodhzv2uzcPHLdES4bl7OUhBbp+
   012FQtTDTnYwl1aTZrIl3hYwjFMR/yUcpSQizMG431D1xXMn2WQJAea/A
   /t8IGqLzbYbKL260CLru69hKrnqtPJPh+HtICbQjb4/n6QLvuzy1wQYJw
   WyU2ICW9ESMTqmBFyurLz3pRiKVj/ch0cgIbLo+eRwa7K3nU6SWcTyS3F
   /hZtvwrreS9hof1ZO/fy8d8UBXG4bwfTvYhRBA1IdZ891xx5dUo2QOKKM
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="311422384"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="311422384"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2022 15:48:08 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="880867230"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="880867230"
Received: from durgasin-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.212.240.219])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2022 15:48:07 -0800
Subject: [ndctl PATCH 14/15] cxl/test: Extend cxl-topology.sh for a single
 root-port host-bridge
From:   Dan Williams <dan.j.williams@intel.com>
To:     vishal.l.verma@intel.com
Cc:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev
Date:   Sun, 06 Nov 2022 15:48:07 -0800
Message-ID: <166777848711.1238089.14027431355477472365.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <166777840496.1238089.5601286140872803173.stgit@dwillia2-xfh.jf.intel.com>
References: <166777840496.1238089.5601286140872803173.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

A recent extension of cxl_test adds 2 memory devices attached through a
switch to a single ported host-bridge to reproduce a bug report.

Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Link: http://lore.kernel.org/r/20221010172057.00001559@huawei.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 test/cxl-topology.sh |   48 +++++++++++++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 19 deletions(-)

diff --git a/test/cxl-topology.sh b/test/cxl-topology.sh
index 1f15d29f0600..f1e0a2b01e98 100644
--- a/test/cxl-topology.sh
+++ b/test/cxl-topology.sh
@@ -29,27 +29,30 @@ count=$(jq "length" <<< $json)
 root=$(jq -r ".[] | .bus" <<< $json)
 
 
-# validate 2 host bridges under a root port
+# validate 2 or 3 host bridges under a root port
 port_sort="sort_by(.port | .[4:] | tonumber)"
 json=$($CXL list -b cxl_test -BP)
 count=$(jq ".[] | .[\"ports:$root\"] | length" <<< $json)
-((count == 2)) || err "$LINENO"
+((count == 2)) || ((count == 3)) || err "$LINENO"
+bridges=$count
 
 bridge[0]=$(jq -r ".[] | .[\"ports:$root\"] | $port_sort | .[0].port" <<< $json)
 bridge[1]=$(jq -r ".[] | .[\"ports:$root\"] | $port_sort | .[1].port" <<< $json)
+((bridges > 2)) && bridge[2]=$(jq -r ".[] | .[\"ports:$root\"] | $port_sort | .[2].port" <<< $json)
 
+# validate root ports per host bridge
+check_host_bridge()
+{
+	json=$($CXL list -b cxl_test -T -p $1)
+	count=$(jq ".[] | .dports | length" <<< $json)
+	((count == $2)) || err "$3"
+}
 
-# validate 2 root ports per host bridge
-json=$($CXL list -b cxl_test -T -p ${bridge[0]})
-count=$(jq ".[] | .dports | length" <<< $json)
-((count == 2)) || err "$LINENO"
-
-json=$($CXL list -b cxl_test -T -p ${bridge[1]})
-count=$(jq ".[] | .dports | length" <<< $json)
-((count == 2)) || err "$LINENO"
+check_host_bridge ${bridge[0]} 2 $LINENO
+check_host_bridge ${bridge[1]} 2 $LINENO
+((bridges > 2)) && check_host_bridge ${bridge[2]} 1 $LINENO
 
-
-# validate 2 switches per-root port
+# validate 2 switches per root-port
 json=$($CXL list -b cxl_test -P -p ${bridge[0]})
 count=$(jq ".[] | .[\"ports:${bridge[0]}\"] | length" <<< $json)
 ((count == 2)) || err "$LINENO"
@@ -65,9 +68,9 @@ switch[2]=$(jq -r ".[] | .[\"ports:${bridge[1]}\"] | $port_sort | .[0].host" <<<
 switch[3]=$(jq -r ".[] | .[\"ports:${bridge[1]}\"] | $port_sort | .[1].host" <<< $json)
 
 
-# validate the expected properties of the 4 root decoders
-# use the size of the first decoder to determine the cxl_test version /
-# properties
+# validate the expected properties of the 4 or 5 root decoders
+# use the size of the first decoder to determine the
+# cxl_test version / properties
 json=$($CXL list -b cxl_test -D -d root)
 port_id=${root:4}
 port_id_len=${#port_id}
@@ -103,12 +106,19 @@ count=$(jq "[ $decoder_sort | .[3] |
 	select(.nr_targets == 2) ] | length" <<< $json)
 ((count == 1)) || err "$LINENO"
 
+if [ $bridges -eq 3 ]; then
+	count=$(jq "[ $decoder_sort | .[4] |
+		select(.pmem_capable == true) |
+		select(.size == $decoder_base_size) |
+		select(.nr_targets == 1) ] | length" <<< $json)
+	((count == 1)) || err "$LINENO"
+fi
 
-# check that all 8 cxl_test memdevs are enabled by default and have a
+# check that all 8 or 10 cxl_test memdevs are enabled by default and have a
 # pmem size of 256M, or 1G
 json=$($CXL list -b cxl_test -M)
 count=$(jq "map(select(.pmem_size == $pmem_size)) | length" <<< $json)
-((count == 8)) || err "$LINENO"
+((bridges == 2 && count == 8 || bridges == 3 && count == 10)) || err "$LINENO"
 
 
 # check that switch ports disappear after all of their memdevs have been
@@ -151,8 +161,8 @@ do
 done
 
 
-# validate host bridge tear down
-for b in ${bridge[@]}
+# validate host bridge tear down for the first 2 bridges
+for b in ${bridge[0]} ${bridge[1]}
 do
 	$CXL disable-port $b -f
 	json=$($CXL list -M -i -p $b)

