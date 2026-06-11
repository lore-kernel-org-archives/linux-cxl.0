Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42A4231A23
	for <linux-cxl@vger.kernel.org>; Thu, 11 Jun 2026 23:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781218987; cv=none; b=D0cYRze+vCzRrWBhnKGHuuS+EY2TYDPJmWLhh0yeqGp0HxmJMv6nuIZF57J0NH8rG93NbRpNYBcmtdXhD4CnNpbVu2q3ejBpwPK+z9VdWx+TOLx+EUaP+UnU15tAToWDPpNCRwpFNlUNew3g7HiL3YAi70PENMwTFqBIL3r+Kmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781218987; c=relaxed/simple;
	bh=lXaie+b9yFN/l8OFitCsis5wrPPhhdU9ISDiQzpYxSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=klP3IDU+n1PMT+Q/X/ozqz5apGnwdFK1rgNGh6Oj6/Vsbd8qSAFQIlsCYLcw6RKfHbEc9V3EGm1y6JP4Z1jnPyWfk7HS1x8UvPdS7xwQrboCCuN24gGCdvlDkESvFwZ70DwpO+XU/eFZrcjS6Wixdfoaomt7gJ7VGs3KbtvXgoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EA1F1F000E9;
	Thu, 11 Jun 2026 23:03:06 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jic23@kernel.org,
	alison.schofield@intel.com,
	djbw@kernel.org
Subject: [PATCH] cxl/test: Add check after kzalloc() memory in alloc_mock_res()
Date: Thu, 11 Jun 2026 16:03:05 -0700
Message-ID: <20260611230305.197390-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

alloc_mock_res() calls kzalloc() without checking the return value.
Add scope based resource management to deal with the allocated memory
cleanly.

Reported-by: sashiko-bot
Fixes: 67dcdd4d3b83 ("tools/testing/cxl: Introduce a mocked-up CXL port hierarchy")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 tools/testing/cxl/test/cxl.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 296516eecfd6..e6f68dba85d1 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -433,12 +433,16 @@ static void depopulate_all_mock_resources(void)
 
 static struct cxl_mock_res *alloc_mock_res(resource_size_t size, int align)
 {
-	struct cxl_mock_res *res = kzalloc(sizeof(*res), GFP_KERNEL);
 	struct genpool_data_align data = {
 		.align = align,
 	};
 	unsigned long phys;
 
+	struct cxl_mock_res *res __free(kfree) = kzalloc(sizeof(*res),
+							 GFP_KERNEL);
+	if (!res)
+		return NULL;
+
 	INIT_LIST_HEAD(&res->list);
 	phys = gen_pool_alloc_algo(cxl_mock_pool, size,
 				   gen_pool_first_fit_align, &data);
@@ -453,7 +457,7 @@ static struct cxl_mock_res *alloc_mock_res(resource_size_t size, int align)
 	list_add(&res->list, &mock_res);
 	mutex_unlock(&mock_res_lock);
 
-	return res;
+	return no_free_ptr(res);
 }
 
 /* Only update CFMWS0 as this is used by the auto region. */

base-commit: 4549871118cf616eecdd2d939f78e3b9e1dddc48
-- 
2.54.0

