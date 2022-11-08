Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6001C43219
	for <linux-cxl@archiver.kernel.org>; Tue,  8 Nov 2022 17:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234378AbiKHR1O (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 8 Nov 2022 12:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234373AbiKHR0g (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 8 Nov 2022 12:26:36 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B68958013
        for <linux-cxl@vger.kernel.org>; Tue,  8 Nov 2022 09:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667928393; x=1699464393;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cPIE4LC7mms4p8LW6nwgmVCNIo/V1BCOypYTc71yoBw=;
  b=NYF9BNEZdTO6zDbDSatzKvjTWNB1A5c4LkOme7HbQc5lcEktiSfQ9UQ3
   Hh7thkNt3j7b2M9X+046xvQiLz9fTSle0jcdfBn3EVKIQ6EGS+ph6QGwd
   AO84qbVwgOFklQJ5J7sSi1CojwczxOF/DKqS1rN4pLvIxhoo/uaojpOdd
   V6RxYGfSTVWd+rwW1WtFru6uiJJYdKfqMY7Ybk6gva7MDPxY9LZf+Kb+w
   lHTsCj0xEBlbeEyhs9fgXygyomWq+jazOSUwXKh13mn8yfyV64bJnYMx8
   f7jITOTkeYXGshGTyZcC3GGEzcWaG4jOdLsJx4MZ11iYAB5P8K8Nug5he
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="309465305"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="309465305"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 09:26:33 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="669629837"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="669629837"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 09:26:31 -0800
Subject: [PATCH v3 12/18] tools/testing/cxl: Add "passphrase secure erase"
 opcode support
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date:   Tue, 08 Nov 2022 10:26:30 -0700
Message-ID: <166792839079.3767969.17718924625264191957.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166792815961.3767969.2621677491424623673.stgit@djiang5-desk3.ch.intel.com>
References: <166792815961.3767969.2621677491424623673.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Add support to emulate a CXL mem device support the "passphrase secure
erase" operation.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 tools/testing/cxl/test/mem.c |   59 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 90607597b9a4..aa6dda21bc5f 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -362,6 +362,62 @@ static int mock_unlock_security(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd
 	return 0;
 }
 
+static int mock_passphrase_secure_erase(struct cxl_dev_state *cxlds,
+					struct cxl_mbox_cmd *cmd)
+{
+	struct cxl_mock_mem_pdata *mdata = dev_get_platdata(cxlds->dev);
+	struct cxl_pass_erase *erase;
+
+	if (cmd->size_in != sizeof(*erase))
+		return -EINVAL;
+
+	if (cmd->size_out != 0)
+		return -EINVAL;
+
+	erase = cmd->payload_in;
+	if (mdata->security_state & CXL_PMEM_SEC_STATE_FROZEN &&
+	    erase->type != CXL_PMEM_SEC_PASS_MASTER) {
+		cmd->return_code = CXL_MBOX_CMD_RC_SECURITY;
+		return -ENXIO;
+	}
+
+	if (mdata->security_state & CXL_PMEM_SEC_STATE_USER_PLIMIT) {
+		cmd->return_code = CXL_MBOX_CMD_RC_SECURITY;
+		return -ENXIO;
+	}
+
+	if (erase->type == CXL_PMEM_SEC_PASS_MASTER &&
+	    mdata->security_state & CXL_PMEM_SEC_STATE_MASTER_PASS_SET) {
+		if (memcmp(mdata->master_pass, erase->pass, NVDIMM_PASSPHRASE_LEN)) {
+			master_plimit_check(mdata);
+			cmd->return_code = CXL_MBOX_CMD_RC_PASSPHRASE;
+			return -ENXIO;
+		}
+		mdata->master_limit = 0;
+		mdata->user_limit = 0;
+		mdata->security_state &= ~CXL_PMEM_SEC_STATE_USER_PASS_SET;
+		memset(mdata->user_pass, 0, NVDIMM_PASSPHRASE_LEN);
+		mdata->security_state &= ~CXL_PMEM_SEC_STATE_LOCKED;
+		return 0;
+	}
+
+	if (erase->type == CXL_PMEM_SEC_PASS_USER &&
+	    mdata->security_state & CXL_PMEM_SEC_STATE_USER_PASS_SET) {
+		if (memcmp(mdata->user_pass, erase->pass, NVDIMM_PASSPHRASE_LEN)) {
+			user_plimit_check(mdata);
+			cmd->return_code = CXL_MBOX_CMD_RC_PASSPHRASE;
+			return -ENXIO;
+		}
+
+		mdata->user_limit = 0;
+		mdata->security_state &= ~CXL_PMEM_SEC_STATE_USER_PASS_SET;
+		memset(mdata->user_pass, 0, NVDIMM_PASSPHRASE_LEN);
+		return 0;
+	}
+
+	return 0;
+}
+
 static int mock_get_lsa(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
 {
 	struct cxl_mbox_get_lsa *get_lsa = cmd->payload_in;
@@ -470,6 +526,9 @@ static int cxl_mock_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *
 	case CXL_MBOX_OP_UNLOCK:
 		rc = mock_unlock_security(cxlds, cmd);
 		break;
+	case CXL_MBOX_OP_PASSPHRASE_SECURE_ERASE:
+		rc = mock_passphrase_secure_erase(cxlds, cmd);
+		break;
 	default:
 		break;
 	}


