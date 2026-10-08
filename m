Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3523018E025
	for <linux-cxl@vger.kernel.org>; Thu,  8 Oct 2026 03:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791431197; cv=none; b=MzPDi2KG7ben3wDHwmdU9wmvjojRyoA/trPQpigRUXsTYZiVWcgC2PnaoLqvUPkB14PMTgPcjaLhQO7glfr0yIQ3eQCkYRrODQth/tFcKHHxOO8NP99nV/uqDnjzrF0WxCog4/mqE696fIVBpbNkeVh+dUCyVDv2vUVKM0ADjRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791431197; c=relaxed/simple;
	bh=SeqoTy9+EKk4ZTevGmk5buRdDbNhj712Io4HnZVzki8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kWiIuDA1jjN+tJPxd2iHiIaR322KXG8SKNhPvFmRzbUM8uEMmUSFr7OuoWgyZiTRswueNH43CInF0ohvscVaeSeKcfBn2FUNVQ7HB7GWZherY929fY77oh04/x+bUhVGEcSuumjlxfVTMYwJegLk89V93FkiVoNep/g7Plx4EfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=IHFipP9I; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="IHFipP9I"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1791431189; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=E2eArMk3wqwwVk6WCEOa8C2qDWDQP70jo89CWmed5Qw=;
	b=IHFipP9I2b67Ry/kXe+pWER6gb8QcnuYgdDT+iDEXk7LY99lCWA+VCS4tfw0x0Anf04/vKOZo1u9zM2x2uwm0QSfxese7qpV3lljwClh/Yf7auaFNVM1wPMLLDGQ6vaK6T0mi3kLa2D2mWc+Rbvic3sBfpLj196z/Lv7UnOzyOM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R381e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0XCJd7mn_1791431188;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XCJd7mn_1791431188 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 08 Oct 2026 11:46:28 +0800
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
Subject: [PATCH v2 1/3] cxl/pci: Use the Device GPF DVSEC for restricted endpoints
Date: Thu,  8 Oct 2026 11:46:12 +0800
Message-ID: <20261008034619.28059-2-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261008034619.28059-1-kanie@linux.alibaba.com>
References: <20261008034619.28059-1-kanie@linux.alibaba.com>
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
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
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

