Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA98E1FCF7C
	for <linux-cxl@vger.kernel.org>; Wed, 28 May 2025 11:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748430545; cv=none; b=qvH8rCQ1Vp1o8AtnmZPwYfLJzhHmiq/BkGnLJ2NvKHiCNd454wrj8bb0jzLP1wUaSs8GAmqh9nMmIaVKb/XPMlaD/zbg+D/QfDNqz5pWQVlmymfVa0dQbyliSjiLlhVQ3/tqed7Bl47nYgqN82W3Rayx/vhk65yRgaVXhN2ynt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748430545; c=relaxed/simple;
	bh=9nm8w5QUrJ8bEEJRRL8r6UbFS/By5vA950gJ22lA3fc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q/R5Xvh3AI+WUNkAnuI/cWgqE5OiV2tzMrG0g6H8H1ydRbyttT/HyzYMBZGzy7Z74d5EZSl2jpkPayQofhXREKkuatlPHh/4neh8epI653/oQQFbzdAzoOzhogyleqcdw3ZuV8RhOOSL/AQJLPItL9dYqw5NHTBZfmOqcErj/rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b6mwB5C5Fz6M4sd;
	Wed, 28 May 2025 19:08:58 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 3CD2214034D;
	Wed, 28 May 2025 19:09:01 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 28 May 2025 13:09:00 +0200
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <qemu-devel@nongnu.org>, Fan Ni <fan.ni@samsung.com>, Peter Maydell
	<peter.maydell@linaro.org>, <mst@redhat.com>
CC: <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>, <qemu-arm@nongnu.org>,
	Yuquan Wang <wangyuquan1236@phytium.com.cn>, Itaru Kitayama
	<itaru.kitayama@linux.dev>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
	<philmd@linaro.org>, Alireza Sanaee <alireza.sanaee@huawei.com>
Subject: [PATCH v14 3/5] hw/cxl-host: Allow split of establishing memory address and mmio setup.
Date: Wed, 28 May 2025 12:07:24 +0100
Message-ID: <20250528110726.226389-4-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250528110726.226389-1-Jonathan.Cameron@huawei.com>
References: <20250528110726.226389-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 frapeml500008.china.huawei.com (7.182.85.71)

On arm/virt the memory map is set up before any devices are brought
up.  To enable this provide split functions to establish the fw->base
and later to actually map it.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v14: Update wrt to changes in previous patch.
     Add a do_cfwms_set_memmap_and_update_mmio() utility function
     to reduce code duplication. (Zhijian)
---
 include/hw/cxl/cxl_host.h |  2 ++
 hw/cxl/cxl-host-stubs.c   |  2 ++
 hw/cxl/cxl-host.c         | 43 +++++++++++++++++++++++++++++++++++----
 3 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/include/hw/cxl/cxl_host.h b/include/hw/cxl/cxl_host.h
index 6dce2cde07..aee9d573d6 100644
--- a/include/hw/cxl/cxl_host.h
+++ b/include/hw/cxl/cxl_host.h
@@ -16,6 +16,8 @@
 void cxl_machine_init(Object *obj, CXLState *state);
 void cxl_fmws_link_targets(Error **errp);
 void cxl_hook_up_pxb_registers(PCIBus *bus, CXLState *state, Error **errp);
+hwaddr cxl_fmws_set_memmap(hwaddr base, hwaddr max_addr);
+void cxl_fmws_update_mmio(void);
 hwaddr cxl_fmws_set_memmap_and_update_mmio(hwaddr base, hwaddr max_addr);
 GSList *cxl_fmws_get_all_sorted(void);
 
diff --git a/hw/cxl/cxl-host-stubs.c b/hw/cxl/cxl-host-stubs.c
index 13eb6bf6a4..d9e38618d6 100644
--- a/hw/cxl/cxl-host-stubs.c
+++ b/hw/cxl/cxl-host-stubs.c
@@ -11,6 +11,8 @@
 void cxl_fmws_link_targets(Error **errp) {};
 void cxl_machine_init(Object *obj, CXLState *state) {};
 void cxl_hook_up_pxb_registers(PCIBus *bus, CXLState *state, Error **errp) {};
+hwaddr cxl_fmws_set_memmap(hwaddr base, hwaddr max_addr) { return base; };
+void cxl_fmws_update_mmio(void) {};
 hwaddr cxl_fmws_set_memmap_and_update_mmio(hwaddr base, hwaddr max_addr)
 {
     return base;
diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index 016a4fdc6a..a1b9980035 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -378,11 +378,14 @@ void cxl_hook_up_pxb_registers(PCIBus *bus, CXLState *state, Error **errp)
     }
 }
 
-static void cxl_fmws_update(CXLFixedWindow *fw, hwaddr *base, hwaddr max_addr)
+static void cxl_fmws_update(CXLFixedWindow *fw, hwaddr *base, hwaddr max_addr,
+                            bool update_mmio)
 {
     if (*base + fw->size <= max_addr) {
         fw->base = *base;
-        sysbus_mmio_map(SYS_BUS_DEVICE(fw), 0, fw->base);
+        if (update_mmio) {
+            sysbus_mmio_map(SYS_BUS_DEVICE(fw), 0, fw->base);
+        }
         *base += fw->size;
     }
 }
@@ -421,19 +424,51 @@ GSList *cxl_fmws_get_all_sorted(void)
     return g_slist_sort_with_data(cxl_fmws_get_all(), cfmws_cmp, NULL);
 }
 
-hwaddr cxl_fmws_set_memmap_and_update_mmio(hwaddr base, hwaddr max_addr)
+static hwaddr do_cxl_fmws_set_memmap_and_update_mmio(hwaddr base,
+                                                     hwaddr max_addr,
+                                                     bool update_mmio)
 {
     GSList *cfmws_list, *iter;
 
     cfmws_list = cxl_fmws_get_all_sorted();
     for (iter = cfmws_list; iter; iter = iter->next) {
-        cxl_fmws_update(CXL_FMW(iter->data), &base, max_addr);
+        cxl_fmws_update(CXL_FMW(iter->data), &base, max_addr, update_mmio);
     }
     g_slist_free(cfmws_list);
 
     return base;
 }
 
+hwaddr cxl_fmws_set_memmap(hwaddr base, hwaddr max_addr)
+{
+    return do_cxl_fmws_set_memmap_and_update_mmio(base, max_addr, false);
+}
+
+hwaddr cxl_fmws_set_memmap_and_update_mmio(hwaddr base, hwaddr max_addr)
+{
+    return do_cxl_fmws_set_memmap_and_update_mmio(base, max_addr, true);
+}
+
+static int cxl_fmws_mmio_map(Object *obj, void *opaque)
+{
+    struct CXLFixedWindow *fw;
+
+    if (!object_dynamic_cast(obj, TYPE_CXL_FMW)) {
+        return 0;
+    }
+    fw = CXL_FMW(obj);
+    sysbus_mmio_map(SYS_BUS_DEVICE(fw), 0, fw->base);
+
+    return 0;
+}
+
+void cxl_fmws_update_mmio(void)
+{
+    /* Ordering is not required for this */
+    object_child_foreach_recursive(object_get_root(), cxl_fmws_mmio_map,
+                                   NULL);
+}
+
 static void cxl_fmw_realize(DeviceState *dev, Error **errp)
 {
     CXLFixedWindow *fw = CXL_FMW(dev);
-- 
2.48.1

