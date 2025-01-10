Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F96C2080F3;
	Fri, 10 Jan 2025 11:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736510178; cv=none; b=khXnwla+OWQyB71TTjMDkXAGo882GEaO8JolpXCDEJaPPrkNUp70IWzeC7rCEbWD7Cqry9kevi633YIzWztmcsJLXNBVxtl2mdo25qoT4wtJpHw0EgwyvauSB5wIDklf4mATM2ipDEmDLr6/VxFQnsoClwHtOZUUc/KSbOHtpfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736510178; c=relaxed/simple;
	bh=Qjy56krS6CFvsqJSHO30Wy/bg8mhH0oWoayecrdkayU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bKUMnVXdIUDtSjkwY+9BV+/rQIipGzpq3L4Y5x8CUZy9QxHyCNDhOxh+Q+rDPOnBV1DS5GytCSe5VuVzaDyf68zg1jnwju0CWyX6oNjN9BG2SmIVKQFoBDGw63mkp//Xc0DTtHtZllOfBTEodepdkvsMWbFsSNa31j2TnNN30s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YV0Sy5BVfz6L5Hk;
	Fri, 10 Jan 2025 19:54:58 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id E427F14022E;
	Fri, 10 Jan 2025 19:56:12 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.126.170.14) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 10 Jan 2025 12:56:12 +0100
From: <shiju.jose@huawei.com>
To: <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <alison.schofield@intel.com>,
	<nifan.cxl@gmail.com>, <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dave@stgolabs.net>, <linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>, <shiju.jose@huawei.com>
Subject: [PATCH v5 0/6] Update Event Records to CXL spec rev 3.1
Date: Fri, 10 Jan 2025 11:55:50 +0000
Message-ID: <20250110115556.1654-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500007.china.huawei.com (7.182.85.172)

From: Shiju Jose <shiju.jose@huawei.com>

Add updates in the CXL events records and CXL trace events implementations
for the changes in CXL spec rev 3.1.

Shiju Jose (6):
  cxl/events: Update Common Event Record to CXL spec rev 3.1
  cxl/events: Add Component Identifier formatting for CXL spec rev 3.1
  cxl/events: Update General Media Event Record to CXL spec rev 3.1
  cxl/events: Update DRAM Event Record to CXL spec rev 3.1
  cxl/events: Update Memory Module Event Record to CXL spec rev 3.1
  cxl/test: Update test code for event records to CXL spec rev 3.1

Changes:
V4 -> V5
1. Reverted changes made in v4 for overcoming parsing error when
libtraceevent in userspace parses the CXL trace events, for rasdaemon.
This was due to trace event's format file is larger than PAGE_SIZE, not
supported reading complete format file in one go in the kernel and thus
fixed in the rasdaemon.
2. Rebased to v6.13-rc5.
3. Tested with rasdaemon and ras-mc-ctl tools updated for CXL spec rev 3.1
   event record changes.

V3 -> V4
1. Changes for the parsing error parsing error when libtraceevent in
userspace parses the CXL trace events, for rasdaemon.
It was found that long decoded strings of field values in the TP_printk()
caused the issue, looks like due to buffer overflow/corruption.
Increasing known buffer sizes in userspace and kernel did not help.
As a solution, decoding of some fields in the TP_printk() are removed
to accommodate the new fields.
Decoding of these fields is added in the userspace tool rasdaemon.

V2 -> V3
1. Changes for the feedbacks from Jonathan.
 - Added printing component Id format bit in show_valid_flags()
 - Modified parsing component ID in patch [2] and added logging
   of raw comp-id, comp_id_pldm_flags, PLDM entity id and
   PLDM resource id in patches 3 to 4.
 
V1 -> V2
1. Changes for the feedbacks from Jonathan.
  - Separate patch for Component Identifier formatting.
  - Moved printing of event sub type after event type.
  - For memory module event, rename sub_type to event_sub_type. 
2. Changes for the feedbacks from Alison.
  - Updated patch's subject
  - Updated CXL test code for CXL spec rev 3.1 event records.
3. Changed logic for Component Identifier formatting and other improvements.

 drivers/cxl/core/trace.h     | 258 +++++++++++++++++++++++++++++------
 include/cxl/event.h          |  28 ++--
 tools/testing/cxl/test/mem.c |  23 +++-
 3 files changed, 256 insertions(+), 53 deletions(-)

-- 
2.43.0

