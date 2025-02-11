Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4998C26BD99
	for <linux-cxl@vger.kernel.org>; Tue, 11 Feb 2025 02:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739240728; cv=none; b=ONT8W3H2bEwXFnzER3hWv2mwAE/NzlWrikaKCn54xnJgQ1lEki5ifFa8JOBVjHJwGRTsFAOVFGbUkPW7lVAwxxmmFJYgCyjAaJAPvje5Bl8zX/0U8x/5jv96iTMpRbeD/MrNR7x9sXyAj4oadsX/7fXb3DuWEivzemkIk9duWmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739240728; c=relaxed/simple;
	bh=0O2ATZHlphR3EfLjQJHpwFlKxiFcZANccA0NltEbQic=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wzz6Zd+EZJe0pQwf2Euzj6VX0IoiqlATbINTaIz8k3SOphdlhleM4wWrYW0SJYpUrpRnRKIzLPEyXUwwrKo7rbqi5Qr/GqTB1pAb+TPUoeST+TxfpeJ712hMd2jqKElisiL1kXnqT93TvBQrd43pT2LK72FU9Q4+B1NBGMUh0e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwB3fl7wtKpnq41YAg--.25959S2;
	Tue, 11 Feb 2025 10:24:48 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
	by mail (Coremail) with SMTP id AQAAfwDX3YnmtKpnW+AgAA--.43854S4;
	Tue, 11 Feb 2025 10:24:42 +0800 (CST)
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: jonathan.cameron@huawei.com,
	fan.ni@samsung.com
Cc: qemu-devel@nongnu.org,
	chenbaozi@phytium.com.cn,
	linux-cxl@vger.kernel.org,
	Yuquan Wang <wangyuquan1236@phytium.com.cn>
Subject: [PATCH 1/1] mem/cxl-type3: Add a default value of sn
Date: Tue, 11 Feb 2025 10:24:13 +0800
Message-Id: <20250211022413.80842-2-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211022413.80842-1-wangyuquan1236@phytium.com.cn>
References: <20250211022413.80842-1-wangyuquan1236@phytium.com.cn>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwDX3YnmtKpnW+AgAA--.43854S4
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQASAWeqWwIBbQAAsq
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7WF1xGrW7Xw4xWFyUCFyUZFb_yoW8tr15pr
	WagFy5KFs7ArnxJrWvya45Jw1xWFsag34UAasxAw17ZF92vwn0qr1DKryFkFyDuayxAr1U
	ta12ga429w43Kw7anT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

The previous default value of sn is UI64_NULL which would cause the
cookie of nd_interleave_set be '0' and the "invalid interleave-set
-cookie" failure in label validation.

As many users maybe not know how to set a unique sn for cxl-type3
device and perhaps be confuesd by the failure of label validation,
so this defines '1' as the default value of serial number to fix the
problem.

Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
---
 hw/mem/cxl_type3.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 0ae1704a34..a6b5a9f74e 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -310,12 +310,6 @@ static void ct3d_config_write(PCIDevice *pci_dev, uint32_t addr, uint32_t val,
     pcie_aer_write_config(pci_dev, addr, val, size);
 }
 
-/*
- * Null value of all Fs suggested by IEEE RA guidelines for use of
- * EU, OUI and CID
- */
-#define UI64_NULL ~(0ULL)
-
 static void build_dvsecs(CXLType3Dev *ct3d)
 {
     CXLComponentState *cxl_cstate = &ct3d->cxl_cstate;
@@ -856,12 +850,9 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
     pci_config_set_prog_interface(pci_conf, 0x10);
 
     pcie_endpoint_cap_init(pci_dev, 0x80);
-    if (ct3d->sn != UI64_NULL) {
-        pcie_dev_ser_num_init(pci_dev, 0x100, ct3d->sn);
-        cxl_cstate->dvsec_offset = 0x100 + 0x0c;
-    } else {
-        cxl_cstate->dvsec_offset = 0x100;
-    }
+
+    pcie_dev_ser_num_init(pci_dev, 0x100, ct3d->sn);
+    cxl_cstate->dvsec_offset = 0x100 + 0x0c;
 
     ct3d->cxl_cstate.pdev = pci_dev;
     build_dvsecs(ct3d);
@@ -1225,7 +1216,7 @@ static const Property ct3_props[] = {
                      TYPE_MEMORY_BACKEND, HostMemoryBackend *),
     DEFINE_PROP_LINK("lsa", CXLType3Dev, lsa, TYPE_MEMORY_BACKEND,
                      HostMemoryBackend *),
-    DEFINE_PROP_UINT64("sn", CXLType3Dev, sn, UI64_NULL),
+    DEFINE_PROP_UINT64("sn", CXLType3Dev, sn, 0x1),
     DEFINE_PROP_STRING("cdat", CXLType3Dev, cxl_cstate.cdat.filename),
     DEFINE_PROP_UINT8("num-dc-regions", CXLType3Dev, dc.num_regions, 0),
     DEFINE_PROP_LINK("volatile-dc-memdev", CXLType3Dev, dc.host_dc,
-- 
2.34.1

