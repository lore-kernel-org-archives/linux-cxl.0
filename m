Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049D41EDA1C;
	Tue, 11 Feb 2025 07:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739260709; cv=pass; b=IclYnv5qBY2s+NcSP+RZguTsHfGLBGahGqFK9U1ZLPSfRsnuRrr9/qNeb9RZf0YprHRKXP6K66U/FgJsmCSCY9BbRWBNDMhvC8AIZ+ttDmnTDhVdtLYmHshbKkHMBYfk0P6ddTX3DEiPytR3MQPKaIq0i6SMq12sqdWUPZ14zDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739260709; c=relaxed/simple;
	bh=paFHILdJMJY9q+grGENdE0DuH6OPrCNJeLRtGxndQ3c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mXYQDe3R6aTC/c8KZzjL0P3rvXR65W4bjR0K/KdJL2ymsaLC29LAH4A0GZpuFDG2ueDXvYFWjgKtpi2RppdJQNuJ1sGdEEfg7EkGfpLowISbpLpr9YqQEXxzmphp6jZ3hjKppI4KZMDXmiPY7JjnL+jucMZgIVdlcUehaH/NVRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=T9NjZFNm; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="T9NjZFNm"
ARC-Seal: i=1; a=rsa-sha256; t=1739260693; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=MnUIDYU3CINOzLSzI0xiz8k9WIKuOZIlq17ZVTJAJfL/QQcFgWDgpsDeNVK5fP0qVJubVMERDXLbJPOvLDo6Ttk8SXnk0n2m+vxm6QhFU4BTM4IrfX04nLmIkmQPWBrM/BdlKVZeFgmJOsZ6+bdaHO9Mfvaosane/eAMZoAvH5Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739260693; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=b8QUtKcULY5BSevs4btZ0h9+H1szEO683cNvyCMY56k=; 
	b=FQVxz3igT+d4G38J4iLNH9Cpm36yO8nitrtTPxTEDIfZzeqSkmWNqtg5NDY8G69XhC27ZiTrdqf4lCUa4WRtGfdMiQzGoquaUoOb2J+C39XRTXBRwbZk8pih+kkCXruOFfx5OAbuXDfgIN8AWJpBWNxJcLMslPiQmPRGT607qlA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739260693;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=b8QUtKcULY5BSevs4btZ0h9+H1szEO683cNvyCMY56k=;
	b=T9NjZFNmOpBS1yXjWidBFH6ikfK1h8cgfo7qQ4qFE3s+btbo6WS9T3ErJO4N6zmD
	aF0jAhpkzP+HxHqGHVRgDykMEngFh4WRTy127Z4IfpGOK9QreAgRS/Wi1TkRLv2LOFo
	EXm5anucH1p6M539PnVl69SjIS287VRqWgm+TVD4=
Received: by mx.zohomail.com with SMTPS id 1739260688941164.39858853682188;
	Mon, 10 Feb 2025 23:58:08 -0800 (PST)
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
Subject: [PATCH v1 3/7] cxl/memdev: cxl_memdev_ioctl() cleanup
Date: Tue, 11 Feb 2025 15:57:23 +0800
Message-Id: <20250211075727.351895-4-ming.li@zohomail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211075727.351895-1-ming.li@zohomail.com>
References: <20250211075727.351895-1-ming.li@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011227a735d99e4fb1a64d7016e5630000eb5531fea2251acb5e148a3b5ce699d36cacf35e3621d9fdba:zu0801122785f10c4a58cdeb253287c4cb0000ec2deb8b3314226c709437142815e8189c424730212f3aec54:rf0801122db36a6c6d0d2e50623137a2a30000baa950606a0939be5d95160d57424071893a90df47d6b4723a096160dbd16b:ZohoMail
X-ZohoMailClient: External

In cxl_memdev_ioctl(), the down_read(&cxl_memdev_rwsem) and
up_read(&cxl_memdev_rwsem) can be replaced by a
guard(rwsem_read)(&cxl_memdev_rwsem), it helps to remove the open-coded
up_read(&cxl_memdev_rwsem). Besides, the local var 'rc' can be also
removed to make the code more cleaner.

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

