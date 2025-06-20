Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3E778F39;
	Fri, 20 Jun 2025 05:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750397398; cv=pass; b=qdUpYxG/WLMQHg7L3buIUTXdjpGm4lfLwCl65+lk3xAyoIFDa95IO0K018BnrL+3TuL2Z9Wm8j30Rib4ISFmO4wS+z7YVxDQ4QXvtEBMH68Go+166eQZFb+RYv3TLdNdK+kCdUfjA5OH3FnqnRc2yBA8uN1y9JTE8coHmhwgS6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750397398; c=relaxed/simple;
	bh=KLTwekWnOIGEwf5a6ZTZCxAx2BXsXPUzPeMu4ceMhuo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s06iS5nJ9Zlkd6V8tfl+ja5N4BeIh1HVH4A3Wry85CjEUmK4Zhv2Ntddgd7p2SU13dzwog2NPgUIEhdoym3tkqlYZ4grq8SJL6TgtqrmCCgU35ghTduXfSYmuhFeJFklERXsSyvo6ErBw/2GFyWVjFygvfj0R1hSFVpzWDX36BQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=eEQZY7Q7; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="eEQZY7Q7"
ARC-Seal: i=1; a=rsa-sha256; t=1750397376; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TQd3JhPbWX6Zj9oOK1b+4YrHsAeMiAD9Aj4L/DgVIkxom/FGVT2vYy6OdxEVNboRW2qqmoz/nEgDivR4LuyAJB47E3Nsvy7DCv+B306VRCEIGCRlWFrsT9+qpKPbxg+7Hc+GcDgMV+Yq2Mg2F9lHN8gl/cxB3iSGoTieM0+4dkE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1750397376; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=qHKGusWoiF5FpA2uC1/f3a/JKaJs0uOL3w3lBc2uXGk=; 
	b=ZfXAugwP/Glj005SP9pajcifQGA3xrveJ13P0nOt+pgqw4hFtjcbzcOMQtpW3soaVYzLddrpAHJRsLx47WnhYmYa2tJ3qJlKxZtYZp444ftyp49saWlHZK5O+6WZOgJAzV6x52jh0GWT6GkOkqsGkndlxWdjpve60dO3y0dR8vU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1750397376;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=qHKGusWoiF5FpA2uC1/f3a/JKaJs0uOL3w3lBc2uXGk=;
	b=eEQZY7Q7eLV3z7Q6Ep4REsu2TQ5M+z/QIzvfpBZ4ZidFt25YkP9yUPKaHk1UpJ0o
	rzvo+7hep/U+MjgcRRjYbht8XMiabN2xQ/ZbrPAQBFDtBJxojZxCmteOUcCP3lV/u/0
	JmYKMqK02WMywTKT8medokU2JOZfOyKsosWL3Hf0=
Received: by mx.zohomail.com with SMTPS id 1750397374690501.77460902845905;
	Thu, 19 Jun 2025 22:29:34 -0700 (PDT)
From: Li Ming <ming.li@zohomail.com>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	shiju.jose@huawei.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Ming <ming.li@zohomail.com>
Subject: [PATCH 1/1] cxl/edac: Fix using wrong repair type to check dram event record
Date: Fri, 20 Jun 2025 13:29:24 +0800
Message-Id: <20250620052924.138892-1-ming.li@zohomail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011227e91d332aa4327cec4390cd8c000070e5c6e3aaaf2626bd44fd99da857da8c2cce1fae56102dfa1:zu08011227b4c49e91e48aad6e698398d90000ce84e86fa77c950d222468a501679f95896125cc8706d71a78:rf0801122dad43ba7108c01f6139ddb1d30000fd05ee002c0a4218da4faef59692162b9daa6ab47612c72597284f8f88d85b:ZohoMail
X-ZohoMailClient: External

cxl_find_rec_dram() is used to find a DRAM event record based on the
inputted attributes. Different repair_type of the inputted attributes
will check the DRAM event record in different ways.
When EDAC driver is performing a memory rank sparing, it should use
CXL_RANK_SPARING rather than CXL_BANK_SPARING as repair_type for DRAM
event record checking.

Fixes: 588ca944c277 ("cxl/edac: Add CXL memory device memory sparing control feature")
Signed-off-by: Li Ming <ming.li@zohomail.com>
---
base-commit: 3c70ec71abdaf4e4fa48cd8fdfbbd864d78235a8 cxl/fixes
---
 drivers/cxl/core/edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
index d725ee954199..623aaa4439c4 100644
--- a/drivers/cxl/core/edac.c
+++ b/drivers/cxl/core/edac.c
@@ -1323,7 +1323,7 @@ cxl_mem_get_rec_dram(struct cxl_memdev *cxlmd,
 		attrbs.bank = ctx->bank;
 	break;
 	case EDAC_REPAIR_RANK_SPARING:
-		attrbs.repair_type = CXL_BANK_SPARING;
+		attrbs.repair_type = CXL_RANK_SPARING;
 		break;
 	default:
 		return NULL;
-- 
2.34.1

