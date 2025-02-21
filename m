Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C29838F80;
	Fri, 21 Feb 2025 01:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740101168; cv=pass; b=Cg6qiUhBvjkjhJ3gsqQ+VwH3C2RJrZAJ1k13pnefKsiWLSz+67qVjJ+dDd0VNqISd/68MzTssCZ1HFuP61cw9+04NkQJi/1IDL9tIqZsHWaMAjTNBCrZW+x2MWQYNNfzJIzv70nvIVvYEg9khu8cHcTqod23AtFDk4rkj0Msquo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740101168; c=relaxed/simple;
	bh=pmKOIFUtzZMobmZ2DbYaqsRYTwJ8Dwu4xWqnrrZurA0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HjCRG1TshvI9U4KwEKTb3s84ygUxSV/GyJMVpFTnLojbC+26W7zebPhqiZQpXyPpyGZeXYnDW7h4WOPzewXztvfkXlIX8G9+fylu/Fm4ljgocHcrmZNuXl3I5pKR/8WlBNWCfvW+7hI0Z9OqvV+2F3C93C6G6xkQyNQAXsO+aMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=AJmBbMIS; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="AJmBbMIS"
ARC-Seal: i=1; a=rsa-sha256; t=1740101140; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=fhOFPIkrZCZva7+tzpl3rtwcvI6Sr0fvtcqOWJiReKD71MlYpvCqJBF/xZ+quvdDy01+aUWEcgcvHSf3fXrgLnwgAdoQgSfh5THliscCvYOI6vSxFFh/NgqOnBdm0BEMTWM59sZMi7zdBXixO/x4zoqw0thtM6F2D30Nc6z7u+k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740101140; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=KeEb8LPi+h2iOJ944U3++xva3wZkhcHbCDop6unqk5I=; 
	b=IqN8OvXgFJ0LY+yiMJXlq6VsuaKmqcGDqSrCKWytL5cqZtt1fPVmVaLKN56+tFdvjYyNThBiQCt1pyhqsHomhaohORVUQiyOtt7W4VABS9wG8pv82sWn86rkDFK0OclwIuHCBOx5hAv75CGazu+c9PGsw5UUC5dSsCjignOqs28=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740101140;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=KeEb8LPi+h2iOJ944U3++xva3wZkhcHbCDop6unqk5I=;
	b=AJmBbMISUwHmokZKaea0ZOUcloPh64mb27AmRLHGx8DJy8GP32X2oFd16DcLD2TV
	32yhYlVyXBY9+YU/KR0EloO7vflpI8un4uSs0hQkGxzFsRzAHJK9fJfg4S+5IBJOMSm
	tqSIRa84W9ea80QBrdjB4bcAu5FEr0j9aYKlD+bs=
Received: by mx.zohomail.com with SMTPS id 1740101137120159.54618824138697;
	Thu, 20 Feb 2025 17:25:37 -0800 (PST)
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
Subject: [PATCH v3 3/7] cxl/memdev: cxl_memdev_ioctl() cleanup
Date: Fri, 21 Feb 2025 09:24:49 +0800
Message-Id: <20250221012453.126366-4-ming.li@zohomail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221012453.126366-1-ming.li@zohomail.com>
References: <20250221012453.126366-1-ming.li@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011227807f201c8c1e5978b245b5a50000610b8e0fc892d0b4119a7d5eb040ee78534b5188127ff3b710:zu0801122706c68c02ed125a0eb674a3bd0000c9eaef536c222177f3f5691b234036cd0b49988eeb57265053:rf0801122d2f55e2afedd4ddea1fd8f4fa0000761cd27a4dce20243fdf083ecdc82030059fbe6e686898e90ee5dc4dfdcace:ZohoMail
X-ZohoMailClient: External

In cxl_memdev_ioctl(), the down_read(&cxl_memdev_rwsem) and
up_read(&cxl_memdev_rwsem) can be replaced by a
guard(rwsem_read)(&cxl_memdev_rwsem), it helps to remove the open-coded
up_read(&cxl_memdev_rwsem). Besides, the local var 'rc' can be also
removed to make the code more cleaner.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Acked-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Li Ming <ming.li@zohomail.com>
---
 drivers/cxl/core/memdev.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index da692020980b..a16a5886d40a 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -691,15 +691,13 @@ static long cxl_memdev_ioctl(struct file *file, unsigned int cmd,
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

