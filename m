Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B6F1C02
	for <linux-cxl@vger.kernel.org>; Mon, 25 Mar 2024 19:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711393461; cv=none; b=DITEnPfukBHr5R2e+zDiKcDbG/C0kzaQhWjqQranEO9GAP01eN+hk+ZfpN7AY9RZqs28dgxOnk/sZaLhZzZjoR05IS7UHP6aZUY3ye/vVj5GeU+WnS9NRftogvB5ErlGT9Hxngzt2S3dC3LGVhIUtN2PYcr/E6XiUrwxt58evkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711393461; c=relaxed/simple;
	bh=Im+v4K+bqKkx0QUfX/CUyETsYPzlHMZk2eS398RcF+4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vdi81b/Lic2tqqRrqNsgfH5T/l9TCWFUfWP5CddVcSrLtIZmEdwsFlzfrE9WkGG1uBrvbcZGF+w0UPkJhhydcvRlHTXe96EUDAE1Rb1jicU5+3DrJCv3RFYIols6+cmaP+/2LQZAWFFy10IrGPP60zDeYUyC5PXPXjnj4Qd36X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=krXG60Hs; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="krXG60Hs"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e74aa08d15so3174258b3a.1
        for <linux-cxl@vger.kernel.org>; Mon, 25 Mar 2024 12:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711393459; x=1711998259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y5Zto9K7udTq5AQPakgTtPCJCOiPmQtEfYiG7fTXVFs=;
        b=krXG60HsW91alVMbwFn4bfxdrgE2auPf1O/454jQkj23DUBzZKO6g146f3g6YOed46
         i475qznY4slIS6Z9RIIU5nccWBqibI8pmcAc6YfahUuPB5Ld3r+P/faVkgFuR6hXvKlT
         kV9Eo4sHMXhrkK9QsgyIBTEJzNIGZkWi+aNTkrXCrwh4ivLSY94YDLyYHP3irGybGxPB
         KY0axBYnIyqNdCQ8xtgtGNmyp+jJ69l79qy+MWCUgSVFQLpWs4klHa6ttplllMoUfvMk
         2YaeHECfFtES+C8zBrDKK/NIBMvHrcViNde05lX7ouY8Am7Tav4SqZnRy1xTaJHtw+29
         f8WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711393459; x=1711998259;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y5Zto9K7udTq5AQPakgTtPCJCOiPmQtEfYiG7fTXVFs=;
        b=kQL/TUA2nJSO/CUfFFOIjlSg7dIndD32XHXEPYwJy4/cYjsXuW1hqtwLIJ34XbqfNC
         hpiOlpLCqh3TlBh4i5GppOrmhFlw8gSWJJX1abyIGZl7TYH5biIKyALe/XrefcUiqzXT
         Wvfwk+qvT69aSUmpjG3nQRreM52VJYSxv5fARAKQYVC7/cnlEMv091X6EcJLdPc2Rsfq
         o1qdfjm8RSZX02AbP+m7aIUi3qyOWfUeiu1t9++Lf2nqPmQyQsCJaeD54hAfwM+ALHpG
         5ZE/tdvt6wS789Y8d8MWCLKTczWbHSKmsu4C3l+Xxa0AMlJqEvKSd/3p/bfMBJEJCSvM
         cW6g==
X-Forwarded-Encrypted: i=1; AJvYcCXmJCBFQfItEZmvf+zbhFEhDBWvSmcP9aPpjeOM0OKincz99pvSNG5phvt9dKsY9nOSK29DQuQyrForUnj/oaIDR5sgf8hxmXBm
X-Gm-Message-State: AOJu0YyghOpqaaKmcm5CgA0uAK+cr3JTCvjNyX/BjSHidP2vQZ2ojeHM
	QLvu86kmR+ugugwAXC8a1QygaNkIsNaGd3Moc+0gzZ2SLMUVuW/R
X-Google-Smtp-Source: AGHT+IGZShujGwOKxQ+nptAm5/rMbK7nM5xmkrnfnyDFXq5KsYB7EKXYKiCNBZkCJq9HAY7FI/XqIw==
X-Received: by 2002:a05:6a20:9147:b0:1a3:bdd6:efef with SMTP id x7-20020a056a20914700b001a3bdd6efefmr7683199pzc.50.1711393458627;
        Mon, 25 Mar 2024 12:04:18 -0700 (PDT)
Received: from localhost.localdomain ([2601:641:300:14de:7bed:2ef:bead:18b])
        by smtp.gmail.com with ESMTPSA id z7-20020a634c07000000b005f05c9ee8d3sm1722663pga.93.2024.03.25.12.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 12:04:18 -0700 (PDT)
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
Subject: [PATCH v6 00/12] Enabling DCD emulation support in Qemu
Date: Mon, 25 Mar 2024 12:02:18 -0700
Message-ID: <20240325190339.696686-1-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fan Ni <fan.ni@samsung.com>

A git tree of his series can be found here (with one extra commit on top
for printing out accepted/pending extent list): 
https://github.com/moking/qemu/tree/dcd-v6

v5->v6:
1. Picked up tags;
2. Renamed start_region_id to start_rid; (Jonathan)
3. For get extent list mailbox command, add logic to adjust returned extent
   count based on output payload size; (Jonathan)
4. Use Range to detect extent comparison and overlaps; (Jonathan)
5. Renamed extents_pending_to_add to extents_pending; (Jonathan)
6. Updated the commit log of the qmp interface patch by renaming "dpa" to offset
    to align with the code. (Gregory)
7. For DC extent add response and release mailbox command, we use a 2 pass
   approach. The first pass is to detect any potential errors, and the second
   pass to update the in-device data structure;
8. For QMP interface for add/release DC extents, use 2 pass approach with the
   first pass detecting any faulty input and second pass filling the event log.
   Note, based on sswg discussion, we disallow release extents which has DPA
   range not accepted by the host yet;
9. We enforce the in-order process of the pending list for DC extent release
   mailbox command, and the head of pending list is handled accordingly.
10. The last patch from v5 has been removed from this series.

Note: we do not drop the DC changes in build_dvsecs which was suggested
by Jonathan, the reason is that during testing, we found in the current
kernel code, when checking whether the media is ready
(in cxl_await_media_ready), the devsec range registers are checked, for
dcd device, if we leave dvsec range registers unset, the device cannot be
put into "ready" state, which will cause the device inactive.
The related code is below,
https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/tree/drivers/cxl/core/pci.c?h=fixes&id=d206a76d7d2726f3b096037f2079ce0bd3ba329b#n195

Compared to v5[1], PATCH 8-9 and PATCH 11-12 are almost re-coded, so need more
care when review.

The code is tested with similar setup and has passed similar tests as listed
in the cover letter of v5.
Also, the code passes similar tests with the latest DCD kernel patchset[2].

[1] Qemu DCD patches v5: https://lore.kernel.org/linux-cxl/20240304194331.1586191-1-nifan.cxl@gmail.com/T/#t
[2] DCD kernel patches: https://lore.kernel.org/linux-cxl/20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com/T/#m11c571e21c4fe17c7d04ec5c2c7bc7cbf2cd07e3



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
  hw/mem/cxl_type3: Add dpa range validation for accesses to DC regions
  hw/cxl/cxl-mailbox-utils: Add superset extent release mailbox support
  hw/mem/cxl_type3: Allow to release extent superset in QMP interface

 hw/cxl/cxl-mailbox-utils.c  | 644 +++++++++++++++++++++++++++++++++++-
 hw/mem/cxl_type3.c          | 580 +++++++++++++++++++++++++++++---
 hw/mem/cxl_type3_stubs.c    |  14 +
 include/hw/cxl/cxl_device.h |  67 +++-
 include/hw/cxl/cxl_events.h |  18 +
 qapi/cxl.json               |  61 +++-
 6 files changed, 1334 insertions(+), 50 deletions(-)

-- 
2.43.0

