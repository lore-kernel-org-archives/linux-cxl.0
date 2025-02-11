Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A991D5178;
	Tue, 11 Feb 2025 07:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739260685; cv=pass; b=efjro1dogmpybtTOnePEX3+3owufwvjRQ2YcNPjwPcKpzMUNqkKZ3Ux6uvbgAC1qGhDkiybbFysAov+vETTW4BfggkhCHl9wW0zJAQo1EOwzyH6vIBAyId1XFKfmkk3/tLhSJJ35PpvmTLC60m9zZdFrT6j+hbzTtDEFvn2F1c4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739260685; c=relaxed/simple;
	bh=tsgS7l33eNAKf3JQWvmEtckgKYt+kqK5VU9I983EgEw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yq8Z8Y6IlpYv7DUmnQ4g8SECe8dAfUiZuVl3q0cPm+oTEWk2dRPJrdfbK9yRLALjuW9AzQkjcqUnh5f3J1JQenfXQmHRZfc3L+cBzdzD/Hn5DfmD5thh6CO+WiDSa7wA4NAO8kYTbdwuBGRnGvhrzTlUJnGfyMLTD3XEQQ5tGM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=IAqPF++I; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="IAqPF++I"
ARC-Seal: i=1; a=rsa-sha256; t=1739260671; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=fYwmSB1xa9p7zk6afiOioMUi55rOr86a3BE1uBN9MpkoXraaSAkz61fNzP3ypx6I7GiIUe8U2gZYqCeShOhKljST5+JJwyjYedaZ4EFvZhBWdlVZBoAty0XAuUwXWmgGnlrLMruaekvTMJ8GyTY+I9UJW8//ed4W3lGzNzCoqq4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739260671; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=l7yDY1YrOXyl3zDScnNZ9aSbnu0JkwNPQ8jA0FjYLwg=; 
	b=Wh/sPmP9VTY25pPPhgvtu3rCsSh3LAuFvk0M/CrKXEI786W/KqDkGH/U1l427xWbzcm7p/5YXY7Yi9hzTeYG6kQNnG4UhbAbwxQoouP4TWLRlq85dIqNXjYnTD6dPDWLCfrBF0gJvzgyrh6yBJOnT9FOyicKj8hSSZ2v6zjbfrY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739260671;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=l7yDY1YrOXyl3zDScnNZ9aSbnu0JkwNPQ8jA0FjYLwg=;
	b=IAqPF++IejIVV8rxQeUwHAmf4ZpiVn1OAaZDXf1JtRvio63K70NxcX45iiR88tSr
	diQsGoG3/F8XcFE/9L6uYg+fzMiiee+CHVNABHIqwd7Kvwm2BsgEovSDm3tpT3PZuJh
	xW/v11WqjtAS2tVtuqTXxy2IOIKYrjqE3ckPq9Q4=
Received: by mx.zohomail.com with SMTPS id 173926066854426.558442515489446;
	Mon, 10 Feb 2025 23:57:48 -0800 (PST)
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
Subject: [PATCH v1 1/7] cxl/core: Use guard() to replace open-coded down_read/write()
Date: Tue, 11 Feb 2025 15:57:21 +0800
Message-Id: <20250211075727.351895-2-ming.li@zohomail.com>
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
Feedback-ID: rr08011227e9904aec35828b83d44c7de4000091c765d0458b405acc41a555a6b5de6c358d4e561867ad1f79:zu080112276e7dfa5c5aa43ecf5faf276b000061caf1719aaa9f73aa82aa340a1c0527b4852a2ba39168c1f4:rf0801122dede5117c59a4b6e7d1bfa84d00005f26c7d168f75a419f2819b33f3b8558735a7a68375d9c9740151211eac5e1:ZohoMail
X-ZohoMailClient: External

Some down/up_read() and down/up_write() cases can be replaced by a
guard() simply to drop explicit unlock invoked. It helps to align coding
style with current CXL subsystem's.

Signed-off-by: Li Ming <ming.li@zohomail.com>
---
 drivers/cxl/core/hdm.c    | 9 +++------
 drivers/cxl/core/memdev.c | 9 +++------
 drivers/cxl/core/port.c   | 8 ++------
 drivers/cxl/core/region.c | 3 +--
 4 files changed, 9 insertions(+), 20 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 50e6a45b30ba..2bb2782a72ad 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -213,13 +213,12 @@ void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds)
 {
 	struct resource *p1, *p2;
 
-	down_read(&cxl_dpa_rwsem);
+	guard(rwsem_read)(&cxl_dpa_rwsem);
 	for (p1 = cxlds->dpa_res.child; p1; p1 = p1->sibling) {
 		__cxl_dpa_debug(file, p1, 0);
 		for (p2 = p1->child; p2; p2 = p2->sibling)
 			__cxl_dpa_debug(file, p2, 1);
 	}
-	up_read(&cxl_dpa_rwsem);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_dpa_debug, "CXL");
 
@@ -250,9 +249,8 @@ static void __cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
 
 static void cxl_dpa_release(void *cxled)
 {
-	down_write(&cxl_dpa_rwsem);
+	guard(rwsem_write)(&cxl_dpa_rwsem);
 	__cxl_dpa_release(cxled);
-	up_write(&cxl_dpa_rwsem);
 }
 
 /*
@@ -364,10 +362,9 @@ resource_size_t cxl_dpa_size(struct cxl_endpoint_decoder *cxled)
 {
 	resource_size_t size = 0;
 
-	down_read(&cxl_dpa_rwsem);
+	guard(rwsem_read)(&cxl_dpa_rwsem);
 	if (cxled->dpa_res)
 		size = resource_size(cxled->dpa_res);
-	up_read(&cxl_dpa_rwsem);
 
 	return size;
 }
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index ae3dfcbe8938..98c05426aa4a 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -564,10 +564,9 @@ EXPORT_SYMBOL_NS_GPL(is_cxl_memdev, "CXL");
 void set_exclusive_cxl_commands(struct cxl_memdev_state *mds,
 				unsigned long *cmds)
 {
-	down_write(&cxl_memdev_rwsem);
+	guard(rwsem_write)(&cxl_memdev_rwsem);
 	bitmap_or(mds->exclusive_cmds, mds->exclusive_cmds, cmds,
 		  CXL_MEM_COMMAND_ID_MAX);
-	up_write(&cxl_memdev_rwsem);
 }
 EXPORT_SYMBOL_NS_GPL(set_exclusive_cxl_commands, "CXL");
 
@@ -579,10 +578,9 @@ EXPORT_SYMBOL_NS_GPL(set_exclusive_cxl_commands, "CXL");
 void clear_exclusive_cxl_commands(struct cxl_memdev_state *mds,
 				  unsigned long *cmds)
 {
-	down_write(&cxl_memdev_rwsem);
+	guard(rwsem_write)(&cxl_memdev_rwsem);
 	bitmap_andnot(mds->exclusive_cmds, mds->exclusive_cmds, cmds,
 		      CXL_MEM_COMMAND_ID_MAX);
-	up_write(&cxl_memdev_rwsem);
 }
 EXPORT_SYMBOL_NS_GPL(clear_exclusive_cxl_commands, "CXL");
 
@@ -590,9 +588,8 @@ static void cxl_memdev_shutdown(struct device *dev)
 {
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
 
-	down_write(&cxl_memdev_rwsem);
+	guard(rwsem_write)(&cxl_memdev_rwsem);
 	cxlmd->cxlds = NULL;
-	up_write(&cxl_memdev_rwsem);
 }
 
 static void cxl_memdev_unregister(void *_cxlmd)
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 78a5c2c25982..2c59d65bc18b 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -549,13 +549,9 @@ static ssize_t decoders_committed_show(struct device *dev,
 				       struct device_attribute *attr, char *buf)
 {
 	struct cxl_port *port = to_cxl_port(dev);
-	int rc;
-
-	down_read(&cxl_region_rwsem);
-	rc = sysfs_emit(buf, "%d\n", cxl_num_decoders_committed(port));
-	up_read(&cxl_region_rwsem);
 
-	return rc;
+	guard(rwsem_read)(&cxl_region_rwsem);
+	return sysfs_emit(buf, "%d\n", cxl_num_decoders_committed(port));
 }
 
 static DEVICE_ATTR_RO(decoders_committed);
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index e8d11a988fd9..e3bb33109ced 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3216,10 +3216,9 @@ static int match_region_by_range(struct device *dev, const void *data)
 	cxlr = to_cxl_region(dev);
 	p = &cxlr->params;
 
-	down_read(&cxl_region_rwsem);
+	guard(rwsem_read)(&cxl_region_rwsem);
 	if (p->res && p->res->start == r->start && p->res->end == r->end)
 		rc = 1;
-	up_read(&cxl_region_rwsem);
 
 	return rc;
 }
-- 
2.34.1

