Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0204A2DC775;
	Wed, 30 Apr 2025 01:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.37.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745976634; cv=none; b=NElzRwO+Ng/sM8sd/yXWxpYAyqOl4edU7R63MF8F00oU4WsHVIDCXsO7tndbcWRQKRigwEcOwzz+DYX8+RlG1xjmrkxDYi9Ql5Dh+qahtXuEvP7iK2hFInd1Qrnut6SaDmhgB+Bv1hHk3VnznqogMtG6/js4BW0boCxSCbhUW/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745976634; c=relaxed/simple;
	bh=u5ZyN8SzOBT5hAHJ1lMX9Syyf7NZL+fhlUK/ToIs5QY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=BzrcB69TDV/1rVQV3VjOUvUFRs96AxPkYdU1XOJrB0ILT1YLlun9QiKRwR4KTNfNNM8rp+0PmCr8Z6/l0kFTzrB6DXFD77IeRFYDxyCfRu0sIjFAHZdUEjMWJ98E69+uz31xYTbKxFF9ddVyTTk8yxN08OFQxapB9IixZxlenEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=VGjVbim1; arc=none smtp.client-ip=139.138.37.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="VGjVbim1"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1745976632; x=1777512632;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=u5ZyN8SzOBT5hAHJ1lMX9Syyf7NZL+fhlUK/ToIs5QY=;
  b=VGjVbim1kfEkmM6qRL6f5u1MJMBMdsSprJsCASPnrNdgd1qXflZZOUk2
   Jzn+cO1tUHD6hhK+JxvvpkIpc/4Na8gyiGvppDu4MFRrnTc7vh96GG2HS
   CCaYm5AFu2k2ZiIS7J208ZPxhyKnylsw8ghaoHCMNfh4ySk1bUclMxre5
   VoOxzwwMYMb/yLZPqm9RrScSBlIhviAzkSWxtcnUQdtjuW0yPOhXitDfy
   UhA6afK0EFLknnQH6RVjaUyaKBWX82LTv/ogfMRqyQJ7zHmw/gUtdSI2N
   EmBwRsMuyzZGaeupbEqJCRRJ1jS6Mfa5o4z9ZxVik4G/wiScHQQU+jxpm
   g==;
X-CSE-ConnectionGUID: gX7J6P1IQ06FkkXfXCiq6w==
X-CSE-MsgGUID: AoZqcz9kTaC68y2XCd4xHw==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="176955983"
X-IronPort-AV: E=Sophos;i="6.15,250,1739804400"; 
   d="scan'208";a="176955983"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 10:29:20 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
	by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 9BE3D96743;
	Wed, 30 Apr 2025 10:29:18 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 5A43ECFA5A;
	Wed, 30 Apr 2025 10:29:18 +0900 (JST)
Received: from iaas-rpma.. (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 4EB271A0071;
	Wed, 30 Apr 2025 09:29:17 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-cxl@vger.kernel.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-kernel@vger.kernel.org,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [RFC PATCH] cxl: Allow reprogramming misconfigured hdm decoders
Date: Wed, 30 Apr 2025 09:29:15 +0800
Message-Id: <20250430012915.295136-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

During kernel booting, CXL drivers will attempt to construct the CXL region
according to the pre-programed(firmware provisioning) HDM decoders.

This construction process will fail for some reasons, in this case, the
userspace cli like ndctl/cxl cannot destroy nor create regions upon the
existing decoders.

Introuce a new flag CXL_DECODER_F_NEED_RESET tell the driver to reset
the decoder during `cxl destroy-region regionN`, so that region can be
create again after that.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
Cover letter is here.

Hi all,

Previously, we encountered a CXL device with differing IG between the device
and its USP, which resulted in the driver’s failure to automatically
complete the creation of the region, and user cannot create/destroy region
after this failure.

Although this IG issue has been ignored in the new kernel [1], I realized
that if there was an error in firmware provisioning the HDM decoders, the
user might not be able to destroy the unfinished region and recreate it.
This is because certain components related to this region are in an
inconsistent state, preventing the CXL tool from operating on it.

This implies that the OS administrator cannot reconfigure the CXL device,
which is largely contrary to user expectations. I am keen to hear your
thoughts on this matter.

A modified QEMU [2] is able to limitly program the HDM decoders to inject some
wrong decoder configurations.

[1] https://lore.kernel.org/lkml/20250402232552.999634-1-gourry@gourry.net/
[2] https://github.com/zhijianli88/qemu/tree/program-decoder

---
---
 drivers/cxl/core/hdm.c       | 4 +++-
 drivers/cxl/core/region.c    | 6 ++++--
 drivers/cxl/cxl.h            | 3 ++-
 tools/testing/cxl/test/cxl.c | 1 +
 4 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 70cae4ebf8a4..afbbda780d4d 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -559,7 +559,8 @@ int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
 			dev_name(&cxled->cxld.region->dev));
 		return -EBUSY;
 	}
-	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE) {
+	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE &&
+	    !(cxled->cxld.flags & CXL_DECODER_F_NEED_RESET)) {
 		dev_dbg(dev, "decoder enabled\n");
 		return -EBUSY;
 	}
@@ -918,6 +919,7 @@ static void cxl_decoder_reset(struct cxl_decoder *cxld)
 	up_read(&cxl_dpa_rwsem);
 
 	cxld->flags &= ~CXL_DECODER_F_ENABLE;
+	cxld->flags &= ~CXL_DECODER_F_NEED_RESET;
 
 	/* Userspace is now responsible for reconfiguring this decoder */
 	if (is_endpoint_decoder(&cxld->dev)) {
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index c3f4dc244df7..d025e892d07d 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2096,7 +2096,8 @@ static int cxl_region_detach(struct cxl_endpoint_decoder *cxled)
 	p = &cxlr->params;
 	get_device(&cxlr->dev);
 
-	if (p->state > CXL_CONFIG_ACTIVE) {
+	if (p->state > CXL_CONFIG_ACTIVE ||
+	    cxled->cxld.flags & CXL_DECODER_F_NEED_RESET) {
 		cxl_region_decode_reset(cxlr, p->interleave_ways);
 		p->state = CXL_CONFIG_ACTIVE;
 	}
@@ -3434,7 +3435,8 @@ int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
 		if (device_attach(&cxlr->dev) < 0)
 			dev_err(&cxlr->dev, "failed to enable, range: %pr\n",
 				p->res);
-	}
+	} else
+		cxled->cxld.flags |= CXL_DECODER_F_NEED_RESET;
 
 	put_device(region_dev);
 out:
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index be8a7dc77719..60fae072bbcf 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -331,7 +331,8 @@ int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
 #define CXL_DECODER_F_TYPE3 BIT(3)
 #define CXL_DECODER_F_LOCK  BIT(4)
 #define CXL_DECODER_F_ENABLE    BIT(5)
-#define CXL_DECODER_F_MASK  GENMASK(5, 0)
+#define CXL_DECODER_F_NEED_RESET    BIT(6)
+#define CXL_DECODER_F_MASK  GENMASK(6, 0)
 
 enum cxl_decoder_type {
 	CXL_DECODER_DEVMEM = 2,
diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 1c3336095923..5dac454ca0e2 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -709,6 +709,7 @@ static void mock_decoder_reset(struct cxl_decoder *cxld)
 			"%s: out of order reset, expected decoder%d.%d\n",
 			dev_name(&cxld->dev), port->id, port->commit_end);
 	cxld->flags &= ~CXL_DECODER_F_ENABLE;
+	cxld->flags &= ~CXL_DECODER_F_NEED_RESET;
 }
 
 static void default_mock_decoder(struct cxl_decoder *cxld)
-- 
2.27.0

