Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6AB1E633C;
	Tue, 11 Feb 2025 06:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739254898; cv=pass; b=pzqoLrtyAlN1gB2MFP1ufx0V2MMAKHkORzzCtuFSmR/Gpppj8ncaGQh//GrjXulo1K849CfEM8x2c7Q7n/W0jSCTDwg4LCcInR8dwmul375M3eJABJMh0e3osNxTesL6GH3Q/sgrQsbo4fKfyNtkA4FqSThW0UjkETBwnOnwpzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739254898; c=relaxed/simple;
	bh=oBuFtIps8sGZ8zC0dZ6JqBBIIse9hUQ3UjLxYk55sXA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FVH+cj/nBDd/XvrfuNViHUnunOBLfYL5pkpTgoKzc82KscjJ231GDJwoMHFeg2r69AghsyPpTofEl98lGDIbzQs+pQ27r2AjPQEqPRP1TmOCrSxkOUfRrPNTS4BEzJ5MYy2dwxcS08icoHdh1jPzqG4xlyTvzrQLgCGsbWFuRK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=QilXGhL/; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="QilXGhL/"
ARC-Seal: i=1; a=rsa-sha256; t=1739254882; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=JI8TO3n+OTuqgEcvPvChhX+bmAatgs+5BI5ckjAu+nr0NwR865zdGk3TPcAEON6gLiZOPi9IW3qhzO/zeBz7UNhJ0rGMd1c0xwL/RYxk1r9JjnuH1AwoqxjlzXMxe3Rfjq0xgNuCoFRer3JEROPrBXj0V+wgfyRoJpYW8b4j5uc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739254882; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=668bId0JdCiv6vE9UnGCvkp/FNEM+8SepfiZj0GGLPE=; 
	b=O0VRD3yRpTuhqhtdo324WsjMumBf+ox7EavMbc308uFmf71AZGwxW3o2rXUJpSvSdoH4PkEA9v1WE3X1WrvAksF9M/J4u9KI//Vgwg0V0lSkgynIJJc5fFfOOavTdUBnvK8hEpxqANBe0zrQIVq8NiYR9FA8N172/CGr/tqnooE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739254882;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=668bId0JdCiv6vE9UnGCvkp/FNEM+8SepfiZj0GGLPE=;
	b=QilXGhL/+vjFNtsEgp95ZJW195iGFMD/mEhdAguU1zir00iL8UdtEOyvj8YSx5Ef
	2g64S0D2/+uX48xvHnNmZGX5oFt5W9Rh0WBh3y3SM3lQMI1Y91RO/TfUWXBTwa5bMa3
	w5kuew4vErlJ1PeoWh1BjgQHf2Et7E+jzmF2FfSI=
Received: by mx.zohomail.com with SMTPS id 1739254879233457.3033271412928;
	Mon, 10 Feb 2025 22:21:19 -0800 (PST)
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
Subject: [PATCH v1 1/1] cxl/cdat: Remove redundant gp_port initialization
Date: Tue, 11 Feb 2025 14:20:54 +0800
Message-Id: <20250211062054.300108-1-ming.li@zohomail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr080112272a0c232586dd370b9453f8600000cf59533ff5396389351935a23a99df020016d826b54e2ba33e:zu08011227c46a6d4aaeb4d1cc51fbb92400008bdc00d4386bbc417c287fc20cc1b0fa229c2087fc7ea49f60:rf0801122dab5026cbd4ca03a6d9df3a1d0000e02e263f3af988ca56396fbe18bc6b539da4948a0ac6b3c484b7cd0c64e146:ZohoMail
X-ZohoMailClient: External

gp_port is already pointed to the grandparent port during its definition,
remove a redundant code to let gp_port point to the grandparent port
again.

Signed-off-by: Li Ming <ming.li@zohomail.com>
---
 drivers/cxl/core/cdat.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index 8153f8d83a16..c656c1346aa0 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -651,7 +651,6 @@ static int cxl_endpoint_gather_bandwidth(struct cxl_region *cxlr,
 	if (IS_ERR(perf))
 		return PTR_ERR(perf);
 
-	gp_port = to_cxl_port(parent_port->dev.parent);
 	*gp_is_root = is_cxl_root(gp_port);
 
 	/*
-- 
2.34.1

