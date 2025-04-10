Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1D81E9B12;
	Thu, 10 Apr 2025 02:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744253150; cv=pass; b=ikF9rTv2svop+MsO12ehk2HBLc6Dyu35C3lFSUZUZqNG7SbOwxp/qtT40Fm0194cCbUa0rdAfvpDGI9V86EX0IHORBC3y6uz3Yd+yLaqZRDD7QkUEjf1bV33/LrO8atB024Ue0bqTzP6/aYO2oBlB5KB6OELqPcFsdU8TvacqwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744253150; c=relaxed/simple;
	bh=59zn4Z/QXSsn/dYi20BvJ7x27wAjnpmuU3q4TnCEGng=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m5F34N/+lItwoFU2mWvTdO06l45S1iVmCUxWc+RDwEPdIa4GrlPDS3cKTI8vb20pJ4/uxYNgF/CWNQLOgwRVSCjBjH4xeYdsG8j4DcTzviG/UGVqu2QOnjZXfCwp3GP679TPVRBi+sWnkcIJbQxnxVC3GnlrsSeCV8FA1pkzmLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=MwiHJKyH; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="MwiHJKyH"
ARC-Seal: i=1; a=rsa-sha256; t=1744253134; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=f7rDPeX4Wg2pvS+wb/OMD7ysgOaabppR1eMZq9QFROaoof25dL1uctZR6ZyKekuIdo/zlcvUQxtGsxdBEUFIG7gxmcsM52rrTqc0w9DUqWT1K6tcAi4MiZGy08/poDZ5SrlqsSuQdOMq/jBMnbdFjRl41quy2gJWtsf7Jm0mcXA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1744253134; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=PvYx+06KT98XpC+VIeWlEcOZ4YTHAdkft+Uf6Lb4JAA=; 
	b=g/VNhVLXoDXUcnq0Ia8rZGn6UvmhyX5NJU1u7V+vv36DIu6poiBp1IcGJWjozZZoqgAHA6MH/NYEWOWeZ2oUMhsI+seeXN6BamJtoVOvxPbA+iL+AzqLEvlvs+rExToWyQFzLpB+LsrIDKmeSxCjhZXye9yMHWPbgQsEIflgmlU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1744253134;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=PvYx+06KT98XpC+VIeWlEcOZ4YTHAdkft+Uf6Lb4JAA=;
	b=MwiHJKyHFiAbJk6ByaUI+GEUlnkcPqrQzT6CHsJDvjSEDW1ahL39pl3xuVtYJrP5
	puImXh7BVj4Vf1SETHd+sHRvE9iKHJ5d1M+PGVuWkoc7zcWkBWJnKFmYeDpyIezHnwa
	qVCfw2uESFgxnpyfSFCFEEHUWcDkMICHuq6D+aog=
Received: by mx.zohomail.com with SMTPS id 1744253131792555.9205806172549;
	Wed, 9 Apr 2025 19:45:31 -0700 (PDT)
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
Subject: [PATCH v3 1/1] cxl/feature: Update out_len in set feature failure case
Date: Thu, 10 Apr 2025 10:45:21 +0800
Message-Id: <20250410024521.514095-1-ming.li@zohomail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr0801122785b0d5d72241a49bb2e2d90b0000283464bf916e889d80afd5b572eec254ed94be97dfd563d589:zu08011227a06a218e70415aed63e64db600007cd3f6c80826e03cfb7d1f700209bfb414b9abcd1837877724:rf0801122ddab797f8fb3e2743c6c270b700003ff0b1a4516e6d008df40bc07a72612bf283d2bdcc730a1a3a591fe714cdd9:ZohoMail
X-ZohoMailClient: External

CXL subsystem supports userspace to configure features via fwctl
interface, it will configure features by using Set Feature command.
Whatever Set Feature succeeds or fails, CXL driver always needs to
return a structure fwctl_rpc_cxl_out to caller, and returned size is
updated in a out_len parameter. The out_len should be updated not only
when the set feature succeeds, but also when the set feature fails.

Fixes: eb5dfcb9e36d ("cxl: Add support to handle user feature commands for set feature")
Signed-off-by: Li Ming <ming.li@zohomail.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
---
base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8 v6.15-rc1

v3:
- Add fixes tag
v2:
- Adjust changelog
---
 drivers/cxl/core/features.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
index fcc624cefe89..63f24f032209 100644
--- a/drivers/cxl/core/features.c
+++ b/drivers/cxl/core/features.c
@@ -540,13 +540,13 @@ static void *cxlctl_set_feature(struct cxl_features_state *cxlfs,
 	rc = cxl_set_feature(cxl_mbox, &feat_in->uuid,
 			     feat_in->version, feat_in->feat_data,
 			     data_size, flags, offset, &return_code);
+	*out_len = sizeof(*rpc_out);
 	if (rc) {
 		rpc_out->retval = return_code;
 		return no_free_ptr(rpc_out);
 	}
 
 	rpc_out->retval = CXL_MBOX_CMD_RC_SUCCESS;
-	*out_len = sizeof(*rpc_out);
 
 	return no_free_ptr(rpc_out);
 }
-- 
2.34.1

