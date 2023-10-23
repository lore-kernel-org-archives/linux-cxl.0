Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F6F14F70
	for <linux-cxl@vger.kernel.org>; Mon, 23 Oct 2023 16:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49140D6E
	for <linux-cxl@vger.kernel.org>; Mon, 23 Oct 2023 09:15:46 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SDgG91WsYz6K6H6;
	Tue, 24 Oct 2023 00:13:05 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 23 Oct 2023 17:15:43 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, Michael Tsirkin
	<mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
CC: <linuxarm@huawei.com>, Fan Ni <fan.ni@samsung.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Gregory Price
	<gregory.price@memverge.com>, Davidlohr Bueso <dave@stgolabs.net>, Klaus
 Jensen <its@irrelevant.dk>, Corey Minyard <cminyard@mvista.com>
Subject: [PATCH v2 15/17] hw/cxl/type3: Cleanup multiple CXL_TYPE3() calls in read/write functions
Date: Mon, 23 Oct 2023 17:08:04 +0100
Message-ID: <20231023160806.13206-16-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231023160806.13206-1-Jonathan.Cameron@huawei.com>
References: <20231023160806.13206-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected

From: Gregory Price <gourry.memverge@gmail.com>

Call CXL_TYPE3 once at top of function to avoid multiple invocations.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/mem/cxl_type3.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index cc8220592f..a766c64575 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -888,17 +888,18 @@ static int cxl_type3_hpa_to_as_and_dpa(CXLType3Dev *ct3d,
 MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
                            unsigned size, MemTxAttrs attrs)
 {
+    CXLType3Dev *ct3d = CXL_TYPE3(d);
     uint64_t dpa_offset = 0;
     AddressSpace *as = NULL;
     int res;
 
-    res = cxl_type3_hpa_to_as_and_dpa(CXL_TYPE3(d), host_addr, size,
+    res = cxl_type3_hpa_to_as_and_dpa(ct3d, host_addr, size,
                                       &as, &dpa_offset);
     if (res) {
         return MEMTX_ERROR;
     }
 
-    if (sanitize_running(&CXL_TYPE3(d)->cci)) {
+    if (sanitize_running(&ct3d->cci)) {
         qemu_guest_getrandom_nofail(data, size);
         return MEMTX_OK;
     }
@@ -909,17 +910,18 @@ MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
 MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
                             unsigned size, MemTxAttrs attrs)
 {
+    CXLType3Dev *ct3d = CXL_TYPE3(d);
     uint64_t dpa_offset = 0;
     AddressSpace *as = NULL;
     int res;
 
-    res = cxl_type3_hpa_to_as_and_dpa(CXL_TYPE3(d), host_addr, size,
+    res = cxl_type3_hpa_to_as_and_dpa(ct3d, host_addr, size,
                                       &as, &dpa_offset);
     if (res) {
         return MEMTX_ERROR;
     }
 
-    if (sanitize_running(&CXL_TYPE3(d)->cci)) {
+    if (sanitize_running(&ct3d->cci)) {
         return MEMTX_OK;
     }
 
-- 
2.39.2

