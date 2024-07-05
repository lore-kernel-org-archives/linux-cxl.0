Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DB3146A96
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jul 2024 11:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720179692; cv=none; b=PWeYuxm8UV6Ifl8UUdG0EaTFQ5lDot0Qn93kaQsqEeNRPgBQFlrb3I69M7tYEaoGT3oQs2RebOqGMvulzhyArixXUTge/pEUXrbHjYVhO9SRot6SRojSFzTct5a97qMaxPLQDONwKztINOYwdTouecwknca/O+Mpex4+EOUZD2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720179692; c=relaxed/simple;
	bh=4KahiP0wCMZ63CxXh5nFl1Qt8CgGnBPbdFJqZxafbos=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M59OIu8u28QsAic9b9whwSeaGbiQdGPT4MaZjdmzJBrf1Dbnc6kIhMC4lI8qjLD2WYf4KKpaaCIwxCZLnxXPzRUh7m4k7ndlYtnn9hwK2zHTgL2RqFBwTmGBAxro03RckOXDumC6SJ+SLralus0yKpw7bHKDXbBXF8OplsOvid8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WFs5m69Hpz6JBWB;
	Fri,  5 Jul 2024 19:40:44 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id D6138140B18;
	Fri,  5 Jul 2024 19:41:28 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 5 Jul 2024 12:41:28 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <mst@redhat.com>, <qemu-devel@nongnu.org>
CC: <linux-cxl@vger.kernel.org>, Markus Armbruster <armbru@redhat.com>, Li
 Zhijian <lizhijian@fujitsu.com>, <linuxarm@huawei.com>, Zhao Liu
	<zhao1.liu@linux.intel.com>, Xingtao Yao <yaoxt.fnst@fujitsu.com>
Subject: [PATCH v2 3/3] hw/cxl: Check for multiple mappings of memory backends.
Date: Fri, 5 Jul 2024 12:39:56 +0100
Message-ID: <20240705113956.941732-4-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240705113956.941732-1-Jonathan.Cameron@huawei.com>
References: <20240705113956.941732-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
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

