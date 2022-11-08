Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5F7C433FE
	for <linux-cxl@archiver.kernel.org>; Tue,  8 Nov 2022 17:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234136AbiKHR0U (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 8 Nov 2022 12:26:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234528AbiKHR0O (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 8 Nov 2022 12:26:14 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D2358037
        for <linux-cxl@vger.kernel.org>; Tue,  8 Nov 2022 09:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667928369; x=1699464369;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ed3mErKgjNM1+fOixKcxiX5To77fam1chdRaKAbp6w8=;
  b=WzvVFvHsmoNObM8kPj/n4R9WehBXaieK2MqBMg+IAADYOHaa4/7Q11Cr
   RoOY8+mJpEzFfwvO17lyUANkv0yJJtlUU6pXNDtC16Drv+/fMwzRK1YnB
   /9vYkand0e3csHdKxNyAUuU22ELGTBMDcQ1Z+br2qOPzXeym2o+cnYytv
   YtoUWkus8q/5l/KKQUfEUSUeXHdhYaaovfhpRwbTgCcdcRuMYMDWZ9W4u
   JKwSk+c2gc8MZgG+r+N9tbWHzEABpUjYwKChvocfPo19dso2rbIYZRIlI
   csBFBhBHlLU+ufVBPUyCQiNKXPwxIVdZu131Y62KVSw56vcyXY+Q+cUGG
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="375029763"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="375029763"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 09:26:02 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="742038900"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="742038900"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 09:26:01 -0800
Subject: [PATCH v3 07/18] cxl/pmem: Add "Freeze Security State" security
 command support
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date:   Tue, 08 Nov 2022 10:26:01 -0700
Message-ID: <166792836140.3767969.14852087206799797632.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166792815961.3767969.2621677491424623673.stgit@djiang5-desk3.ch.intel.com>
References: <166792815961.3767969.2621677491424623673.stgit@djiang5-desk3.ch.intel.com>
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

See CXL rev3.0 spec section 8.2.9.8.6.5 for reference.

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
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


