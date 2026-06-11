Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6922A367B63
	for <linux-cxl@vger.kernel.org>; Thu, 11 Jun 2026 23:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781219038; cv=none; b=rBSRu6gw/Wfy4hdkNWPYyv9ci6851LEi6PDvKKlwO86xVnYAbREU2U+NYs51J9J5G9Iqp8tGHStV+6iakXMP9mYhPcV6kXIBqPeL13n18LZDYpGgalr0oB4QAadCRM6FdlGPf4ygY+dlI2ENR27r/0L7Z78EzdfXppMnGGCODoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781219038; c=relaxed/simple;
	bh=ANaeD+4TzN6SRspNSlBVOAjfq+AQnZoGOO9aqUe/rOY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r0YDFC9pJXBKUtx7JcX4fofNlRbgDqURxkLSYxu11N1LjTBestvfQlX1OqgYGl/NXFtBVvWzQeKVOyllDUMklybC9NKcKNyR3FWPFMQsrtuKFZz/7ToxKuqpfQv4HXLlDbPoOBgEMRjvpLff0KPeG9LV9KhpQC7/AkkQz1Xm454=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF0741F000E9;
	Thu, 11 Jun 2026 23:03:56 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jic23@kernel.org,
	alison.schofield@intel.com,
	djbw@kernel.org
Subject: [PATCH] cxl/test: Unregister cxl_acpi in cxl_test_init() error path
Date: Thu, 11 Jun 2026 16:03:55 -0700
Message-ID: <20260611230355.198912-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In cxl_test_init(), Once cxl_mock_platform_device_add() succeeds, all
error paths after needs to call platform_device_unregister() instead of
platform_device_put() to clean up.

Fixes: 67dcdd4d3b83 ("tools/testing/cxl: Introduce a mocked-up CXL port hierarchy")
Reported-by: sashiko-bot
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 tools/testing/cxl/test/cxl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index e6f68dba85d1..5733a526f7dc 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -1955,7 +1955,7 @@ static __init int cxl_test_init(void)
 err_mem:
 	cxl_mem_exit();
 err_root:
-	platform_device_put(cxl_acpi);
+	platform_device_unregister(cxl_acpi);
 err_rch:
 	cxl_rch_topo_exit();
 err_single:

base-commit: 4549871118cf616eecdd2d939f78e3b9e1dddc48
prerequisite-patch-id: 1368e94a3bbc2945c2eb36ac72bd6ab8a10650de
-- 
2.54.0

