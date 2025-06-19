Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187723085DB
	for <linux-cxl@vger.kernel.org>; Thu, 19 Jun 2025 15:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750346207; cv=none; b=rKZor6bq58ZqlLaMHeF4swlmikrPATSSY0ViWCw2jMJuRD/3ys1MImFsqfto4ABmU7vdjkTQZWXrqru4zXpguQV1l3L/3jIYMu2YKRwrLXGr0otYnoXCYwKK5ddsILNy7Y9+Vrw6vZFqMb2UtTtF1WZvam+7kwsAc4FFAYJMBzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750346207; c=relaxed/simple;
	bh=Ghk5yTMxYB8G/TJFB46Gl+jyjoxTNcxihzolgyNujK8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V2uGseBBg05x39GROPzWlmcZI4oR/IUIJ6itsnSj7sjuZz1YHkzhQGMCVjXIYtYFCBDWPnmMMGNrYuTPvuCXByD6rsdEACqPmQ6z3xhm0bRCSUjCcad4gt5ire0+DANGUyzIF2ifNmRwruBOomHvr5bxYEapkYnOgDfWpGbRtvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bNPM82RJ1z6M5R4;
	Thu, 19 Jun 2025 23:16:04 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 2300314033C;
	Thu, 19 Jun 2025 23:16:41 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.195.246.81) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Jun 2025 17:16:40 +0200
From: <shiju.jose@huawei.com>
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
	<jonathan.cameron@huawei.com>
CC: <tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH v2 0/7] hw/cxl: Update CXL events to rev3.2 and add maintenance support for memory repair features 
Date: Thu, 19 Jun 2025 16:16:12 +0100
Message-ID: <20250619151619.1695-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500007.china.huawei.com (7.182.85.172)

From: Shiju Jose <shiju.jose@huawei.com>

Add updates for the CXL spec rev3.2 changes, in the CXL events reporting
and QMP command to inject CXL events.

Add maintenance support and emulation support for memory Post Package
Repair(PPR) and memory sparing control features.

Davidlohr Bueso (1):
  hw/cxl: Add Maintenance support

Changes
=======
v1 -> v2:
1. QMP CXL event injection code has updated for the following
   change in CXL spec r3.2 Table 8-55. Common Event Record Format,
   field: Event Record Flags. Length of this field has changed
   from 2 bytes to 3 bytes.  

2. Rebase to recent tag 'cxl-2025-06-10'.

Shiju Jose (6):
  hw/cxl/events: Update for rev3.2 common event record format
  hw/cxl/events: Updates for rev3.2 general media event record
  hw/cxl/events: Updates for rev3.2 DRAM event record
  hw/cxl/events: Updates for rev3.2 memory module event record
  hw/cxl/cxl-mailbox-utils: Move declaration of scrub and ECS feature
    attributes in cmd_features_set_feature()
  hw/cxl: Add emulation for memory sparing control feature

 hw/cxl/cxl-mailbox-utils.c  | 505 +++++++++++++++++++++++++++++++++++-
 hw/mem/cxl_type3.c          | 182 ++++++++++++-
 hw/mem/cxl_type3_stubs.c    |  22 +-
 include/hw/cxl/cxl_device.h | 132 +++++++++-
 include/hw/cxl/cxl_events.h |  38 ++-
 qapi/cxl.json               |  94 ++++++-
 6 files changed, 936 insertions(+), 37 deletions(-)

-- 
2.43.0

