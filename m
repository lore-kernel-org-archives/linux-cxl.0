Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2AA1CB51B;
	Tue, 11 Feb 2025 07:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739260676; cv=pass; b=dVuxSw/T5rnR5HuCqpqK2f8iEXlfAEY32gefTo10eEGrNAFqxd2xjZEj+WG3xMEPCt9or78i2yvXROH+Ex2roM5sji+dpWYKRF9eSz3f5h2H5RilF9i6AzC3tDtduelHhOaCWbVn+cd3jih5UuF/XTZWZT7rzG8hi7SQUmbuXPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739260676; c=relaxed/simple;
	bh=EkXyonoyXlxTxbDDka2sbe2pzNYd9avLkgJX04haqYE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t96YNtRX1recCrkbsU+i0mrfrMAWFEHYGGnVfLdnIOu0ZmNhWZ+FoyfwyvMsd9RI7f3ZZQDfrEznQ8dtou20EnPNg+ZvuYG0cL4cyJSmiFqdU8a4hnFcXaATbb8Q27wHuXRDuEL1IV8lp57WGhsEK52NbgkKaTCZ/9tfT88nUCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=J9OfNxcc; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="J9OfNxcc"
ARC-Seal: i=1; a=rsa-sha256; t=1739260661; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Iu5o4OhpjZhY8Ow79gN0JHjyJw5rea/2ALE9NeXX2v6jOCcJMev/n2CmFQJmrd5M2mfhs15xytuKurWqQqaqZuhZqpvScs/Bff6+3CSU5Xs3Vd7Bizv+qyuYij3hTWvUHEcsPB7lk1hW8Q2eAioxtcnOFWCtqaMRr3Ntj+01jQQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739260661; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=aJYugM60n93ioiD/yFHZ0ukaareKO/ZhIAhoTxBvDPQ=; 
	b=g9Pg3br2WHiDGRYlXerK7i8uIAOBqhqs6QzJ8ONDGOotsLPWvtQGrGnXDIuH38QLNKwIQ5R/yF9235uJ4+6dM1ZvQHCi5cTH/X4UV79ytYoRvCeInKhoNSODPNEUuvh0Ta/ozu0nmTr29jVu/nJPkR1SxQ4yGhBlEKBV2nlighc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739260661;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=aJYugM60n93ioiD/yFHZ0ukaareKO/ZhIAhoTxBvDPQ=;
	b=J9OfNxccFFUvtXN+dAh5nrLbrX1MWDh/KeO+l35EY3fZvkoJSNOPL1P4/KZk7rwN
	LsByghmzgV+uDCv7RinQEb5t6g6EgAx1zzbOusmpM9us3JTgSmWuQTrPFujld17Uy+q
	LPQA9NvFNKezyJnfAnICUljYgbK5HoMZ2q4qdWvY=
Received: by mx.zohomail.com with SMTPS id 1739260658164746.6572688940518;
	Mon, 10 Feb 2025 23:57:38 -0800 (PST)
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
Subject: [PATCH v1 0/7] Use guard() instead of rwsem locking
Date: Tue, 11 Feb 2025 15:57:20 +0800
Message-Id: <20250211075727.351895-1-ming.li@zohomail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011227697a47ad496bfedf41ffec840000e16ec349b7a5ef7307093606e9313b20b659af9c738441d42f:zu08011227424f64415c2e61a70b4a02be00007c5d89c04393e58da93543626a27d42225e5b47246624933af:rf0801122d30a9f785deb526d2e4ee69db00002ea7e2a7eae156bba825b5829b419127b1c3197a7cb16dfcc9829094af26cd:ZohoMail
X-ZohoMailClient: External

Use scoped resource management to replace open-coded locking operation
is recommended. CXL subsystem still remains some down_read()/up_read()
and down_write()/up_write() which can be replaced by guard() simply.

This patchset includes simply using guard() instead of some
down_read()/up_read() and down_write()/up_write() cases. Besides, it
also includes some function code cleanup after using guard().

base-commit: a64dcfb451e254085a7daee5fe51bf22959d52d3 (tag: v6.14-rc2)

Li Ming (7):
  cxl/core: Use guard() to replace open-coded down_read/write()
  cxl/core: cxl_mem_sanitize() cleanup
  cxl/memdev: cxl_memdev_ioctl() cleanup
  cxl/core: Use guard() to drop the goto pattern of cxl_dpa_free()
  cxl/core: Use guard() to drop goto pattern of cxl_dpa_alloc()
  cxl/region: Drop goto pattern in cxl_dax_region_alloc()
  cxl/region: Drop goto pattern of construct_region()

 drivers/cxl/core/hdm.c    | 62 +++++++++++----------------
 drivers/cxl/core/mbox.c   | 10 ++---
 drivers/cxl/core/memdev.c | 17 +++-----
 drivers/cxl/core/port.c   |  8 +---
 drivers/cxl/core/region.c | 90 +++++++++++++++++++--------------------
 5 files changed, 81 insertions(+), 106 deletions(-)

-- 
2.34.1

