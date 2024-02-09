Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CC92D60A
	for <linux-cxl@vger.kernel.org>; Fri,  9 Feb 2024 11:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.37.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707479735; cv=none; b=hfY0UuxTBYvn07zdVB9zH412hQMTdv6CkE2IKABLT+NCAzJFyCobmOjIDqF6hf//+UcPVhkK0Lxru5yFPALdRHFnBkAoz6FG9KSY2jX9ygrrTMBcxXHtWk23cNTV+cBAmmh5DSVPJM3WNNQ3OfHs8nzKkuIhMIgE+Eh3ZD6AISk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707479735; c=relaxed/simple;
	bh=Z7T5L3Tda6BxZYidR6fnaq/tpChYL2fRgPdxqk3pY3E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SHJ8+TiuTavn9QyH13T7wALJVRwynvPNiW+SJvNYp4KKGEnNLXKY7cddgCZk2px28aNa6ENILbarbdl+vkHzYUgZlBgYWLTlJ+VDvZPdg3o8fqwTAB/hzfYnBkcJ61fSTDEyaKjrizYDloBrFw32FMCTKabACsGH4PFYuwug5pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=r2ohBbnL; arc=none smtp.client-ip=139.138.37.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="r2ohBbnL"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1707479733; x=1739015733;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Z7T5L3Tda6BxZYidR6fnaq/tpChYL2fRgPdxqk3pY3E=;
  b=r2ohBbnLYslrhv1epGe/88xA+t9EG4gjK2vrLKgznYQNnV0feEGOYdj0
   a85ipLVJny5/XvNapIh+jMwyHte4lyZ+KJiH+z65UVEDgTaioToUl0vQt
   oEYFkkdHOLYx5uz+xsVQ+kq6p6420hHXfy/chyZPmea/WWkeH3+gzQPmx
   mTOWRP002QpY00mJHHqcg/bVCtrjhmRIh336q8AHFDwyzGckzmluaqtCF
   uLaVsprN/P3DU2mZNDJ+BMTlmSb5MS+OmRIs7K0PkG/R/o0q7t8taNoGp
   gtBZ56wcBymVOMDqlNfrGk+y4AZeYSmT0S1CcGgbAiyVXLum/y9zCV0tL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="128242538"
X-IronPort-AV: E=Sophos;i="6.05,256,1701097200"; 
   d="scan'208";a="128242538"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 20:54:21 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
	by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id D78EEF2D56
	for <linux-cxl@vger.kernel.org>; Fri,  9 Feb 2024 20:54:19 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 0BA2BD6237
	for <linux-cxl@vger.kernel.org>; Fri,  9 Feb 2024 20:54:19 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id A3B7720097CED
	for <linux-cxl@vger.kernel.org>; Fri,  9 Feb 2024 20:54:18 +0900 (JST)
Received: from irides.g08.fujitsu.local (unknown [10.167.226.114])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 309C51A009A;
	Fri,  9 Feb 2024 19:54:18 +0800 (CST)
From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
To: qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org
Cc: Jonathan.Cameron@huawei.com,
	dan.j.williams@intel.com
Subject: [RFC PATCH 1/2] hw/cxl/type3: add missing flag bit for GMER
Date: Fri,  9 Feb 2024 19:54:11 +0800
Message-Id: <20240209115417.724638-2-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240209115417.724638-1-ruansy.fnst@fujitsu.com>
References: <20240209115417.724638-1-ruansy.fnst@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28180.007
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28180.007
X-TMASE-Result: 10--6.570700-10.000000
X-TMASE-MatchedRID: UpZ+EYxJ0vn5S+IvXI7mDU7nLUqYrlslFIuBIWrdOeOjEIt+uIPPOC/6
	oQ/dDcvK+XV+0/kEbzbCWEJl/eJ/AWdMDh/Ba5IyngIgpj8eDcBpkajQR5gb3lQwtQm7iV5jKra
	uXd3MZDUcjalIOG21n4U/djnIxCr4sKweaq3mGKFHXsfuoS1sXjJ4wpepbn7q
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

The "Volatile" should be set if current device is a volatile memory.
Per CXL Spec r3.0 8.2.9.2.1.1, Table 8-43.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 hw/mem/cxl_type3.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 52647b4ac7..d8fb63b1de 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1285,6 +1285,9 @@ static const QemuUUID memory_module_uuid = {
                  0x79, 0xba, 0xb1, 0x13, 0xb7, 0x74),
 };
 
+#define CXL_GMER_DPA_VOLATILE                           BIT(0)
+#define CXL_GMER_DPA_NOT_REPAIRABLE                     BIT(1)
+
 #define CXL_GMER_VALID_CHANNEL                          BIT(0)
 #define CXL_GMER_VALID_RANK                             BIT(1)
 #define CXL_GMER_VALID_DEVICE                           BIT(2)
@@ -1348,6 +1351,9 @@ void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
     cxl_assign_event_header(hdr, &gen_media_uuid, flags, sizeof(gem),
                             cxl_device_get_timestamp(&ct3d->cxl_dstate));
 
+    if (ct3d->hostvmem) {
+        dpa |= CXL_GMER_DPA_VOLATILE;
+    }
     stq_le_p(&gem.phys_addr, dpa);
     gem.descriptor = descriptor;
     gem.type = type;
-- 
2.34.1

