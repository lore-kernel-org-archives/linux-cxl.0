Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158A427A471
	for <linux-cxl@vger.kernel.org>; Tue, 27 May 2025 15:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748360104; cv=none; b=QAr1Ed/jHS9vNogGmRlfiJF7KVvfY/7CTGvv5aN/auCYEj4Pi8iLW+zKORp5BF725C7PJVF2Yx31R1OWnKB1VbVuSi7tqDn8H+x1iGxMeiiNeZGKnFelGDd4gUCZhjHFlvOpIN6nIoaO3oPViRgPNGpgWBqxjEs9Rxmc9nz1Yrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748360104; c=relaxed/simple;
	bh=byJs5su/6ItcqE1iPC6HbRq4IOuNwkdV6vI8sChy+4I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QhIWHaeqM66EviWxHHfDeQyiCz6fno1o5RPfJOV0ij5rHT4C6jm8gY152wv/MYYG9d7vHmf523NUFa1fKjIdMxearu52F15V61bKAPWx80eTuM2sI84JzMPkpYZJiqqVELMvSbnpdjDMnPUCGKw3lha4Vn5hKOORL7edm26jibw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b6GsR3c6sz6J7X5;
	Tue, 27 May 2025 23:34:51 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id C40681402FF;
	Tue, 27 May 2025 23:34:52 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 27 May 2025 17:34:52 +0200
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <linux-cxl@vger.kernel.org>
CC: Itaru Kitayama <itaru.kitayama@linux.dev>, Dan Williams
	<dan.j.williams@intel.com>, Marc Herbert <marc.herbert@linux.intel.com>,
	Alison Schofield <alison.schofield@intel.com>, Dave Jiang
	<dave.jiang@intel.com>, <linuxarm@huawei.com>
Subject: [PATCH] cxl_test: Limit location for fake CFMWS to mappable range
Date: Tue, 27 May 2025 16:34:51 +0100
Message-ID: <20250527153451.82858-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 frapeml500008.china.huawei.com (7.182.85.71)

Some architectures (e.g. arm64) only support memory hotplug operations on
a restricted set of physical addresses. This applies even when we are
faking some CXL fixed memory windows for the purposes of cxl_test.
That range can be queried with mhp_get_pluggable_range(true). Use the
minimum of that the top of that range and iomem_resource.end to establish
the 64GiB region used by cxl_test.

From thread #2 which was related to the issue in #1.

Link: https://lore.kernel.org/linux-cxl/20250522145622.00002633@huawei.com/ #2
Reported-by: Itaru Kitayama <itaru.kitayama@linux.dev>
Closes: https://github.com/pmem/ndctl/issues/278 #1
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Tested-by: Itaru Kitayama <itaru.kitayama@fujitsu.com <mailto:itaru.kitayama@fujitsu.com>
Tested-by: Marc Herbert <marc.herbert@linux.intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
I haven't given this a fixes tag because it never worked on arm64.
So it isn't a regression fix, and I'm not sure we want to back port this
which a fixes tag might well trigger.  If people want one shout and I'll
try and figure out what is appropriate.
---
 tools/testing/cxl/test/cxl.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 8a5815ca870d..6a25cca5636f 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -2,6 +2,7 @@
 // Copyright(c) 2021 Intel Corporation. All rights reserved.
 
 #include <linux/platform_device.h>
+#include <linux/memory_hotplug.h>
 #include <linux/genalloc.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
@@ -1328,6 +1329,7 @@ static int cxl_mem_init(void)
 static __init int cxl_test_init(void)
 {
 	int rc, i;
+	struct range mappable;
 
 	cxl_acpi_test();
 	cxl_core_test();
@@ -1342,8 +1344,11 @@ static __init int cxl_test_init(void)
 		rc = -ENOMEM;
 		goto err_gen_pool_create;
 	}
+	mappable = mhp_get_pluggable_range(true);
 
-	rc = gen_pool_add(cxl_mock_pool, iomem_resource.end + 1 - SZ_64G,
+	rc = gen_pool_add(cxl_mock_pool,
+			  min(iomem_resource.end + 1 - SZ_64G,
+			      mappable.end + 1 - SZ_64G),
 			  SZ_64G, NUMA_NO_NODE);
 	if (rc)
 		goto err_gen_pool_add;
-- 
2.43.0

