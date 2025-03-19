Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E2A29A2;
	Wed, 19 Mar 2025 03:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742356733; cv=pass; b=IkMQh5+ynPpTSou7IFxnOtZy7q07OG00YlRx5XkZEoBJr4TIJiwqpSwba6O/hDZveXrZp8oA1No38B5fUcBQxWlsgsLLnC7AFTcUWNUTo9gNxAjkM5k9/v7Bb0VfJ6h4mJoP28iHYbgvVJ8O75UVBuQ/LT+jTENngprRwd8DWlE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742356733; c=relaxed/simple;
	bh=OMstznMK93rjXJ4pOYYKe6IuQYAzW9PcWYwQWkolzdw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XL7brXxYEYlsxkX5xa9tvpY2Wp5Ipf9gvakYiGJpLpb2RTz1Sphier7TeVM5Uo1kkFWaP9PsDAXPceKQkSHXyGTKsE5YiV4fKjKR3DOEwh9Mnw3d8HurgOygwneAAUk+YYWqxBsczKpV7JXA+/iGNH2+sTjuxreP/lbwFf0rThs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=UUoN6TGL; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="UUoN6TGL"
ARC-Seal: i=1; a=rsa-sha256; t=1742356701; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SPZTNeV+adrH7gdQHIAUtGmGa1ZpG/mguGTSSFZzfsCz/ATUsQFu+A/hU2rq65B631Do/jVOtDDvi9lXbz322Dc0G3DCJ7DuDeJ5l1vxWnjVh12lN17k3pzVf/Pzp23vmIko8Osw4qutb8O3xJTinZu8WDiABwW1866iMLPcUqM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1742356701; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=7lmtVsGEltZzF1l3MlLgaziMumLElh6VFHIOEXgSvkI=; 
	b=b/JKpvUIsws3A5gGngizC76tPBlIhVPNu04CFCwlb+qQawswJLASRJG89H8sdB3BRz1QJVzzAASPcbFFKd02ljctH638Il5xM977AGuR6pgVGmYfdSPfKaLUUabiZ1Z5h3todo1t0F4RTmqLVOYRCA8KVcJAwG7uhsR/uCHwkvs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742356701;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=7lmtVsGEltZzF1l3MlLgaziMumLElh6VFHIOEXgSvkI=;
	b=UUoN6TGLz7Nx5nNq6eC5Vfb/KSRU9JmQA99iTI0NhpN8hHJv7kqwJCj0ieHXyCdm
	LApN9Ca9pNuuytZU7iHo5ITPJdQV5V/w4q7AgqvrPENetSsxp8Ej9tiDloEVe3LrZ6o
	c0z/otHSaWoS734wYg9WWF1QCgcDNf95dzHDD5N4=
Received: by mx.zohomail.com with SMTPS id 1742356697079760.2970055816222;
	Tue, 18 Mar 2025 20:58:17 -0700 (PDT)
From: Li Ming <ming.li@zohomail.com>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Ming <ming.li@zohomail.com>
Subject: [RFC Patch v1 3/3] cxl/pci: Drop the parameter is_port of cxl_gpf_get_dvsec()
Date: Wed, 19 Mar 2025 11:55:16 +0800
Message-Id: <20250319035516.222054-4-ming.li@zohomail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250319035516.222054-1-ming.li@zohomail.com>
References: <20250319035516.222054-1-ming.li@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr080112276899b114617b00f545746bce0000457f37c546f0786ec6ab44c0f5d4a7d51c27f72e8fdc300e18:zu08011227e815470a02b93affbf1ad9670000e3dfdb3797d2104bbac050b4d3f0e4df7009de1557c1395d5d:rf0801122d4015308c04c2520181955f660000cb8cf28902f27f691629868c920aa63c7508345fd31f7337c18d8f3755b0df:ZohoMail
X-ZohoMailClient: External

The first parameter of cxl_gpf_get_dvsec() is a struct device, can be
used to distinguish if the device is a cxl dport or a cxl pci device by
checking the PCIe type of it, so the parameter is_port is unnecessary
to cxl_gpf_get_dvsec(), using parameter struct device is enough.

Signed-off-by: Li Ming <ming.li@zohomail.com>
---
 drivers/cxl/core/pci.c | 12 +++++++++---
 drivers/cxl/cxl.h      |  2 +-
 drivers/cxl/pmem.c     |  2 +-
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index edbdaf1681e8..3b80e9a76ba8 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -1072,14 +1072,20 @@ int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c)
 #define GPF_TIMEOUT_BASE_MAX 2
 #define GPF_TIMEOUT_SCALE_MAX 7 /* 10 seconds */
 
-u16 cxl_gpf_get_dvsec(struct device *dev, bool is_port)
+u16 cxl_gpf_get_dvsec(struct device *dev)
 {
+	struct pci_dev *pdev;
+	bool is_port = true;
 	u16 dvsec;
 
 	if (!dev_is_pci(dev))
 		return 0;
 
-	dvsec = pci_find_dvsec_capability(to_pci_dev(dev), PCI_VENDOR_ID_CXL,
+	pdev = to_pci_dev(dev);
+	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ENDPOINT)
+		is_port = false;
+
+	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
 			is_port ? CXL_DVSEC_PORT_GPF : CXL_DVSEC_DEVICE_GPF);
 	if (!dvsec)
 		dev_warn(dev, "%s GPF DVSEC not present\n",
@@ -1137,7 +1143,7 @@ int cxl_gpf_port_setup(struct cxl_dport *dport)
 		struct pci_dev *pdev;
 		int dvsec;
 
-		dvsec = cxl_gpf_get_dvsec(dport->dport_dev, true);
+		dvsec = cxl_gpf_get_dvsec(dport->dport_dev);
 		if (!dvsec)
 			return -EINVAL;
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 2d81ccd83916..a9ab46eb0610 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -910,6 +910,6 @@ bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
 #define __mock static
 #endif
 
-u16 cxl_gpf_get_dvsec(struct device *dev, bool is_port);
+u16 cxl_gpf_get_dvsec(struct device *dev);
 
 #endif /* __CXL_H__ */
diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
index d061fe3d2b86..e197883690ef 100644
--- a/drivers/cxl/pmem.c
+++ b/drivers/cxl/pmem.c
@@ -108,7 +108,7 @@ static void cxl_nvdimm_arm_dirty_shutdown_tracking(struct cxl_nvdimm *cxl_nvd)
 		return;
 	}
 
-	if (!cxl_gpf_get_dvsec(cxlds->dev, false))
+	if (!cxl_gpf_get_dvsec(cxlds->dev))
 		return;
 
 	if (cxl_get_dirty_count(mds, &count)) {
-- 
2.34.1

