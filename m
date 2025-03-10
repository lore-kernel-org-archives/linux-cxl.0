Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EFA21E0AE;
	Mon, 10 Mar 2025 13:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741614685; cv=none; b=r9yrE/VI86R3hiCOkY/R2+zUW73vrtpFGEfj+XiKBIQKJUpL8toprrlcnFK3KKG9vpLiFz//zKETj/7wETfPo5odh4M5i6jIDAS53JSl8h65WwUuYuBtnmgiSC3lAX2HbRycc9H0zLRCgm4zvMtnguQGE5l5mU+gq97NVYJv/Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741614685; c=relaxed/simple;
	bh=PIYugoZwhEs2hJs1UPNoqX04pDcVa6iAsRDXNI4cWSU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OzTyDZCGPRwYI601m8BH4VusDlDpCAGzU+1g/u5JboO1P+of71ECFkX8LhuBr2L0b7Hwamv+BvG8f5n2C4k1TUKnG6ZwQXBmAIswgizTdd82515CTM9w57/0Cva+FxlDXXzBBm3j1qCgYPd8+BoqymssJ3A55DLrEYf872bvwFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QTEHYWIT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTEHYWIT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1B8CC4CEF0;
	Mon, 10 Mar 2025 13:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741614684;
	bh=PIYugoZwhEs2hJs1UPNoqX04pDcVa6iAsRDXNI4cWSU=;
	h=From:To:Cc:Subject:Date:From;
	b=QTEHYWITads7vGifSYT6DMpFSt2a9gANjZXVYp20puC4EBx2529IEKHCPB3ECdIyo
	 FwrTbY8bT2EUIQwWMtdDAeahbavOHipZ6xun6QzRweTCaJbFZUDchQ71X/upS5z9Ng
	 Z3YzgaConUz+7VWjW32hM1TBcbNr9Xn4ISK5juqu1mKkA1qh+RbZ55XBSDA+cCepvh
	 8OMnwm2RXfUm7K8HEIwlewMmTnHRwD01ki2QLI61GBpgSRpICEyXkd2QnnR4E0sh8U
	 VQrAf18v35aM7JaE7mYriVaRg5jDLM5AM6twKQxI2sRXz0RLzbjJi/d4k1CuBKOb9Z
	 9uwj562pNFh/A==
From: Arnd Bergmann <arnd@kernel.org>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Li Ming <ming.li@zohomail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Robert Richter <rrichter@amd.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cxl: fix FWCTL dependency
Date: Mon, 10 Mar 2025 14:51:15 +0100
Message-Id: <20250310135119.4168933-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The 'FWCTL' subsystem is selected by CXL_FEATURES, which is a 'bool' symbol
with a dependency on CXL_PCI, but referenced by the cxl_core.ko.
When cxl_core is built-in, but the cxl_pci.ko driver is a loadable mdoule,
this results in a link failure:

ld.lld-21: error: undefined symbol: _fwctl_alloc_device
>>> referenced by features.c:695 (/home/arnd/arm-soc/drivers/cxl/core/features.c:695)
ld.lld-21: error: undefined symbol: fwctl_register
>>> referenced by features.c:699 (/home/arnd/arm-soc/drivers/cxl/core/features.c:699)
ld.lld-21: error: undefined symbol: fwctl_unregister
>>> referenced by features.c:676 (/home/arnd/arm-soc/drivers/cxl/core/features.c:676)

Move the 'select' into the symbol that controls the core module instead.

Fixes: a53a6004e7a5 ("cxl: Add FWCTL support to CXL")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/cxl/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index ed49e7e7e5bc..cf1ba673b8c2 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -7,6 +7,7 @@ menuconfig CXL_BUS
 	select PCI_DOE
 	select FIRMWARE_TABLE
 	select NUMA_KEEP_MEMINFO if NUMA_MEMBLKS
+	select FWCTL if CXL_FEATURES
 	help
 	  CXL is a bus that is electrically compatible with PCI Express, but
 	  layers three protocols on that signalling (CXL.io, CXL.cache, and
@@ -105,7 +106,6 @@ config CXL_MEM
 config CXL_FEATURES
 	bool "CXL: Features"
 	depends on CXL_PCI
-	select FWCTL
 	help
 	  Enable support for CXL Features. A CXL device that includes a mailbox
 	  supports commands that allows listing, getting, and setting of
-- 
2.39.5

