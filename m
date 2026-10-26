Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.139.117
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793008459;
	b=grwo2gV1Oe6ug3ZduYOx3DBRmRAZjOpedqt29x+KlVH3rKc9LSWw9ou8gSAsq03+4u/3
	 VHs9Zt52N13oackVH646H3yq8M55gOG6KIXxHy8rvVKXCMQYMnblvRyjaAh/GEQ24BlhK
	 rbC+MMXZlzZBmvsrPXjb9R8BOGpAJ0iC9JKnT7GiOzW24mKW4yCWfr/YKHHd1fSDqg4E0
	 p3QwiU+nAJT0aeXmBPfQqMdTOlkKcDaXs5voYQmqKMG8yU81GHtRyCxwnUSjh1wdQJQDx
	 uWqgcHnwyV0hhINKwTYSIPryXdxvSCcNIAh3pMtV5CUNADC1mhq+CFFKmhP8xhAhepw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793008459;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=rmht22CGrxfL4vYhIbCQTiNGlGP2TjapHUWtXZPfvLk=;
	b=xjuMtKoseLcPcfl3mBKbs1AYyVRKxrfrkfFYglr4iF7yhaCi6vDl4pEgC6NiTv9ySx13
	 xZXpNeGe9NYUF5RQ/gne0tDBMWE4QrVemZBmV6KO1iPltFFasAjFeSossKOJVHwWONeEp
	 fEzQQtx7oqIzJ9sp1NhLWiibMvucu4vac0NwtfkPXCz51sG/ywBiIRVYWNGjgOhX341G3
	 Vqzznl4VWzyVIxrYoe+baCtLoYcnxgF/HGe9On/0fpn2G9Iu6+e4KhcbT+JWGQ8dTsS0V
	 qzcE6xInZ/YmDT9dHXqUi4w5RukBgA5CvwlWQmXWh2HOuVUrkxg6CFVN8wT3QQio0Vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fujitsu.com;
	spf=pass smtp.mailfrom=fujitsu.com;
	dkim=pass header.d=fujitsu.com header.i=@fujitsu.com header.a=rsa-sha256 header.s=fj2 header.b=Ma6SBon+;
	arc=none smtp.remote-ip=68.232.139.117
Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com [68.232.139.117])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51793606A31B
	for <linux-cxl@vger.kernel.org>; Mon, 26 Oct 2026 09:54:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51793606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fujitsu.com header.i=@fujitsu.com header.a=rsa-sha256 header.s=fj2 header.b=Ma6SBon+
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1793008458; x=1824544458;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/tmmNQTc1uXtVHQp9ghXgdfmfuVHFU+fKjxTNRMw6H4=;
  b=Ma6SBon+Be4B5FACx/KaUmoShLnXZFqYbKujXTeCzDlQY0Txx331iiGj
   9heZGvOyQAxKmOV1Mr+Pm+K4E8SQ81Ga2VA22n4j1Yf4DHjrZu5x2NBvV
   n+NKvvEt1BIY6qslItbGbF0t7tlLjNIyqCCkPvZ8zgQMiBBK1y/HZ5Tjy
   GTLA5n4mP1w8hwddw8rnHXkyVCCWlMbJJ9Ert1QaFW3GuqkrPFS7KHXyt
   I4ahh6MTDxwYmbSpo2tsqcjW/sAXwaVb8oXC+w1PGHVV9YyrEH7XZfLBv
   hjUXaaegXJmukE3Xw6Xl+TYajAas5MastBWAk28KQX1FQPKoevC6RwG8C
   A==;
X-CSE-ConnectionGUID: BX6OIwL8R2+2MoxHmqW4ww==
X-CSE-MsgGUID: Koutv4eHRRqeUSmhveugRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="259010301"
X-IronPort-AV: E=Sophos;i="6.27,179,1786978800"; 
   d="scan'208";a="259010301"
Received: from gmgwnl01.global.fujitsu.com ([52.143.17.124])
  by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 18:54:11 +0900
Received: from az2nlsmgm2.o.css.fujitsu.com (unknown [10.150.26.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gmgwnl01.global.fujitsu.com (Postfix) with ESMTPS id 861EC1000371
	for <linux-cxl@vger.kernel.org>; Mon, 26 Oct 2026 09:54:11 +0000 (UTC)
Received: from m3003.s.css.fujitsu.com (unknown [10.128.233.114])
	by az2nlsmgm2.o.css.fujitsu.com (Postfix) with ESMTP id 019CA1C002EE
	for <linux-cxl@vger.kernel.org>; Mon, 26 Oct 2026 09:54:11 +0000 (UTC)
Received: from tanjiro.soft.fujitsu.com (unknown [10.118.236.61])
	by m3003.s.css.fujitsu.com (Postfix) with ESMTP id C1B00202EBDE;
	Mon, 26 Oct 2026 18:54:09 +0900 (JST)
From: Yukiya Takaki <fj2110jc@fujitsu.com>
To: qemu-devel@nongnu.org
Cc: Yukiya Takaki <fj2110jc@fujitsu.com>,
	Anisa Su <anisa.su@samsung.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Junjie Cao <junjie.cao@intel.com>,
	linux-cxl@vger.kernel.org,
	"Wolski, Tomasz" <tomasz.wolski@fujitsu.com>,
	lizhijian@fujitsu.com,
	y-goto@fujitsu.com,
	yukiya.takaki@gmail.com
Subject: [PATCH RFC 3/7] QEMU: hw/cxl: add helper to get HPA range for CXL Type 3
Date: Mon, 26 Oct 2026 19:03:24 +0900
Message-ID: <22b52860497f643217fb52f029d87ebd8a6e6492.1793003983.git.fj2110jc@fujitsu.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1793003983.git.fj2110jc@fujitsu.com>
References: <cover.1793003983.git.fj2110jc@fujitsu.com>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The previously added `hpa_offset` on CXLType3Dev records the offset of a
device within its CFMW window, but there is no simple helper to obtain the
full host physical address (HPA) range for a given Type 3 device.

This patch adds `ct3_type3_get_hpm_range()`, which returns the HPA base and
size for a CXLType3Dev by combining the CFMW base, the per‑device offset
and the device size. The helper is declared in the header so that other
code can use it when building tables and regions.

Co-developed-by: Li Zhijian <lizhijian@fujitsu.com>
Signed-off-by: Yukiya Takaki <fj2110jc@fujitsu.com>
---
 hw/mem/cxl_type3.c          | 40 +++++++++++++++++++++++++++++++++++++
 include/hw/cxl/cxl_device.h |  1 +
 2 files changed, 41 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index d08a4255c9..811f8e247d 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1358,6 +1358,46 @@ MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
     return address_space_write(as, dpa_offset, attrs, &data, size);
 }
 
+static uint64_t c3t_addr_size(DeviceState *dev)
+{
+    CXLType3Dev *ct3d = CXL_TYPE3(dev);
+    MemoryRegion *vmr = host_memory_backend_get_memory(ct3d->hostvmem);
+
+    return memory_region_size(vmr);
+}
+
+static uint64_t c3t_hpa_base(DeviceState *dev)
+{
+    GSList *cfmws_list, *iter;
+
+    cfmws_list = cxl_fmws_get_all_sorted();
+    for (iter = cfmws_list; iter; iter = iter->next) {
+        struct CXLFixedWindow *fw;
+
+        if (!object_dynamic_cast(iter->data, TYPE_CXL_FMW)) {
+            continue;
+        }
+        fw = CXL_FMW(iter->data);
+
+        PXBCXLDev *pxb = fw->target_hbs[0];
+        if (ct3d_to_cxl_pxb(dev) != pxb->cxl_host_bridge) {
+            continue;
+        }
+
+        g_slist_free(cfmws_list);
+        return fw->base;
+    }
+    g_slist_free(cfmws_list);
+
+    return 0;
+}
+
+void ct3_type3_get_hpm_range(CXLType3Dev *dev, uint64_t *base, uint64_t *size)
+{
+    *base = c3t_hpa_base(DEVICE(dev)) + dev->hpa_offset;
+    *size = c3t_addr_size(DEVICE(dev));
+}
+
 static void ct3d_reset(DeviceState *dev)
 {
     CXLType3Dev *ct3d = CXL_TYPE3(dev);
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index c3a729f8c5..07654f4b62 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -878,6 +878,7 @@ void ct3_clear_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
                                    uint64_t len);
 bool ct3_test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
                                   uint64_t len);
+void ct3_type3_get_hpm_range(CXLType3Dev *dev, uint64_t *base, uint64_t *size);
 void cxl_assign_event_header(CXLEventRecordHdr *hdr,
                              const QemuUUID *uuid, uint32_t flags,
                              uint8_t length, uint64_t timestamp,
-- 
2.52.0

