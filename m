Received: from sender4-pp-o90.zoho.com (sender4-pp-o90.zoho.com [136.143.188.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1396822258C;
	Mon, 12 Jan 2026 12:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768219559; cv=pass; b=gCOh8lXK8Z1fBuzslGAiw7rgvdTSWuCi7qjB2FuCsGqpr4zBXsb5RJbgvNh6BWEQyWaram/eS0i2ghuT+/3iqtZnVyTEVOh7ASeD8bb6Ok/tstEpjRoCCAnTMLdfJV/C/xLLPH7F05RTuDOn0vT3obqhcLE3xP0GU+CQngSGp6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768219559; c=relaxed/simple;
	bh=Rda2hWra7xocZ1t+qWnY6VK8yI1mx7FANILr1lmUxtM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P3qz9bqDj2lSmJuJFALaJDuAtEs2kAj2JYyLtexaWRjtpLn4nZ7y+uyDv5DIUltUoBiGpRhIKlk5LnnNQVoCqRdcLBFlWXWXulNCWqpbqTQ4KuFCx2O03yUtl2YcZT6CyyhVHuLEJTu/vdX7eGZxP1538z2S+z8OYDaWS2EbzjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=KhepQBgP; arc=pass smtp.client-ip=136.143.188.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="KhepQBgP"
ARC-Seal: i=1; a=rsa-sha256; t=1768219542; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hSFjoafeiuyRVsOl9IihMpshthHBx+/s5E72LvyqA9UrkyHqJdu65B4w7JFlK7LaItaf8ORUNnTPv+Rh7CdnYEIQDL7sy3PFwjKxAbKv/hkA/3T6G2zBZRLm+Q6+uImY+z80gg5EXgM0cuBe3M1m6sLAir1Iv7qO8k1D3ryzVQE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1768219542; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=JmJr5v9E2ga7rAAofhrmWS5gfpg4Kf4eIIMJ0DbS2qY=; 
	b=a/DIk0PEiWkrURiSblLIAh1Pl9oQRWFS5UKX24IgplRDP5lEzs3Urz9tGXB775jCgFYh16dgXXb/LuEKXzCcHnASi69HimbrYoLhsaPG/HyXXJPuT0SLixXu1eOlk+gbXtPjSqnk+jtDEYia0DEbWK37XPAe/XFeit/zpPC4L1Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1768219542;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=JmJr5v9E2ga7rAAofhrmWS5gfpg4Kf4eIIMJ0DbS2qY=;
	b=KhepQBgP6Zp4dywS8bo90fAG8rE2s58Ijww7Oz9gBA+zskZt1dc+rYgb6PIA1bGF
	PZDywt3L5gV9fnj5POSvF6PZ3Wz1o2Js8TtUykV7wSjM9dZ7F3S1VJZ2T/jv4qi3HeQ
	y+k3bhF7s//WoIDRF+eu1OV+wA0vJYJAn2tiqI7A=
Received: by mx.zohomail.com with SMTPS id 1768219540937352.07051296128816;
	Mon, 12 Jan 2026 04:05:40 -0800 (PST)
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
Subject: [PATCH 1/1] cxl/hdm: Fix potential infinite loop in __cxl_dpa_reserve()
Date: Mon, 12 Jan 2026 20:05:26 +0800
Message-Id: <20260112120526.530232-1-ming.li@zohomail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011227ea1e3f7429c7b1d7c5db5da50000d4d801153e548f05c447a364006a378a416318ace03ddef282:zu0801122771746feb2189ced651e899160000d86358b0ddc21d2b9cdf460a87bbb643e59687fb20899d40a3:rf08011232f8c5845b5406119624f1ec5e0000cde58d8cd1d1536ae677db7327b0cf1615badb9b49ea2acb85febbea31c8808b1ce05778:ZohoMail
X-ZohoMailClient: External

In __cxl_dpa_reserve(), it will check if the new resource range is
included in one of paritions of the cxl memory device.
cxlds->nr_paritions is used to represent how many partitions information
the cxl memory device has. In the loop, if driver cannot find a
partition including the new resource range, it will be an infinite loop.

Fixes: be5cbd084027 ("cxl: Kill enum cxl_decoder_mode")
Signed-off-by: Li Ming <ming.li@zohomail.com>
---
 drivers/cxl/core/hdm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 1c5d2022c87a..a470099a69f1 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -403,7 +403,7 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 	 * is not set.
 	 */
 	if (cxled->part < 0)
-		for (int i = 0; cxlds->nr_partitions; i++)
+		for (int i = 0; i < cxlds->nr_partitions; i++)
 			if (resource_contains(&cxlds->part[i].res, res)) {
 				cxled->part = i;
 				break;
-- 
2.34.1

