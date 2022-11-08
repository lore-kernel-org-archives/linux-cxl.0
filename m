Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4A1C433FE
	for <linux-cxl@archiver.kernel.org>; Tue,  8 Nov 2022 17:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234513AbiKHR0c (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 8 Nov 2022 12:26:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234454AbiKHR01 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 8 Nov 2022 12:26:27 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576BB1DF13
        for <linux-cxl@vger.kernel.org>; Tue,  8 Nov 2022 09:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667928386; x=1699464386;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eiIN4eyQM0LaCjAMpiqCf5fnkzU8wVjh86SoW74alkY=;
  b=ZiABU0ml6ZyGMNVoiyAPbMZ9gqa0Is9n+goARJAULElKo2T4k2PF1rcu
   ctKOo+E3GpFaChQc99c8wl5Y2A3Dt1xOJLoYhsMnksXl26vN9S2V/Bxts
   oiZMVbY2EiFjKd6nCU7RqwO5Q1VEvy7WTRUogM8ugXtB7Y5XF7wrhRMxE
   DpWYEHXwQG3Ig07bxG88sNTynqhemhzA6wpwZxdsruA97052d1euKsskP
   ufB6RTf/Ycr9U04e8+ufGiVQ9r5UY9rwYPqbC6JZ94q0LDvRhdqMJKb33
   idtbv/YY5OREkcdBz/cgQ3f3SRtGjqXxZt8ar/H3GZqTFrj6xEuSSJi7Z
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="291144514"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="291144514"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 09:26:25 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="669629817"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="669629817"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 09:26:25 -0800
Subject: [PATCH v3 11/18] cxl/pmem: Add "Passphrase Secure Erase" security
 command support
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date:   Tue, 08 Nov 2022 10:26:24 -0700
Message-ID: <166792838491.3767969.5093666840089372918.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166792815961.3767969.2621677491424623673.stgit@djiang5-desk3.ch.intel.com>
References: <166792815961.3767969.2621677491424623673.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Create callback function to support the nvdimm_security_ops() ->erase()
callback. Translate the operation to send "Passphrase Secure Erase"
security command for CXL memory device.

When the mem device is secure erased, cpu_cache_invalidate_memregion() is
called in order to invalidate all CPU caches before attempting to access
the mem device again.

See CXL 3.0 spec section 8.2.9.8.6.6 for reference.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/mbox.c      |    1 +
 drivers/cxl/cxlmem.h         |    8 ++++++++
 drivers/cxl/security.c       |   29 +++++++++++++++++++++++++++++
 include/uapi/linux/cxl_mem.h |    1 +
 4 files changed, 39 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 243b01e2de85..4a99d2b1049e 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -70,6 +70,7 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
 	CXL_CMD(DISABLE_PASSPHRASE, 0x40, 0, 0),
 	CXL_CMD(FREEZE_SECURITY, 0, 0, 0),
 	CXL_CMD(UNLOCK, 0x20, 0, 0),
+	CXL_CMD(PASSPHRASE_SECURE_ERASE, 0x40, 0, 0),
 };
 
 /*
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 4e6897e8eb7d..75baeb0bbe57 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -278,6 +278,7 @@ enum cxl_opcode {
 	CXL_MBOX_OP_DISABLE_PASSPHRASE	= 0x4502,
 	CXL_MBOX_OP_UNLOCK		= 0x4503,
 	CXL_MBOX_OP_FREEZE_SECURITY	= 0x4504,
+	CXL_MBOX_OP_PASSPHRASE_SECURE_ERASE	= 0x4505,
 	CXL_MBOX_OP_MAX			= 0x10000
 };
 
@@ -400,6 +401,13 @@ struct cxl_disable_pass {
 	u8 pass[NVDIMM_PASSPHRASE_LEN];
 } __packed;
 
+/* passphrase secure erase payload */
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
index cf20d58ac1b3..631a474939d6 100644
--- a/drivers/cxl/security.c
+++ b/drivers/cxl/security.c
@@ -128,12 +128,41 @@ static int cxl_pmem_security_unlock(struct nvdimm *nvdimm,
 	return 0;
 }
 
+static int cxl_pmem_security_passphrase_erase(struct nvdimm *nvdimm,
+					      const struct nvdimm_key_data *key,
+					      enum nvdimm_passphrase_type ptype)
+{
+	struct cxl_nvdimm *cxl_nvd = nvdimm_provider_data(nvdimm);
+	struct cxl_memdev *cxlmd = cxl_nvd->cxlmd;
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_pass_erase erase;
+	int rc;
+
+	if (!cpu_cache_has_invalidate_memregion())
+		return -EINVAL;
+
+	erase.type = ptype == NVDIMM_MASTER ?
+		CXL_PMEM_SEC_PASS_MASTER : CXL_PMEM_SEC_PASS_USER;
+	memcpy(erase.pass, key->data, NVDIMM_PASSPHRASE_LEN);
+	/* Flush all cache before we erase mem device */
+	cpu_cache_invalidate_memregion(IORES_DESC_PERSISTENT_MEMORY);
+	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_PASSPHRASE_SECURE_ERASE,
+			       &erase, sizeof(erase), NULL, 0);
+	if (rc < 0)
+		return rc;
+
+	/* mem device erased, invalidate all CPU caches before data is read */
+	cpu_cache_invalidate_memregion(IORES_DESC_PERSISTENT_MEMORY);
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
diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
index 95dca8d4584f..82bdad4ce5de 100644
--- a/include/uapi/linux/cxl_mem.h
+++ b/include/uapi/linux/cxl_mem.h
@@ -46,6 +46,7 @@
 	___C(DISABLE_PASSPHRASE, "Disable Passphrase"),			  \
 	___C(FREEZE_SECURITY, "Freeze Security"),			  \
 	___C(UNLOCK, "Unlock"),						  \
+	___C(PASSPHRASE_SECURE_ERASE, "Passphrase Secure Erase"),	  \
 	___C(MAX, "invalid / last command")
 
 #define ___C(a, b) CXL_MEM_COMMAND_ID_##a


