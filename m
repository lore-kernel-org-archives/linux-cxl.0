Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EC0392811
	for <linux-cxl@vger.kernel.org>; Wed, 15 Jul 2026 15:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784130689; cv=none; b=dxXD/eSm37ie/KTaVH5xVPvNnQH+G9rPRe6/cyFAsvkWc6Vgjd3pqwfrXYfdVSLIglYJWlch3HJbd2JGXijzTqbtDotW8hF2ohFIvmpQorDdiiqUiMdKLZZ5KCUht+Cl/Z8s1CPTqbfXfbrlEu54PK1a1ND9NZ7hFHh0nx2jzIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784130689; c=relaxed/simple;
	bh=N3vXjoWIvCL85CJUR3FQp4hZd9UNVwo3BJtoaywZ14I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ERybup5CQ9dL62n3ATqkJ5TbNo1ezeI+/StzsMrxB9imtPUm0l/VtNv4AjEGv342nBU66wBz9nnN0Lv87mtATT20sEWg4sR+K3bFtiD/ggt/rym4ev5Z0Pk8ORowbQ0fhTTktOgp1BJJ2Qmd2j27sRt8PjsfccAg6X7DJvDBI4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 850D31F00A3A;
	Wed, 15 Jul 2026 15:51:27 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jic23@kernel.org,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	djbw@kernel.org,
	icheng@nvidia.com
Subject: [PATCH] cxl: Deny Features commands on the RAW mailbox path
Date: Wed, 15 Jul 2026 08:51:26 -0700
Message-ID: <20260715155126.1629178-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RAW mailbox command path allows user to issue arbitrary opcodes
to the device. The FWCTL interface was introduced to support the
CXL Features commands where access control is provided depends on
what the CEL indicates.

Add the Features commands to cxl_disabled_raw_commands[] to ensure
that all Features commands are only accessible through the FWCTL
interface.

The cxl_raw_allow_all debugfs override knob bypasses the disabled list
if the user is aware of the risks and wants to use the RAW path for
Features commands.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/mbox.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 7c6c5b7450a5..6dea70a1ff95 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -91,6 +91,10 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
  *
  * CXL_MBOX_OP_[GET_,INJECT_,CLEAR_]POISON: These commands require kernel
  * driver orchestration for safety.
+ *
+ * CXL_MBOX_OP_[GET_SUPPORTED_FEATURES,GET_FEATURE,SET_FEATURE]: Features are
+ * accessed through the fwctl ABI, which applies scope-based access control.
+ * The RAW path would bypass those checks, so it is not permitted here.
  */
 static u16 cxl_disabled_raw_commands[] = {
 	CXL_MBOX_OP_ACTIVATE_FW,
@@ -102,6 +106,9 @@ static u16 cxl_disabled_raw_commands[] = {
 	CXL_MBOX_OP_GET_POISON,
 	CXL_MBOX_OP_INJECT_POISON,
 	CXL_MBOX_OP_CLEAR_POISON,
+	CXL_MBOX_OP_GET_SUPPORTED_FEATURES,
+	CXL_MBOX_OP_GET_FEATURE,
+	CXL_MBOX_OP_SET_FEATURE,
 };
 
 /*

base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa
-- 
2.55.0

