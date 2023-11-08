Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C92618C3A
	for <linux-cxl@vger.kernel.org>; Wed,  8 Nov 2023 22:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e3mMTE14"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14620213B
	for <linux-cxl@vger.kernel.org>; Wed,  8 Nov 2023 14:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699481110; x=1731017110;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Vm4KEEJ60VtM+/xalsMFZc33JA7Haz2uaPn8iqA1FGc=;
  b=e3mMTE14OyNXcytTtdtr9MXCqKS+9Nxlio++7dTgxC4qjoSK9e49Mxl5
   EwnOxk9NivdCCcWQNcCYnUqHEnewShLuBqdAKRwnUEVMhvxsDBdaGttaP
   kSCUWisJGbv4S/1Yz4NGS+s+CFDgfVqXIt9RiOKmOX3CJq9VIk5qik3RP
   CY4KLV4TP0T+j9Bo00E5m7V6Dfhq5AOh+SeZFbdKU9FASvd08M9aM8vkh
   3lfn2gV18VfSYhENaQvTwe4h99NlQQFxh2RT5SNMycIPKv55pziWsUQyB
   zhvKEYuwrLWjfYTAITYyJqXwnu5VfMeIqj4jUE6ByR0ciBrgm1gTQz8WO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="374909193"
X-IronPort-AV: E=Sophos;i="6.03,287,1694761200"; 
   d="scan'208";a="374909193"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 14:05:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="829107540"
X-IronPort-AV: E=Sophos;i="6.03,287,1694761200"; 
   d="scan'208";a="829107540"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.76.61])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 14:05:08 -0800
Subject: [PATCH] cxl: Add cxl_region_rwsem around commit_end write during
 decoder enumeration
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com
Date: Wed, 08 Nov 2023 15:05:08 -0700
Message-ID: <169948110840.509375.13862681045079385425.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

init_hdm_decoder() modifies port->commit_end without taking the
cxl_region_rwsem. An assert splat emitted by cxl_num_decoders_committed().
However looking at the code, it looks like the write version of the rwsem
needs to be taken due to the modification of commit_end. Wrap the write
version of the rwsem around reading and writing of commit_end.

Fixes: 176baefb2eb5 ("cxl/hdm: Commit decoder state to hardware")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/hdm.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index bc8ad4a8afca..a8f960c496cb 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -854,10 +854,12 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 			cxld->target_type = CXL_DECODER_HOSTONLYMEM;
 		else
 			cxld->target_type = CXL_DECODER_DEVMEM;
+		down_write(&cxl_region_rwsem);
 		if (cxld->id != cxl_num_decoders_committed(port)) {
 			dev_warn(&port->dev,
 				 "decoder%d.%d: Committed out of order\n",
 				 port->id, cxld->id);
+			up_write(&cxl_region_rwsem);
 			return -ENXIO;
 		}
 
@@ -865,9 +867,11 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 			dev_warn(&port->dev,
 				 "decoder%d.%d: Committed with zero size\n",
 				 port->id, cxld->id);
+			up_write(&cxl_region_rwsem);
 			return -ENXIO;
 		}
 		port->commit_end = cxld->id;
+		up_write(&cxl_region_rwsem);
 	} else {
 		if (cxled) {
 			struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);


