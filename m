Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA16380
	for <linux-cxl@vger.kernel.org>; Fri, 30 Aug 2024 07:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725004330; cv=none; b=O5HC7E5eVGPnNsP48gpJgSF73tRuIWrpvBYoTKVuwCya9xTvt4FaCnBLrtu8OqiwnwXPUJlHKFw31Mkhjct9VX8YHU8j8YC/0APYPSy+yrvdrqEw9C8UFnge1ipFGPjoOz/Q3XQVM0K4sq/OOlMAqJSnxslIRnTwdG30pWBreL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725004330; c=relaxed/simple;
	bh=6aavZjjdUbqFSXtxSnuzNZQt1RYpK2aVRizawp1go+A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ep9aOYSVz+9OSgk8srBywrqYxXE/7nzD3O7t0DUd1mItktuPlftzBt6ghtubnbpIkexSepTeinEf9syzpb2xfO3GA4vk7568qpqUjUU9GtZbtXxpI0XBILNzUtBD6pt5VzY1hUJ5JJ/eCcjMuVSdUr/gxC1FIZ1veDDeHYBGQVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Ww9Kp2tn4z1xwX8;
	Fri, 30 Aug 2024 15:50:06 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id DE932140136;
	Fri, 30 Aug 2024 15:52:04 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 30 Aug
 2024 15:52:04 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <lihongbo22@huawei.com>
Subject: [PATCH -next] cxl: Remove duplicate included header file core.h
Date: Fri, 30 Aug 2024 16:00:16 +0800
Message-ID: <20240830080016.3542184-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500022.china.huawei.com (7.185.36.66)

The header file core.h is included twice. Remove the last
one. The compilation test has passed.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 drivers/cxl/core/cdat.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index bb83867d9fec..e2e1ccda88fa 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -9,7 +9,6 @@
 #include "cxlmem.h"
 #include "core.h"
 #include "cxl.h"
-#include "core.h"
 
 struct dsmas_entry {
 	struct range dpa_range;
-- 
2.34.1

