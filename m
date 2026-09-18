Received: from mail-yx2-f40.google.com (mail-yx2-f40.google.com [74.125.224.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBC94B2CC1
	for <linux-cxl@vger.kernel.org>; Fri, 18 Sep 2026 20:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789763484; cv=none; b=VIpds8MmsGEeM4c0t3py6Jc6WVzlcN8TUd4afTqNaUPMk7PuB3pYt7/71q5Z9x8M1eAxzoGB+uITzTNfWRamjq4J92X+mtqZz0606NQSbAjvwn43weDMmktX/r5Nr1Fgo2CdZqxn1c5qbeZPH8xpsGA3dK6T0Xwqz2lls6HXX2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789763484; c=relaxed/simple;
	bh=FVfF7eyyYHmTLrDdWiUkROoH0hOGPxG2rtI9sQydSj0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IpifOeGW30akjBQ7tSKJyTYt2pf87bhow8YfmZr575FGq1ht60yBMYFMOjpA3z5k0WgLKr2YyMx21MWEKiQLd+WyUWICiPX6hkmkTLMsQsZg4SZpTqgwG+zcJD+S5x1DhAqttj9DMaGLgfPr4mOWwl60yedCIEgz5unipwRCSbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UetJOfvT; arc=none smtp.client-ip=74.125.224.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UetJOfvT"
Received: by mail-yx2-f40.google.com with SMTP id 956f58d0204a3-66e4aa8d881so1331553d50.1
        for <linux-cxl@vger.kernel.org>; Fri, 18 Sep 2026 13:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789763482; x=1790368282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QA2M7HL67nwdh3oyVRAR92DnNn2znpflWpr2FV6wdvg=;
        b=UetJOfvTF5EWlN/pcxt5Ocz/5Ga72pWKCKeeF3NHT6vC0YOousZKhl0B/CVrdFQNUM
         f9ss60r6t0FRXycOHlTpj7lS7SVwc8Kv8GtG7Wpc597bb3GR9/pwOVtgmH+7nVLVcWZv
         ZuyM2xb656nyjeq6MBp68jqoVxpgKTQrVRim+g/SyO4kVaemsjnPABlPNnyZGLUxZeGG
         6V4b8IIwTIqL8R/aSp6BHGjaAGEyU10Zv6u3jK8yTY6TC7jmABtNSMM8KwzIx2fbY+hp
         AV11BqkfZq6fL0W0QaV4+MRx51pAQfjtlCS7Lr40ot/BJjmyMLcL4o9YVChrAb7zYBbT
         tAaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789763482; x=1790368282;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QA2M7HL67nwdh3oyVRAR92DnNn2znpflWpr2FV6wdvg=;
        b=Pa0gv6m4SKYea2evn0C9qRGAfN+052UJYmfiBWg30ib+iPKn/2RvsPCVPTvIJxoftq
         XT5+I/gQ8IVHUHsfjXCikMP70VL0MPEJ1Izbwk+bwdaERwZF6y9OTcQe8UoKL7IBmy2e
         qP+YzrUSXtTwZba/Ax+/t0S0zInf/B+3UREbSFczNs6MOf9GC805M9xo4KDMMKhqkJmD
         uMwSDvdobAXtsHHBN2xtbQlWB+0DLlD/NGeKhZOvTENzR2h0VIHYQK2N1V0UEhlXHgkj
         BAo0EDoEnjIhdXrjpvAwxR1jtY1T4EyfvH01qCEuO7gxKxGHK83eQ02r+uZn5bB8WlqY
         xuHA==
X-Gm-Message-State: AFuF++mhOrwkiVxRjT52ayGUSDKi5Pz5d/wy90dCaEg7syuqau8Kt+bb
	YDHhdX57+6WQHKbLrNHx1GEuxhXvMRcY4FUEhxUPF1wr4TDMqqzcRtyZx9CUIg==
X-Gm-Gg: AYBFou0guLThMR3oxNK+gkYcc5bxmPqUTpUpsYqCM4+BcrUFPicQ9XyEolxjch4XDFW
	i7ZCdEiRElNqHi1rzYoeO4D4zxhc4Wf2nK5IpvbLbZGoqYT1wdmz7NVabRsYlUH7c3U3NHeEVh+
	+OXTCZToMAFXeAgUpYl18/fSlh7vmtbBsybOZD0zfailk+L8MQME+ahQ/oJpmIn9P6uQl3kN8z2
	tyW/tIqfPgPIyWhlcd7LJhH7o6LRqBfB7BowSDSgTHJT/ZCevALrWCX/sXrst7sIqlVUro6jnPd
	G6MbF/0Hiepg3zLKMSfzBsuq7n5e1UGRF/nM69oIwgi/uv0d3YqXdJ9x4BdyLQBWkkx5MtOKpjk
	0O0tfI580JIW24DtRyT2ihsy76ebUA2W4syBiovPMlZCy60arekmzFSqdOBnuwNpZ4BLQuGdJAu
	yd4zRrdq93yM/XpJ8syGWBuCLeAXXAwbg6udjaAONUwzBuqr3jzPVv+nAV03cnbKbYUDJ5HDrtr
	cyhkTAljo10yYeoPW/0NLrArDIpiM524R5bK+vcPad1uIuGyA==
X-Received: by 2002:a05:690e:1697:b0:671:282d:6b15 with SMTP id 956f58d0204a3-6717fcb2a9fmr1606864d50.33.1789763481831;
        Fri, 18 Sep 2026 13:31:21 -0700 (PDT)
Received: from 4470NRD-ASU.ssi.samsung.com ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67298f64b74sm427240d50.1.2026.09.18.13.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 13:31:21 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
To: linux-cxl@vger.kernel.org
Cc: Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Li Ming <ming.li@zohomail.com>,
	Gregory Price <gourry@gourry.net>,
	Richard Cheng <icheng@nvidia.com>,
	Ben Cheatham <benjamin.cheatham@amd.com>,
	Anisa Su <anisa.su@samsung.com>
Subject: [PATCH v14 0/8] DCD Prep Series
Date: Fri, 18 Sep 2026 13:30:09 -0700
Message-ID: <20260918203049.7273-1-anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These are the first eight patches of the Dynamic Capacity Device (DCD)
series. They set up: DCD enumeration, CDAT handling for DC partitions,
the event interrupt plumbing, a preparatory refactor, and
documentation of the DPA partition layout. They stand alone and keep DCD
disabled, and are not dependent on the rest of the series.

Patch 1 detects the 48h command set and then leaves mds->dcd_supported
false. The flag is only turned on by the series that adds DCD event
handling, so every DCD specific path added here is shut off at runtime:
cxl_configure_dcd() never runs, no DC partition is created, no DCD
interrupt is armed, and the CXL_PARTMODE_DYNAMIC_RAM_1 paths are
unreachable. The intent is to land the enumeration and plumbing while
the extent to DAX pipeline is still under review.

Based on v7.3-rc3

GitHub Branch:
https://github.com/anisa-su993/anisa-linux-kernel/tree/dcd-prep-v14

v13: https://lore.kernel.org/linux-cxl/20260908102124.2231730-2-anisa.su@samsung.com/T/#m5b414fa4a1ae0bf26421e2a38a668c43e1aec1fb
v12: https://lore.kernel.org/linux-cxl/20260731084901.1512819-1-anisa.su@samsung.com/

Patch organization
==================
 1-3: enumerate DCD command support, read the DC configuration, and pick
      up DSMAS data for DC partitions.
 4-6: split event msgnum configuration from irq setup, factor out the
      interrupt policy check, then configure the DCD event interrupt.
   7: preparatory refactor -- enforce partition order while collapsing
      the ram/pmem specific partition helpers into one.
   8: document the DPA partition layout the previous patches enforce,
      and where Linux is stricter than the specification.

v13 -> v14 Changes:
===================
 - Patch 1: cxl/mbox: Flag support for Dynamic Capacity Devices (DCD)
        - No code change. Tags only.

 - Patch 2: cxl/mem: Read dynamic capacity configuration from the device
        - Don't disable DCD when the device reports more than
          CXL_MAX_DC_PARTITIONS. Today's spec allows 1 to 8, but a later
          revision may allow more. Read only the first 8 and only configure
	  partition 0. (Jonathan)
        - Reject a decode length that overflows when scaled by
          CXL_CAPACITY_MULTIPLIER. Decode length is a count of 256M
          units, so a device reporting 2^36 or more wraps and result in
          a plausible looking partition size instead of an error
          (Richard).
        - Reject a DC partition size that overflows the DPA total in
          cxl_configure_dcd(). The wrapped total read as zero capacity,
          which cxl_dpa_setup() accepts silently, so the device
          enumerated with no DPA and no error (Richard).
        - Commit message: CXL r4.0 9.13.3 describes Get DC
          Configuration as the way to obtain partition characteristics
          rather than "require" it for set up; the single partition limit is
          stated as initial enablement (Jonathan)
        - Use min() instead of min_t() for calculating partition_count (Jonathan).
	- Check media_ready at the start of cxl_configure_dcd();
	  don't configure DC partition 0 if the media is not ready (Claude /kreview) 

 - Patch 3: cxl/cdat: Gather DSMAS data for DCD partitions
        - Record the DSMAS shareable flag independently of QOS
	  discovery. cxl_port_perf_data_calculate() returns -ENOENT when
          firmware recommends no QTG for any entry, so the early return
          on that skipped assigning the shareable flag even though the
	  the CDAT was successfully parsed. (Richard).

 - Patch 4: cxl/events: Split event msgnum configuration from irq setup
        - No code change. Tags only.

 - Patch 5: cxl/pci: Factor out interrupt policy check
        - No code change. Tags only.

 - Patch 6: cxl/mem: Configure dynamic capacity interrupts
        - Drop CXLDEV_EVENT_STATUS_ALL and instead opt into
	  each event log explicitly, especially because more log types
	  may be added in the future (Jonathan).
	- Return early from cxl_event_config() if DCD is disabled and
	  BIOS owns the other logs. Nothing is left to configure, so
	  return early (Claude /kreview)

 - Patch 7: cxl/core: Enforce partition order/simplify partition calls
        - No code change. Tags only.

 - Patch 8: Documentation/cxl: Document DPA partition layout and
   ordering rules
        - Drop the paragraph saying support for additional DC partitions
          may be added later; documentation should not predict future
          work. (Jonathan / Davidlohr).
        - Break the DCD entry in maturity-map.rst into sub-items so
          multi-step upstreaming shows what is there and sets
          expectations: partition enumeration / configuration is [1],
          extent add / release handling and DC-backed DAX regions stay
          [0], and the parent stays [0] because nothing is usable until
          dcd_supported is turned on (Davidlohr).

Review status
=============
- Dropped Alison's Tested-by tags, since the NDCTL regression testing
was ran against v13

Patch 2:
+ Alison's Reviewed-by tag on v13, but I added a check for media_ready
at the top of cxl_configure_dcd() before configuring DC partition 0

Please let me know if you would rather re-review!

Patch 6: + Reviewed-by Jonathan, Alison.

Besides the change requested by Jonathan (drop CXL_EVENT_STATUS_ALL),
I also added an early return in cxl_event_config() on BIOS-first
platforms once DCD has been disabled. I kept the tags, but please
let me know if both of you would rather re-review.

Testing
=======

On HW:
This series leaves mds->dcd_supported false on purpose, so
cxl_configure_dcd(), cxl_dev_dc_identify() and cxl_dc_check() are
unreachable at runtime as posted. So the test below is done with the rest
of the series on top, otherwise the results would not be very meaningful.

Tested by Wonjae Lee/Junhee Park/Heesoo Kim whose tested-by tags are
carried over to this revision.

Since this is the prep patch, we just tested adding and removing 1 extent
(2GB, tag=5be13bce-ae34-4a77-b6c3-16df975fcf1a) to verify that the
partition and interrupts are configured correctly.

--- Add ---
[14181.811999] cxl_pci 0000:b8:00.0: Reading event logs: 10
[14181.812040] cxl_pci 0000:b8:00.0: Sending command: 0x0100
[14181.812077] cxl_pci 0000:b8:00.0: Doorbell wait took 0ms
[14181.812121] cxl_pci 0000:b8:00.0: DCD event add : DPA:0x0 LEN:0x80000000
[14181.812133] cxl_pci 0000:b8:00.0: DC extent DPA [range 0x0000000000000000-0x000000007fffffff] (DCR:[range 0x0000000000000000-0x0000001fffffffff])(5be13bce-ae34-4a77-b6c3-16df975fcf1a)
[14181.812146] cxl_pci 0000:b8:00.0: DC extent DPA [range 0x0000000000000000-0x000000007fffffff] (DCR:[range 0x0000000000000000-0x0000001fffffffff])(5be13bce-ae34-4a77-b6c3-16df975fcf1a)
[14181.812152] cxl_pci 0000:b8:00.0: DC extent DPA [range 0x0000000000000000-0x000000007fffffff] (DCR:[range 0x0000000000000000-0x0000001fffffffff])(5be13bce-ae34-4a77-b6c3-16df975fcf1a)
[14181.812162] cxl decoder9.0: dpa:0x0 mapped in region:region9
[14181.812201] cxl decoder9.0: Add extent [range 0x0000000000000000-0x000000007fffffff] (5be13bce-ae34-4a77-b6c3-16df975fcf1a)
[14181.812208] cxl_dax_region dax_region9: Alloc new tag group
[14181.812257]  extent9.1: dc_extent HPA [range 0x0000000000000000-0x000000007fffffff] (5be13bce-ae34-4a77-b6c3-16df975fcf1a)
[14181.812265] cxl_dax_region dax_region9: Trying notify: type 0 tag 5be13bce-ae34-4a77-b6c3-16df975fcf1a
[14181.812270] cxl_dax_region dax_region9: Notify: type 0 tag 5be13bce-ae34-4a77-b6c3-16df975fcf1a
[14181.812299] cxl_pci 0000:b8:00.0: Sending command: 0x4802
[14181.812473] cxl_pci 0000:b8:00.0: Doorbell wait took 0ms
[14181.812482] cxl_pci 0000:b8:00.0: Event log '4': Clearing 1
[14181.812488] cxl_pci 0000:b8:00.0: Sending command: 0x0101
[14181.812514] cxl_pci 0000:b8:00.0: Doorbell wait took 0ms
[14181.812520] cxl_pci 0000:b8:00.0: Sending command: 0x0100
[14181.812550] cxl_pci 0000:b8:00.0: Doorbell wait took 0ms

--- Release -- 
[14291.325683] cxl_pci 0000:b8:00.0: Reading event logs: 10
[14291.325701] cxl_pci 0000:b8:00.0: Sending command: 0x0100
[14291.325737] cxl_pci 0000:b8:00.0: Doorbell wait took 0ms
[14291.325820] cxl_pci 0000:b8:00.0: DCD event release : DPA:0x0 LEN:0x80000000
[14291.325833] cxl decoder9.0: dpa:0x0 mapped in region:region9
[14291.444166] cxl_dax_region dax_region9: Trying notify: type 1 tag 5be13bce-ae34-4a77-b6c3-16df975fcf1a
[14291.444175] cxl_dax_region dax_region9: Notify: type 1 tag 5be13bce-ae34-4a77-b6c3-16df975fcf1a
[14291.444203]  extent9.1: DAX region rm extent HPA [range 0x0000000000000000-0x000000007fffffff]
[14291.444238] cxl decoder9.0: Remove extent [range 0x0000000000000000-0x000000007fffffff] (5be13bce-ae34-4a77-b6c3-16df975fcf1a)
[14291.444242] cxl_pci 0000:b8:00.0: Release response dpa [range 0x0000000000000000-0x000000007fffffff]
[14291.444258] cxl_pci 0000:b8:00.0: Sending command: 0x4803
[14291.444448] cxl_pci 0000:b8:00.0: Doorbell wait took 0ms
[14291.444471] cxl_pci 0000:b8:00.0: Event log '4': Clearing 3
[14291.444474] cxl_pci 0000:b8:00.0: Sending command: 0x0101
[14291.444497] cxl_pci 0000:b8:00.0: Doorbell wait took 0ms
[14291.444500] cxl_pci 0000:b8:00.0: Sending command: 0x0100
[14291.444523] cxl_pci 0000:b8:00.0: Doorbell wait took 0ms

cxl_test:
Ran cxl_test ndctl/pending for regression testing:
https://github.com/anisa-su993/ndctl-test-runner/actions/runs/35388628475/job/105741489718

18/18 Ok

QEMU:
Additional testing is done on QEMU for catching various cases that would not
occur on the hardware because of configuration differences.

The tool used automatically starts various topos using a QEMU branch
I modified to allow certain bad inputs for testing:
https://github.com/anisa-su993/cxl-tests/blob/main/dcd/run-all.sh

1. Eight DC partitions, only the first is used
-----------------------------------------------
2G ram + 512M pmem static, so static capacity ends at 0xa0000000, and
eight 512M DC partitions above it. Five partition records fit in one
reply on the 256 byte mailbox, so the read continues from partition 5
in a second command. This also tests that the loop to Get DC Region Info
works.

  cxl_pci 0000:0d:00.0: Read 5/8 DC partitions
  cxl_pci 0000:0d:00.0: DC partition 0 start 0xa0000000 size 0x20000000 blk_size: 0x200000
  cxl_pci 0000:0d:00.0: Read 3/8 DC partitions
  cxl_pci 0000:0d:00.0: Adding dynamic ram partition 1; 0xa0000000 size 0x20000000
  cxl_pci 0000:0d:00.0: DPA(ram): [mem 0x00000000-0x7fffffff flags 0x200]
  cxl_pci 0000:0d:00.0: DPA(pmem): [mem 0x80000000-0x9fffffff flags 0x200]
  cxl_pci 0000:0d:00.0: DPA(dynamic_ram_1): [mem 0xa0000000-0xbfffffff flags 0x200]

All eight partitions are read, but only the first is validated and set up for use.

2. Block size/decode len/DSMAD handle validation
-------------------------------------------------
1 DC Partition.
Fuzz QEMU to respond to Get DC Configuration with a bad block size /
decode length / partition base/ DSMAD handle / # of partitions and
look for the corresponding dev_err message:

  block size 0x100000040    DC partition 0 invalid block size 0x100000040
  decode length 0           DC partition 0 zero decode length
  decode length 2^36        DC partition 0 decode length 0x1000000000 overflows
  base 0xa0001000           DC partition 0 base 0xa0001000 not aligned to 256M
  base 0x90000000           DC partition 0 base 0x90000000 overlaps static capacity ending at 0xa0000000
  base 0xb0000000           DC partition 0 base 0xb0000000 leaves a gap from static capacity ending at 0xa0000000
  DSMAD handle 0x100        DSMAD handle 0x100 exceeds the 8 bit CDAT DSMAD handle
  0 partitions available    Device reported no DC partitions

Anisa Su (1):
  Documentation/cxl: Document DPA partition layout and ordering rules

Ira Weiny (7):
  cxl/mbox: Flag support for Dynamic Capacity Devices (DCD)
  cxl/mem: Read dynamic capacity configuration from the device
  cxl/cdat: Gather DSMAS data for DCD partitions
  cxl/events: Split event msgnum configuration from irq setup
  cxl/pci: Factor out interrupt policy check
  cxl/mem: Configure dynamic capacity interrupts
  cxl/core: Enforce partition order/simplify partition calls

 .../driver-api/cxl/linux/cxl-driver.rst       |  35 +++
 Documentation/driver-api/cxl/maturity-map.rst |   4 +
 drivers/cxl/core/cdat.c                       |  49 ++-
 drivers/cxl/core/hdm.c                        |  13 +
 drivers/cxl/core/mbox.c                       | 285 ++++++++++++++++++
 drivers/cxl/core/memdev.c                     |  95 ++++--
 drivers/cxl/cxl.h                             |   6 +-
 drivers/cxl/cxlmem.h                          |  88 +++++-
 drivers/cxl/mem.c                             |   2 +-
 drivers/cxl/pci.c                             | 162 ++++++++--
 include/cxl/cxl.h                             |  27 +-
 tools/testing/cxl/test/mem.c                  |   5 +-
 12 files changed, 684 insertions(+), 87 deletions(-)


base-commit: fd73f4a6659897191fa0d40695fe370925dd3780
-- 
2.43.0

