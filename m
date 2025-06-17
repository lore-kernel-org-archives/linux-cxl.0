Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E322E92D3
	for <linux-cxl@vger.kernel.org>; Tue, 17 Jun 2025 13:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750165389; cv=none; b=tAJPsxDrDcaoksjDCkMt18YcDcjQF4UrasCUBDgm//8gnNvmRsan1NBLD50q9N6s1Nj0BHABU2IOB/rtGotqVcRZfpzstHB1ncCIFNwj2oCLOpZblpatmUNPlCHcnVF+R7zmRjwzmmBz5fYMh+81QPkhOKE4TJDOdN/F1bg3OMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750165389; c=relaxed/simple;
	bh=b7BVG3FrdKR4itfFL5hAWRa4x5j6YdYdxQ3wVph1Zw8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=Ul+NvJRBhS5cQiKjgv1b7cplZ6c5VAvZIQKXK8NNgRNgGrMdvkkPKpeSwF97Wwb+GKxhUP917LSfRIJWyEI4fyuxXL879RXMKFXRM77s6i1OPCVwWt6HV52Sc+ac5jN0mfBiA4c9uqklB4wvcw2/uWzFtyC94k62dXscfDsN/ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=iGuxFWgP; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="iGuxFWgP"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250617130303epoutp02619d334085f5fc9fe68de638ca353ff8~J1iTY80vX2453024530epoutp02K
	for <linux-cxl@vger.kernel.org>; Tue, 17 Jun 2025 13:03:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250617130303epoutp02619d334085f5fc9fe68de638ca353ff8~J1iTY80vX2453024530epoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1750165383;
	bh=Pr2FwwrRwwlTuBgxlXhcxK36JX8grbSnqXMfG7T2C24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iGuxFWgPDMyEJPtPfHSGc+fEhL+CXyiTvKT5cvtQIFGq7Si+bt9Me7OCeEIJY9tXa
	 /DHHRCcBgf8lS/ArYRN+Xcv7Ofh1V0B4suDN58+XiDE97BrWHxWx7FO2rrX755H4/U
	 AMLH3uqdjtX7af1ditJs8lp9aGcZnRA/L/ae9Xm4=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20250617130303epcas5p1359a6a34e28a04e67691ff95c1e49b76~J1iSvIEr22019620196epcas5p13;
	Tue, 17 Jun 2025 13:03:03 +0000 (GMT)
Received: from epcpadp2new (unknown [182.195.40.142]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4bM6Vb1Yybz6B9m7; Tue, 17 Jun
	2025 13:03:03 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250617124058epcas5p2324bd3b1bf95d47f553d90fdc727e50d~J1PAt0_H20930409304epcas5p2L;
	Tue, 17 Jun 2025 12:40:58 +0000 (GMT)
Received: from test-PowerEdge-R740xd.samsungds.net (unknown [107.99.41.79])
	by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250617124055epsmtip284e8269183523be2932631c09dcc7d75~J1O_N11oP2488624886epsmtip2a;
	Tue, 17 Jun 2025 12:40:55 +0000 (GMT)
From: Neeraj Kumar <s.neeraj@samsung.com>
To: dan.j.williams@intel.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com
Cc: a.manzanares@samsung.com, nifan.cxl@gmail.com, anisa.su@samsung.com,
	vishak.g@samsung.com, krish.reddy@samsung.com, arun.george@samsung.com,
	alok.rathore@samsung.com, s.neeraj@samsung.com, neeraj.kernel@gmail.com,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev, gost.dev@samsung.com, cpgs@samsung.com
Subject: [RFC PATCH 18/20] cxl/pmem: Add support of cxl lsa 2.1 support in
 cxl pmem
Date: Tue, 17 Jun 2025 18:09:42 +0530
Message-Id: <592959754.121750165383213.JavaMail.epsvc@epcpadp2new>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250617123944.78345-1-s.neeraj@samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250617124058epcas5p2324bd3b1bf95d47f553d90fdc727e50d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20250617124058epcas5p2324bd3b1bf95d47f553d90fdc727e50d
References: <20250617123944.78345-1-s.neeraj@samsung.com>
	<CGME20250617124058epcas5p2324bd3b1bf95d47f553d90fdc727e50d@epcas5p2.samsung.com>

Add support of cxl lsa 2.1 using NDD_CXL_LABEL flag. It also creates cxl
region based on region information parsed from LSA.

Signed-off-by: Neeraj Kumar <s.neeraj@samsung.com>
---
 drivers/cxl/pmem.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
index ffcebb8d382f..2733d79b32d5 100644
--- a/drivers/cxl/pmem.c
+++ b/drivers/cxl/pmem.c
@@ -58,6 +58,63 @@ static const struct attribute_group *cxl_dimm_attribute_groups[] = {
 	NULL
 };
 
+static int match_ep_decoder(struct device *dev, void *data)
+{
+	struct cxl_decoder *cxld = to_cxl_decoder(dev);
+
+	if (!cxld->region)
+		return 1;
+	else
+		return 0;
+}
+
+static struct cxl_decoder *cxl_find_free_decoder(struct cxl_port *port)
+{
+	struct device *dev;
+
+	dev = device_find_child(&port->dev, NULL, match_ep_decoder);
+	if (!dev)
+		return NULL;
+
+	return to_cxl_decoder(dev);
+}
+
+static int create_pmem_region(struct nvdimm *nvdimm)
+{
+	struct cxl_nvdimm *cxl_nvd;
+	struct cxl_memdev *cxlmd;
+	struct cxl_nvdimm_bridge *cxl_nvb;
+	struct cxl_pmem_region_params *params;
+	struct cxl_root_decoder *cxlrd;
+	struct cxl_decoder *cxld;
+	struct cxl_region *cxlr;
+
+	if (!nvdimm)
+		return -ENOTTY;
+
+	if (!nvdimm_has_cxl_region(nvdimm))
+		return 0;
+
+	cxl_nvd = nvdimm_provider_data(nvdimm);
+	params = nvdimm_get_cxl_region_param(nvdimm);
+	cxlmd = cxl_nvd->cxlmd;
+	cxl_nvb = cxlmd->cxl_nvb;
+	cxlrd = cxlmd->cxlrd;
+
+	/* FIXME: Limitation: Region creation only when interleave way == 1 */
+	if (params->nlabel == 1) {
+		cxld = cxl_find_free_decoder(cxlmd->endpoint);
+		cxlr = cxl_create_pmem_region(cxlrd, cxld, params,
+				atomic_read(&cxlrd->region_id));
+		if (IS_ERR(cxlr))
+			dev_dbg(&cxlmd->dev, "Region Creation failed\n");
+	} else {
+		dev_dbg(&cxlmd->dev, "Region Creation is not supported with iw > 1\n");
+	}
+
+	return 0;
+}
+
 static int cxl_nvdimm_probe(struct device *dev)
 {
 	struct cxl_nvdimm *cxl_nvd = to_cxl_nvdimm(dev);
@@ -74,6 +131,7 @@ static int cxl_nvdimm_probe(struct device *dev)
 		return rc;
 
 	set_bit(NDD_LABELING, &flags);
+	set_bit(NDD_CXL_LABEL, &flags);
 	set_bit(NDD_REGISTER_SYNC, &flags);
 	set_bit(ND_CMD_GET_CONFIG_SIZE, &cmd_mask);
 	set_bit(ND_CMD_GET_CONFIG_DATA, &cmd_mask);
@@ -86,6 +144,7 @@ static int cxl_nvdimm_probe(struct device *dev)
 		return -ENOMEM;
 
 	dev_set_drvdata(dev, nvdimm);
+	create_pmem_region(nvdimm);
 	return devm_add_action_or_reset(dev, unregister_nvdimm, nvdimm);
 }
 
-- 
2.34.1


