Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7512AC04A68
	for <linux-cxl@archiver.kernel.org>; Wed, 27 Jul 2022 22:18:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234392AbiG0WSF (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 27 Jul 2022 18:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236969AbiG0WRs (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 27 Jul 2022 18:17:48 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F9DDAA
        for <linux-cxl@vger.kernel.org>; Wed, 27 Jul 2022 15:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658960207; x=1690496207;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RfMJY+y5j4+BhKgteGY90p3DSKlYWAbwmsbh2Jtxu8Y=;
  b=cKSkXJSI9wH25LyrSlQVbKPr7Np/84YjQff2SEBBHZ9yHhxs1FEaw8Nd
   7kOPP/jc8sPjEu3aLgyYL2Wb7EV0BmFKLEVS3HCmwpHVKpzS4f9Wrstaw
   c/e+ByzUtLPP5Y018EkybjdEv8yuhZi8OGtFK635WIzEPQ/XOWMANQ93g
   p5vNmB0R6eThxpPZdBwb2+jhhBisRPPwKHHinCDikhy2BDa5LukGB/i9F
   8wmk4+qi7gq0eyWCcrfkv5IOr5rfDIdg9O5cj6D7pj+bPe4gttn4wsVy1
   /7n+uefIGoPBZPJIQkNkN4pg1iA6LeEePa5IogGOMv20DjK5poUUoWi60
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10421"; a="289129715"
X-IronPort-AV: E=Sophos;i="5.93,196,1654585200"; 
   d="scan'208";a="289129715"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 15:16:46 -0700
X-IronPort-AV: E=Sophos;i="5.93,196,1654585200"; 
   d="scan'208";a="628562623"
Received: from jihernan-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.251.21.28])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 15:16:46 -0700
Subject: [PATCH] cxl/hdm: Fix DPA reservation vs cxl_endpoint_decoder
 lifetime
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date:   Wed, 27 Jul 2022 15:16:46 -0700
Message-ID: <165896020625.3546860.12390103413706292760.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

After adding support for emulating platform firmware established DPA
reservations, the cxl-topology.sh [1] unit test started crashing with
the following signature:

 general protection fault, probably for non-canonical address 0x6b6b6b6b6b6b6bc3: 0000 [#1] PREEMPT SMP
 [..]
 RIP: 0010:to_cxl_port+0x8/0x60 [cxl_core]
 [..]
 Call Trace:
  <TASK>
  __cxl_dpa_release+0x1b/0xd0 [cxl_core]
  cxl_dpa_release+0x1d/0x30 [cxl_core]
  release_nodes+0x63/0x90
  devres_release_all+0x88/0xc0

...i.e. a use after free of a 'struct cxl_endpoint_decoder' object. This
results from the ordering of init_hdm_decoder() before add_hdm_decoder()
where, at release time, the decoder is unregistered and released before
the DPA reservation.

Fix this by extending the life of the object until all DPA reservations
have been released which also preserves platform decoder settings being
settled by the time the decoder is published in sysfs (KOBJ_ADD time).

Note that the @len == 0 case in __cxl_dpa_reserve() is avoided in
practice as this function is only called for committed decoders and new
non-zero DPA allocations.

Link: https://github.com/pmem/ndctl/blob/pending/test/cxl-topology.sh [1]
Fixes: 9c57cde0dcbd ("cxl/hdm: Enumerate allocated DPA")
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/hdm.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index ee53e8ac5c96..8143e2615957 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -178,6 +178,7 @@ static void __cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
 		__release_region(&cxlds->dpa_res, skip_start, cxled->skip);
 	cxled->skip = 0;
 	cxled->dpa_res = NULL;
+	put_device(&cxled->cxld.dev);
 	port->hdm_end--;
 }
 
@@ -214,7 +215,7 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 	lockdep_assert_held_write(&cxl_dpa_rwsem);
 
 	if (!len)
-		return 0;
+		goto success;
 
 	if (cxled->dpa_res) {
 		dev_dbg(dev, "decoder%d.%d: existing allocation %pr assigned\n",
@@ -266,8 +267,10 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 			cxled->cxld.id, cxled->dpa_res);
 		cxled->mode = CXL_DECODER_MIXED;
 	}
-	port->hdm_end++;
 
+success:
+	port->hdm_end++;
+	get_device(&cxled->cxld.dev);
 	return 0;
 }
 

