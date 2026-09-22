Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F99E4D2EE0
	for <linux-cxl@vger.kernel.org>; Tue, 22 Sep 2026 10:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790071251; cv=none; b=ufnRorhKCZ9EHVOkOuCUQtZNQYPe0rdnlEHf+UzC04XodOqkR64Q7SlEalD0b6TgK+AgbEiEWFvWsvTEpn+zQ+AcjpUThRMjTIWpMRyhV8sqBkvaCtwDsnOk5tYOU9TrQrTcbD2RHK/MYdy5zckKq5/ua8Y/pDeln3cOfaJk6D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790071251; c=relaxed/simple;
	bh=8WmCR5CjhW2NVhXeObpPxnFJZZ/Bef+vuOnuK+qqzNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dVq+yNlUexEqm2G0Aqqr27rUn0pj/rYHuHAjMICEWcsAMDS3FVoLbGWiwMBi/m+q/1dZCTwuQtE0od1OMjGgOKie1dFYTUnSCtXK7urTe1gVPXv/SPUbCnAebH+XMknLSkGHaZQhlMxZD6agl/mbQ+vcLCztB0RAce9HkaroCVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=a+pbI8gv; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="a+pbI8gv"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1790071240; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=lCWNfRvi0ZhAcxevGMWLRfeSq7Zgq+RYDch22I3n+50=;
	b=a+pbI8gvL/7tF++18oZjhC9XX5KHp+8kUKXCd9/KM4Kmb44Bm9cgCWoTo4a0jI8pNNey+IK2EYoz3mJipZbnZURGA3XIAYNC+R7ZCqEgGCnfRfxn9qEeFyER92WEMoaKoV8Wy5MXnK6+gtuhfWIxTtnqIjDoHcwszEhUNgaQMhw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0XBTWPLB_1790071239;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XBTWPLB_1790071239 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 22 Sep 2026 18:00:40 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH 1/3] cxl/pci: Use the Device GPF DVSEC for restricted endpoints
Date: Tue, 22 Sep 2026 18:00:11 +0800
Message-ID: <20260922100026.3742401-2-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260922100026.3742401-1-kanie@linux.alibaba.com>
References: <20260922100026.3742401-1-kanie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cxl_gpf_get_dvsec() picks between the Port and the Device GPF DVSEC
from the PCIe type of the given device, and only a plain endpoint
counts as a device. A restricted CXL device is an endpoint too, but
it falls into the port case and is probed for the Port GPF DVSEC
instead of the Device GPF DVSEC.

On an RCD, dirty shutdown tracking therefore never arms: the DVSEC
lookup in cxl_nvdimm_arm_dirty_shutdown_tracking() fails, the dirty
shutdown count stays invalid, and the warning complains about a
missing Port GPF DVSEC on a device.

Treat restricted endpoints as devices.

Fixes: 36aace15d9bd ("cxl/pci: Drop the parameter is_port of cxl_gpf_get_dvsec()")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/cxl/core/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 9d807c1a002c..e31aad7a525a 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -804,7 +804,8 @@ u16 cxl_gpf_get_dvsec(struct device *dev)
 		return 0;
 
 	pdev = to_pci_dev(dev);
-	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ENDPOINT)
+	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ENDPOINT ||
+	    is_cxl_restricted(pdev))
 		is_port = false;
 
 	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
-- 
2.43.7

