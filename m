Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C576C433EF
	for <linux-cxl@archiver.kernel.org>; Tue, 22 Feb 2022 19:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235318AbiBVTxG (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 22 Feb 2022 14:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233423AbiBVTxD (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 22 Feb 2022 14:53:03 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D569DC4E30
        for <linux-cxl@vger.kernel.org>; Tue, 22 Feb 2022 11:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645559557; x=1677095557;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i/f+JBwQs1IDAStzVhcNq+ZwWqHAE3YETRKnb3eAacA=;
  b=nkqBABY7FTpbjwaAkjALZzegsi+IKnusJ+fLVu2MZyVI4kAJGutjgEKO
   DghsIOTVJqjAZ2lDH2s55KMUFdIYIzROlrTQs3RH+H0Gtx65LdMpTM3jJ
   iCSrTsljf1psTieL7PhjNTcofGy+IZm0aJVMoQTAyM8P6SaEWy/o3S0H+
   z9muxkw2Kbtmj6jnqepkUkYQvawan+TA7/xUVFczxh3GUodN6xy4URQTX
   Q1RS9hbYOLlSkrtSw2zMAGyxJ5b/stK00wyCbU2ua/pUZ54bi7YB+55hD
   q0ISmNRB2lg/iwiL5mh1X1hQmYDWWGwpwRD7YwKARUa/UORFk0pllVolP
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="250624958"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="250624958"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 11:52:36 -0800
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="683637812"
Received: from alison-desk.jf.intel.com (HELO localhost) ([10.54.74.41])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 11:52:36 -0800
From:   alison.schofield@intel.com
To:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org
Subject: [ndctl PATCH v6 3/6] libcxl: return the partition alignment field in bytes
Date:   Tue, 22 Feb 2022 11:56:05 -0800
Message-Id: <6b937b09b61ddf95e069fd7acfda0c5bbb845be8.1645558189.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1645558189.git.alison.schofield@intel.com>
References: <cover.1645558189.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

Per the CXL specification, the partition alignment field reports
the alignment value in multiples of 256MB. In the libcxl API, values
for all capacity fields are defined to return bytes.

Update the partition alignment accessor to return bytes so that it
is in sync with other capacity related fields.

Since this is early in the development cycle, the expectation is that
no third party consumers of this library have come to depend on the
encoded capacity field. If that is not the case, the original format
can be restored, and a new _bytes version introduced.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 cxl/lib/libcxl.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
index 9413384b4b3b..c05c13c501ab 100644
--- a/cxl/lib/libcxl.c
+++ b/cxl/lib/libcxl.c
@@ -2308,15 +2308,12 @@ CXL_EXPORT int cxl_cmd_identify_get_fw_rev(struct cxl_cmd *cmd, char *fw_rev,
 CXL_EXPORT unsigned long long cxl_cmd_identify_get_partition_align(
 		struct cxl_cmd *cmd)
 {
-	struct cxl_cmd_identify *id =
-			(struct cxl_cmd_identify *)cmd->send_cmd->out.payload;
+	struct cxl_cmd_identify *c;
 
-	if (cmd->send_cmd->id != CXL_MEM_COMMAND_ID_IDENTIFY)
-		return -EINVAL;
-	if (cmd->status < 0)
-		return cmd->status;
-
-	return le64_to_cpu(id->partition_align);
+	c = cmd_to_identify(cmd);
+	if (!c)
+		return ULLONG_MAX;
+	return cxl_capacity_to_bytes(c->partition_align);
 }
 
 CXL_EXPORT unsigned int cxl_cmd_identify_get_label_size(struct cxl_cmd *cmd)
-- 
2.31.1

