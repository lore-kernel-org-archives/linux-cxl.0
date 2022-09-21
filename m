Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC3EFECAAD8
	for <linux-cxl@archiver.kernel.org>; Wed, 21 Sep 2022 15:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbiIUPhS (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 21 Sep 2022 11:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbiIUPhB (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 21 Sep 2022 11:37:01 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB48D9AF85
        for <linux-cxl@vger.kernel.org>; Wed, 21 Sep 2022 08:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663774404; x=1695310404;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sEmO4iqX0vz/bl7jA5tl6eNxVxP/xg2TOeDvXKiGC6I=;
  b=Hx6tXv2X/aY5kudxyS+I+62g98rE1YxEIAxwF1PABipWHWHPL1hBuHXy
   F+PXaJMpgwGkPYdK5twefZ2QC1D93tmOIH4eILulW5qAnIxj/GCL92ksy
   tJMfeXacMfb3Sc50DbK5LD+LNUp6vzi6vewspYr2xS7TN3hKg7Buv9sTa
   uG2tXy9wBmOf0JHPQ5J5B6bIY+m6L58+igdAI2VTr/J4WBDf4PoQfyt1S
   wLfEnk0O89xp5BZy9uW2g3+QE2TJVyMDwcuulBfvdyLIWSZ4aNn6a73d2
   2GGvLC7XMUSZMhR5UftIdfXuLnPVWTv1NHelRf073md1ppMW1Ip/P3dEu
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="361796203"
X-IronPort-AV: E=Sophos;i="5.93,333,1654585200"; 
   d="scan'208";a="361796203"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 08:32:17 -0700
X-IronPort-AV: E=Sophos;i="5.93,333,1654585200"; 
   d="scan'208";a="597034656"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 08:32:16 -0700
Subject: [PATCH v2 08/19] cxl/pmem: Add "Freeze Security State" security
 command support
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     nvdimm@lists.linux.dev, dan.j.williams@intel.com,
        bwidawsk@kernel.org, ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, dave@stgolabs.net,
        Jonathan.Cameron@huawei.com
Date:   Wed, 21 Sep 2022 08:32:16 -0700
Message-ID: <166377433634.430546.8484308346097721389.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166377414787.430546.3863229455285366312.stgit@djiang5-desk3.ch.intel.com>
References: <166377414787.430546.3863229455285366312.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Create callback function to support the nvdimm_security_ops() ->freeze()
callback. Translate the operation to send "Freeze Security State" security
command for CXL memory device.

See CXL 2.0 spec section 8.2.9.5.6.5 for reference.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/mbox.c      |    1 +
 drivers/cxl/cxlmem.h         |    1 +
 drivers/cxl/security.c       |   10 ++++++++++
 include/uapi/linux/cxl_mem.h |    1 +
 4 files changed, 13 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 2563325db0f6..6b8f118b2604 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -68,6 +68,7 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
 	CXL_CMD(GET_SECURITY_STATE, 0, 0x4, 0),
 	CXL_CMD(SET_PASSPHRASE, 0x60, 0, 0),
 	CXL_CMD(DISABLE_PASSPHRASE, 0x40, 0, 0),
+	CXL_CMD(FREEZE_SECURITY, 0, 0, 0),
 };
 
 /*
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 9ad92f975b78..9007158969fe 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -276,6 +276,7 @@ enum cxl_opcode {
 	CXL_MBOX_OP_GET_SECURITY_STATE	= 0x4500,
 	CXL_MBOX_OP_SET_PASSPHRASE	= 0x4501,
 	CXL_MBOX_OP_DISABLE_PASSPHRASE	= 0x4502,
+	CXL_MBOX_OP_FREEZE_SECURITY	= 0x4504,
 	CXL_MBOX_OP_MAX			= 0x10000
 };
 
diff --git a/drivers/cxl/security.c b/drivers/cxl/security.c
index 85b4c1f86881..d991cbee3531 100644
--- a/drivers/cxl/security.c
+++ b/drivers/cxl/security.c
@@ -95,10 +95,20 @@ static int cxl_pmem_security_disable(struct nvdimm *nvdimm,
 	return rc;
 }
 
+static int cxl_pmem_security_freeze(struct nvdimm *nvdimm)
+{
+	struct cxl_nvdimm *cxl_nvd = nvdimm_provider_data(nvdimm);
+	struct cxl_memdev *cxlmd = cxl_nvd->cxlmd;
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+
+	return cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_FREEZE_SECURITY, NULL, 0, NULL, 0);
+}
+
 static const struct nvdimm_security_ops __cxl_security_ops = {
 	.get_flags = cxl_pmem_get_security_flags,
 	.change_key = cxl_pmem_security_change_key,
 	.disable = cxl_pmem_security_disable,
+	.freeze = cxl_pmem_security_freeze,
 };
 
 const struct nvdimm_security_ops *cxl_security_ops = &__cxl_security_ops;
diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
index f6d383a80f22..7c0adcd68f4c 100644
--- a/include/uapi/linux/cxl_mem.h
+++ b/include/uapi/linux/cxl_mem.h
@@ -44,6 +44,7 @@
 	___C(GET_SECURITY_STATE, "Get Security State"),			  \
 	___C(SET_PASSPHRASE, "Set Passphrase"),				  \
 	___C(DISABLE_PASSPHRASE, "Disable Passphrase"),			  \
+	___C(FREEZE_SECURITY, "Freeze Security"),			  \
 	___C(MAX, "invalid / last command")
 
 #define ___C(a, b) CXL_MEM_COMMAND_ID_##a


