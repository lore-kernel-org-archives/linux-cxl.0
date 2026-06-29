Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82C02C11D9
	for <linux-cxl@vger.kernel.org>; Mon, 29 Jun 2026 22:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782771073; cv=none; b=JBAbBoup/tB5E0XdSxPQgBaqDzUkJ8cJYKTe0OvC+cUKEj8lZV4A7x3uYeykfs9Sg5Z0HE2pGowxoxH2L7hvAZhJnLw9YlYbkaL5ztoI+eKSRotNjRjVLyDzOrVw1F85cOojSbG+oErCS0fgcQqZGskb6MkPeKlvmQRxEH4R+kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782771073; c=relaxed/simple;
	bh=cp3AtjS/poEhdqmTLcJCYMuDmEuXlD2yCjevreT1gqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RqXJcJ+fTiQa9FefFr8L9PpxkhjHoG8X0MSabjG9640iENR8NgjoKd4JWwtknrB/9lqrexU8gWulSx/m0YFcQg/3SJcGGu2CjPPppAxdFxSRJw3BCka+W3V7fbrUKzQw19RMyeKlD4MEB8pKF4iVEFsMdVKUutdV5c28xeXE0dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36AAD1F00A3A;
	Mon, 29 Jun 2026 22:11:11 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: djbw@kernel.org,
	dave@stgolabs.net,
	jic23@kernel.org,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com
Subject: [PATCH v7 1/7] cxl/test: Add test for module parameters
Date: Mon, 29 Jun 2026 15:10:58 -0700
Message-ID: <20260629221104.3891733-2-dave.jiang@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629221104.3891733-1-dave.jiang@intel.com>
References: <20260629221104.3891733-1-dave.jiang@intel.com>
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
 tools/testing/cxl/test/cxl.c       | 20 ++++++++++++++++++++
 tools/testing/cxl/test/hmem_test.c |  3 ++-
 tools/testing/cxl/test/mock.h      |  2 ++
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index ef92dd35e030..198a128181b9 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -1827,11 +1827,31 @@ static struct attribute *cxl_acpi_attrs[] = {
 };
 ATTRIBUTE_GROUPS(cxl_acpi);
 
+static bool __init have_multiple_modparms(void)
+{
+	int count = 0;
+
+	if (interleave_arithmetic)
+		count++;
+	if (extended_linear_cache)
+		count++;
+	if (fail_autoassemble)
+		count++;
+	if (hmem_test)
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
 	if (!IS_ALIGNED(mock_auto_region_size, PMD_SIZE)) {
 		pr_err_once("mock_auto_region_size %d must be PMD-aligned\n",
 			    mock_auto_region_size);
diff --git a/tools/testing/cxl/test/hmem_test.c b/tools/testing/cxl/test/hmem_test.c
index 3a1a089e1721..0fa00f7e16db 100644
--- a/tools/testing/cxl/test/hmem_test.c
+++ b/tools/testing/cxl/test/hmem_test.c
@@ -3,8 +3,9 @@
 #include <linux/moduleparam.h>
 #include <linux/workqueue.h>
 #include "../../../drivers/dax/bus.h"
+#include "mock.h"
 
-static bool hmem_test;
+bool hmem_test;
 
 static void hmem_test_work(struct work_struct *work)
 {
diff --git a/tools/testing/cxl/test/mock.h b/tools/testing/cxl/test/mock.h
index 4f57dc80ae7d..846d7c5d6eaa 100644
--- a/tools/testing/cxl/test/mock.h
+++ b/tools/testing/cxl/test/mock.h
@@ -5,6 +5,8 @@
 #include <linux/dax.h>
 #include <cxl.h>
 
+extern bool hmem_test;
+
 struct cxl_mock_ops {
 	struct list_head list;
 	bool (*is_mock_adev)(struct acpi_device *dev);
-- 
2.54.0

