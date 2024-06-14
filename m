Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com [68.232.139.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793E31E4BE
	for <linux-cxl@vger.kernel.org>; Fri, 14 Jun 2024 03:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718335377; cv=none; b=SRxhxqfxTEIq0yGkkUS9YDgYDyG92oB6FFJYF5RZdASfBgT6+K0NSVzqBty4/ld6Ee6kHkkAWVRoIoDSDA7W2IgKZV60uL224CYvkisI807nPsz1wXy824nGFCQSdER8qi2JH1rLVcMcwj3NYkNYYcxn3qxo8VUvID38DI2Plvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718335377; c=relaxed/simple;
	bh=TYvXlcx/QBCX55n2er3i+f2dmocZvuYU4US7UdIOqE4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EyD63ABE2e8atI/5mYyZgA8ZXAc9dTFSiE2rwh//kOHIVsjrJlDSe46yD3cuDyumsUEDoLgiNz937s+0CwG/+cWf63qvas8208XJyL8d3F7SOwGp4D13M3XMjndtfMoEtXst6Gl7aO8w+ED1qlbNx67wy9JwMOF0itXqaiPGSng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=SkYOH9yo; arc=none smtp.client-ip=68.232.139.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="SkYOH9yo"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1718335376; x=1749871376;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TYvXlcx/QBCX55n2er3i+f2dmocZvuYU4US7UdIOqE4=;
  b=SkYOH9yoAoR/kUErtXqoLafdyp7gA1wdyn+2q8MDgG575NCucFie1Fwf
   C4msXFLsR8UJgVRIR3RSS7RdGQZM+/hBddMvenZJdZQKOzD8AP29OLq+u
   J0JJ9xM0PYipaJkhpjqF9FnaZbENugm7fGRG+GVYigyqE2syVZOp1zrBB
   cc/6idFO4hKCGb6r5fh4W8LmxObdij5UsigdC6Faod6pqg6Ymy47kEuRE
   1rpqIldjFS9Py1VijiN4A5Cekw6WMviSwdfyxoQ1T0JJylPrGaknrS2FE
   Xx5Dj+fCoe2h/OjKducJHYcJVH0TOxGBW863Cyk2Tte0GPGpStNY39+Ng
   w==;
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="165080761"
X-IronPort-AV: E=Sophos;i="6.08,236,1712588400"; 
   d="scan'208";a="165080761"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 12:21:44 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
	by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 5DE80CA1EC
	for <linux-cxl@vger.kernel.org>; Fri, 14 Jun 2024 12:21:41 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id AC2D8D700A
	for <linux-cxl@vger.kernel.org>; Fri, 14 Jun 2024 12:21:40 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 3C45CE51A8
	for <linux-cxl@vger.kernel.org>; Fri, 14 Jun 2024 12:21:40 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.225.88])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 87E131A0002;
	Fri, 14 Jun 2024 11:21:39 +0800 (CST)
From: Yao Xingtao <yaoxt.fnst@fujitsu.com>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	jim.harris@samsung.com
Cc: linux-cxl@vger.kernel.org,
	Yao Xingtao <yaoxt.fnst@fujitsu.com>
Subject: [PATCH v8 2/3] cxl: documentation: add cxlmem.h to cxl driver-api
Date: Thu, 13 Jun 2024 23:21:32 -0400
Message-Id: <20240614032133.45365-3-yaoxt.fnst@fujitsu.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240614032133.45365-1-yaoxt.fnst@fujitsu.com>
References: <20240614032133.45365-1-yaoxt.fnst@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28452.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28452.004
X-TMASE-Result: 10-0.012700-10.000000
X-TMASE-MatchedRID: Dkfyeyxtv0aCAvsmJ/zu/0hwlOfYeSqx0bdjqKOoG3eR2NCgBzDCuH6g
	ZpfnfKEjIvrftAIhWmLy9zcRSkKatUPu4/hW5W83rMZ+BqQt2Np9LQinZ4QefCP/VFuTOXUT3n8
	eBZjGmUzkwjHXXC/4I8ZW5ai5WKlyZjGevXgJ4YrU8N80A4JdGnEejtgXWWhkJPhb4GG043RYW5
	x7rJiB8nboV0PxFh4SLGhuoLYgtaEDpsICOXTP8jyZ3q2rhT4WEWW0bEJOTAVAdUD6vW8Z1mZAM
	QMIyK6zB8/x9JIi8hKhgLRzA45JPQ==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Since the interleave capability check is supported, and this feature
depends on cxl_hdm, add cxl_hdm structure to the cxl driver API
documentation.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
---
 Documentation/driver-api/cxl/memory-devices.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/driver-api/cxl/memory-devices.rst b/Documentation/driver-api/cxl/memory-devices.rst
index 5149ecdc53c7..e33ee67ac1a2 100644
--- a/Documentation/driver-api/cxl/memory-devices.rst
+++ b/Documentation/driver-api/cxl/memory-devices.rst
@@ -325,6 +325,9 @@ CXL Memory Device
 .. kernel-doc:: drivers/cxl/pci.c
    :internal:
 
+.. kernel-doc:: drivers/cxl/cxlmem.h
+   :internal:
+
 .. kernel-doc:: drivers/cxl/mem.c
    :doc: cxl mem
 
-- 
2.37.3

