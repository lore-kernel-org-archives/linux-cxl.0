Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CF63451CC
	for <linux-cxl@vger.kernel.org>; Wed, 10 Jun 2026 22:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781130214; cv=none; b=PbaW0lGAvzVeqBBP9ep3m+krdPscwlvO7tcXIoElNEY0+hIP7vFSMBMkISA7IWzs8DuVuPK1Z9HV2xhmvbaZ9jej/7E2sw/1g/3gCdb9rkMtHjNnTs8E/nsKkakry32Ms28iHxNJmt69Q9Jpo4l51asra20XC9XSsRHmpDo7JX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781130214; c=relaxed/simple;
	bh=qytFdJw5QeVcl0PPJPPhBFyqE09Vmaa8O5EB36o0N0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z2G777m2YSiICYLoG807wxyq/27+8h9KQYB5gC765d/A2AJSw6dxjEUmZUIoruolTvESuaWnIAgktrJ3Y2xUummHPx/q5LECldS914GiAjYBXJGweknAYLTQANTZ3ApYiNuP+iyt7WKL8+RVihXiQhklHqOQr0NFkX93I7OvDHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF4EC1F00893;
	Wed, 10 Jun 2026 22:23:32 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: djbw@kernel.org,
	dave@stgolabs.net,
	jic23@kernel.org,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com
Subject: [PATCH v3 1/6] cxl/test: Add test for module parameters
Date: Wed, 10 Jun 2026 15:23:23 -0700
Message-ID: <20260610222328.2272427-2-dave.jiang@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610222328.2272427-1-dave.jiang@intel.com>
References: <20260610222328.2272427-1-dave.jiang@intel.com>
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
index 296516eecfd6..b00f5161b5f0 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -1814,11 +1814,29 @@ static struct attribute *cxl_acpi_attrs[] = {
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

