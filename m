Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EC584FD8
	for <linux-cxl@vger.kernel.org>; Wed, 21 Feb 2024 18:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708539673; cv=none; b=AeU2Xi4G/S23VPVxuW4Svcbyzg8hzEM4X21W8hf/fHu5PINsOtqXBgzqHWowzgYfna4OzsL5QQVOZD86caEHs7VgfnCtKqAKGgnB6dmXb6K+WfbQ9Y/hhUZ7ziZcgT6zqml6mgfz+ApQ3D8cs5Uga33mJ6fuNqZqKUHndfMuLkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708539673; c=relaxed/simple;
	bh=8/CV3w3YjwARXJ2jrEEnKHfmeI9wI2ME48Vc+8HcCPU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aO5BQ1dSYIPc2XsrcNegh8V1aTr0sQW0g+2iRY6rlYWCWe6pa/TTklxXsodO58Spuj5UD9LXGRLjtVMm84GxzwORQ5k+GMbYUGfiYrnNV2l6r6+sIRFCem6sAruzftloFHJVPJ7K98i2O7Z8nH06Glzewjx7QBziFyfuW8lWWcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PMT5gmRh; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMT5gmRh"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-595aa5b1fe0so4541744eaf.2
        for <linux-cxl@vger.kernel.org>; Wed, 21 Feb 2024 10:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708539671; x=1709144471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rF+lzU6VXn8MzeIYj12jMaidQDet+Jk/8usd9xFeU4E=;
        b=PMT5gmRhZhRy3+ksINj9V4A4qnAKbv6zUVdFhYn0pJhsBM2YjMI6iSaSqoA/f3h4JU
         NPrekJ0rBQATn43S+IDQ4UC9Sk6V8IrzfrjDKyasQXqHrcN+h+N0nKeNxK1dCj2fIj3T
         KOiGc6n9eHSutPeZ88sT22RajlzhGL2raQARWrdVIF/HovzgOSzeKC8H+YRQwP8uCtET
         eo7isBYLxwPxJgGBiOUVd9UBS05Opw1lxj44TVyeRmqCYMnYqG4H6DCTVlNzcMJZ9IHs
         CcONxWGTlCSHw7CmY+RYZQLrPrtjqH9hKx0ycuijvX8qv9CtNjNzsype5M3H7Cf1xcty
         po/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708539671; x=1709144471;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rF+lzU6VXn8MzeIYj12jMaidQDet+Jk/8usd9xFeU4E=;
        b=VuF7TXHyM5d7xzOA18OAAVSBo+OLw4flLZxQ1wLUyhVGw/Ns9XjjA6JpqI6mq2DbOb
         9F9OJVGLqi82UwD3ymrSiYIYbvDgLyb+XvpuxhISmFd+aDWXnnLUCmK5S7T4ROGiPyXI
         eVLimZqqdVbjONHpY4bYoLyhyIpZeK6rxd27DOVCbBmhMooxVU0hNBQITF6KjRGoAw6M
         E+viDxCEZ2ft8hlfQIFKl4ayqsnKJMYbvbaCDxPWLYeUJTdQIeSm50/JdJkZmRghWpeX
         4d1buWKchjWCTTeN8blXw+kMt3PxzQYehd0tlli5Vseu0G7BIQw3L8mvkqQAtx2fgF3L
         WRbA==
X-Forwarded-Encrypted: i=1; AJvYcCWyCvA2RONeg6hHcuibglk2gtUj28WdGMFjd1zSCNvyDydQ6LVao2l1PyZOQxNuT4vks6W1bsDFWEW+l6t2KKQlIKdiu6ivSafe
X-Gm-Message-State: AOJu0Yz5PGETzP4VwelF+SW9d/2W58SNpMSK1TkrMGG8kAVpizXce5xY
	9InKH59WUTZoiARhYg79e61r/Ir0Edb6YX7xkZclidwilWUhnGyx
X-Google-Smtp-Source: AGHT+IEeZFxdjaqyZAi2dnWva5Y087szRR+YGolJKt82BgzIVoI5c1BjJh3XQtisJrtTNdd4YlBcJA==
X-Received: by 2002:a05:6358:65a7:b0:17b:57f3:3b9 with SMTP id x39-20020a05635865a700b0017b57f303b9mr3776609rwh.14.1708539670465;
        Wed, 21 Feb 2024 10:21:10 -0800 (PST)
Received: from localhost.localdomain ([2601:641:300:14de:5692:7e41:13a2:69a])
        by smtp.gmail.com with ESMTPSA id cs16-20020a17090af51000b002992f49922csm9979009pjb.25.2024.02.21.10.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 10:21:10 -0800 (PST)
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
	Fan Ni <fan.ni@samsung.com>
Subject: [PATCH v4 00/10] Enabling DCD emulation support in Qemu
Date: Wed, 21 Feb 2024 10:15:53 -0800
Message-ID: <20240221182020.1086096-1-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fan Ni <fan.ni@samsung.com>

v3[1]->v4: 

The code is rebased on mainstream QEMU with the following patch series:

hw/cxl/mailbox: change CCI cmd set structure to be a member, not a reference
hw/cxl/mailbox: interface to add CCI commands to an existing CCI

Main changes include:

1. Updated the specification references to align with cxl spec r3.1.
2. Add extra elements to get dc region configuration output payload and
procecced accordingly in mailbox command 4800h.
3. Removed the unwanted space.
4. Refactored ct3_build_cdat_entries_for_mr and extract it as a separate patch.
5. Updated cxl_create_dc_regions function to derive region len from host
backend size.
6. Changed the logic for creating DC regions when host backend and address
space processing is introduced, now cxl_create_dc_regions is called only
when host backend exists.
7. Updated the name of the definitions related to DC extents for consistency.
7. Updated dynamic capacity event record definition to align with spec r3.1.
9. Changed the dynamic capacity request process logic, for release request,
extra checks are done against the pending list to remove the extent yet added.
10. Changed the return value of cxl_create_dc_regions so the return can be used
to Remove the extent for the list if needed.
11. offset and size in the qmp interface are changed to be byte-wise while the
original is MiB-wise.
12. Fixed bugs in handling bitmap for dpa range existence.
13. NOTE: in previous version DC is set to non-volatile, while in this version
we change it to volatile per Jonathan's suggestion.
14. Updated the doc in qapi/cxl.json.

Thank Jonathan for the detailed review of the last version[1].

The code is tested with Ira's last kernel DCD patch set [2] with some minor
bug fixes[3]. Tested operations include:
1. create DC region;
2. Add/release DC extents;
3. convert DC capacity into system RAM (no real read/write to DCD tested);


v3: 
[1] https://lore.kernel.org/linux-cxl/20231107180907.553451-1-nifan.cxl@gmail.com/T/#t
[2] https://github.com/weiny2/linux-kernel/tree/dcd-v3-2023-10-30
[3] https://github.com/moking/linux-dcd/commit/9d24fa6e5d39f934623220953caecc080f93e964

Fan Ni (10):
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

 hw/cxl/cxl-mailbox-utils.c  | 507 +++++++++++++++++++++++++++++++-
 hw/mem/cxl_type3.c          | 559 +++++++++++++++++++++++++++++++++---
 hw/mem/cxl_type3_stubs.c    |  14 +
 include/hw/cxl/cxl_device.h |  61 +++-
 include/hw/cxl/cxl_events.h |  18 ++
 qapi/cxl.json               |  61 +++-
 6 files changed, 1174 insertions(+), 46 deletions(-)

-- 
2.43.0

