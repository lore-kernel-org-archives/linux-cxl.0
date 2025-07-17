Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC10299A90
	for <linux-cxl@vger.kernel.org>; Thu, 17 Jul 2025 10:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752747517; cv=none; b=V+hf1Sj6w68Y6pPp+exqFgNjUri2+bLVrVuBFWH7yIVbHfuxdn8Rnj8uxUYZCURZJjYMCM0y8lsC//OXF1xRQgfEG4CEd1uB25os89AXg94zWbuUIFfKOdpXqTXeVsBUjP3Jc0RpoUKZXmHxP/ZiuKM6YiunmyJPtuKnywSGLa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752747517; c=relaxed/simple;
	bh=3WItUOVq5VU7dsqQEb8JtizN5+VGyHukvjU3MU9HK1U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DXLFh4V52JfiWamTDLLyiLi99HFLBFnfTSb3kvZTDKNO+PVIoo4+V7eXWcdeKhLX9Yzsni+n2vai05XHNB6PPwz4Wu0YE4/VA1H4yp5PrqzFc7RIN63DNJUhksnsZZdQIjBZXN0R50lbVW8pfMs7j/kmsNkKc6YlyiXyWdPzfDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bjTPT4ZQrz6L5Pv;
	Thu, 17 Jul 2025 18:17:17 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 627DF14027A;
	Thu, 17 Jul 2025 18:18:31 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.195.245.216) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 17 Jul 2025 12:18:30 +0200
From: <shiju.jose@huawei.com>
To: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<dave.jiang@intel.com>, <jonathan.cameron@huawei.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>
CC: <tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH v2 0/4] cxl/events: Update to rev 3.2, improvements and add trace memory sparing event record
Date: Thu, 17 Jul 2025 11:18:13 +0100
Message-ID: <20250717101817.2104-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 frapeml500007.china.huawei.com (7.182.85.172)

From: Shiju Jose <shiju.jose@huawei.com>

Add following changes to the CXL trace events,
1. Update Common Event Record to CXL spec rev 3.2
   https://lore.kernel.org/all/20250522090002.831-1-shiju.jose@huawei.com/
2. Add extra validity checks for corrected memory error count
   in General Media Event Record
3. Add extra validity checks for CVME count in DRAM Event Record
4. Add support for Trace Memory Sparing Event Record.

Changes
v1 -> v2
 https://lore.kernel.org/all/20250716104945.2002-1-shiju.jose@huawei.com/

1. Fixed comment "Spacing before the } is inconsistent" in patch
   Add support for Trace Memory Sparing Event Record (Jonathan).

2. Dropped note and question from patch(2) and patch (3) (Jonathan and
   Dave Jiang)

3 Fix for
  https://lore.kernel.org/all/202507171153.p2RrAdN4-lkp@intel.com/ and
  https://lore.kernel.org/all/202507171217.6p5GHqr0-lkp@intel.com/
  Foregot to do get_unaligned_le24().
  
Shiju Jose (4):
  cxl/events: Update Common Event Record to CXL spec rev 3.2
  cxl/events: Add extra validity checks for corrected memory error count
    in General Media Event Record
  cxl/events: Add extra validity checks for CVME count in DRAM Event
    Record
  cxl/events: Trace Memory Sparing Event Record

 drivers/cxl/core/mbox.c  |  24 +++++++
 drivers/cxl/core/trace.h | 133 +++++++++++++++++++++++++++++++++++++--
 drivers/cxl/cxlmem.h     |   8 +++
 include/cxl/event.h      |  37 ++++++++++-
 4 files changed, 195 insertions(+), 7 deletions(-)

-- 
2.43.0

