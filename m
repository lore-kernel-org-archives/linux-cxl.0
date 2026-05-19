Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15553D88EC
	for <linux-cxl@vger.kernel.org>; Tue, 19 May 2026 21:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779226661; cv=none; b=fmCySWuYrXq03G9LLSUb3Upr3AIliIChm8opw2ck4iaiGWhQhRkN7Bvs4GbbBfmX9zNXqkqyc9awrRplJeyY7Dt2I5sgWglti1SATD8EwBhuFb1LsU8292VX88BLEhCShNF9loWx6RZmIe2X8dMBU6z6cl9TuesXLm5bvBRsX28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779226661; c=relaxed/simple;
	bh=2nkR+z6RPJ7R+mjkwhvPEU9EQKBKSCGQK1nu0bJkQMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J6jhuZiTqdabY7JfzUBW3rdnODoVuxDT8CjcjZsUAwhRk3Y2NFVNJ44Hy+Hx2dl5FywCIO6sGAxCtx2Wlon913nt8MMJeE6D9BVdbH506isWsvpcll20iQTta1211tnVuI7YXYhBZapbdlvNMRCFlp0UNIQ1HbZJlJqpon48JAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B279C1F00893;
	Tue, 19 May 2026 21:37:40 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: djbw@kernel.org,
	dave@stgolabs.net,
	jic23@kernel.org,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com
Subject: [PATCH v2 1/6] cxl/test: Add test for module parameters
Date: Tue, 19 May 2026 14:37:28 -0700
Message-ID: <20260519213734.69737-2-dave.jiang@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519213734.69737-1-dave.jiang@intel.com>
References: <20260519213734.69737-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test for module paraters during module init to make sure that
only one is activated.

Suggested-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 tools/testing/cxl/test/cxl.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 48cae9dde2e4..e60cd0b2ac7b 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -1867,11 +1867,29 @@ static struct attribute *cxl_acpi_attrs[] = {
 };
 ATTRIBUTE_GROUPS(cxl_acpi);
 
+bool __init have_multiple_modparms(void)
+{
+	int count = 0;
+
+	if (interleave_arithmetic)
+		count++;
+	if (extended_linear_cache)
+		count++;
+	if (fail_autoassemble)
+		count++;
+
+	return count > 1;
+}
+
 static __init int cxl_test_init(void)
 {
 	int rc, i;
 	struct range mappable;
 
+	/* Enforce a single module param active at a time */
+	if (have_multiple_modparms())
+		return -EINVAL;
+
 	cxl_acpi_test();
 	cxl_core_test();
 	cxl_mem_test();
-- 
2.54.0

