Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6D4C4332F
	for <linux-cxl@archiver.kernel.org>; Sun,  6 Nov 2022 23:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbiKFXsP (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 6 Nov 2022 18:48:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiKFXsP (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 6 Nov 2022 18:48:15 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DCBD2F8
        for <linux-cxl@vger.kernel.org>; Sun,  6 Nov 2022 15:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667778494; x=1699314494;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8AHlCZAR1McgpgfxK/9LNp0DWH0p6txm/uMu7blTXsw=;
  b=b2xnqa7LPo8w82tEonhAwKedIto9K+Z+OjVu0TcHauCoPN2Jc03N7ukw
   yoLVoR6xrAjVxZO3PHBPil+A53bB5b/fJrMyIZLHhph4aZJffTqWs1h8/
   d4kdUJbl/Q5todE/5ULfjQotJbN2omLHHOecXTLPTSOq39hETPMUN9gpO
   wmHP78BcE5ZOjxHuUAWGaVyFM4EO9n7qFSJk+bDKY9cNlXdzYdGcFMWn5
   3t1Z98iUpv7+1EYczA531460u0ZQ5eyBYrJEj+/3ytfV9WrK6FZAgpNia
   jtPpYFDw3XPqhpvHKG1obtTb2DOD8IlD0Ycu1zEez7y1VXNu63oJsk0+E
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="372407833"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="372407833"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2022 15:48:14 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="880867238"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="880867238"
Received: from durgasin-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.212.240.219])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2022 15:48:13 -0800
Subject: [ndctl PATCH 15/15] cxl/test: Test single-port host-bridge region
 creation
From:   Dan Williams <dan.j.williams@intel.com>
To:     vishal.l.verma@intel.com
Cc:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev
Date:   Sun, 06 Nov 2022 15:48:13 -0800
Message-ID: <166777849300.1238089.2412172532718881380.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <166777840496.1238089.5601286140872803173.stgit@dwillia2-xfh.jf.intel.com>
References: <166777840496.1238089.5601286140872803173.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The original port decoder programming algorithm in the kernel failed to
acommodate the corner case of a passthrough port connected to a fan-out
port. Use the 5th cxl_test decoder to regression test this scenario.

Reported-by: Bobo WL <lmw.bobo@gmail.com>
Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Link: http://lore.kernel.org/r/20221010172057.00001559@huawei.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 test/cxl-create-region.sh |   28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/test/cxl-create-region.sh b/test/cxl-create-region.sh
index 82aad3a7285a..47aed44848ab 100644
--- a/test/cxl-create-region.sh
+++ b/test/cxl-create-region.sh
@@ -110,6 +110,34 @@ create_subregions()
 	done
 }
 
+create_single()
+{
+	# the 5th cxl_test decoder is expected to target a single-port
+	# host-bridge. Older cxl_test implementations may not define it,
+	# so skip the test in that case.
+	decoder=$($CXL list -b cxl_test -D -d root |
+		  jq -r ".[4] |
+		  select(.pmem_capable == true) |
+		  select(.nr_targets == 1) |
+		  .decoder")
+
+        if [[ ! $decoder ]]; then
+                echo "no single-port host-bridge decoder found, skipping"
+                return
+        fi
+
+	region=$($CXL create-region -d "$decoder" | jq -r ".region")
+	if [[ ! $region ]]; then
+		echo "failed to create single-port host-bridge region"
+		err "$LINENO"
+	fi
+
+	destroy_regions "$region"
+}
+
+# test region creation on devices behind a single-port host-bridge
+create_single
+
 # test reading labels directly through cxl-cli
 readarray -t mems < <("$CXL" list -b cxl_test -M | jq -r '.[].memdev')
 

