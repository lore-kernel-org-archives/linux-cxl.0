Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB276C43217
	for <linux-cxl@archiver.kernel.org>; Thu, 11 Nov 2021 20:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C64A861212
	for <linux-cxl@archiver.kernel.org>; Thu, 11 Nov 2021 20:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233975AbhKKUrq (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 11 Nov 2021 15:47:46 -0500
Received: from mga03.intel.com ([134.134.136.65]:41135 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233940AbhKKUrq (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 11 Nov 2021 15:47:46 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10165"; a="232953041"
X-IronPort-AV: E=Sophos;i="5.87,226,1631602800"; 
   d="scan'208";a="232953041"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 12:44:56 -0800
X-IronPort-AV: E=Sophos;i="5.87,226,1631602800"; 
   d="scan'208";a="504579084"
Received: from dmamols-mobl1.amr.corp.intel.com (HELO vverma7-desk.amr.corp.intel.com) ([10.255.92.53])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 12:44:56 -0800
From:   Vishal Verma <vishal.l.verma@intel.com>
To:     <linux-cxl@vger.kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        <nvdimm@lists.linux.dev>, Vishal Verma <vishal.l.verma@intel.com>
Subject: [ndctl PATCH v5 11/16] libcxl: add interfaces for label operations
Date:   Thu, 11 Nov 2021 13:44:31 -0700
Message-Id: <20211111204436.1560365-12-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211111204436.1560365-1-vishal.l.verma@intel.com>
References: <20211111204436.1560365-1-vishal.l.verma@intel.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6778; h=from:subject; bh=bJRx/rlaLxFFyEJeobZTGTjwYu8yACPIqaFSiBPKM2g=; b=owGbwMvMwCHGf25diOft7jLG02pJDIm9DZs2v6llMV65lI9p94ovbxjnPP50eGry5b3HbV9PnbWt 0sHjRkcpC4MYB4OsmCLL3z0fGY/Jbc/nCUxwhJnDygQyhIGLUwAmcjuT4Z9hbPet5OzoQKcnpzzu+L 3wLexQX70qOndRU57VzjkCb90YGfr3rDrCaLHj7BS+R+onzr98zJda+5rJ/V2o7+xp5r4M0/gA
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp; fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Add libcxl interfaces to allow performinfg label (LSA) manipulations.
Add a 'cxl_cmd_new_set_lsa' interface to create a 'Set LSA' mailbox
command payload, and interfaces to read, write, and zero the LSA area on
a memdev.

Cc: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 cxl/lib/private.h  |   6 ++
 cxl/lib/libcxl.c   | 158 +++++++++++++++++++++++++++++++++++++++++++++
 cxl/libcxl.h       |   8 +++
 cxl/lib/libcxl.sym |   4 ++
 4 files changed, 176 insertions(+)

diff --git a/cxl/lib/private.h b/cxl/lib/private.h
index 2f0b6ea..375ba22 100644
--- a/cxl/lib/private.h
+++ b/cxl/lib/private.h
@@ -88,6 +88,12 @@ struct cxl_cmd_get_lsa_in {
 	le32 length;
 } __attribute__((packed));
 
+struct cxl_cmd_set_lsa {
+	le32 offset;
+	le32 rsvd;
+	unsigned char lsa_data[0];
+} __attribute__ ((packed));
+
 struct cxl_cmd_get_health_info {
 	u8 health_status;
 	u8 media_status;
diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
index 7bc0696..a63e18f 100644
--- a/cxl/lib/libcxl.c
+++ b/cxl/lib/libcxl.c
@@ -1197,3 +1197,161 @@ CXL_EXPORT int cxl_cmd_get_out_size(struct cxl_cmd *cmd)
 {
 	return cmd->send_cmd->out.size;
 }
+
+CXL_EXPORT struct cxl_cmd *cxl_cmd_new_write_label(struct cxl_memdev *memdev,
+		void *lsa_buf, unsigned int offset, unsigned int length)
+{
+	struct cxl_ctx *ctx = cxl_memdev_get_ctx(memdev);
+	struct cxl_cmd_set_lsa *set_lsa;
+	struct cxl_cmd *cmd;
+	int rc;
+
+	cmd = cxl_cmd_new_generic(memdev, CXL_MEM_COMMAND_ID_SET_LSA);
+	if (!cmd)
+		return NULL;
+
+	/* this will allocate 'in.payload' */
+	rc = cxl_cmd_set_input_payload(cmd, NULL, sizeof(*set_lsa) + length);
+	if (rc) {
+		err(ctx, "%s: cmd setup failed: %s\n",
+			cxl_memdev_get_devname(memdev), strerror(-rc));
+		goto out_fail;
+	}
+	set_lsa = (struct cxl_cmd_set_lsa *)cmd->send_cmd->in.payload;
+	set_lsa->offset = cpu_to_le32(offset);
+	memcpy(set_lsa->lsa_data, lsa_buf, length);
+
+	return cmd;
+
+out_fail:
+	cxl_cmd_unref(cmd);
+	return NULL;
+}
+
+enum lsa_op {
+	LSA_OP_GET,
+	LSA_OP_SET,
+	LSA_OP_ZERO,
+};
+
+static int __lsa_op(struct cxl_memdev *memdev, int op, void *buf,
+		size_t length, size_t offset)
+{
+	const char *devname = cxl_memdev_get_devname(memdev);
+	struct cxl_ctx *ctx = cxl_memdev_get_ctx(memdev);
+	void *zero_buf = NULL;
+	struct cxl_cmd *cmd;
+	ssize_t ret_len;
+	int rc = 0;
+
+	switch (op) {
+	case LSA_OP_GET:
+		cmd = cxl_cmd_new_read_label(memdev, offset, length);
+		if (!cmd)
+			return -ENOMEM;
+		rc = cxl_cmd_set_output_payload(cmd, buf, length);
+		if (rc) {
+			err(ctx, "%s: cmd setup failed: %s\n",
+			    cxl_memdev_get_devname(memdev), strerror(-rc));
+			goto out;
+		}
+		break;
+	case LSA_OP_ZERO:
+		zero_buf = calloc(1, length);
+		if (!zero_buf)
+			return -ENOMEM;
+		buf = zero_buf;
+		/* fall through */
+	case LSA_OP_SET:
+		cmd = cxl_cmd_new_write_label(memdev, buf, offset, length);
+		if (!cmd) {
+			rc = -ENOMEM;
+			goto out_free;
+		}
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	rc = cxl_cmd_submit(cmd);
+	if (rc < 0) {
+		err(ctx, "%s: cmd submission failed: %s\n",
+			devname, strerror(-rc));
+		goto out;
+	}
+
+	rc = cxl_cmd_get_mbox_status(cmd);
+	if (rc != 0) {
+		err(ctx, "%s: firmware status: %d\n",
+			devname, rc);
+		rc = -ENXIO;
+		goto out;
+	}
+
+	if (op == LSA_OP_GET) {
+		ret_len = cxl_cmd_read_label_get_payload(cmd, buf, length);
+		if (ret_len < 0) {
+			rc = ret_len;
+			goto out;
+		}
+	}
+
+out:
+	cxl_cmd_unref(cmd);
+out_free:
+	free(zero_buf);
+	return rc;
+
+}
+
+static int lsa_op(struct cxl_memdev *memdev, int op, void *buf,
+		size_t length, size_t offset)
+{
+	const char *devname = cxl_memdev_get_devname(memdev);
+	struct cxl_ctx *ctx = cxl_memdev_get_ctx(memdev);
+	size_t remaining = length, cur_len, cur_off = 0;
+	int label_iter_max, rc = 0;
+
+	if (op != LSA_OP_ZERO && buf == NULL) {
+		err(ctx, "%s: LSA buffer cannot be NULL\n", devname);
+		return -EINVAL;
+	}
+
+	if (length == 0)
+		return 0;
+
+	label_iter_max = memdev->payload_max - sizeof(struct cxl_cmd_set_lsa);
+	while (remaining) {
+		cur_len = min((size_t)label_iter_max, remaining);
+		rc = __lsa_op(memdev, op, buf + cur_off,
+				cur_len, offset + cur_off);
+		if (rc)
+			break;
+
+		remaining -= cur_len;
+		cur_off += cur_len;
+	}
+
+	if (rc && (op == LSA_OP_SET))
+		err(ctx, "%s: labels may be in an inconsistent state\n",
+			devname);
+	return rc;
+}
+
+CXL_EXPORT int cxl_memdev_zero_label(struct cxl_memdev *memdev, size_t length,
+		size_t offset)
+{
+	return lsa_op(memdev, LSA_OP_ZERO, NULL, length, offset);
+}
+
+CXL_EXPORT int cxl_memdev_write_label(struct cxl_memdev *memdev, void *buf,
+		size_t length, size_t offset)
+{
+	return lsa_op(memdev, LSA_OP_SET, buf, length, offset);
+}
+
+CXL_EXPORT int cxl_memdev_read_label(struct cxl_memdev *memdev, void *buf,
+		size_t length, size_t offset)
+{
+	return lsa_op(memdev, LSA_OP_GET, buf, length, offset);
+}
diff --git a/cxl/libcxl.h b/cxl/libcxl.h
index 535e349..89d35ba 100644
--- a/cxl/libcxl.h
+++ b/cxl/libcxl.h
@@ -44,6 +44,12 @@ unsigned long long cxl_memdev_get_ram_size(struct cxl_memdev *memdev);
 const char *cxl_memdev_get_firmware_verison(struct cxl_memdev *memdev);
 size_t cxl_memdev_get_label_size(struct cxl_memdev *memdev);
 int cxl_memdev_nvdimm_bridge_active(struct cxl_memdev *memdev);
+int cxl_memdev_zero_label(struct cxl_memdev *memdev, size_t length,
+		size_t offset);
+int cxl_memdev_read_label(struct cxl_memdev *memdev, void *buf, size_t length,
+		size_t offset);
+int cxl_memdev_write_label(struct cxl_memdev *memdev, void *buf, size_t length,
+		size_t offset);
 
 #define cxl_memdev_foreach(ctx, memdev) \
         for (memdev = cxl_memdev_get_first(ctx); \
@@ -101,6 +107,8 @@ struct cxl_cmd *cxl_cmd_new_read_label(struct cxl_memdev *memdev,
 		unsigned int offset, unsigned int length);
 ssize_t cxl_cmd_read_label_get_payload(struct cxl_cmd *cmd, void *buf,
 		unsigned int length);
+struct cxl_cmd *cxl_cmd_new_write_label(struct cxl_memdev *memdev,
+		void *buf, unsigned int offset, unsigned int length);
 
 #ifdef __cplusplus
 } /* extern "C" */
diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
index f3b0c63..077d104 100644
--- a/cxl/lib/libcxl.sym
+++ b/cxl/lib/libcxl.sym
@@ -66,6 +66,10 @@ global:
 	cxl_cmd_read_label_get_payload;
 	cxl_memdev_get_label_size;
 	cxl_memdev_nvdimm_bridge_active;
+	cxl_cmd_new_write_label;
+	cxl_memdev_zero_label;
+	cxl_memdev_write_label;
+	cxl_memdev_read_label;
 local:
         *;
 };
-- 
2.31.1

