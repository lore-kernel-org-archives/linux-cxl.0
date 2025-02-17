Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD277223328;
	Mon, 17 Feb 2025 14:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739803936; cv=pass; b=aIEv1DqKBFg/8h747xEu/mOq+ezC3WzXREHsTbuUAzWXuYVOZBBw/n9UKewWSe4fShDeN917tNojKFYJDnib+9w/zcc/20I2KBfI2KsGReSvY3HLxDSak0zMAWW1n25LvbyQ4qK0EaUk60ABS/QEpT0s2Eq0aGeVMQCuQyv9ycU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739803936; c=relaxed/simple;
	bh=RiB1oXhMD5rMP5CbSPhagMBU8X4ZPgknYiSKpVbHubI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KsuO1ZCjYWcRIFya3rxRG0aKomd6CCZaDQMUWJw5PEyO14VHylRxVfeJ7+l676IJXxgqVhiIaviVlr+9RjXWZtKQ9YI1kLWZHS1py53b5m/EikAre070Ini/ueZQHD8l0ULJqQDvzBrlpYmarBD9010awnXibJSyW9UNSz7hfI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=drISJy0h; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="drISJy0h"
ARC-Seal: i=1; a=rsa-sha256; t=1739803789; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=OEyDTQFE3PL/rMaep9wLKOvMx09kC1ebYIqwkfEFs5q/PyoohyLk3+W866ie3l2vNyceWc0N5A+86vO0bkUgZX+KP4VO51G6KfDxqr88BSXiTKNKuwyN/FPZAK/38QAMEACBX3xwHhZI96VR7qIxK4KuQJHYgYmKBkyqNBSFYoE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739803789; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=fwSLwPfrZMT8HZvx/0S2Jc6bVi6NXmFLmVbTwY6Loqo=; 
	b=YvJgL18afOj35blO2UZyfTByg+7cyNRntg8ni8b0dSFZFNT/y7lIk/IKbRT3tBQXSMO7iKoiQVRQM3TwTZclW6vTxCi5C7yQ/UhZkRanDARI9yTFVRcCqfASMqiN1Ucpax/etrss0CsA22l6tkYdCMKERqHKPA5l6CqHHDY5Bwk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739803789;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=fwSLwPfrZMT8HZvx/0S2Jc6bVi6NXmFLmVbTwY6Loqo=;
	b=drISJy0hhCXcxT/bnL634+Gju9y3gQzTDTaT5UiJXwPULhlRJh3FeN/QRxuURNG+
	zJ/37drqtVrBCnH6n6LQLyujKkCjhNMGbc0FYcLDts68+LV5EAbFf9pLcCazfvE5zEY
	oQV3FMm9r29gcoChEXkq2I08i0FrtdVujNCRsHJU=
Received: by mx.zohomail.com with SMTPS id 173980378657025.23360537786118;
	Mon, 17 Feb 2025 06:49:46 -0800 (PST)
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
Subject: [PATCH v2 6/7] cxl/region: Drop goto pattern in cxl_dax_region_alloc()
Date: Mon, 17 Feb 2025 22:48:27 +0800
Message-Id: <20250217144828.30651-7-ming.li@zohomail.com>
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
Feedback-ID: rr080112272c5dc6440b0446e6588a766f00001b0dec5e1aa36b1ef08c2fff4b5f878ab81e8eaf7d6b074e9a:zu080112274dfe11115d82755fbbbc9214000048773d70501f33f8ddf947b8ee4fad21aac94e977a758c942a:rf0801122d0813314a8608b029609f6c1f000018e4b981a75ca902e9d6f3e6e096f74db99aaab4175851196d58a21a24b9b5:ZohoMail
X-ZohoMailClient: External

In cxl_dax_region_alloc(), there is a goto pattern to release the rwsem
cxl_region_rwsem when the function returns, the down_read() and up_read
can be replaced by a guard(rwsem_read) then the goto pattern can be
removed.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Li Ming <ming.li@zohomail.com>
---
 drivers/cxl/core/region.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index d8a71f9f9fa5..320a3f218131 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3038,17 +3038,13 @@ static struct cxl_dax_region *cxl_dax_region_alloc(struct cxl_region *cxlr)
 	struct cxl_dax_region *cxlr_dax;
 	struct device *dev;
 
-	down_read(&cxl_region_rwsem);
-	if (p->state != CXL_CONFIG_COMMIT) {
-		cxlr_dax = ERR_PTR(-ENXIO);
-		goto out;
-	}
+	guard(rwsem_read)(&cxl_region_rwsem);
+	if (p->state != CXL_CONFIG_COMMIT)
+		return ERR_PTR(-ENXIO);
 
 	cxlr_dax = kzalloc(sizeof(*cxlr_dax), GFP_KERNEL);
-	if (!cxlr_dax) {
-		cxlr_dax = ERR_PTR(-ENOMEM);
-		goto out;
-	}
+	if (!cxlr_dax)
+		return ERR_PTR(-ENOMEM);
 
 	cxlr_dax->hpa_range.start = p->res->start;
 	cxlr_dax->hpa_range.end = p->res->end;
@@ -3061,8 +3057,6 @@ static struct cxl_dax_region *cxl_dax_region_alloc(struct cxl_region *cxlr)
 	dev->parent = &cxlr->dev;
 	dev->bus = &cxl_bus_type;
 	dev->type = &cxl_dax_region_type;
-out:
-	up_read(&cxl_region_rwsem);
 
 	return cxlr_dax;
 }
-- 
2.34.1

