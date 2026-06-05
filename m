Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963A73E639A
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jun 2026 18:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780685069; cv=none; b=labYFdO7MZWs6pfrzHOS0J2sAlHjNV+Iwg/XxDGMDv5+g51k1KlW7m5TMp8G89q0ZPOFK/rCbs+hg7bUxSkg9pgAWoOhnp1nHAGudkFHndGMGdjKor/TguyPXZJiXzALZ+XfSQ/+KVyT9+9W4GUh5Ykid/iemZVF3mHLPu9xsYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780685069; c=relaxed/simple;
	bh=g6Ap1cWL9p7pgT1E9Z1R6zBiWZJsJpeHCBYq4IcV29I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fH98M/phN7OMfv2hg0xrbchJRQcGA1wxt4EYEuc1Je4xSw3Xfv9nGvKJRiaRpvIMU5cwevZNYXkZ4FKwHywCZ/+ybpqjy4FlXK+vjaQ8PCABNvfZ7jk28zUQzdnHB+RgGJi/CpfYd//n7v6UiwvkBWROHRfuvlkrssdLTlFAVKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BA861F00893;
	Fri,  5 Jun 2026 18:44:27 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jic23@kernel.org,
	alison.schofield@intel.com,
	djbw@kernel.org
Subject: [PATCH] cxl/test: Zero out LSA backing memory to avoid leaking to user
Date: Fri,  5 Jun 2026 11:44:26 -0700
Message-ID: <20260605184426.4070913-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Memory through vmalloc() is not zeroed out. When this memory is copied
into output payload, it leaks memory content to user. Use vzalloc()
instead to zero out the memory.

Suggested-by: sashiko-bot
Link: https://lore.kernel.org/linux-cxl/20260605173146.2B9A31F00893@smtp.kernel.org/
Fixes: 7d3eb23c4ccf ("tools/testing/cxl: Introduce a mock memory device + driver")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 tools/testing/cxl/test/mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 9a7cd3f46a1e..739343cd5802 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -1724,7 +1724,7 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	dev_set_drvdata(dev, mdata);
 
-	mdata->lsa = vmalloc(LSA_SIZE);
+	mdata->lsa = vzalloc(LSA_SIZE);
 	if (!mdata->lsa)
 		return -ENOMEM;
 	mdata->fw = vmalloc(FW_SIZE);

base-commit: e43ffb69e0438cddd72aaa30898b4dc446f664f8
prerequisite-patch-id: a09fa1bd37ae9ee663117e196f1b8c49c55365e4
prerequisite-patch-id: 75202ea281daa3b091090369ada6eabcaefc6671
-- 
2.54.0

