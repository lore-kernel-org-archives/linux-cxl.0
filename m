Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AAB9C43334
	for <linux-cxl@archiver.kernel.org>; Fri, 15 Jul 2022 21:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbiGOVKO (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 15 Jul 2022 17:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbiGOVJ4 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 15 Jul 2022 17:09:56 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C72E8720A
        for <linux-cxl@vger.kernel.org>; Fri, 15 Jul 2022 14:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657919390; x=1689455390;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L/mYFlodFVBIt1ciLDhpJOinYXzfR4o+44dbw4W6rrc=;
  b=OqaTkFi90K9f0+IHeRJjNtOGU2+Lfgk++uvdonkgauSWRuA6EPfzoCtS
   2K2e+kLH7nFFusnErIdRggwq1DHi1PkgJjmjN7C9TDnUxmOmW35CTxhAb
   CtS7JIUC/NtdUQdPP+xZCz8ETta/2Xc3augWcHVU6XC2pAAhj3y1fR83g
   w+uk/WtY8F/cHnIvdSVLQ0q7quzZxOpTpPj/ithdMpCAcJFNoEsKipMVE
   nXV879PrJEAxTG0WJicNMRkVIZ+zSfb0C/DYfrJtrSF2R8s0O4Jo0vkGS
   /hIHf5M7hWmAhWLnPq7KYSl0oIYmU2QVY0YmugCwPnZ6Ag1dwbBCjwJpw
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10409"; a="347588043"
X-IronPort-AV: E=Sophos;i="5.92,275,1650956400"; 
   d="scan'208";a="347588043"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 14:09:49 -0700
X-IronPort-AV: E=Sophos;i="5.92,275,1650956400"; 
   d="scan'208";a="571680911"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 14:09:48 -0700
Subject: [PATCH RFC 13/15] cxl/pmem: Add "Passphrase Secure Erase" security
 command support
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev
Cc:     dan.j.williams@intel.com, bwidawsk@kernel.org, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        dave@stgolabs.net
Date:   Fri, 15 Jul 2022 14:09:48 -0700
Message-ID: <165791938847.2491387.8701829648751368015.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <165791918718.2491387.4203738301057301285.stgit@djiang5-desk3.ch.intel.com>
References: <165791918718.2491387.4203738301057301285.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Create callback function to support the nvdimm_security_ops() ->erase()
callback. Translate the operation to send "Passphrase Secure Erase"
security command for CXL memory device.

When the mem device is secure erased, arch_invalidate_nvdimm_cache() is
called in order to invalidate all CPU caches before attempting to access
the mem device again.

See CXL 2.0 spec section 8.2.9.5.6.6 for reference.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/cxlmem.h   |    8 ++++++++
 drivers/cxl/security.c |   29 +++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index ae8ccd484491..4bcb02f625b4 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -255,6 +255,7 @@ enum cxl_opcode {
 	CXL_MBOX_OP_DISABLE_PASSPHRASE	= 0x4502,
 	CXL_MBOX_OP_UNLOCK		= 0x4503,
 	CXL_MBOX_OP_FREEZE_SECURITY	= 0x4504,
+	CXL_MBOX_OP_PASSPHRASE_ERASE	= 0x4505,
 	CXL_MBOX_OP_MAX			= 0x10000
 };
 
@@ -369,6 +370,13 @@ struct cxl_disable_pass {
 	u8 pass[NVDIMM_PASSPHRASE_LEN];
 } __packed;
 
+/* passphrase erase payload */
+struct cxl_pass_erase {
+	u8 type;
+	u8 reserved[31];
+	u8 pass[NVDIMM_PASSPHRASE_LEN];
+} __packed;
+
 enum {
 	CXL_PMEM_SEC_PASS_MASTER = 0,
 	CXL_PMEM_SEC_PASS_USER,
diff --git a/drivers/cxl/security.c b/drivers/cxl/security.c
index d15520f280f0..4add7f62e758 100644
--- a/drivers/cxl/security.c
+++ b/drivers/cxl/security.c
@@ -134,12 +134,41 @@ static int cxl_pmem_security_unlock(struct nvdimm *nvdimm,
 	return 0;
 }
 
+static int cxl_pmem_security_passphrase_erase(struct nvdimm *nvdimm,
+					      const struct nvdimm_key_data *key,
+					      enum nvdimm_passphrase_type ptype)
+{
+	struct cxl_nvdimm *cxl_nvd = nvdimm_provider_data(nvdimm);
+	struct cxl_memdev *cxlmd = cxl_nvd->cxlmd;
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_pass_erase *erase;
+	int rc;
+
+	erase = kzalloc(sizeof(*erase), GFP_KERNEL);
+	if (!erase)
+		return -ENOMEM;
+
+	erase->type = ptype == NVDIMM_MASTER ?
+		CXL_PMEM_SEC_PASS_MASTER : CXL_PMEM_SEC_PASS_USER;
+	memcpy(erase->pass, key->data, NVDIMM_PASSPHRASE_LEN);
+	rc =  cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_PASSPHRASE_ERASE,
+				erase, sizeof(*erase), NULL, 0);
+	kfree(erase);
+	if (rc < 0)
+		return rc;
+
+	/* DIMM erased, invalidate all CPU caches before we read it */
+	arch_invalidate_nvdimm_cache();
+	return 0;
+}
+
 static const struct nvdimm_security_ops __cxl_security_ops = {
 	.get_flags = cxl_pmem_get_security_flags,
 	.change_key = cxl_pmem_security_change_key,
 	.disable = cxl_pmem_security_disable,
 	.freeze = cxl_pmem_security_freeze,
 	.unlock = cxl_pmem_security_unlock,
+	.erase = cxl_pmem_security_passphrase_erase,
 };
 
 const struct nvdimm_security_ops *cxl_security_ops = &__cxl_security_ops;


