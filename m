Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11768632B;
	Tue,  7 Jan 2025 03:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736222292; cv=pass; b=sSADyGNsu7u9H5+HoV+ZRb2RipXhjrWb3/jcQiIJRDEzcwKd/9KvzJpNLTco5BRD0WBNVDuzDDtmrhWFC7q/WT+ud+Ewny11yeBZQs6Lpu6N+l3GR4fdbhxaqsG0bdNIqdPwXGkgz/PAbY6DailzOzuwWzc9FiiNlhgsI5G/3D4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736222292; c=relaxed/simple;
	bh=zqSHsziad0iLZs6QqxuWE6HhpLK0IvOWGwH5UtPLgQ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GV51yp0RQED5wpaIUsTjtgxXNaJopFXjktzXOc6pt6eRqhkGKr3y1cLqIvGFBJJIo4CZ5TnQMt5GsoKk2PCQCYAZhEyows5wdaQXc8NquJeERRpXH/DsD65KLTKTXxNmtCqHtwDne1PUoXbDHFvznoibwMNJInkbQz8PwS2az20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=Bw7hL/7a; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="Bw7hL/7a"
ARC-Seal: i=1; a=rsa-sha256; t=1736222267; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=D/tbmD1/1pPU9jGIBH/5COPQtHH1/iXr+e9MpXpJ7lqYaFVuFGty82RSsD5Rz/nYJS5fASAJFmKffpELPtRIQsWhlx773eeNFq09Q3vFHPJuv3qdGVPQn6JGuWxlxfyhuSmGX62Bxh3j3ltJyGsC8Ph2jnk6PdTHi5ejfFIhsIA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1736222267; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=uSVefGGKaTk1sDvzueyHqzcDxxx1WJNakriqtp4cVcY=; 
	b=SBiODlx+qHS9k5NzkHluW5cnd1FTC7vrWT1hcyP0LPlqqL7kiJVWg9X6P14vbMatJBPmT4uDs623j8N/KvFjDUlsNtGFreZFU17I9NqelmOMX0jhCJOjDGgRNmu6p3KZudr725plCC/PJLIctpTvqUiEl8/Ls6vUCSc8DmX5yug=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1736222267;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=uSVefGGKaTk1sDvzueyHqzcDxxx1WJNakriqtp4cVcY=;
	b=Bw7hL/7aly7BLTjGq0mzEJ7G9ADvwBxfjGU94bZ/a7bvYH5fVqWNOXH/WGYGzPDT
	Bbx+EMYLH+9wLbMWWT4EQk8YdiLEMshtDyoZ0I7uNodW9P5uyUcoJglddYBtB+JSy6w
	rTuYBzmDEBHVE971jDW4yHHj6+6569JAE5oXHJ7Q=
Received: by mx.zohomail.com with SMTPS id 1736222265459480.52893116612825;
	Mon, 6 Jan 2025 19:57:45 -0800 (PST)
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
Subject: [RFC PATCH 3/8] cxl/region: Check if dev is a decoder in check_commit_order()
Date: Tue,  7 Jan 2025 11:57:03 +0800
Message-Id: <20250107035708.1134954-4-ming.li@zohomail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250107035708.1134954-1-ming.li@zohomail.com>
References: <20250107035708.1134954-1-ming.li@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011227af502f1a8495808710c3aa39000015bf6d3ef7ba5e42951c0b9c32923616f4a1c640c9d8b583c2:zu080112270161c2dbca105bd02a72bbf90000eed5e76b7e96e1683d62d3b9ad0fdee4bb017b85b11fdd900c:rf0801122d8316552c81ef98b053220e860000b9b7009b32778fb0271da8f4050fe098a0f38548e1dbbedbc950ccbd57cd7a:ZohoMail
X-ZohoMailClient: External

Currently, endpoint port probing helps to enumerate decoders on its
ancestor ports. it will impact the sequence of port's device child list.

Before that, port's decoders are added to port's device child list
firstly, then all ports under the port will be added to the port's
device child list.
But now, all ports under the port will be added to the port's device
child list firstly, then the port's decoders will be added.

So when using device_for_each_child_reverse_from() to check decoders
commit order, needs to check if the child device is decoder, if not,
that means the first decoder was walked. Returning a positive in such
case to stop iterator.

Signed-off-by: Li Ming <ming.li@zohomail.com>
---
 drivers/cxl/core/region.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index b98b1ccffd1c..946fca0fe0fe 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -780,8 +780,12 @@ static size_t show_targetN(struct cxl_region *cxlr, char *buf, int pos)
 
 static int check_commit_order(struct device *dev, const void *data)
 {
-	struct cxl_decoder *cxld = to_cxl_decoder(dev);
+	struct cxl_decoder *cxld;
 
+	if (!is_switch_decoder(dev))
+		return 1;
+
+	cxld = to_cxl_decoder(dev);
 	/*
 	 * if port->commit_end is not the only free decoder, then out of
 	 * order shutdown has occurred, block further allocations until
@@ -815,7 +819,7 @@ static int match_free_decoder(struct device *dev, void *data)
 
 	rc = device_for_each_child_reverse_from(dev->parent, dev, NULL,
 						check_commit_order);
-	if (rc) {
+	if (rc < 0) {
 		dev_dbg(dev->parent,
 			"unable to allocate %s due to out of order shutdown\n",
 			dev_name(dev));
-- 
2.34.1

