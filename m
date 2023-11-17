Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qvd9qQ2P"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D398D6A
	for <linux-cxl@vger.kernel.org>; Fri, 17 Nov 2023 10:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700245349; x=1731781349;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uXzL4IV3tv9S6EWRvJnLj4Ikgc+JTB4kzIacQT8qLk0=;
  b=Qvd9qQ2PLzB7xCe8sXFDbfAK6Obdm2tkLl2x/D/6h4K14VSCm/WYqpHp
   JrgBdjjXY2GU3GF2uX1VTGdKM/q7IXEmTCiGqg+CCKi2IQKZsXKHKyqpZ
   v17/JtI1Mn0wJeCWAGAKRKjtDb/0FDWPKHYiLaQ0CoqSeAJBtH9I+TFN5
   i/LKKFXkwU/HFTiidyoU9cz/mUnqN1zengaW4TVS3rPcsMTDINU8nd/K4
   NiQl0OHirKahlrmiee9ln8FPLnvBtH2Nxr+PtvNjKsAuStYAs9B24NY//
   BAZo04dcojQSan+Api1Bpz3efLye3SgVgiDqZZuDK37wIXiF0ixuyMmAi
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="12897633"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="12897633"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 10:22:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="1097169441"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="1097169441"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.64.85])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 10:22:28 -0800
Subject: [PATCH v2] cxl: Add cxl_region_rwsem around commit_end write during
 decoder enumeration
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net,
 peterz@infradead.org
Date: Fri, 17 Nov 2023 11:22:28 -0700
Message-ID: <170024534807.2141355.15008645558355252180.stgit@djiang5-mobl3>
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
v2:
- Add changes from Ira and moving the lock block
- Add suggestion from Dan on using guard()
---
 drivers/cxl/core/hdm.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 1cc9be85ba4c..5be17dbc6053 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -839,19 +839,22 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 			cxld->target_type = CXL_DECODER_HOSTONLYMEM;
 		else
 			cxld->target_type = CXL_DECODER_DEVMEM;
-		if (cxld->id != cxl_num_decoders_committed(port)) {
+
+		if (size == 0) {
 			dev_warn(&port->dev,
-				 "decoder%d.%d: Committed out of order\n",
+				 "decoder%d.%d: Committed with zero size\n",
 				 port->id, cxld->id);
 			return -ENXIO;
 		}
 
-		if (size == 0) {
+		guard(rwsem_write)(&cxl_region_rwsem);
+		if (cxld->id != cxl_num_decoders_committed(port)) {
 			dev_warn(&port->dev,
-				 "decoder%d.%d: Committed with zero size\n",
+				 "decoder%d.%d: Committed out of order\n",
 				 port->id, cxld->id);
 			return -ENXIO;
 		}
+
 		port->commit_end = cxld->id;
 	} else {
 		if (cxled) {


