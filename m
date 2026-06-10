Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305194369A
	for <linux-cxl@vger.kernel.org>; Wed, 10 Jun 2026 00:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781050408; cv=none; b=L5uh34Fje0s7gNC0yceSpEHhltdE1vFHZKMDhkM6OHA91qlLGGC7XETNi54Hwn5UWq5BAcyKB5MxJm9TiNs3mIJrd69zGz7fj+OCJwzFf3ROSmnkbAYeOyF2GtpxoJkewtMQDIv51diVMjobhj6yc1ki9AVU8sJmd9PpArn+I4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781050408; c=relaxed/simple;
	bh=EW0azbaTbdcq0oyT9+goOXIQ329xS6J0jr8IftJMIYE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cCFQnwkz1CFMr7YMLIURIi3uVu/rKdxNwXAlUKMUJ0yS5zqb2UreVf1eV0Xlxkpm0fAF0AfeVQiGP55SLWn1ye2o4Dt5/4/60RvmcT1+99Ils5NLevQrYLQjEpwtm15E3GJQVxIfMabhBZZqmV4rlb5kwG1l1Giy+9P1iYvAGCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0C2F1F00898;
	Wed, 10 Jun 2026 00:13:26 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: djbw@kernel.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] cxl: Add dummy function for cxl_memdev_attach_region for !CONFIG_CXL_REGION
Date: Tue,  9 Jun 2026 17:13:24 -0700
Message-ID: <20260610001324.260268-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a dummy function that returns -EOPNOTSUPP for cxl_memdev_attach_region
when CONFIG_CXL_REGION is not enabled. This allow sbuilding when
cxl/core/region.o isn't built.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 9b1e70e8f9ec ("cxl/region: Introduce devm_cxl_probe_mem()")
https://lore.kernel.org/oe-kbuild-all/202606100401.GOjzpKHo-lkp@intel.com/
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---

Fix is against last patch of Dan's [1] series for Introduce
devm_cxl_probe_mem() and fix region deletion.

[1]: https://lore.kernel.org/linux-cxl/48834616-6e75-4936-89be-9224a6dedefa@intel.com/T/#t
---
 drivers/cxl/cxlmem.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index d3bdd00f94b3..ed419d0c59f2 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -115,7 +115,14 @@ struct cxl_attach_region {
 	struct range hpa_range;
 };
 
+#ifdef CONFIG_CXL_REGION
 int cxl_memdev_attach_region(struct cxl_memdev *cxlmd);
+#else
+static inline int cxl_memdev_attach_region(struct cxl_memdev *cxlmd)
+{
+	return -EOPNOTSUPP;
+}
+#endif
 
 struct cxl_memdev *devm_cxl_add_classdev(struct cxl_dev_state *cxlds);
 struct cxl_memdev *__devm_cxl_add_memdev(struct cxl_dev_state *cxlds,

base-commit: 9b1e70e8f9ec4b5c6ce7fa774a0023bb6894c686
-- 
2.54.0

