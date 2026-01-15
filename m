Received: from sender4-pp-o90.zoho.com (sender4-pp-o90.zoho.com [136.143.188.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0980394485;
	Thu, 15 Jan 2026 13:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768483041; cv=pass; b=EcNShXND4FB1nzc9Fo+GHmusnomC//uQAbTESVh5EJYcF+7Wp/bOCGJvDCph770UGsUsVh2oTQpBT4HYfxCDkhzJkIaA956OSltnDdgkbZ6iERIgi2XxDGTiNoCQBjwGGj6iyW+WQ3awXXu1ObTv1kNsxoDGM7p8z/sifrwNOJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768483041; c=relaxed/simple;
	bh=uo0E8NTPDuIPqMdIbGTQgfSYZXi7cMWWCypWJvO9ptQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=vCIoYOh/TqWOjgzTpFOmBR+80PBYloOQD5mmZw0J2dHsGWq/uBlYAMGQTNoSUyZF45Qz4CwXgjFpdDJa1pvb/bPr3UukYhG2UDTJ/Xe52R3DpwU8q6dH7txLA2sni8ONG1BCIiZxSIJp8aB5vC9axQLSzXXHbeiJkvkaYppcjxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=R4rrHBYm; arc=pass smtp.client-ip=136.143.188.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="R4rrHBYm"
ARC-Seal: i=1; a=rsa-sha256; t=1768483024; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=bSOS7lduxkAXiFGn91PGYGwyHqR2yjXEC1haArzxFae/AcpcHpI5rgh/RYyqt3a6viTGiFx/1BFsaCC0sKVifv5A7hrVOU7JA3i0tH7FzXvkAnCK/76eH2yIRSfk2gulpkCiP6s1FEIQLjCMWdWnJlG3QoULUb70q7B7dLJjYyw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1768483024; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=CJ1WMc3dyzJouq5sMhGv5Z9QnE6jU6+19x4kxM2x4OE=; 
	b=hGA49I3+evQ9vUe4fzkHP1PHASDNn12C8k3qayxOeXI2GEtRxswJhjiPVhptkTK3qrnEOJY7VYvgaUYh7EoHjU5alIMWXZQlT2lRQ1XlP5nqB6+VUvdBSpji8J3wXeUvRKw9AbpjOYkUYdFu3elJmqYmOtAKCrlGoFi171rGPBk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1768483024;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=CJ1WMc3dyzJouq5sMhGv5Z9QnE6jU6+19x4kxM2x4OE=;
	b=R4rrHBYmoUvp6fBLMi0pUj6r1PrrFuJeg7+Ws3y4RaHgufYyMRirkJsGenpoqzpG
	Pf8E8VmSsfxbg6r0R2UB9iE0Fynfv81pSazI+vFmTVyNJY8eC1FeXUATG6AvHbxhMlG
	D+TxBKraD4v1OIC1odLQijFwB5VyURBMpHWEhrHA=
Received: by mx.zohomail.com with SMTPS id 1768483022120102.75584545377808;
	Thu, 15 Jan 2026 05:17:02 -0800 (PST)
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
Subject: [PATCH 1/1] cxl/acpi: Fix using extra xormaps for address translation
Date: Thu, 15 Jan 2026 21:16:48 +0800
Message-Id: <20260115131648.620177-1-ming.li@zohomail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011227a1f9db935305e97c6e019c29000030614be54cbdd5c7a962f6cb315842989a38a6ef12f2f3bcc8:zu08011227b7ef7a68f556d6af9a5d96d90000095368a0ad08830ef3818df6206e24c11b5b883d10c22d2573:rf0801123203b4b1403a52f86e7113690e000030caa7b3ddac5a9bb847a501b581a98147732c3524919235d8c51f5d1876da0fb6200bb3:ZohoMail
X-ZohoMailClient: External

CXL r3.1 Table 9-22 defines a fixed number of XOR maps for interleave
arithmetic based on the number of interleave ways, as reflected by
hbiw_to_nr_maps[].

The current implementation applies all XOR maps during address
translation, but it should use the spec-defined number of XOR maps
derived from the number of interleave ways.

Fixes: 3b2fedcd75e3 ("cxl: Restore XOR'd position bits during address translation")
Signed-off-by: Li Ming <ming.li@zohomail.com>
---
 drivers/cxl/acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 77ac940e3013..5f84d01e7d39 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -61,7 +61,7 @@ u64 cxl_do_xormap_calc(struct cxl_cxims_data *cximsd, u64 addr, int hbiw)
 	 * bits results in val==0, if odd the XOR result is val==1.
 	 */
 
-	for (int i = 0; i < cximsd->nr_maps; i++) {
+	for (int i = 0; i < nr_maps_to_apply; i++) {
 		if (!cximsd->xormaps[i])
 			continue;
 		pos = __ffs(cximsd->xormaps[i]);
-- 
2.34.1

