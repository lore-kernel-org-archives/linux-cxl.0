Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61EE1A9B34
	for <linux-cxl@vger.kernel.org>; Fri,  7 Mar 2025 22:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741385497; cv=none; b=h2QoxkjISOCc+1IDGXlnptRtiYloksI8xkgvqg9hYUOjOsGJUqjFeUs71NwCrIzGSrX4Q8HDIr4KrxT7Cuo63aqmB5dzuY3cz3phsR/TImB/DkGlx7MEh4jUDxr5NOw1eY8SIWitwlSZ+9m4TVsPjQFAcBPKQ9Sw++rLVA8RbMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741385497; c=relaxed/simple;
	bh=2jYQoN76TG1y+NEYEuIvhhCHvmtmTELTnVO8nuVgVao=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=CNtYUlslov5XSe4Y+UmAhzV2V7Y5ebh6Wj8+anxjHcS4JGp2kSAsB2c4MMUYgjT1nAf/I4LFVXwQC0VTpWdGiKdwEvWj7TsQ1jHN4AK3t/KWycVKXwKQvfv8EwjFTV0//MNnB5nf6RGHEi9cmo71MMwFh/W4qEuYWvl3xWhWW5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WBz2Lfyi; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WBz2Lfyi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741385495; x=1772921495;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2jYQoN76TG1y+NEYEuIvhhCHvmtmTELTnVO8nuVgVao=;
  b=WBz2Lfyibne4K1UmoW0RSAxR2tszMaYaWnwtJreKCvWbzW0ogqGrPI/x
   hCh9jmF+v24GUCbMMVvqqJ7+j4HJzCcjZQtn++cI2r4edEEuSBFByxVEo
   j2T357/WaTKdvHkZOGVNmsYYOnX5Rkh+XZhDOHv4AJU4NrtEP74ibFlCF
   T+Kz4BJUs+rwnP9hygsMgLAZ/O3HhEMqp70TF+68FhbJMcYYxlBl+b1/Y
   wqYdTMG1vn5E4u6JtthLUEPiQ28sKFbPcK9SSAzI4IH3G4pisDFrYikfk
   YhPQcru1yZVSOZw4na+bRp7ou2K+J+PCtzdjG/VoqotbFbRe/oOvznejC
   A==;
X-CSE-ConnectionGUID: 16+zmMFCRd+PPinKPPQtXQ==
X-CSE-MsgGUID: /iaf3MgHT3u2CFuL6yUXdQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11366"; a="42672974"
X-IronPort-AV: E=Sophos;i="6.14,230,1736841600"; 
   d="scan'208";a="42672974"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 14:11:35 -0800
X-CSE-ConnectionGUID: GwC0P8chQhmwF5S91P4Zpg==
X-CSE-MsgGUID: csnwHfLBQqmHGy+vp0KYYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="150390335"
Received: from jdoman-mobl3.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.125.110.176])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 14:11:35 -0800
Subject: [PATCH] cxl/fwctl: Cleanup unused fwctl_dev from cxl_features_state
From: Dan Williams <dan.j.williams@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Dave Jiang <dave.jiang@intel.com>, Li Ming <ming.li@zohomail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Jason Gunthorpe <jgg@nvidia.com>
Date: Fri, 07 Mar 2025 14:11:34 -0800
Message-ID: <174138547078.1626291.2681320775917569071.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

A review of devm_cxl_setup_fwctl() indicates a potential a use after
free condition for the ->fwctl_dev pointer given it is not cleared after
devm_add_action_or_reset() might have released it. However, nothing uses
it, so just delete it.

If it ever comes back it should be returned by devm_cxl_setup_fwctl() so
that users can always assume the pointer is either valid or NULL.

Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Li Ming <ming.li@zohomail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---

base-commit: da0dd17604d4c70080497091c762a790b0871eff

 drivers/cxl/core/features.c |    2 --
 include/cxl/features.h      |    2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
index caf92e9cea21..f4daefe3180e 100644
--- a/drivers/cxl/core/features.c
+++ b/drivers/cxl/core/features.c
@@ -700,8 +700,6 @@ int devm_cxl_setup_fwctl(struct cxl_memdev *cxlmd)
 	if (rc)
 		return rc;
 
-	cxlfs->fwctl_dev = fwctl_dev;
-
 	return devm_add_action_or_reset(&cxlmd->dev, free_memdev_fwctl,
 					no_free_ptr(fwctl_dev));
 }
diff --git a/include/cxl/features.h b/include/cxl/features.h
index ead63573b0b4..fbfdc601bd85 100644
--- a/include/cxl/features.h
+++ b/include/cxl/features.h
@@ -53,7 +53,6 @@ enum cxl_features_capability {
  * @entries: CXl feature entry context
  *	@num_features: total Features supported by the device
  *	@ent: Flex array of Feature detail entries from the device
- * @fwctl_dev: Firmware Control device
  */
 struct cxl_features_state {
 	struct cxl_dev_state *cxlds;
@@ -62,7 +61,6 @@ struct cxl_features_state {
 		int num_user_features;
 		struct cxl_feat_entry ent[] __counted_by(num_features);
 	} *entries;
-	struct fwctl_device *fwctl_dev;
 };
 
 struct cxl_mailbox;

