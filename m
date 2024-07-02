Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A8A1B4C40
	for <linux-cxl@vger.kernel.org>; Tue,  2 Jul 2024 14:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719930962; cv=none; b=hHnZZHXGEhgkqNte7FfblAP4IDoqCyx2ciLHD5i9VHBrpBemU5YinyhZrKMHHisdcUUozN5HltnMt0wl9gleJCeq8EnzSdDjH+3DfjE2/GfBgqgcIiC3P6loGQKiA5bntqDtqTNpExuWOva0xss/5QeyYH0Xrq/Am0i50PiDcNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719930962; c=relaxed/simple;
	bh=4KahiP0wCMZ63CxXh5nFl1Qt8CgGnBPbdFJqZxafbos=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hcbFfu3QLImJDQ7l9esf2Ro/YHJrQSGi5Q5o2OMvqvbZM1jCsT/MKE8CxloH8qC1tv0bLjBHTm+l8ZCXv9NhCIB4mWAuVb/gJvgxaech9tHWsZNejwdMMZDLNgE+K0wjyynPvH35nifv9jFkWCLVJySVrVWJZ82q9kE0dW+DHcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WD5692g20z6J6pg;
	Tue,  2 Jul 2024 22:34:57 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 21F16140A70;
	Tue,  2 Jul 2024 22:35:58 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 2 Jul 2024 15:35:57 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <linux-cxl@vger.kernel.org>, <mst@redhat.com>, Markus Armbruster
	<armbru@redhat.com>, <qemu-devel@nongnu.org>, Li Zhijian
	<lizhijian@fujitsu.com>
CC: <linuxarm@huawei.com>
Subject: [PATCH 3/3] hw/cxl: Check for multiple mappings of memory backends.
Date: Tue, 2 Jul 2024 15:34:25 +0100
Message-ID: <20240702143425.717452-4-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240702143425.717452-1-Jonathan.Cameron@huawei.com>
References: <20240702143425.717452-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

Similar protection to that provided for -numa memdev=x
to make sure that memory used to back a type3 device is not also mapped
as normal RAM, or for multiple type3 devices.

This is an easy footgun to remove and seems multiple people have
run into it.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/mem/cxl_type3.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 35ac59883a..e7fbbb4d51 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -737,6 +737,11 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
             error_setg(errp, "volatile memdev must have backing device");
             return false;
         }
+        if (host_memory_backend_is_mapped(ct3d->hostvmem)) {
+            error_setg(errp, "memory backend %s can't be used multiple times.",
+               object_get_canonical_path_component(OBJECT(ct3d->hostvmem)));
+            return false;
+        }
         memory_region_set_nonvolatile(vmr, false);
         memory_region_set_enabled(vmr, true);
         host_memory_backend_set_mapped(ct3d->hostvmem, true);
@@ -760,6 +765,11 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
             error_setg(errp, "persistent memdev must have backing device");
             return false;
         }
+        if (host_memory_backend_is_mapped(ct3d->hostpmem)) {
+            error_setg(errp, "memory backend %s can't be used multiple times.",
+               object_get_canonical_path_component(OBJECT(ct3d->hostpmem)));
+            return false;
+        }
         memory_region_set_nonvolatile(pmr, true);
         memory_region_set_enabled(pmr, true);
         host_memory_backend_set_mapped(ct3d->hostpmem, true);
@@ -790,6 +800,11 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
             return false;
         }
 
+        if (host_memory_backend_is_mapped(ct3d->dc.host_dc)) {
+            error_setg(errp, "memory backend %s can't be used multiple times.",
+               object_get_canonical_path_component(OBJECT(ct3d->dc.host_dc)));
+            return false;
+        }
         /*
          * Set DC regions as volatile for now, non-volatile support can
          * be added in the future if needed.
-- 
2.43.0

