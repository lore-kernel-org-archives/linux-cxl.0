Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E18620E31E
	for <linux-cxl@vger.kernel.org>; Fri, 18 Oct 2024 01:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729213839; cv=none; b=lKWKhLG/wUoI+lU6VtsJxJihyJnBAAaIFHmBRzi38byGI0MNjCQplI5VxV0PpEhJiBarBAtAQSTm8X8ADjeUhksXYXs7mapPauWDtMZsIiR/3ykXI70qJq5yB0gLVUHXusBnfpnDAvXu5s/qMjjrKA2UHGcuP9Zf64kJ2owYeBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729213839; c=relaxed/simple;
	bh=L8pZ6+V41pof13b5gixaLksIjInuyvkMAXvESD6nvPE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=azeBwpDWtWMWmN4atLdGfph0NCeHMAiwfCtj0+XOAKE/LTdnjXCGnB2+WuXZ79T1kHwW8THvTz5M7VVmkXAbl5lAHr1Lg3wIJuJZ43WHfkGhA4Tou8G/nM2/Ro/kJfYguQj4DhS+cD8VK2K0KhDQwVZS67tSeDFF5dSdXytsOBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nygvghDc; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nygvghDc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729213837; x=1760749837;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L8pZ6+V41pof13b5gixaLksIjInuyvkMAXvESD6nvPE=;
  b=nygvghDcNn6ULtWP4NFv9bJhYMU79uCrKUfdrDaIQrIYvJX0+73PURGm
   Xc3HuqmY1Z7tqJ73PEkyHewoksMmBOzRmz/7hnyTljs3njOITg5FAT4Si
   Dfb8+6+tmnjpnSDuFq3V3KmKPSPSpa9Z7L0OHYRIp9gbFai9QSy77/Kw4
   TeqUL0dACbnwqkjiBJToVJjYSJiKg+n1qB/kRJLg8ANVDuzFPe2Sl1LZF
   50CuRaHKGRk37CMLMc7ryvthnwFtXkHNansb3Ptw39kwYs/OVqzkHseHu
   6YFTyFzmKCGaNkvtJz0WbaoeI6pir8hEobmzG6yRJ/ZwWud0oLi+JjOJG
   Q==;
X-CSE-ConnectionGUID: 36QXn4HHRUOSqqVLhw//LQ==
X-CSE-MsgGUID: J6v592BaRiiIHlEUVgxF3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="28168462"
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="28168462"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 18:10:27 -0700
X-CSE-ConnectionGUID: pDH82L2TQ0mWDTgtwOqenQ==
X-CSE-MsgGUID: eihjvqXMRcW9z7EL3+8DKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="109535282"
Received: from rfrazer-mobl3.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.125.109.118])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 18:10:27 -0700
Subject: [PATCH v2 2/3] cxl/port: Revert __free() conversion of
 add_port_attach_ep()
From: Dan Williams <dan.j.williams@intel.com>
To: ira.weiny@intel.com, dave.jiang@intel.com
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Li Ming <ming4.li@intel.com>,
 linux-cxl@vger.kernel.org
Date: Thu, 17 Oct 2024 18:10:25 -0700
Message-ID: <172921382410.2133624.570103049126168259.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <172921380683.2133624.1708770961640157143.stgit@dwillia2-xfh.jf.intel.com>
References: <172921380683.2133624.1708770961640157143.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Dan points out via smatch [1] that the conversion of
add_port_attach_ep() to use cleanup helpers does appears to not
correctly handle a pointer reassignment case.

    drivers/cxl/core/port.c:1591 add_port_attach_ep()
    warn: re-assigning __cleanup__ ptr 'port'

The reassignment still results in the correct cleanup and reference
counting, but it is not immediately obvious from the code.

Revert the __free() conversion in preparation for refactoring the
subtlety out of this function.

Cc: Dan Carpenter <dan.carpenter@linaro.org>
Link: http://lore.kernel.org/2a19289b-0bcf-42c4-82a9-268a922535f2@stanley.mountain [1]
Cc: Li Ming <ming4.li@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/port.c |   11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 54dd2cd450ca..8e6596e147b3 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1544,6 +1544,7 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
 			      struct device *dport_dev)
 {
 	struct device *dparent = grandparent(dport_dev);
+	struct cxl_port *port, *parent_port = NULL;
 	struct cxl_dport *dport, *parent_dport;
 	resource_size_t component_reg_phys;
 	int rc;
@@ -1559,18 +1560,12 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
 		return -ENXIO;
 	}
 
-	struct cxl_port *parent_port __free(put_cxl_port) =
-		find_cxl_port(dparent, &parent_dport);
+	parent_port = find_cxl_port(dparent, &parent_dport);
 	if (!parent_port) {
 		/* iterate to create this parent_port */
 		return -EAGAIN;
 	}
 
-	/*
-	 * Definition with __free() here to keep the sequence of
-	 * dereferencing the device of the port before the parent_port releasing.
-	 */
-	struct cxl_port *port __free(put_cxl_port) = NULL;
 	device_lock(&parent_port->dev);
 	if (!parent_port->dev.driver) {
 		dev_warn(&cxlmd->dev,
@@ -1605,8 +1600,10 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
 			 */
 			rc = -ENXIO;
 		}
+		put_device(&port->dev);
 	}
 
+	put_device(&parent_port->dev);
 	return rc;
 }
 

