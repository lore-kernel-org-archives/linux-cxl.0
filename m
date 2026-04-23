Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB93340A76;
	Thu, 23 Apr 2026 11:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776943215; cv=pass; b=h2pbrjGxGo+8saVTVrlvtUz+iMuwJKzpuCLuE+joyfTdaXjq7FBdHqxI8nPCfvLFLJZ6LMjmB3+n2Us/mRt5FyjlcI4MAwipNFuGPSj13ixA7LxER5jvZ+MTKuFVUOHtZpJZ6lnij6vvcfJsOmrkfNvexGHcIVgCspyRHXf6q/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776943215; c=relaxed/simple;
	bh=JD8ZajRo0doGFmA+4bomWfvd7OhXwX/0671cbzQ6aCw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T+dIoKDDWvtYQ3kIlCs7MZhyDrgiRQbAdo4g/YAJ2WebMZiO8Vqc4OOn6bDVI2QaqVaHWa8kBbjU78xgPsAw33r+EVs9jxxdMJRFrk2Pzmdso4x6Y6k7uzBs0P1icG2hz8sOYWgCOYtCtB3lBRyHMO9p54+ftE6JZvAwqjpzu4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=SOJ2nWA9; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="SOJ2nWA9"
ARC-Seal: i=1; a=rsa-sha256; t=1776943198; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=WSCBqMNNSSUjZVpJGXLmgJooUUkgGjMP9W+0tQyNFndM7z5luzn6PLEx05gHOn47Begf7KcDHpDS/5nHZP4niDVNhA5DMjmMbLOZcjJslk5ZMWhR9KA8TuouG0tlsZ8Rm5juOMklRWkIuYMITQ3o7+IvtG3AfuIgMa7WOc8OhgA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1776943198; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=zx1TbB42QIOpTFwR1+0cKlMwUnpFMs7/CM8FmnsfLnc=; 
	b=N19o0ZH3nMyeP782c4nYWZrMbAZXIoFaSgPdPIRsF00XcJyRlFt8qcU+HLjqddaoRp8GyzCDotd37O5hetpPz3yPNk/BjtxhFZ9j6+Q0TCQFXfDfoHZR4RWdUShPBLWCbXH0pKY/tzMZPy4V1KYzIneGPAWKt/oIcvYNORRd+C8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1776943198;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=zx1TbB42QIOpTFwR1+0cKlMwUnpFMs7/CM8FmnsfLnc=;
	b=SOJ2nWA9OyI8G/169GanCCLkgFi9hQjfnQMC0MNhai6pZj9Scmoc39e8Qm4fBjQe
	N1rIfze8uiOIJXWa1MVyBO6HkC641m+DIZm34BIEsXTt5lkj+poM5MX2L5LNm5/cKBJ
	wkSchXsUM/qsIGn8xQZpfSOfyCRhuym8/Vfc4Odc=
Received: by mx.zohomail.com with SMTPS id 1776943195579487.7576515417993;
	Thu, 23 Apr 2026 04:19:55 -0700 (PDT)
From: Li Ming <ming.li@zohomail.com>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	djbw@kernel.org
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ming.li@zohomail.com
Subject: [PATCH v3 1/1] cxl/memdev: Hold memdev lock during memdev poison injection/clear
Date: Thu, 23 Apr 2026 19:19:49 +0800
Message-ID: <20260423111949.177399-1-ming.li@zohomail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: zu08011227c38fcbaf9f449286ecf11dee00008ec274bd76935e0e953d72ebbb7b35dadff003cf15ca235031:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External

cxl_dpa_to_region() assumes that it is running a context where it is not
racing changes to "cxlmd->dev.driver". Acquire the memdev device lock in
the debugfs entry points to preclude debugfs usage racing cxl_mem driver
detach.

Suggested-by: Dan Williams <djbw@kernel.org>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Dan Williams <djbw@kernel.org>
Signed-off-by: Li Ming <ming.li@zohomail.com>
---
This patch originally belonged to the patchset[1], but was not merged
into mainline together with the rest of the patchset. Resend this patch
individually.

[1]: https://lore.kernel.org/linux-cxl/20260314-fix_access_endpoint_without_drv_check-v2-0-4c09edf2e1db@zohomail.com/T/#m9c302a841a3d26aa2eb7217ccdcdc4ae2607740a

Changes in v3:
- Update changelog. (Dan)
- Add review tag from Dan.
Changes in v2:
- Move hoding CXL memdev lock to cxl_debugfs_poison_inject/clear(). (Alison)
---
 drivers/cxl/mem.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index fcffe24dcb42..ab88eaa31d1d 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -48,6 +48,11 @@ static int cxl_mem_dpa_show(struct seq_file *file, void *data)
 static int cxl_debugfs_poison_inject(void *data, u64 dpa)
 {
 	struct cxl_memdev *cxlmd = data;
+	int rc;
+
+	ACQUIRE(device_intr, devlock)(&cxlmd->dev);
+	if ((rc = ACQUIRE_ERR(device_intr, &devlock)))
+		return rc;
 
 	return cxl_inject_poison(cxlmd, dpa);
 }
@@ -58,6 +63,11 @@ DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_inject_fops, NULL,
 static int cxl_debugfs_poison_clear(void *data, u64 dpa)
 {
 	struct cxl_memdev *cxlmd = data;
+	int rc;
+
+	ACQUIRE(device_intr, devlock)(&cxlmd->dev);
+	if ((rc = ACQUIRE_ERR(device_intr, &devlock)))
+		return rc;
 
 	return cxl_clear_poison(cxlmd, dpa);
 }
-- 
2.43.0

