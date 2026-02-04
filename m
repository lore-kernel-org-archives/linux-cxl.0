Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE4231A568
	for <linux-cxl@vger.kernel.org>; Wed,  4 Feb 2026 17:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770225196; cv=none; b=rl2i+SLLV3JgzQQPhLBgTgrpbmeY/UdfLVJyh/7RahhyyDipjD1Y6Zw8NGTWV7RVUZX8ErqOjhg9i15aQC2gAcXIrWzeCOdml+vbQAV6sX5s4OHw2tmiSCJhoNVpMfkxNE4IGD0bwh8CVWPSmrwthVPfSXTqiJiR7wGF7Xutmkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770225196; c=relaxed/simple;
	bh=fh4ai1gVLZyCyZ4VjRavJjJVNvCJSEaQwgcFd0jElF8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bFoBY+Zwn7VdUpFBSLGvEsuBgB0nTGHWirRgNWPqzIRVZsLGXNh1v8aoAAH4IL+1jUp8Qb9V6zcNiUnvZKp9FWkOlFsH097NJ6KxfYHKc3VOBtCnarljpzZg9Y9B2hQ9cT2zCSHRI2aSfYrn9oXDH+I9cXBU6+4vFD3MlDu2e2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f5n3F3sMfzJ46bf;
	Thu,  5 Feb 2026 01:12:25 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id D75AA40539;
	Thu,  5 Feb 2026 01:13:14 +0800 (CST)
Received: from SecurePC-101-06.huawei.com (10.122.19.247) by
 dubpeml500005.china.huawei.com (7.214.145.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 4 Feb 2026 17:13:14 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Michael Tsirkin <mst@redhat.com>, <qemu-devel@nongnu.org>, Davidlohr Bueso
	<dave@stgolabs.net>
CC: <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>, Ravi Shankar
	<venkataravis@micron.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
	Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>
Subject: [PATCH qemu v7 7/7] hw/cxl: Remove register special_ops->read()
Date: Wed, 4 Feb 2026 17:09:35 +0000
Message-ID: <20260204170936.43959-8-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260204170936.43959-1-Jonathan.Cameron@huawei.com>
References: <20260204170936.43959-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 dubpeml500005.china.huawei.com (7.214.145.207)

From: Davidlohr Bueso <dave@stgolabs.net>

... this is unused, unlike its write counterpart.

Scope needs to be added to avoid _Static_assert() immediately
after a label. c23 makes this valid but before then it is compiler
dependent.

Suggested-by: Jonathan.Cameron@huawei.com
Tested-by: Dongjoo Seo <dongjoo.seo1@samsung.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v7: Add scope to avoid pre C23 issue.
hw/cxl/cxl-component-utils.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index a7d36e1128c2..07aabe331c44 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -68,11 +68,7 @@ static uint64_t cxl_cache_mem_read_reg(void *opaque, hwaddr offset,
     ComponentRegisters *cregs = &cxl_cstate->crb;
 
     switch (size) {
-    case 4:
-        if (cregs->special_ops && cregs->special_ops->read) {
-            return cregs->special_ops->read(cxl_cstate, offset, 4);
-        }
-
+    case 4: {
         QEMU_BUILD_BUG_ON(sizeof(*cregs->cache_mem_registers) != 4);
 
         if (offset == A_CXL_BI_RT_STATUS ||
@@ -105,6 +101,7 @@ static uint64_t cxl_cache_mem_read_reg(void *opaque, hwaddr offset,
         }
 
         return cregs->cache_mem_registers[offset / 4];
+    }
     case 8:
         qemu_log_mask(LOG_UNIMP,
                       "CXL 8 byte cache mem registers not implemented\n");
-- 
2.51.0

