Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94464653A
	for <linux-cxl@vger.kernel.org>; Mon,  4 Mar 2024 19:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709581447; cv=none; b=CmearHMGXVIR4jqjssKeSTjLuKGrsw2RgtDbotVrccKm70/hTZ8gOOUgis9Nk7etYO3OXsiHpR4eskuR4JABfL78mL2Wi9E498PxAT4lMg+zEi5IKwBGmg1e+S8w4yneNXDRwAR+P8W8PbOjTqetEOK8BLJtRFl1zJBx0Ie8DMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709581447; c=relaxed/simple;
	bh=La7ebYXMaaD8AkGITjp3XwPK6JhQ/4hEQjhs4AvUp2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ATWF/N72fJqNf20AgNEr+MqWR8bp0BmgcMnlNDeZOLZ4+ZysARRqkGCTcvuOYmeA53GfmVQZZiZt0jo7d7PU3UKj47jTeZdsXBmkHlf0W5WjxVMU+jZQhwXQ9wH2sWhHcGZ6hYKTWV91H2XFqQ1nzLAXeFCY3zzYoIX/8SKdhBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xg6HlWwt; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xg6HlWwt"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-db3a09e96daso4303569276.3
        for <linux-cxl@vger.kernel.org>; Mon, 04 Mar 2024 11:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709581445; x=1710186245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QJbfZE+vJVhF6ohULRusgGlAawiyr+LeVZe1pP+RB9U=;
        b=Xg6HlWwtkcgAybQShd2zcSkXWuiighVFsHZSOyI3CRQvXY6v+WcUO2hMmOk+R+CWOZ
         ieRW0pPKWEPaOgYDQXwGBiEuG40aQDXG53QBJPpwHKWyZSBBJoGwbvzK0VFIwof0e+In
         lstODAByLHeUP9M7fNS8NMwMxVzIynv1nVcci1mB3FrgKI69tKcq//ssjsWj5DNp5kwg
         VNForJ6sbz/Odao+SYT/lfntdswveOinwsIKIKUMR8LoBcnewgDicX/4RnEHmXVOqZjI
         KAggcA5qyWQ7uVjWAL75gmiqrYVgBitDGEiiDMDC5P8Ue8lmPA1GnByUfIFpP0+LRqyl
         ZZvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709581445; x=1710186245;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QJbfZE+vJVhF6ohULRusgGlAawiyr+LeVZe1pP+RB9U=;
        b=HAX+PHtmroyciXZOKGrZBUMNWFpcUNZvv0QoMRz+zE6i1sqHC2r3EBu0h1pEk/3kA5
         P6AlCA+S4W4cCRGV0zV1zMDzoU+VRZmCeNV3MyQ9egYQbFxQHZbW+d4bwDYM5nJjN7ac
         cVvaj5/J+YP0HeyD8B+n5qADfMP61a1TdL8SY+XP8mJAAzsznzKWt5G75D5WsP0DYs68
         xxX5if5/u85GQP+3mDplxk1xaWS5iJSLOM4J4RJZICVgXJH9Cm5ewIhQp4ksid6M0Dl4
         pk+cdXX4rBV4+7EMIVHA5QjdO3Il8sZMrnZJM8I+RdgQNyi9blWm39iZNeDxHenYzLDh
         tu2g==
X-Forwarded-Encrypted: i=1; AJvYcCW/BQLoau4bgLk8zU4KkJa+x47ItRm2S1AcTJOS9AYqQbOVuZoT/Mp6IiXEANzWT/rwMebm8pafskw+jiBLqD5auMz46lWcXmhe
X-Gm-Message-State: AOJu0Yy4gcigNJw5nuWUGDPTjAVMqE/LlyTYkXncAUfcbHwF03PyAPSM
	ISOAv1l2VAFjYd4i70DB4RNeB/82+pMjTzanTkBpkriGAV5G9niY
X-Google-Smtp-Source: AGHT+IFvo7oOwuDmSurrtT5G/HJwiIcSWjslezbbQeIkVsdhV8wYif+bOOvtoCuDV8Xf5v/OxuOODw==
X-Received: by 2002:a25:aa86:0:b0:dc7:49ec:50d9 with SMTP id t6-20020a25aa86000000b00dc749ec50d9mr7732176ybi.42.1709581444731;
        Mon, 04 Mar 2024 11:44:04 -0800 (PST)
Received: from localhost.localdomain ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id h1-20020a255f41000000b00dc62edd58dasm2282646ybm.40.2024.03.04.11.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 11:44:04 -0800 (PST)
From: nifan.cxl@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com,
	linux-cxl@vger.kernel.org,
	gregory.price@memverge.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	a.manzanares@samsung.com,
	dave@stgolabs.net,
	nmtadam.samsung@gmail.com,
	nifan.cxl@gmail.com,
	jim.harris@samsung.com,
	Jorgen.Hansen@wdc.com,
	wj28.lee@gmail.com,
	Fan Ni <fan.ni@samsung.com>
Subject: [PATCH v5 00/13] Enabling DCD emulation support in Qemu
Date: Mon,  4 Mar 2024 11:33:55 -0800
Message-ID: <20240304194331.1586191-1-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fan Ni <fan.ni@samsung.com>

The code is rebased on mainstream QEMU with the following patch series:
hw/cxl/mailbox: change CCI cmd set structure to be a member, not a reference
hw/cxl/mailbox: interface to add CCI commands to an existing CCI

v4->v5:
1. Did spell check for the patchset and fixed 2 typos;
2. Fixed a misuse of stq_le_p and replaced it with stl_le_p in
   cmd_dcd_get_dyn_cap_config;
3. Removed unnecessary switch case in patch 9;
4. Capitalized ""opcode" to "Opcode" in two code comments;
5. Updated one reference text to the spec;
6. Minor text change in qapi/cxl.json.
7. Removed the definition of CXL_SPEC_AFTER_R30
8. Removed the unnecessary input and output mailbox payload struct type
   definition;
9. set num_extents_supported and num_extents_avaible based on extents;
10. Renamed DCD_MAX_REGION_NUM to DCD_MAX_NUM_REGION;
11. Updated the commit log in Patch 4 to remove the unwanted text;
12. Fixed some indent issues;
13. Fail removal if it causes extents overflow after removal;
14. Capture cases when adding response causing the device to exceed its extent
    tracking ability;
15. Using memory_region_size instead of directly accessing the field in
    cxl_create_dc_regions;
16. Renamed DCDRegion as DCRegion;

Changes 1-5 are suggested by Wonjae Lee (wj28.lee@gmail.com), 
Changes 6-14 are suggested by Jonathan.
Changes 15-16 are suggested by Jorgen.

Thanks for the review of v4.

For this version, the main code changes (PATCH 11~12) extend DC extent
release processing, including mailbox command and QMP interface processing.

Based on Jonathan's suggestion, we updated the code, and now we can process
extent release request more flexible. We can now support superset release
(actually we can do even more, as long as the DPA range is covered by
accepted extents, we can release).

For superset extent release, the only requirement, if we find part of its DPA
range is still pending to add, while the other is accepted, we reject it
through QMP interface.

Last but not least, in the series, we introduced a new patch (PATCH 13),
which We introduce new QMP interfaces to print out accepted and
pending-to-add list in the device to a file.

The latest code branch is https://github.com/moking/qemu/tree/dcd-v5.

The code is tested with Ira's last kernel DCD patch set [2] with some minor
bug fixes[3]. Tested operations include:

Extra extent release test,
1. Add multiple extents, and removing them one by one, passed;
2. Superset release: add multiple extents with continuous DPA ranges, and
   Remove all of them with a single extent request with extent covering the
   whole DPA range, passed;
3. Partial extent release: add a large extent and release only part of it,
   passed;
4. Partial+superset release: add multiple extents,and release it with some
   leftover with one request with an extent. For example, add extents [0-128M]
   and [128-256], release [64M-256M], passed;
5. release extent not aligned to block size, failed as expected;
6. extents have overlaps, fail the request as expected;
7. extent has uncovered DPA range, skip the extent as expected; 
8. OS tries to release a non-exist extent, return invalid PA as expected;
 
[1] v4: https://lore.kernel.org/linux-cxl/20240221182020.1086096-1-nifan.cxl@gmail.com/T/#m580c59be5deca2639dd7158e57f4bc1141d1c885
[2] https://github.com/weiny2/linux-kernel/tree/dcd-v3-2023-10-30
[3] https://github.com/moking/linux-dcd/commit/9d24fa6e5d39f934623220953caecc080f93e964

Fan Ni (13):
  hw/cxl/cxl-mailbox-utils: Add dc_event_log_size field to output
    payload of identify memory device command
  hw/cxl/cxl-mailbox-utils: Add dynamic capacity region representative
    and mailbox command support
  include/hw/cxl/cxl_device: Rename mem_size as static_mem_size for
    type3 memory devices
  hw/mem/cxl_type3: Add support to create DC regions to type3 memory
    devices
  hw/mem/cxl-type3: Refactor ct3_build_cdat_entries_for_mr to take mr
    size insead of mr as argument
  hw/mem/cxl_type3: Add host backend and address space handling for DC
    regions
  hw/mem/cxl_type3: Add DC extent list representative and get DC extent
    list mailbox support
  hw/cxl/cxl-mailbox-utils: Add mailbox commands to support add/release
    dynamic capacity response
  hw/cxl/events: Add qmp interfaces to add/release dynamic capacity
    extents
  hw/mem/cxl_type3: Add dpa range validation for accesses to DC regions
  hw/cxl/cxl-mailbox-utils: Add partial and superset extent release
    mailbox support
  hw/mem/cxl_type3: Allow to release partial extent and extent superset
    in QMP interface
  qapi/cxl.json: Add QMP interfaces to print out accepted and pending DC
    extents

 hw/cxl/cxl-mailbox-utils.c  | 682 ++++++++++++++++++++++++++++++++-
 hw/mem/cxl_type3.c          | 724 ++++++++++++++++++++++++++++++++++--
 hw/mem/cxl_type3_stubs.c    |  26 ++
 include/hw/cxl/cxl_device.h |  61 ++-
 include/hw/cxl/cxl_events.h |  18 +
 qapi/cxl.json               |  93 ++++-
 6 files changed, 1558 insertions(+), 46 deletions(-)

-- 
2.43.0

