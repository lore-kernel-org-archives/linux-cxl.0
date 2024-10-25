Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600DD192592;
	Fri, 25 Oct 2024 11:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729856792; cv=none; b=sRcovn3yQ9sjO8e1NxCqHUKqR+ub4lFyN2HORbZtlgpd8nJGrdmXDSMTrNIQ+4pvo4iETUQa2fj6qP0ijCue0Vg4paETQD1aet+W677kvzii9KEyzY7zJCHR90owzkxumChJFZ/zP8GHqxtExYAybqSIT6YSrwS8FYa5zaY3Q30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729856792; c=relaxed/simple;
	bh=j9GWXfv1DxXCNWQTXf0uIL68q2p4Ue8VEhNDnpVsvOI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RIB/pMFX1gZaJNeonBIHiDu0mG9mnMa0XfWXNf++AHVwqkup1cYs9H6kXo//lLckBkzK5GlnIDqCpYQcxJeCBoUNsE0GF7Z+AbeDocxFshgwpsQiwOhfZ1oAY6jQH0LD2kZ0G7oDwDAtKgFx2YVAHffulMY0DLFA/cHIDH0lMrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XZgvR03sjz6K5kc;
	Fri, 25 Oct 2024 19:45:23 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 90E04140B35;
	Fri, 25 Oct 2024 19:46:26 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.151.104) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 25 Oct 2024 13:46:25 +0200
From: <shiju.jose@huawei.com>
To: <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <dave@stgolabs.net>,
	<linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>, <shiju.jose@huawei.com>
Subject: [PATCH v3 0/6] Update Event Records to CXL spec rev 3.1
Date: Fri, 25 Oct 2024 12:45:49 +0100
Message-ID: <20241025114555.1363-1-shiju.jose@huawei.com>
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
2. Verified with modified CXL error injection in QEMU CXL emulation and
CXL mock test in kernel. (Thanks to Jonathan for verifying with CXL mock test setup).

Shiju Jose (6):
  cxl/events: Update Common Event Record to CXL spec rev 3.1
  cxl/events: Add Component Identifier formatting for CXL spec rev 3.1
  cxl/events: Update General Media Event Record to CXL spec rev 3.1
  cxl/events: Update DRAM Event Record to CXL spec rev 3.1
  cxl/events: Update Memory Module Event Record to CXL spec rev 3.1
  cxl/test: Update test code for event records to CXL spec rev 3.1

 drivers/cxl/core/trace.h     | 258 +++++++++++++++++++++++++++++------
 include/cxl/event.h          |  20 ++-
 tools/testing/cxl/test/mem.c |  23 +++-
 3 files changed, 252 insertions(+), 49 deletions(-)

-- 
2.34.1

