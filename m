Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13726222596;
	Mon, 17 Feb 2025 14:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739803778; cv=pass; b=ARoT0Hg2Aoygc8lAh61ig7Y85NsI2O4uS/BQ/jpI8cXvQ5LAdZofaM5k7ZlB3yLgv41cNE28bmRT2tigpBIWShjqW8SHn2QInz+TknKZ2mXYCDHxD7kLSaHnbezvVv9xikRlj8nbY5sNwhCs9yagsWzY01hHKmUR479nyaELWss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739803778; c=relaxed/simple;
	bh=at+D77xhBCQv3TXVg3YLeQXMmx8vzJzFzSGSD7CTzIE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fQ+I3Dn/sBGMGj+ksZXHcNq07AKAdv8omx5Kwzwl/eWqNJh3vintpBeTMWy0wzqueRjcf7oHWT69iWgDAD4b/F6LTpwa4TV6M4uKMZAevjWN1H2y6x6x5Yo8QTS9UreNuZyka17hymgjk91WWGxqagAWUrA7vNCvDiEotZ+/PeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=bNdp1imx; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="bNdp1imx"
ARC-Seal: i=1; a=rsa-sha256; t=1739803757; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=V5BDFT1m32CLMmL2uq1SctHV+ctx1pz2nANZZHfn51LJRBbDZ2hS2Mzk6zuORwHSGzRK5FjfqQBy4nb0NbkImk7ey1M81WU9Ypyzl6KmJWCJE5blyuDjhuNc0tCdBZJWhdokS+KCjR4NyEXRB5AkPdPNvEbUsiGHiVR044dmqd0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739803757; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=vZ4AbqtxvA/XdTRpEb45TpkQeirAJecUksAnhpHB9mU=; 
	b=apiD/FBNNZcXgNr4ig2iF2Ap66d7NMDcWhis/DTr/ZRGnwzIBJhd3nDLCnZGU4mAYov/EMnZq6pugTuxm1gECIEWfGhVMZevByQ1ox6G1Xq/aBE3vdnvylqksBozxe8TvtQL3a87x+J2vYjanBBtayfBA99WUHJZqw7nItjNiYY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739803757;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=vZ4AbqtxvA/XdTRpEb45TpkQeirAJecUksAnhpHB9mU=;
	b=bNdp1imxWypUPvISKAjv47gOIXN2DA7avYWQ6P1ABGAetlmQpf7ttz7AD9YTch/7
	fFD15H+DaBnH9V+bFSg7hggAfMT7HT4HeWSPL0rPG7TDcLneYOd24vKYGi4e7evUrPK
	9QjcP3fpY80ZEYjYiXGNXjqMW/6fbb1kVMWMmFuo=
Received: by mx.zohomail.com with SMTPS id 1739803754315852.1927748164743;
	Mon, 17 Feb 2025 06:49:14 -0800 (PST)
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
	Li Ming <ming.li@zohomail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 3/7] cxl/memdev: cxl_memdev_ioctl() cleanup
Date: Mon, 17 Feb 2025 22:48:24 +0800
Message-Id: <20250217144828.30651-4-ming.li@zohomail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250217144828.30651-1-ming.li@zohomail.com>
References: <20250217144828.30651-1-ming.li@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011227957a81ebafd8ad2a52fb16fd00005d60d321eec5b6b4b9de04752d26e218e0e90f7e314d9a022e:zu08011227f8fed950e5bf5fe4bba566e700002b786b09415c7703ff58fedac56f79fdd79bfa2d332be5a5b8:rf0801122d215f26e1822a2759fb9c516800003e0f8b3723fc842170562d19aea6a0c8c35fccf454f63726b48dd5a8c568d6:ZohoMail
X-ZohoMailClient: External

In cxl_memdev_ioctl(), the down_read(&cxl_memdev_rwsem) and
up_read(&cxl_memdev_rwsem) can be replaced by a
guard(rwsem_read)(&cxl_memdev_rwsem), it helps to remove the open-coded
up_read(&cxl_memdev_rwsem). Besides, the local var 'rc' can be also
removed to make the code more cleaner.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Li Ming <ming.li@zohomail.com>
---
 drivers/cxl/core/memdev.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 98c05426aa4a..6f90dcd626f9 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -668,15 +668,13 @@ static long cxl_memdev_ioctl(struct file *file, unsigned int cmd,
 {
 	struct cxl_memdev *cxlmd = file->private_data;
 	struct cxl_dev_state *cxlds;
-	int rc = -ENXIO;
 
-	down_read(&cxl_memdev_rwsem);
+	guard(rwsem_read)(&cxl_memdev_rwsem);
 	cxlds = cxlmd->cxlds;
 	if (cxlds && cxlds->type == CXL_DEVTYPE_CLASSMEM)
-		rc = __cxl_memdev_ioctl(cxlmd, cmd, arg);
-	up_read(&cxl_memdev_rwsem);
+		return __cxl_memdev_ioctl(cxlmd, cmd, arg);
 
-	return rc;
+	return -ENXIO;
 }
 
 static int cxl_memdev_open(struct inode *inode, struct file *file)
-- 
2.34.1

