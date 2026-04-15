Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3EB2D780C;
	Wed, 15 Apr 2026 12:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776257045; cv=none; b=sQGdeJEGlrB5re4EbjR87ZaQpSu0npU1x7HaTK4FV2ZJD4HlPRMAP3jHeXXDk/gASSZwLu5si4BEMUhxONJsNfxfmq0ZTABvzJ3DwlFcCBqP0HfHSHwbNyNLME4W1lVyL/j0xvY1V1eD9hgTFoESm+gC/fGlHII8yoZ4x0zSUvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776257045; c=relaxed/simple;
	bh=XweURMjRU19v0BIhNynRsWBSHYAgD5Rjn5J8WyVJfB0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YanCxadv7BuFRXdQw+Q3GkHsLA64KxT0d0OKQs3mFqdmw4ZZEbvCyrM7rOrXeoxQ+l0wpZHZdf79Lk32fe698/X4gJTUc6gZASelDz5WpvlYgJwn2/XvpeXagN0Hn/Bovra9VdVYpr7z7psbTYoJsCSrWvKw9reZ9zfoUfSEmrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fwgmN3XDxzJ46Zb;
	Wed, 15 Apr 2026 20:43:16 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 9D2424058B;
	Wed, 15 Apr 2026 20:43:59 +0800 (CST)
Received: from SecurePC-101-06.huawei.com (10.123.51.176) by
 dubpeml500005.china.huawei.com (7.214.145.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 15 Apr 2026 13:43:58 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <linux-kernel@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>,
	<jic23@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira
 Weiny <ira.weiny@intel.com>, <djbw@kernel.org>, <linux-cxl@vger.kernel.org>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Conor
 Dooley <conor@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, Saeed Mahameed
	<saeedm@nvidia.com>
CC: <linuxarm@huawei.com>
Subject: [PATCH] MAINTAINERS: Update Jonathan Cameron's email address
Date: Wed, 15 Apr 2026 13:43:57 +0100
Message-ID: <20260415124357.12539-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml500005.china.huawei.com (7.214.145.207)

Update my email address for CXL, FWCTL and Cache subsystems to use my
kernel.org account. Also update .mailmap.

Separate patches will replace maintainers for HiSilicon specific hardware.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---

Any merge route works for this, but given there are two CXL entries,
perhaps that one is most obvious.

 .mailmap    | 1 +
 MAINTAINERS | 8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/.mailmap b/.mailmap
index 22c5ab1c5d55..55be3163f8ea 100644
--- a/.mailmap
+++ b/.mailmap
@@ -419,6 +419,7 @@ John Stultz <johnstul@us.ibm.com>
 <jon.toppins+linux@gmail.com> <jtoppins@cumulusnetworks.com>
 <jon.toppins+linux@gmail.com> <jtoppins@redhat.com>
 Jonas Gorski <jonas.gorski@gmail.com> <jogo@openwrt.org>
+Jonathan Cameron <jic23@kernel.org> <jonathan.cameron@huawei.com>
 Jordan Crouse <jordan@cosmicpenguin.net> <jcrouse@codeaurora.org>
 <josh@joshtriplett.org> <josh@freedesktop.org>
 <josh@joshtriplett.org> <josh@kernel.org>
diff --git a/MAINTAINERS b/MAINTAINERS
index d1cc0e12fe1f..558b92f5fbc5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6426,7 +6426,7 @@ F:	include/linux/compiler_attributes.h
 
 COMPUTE EXPRESS LINK (CXL)
 M:	Davidlohr Bueso <dave@stgolabs.net>
-M:	Jonathan Cameron <jonathan.cameron@huawei.com>
+M:	Jonathan Cameron <jic23@kernel.org>
 M:	Dave Jiang <dave.jiang@intel.com>
 M:	Alison Schofield <alison.schofield@intel.com>
 M:	Vishal Verma <vishal.l.verma@intel.com>
@@ -6442,7 +6442,7 @@ F:	include/uapi/linux/cxl_mem.h
 F:	tools/testing/cxl/
 
 COMPUTE EXPRESS LINK PMU (CPMU)
-M:	Jonathan Cameron <jonathan.cameron@huawei.com>
+M:	Jonathan Cameron <jic23@kernel.org>
 L:	linux-cxl@vger.kernel.org
 S:	Maintained
 F:	Documentation/admin-guide/perf/cxl.rst
@@ -10539,7 +10539,7 @@ FWCTL SUBSYSTEM
 M:	Dave Jiang <dave.jiang@intel.com>
 M:	Jason Gunthorpe <jgg@nvidia.com>
 M:	Saeed Mahameed <saeedm@nvidia.com>
-R:	Jonathan Cameron <Jonathan.Cameron@huawei.com>
+R:	Jonathan Cameron <jic23@kernel.org>
 S:	Maintained
 F:	Documentation/userspace-api/fwctl/
 F:	drivers/fwctl/
@@ -25148,7 +25148,7 @@ F:	drivers/staging/
 
 STANDALONE CACHE CONTROLLER DRIVERS
 M:	Conor Dooley <conor@kernel.org>
-M:	Jonathan Cameron <jonathan.cameron@huawei.com>
+M:	Jonathan Cameron <jic23@kernel.org>
 S:	Maintained
 T:	git https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/
 F:	Documentation/devicetree/bindings/cache/
-- 
2.51.0

