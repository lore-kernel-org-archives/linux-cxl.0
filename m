Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3929B503BC9
	for <linux-cxl@vger.kernel.org>; Tue,  8 Sep 2026 09:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788859461; cv=none; b=kUrvGWGQMibhG7cft5UL/SFScd9nHYRyGNF6EzvDxTRugqpqx1Sz+UAFrkGqlG1uf9HrwBuf4yG2s1pl/QAfvuH/nhWKeIRSoSCRV116kkspLilwSR8nfHuwZycMUQlXTMioKLGuw9NkKwFXwr7UCYtnllMz+An8BplMOkrX500=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788859461; c=relaxed/simple;
	bh=HiJkVEpomco7j1jH4alXYaPsDt8YTgRSQ8SHI+SDl2s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nmL9HMF3HZoV5rk4OGZ3seSnwhIPF3NNiyEcVLm7v5jeVUbaYACgJbihJclsw0tE6dXpsCRP+03jfGDHboFg/ejEMFZDYfGtQCtHDdn/NfsclaF2gpRPDEH8HMlxqVu4sW7OP/TLV39bsWSLYIRIF/YTrikxtYptSkR1RrwmYMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jD0C5WYq; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jD0C5WYq"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so4137538a91.2
        for <linux-cxl@vger.kernel.org>; Tue, 08 Sep 2026 02:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788859459; x=1789464259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KhVoRR2as2l1Y1vZ/wmp10+yhTCcphYNfyS7YrMEo1E=;
        b=jD0C5WYqtlq+huBIcq70ArquXZttn0SWU+J04fevDa3yROx6+KFl9AqOlMhWpMJ0GF
         U8bNgk/zEY1wpuhvVmwypH/HP0jRKO1ROwVlxrwNffh70RHqeG+3TWYG24o0asPp95zv
         sexDVaf/PJHo3tX3yn+l0bKH6geayT0gguOjPPIyHzc8pIm5wjJDwJc6chNZHwp5/ZZ+
         8u2bDhL3sAGZKnqyGwVAt6Qh3gG+QJDCr68x49Fn5AAO9qD5MjwGdEWZWfXjXIfKlpD9
         L/bNSwe/AEtsVxHH3nloJvRvaymMtBYJ65ws7zkX7E80M4s6L0O73ZdMgtPthtUmLpsi
         +DZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788859459; x=1789464259;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KhVoRR2as2l1Y1vZ/wmp10+yhTCcphYNfyS7YrMEo1E=;
        b=UhWzhTGAx1R4UpYuPmkUIFoD3yl0/AiW4kQIOsIS0/tHafcHjQE1JV7Rnyb+egSgYk
         QzrfOQyPNh39CqDaOMbXEuvCL3W1q0CX/3Cr3oaZKkJB0b7fpWTNWHdgkIV4PsIaSblz
         +w98OyL9a0vdnBzrV8RVkmksJrdjI/30RvTSCF3Z1uCor5h/bihkfeGdEm2Ficgg1RBd
         uA5tG/dfTXgaRWK4HLejFK29NGbTwU+Tby7XjCt7KTk3Tz81eEEHhrJzJykDPz2CjTta
         bvE0oGz6gzRGcG7AxspIeK0RBkGturaniyql3aUrlM4QEpzqRPdFR52nCa+N6phgAjhS
         r97Q==
X-Gm-Message-State: AFuF++ls/44EAst6rQ2Ls5/dyy6Wxa2zU/pK06vGwCC7hI/ROz6I4KNk
	DX4jz8brccpjH80jLE44b6eNkSjciQIKGqYw+7KmZZ2+oMAHNMxhRbLl367RKg==
X-Gm-Gg: AYBFou3YwxderGKXAch3bl7GkNnA8DEbQWxWCyBTIo235bEx5lsx1hhQ2ARQoj7sggy
	ZfUzAEGwEB9RjAiznOqFvy6ioGNJC5fW5c3u8pCsQslY6s9G6rgZpYtcVHGla6E/nc/8miE1ekq
	TmoVN7mc49+R3YGyJZd8bUTltpMbctAJKbRqaGAqtRwkY1tXLHNLF+9y5/IfbrqYva3xmv8LiTb
	jd5TgkUWWlAHTCYLQ6OayJ0JkUBFIsKq4/F803b2JmvL6iPp2xd+0j4AkuNa9CalvOJCmI+spu4
	W2cW3EvUbGXtvkfOvfvGTuxcpAEb6lcQO2ET1y4IFqsGIlt8MBidPI6+bCh/e7eGgON//CB34e/
	fp1W55wQHzL3S27Hg/LHykX0M5zgrK8J4Aj0ZR8UKZEqOtCV2uhRVV83hd/x/H63Pij2QO8przb
	PNuc1EHuuyGOxrAQK33xsWstRBRD+XMpjL4ih0TnptFVfirbVz9iy8B9Co2r942+e42M7Z9YfA4
	oKsM6n7H3VS69MH/uX74cS+tJ25fEWbugh1UETuCYNTAWiMO/FfmjWv/CfvCRgr/LOQpioBIGNS
	RxIKE+052wo=
X-Received: by 2002:a17:90b:4984:b0:381:25ce:bcc2 with SMTP id 98e67ed59e1d1-39b26104798mr38402793a91.6.1788859459368;
        Tue, 08 Sep 2026 02:24:19 -0700 (PDT)
Received: from AnisaLaptop.localdomain (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339885ca07sm39164584eec.1.2026.09.08.02.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 02:24:18 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
To: linux-cxl@vger.kernel.org
Cc: alison.schofield@intel.com,
	jic23@kernel.org,
	dave.jiang@intel.com,
	gourry@gourry.net,
	icheng@nvidia.com,
	ming.li@zohomail.com,
	vishal.l.verma@intel.com,
	dave@stgolabs.net,
	benjamin.cheatham@amd.com
Subject: [PATCH v13 0/8] DCD Prep Series
Date: Tue,  8 Sep 2026 02:22:34 -0700
Message-ID: <20260908092417.2203965-1-anisa.su@samsung.com>
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
disabled. They are not dependent on the rest of the series.

Patch 1 detects the 48h command set and then leaves mds->dcd_supported
false. The flag is only turned on by the series that adds DCD event
handling, so every DCD specific path added here is shut off at runtime:
cxl_configure_dcd() never runs, no DC partition is created, no DCD
interrupt is armed, and the CXL_PARTMODE_DYNAMIC_RAM_1 paths are
unreachable. The intent is to land the enumeration and plumbing while
the extent to DAX pipeline is still under review.

Based on v7.3-rc2

GitHub Branch:
https://github.com/anisa-su993/anisa-linux-kernel/tree/dcd-prep-v13

v12: https://lore.kernel.org/linux-cxl/20260731084901.1512819-1-anisa.su@samsung.com/

v12 -> v13 Changes:
===================
 - Dropped: cxl/core: Return endpoint decoder information from region
        search (v12 patch 7). The new interface is not paired with its
        first caller in this series -- all three call sites pass NULL --
        so its contract cannot be reviewed here. It will be posted with
        its first user instead (Alison). v12 patch 8 is now patch 7.

 - Added: Documentation/cxl: Document DPA partition layout and ordering
        rules (patch 8) in-tree in addition to the commit messages in order
        to be explicit about places Linux is stricter than the specification.
        Add a section to cxl-driver.rst separating what the spec mandates
        for ram and pmem from what Linux chooses for dynamic capacity.
        It is documentation only.

   The series is eight patches, one dropped and one added.

 - Patch 1: cxl/mbox: Flag support for Dynamic Capacity Devices (DCD)
        - Commit message explains why mds->dcd_supported is left false
          and what turns it back on (Dave).
        - Drop the single use cxl_verify_dcd_cmds() helper and test
          bitmap_full(dcd_cmds, CXL_DCD_ENABLED_MAX) directly (Alison).

 - Patch 2: cxl/mem: Read dynamic capacity configuration from the device
        - Validate only DC partition 0. Every partition the device
          reports is still read, so the framework stays the same if we
          decide to add support for additional partitions.
          But no validation is done for the other partitions,
          so a defect in other partitions that we don't use no
          longer prevents the driver from configuring dynamic capacity
          (Richard / Alison).
        - Rework the cxl_dc_check() validation: checks now run in
          dependency order, block size first, and each failure names the
          field that is wrong instead of four conditions sharing one
          "invalid length" message (Alison).
        - Drop the block size alignment requirement on the region base.
          Table 8-347 requires 256M for the base and states the block
          size alignment for extent start DPAs, not for the base, so
          Linux was enforcing a constraint the spec does not state
          (Alison).
        - Range check the device's available partition count against the
          1 to 8 of Table 8-346, before it is used as the read loop
          bound (Alison).
        - Split cxl_configure_dcd()'s base check: an error for a DC
          partition overlapping static capacity, a warning for a gap
          above it, both printing the addresses. The old message said
          "pmem" when the comparison is against total static capacity
          (Alison).
        - cxl_configure_dcd() returns an error instead of void;
          cxl_pci_probe() disables DCD and carries on rather than failing
          the memdev (Jonathan).
        - Check the block size is a power of 2 in 64 bits.
          is_power_of_2() takes an unsigned long, so a 32 bit build
          truncated blk_size and accepted values such as 0x100000040
          (Sashiko).

 - Patch 3: cxl/cdat: Gather DSMAS data for DCD partitions
        - Only assign shareable for the dynamic ram 1 partition. It was
          set for every partition the DSMAS range fell into, while the
          handle check beside it is DC only (Alison).
        - Reduce nesting in cxl_memdev_set_qos_class(): invert
          range_contains() to continue early, and use a 'part' local
          instead of repeating cxlds->part[i] (Alison). Doing this first
          is what made the reworded warning fit in 100 columns.

 - Patch 4: cxl/events: Split event msgnum configuration from irq setup
        - No change from v12.

 - Patch 5: cxl/pci: Factor out interrupt policy check
        - Rename cxl_event_validate_mem_policy() to
          cxl_event_fw_owns_mem_logs() and invert it. It never validated
          the policy, it reported whether firmware still owns the
          standard memory event logs despite _OSC granting the OS
          control, so the name now states that condition and true means
          firmware owns them (Alison).
        - Commit message: "validation" was the wrong word for what the
          helper does; it checks for firmware ownership of the memory
          event logs (Alison).

 - Patch 6: cxl/mem: Configure dynamic capacity interrupts
        - Disable DCD when the device supports the DCD commands but its
          interrupt policy is too short to carry dcd_settings. The Set is
          sized by the device's own policy length, so on a short policy
          dcd_settings is never sent, and the re-read afterwards leaves
          the driver's own value in the struct because the device does
          not return that byte. cxl_irqsetup() would then arm the DCD
          interrupt from a setting the device never accepted. A
          conforming device cannot be in that state -- DCD is CXL 3.x and
          a 3.x policy carries the field -- but nothing tied the two
          facts together (Alison).
        - Move the DCD bit out of cxl_event_drain_mask(), dropping the
          mds argument it no longer needs, so the bit lands in the patch
          that adds the code draining that log. This patch still defines
          CXLDEV_EVENT_STATUS_DCD, adds it to CXLDEV_EVENT_STATUS_ALL and
          arms the DCD interrupt; only the drain bit moved (Alison).

 - Patch 7: cxl/core: Enforce partition order/simplify partition calls
        - Document the DPA partition layout above enum
          cxl_partition_mode in cxl.h with ascii art, and cite where the
          order comes from: ram before pmem is mandated by CXL r4.0
          Table 8-310, while Table 8-347 only requires the DC Region Base
          to be 256MB aligned, so a dynamic partition following pmem is a
          Linux choice that cxl_configure_dcd() enforces (Alison).
        - Commit message: say what the partition order is, where it comes
          from, and that this patch starts enforcing it. The previous
          text named an "implied partition order" without ever saying
          what it implied (Alison).
        - Name the partitions in the failure: "Partition order mismatch:
          %d (%s) follows %d (%s)" via cxl_mode_name(), rather than the
          bare "Partition order mismatch" (Alison).

Review status
=============
Patch 1
+ Reviewed-by from Dave Jiang and Gregory Price from v12.
Patch 1 did change in v13: dropped the single use
cxl_verify_dcd_cmds() helper so cxl_walk_cel() now tests
bitmap_full() directly. That is a no-op cleanup -- the helper was a
one-line wrapper around the same bitmap_full() call and had no other
caller -- so carried both tags over rather than dropping them.
Dave, Gregory, please say if you would rather re-review.

Patch 2 carries no Reviewed-by and is the patch that most needs eyes.

Patch 3:
Minor changes. Dropped Dave's tag.

Patch 4 is unchanged from v12 and carries its existing tag.

Patches 5 and 7 did change, but quite trivially, so kept
the tags. Patch 5 renames cxl_event_validate_mem_policy() to
cxl_event_fw_owns_mem_logs(). Patch 7 picks up a
loop-local index, a reworded error message and a comment on enum
cxl_partition_mode.

Patch 8 is new in v13 and carries no tags.

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

Testing
=======
This series leaves mds->dcd_supported false on purpose, so cxl_configure_dcd(),
cxl_dev_dc_identify() and cxl_dc_check() are unreachable at
runtime as posted. The tests below are done with the rest of the series on top,
otherwise testing would not yield any meaningful results.

HW:
Tested add/release of a single extent to ensure interrupts are configured
and working and DSMAS attributes are read correctly.

Additional testing is done on QEMU to catch cases that would not occur
on the hardware because of configuration differences. Four topologies
are used, one guest boot each, with a DCD partition after static capacity.

1. Eight DC partitions, only the first validated
------------------------------------------------
2G ram + 512M pmem static, so static capacity ends at 0xa0000000, and
eight 512M DC partitions above it.  Five partition records fit in one
reply on the 256 byte mailbox, so the read continues from partition 5
in a second command.

  cxl_pci 0000:0d:00.0: Read 5/8 DC partitions
  cxl_pci 0000:0d:00.0: DC partition 0 start 0xa0000000 size 0x20000000 blk_size: 0x200000
  cxl_pci 0000:0d:00.0: Read 3/8 DC partitions
  cxl_pci 0000:0d:00.0: Adding dynamic ram partition 1; 0xa0000000 size 0x20000000
  cxl_pci 0000:0d:00.0: DPA(ram): [mem 0x00000000-0x7fffffff flags 0x200]
  cxl_pci 0000:0d:00.0: DPA(pmem): [mem 0x80000000-0x9fffffff flags 0x200]
  cxl_pci 0000:0d:00.0: DPA(dynamic_ram_1): [mem 0xa0000000-0xbfffffff flags 0x200]

All eight partitions are read, but only one "DC partition" line appears:
partition 0 is the only one validated.

2. Volatile-only static capacity
---------------------------------
2G ram, no pmem, one 512M DC partition. cxl_configure_dcd() compares
the DC base against the end of total static capacity, not the end of
pmem; a device with no persistent capacity is what tells those two
apart.

  cxl_pci 0000:0d:00.0: Read 1/1 DC partitions
  cxl_pci 0000:0d:00.0: DC partition 0 start 0x80000000 size 0x20000000 blk_size: 0x200000
  cxl_pci 0000:0d:00.0: Adding dynamic ram partition 1; 0x80000000 size 0x20000000
  cxl_pci 0000:0d:00.0: DPA(ram): [mem 0x00000000-0x7fffffff flags 0x200]
  cxl_pci 0000:0d:00.0: DPA(dynamic_ram_1): [mem 0x80000000-0x9fffffff flags 0x200]

The DC partition lands at 0x80000000, directly after ram, and no
static-capacity complaint is logged.

3. No static capacity at all
-----------------------------
No ram, no pmem, one 512M DC partition based at DPA 0.  This is the
boundary of the contiguity rule: with no static capacity the end of
static capacity is DPA 0, so a DC base of 0 meets it exactly and
neither the overlap error nor the gap warning may fire.

  cxl_pci 0000:0d:00.0: Read 1/1 DC partitions
  cxl_pci 0000:0d:00.0: DC partition 0 start 0x0 size 0x20000000 blk_size: 0x200000
  cxl_pci 0000:0d:00.0: Adding dynamic ram partition 1; 0x0 size 0x20000000
  cxl_pci 0000:0d:00.0: DPA(dynamic_ram_1): [mem 0x00000000-0x1fffffff flags 0x200]

4. Per-field validation
-----------------------
Each row is one malformed field on partition 0, everything else left
valid.  The message names the field that is wrong.

  block size 0x100000040   DC partition 0 invalid block size 0x100000040
  block size 0x30          DC partition 0 invalid block size 0x30
  decode length 0          DC partition 0 zero decode length
  base 0xa0001000          DC partition 0 base 0xa0001000 not aligned to 256M
  DSMAD handle 0x100       DSMAD handle 0x100 exceeds the 8 bit CDAT DSMAD handle
  0 partitions available   Device reported 0 available DC partitions, expected 1 to 8
  9 partitions available   Device reported 9 available DC partitions, expected 1 to 8

The first row is the 32 bit truncation Sashiko reported: 0x100000040 is
not a power of 2, but its low 32 bits are, so is_power_of_2() accepted
it on a 32 bit build.  All seven cases disable DCD and leave the memdev
attached with its static capacity.

DC partition 0 placed against static capacity, which cxl_configure_dcd()
checks separately, gives one message for the overlap and one for the
gap:

  cxl_pci 0000:0d:00.0: DC partition 0 base 0x90000000 overlaps static capacity ending at 0xa0000000
  cxl_pci 0000:0d:00.0: DC partition 0 base 0xb0000000 leaves a gap from static capacity ending at 0xa0000000

Also used ndctl-test-runner to run cxl_test for regressions.
