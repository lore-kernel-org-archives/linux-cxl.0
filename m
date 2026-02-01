Received: from sender4-pp-o90.zoho.com (sender4-pp-o90.zoho.com [136.143.188.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF13F42A96;
	Sun,  1 Feb 2026 09:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769938275; cv=pass; b=n+Ge5XBmW7/Aq0eOMdIf/z4aEsYIQVvo+9WbeW5HdolF7IqXSJY773ZM7C6QJw/k1UFashCL3JTwYz0K+UqoEUpD1HatuSodscZBIuq2QJP3D3qJgqCG/VRoboxoorv8haY5UFymKFeAEGQ4PIy8gP/ZrkL1SZStOhSXYQBnIQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769938275; c=relaxed/simple;
	bh=hsKZ9DzJafLyDdRycM2Ee6tppkb6X9Sas8yeTi5vc74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RlPQpbW3PWgsGfh3QYPIfD+mdBlg0jsxceHJfOhDmCJQDTPKtOpTOVNyntwKYhzneEHE5LF2HImXN9fSSWcS2BYubNH+VwS/Ag9qhKuqQYblta61LI/mEef8m9rng+nUaXYruTpRJ3Tz+hI1OD2SIo4pmoGJXbiudVZMQskM6q8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=Jkp5uhae; arc=pass smtp.client-ip=136.143.188.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="Jkp5uhae"
ARC-Seal: i=1; a=rsa-sha256; t=1769938261; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lunWI9eMu7IOTsWRUIbxA4qnKtLadokPrvzx8xXEMrAeJzXnszLvJbczyPHlV2lDcRItrW86306+hGtQm5ucuzbbQdScGcI9QaAGrD/hVayY6EsKuC1sxd/LafmuHxseNZA8/X8dAJL1i/ZQQ7yCLAeGFmLrWKKmFYeMK49M0KU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1769938261; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=hibxExN37Y2J4xiEbPjvTudzX+CS65krB5RcbciB+5E=; 
	b=Vgz1QY8Y5OAz6r5PgfeZj3BSshtHo7fXvmYZIuexbIm1zKpSQRld9EWqlX8g4y7lQZZsghDuqi0ct3U9wvHtRuG0OfkV5wB31TU5jox3YkEiV7F7kb3/izrdqFjbTWQi7aAouSBekWhhr83c1EseW1vJk59CoVGTIBxPxe0LCNI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769938261;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=hibxExN37Y2J4xiEbPjvTudzX+CS65krB5RcbciB+5E=;
	b=Jkp5uhaeIVXqTeMRgIGH49U8G0Bexr89hAcQftQd3oak3n4+gvAGBZmwooToGVKW
	hejQsmA0rQ2gGTEIkGQFSlC51NdYjFR84DclY1aydhgYillnJMgnU2eo4A3oszF8mCH
	k0h18rLWMw5NuoQ/5NA2eO0yDlO7vOKcI9+f38+0=
Received: by mx.zohomail.com with SMTPS id 1769938259821602.5139285541802;
	Sun, 1 Feb 2026 01:30:59 -0800 (PST)
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
Subject: [PATCH 1/2] cxl/core: Set cxlmd->endpoint to NULL by default
Date: Sun,  1 Feb 2026 17:30:01 +0800
Message-ID: <20260201093002.1281858-2-ming.li@zohomail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260201093002.1281858-1-ming.li@zohomail.com>
References: <20260201093002.1281858-1-ming.li@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr0801122c411b09ef1fb4ee7f94413acf0000697a04a5620573b12ff06473ac3f0749b459dabb256658c55281bd1da3d1:zu080112278b7c9ab791961eb52563e3df000009965e6129cfe0e78302f79844d85cd3d086d36e310bb6d965:rf0801123270ba928561fc2df255162c670000405606c646f0593a246365c2696a558240fd345629d0887fc304483a33240de7e222a9ea:ZohoMail

CXL testing environment can trigger following trace

 Oops: general protection fault, probably for non-canonical address 0xdffffc0000000092: 0000 [#1] SMP KASAN NOPTI
 KASAN: null-ptr-deref in range [0x0000000000000490-0x0000000000000497]
 RIP: 0010:cxl_dpa_to_region+0x105/0x1f0 [cxl_core]
 Call Trace:
  <TASK>
  cxl_event_trace_record+0xd1/0xa70 [cxl_core]
  __cxl_event_trace_record+0x12f/0x1e0 [cxl_core]
  cxl_mem_get_records_log+0x261/0x500 [cxl_core]
  cxl_mem_get_event_records+0x7c/0xc0 [cxl_core]
  cxl_mock_mem_probe+0xd38/0x1c60 [cxl_mock_mem]
  platform_probe+0x9d/0x130
  really_probe+0x1c8/0x960
  __driver_probe_device+0x187/0x3e0
  driver_probe_device+0x45/0x120
  __device_attach_driver+0x15d/0x280

commit 29317f8dc6ed ("cxl/mem: Introduce cxl_memdev_attach for CXL-dependent operation")
initializes cxlmd->endpoint to ERR_PTR(-ENXIO) in cxl_memdev_alloc().
However, cxl_dpa_to_region() treats a non-NULL cxlmd->endpoint as a
valid endpoint.

Across the CXL core, endpoint availability is generally determined by
checking whether it is NULL. Align with this convention by initializing
cxlmd->endpoint to NULL by default.

Fixes: 29317f8dc6ed ("cxl/mem: Introduce cxl_memdev_attach for CXL-dependent operation")
Signed-off-by: Li Ming <ming.li@zohomail.com>
---
 drivers/cxl/core/memdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index af3d0cc65138..41a507b5daa4 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -675,7 +675,7 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
 	cxlmd->id = rc;
 	cxlmd->depth = -1;
 	cxlmd->attach = attach;
-	cxlmd->endpoint = ERR_PTR(-ENXIO);
+	cxlmd->endpoint = NULL;
 
 	dev = &cxlmd->dev;
 	device_initialize(dev);
-- 
2.43.0

