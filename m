Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5883C3A5A7
	for <linux-cxl@archiver.kernel.org>; Tue,  6 Dec 2022 04:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbiLFEWb (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 5 Dec 2022 23:22:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiLFEW3 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 5 Dec 2022 23:22:29 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8B8218AB
        for <linux-cxl@vger.kernel.org>; Mon,  5 Dec 2022 20:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670300549; x=1701836549;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QR2QEL0tBuniYEc6ouf62LmnIGOs6zYA38xahXJtmwk=;
  b=XLP9vTR8NFG8ipTBQcTtpm4qxbXTajTvgKQyAWx+unUD53n0Ap4lOJkY
   EhU8reRVF3mMJUWLrJx3IId2etPItyrCEaNw3pXEInfyw8/jXyhQp9+Ir
   IBcSK7PXuerFw3N2GxsykWEIfKstBEsdZWsfzoWOBtfnEwsK/FvPYkbgG
   Je/0ShIwzwXFpoAwLV4WNgxOG/8ZAaZRpW8ibiH0xA071ZpzOUP6Db72N
   DDqW/mlDJoLgzSnQ9+Z4cj/VwdGB5drWj9ogoOPPn1tdj0Rpnvf+wYKnZ
   gJMi1n/PR0kQTRLQFTSOTdpGZIJpLb8mxPez+xK0WOAK9gGGk3xC/8ZR8
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="315238639"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="315238639"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 20:22:28 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="639733708"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="639733708"
Received: from bmnebren-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.114.171])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 20:22:28 -0800
Subject: [PATCH 1/4] cxl/security: Fix Get Security State output payload
 endian handling
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>, dave.jiang@intel.com,
        ira.weiny@intel.com
Date:   Mon, 05 Dec 2022 20:22:28 -0800
Message-ID: <167030054822.4044561.4917796262037689553.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <167030054261.4044561.2164047490200738083.stgit@dwillia2-xfh.jf.intel.com>
References: <167030054261.4044561.2164047490200738083.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Multi-byte integer values in CXL mailbox payloads are little endian. Add
a definition of the Get Security State output payload and convert the
value before testing flags.

Fixes: 328281155539 ("cxl/pmem: Introduce nvdimm_security_ops with ->get_flags() operation")
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/security.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/security.c b/drivers/cxl/security.c
index 5484d4eecfd1..ebb78b8944f5 100644
--- a/drivers/cxl/security.c
+++ b/drivers/cxl/security.c
@@ -16,14 +16,18 @@ static unsigned long cxl_pmem_get_security_flags(struct nvdimm *nvdimm,
 	struct cxl_memdev *cxlmd = cxl_nvd->cxlmd;
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	unsigned long security_flags = 0;
+	struct cxl_get_security_output {
+		__le32 flags;
+	} out;
 	u32 sec_out;
 	int rc;
 
 	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_GET_SECURITY_STATE, NULL, 0,
-			       &sec_out, sizeof(sec_out));
+			       &out, sizeof(out));
 	if (rc < 0)
 		return 0;
 
+	sec_out = le32_to_cpu(out.flags);
 	if (ptype == NVDIMM_MASTER) {
 		if (sec_out & CXL_PMEM_SEC_STATE_MASTER_PASS_SET)
 			set_bit(NVDIMM_SECURITY_UNLOCKED, &security_flags);

