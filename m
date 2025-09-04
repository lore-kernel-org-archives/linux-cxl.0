Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B46014A09C
	for <linux-cxl@vger.kernel.org>; Thu,  4 Sep 2025 13:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756991972; cv=none; b=KqPBq6zSMjUlFWBxHzZCeQoEyAYaDTndR1cDEmBEFtV9CpmbWro9HECf92YsYLPVKpnIHyHZyG4cUPVpWspgkC5VaW1fF1TjqERR7Hw5Xu/h4E+u8xzv4PgjFOyhB2C3w9OjFkuVtJ52U4TgXqL2VnhsRZGBciYZ8gt/fg6j+nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756991972; c=relaxed/simple;
	bh=AJvja8IXxwnytvof37xPnzRMPC1zHq8DFSgrGMZleoA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=vEKpi4yy25dmdRttj0h5S3BlfJthpH7WFx1mzk7fB1dKXB355imawuwYH36DDomUUYFQZw8u444+/klZN5B8yL4pp7jK3ySymKB86P9TGMrrxGUw/qf7XQn7Rd42lIN3iceru7zfAnF0Y+eS1Krwj/RfToAUTL54Pgs8ap7p0zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Or46twYY; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Or46twYY"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250904131928epoutp046a9ed48d064d377787a9ff900bf2bc09~iFuLVuWct1284112841epoutp04i
	for <linux-cxl@vger.kernel.org>; Thu,  4 Sep 2025 13:19:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250904131928epoutp046a9ed48d064d377787a9ff900bf2bc09~iFuLVuWct1284112841epoutp04i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1756991968;
	bh=zLYpeIhcfT/XxBu0BEuj7ZMrR7WZpGrO3pguyktAwIo=;
	h=From:To:Cc:Subject:Date:References:From;
	b=Or46twYYQj9Xm1g3UewQR1jC2o7zqqChuaxvSCiJRg/YUvk42lq+YyR8ubL1h2NVa
	 DH1xgdDGmvszZ8M77Rxr32sSC1uhin4tMr/PkeRHuEkeenUNn8CqGdUq56HRW8hQQ1
	 +TCVooPJXhB4ERU8oYGMSPRaX5Lr4tymvyoP2FAU=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250904131927epcas5p37ca6bbf5381bae1889aefd2d55afce40~iFuK2btu61316413164epcas5p3p;
	Thu,  4 Sep 2025 13:19:27 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.88]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4cHg724lp1z6B9m5; Thu,  4 Sep
	2025 13:19:26 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250904131926epcas5p2a363cf0604a4801038d32e7da5397da1~iFuJbY33x1668816688epcas5p2b;
	Thu,  4 Sep 2025 13:19:26 +0000 (GMT)
Received: from test-PowerEdge-R740xd.samsungds.net (unknown [107.99.41.79])
	by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250904131924epsmtip2ea367164ee04a5e4114aadf613edce57~iFuIDcHCu0295402954epsmtip2D;
	Thu,  4 Sep 2025 13:19:24 +0000 (GMT)
From: Arpit Kumar <arpit1.kumar@samsung.com>
To: qemu-devel@nongnu.org
Cc: gost.dev@samsung.com, linux-cxl@vger.kernel.org, dave@stgolabs.net,
	Jonathan.Cameron@huawei.com, vishak.g@samsung.com, krish.reddy@samsung.com,
	a.manzanares@samsung.com, alok.rathore@samsung.com, cpgs@samsung.com, Arpit
	Kumar <arpit1.kumar@samsung.com>
Subject: [PATCH v3 0/2] FM-API Physical Switch Command Set Support
Date: Thu,  4 Sep 2025 18:49:02 +0530
Message-Id: <20250904131904.725758-1-arpit1.kumar@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250904131926epcas5p2a363cf0604a4801038d32e7da5397da1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250904131926epcas5p2a363cf0604a4801038d32e7da5397da1
References: <CGME20250904131926epcas5p2a363cf0604a4801038d32e7da5397da1@epcas5p2.samsung.com>

This patch series refactor existing support for Identify Switch Device
and Get Physical Port State by utilizing physical ports (USP & DSP)
information stored during enumeration. 

Additionally, it introduces new support for Physical Port Control
of FM-API based physical switch command set as per CXL spec r3.2 
Table 8-230:Physical Switch. It primarily constitutes two logic:
-Assert-Deassert PERST: Assert PERST involves physical port to be in 
 hold reset phase for minimum 100ms. No other physical port control
 request are entertained until Deassert PERST command for the given 
 port is issued.
-Reset PPB: cold reset of physical port (completing enter->hold->exit phases).

Tested using libcxl-mi interface[1]:
All active ports and all opcodes per active port is tested. Also, tested
against possible edge cases manually since the interface currently dosen't
support run time input.

Example topology (1 USP + 3 DSP's->switch with 2 CXLType3 devices connected
to 2 DSP's):
FM="-object memory-backend-file,id=cxl-mem1,mem-path=$TMP_DIR/t3_cxl1.raw,size=256M \
    -object memory-backend-file,id=cxl-lsa1,mem-path=$TMP_DIR/t3_lsa1.raw,size=1M \
    -object memory-backend-file,id=cxl-mem2,mem-path=$TMP_DIR/t3_cxl2.raw,size=512M \
    -object memory-backend-file,id=cxl-lsa2,mem-path=$TMP_DIR/t3_lsa2.raw,size=512M \
    -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1,hdm_for_passthrough=true \
    -device cxl-rp,port=0,bus=cxl.1,id=cxl_rp_port0,chassis=0,slot=2 \
    -device cxl-upstream,port=2,sn=1234,bus=cxl_rp_port0,id=us0,addr=0.0,multifunction=on, \
    -device cxl-switch-mailbox-cci,bus=cxl_rp_port0,addr=0.1,target=us0 \
    -device cxl-downstream,port=0,bus=us0,id=swport0,chassis=0,slot=4 \
    -device cxl-downstream,port=1,bus=us0,id=swport1,chassis=0,slot=5 \
    -device cxl-downstream,port=3,bus=us0,id=swport2,chassis=0,slot=6 \
    -device cxl-type3,bus=swport0,memdev=cxl-mem1,id=cxl-pmem1,lsa=cxl-lsa1,sn=3 \
    -device cxl-type3,bus=swport2,memdev=cxl-mem2,id=cxl-pmem2,lsa=cxl-lsa2,sn=4 \
    -machine cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=1k \
    -device i2c_mctp_cxl,bus=aspeed.i2c.bus.0,address=4,target=us0 \
    -device i2c_mctp_cxl,bus=aspeed.i2c.bus.0,address=5,target=cxl-pmem1 \
    -device i2c_mctp_cxl,bus=aspeed.i2c.bus.0,address=6,target=cxl-pmem2 \
    -device virtio-rng-pci,bus=swport1"

Multiple Qemu Topologies tested:
-without any devices connected to downstream ports.
-with virtio-rng-pci devices connected to downstream ports.
-with CXLType3 devices connected to downstream ports.
-with different unique values of ports (both upstream and downstream).

Changes from v2->v3:
-cxl_set_port_type(): optimized storing of strucutre members.
-namespace defines instead of enum.
-Calculating size for active_port_bitmask than hardcoding to 0x20.
-Defined struct phy_port directly inside struct CXLUpstreamPort as pports.
-Renamed struct pperst to struct CXLPhyPortPerst.
-Optimized perst member initializations for ports inside
 cxl_initialize_usp_mctpcci() using active_port_bitmask.

[1] https://github.com/computexpresslink/libcxlmi/commit/35fe68bd9a31469f832a87694d7b18d2d50be5b8

The patches are generated against the Johnathan's tree
https://gitlab.com/jic23/qemu.git and branch cxl-2025-07-03.

Signed-off-by: Arpit Kumar <arpit1.kumar@samsung.com>

Arpit Kumar (2):
  hw/cxl: Refactored Identify Switch Device & Get Physical Port State
  hw/cxl: Add Physical Port Control (Opcode 5102h)

 hw/cxl/cxl-mailbox-utils.c                | 368 +++++++++++++++-------
 include/hw/cxl/cxl_device.h               |  76 +++++
 include/hw/cxl/cxl_mailbox.h              |   1 +
 include/hw/pci-bridge/cxl_upstream_port.h |   9 +
 4 files changed, 347 insertions(+), 107 deletions(-)

-- 
2.34.1

