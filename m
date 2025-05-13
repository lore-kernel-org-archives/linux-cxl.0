Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949DB273FD
	for <linux-cxl@vger.kernel.org>; Tue, 13 May 2025 11:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747134994; cv=none; b=Lxizintzf+10eP+w+GlbRYW+ISQw5yxuI95u2cHs0XbBqv16HmnpS9r6lOAJ0Rbvzwv77aRAmPZJkyUfADg6Nad8/y8lVZUxt0ewHW8+qCvR0Bk97nDK9eJVyoNrCuD4TeWCXhBSy8kCxrWxTed5z9oYkmyND3EkgpZyvbMHjQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747134994; c=relaxed/simple;
	bh=sWs/uBsAXwA8hhM+TIZpkiO6k/6FfcaqNqXsqyr0REM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HmuA2cLfwFUqteJZRMqyYP+VIYaF43I6uMXHAlEQBs1c0cZiC8ALlDDvf/NruPHlqOPW51JbkPG3VFZKjVZrj0K7z2ZWtfz9+t6zO3wkfNgwVuSP3cHBrRiRKGwH174w1Su2j6AEtABKiBsrw/xBRrhrIl35ogWu6o83ftfbAuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZxYhQ0h1yz6M4Lf;
	Tue, 13 May 2025 19:11:50 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 5A624140276;
	Tue, 13 May 2025 19:16:30 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 13 May 2025 13:16:29 +0200
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <qemu-devel@nongnu.org>, Fan Ni <fan.ni@samsung.com>, Peter Maydell
	<peter.maydell@linaro.org>, <mst@redhat.com>
CC: <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>, <qemu-arm@nongnu.org>,
	Yuquan Wang <wangyuquan1236@phytium.com.cn>, Itaru Kitayama
	<itaru.kitayama@linux.dev>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
	<philmd@linaro.org>
Subject: [PATCH v13 3/5] hw/cxl-host: Allow split of establishing memory address and mmio setup.
Date: Tue, 13 May 2025 12:14:53 +0100
Message-ID: <20250513111455.128266-4-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250513111455.128266-1-Jonathan.Cameron@huawei.com>
References: <20250513111455.128266-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500008.china.huawei.com (7.182.85.71)

On arm/virt the memory map is set up before any devices are brought
up.  To enable this provide split functions to establish the fw->base
and later to actually map it.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/cxl/cxl_host.h |  2 ++
 hw/cxl/cxl-host-stubs.c   |  2 ++
 hw/cxl/cxl-host.c         | 44 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 47 insertions(+), 1 deletion(-)

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
index 438f2920e1..3b9184e7e7 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -383,6 +383,7 @@ void cxl_hook_up_pxb_registers(PCIBus *bus, CXLState *state, Error **errp)
 struct cfmw_update_state {
     hwaddr base;
     hwaddr maxaddr;
+    bool update_mmio;
 };
 
 static void cxl_fmws_update(Object *obj, void *opaque)
@@ -397,7 +398,9 @@ static void cxl_fmws_update(Object *obj, void *opaque)
     fw = CXL_FMW(obj);
     if (s->base + fw->size <= s->maxaddr) {
         fw->base = s->base;
-        sysbus_mmio_map(SYS_BUS_DEVICE(fw), 0, fw->base);
+        if (s->update_mmio) {
+            sysbus_mmio_map(SYS_BUS_DEVICE(fw), 0, fw->base);
+        }
         s->base += fw->size;
     }
 
@@ -438,6 +441,24 @@ GSList *cxl_fmws_get_all_sorted(void)
     return g_slist_sort_with_data(cxl_fmws_get_all(), cfmws_cmp, NULL);
 }
 
+hwaddr cxl_fmws_set_memmap(hwaddr base, hwaddr max_addr)
+{
+    GSList *cfmws_list, *iter;
+
+    struct cfmw_update_state cfmwss = {
+        .base = base,
+        .maxaddr = max_addr,
+        .update_mmio = false,
+    };
+    cfmws_list = cxl_fmws_get_all_sorted();
+    for (iter = cfmws_list; iter; iter = iter->next) {
+        cxl_fmws_update(iter->data, &cfmwss);
+    }
+    g_slist_free(cfmws_list);
+
+    return cfmwss.base;
+}
+
 hwaddr cxl_fmws_set_memmap_and_update_mmio(hwaddr base, hwaddr max_addr)
 {
     GSList *cfmws_list, *iter;
@@ -445,6 +466,7 @@ hwaddr cxl_fmws_set_memmap_and_update_mmio(hwaddr base, hwaddr max_addr)
     struct cfmw_update_state cfmwss = {
         .base = base,
         .maxaddr = max_addr,
+        .update_mmio = true,
     };
     cfmws_list = cxl_fmws_get_all_sorted();
     for (iter = cfmws_list; iter; iter = iter->next) {
@@ -455,6 +477,26 @@ hwaddr cxl_fmws_set_memmap_and_update_mmio(hwaddr base, hwaddr max_addr)
     return cfmwss.base;
 }
 
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
2.43.0

