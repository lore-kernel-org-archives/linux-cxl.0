Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9181D15666D;
	Sat, 11 Jan 2025 09:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736587094; cv=none; b=kDmSd6O8y44S/fFdIdU2qLpY837XWpELwDcB+OcUAcbKQbvjPFEdapgeWGQDeh89r3kcGjN3z5qHzmbatCiX4Ma5Du3OQkQtyzjoeU66jRg34TK+pnS5z5/aBTkxgawhuwEZMi0Ck48IumDiX7Do52Zv60IOJiZJokXNHYTNGMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736587094; c=relaxed/simple;
	bh=g3fifVcCYBUWa2qovuY/7qcBh3pScizBKwJNaeZ8xfw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pVj25OPLPxL+u8CcMihoX91UDe7O5ASgLjP79+YMDdCHEXTsIdPno8l7pragOKl6l1wHeKFRLC1G30SxqmReVCyX42aDQtbeI65FaA8eGgZcyplwr/232WqZIkuDCHNyHw5HLL3bYOy6hv6DNOLij9qhghvCqNhJNCd2pA3pse4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YVXw53HQ4z6892k;
	Sat, 11 Jan 2025 17:16:53 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 7BA871403D2;
	Sat, 11 Jan 2025 17:18:10 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.156.155) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 11 Jan 2025 10:18:09 +0100
From: <shiju.jose@huawei.com>
To: <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <alison.schofield@intel.com>,
	<nifan.cxl@gmail.com>, <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dave@stgolabs.net>, <linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>, <shiju.jose@huawei.com>
Subject: [PATCH v6 0/6] Update Event Records to CXL spec rev 3.1
Date: Sat, 11 Jan 2025 09:17:50 +0000
Message-ID: <20250111091756.1682-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
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
V5 -> V6
1. Modified for feedbacks from Ira Weiny.
   - Reordered new fields added in trace events cxl_general_media,
     cxl_dram and (cxl_memory_module to pack the records.  
   - Added a suggested note in the patch description of patch
     cxl/events: Add Component Identifier formatting for CXL spec rev 3.1
	 
V4 -> V5
1. Reverted changes made in v4 for overcoming parsing error when
libtraceevent in userspace parses the CXL trace events, for rasdaemon.
This was due to trace event's format file is larger than PAGE_SIZE, not
supported reading complete format file in one go in the kernel and thus
fixed in the rasdaemon.
2. Rebased to v6.13-rc5, in which cxl.git/next is based.
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

 drivers/cxl/core/trace.h     | 259 +++++++++++++++++++++++++++++------
 include/cxl/event.h          |  28 ++--
 tools/testing/cxl/test/mem.c |  23 +++-
 3 files changed, 257 insertions(+), 53 deletions(-)

-- 
2.43.0

