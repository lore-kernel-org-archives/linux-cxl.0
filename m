Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7732A2AF0F
	for <linux-cxl@vger.kernel.org>; Thu, 18 Apr 2024 23:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713482998; cv=none; b=BGK1BzfvjhSCxTPI33malZJfpVy1sWPkrDjbvXk+MRHHk0d5g1vKiJoxUqxikc7I7UOmLj1gsx9PX61+6yX3TyQhhqtmJ4lQhwJdfBxnvIWm6Qs9HYACUfBIyJ069sUR7l0qQoP10jW6WZF+VCuZ0NLaQR3xh/iVW6UUdqCOFXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713482998; c=relaxed/simple;
	bh=EuVblhXY05MaNfBwUOOSziyvcHS8Bor4nMMYg1IOEAc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=umLWdcLKYjur+fBugjl+aaoM+VT25VIgSw+Jb9BqmFD7oO2vryE8w9pksXni7waIJKmlKwgaroxwS/SVzXmgvf/GmzVAmpDuM7U6t8Jl1ZykJoMBt6JRiNV1c4DdWp8ppH/Umo23phDoEXJggx8Ku41RDc2eOLwK5QXZAFVzrZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lc+uFcoh; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lc+uFcoh"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6ead4093f85so1429075b3a.3
        for <linux-cxl@vger.kernel.org>; Thu, 18 Apr 2024 16:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713482997; x=1714087797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fur+9qbrwuD/AXrrSTEkXP81Q45FHlgNLTr+T2spM0U=;
        b=Lc+uFcohDGnAZunSjbHRc/ul4aWANe4NI1yw4rRDm3TFPjiYK6BmzaWbEkfuS6zdge
         Xx8XXz5J49i4rLa9WPqFYmHTrNIBdRjQTsBq0SPIcrWzFN3VjmXka7xcZHWcK+GXm5n5
         x99o/PgI/W7cFL2qNa1y09z3GYvqLIMuUmtXJW/vorRqpcpwu3IZmo4ZMOLp+Wf0r1BS
         X0nxO8J4PnJ7wgGXxgNihRIf/ou/GYnwNednf/FeC97Q5dpFYq7Qoab1De7Y7EXsxtGj
         cP8f0kjvGEWa//gdoIOKXtyykHoW3LtbbHmsS5WejX6LzgRkQ2K5R6Bad0V3ZdSsPPtE
         2U8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713482997; x=1714087797;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fur+9qbrwuD/AXrrSTEkXP81Q45FHlgNLTr+T2spM0U=;
        b=uHfZvdmYVfUjJgFHc6z6UtylARn4cKPDxxH/3aNDk43zkgiAPjKVuiHDBgGIf40AR/
         e09OTYFFtRgLjQrowTz+zfXQ7g9QnYIdTSPHKt4SUr8bBYQPRDh3uhl4p1F4pwrudsu0
         ITbZVPXLXXeISswj3I5jmhgQkccjZpYCM052M2pOSqybsTsCmGwf3LzkfIfcPESfu8TV
         PEuPrwLQTY6tBcpRR2RIN1gLZJjLV9tqysHNDFGVsUdbBFECcq+HaqJz7ZwBYbtkrA5J
         EIt2wOXLiaCQdeDk6IRs/q7js3FtufKYZP/s+9wM7MGYrZKrl7vSgO4/yLI0I79l76Pv
         DwJA==
X-Forwarded-Encrypted: i=1; AJvYcCWEm5UURkYrmR3YkpGrHlkYvGYVSW/NAYBq2Wlhl/FWjyuHDUJjBSo7MogBibtKjuuweSoRr5YjeiNR0DP+iRn6/APPUpkf+kLg
X-Gm-Message-State: AOJu0YyikA9b0YZIMdvafZZsdx3Ha/4584dpGQ1ZnE+/M/mz8RyvTk7g
	ZRw93fuLgNecyi4GYmY76vzR8XADOljmkneJW5mCF8wC5t03HYlV
X-Google-Smtp-Source: AGHT+IEgYQfnOBvaScWVexAIMCNZgj8gRr1kAslt0+joKr9lAHw+kk3EANga3PIAHl9mvsXoBsg5Qg==
X-Received: by 2002:a05:6a00:6616:b0:6ed:d5f5:85e with SMTP id he22-20020a056a00661600b006edd5f5085emr565285pfb.3.1713482996762;
        Thu, 18 Apr 2024 16:29:56 -0700 (PDT)
Received: from localhost.localdomain ([2601:641:300:14de:ed8b:f40f:7543:e9ea])
        by smtp.gmail.com with ESMTPSA id h3-20020a056a00230300b006e6be006637sm2040783pfh.135.2024.04.18.16.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 16:29:56 -0700 (PDT)
From: nifan.cxl@gmail.com
X-Google-Original-From: fan.ni@samsung.com
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
	fan.ni@samsung.com
Subject: [PATCH v7 00/12] Enabling DCD emulation support in Qemu
Date: Thu, 18 Apr 2024 16:10:51 -0700
Message-ID: <20240418232902.583744-1-fan.ni@samsung.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A git tree of this series can be found here (with one extra commit on top
for printing out accepted/pending extent list): 
https://github.com/moking/qemu/tree/dcd-v7

v6->v7:

1. Fixed the dvsec range register issue mentioned in the the cover letter in v6.
   Only relevant bits are set to mark the device ready (Patch 6). (Jonathan)
2. Moved the if statement in cxl_setup_memory from Patch 6 to Patch 4. (Jonathan)
3. Used MIN instead of if statement to get record_count in Patch 7. (Jonathan)
4. Added "Reviewed-by" tag to Patch 7.
5. Modified cxl_dc_extent_release_dry_run so the updated extent list can be
   reused in cmd_dcd_release_dyn_cap to simplify the process in Patch 8. (Jørgen) 
6. Added comments to indicate further "TODO" items in cmd_dcd_add_dyn_cap_rsp.
    (Jonathan)
7. Avoided irrelevant code reformat in Patch 8. (Jonathan)
8. Modified QMP interfaces for adding/releasing DC extents to allow passing
   tags, selection policy, flags in the interface. (Jonathan, Gregory)
9. Redesigned the pending list so extents in the same requests are grouped
    together. A new data structure is introduced to represent "extent group"
    in pending list.  (Jonathan)
10. Added support in QMP interface for "More" flag. 
11. Check "Forced removal" flag for release request and not let it pass through.
12. Removed the dynamic capacity log type from CxlEventLog definition in cxl.json
   to avoid the side effect it may introduce to inject error to DC event log.
   (Jonathan)
13. Hard coded the event log type to dynamic capacity event log in QMP
    interfaces. (Jonathan)
14. Adding space in between "-1]". (Jonathan)
15. Some minor comment fixes.

The code is tested with similar setup and has passed similar tests as listed
in the cover letter of v5[1] and v6[2].
Also, the code is tested with the latest DCD kernel patchset[3].

[1] Qemu DCD patchset v5: https://lore.kernel.org/linux-cxl/20240304194331.1586191-1-nifan.cxl@gmail.com/T/#t
[2] Qemu DCD patchset v6: https://lore.kernel.org/linux-cxl/20240325190339.696686-1-nifan.cxl@gmail.com/T/#t
[3] DCD kernel patches: https://lore.kernel.org/linux-cxl/20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com/T/#m11c571e21c4fe17c7d04ec5c2c7bc7cbf2cd07e3


Fan Ni (12):
  hw/cxl/cxl-mailbox-utils: Add dc_event_log_size field to output
    payload of identify memory device command
  hw/cxl/cxl-mailbox-utils: Add dynamic capacity region representative
    and mailbox command support
  include/hw/cxl/cxl_device: Rename mem_size as static_mem_size for
    type3 memory devices
  hw/mem/cxl_type3: Add support to create DC regions to type3 memory
    devices
  hw/mem/cxl-type3: Refactor ct3_build_cdat_entries_for_mr to take mr
    size instead of mr as argument
  hw/mem/cxl_type3: Add host backend and address space handling for DC
    regions
  hw/mem/cxl_type3: Add DC extent list representative and get DC extent
    list mailbox support
  hw/cxl/cxl-mailbox-utils: Add mailbox commands to support add/release
    dynamic capacity response
  hw/cxl/events: Add qmp interfaces to add/release dynamic capacity
    extents
  hw/mem/cxl_type3: Add DPA range validation for accesses to DC regions
  hw/cxl/cxl-mailbox-utils: Add superset extent release mailbox support
  hw/mem/cxl_type3: Allow to release extent superset in QMP interface

 hw/cxl/cxl-mailbox-utils.c  | 620 ++++++++++++++++++++++++++++++++++-
 hw/mem/cxl_type3.c          | 633 +++++++++++++++++++++++++++++++++---
 hw/mem/cxl_type3_stubs.c    |  20 ++
 include/hw/cxl/cxl_device.h |  81 ++++-
 include/hw/cxl/cxl_events.h |  18 +
 qapi/cxl.json               |  69 ++++
 6 files changed, 1396 insertions(+), 45 deletions(-)

-- 
2.43.0

