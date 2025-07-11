Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740BF16A94A;
	Fri, 11 Jul 2025 03:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752204303; cv=pass; b=thv9Q62DSXntAok4xp+l39ee2A/mqLTRTLdfrWWn49gPPmghzvt6Ye8irSJ5a7L98sZEIGsrrMT+lsNyh/sirZY444zGmbm1O2Gx6aDlVgIrosM0fahm3bWosOpPWIkHG+en3FXAENEAtrFhSFZV26SLNjFdd6UlIPNzd2dMWg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752204303; c=relaxed/simple;
	bh=h4rBXYmo969vqERqEbaUJw2dv49vs+dDR8e+KSMbqJw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lQsXh3AhZBd9B2Lxd7WDgprytWPy9GbH++FzTjF85FCkMH5yqB5gFw8NPGBS0E9H216UFJTJdxpehVgBQN2jXtF8Y/IXCGuHwCuTh7xvrmu5xXroPqdfk0/OFolP+HRqjZpXvrINCbpsAQC3VfZ/gPElnEgQFr+ZlcW2YLaB8Q8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=YJ2LNAP4; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="YJ2LNAP4"
ARC-Seal: i=1; a=rsa-sha256; t=1752204278; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lYLmUW0x+eUQvWfPZrNA1YP90+Ngg31tCpiqM4s7v3IpVKaceZWmg5Kv45f3UcrhDz1x81++9zUSNFqHSacCrWVjJSRtx5UZHJGeXN4Ue6SdlXp6Pi2sY6GidwKF1V4pBwoY1ErEc8bA/UzTjOkAw5cn7ApYWoJrHwyUfW+decU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752204278; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=UAoHT2gMn2UrffI35+MUeHjSjGXq5qMVbjzZAFREdxA=; 
	b=dR6vmmopSVqPFTte1BY5lP83OcDbtdQiO7zaz48XAeRHEiOxi8tM7eOjB2dhm/AuWOeCwKJtXjwpBp65R1EXMPKOQ8nucIWFll12B1h2I3kfuYga6Do8/oz3C31WEopx3Jj7GGzJR3ReGTkf/JwHAz1chQCjKlPH6wS8DDTXZkU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752204278;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=UAoHT2gMn2UrffI35+MUeHjSjGXq5qMVbjzZAFREdxA=;
	b=YJ2LNAP4MSdamqLXHOwd+wk5Rx1vI2YP0nFWipYDVwRzLVs4YWJ4KrscTeNG0ddU
	YOOmt7vR61zA5HAMtY+f8r6/CPdaerfzFLcUh2sxawSRzEhwsOgdO9sL7BnvHbU4bAS
	gs1wSb9I5KZ3m85rMsp3VkbpauGWJ19yUPic4pgw=
Received: by mx.zohomail.com with SMTPS id 1752204276910321.52490643263366;
	Thu, 10 Jul 2025 20:24:36 -0700 (PDT)
From: Li Ming <ming.li@zohomail.com>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	shiju.jose@huawei.com
Cc: andriy.shevchenko@linux.intel.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Ming <ming.li@zohomail.com>
Subject: [PATCH v6 1/3] cxl/core: Introduce a new helper cxl_resource_contains_addr()
Date: Fri, 11 Jul 2025 11:23:55 +0800
Message-Id: <20250711032357.127355-2-ming.li@zohomail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250711032357.127355-1-ming.li@zohomail.com>
References: <20250711032357.127355-1-ming.li@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr0801122743476ab0c8ea8bf29f20f74000008edbe939494b03928a2cfe2f594c7bbfa79cafe2310570eec7:zu0801122765d39e7f90411d0555815a82000081c5367dbbe1d3db16e642e10a3b442104d9136cef8c845dec:rf0801122d25c6927f3494e552d2fcb3a900000cf5b8918652694fb0f77ffc23e2891cd0c5d795c3d25c253efeadc3754858:ZohoMail
X-ZohoMailClient: External

In CXL subsystem, many functions need to check an address availability
by checking if the resource range contains the address. Providing a new
helper function cxl_resource_contains_addr() to check if the resource
range contains the input address.

Suggested-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Li Ming <ming.li@zohomail.com>
Tested-by: Shiju Jose <shiju.jose@huawei.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/core.h | 1 +
 drivers/cxl/core/hdm.c  | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 29b61828a847..6b78b10da3e1 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -80,6 +80,7 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size);
 int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
 resource_size_t cxl_dpa_size(struct cxl_endpoint_decoder *cxled);
 resource_size_t cxl_dpa_resource_start(struct cxl_endpoint_decoder *cxled);
+bool cxl_resource_contains_addr(const struct resource *res, const resource_size_t addr);
 
 enum cxl_rcrb {
 	CXL_RCRB_DOWNSTREAM,
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index ab1007495f6b..088caa6b6f74 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -547,6 +547,13 @@ resource_size_t cxl_dpa_resource_start(struct cxl_endpoint_decoder *cxled)
 	return base;
 }
 
+bool cxl_resource_contains_addr(const struct resource *res, const resource_size_t addr)
+{
+	struct resource _addr = DEFINE_RES_MEM(addr, 1);
+
+	return resource_contains(res, &_addr);
+}
+
 int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_port *port = cxled_to_port(cxled);
-- 
2.34.1

