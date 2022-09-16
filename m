Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55538C6FA86
	for <linux-cxl@archiver.kernel.org>; Fri, 16 Sep 2022 01:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiIPBfL (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 15 Sep 2022 21:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiIPBfJ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 15 Sep 2022 21:35:09 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35B032EEE
        for <linux-cxl@vger.kernel.org>; Thu, 15 Sep 2022 18:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663292108; x=1694828108;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GbjGsk48B5jT8oeQhzL1rnsT1NQxODvuyZ+YY+8XGL8=;
  b=LyDwgG4yM7m+l52ZQvGAUuDnP3I58QUWX+ovyT324ys0N6WqYB+HyOb7
   L6o5zVeI71wkvaGVhV934iieH1n75Z8arVT1XWyIF9PjV61w0wpoGDmeS
   4HRCs5JG/h1+GtnXXBEJo29vQJlCqodsCGMew2is9k9vRu3C969Spx2ZG
   8GiySSza1OAlwUiwMgFl/qCu/3wQs1BFrNxaRcRCYb53XhJx69lRMzTPM
   fSD6Dneb16VKXV49pectF5ELB2aIoMao0RUhG/hCvDSLbNIv4bCLjjgN/
   AGSjVYj4uejOkL0Rn7jnl+hlNYtOL6L2M4sSs/78HJZiNuaWmTOKpTev/
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10471"; a="362849999"
X-IronPort-AV: E=Sophos;i="5.93,319,1654585200"; 
   d="scan'208";a="362849999"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 18:35:06 -0700
X-IronPort-AV: E=Sophos;i="5.93,319,1654585200"; 
   d="scan'208";a="743164761"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.120.139])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 18:35:06 -0700
From:   alison.schofield@intel.com
To:     Vishal Verma <vishal.l.verma@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org
Subject: [ndctl PATCH 2/2] cxl/test: allow another host bridge in cxl-topology check
Date:   Thu, 15 Sep 2022 18:35:02 -0700
Message-Id: <1380b5042ba3baf39777183205cc3d6974519159.1663290390.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1663290390.git.alison.schofield@intel.com>
References: <cover.1663290390.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

Update the related count checks to allow a third CXL Host
Bridge in the cxl_test topology.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 test/cxl-topology.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/test/cxl-topology.sh b/test/cxl-topology.sh
index 2583005fef26..11c39f61cf52 100644
--- a/test/cxl-topology.sh
+++ b/test/cxl-topology.sh
@@ -32,7 +32,7 @@ root=$(jq -r ".[] | .bus" <<< $json)
 port_sort="sort_by(.port | .[4:] | tonumber)"
 json=$($CXL list -b cxl_test -BP)
 count=$(jq ".[] | .[\"ports:$root\"] | length" <<< $json)
-((count == 2)) || err "$LINENO"
+((count == 4)) || err "$LINENO"
 
 bridge[0]=$(jq -r ".[] | .[\"ports:$root\"] | $port_sort | .[0].port" <<< $json)
 bridge[1]=$(jq -r ".[] | .[\"ports:$root\"] | $port_sort | .[1].port" <<< $json)
@@ -103,11 +103,11 @@ count=$(jq "[ $decoder_sort | .[3] |
 ((count == 1)) || err "$LINENO"
 
 
-# check that all 8 cxl_test memdevs are enabled by default and have a
+# check that all 16 cxl_test memdevs are enabled by default and have a
 # pmem size of 256M, or 1G
 json=$($CXL list -b cxl_test -M)
 count=$(jq "map(select(.pmem_size == $pmem_size)) | length" <<< $json)
-((count == 8)) || err "$LINENO"
+((count == 16 )) || err "$LINENO"
 
 
 # check that switch ports disappear after all of their memdevs have been
-- 
2.31.1

