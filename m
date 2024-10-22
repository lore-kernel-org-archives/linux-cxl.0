Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F942154426;
	Tue, 22 Oct 2024 10:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729594758; cv=none; b=WDWoZDDUYRzv6qfVOw9mKlo44/bynEXi/NblWO/3Y7bPU3pb1UabY93l7usimJz/cyQmNEvA4vO7X4rk/KsG5s/DNzjjDJpVP8kHl3XFQUMYeUswRcTMLYphbFbGbxg6zcRIbN9LMnHb016R6FpeXOx8OwQkiIH4JAPaSdfX67E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729594758; c=relaxed/simple;
	bh=yLserqjme93MAW/PM6OIrK05+b9MbaUtcZyxNCB2nPU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fCHIRnU4/3QLMqILcn/SSI6G0PYi2RlGRzpTF+velMmabsFSsj/kdKH/jS5YICjLPbSQABmlGBdb3f48vQWnlMGM89p6LGx3ek+34Rs/eM1rHW/l4lVwWsMVW5MGDN8Ym7IKkknuijqh9IwKoj6bylnyJ99H+u6kHSAr96FxuY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XXpz85W07z6G9Lp;
	Tue, 22 Oct 2024 18:57:08 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 7309C14011D;
	Tue, 22 Oct 2024 18:59:08 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.195.246.16) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 22 Oct 2024 12:59:07 +0200
From: <shiju.jose@huawei.com>
To: <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <dave@stgolabs.net>,
	<linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>, <shiju.jose@huawei.com>
Subject: [PATCH v2 0/6] Update Event Records to CXL spec rev 3.1 
Date: Tue, 22 Oct 2024 11:58:43 +0100
Message-ID: <20241022105849.1272-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500007.china.huawei.com (7.182.85.172)

From: Shiju Jose <shiju.jose@huawei.com>

Add updates for the changes in CXL spec rev 3.1 in the CXL events
records and CXL trace events implementation.

Notes:
1. Please apply following fix patch first if not present.
https://patchwork.kernel.org/project/cxl/patch/20241014143003.1170-1-shiju.jose@huawei.com/
2. Tested with modified CXL error injection in QEMU CXL emulation.
3. Not sure how to run kernel cxl/test for injecting events though updated.

Shiju Jose (6):
  cxl/events: Update Common Event Record to CXL spec rev 3.1
  cxl/events: Add Component Identifier formatting for CXL spec rev 3.1
  cxl/events: Update General Media Event Record to CXL spec rev 3.1
  cxl/events: Update DRAM Event Record to CXL spec rev 3.1
  cxl/events: Update Memory Module Event Record to CXL spec rev 3.1
  cxl/test: Update test code for event records to CXL spec rev 3.1

Changes:
V1 -> V2
1. Changes for the feedbacks from Jonathan.
  - Separate patch for Component Identifier formatting.
  - Moved printing of event sub type after event type.
  - For memory module event, rename sub_type to event_sub_type. 
2. Changes for the feedbacks from Alison.
  - Updated patch's subject
  - Updated CXL test code for CXL spec rev 3.1 event records.
3. Changed logic for Component Identifier formatting and other improvements.

 drivers/cxl/core/trace.h     | 240 ++++++++++++++++++++++++++++-------
 include/cxl/event.h          |  20 ++-
 tools/testing/cxl/test/mem.c |  23 +++-
 3 files changed, 233 insertions(+), 50 deletions(-)

-- 
2.34.1

