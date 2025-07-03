Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A26128DB4A
	for <linux-cxl@vger.kernel.org>; Thu,  3 Jul 2025 09:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751534234; cv=none; b=jnHYB+xYygf19O08QXhFdMpAlwsXCCLN4hZGX63FwfQjtFio45K1nqM+P3knyuYMuPOdNkGzPE60B/7wCFMRX6fxu8VdrAo2a4EX6YBHGo8HKZx+TFGNsqYlf1gZHABbMEfuMpgnIoq334bVymHzKp1gqklMGbfpxPXVfIEEodI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751534234; c=relaxed/simple;
	bh=ixyyfSAPnXJNSnhIDq7/VnGVxBPowLX6fHFp70OM+ek=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=buP46SYhc1wUrHPaVk2nxcfoQMa+KyN5ZxE+n8TWi46QlzCyBS2Qx7gFZe3/gaHko2RilsWtGWUfO5Qnj2uUo+lJqNjaZVicCSS/Tf0htxQp1yMHunLw07u3R6XzK0AUg31Hd0zJwwSqdkg4vsrypvKhkMh13sja7iBZBURB9kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bXrjR4zKrz6M4h1;
	Thu,  3 Jul 2025 17:16:11 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 915661402F5;
	Thu,  3 Jul 2025 17:17:08 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.195.244.176) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 3 Jul 2025 11:17:07 +0200
From: <shiju.jose@huawei.com>
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
	<jonathan.cameron@huawei.com>, <fan.ni@samsung.com>, <dave@stgolabs.net>
CC: <linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH v3 0/7] hw/cxl: Update CXL events to rev3.2 and add maintenance support for memory repair features 
Date: Thu, 3 Jul 2025 10:16:49 +0100
Message-ID: <20250703091657.1868-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500007.china.huawei.com (7.182.85.172)

From: Shiju Jose <shiju.jose@huawei.com>

Add updates for the CXL spec rev3.2 changes, in the CXL events reporting
and QMP command to inject CXL events.

Add maintenance support and emulation support for memory Post Package
Repair(PPR) and memory sparing control features.

Add support for reporting the memory sparing event record.

Changes
=======
v2 -> v3:
1. Changes for the feedback from Jonathan on v2.
   https://lore.kernel.org/all/20250619151619.1695-1-shiju.jose@huawei.com/
  1.1. https://lore.kernel.org/all/20250620150342.000055aa@huawei.com/
    - Wrap this is sub 70 and should aim for about 75 for commit descriptions.
    - hdr->ld_id = ld_id; to stw_le_p(&hdr->ld_id, ld_id); in cxl_assign_event_header()
    - Make maint_class, maint_subclass, ld_id and head_id as optional parameters in QMP for
      relevant events
    - In QMP rename maint-class to maint-op-class, maint_subclass to maint-op-subclass
      In functions, rename parameters, class to maint_op_class, subclass to maint_op_subclass etc.  
  1.2. https://lore.kernel.org/all/20250620151314.0000535c@huawei.com/ 
    - Make cme-ev-flags and cme-count for general media events as optional parameters in the QMP.
    - Make cme-ev-flags and cvme-count for DRAM event as optional parameters in the QMP.
  1.3. https://lore.kernel.org/all/20250620151655.00001cea@huawei.com/
    - Add variable declarations at start of the local scope.
  1.4. https://lore.kernel.org/all/20250620154052.00002a17@huawei.com/
    - Adjust indent style  in few places.
    - Add support for produce a Memory Sparing Event Record and enabled for
      ppr maintenance request.
    - Replaced hard coded values in few switch-cases with macro definition in few places.
    - Replaced CXL_MBOX_UNSUPPORTED with CXL_MBOX_INVALID_INPUT.
  1.5. https://lore.kernel.org/all/20250620154813.00002bbd@huawei.com/
    - Add support for memory sparing resource availability.
    - LOG_UNIMP logs for sparing maint op removed.
    - Replaced CXL_MBOX_UNSUPPORTED with CXL_MBOX_INVALID_INPUT.
               
v1 -> v2:
1. QMP CXL event injection code has updated for the following
   change in CXL spec r3.2 Table 8-55. Common Event Record Format,
   field: Event Record Flags. Length of this field has changed
   from 2 bytes to 3 bytes. 
2. Rebase to recent tag 'cxl-2025-06-10'.


Davidlohr Bueso (1):
  hw/cxl: Add Maintenance support

Shiju Jose (6):
  hw/cxl/events: Update for rev3.2 common event record format
  hw/cxl/events: Updates for rev3.2 general media event record
  hw/cxl/events: Updates for rev3.2 DRAM event record
  hw/cxl/events: Updates for rev3.2 memory module event record
  hw/cxl/cxl-mailbox-utils: Move declaration of scrub and ECS feature
    attributes in cmd_features_set_feature()
  hw/cxl: Add emulation for memory sparing control feature

 hw/cxl/cxl-mailbox-utils.c  | 572 +++++++++++++++++++++++++++++++++++-
 hw/mem/cxl_type3.c          | 269 ++++++++++++++++-
 hw/mem/cxl_type3_stubs.c    |  41 ++-
 include/hw/cxl/cxl_device.h | 142 ++++++++-
 include/hw/cxl/cxl_events.h |  85 +++++-
 qapi/cxl.json               | 106 ++++++-
 6 files changed, 1172 insertions(+), 43 deletions(-)

-- 
2.43.0

