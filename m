Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71393C433EF
	for <linux-cxl@archiver.kernel.org>; Fri, 15 Jul 2022 21:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiGOVJK (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 15 Jul 2022 17:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiGOVJJ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 15 Jul 2022 17:09:09 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613B13FA20
        for <linux-cxl@vger.kernel.org>; Fri, 15 Jul 2022 14:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657919348; x=1689455348;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dBQENS3znweCF0yiR8zGCtWQ5lG/ElS4TNT6oglovdw=;
  b=JyLgtx98eLOxZXnjRgBOsvGGXZOCBHVWQkver2h1dfeNC8ueU0RgLZmL
   nu1fQCgIyyS9hY39hjum9oL2HCBZLuOHr3RVQv4Lyk+sVF3mca+LxtTCp
   5WHGgIqvuL4O6Ym+n3KknuhGerLPfCtaPLrReXIFV/3SgDkOPRAOwo04R
   hh0V/t/M1B7BhqkdzOsuuws3z9czS9in6pggduEjOMJbW+XBrDwCzaM5N
   jfifx3OdrQDCfD168yHUuPPeLvmHj+0ANSmWykP3ymtPYuoFWtTEsLRqO
   kv9c0bef7xqENwrLbrHGj3VuKcWuFmcnM7reQU/5tzLJznKYVcIbjpr5H
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10409"; a="284659349"
X-IronPort-AV: E=Sophos;i="5.92,275,1650956400"; 
   d="scan'208";a="284659349"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 14:09:08 -0700
X-IronPort-AV: E=Sophos;i="5.92,275,1650956400"; 
   d="scan'208";a="629248825"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 14:09:07 -0700
Subject: [PATCH RFC 06/15] cxl/pmem: Add Disable Passphrase security command
 support
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev
Cc:     dan.j.williams@intel.com, bwidawsk@kernel.org, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        dave@stgolabs.net
Date:   Fri, 15 Jul 2022 14:09:07 -0700
Message-ID: <165791934720.2491387.11236603584810515256.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <165791918718.2491387.4203738301057301285.stgit@djiang5-desk3.ch.intel.com>
References: <165791918718.2491387.4203738301057301285.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Create callback function to support the nvdimm_security_ops ->disable()
callback. Translate the operation to send "Disable Passphrase" security
command for CXL memory device. The operation supports disabling a
passphrase for the CXL persistent memory device. In the original
implementation of nvdimm_security_ops, this operation only supports
disabling of the user passphrase. This is due to the NFIT version of
disable passphrase only supported disabling of user passphrase. The CXL
spec allows disabling of the master passphrase as well which
nvidmm_security_ops does not support yet. In this commit, the callback
function will only support user passphrase.

See CXL 2.0 spec section 8.2.9.5.6.3 for reference.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/cxlmem.h   |    8 ++++++++
 drivers/cxl/security.c |   30 ++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 1e76d22f4fd2..70a1eb7720d3 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -252,6 +252,7 @@ enum cxl_opcode {
 	CXL_MBOX_OP_GET_SCAN_MEDIA	= 0x4305,
 	CXL_MBOX_OP_GET_SECURITY_STATE	= 0x4500,
 	CXL_MBOX_OP_SET_PASSPHRASE	= 0x4501,
+	CXL_MBOX_OP_DISABLE_PASSPHRASE	= 0x4502,
 	CXL_MBOX_OP_MAX			= 0x10000
 };
 
@@ -359,6 +360,13 @@ struct cxl_set_pass {
 	u8 new_pass[NVDIMM_PASSPHRASE_LEN];
 } __packed;
 
+/* disable passphrase input payload */
+struct cxl_disable_pass {
+	u8 type;
+	u8 reserved[31];
+	u8 pass[NVDIMM_PASSPHRASE_LEN];
+} __packed;
+
 enum {
 	CXL_PMEM_SEC_PASS_MASTER = 0,
 	CXL_PMEM_SEC_PASS_USER,
diff --git a/drivers/cxl/security.c b/drivers/cxl/security.c
index 76ec5087f966..4aec8e41e167 100644
--- a/drivers/cxl/security.c
+++ b/drivers/cxl/security.c
@@ -76,9 +76,39 @@ static int cxl_pmem_security_change_key(struct nvdimm *nvdimm,
 	return rc;
 }
 
+static int cxl_pmem_security_disable(struct nvdimm *nvdimm,
+				     const struct nvdimm_key_data *key_data)
+{
+	struct cxl_nvdimm *cxl_nvd = nvdimm_provider_data(nvdimm);
+	struct cxl_memdev *cxlmd = cxl_nvd->cxlmd;
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_disable_pass *dis_pass;
+	int rc;
+
+	dis_pass = kzalloc(sizeof(*dis_pass), GFP_KERNEL);
+	if (!dis_pass)
+		return -ENOMEM;
+
+	/*
+	 * While the CXL spec defines the ability to erase the master passphrase,
+	 * the original nvdimm security ops does not provide that capability.
+	 * In order to preserve backward compatibility, this callback will
+	 * only support disable of user passphrase. The disable master passphrase
+	 * ability will need to be added as a new callback.
+	 */
+	dis_pass->type = CXL_PMEM_SEC_PASS_USER;
+	memcpy(dis_pass->pass, key_data->data, NVDIMM_PASSPHRASE_LEN);
+
+	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_DISABLE_PASSPHRASE,
+			       dis_pass, sizeof(*dis_pass), NULL, 0);
+	kfree(dis_pass);
+	return rc;
+}
+
 static const struct nvdimm_security_ops __cxl_security_ops = {
 	.get_flags = cxl_pmem_get_security_flags,
 	.change_key = cxl_pmem_security_change_key,
+	.disable = cxl_pmem_security_disable,
 };
 
 const struct nvdimm_security_ops *cxl_security_ops = &__cxl_security_ops;


