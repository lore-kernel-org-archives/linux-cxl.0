Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DB82F3C2F
	for <linux-cxl@vger.kernel.org>; Wed, 16 Jul 2025 11:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752664870; cv=none; b=OWWKpXitafPEOM4AkojuqCYt4FTfrDlxymR5O+0kBzHJnQxRlt4DInzGCQw8kUWpNwr+wOncARAmiWqFrktDKT2caFFBmXQ6zVueeEdn6rlF1mTxNRpxtc3KRpfBcCrhQ4JjPZWhyfpB8n3v43L54o13aPN07FdD1xf1kamXLcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752664870; c=relaxed/simple;
	bh=Hr6Vfzq2gYg8dO8CoFF8F0WBAf716pSC3MtI26QLaOU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rRXH+vaxs2t5DgJ19mIIsTxd8m6VIdJnynX4cg2k4mmAW/kZlrVXBU4OIeft3Zsqr52CWF/tw2wjxYdluXAlbrw1spRIkG8MQBOwOe5Ii8pmKmh2ND40rv0h+7aOOyOFwKOlMZxJV3LuPAzmbi6+QcYTHF2FrIvLwB7wc53ZXyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bhtr547bMz6M4qL;
	Wed, 16 Jul 2025 19:19:49 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id E3F2014010C;
	Wed, 16 Jul 2025 19:21:04 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.126.173.168) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 16 Jul 2025 13:21:04 +0200
From: <shiju.jose@huawei.com>
To: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<dave.jiang@intel.com>, <jonathan.cameron@huawei.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>
CC: <tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH 0/4] cxl/events: Update to rev 3.2, improvements and add trace memory sparing event record
Date: Wed, 16 Jul 2025 11:49:41 +0100
Message-ID: <20250716104945.2002-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500007.china.huawei.com (7.182.85.172)

From: Shiju Jose <shiju.jose@huawei.com>

Add following changes to the CXL trace events,
1. Update Common Event Record to CXL spec rev 3.2
   https://lore.kernel.org/all/20250522090002.831-1-shiju.jose@huawei.com/
2. Add extra validity checks for corrected memory error count
   in General Media Event Record
3. Add extra validity checks for CVME count in DRAM Event Record
4. Add support for Trace Memory Sparing Event Record.

Shiju Jose (4):
  cxl/events: Update Common Event Record to CXL spec rev 3.2
  cxl/events: Add extra validity checks for corrected memory error count
    in General Media Event Record
  cxl/events: Add extra validity checks for CVME count in DRAM Event
    Record
  cxl/events: Trace Memory Sparing Event Record

 drivers/cxl/core/mbox.c  |  24 ++++++++
 drivers/cxl/core/trace.h | 127 +++++++++++++++++++++++++++++++++++++--
 drivers/cxl/cxlmem.h     |   8 +++
 include/cxl/event.h      |  37 +++++++++++-
 4 files changed, 190 insertions(+), 6 deletions(-)

-- 
2.43.0

