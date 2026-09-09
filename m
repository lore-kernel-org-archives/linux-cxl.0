Received: from cross.elm.relay.mailchannels.net (cross.elm.relay.mailchannels.net [23.83.212.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF4A3976B8
	for <linux-cxl@vger.kernel.org>; Wed,  9 Sep 2026 18:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.212.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788978137; cv=none; b=dryx6NQW5tWgoYXxZ5aPBH0Z4hIGC52QlWEcuREN1hIl1WIXvlI1IJkXvE0P2tcLS+I6hnKwYPcYivZQdOjfY3BB1GWpsG07SvS/+7W8UYgbrUJEdzjWhHa4f7ZmMPcBP/4KHA1px7q4G92Zu1q5kHNssj3BhvT+meKt0X/Ao+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788978137; c=relaxed/simple;
	bh=jW2b5L3ac9X5dZQoFEpIvVMKu1toYF4HcidrPW+FMVA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nt8L0ULOQi+Q03tHMUDaqNvNFnCf+JI1uEqe3BhJdvmztCj57X05yCbHCy5FSI50ZVo2iPlmr6F+v9DfNJKIDK6/tTqrOu2+rUZQnEOTPH5sZBSEBMkKkMt6rL0EG7oZ0nhul0jXz9VV0G8DSMP4cAxGGHnUgKeYWWF6wJ+JXtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=AQg+txSr; arc=none smtp.client-ip=23.83.212.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="AQg+txSr"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 061754028DF;
	Wed, 09 Sep 2026 17:03:30 +0000 (UTC)
Received: from pdx1-sub0-mail-a213.dreamhost.com (100-96-173-13.trex-nlb.outbound.svc.cluster.local [100.96.173.13])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 7D370402CE3;
	Wed, 09 Sep 2026 17:03:28 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Stretch-Blushing: 1970e56676a15348_1788973408759_1906443223
X-MC-Loop-Signature: 1788973408759:3445555165
X-MC-Ingress-Time: 1788973408759
Received: from pdx1-sub0-mail-a213.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.173.13 (trex/8.0.2);
	Wed, 09 Sep 2026 17:03:28 +0000
Received: from offworld.lan (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a213.dreamhost.com (Postfix) with ESMTPSA id 4hg6Zl66xLz1dC;
	Wed,  9 Sep 2026 10:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1788973408;
	bh=a7Uv1EzsC8QNtn+1ofKVqtnN/wkf8/uXiKndBYIWgp0=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=AQg+txSr0Zge3g8Z3P0tBPOWyZYmR2A773BLr2aKzG8+yaVBgVpGXyLrDj1i6BEBd
	 CnRK2Tp4sFJ6r/mr5zfPG851S3mg+MPCRlk5qkq9gKG+DCOeQNLeuRo0Qqkgkn78Ny
	 NjVURqKi24gkHbMo/JlRAvcr/k4Oelx3ZWLrM/SDnrL2ddV9WweGPcWJIoGlkxVzDt
	 K0GFEtG76bsErIzYDwFj9EkmcWUkBZU7vooUOxy+BKxkZgDn8jFHBPbcKRVgf7DDjN
	 0iEQukWu/e7dtvF52P1RT6u7SOAmf4rsJaF/hp1v3VcsvyqeSP0W3ChnVGVsThWYBI
	 mgmwq5w2Er4HA==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com
Cc: jic23@kernel.org,
	alison.schofield@intel.com,
	icheng@nvidia.com,
	ming.li@zohomail.com,
	benjamin.cheatham@amd.com,
	alucerop@amd.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org
Subject: [PATCH v8 0/10] cxl: Support Back-Invalidate
Date: Wed,  9 Sep 2026 10:02:52 -0700
Message-Id: <20260909170302.1550680-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

Changes from v7 (https://lore.kernel.org/all/20260728144136.709882-1-dave@stgolabs.net/):
  - Patch 2: dports are programmed by position, not port type: the
    dport immediately above the device takes BI Enable, every dport
    above it BI Forward, at any switch depth (Li Ming, Table 7-97).
    nr_bi refcounts at every dport, the commit is issued per endpoint
    on a shared level, and a failed commit undoes its write (Sashiko).
  - Patch 2: a reset wipes the device's BI Enable; .reset_done reads
    the hardware and invalidates cxlds->bi, failing closed, with
    recovery by rebind (Richard). cxl_bi_dealloc() clears cxlds->bi
    unconditionally, so the disable no longer depends on a flag the
    hardware may no longer back. The BI teardown is registered
    before the decoders, so BI comes down after them (Richard).
  - Patch 1/7: a USP advertising a BI Route Table that failed to map
    is refused rather than treated as absent (Richard). Renamed the
    port mapping helper to devm_cxl_port_bi_setup() (Li Ming).
  - Patch 4: sysfs attributes spelled out as cap_back_invalidate and
    back_invalidate (Alison); Unknown coherency handling explained in
    the changelog (Alison). The HDM decoder BI bit is derived from the
    region's window rather than cxlds->bi, so an HDM-D decoder under
    a non-BI window is never committed with BI (Richard). A failed
    attach restores the decoder's previous target_type instead of
    the endpoint default, and region commit re-checks cxlds->bi for
    every target, so a reset between attach and commit refuses the
    commit rather than programming BI into a device whose BI Enable
    is clear.
  - Patch 4: cxl_acpi_cfmws_verify() rejects a CFMWS that has both
    Host-only Coherent and BI, one that has neither coherency model,
    and one with BI but not Device Coherent (CFMWS Window Restrictions).
  - Patch 6: cxl_coherency_name() replaces cxl_region_coherency(), so
    the model is named from a (type, bi) pair wherever it is logged.
  - Patch 8: adoption of firmware-enabled paths is a path property
    seeded from the endpoint's own BI Enable, and a switch's route
    table must be committed too before a level is taken as found
    (Richard). construct_region() checks the committed decoder
    against the window on both the BI and the range type axis, and
    cxl_region_attach() refuses a committed decoder whose coherency
    model differs from the region's ("coherency model mismatch:
    HDM-D vs HDM-H"). Dropped a misleading comment (Alison).
  - New patch 9: cxl_test mock BI topology, so the ndctl suite covers
    HDM-DB assembly and cxl_acpi rebind replay.
  - New patch 10: maturity map entry for Back-Invalidate.
  - Rebased onto v7.3-rc2. Collected Reviewed-by tags.

This series is the initial plumbing to enable HDM-DB in Linux. The
model allows Type 2 and Type 3 devices to expose their local memory
to the host CPU in a coherent manner. In alignment with what was
discussed at 2024 LPC type2 support session, this series takes the
Type 3 memory expander approach, which is more direct. Further,
afaik there is no Type 2 + BI hardware out there.

A flagship use case of Type 3 + BI is coherent shared memory, and
there is currently a big gap in this regard (ie: GFAM). Another
is P2P via PCIe UIO, which is also lacking today. Media Operation
(4402h) for ranged sanitize/zero also trigger snoops and there are
some patches out there[0]. As such this series focuses on BI enablement
in terms of discovery and configuration.

The idea is for Type 3 memdevs and Type 2 devices to make use of
cxlds->bi when committing HDM decoders, such that different device
coherence models can be differentiated as:

  type2 hdm-d:  cxlds->type == CXL_DEVTYPE_DEVMEM && cxlds->bi == false
  type2 hdm-db: cxlds->type == CXL_DEVTYPE_DEVMEM && cxlds->bi == true
  type3 hdm-h:  cxlds->type == CXL_DEVTYPE_CLASSMEM && cxlds->bi == false
  type3 hdm-db: cxlds->type == CXL_DEVTYPE_CLASSMEM && cxlds->bi == true

An auto-committed BI decoder found during enumeration is adopted when
the device and its path are BI capable, and only broken combinations
are refused (patches 7-8). See the auto-discovery tests section below.

o Patch 1 probes BI capabilities during register discovery, and maps BI
  Decoder registers.

o Patch 2 implements the BI-ID allocation (and deallocation) from
  the endpoint port's lifecycle, at any switch depth, and detects a
  reset that wiped the device's BI Enable.

o Patch 3 adds coherency support for endpoint decoders based on what the
  root decoder restricts.

o Patch 4 adds support for HDM-DB region creation.

o Patch 5 trivially renames some coherency flags.

o Patch 6 logs the coherency model (HDM-H, HDM-D, HDM-DB) when a
  region is created.

o Patch 7 splits the BI capability walk from BI-ID allocation so the
  answer is available when committed decoders are first parsed.

o Patch 8 allows committed BI decoders. Overall this series
  could be picked up with or without this patch.

o Patch 9 adds a mock BI topology to cxl_test.

o Patch 10 updates the maturity map.

Testing
-------

Testing has been done on top of upstream qemu with the CFMW options series:

  https://lore.kernel.org/all/20260720233242.901544-1-dave@stgolabs.net/

The qemu-based test suite covers 34 topologies, including cascaded
switches, interleaves across switches, firmware-adopted paths, device
resets and AER recovery:

  https://github.com/davidlohr/cxl-bi-tests

This passes regression testing (nothing breaks) ndctl suite via cxl_test,
now with the mock HDM-DB window of patch 9:

  == phase A: cxl_test load/unload x3
  cycle 1: memdevs=11 ports=8 rootdec=7 splats=0
  cycle 2: memdevs=11 ports=8 rootdec=7 splats=0
  cycle 3: memdevs=11 ports=8 rootdec=7 splats=0
  == phase B: ndctl cxl suite
  cxl-topology.sh            PASS      kasan=0 warn=0
  cxl-region-sysfs.sh        PASS      kasan=0 warn=0
  cxl-labels.sh              PASS      kasan=0 warn=0
  cxl-create-region.sh       PASS      kasan=0 warn=0
  cxl-xor-region.sh          PASS      kasan=0 warn=0
  cxl-events.sh              PASS      kasan=0 warn=0
  cxl-sanitize.sh            PASS      kasan=0 warn=0
  cxl-destroy-region.sh      PASS      kasan=0 warn=0
  cxl-qos-class.sh           PASS      kasan=0 warn=0
  cxl-translate.sh           PASS      kasan=0 warn=0
  cxl-elc.sh                 PASS      kasan=0 warn=0
  cxl-dax-hmem.sh            PASS      kasan=0 warn=0
  cxl-region-replay.sh       PASS      kasan=0 warn=0
  cxl-update-firmware.sh     PASS      kasan=0 warn=0
  cxl-security.sh            PASS      kasan=0 warn=0
  cxl-features.sh            PASS      kasan=0 warn=0
  cxl-poison.sh              PASS      kasan=0 warn=0
  BI PHASE DONE pass=11 fail=0
  SUITE DONE pass=17 fail=0 skip=0

1. HDM Decoder with BI through ad-hoc region creation.
------------------------------------------------------
# cxl list -D
[
  {
    "decoder":"decoder0.0",
    "resource":6710886400,
    "size":4294967296,
    "interleave_ways":1,
    "accelmem_capable":true,
    "nr_targets":1
  }
]

# ROOT=/sys/bus/cxl/devices/decoder0.0
# EP=/sys/bus/cxl/devices/decoder2.0
# echo region0 > $ROOT/create_ram_region
[   10.754350] cxl_core:devm_cxl_add_region:2867: cxl_acpi ACPI0017:00: decoder0.0: created HDM-DB region0
# REG=/sys/bus/cxl/devices/region0
# echo ram > $EP/mode
# echo 0x40000000 > $EP/dpa_size
# echo 1 > $REG/interleave_ways
# echo 4096 > $REG/interleave_granularity
# echo 0x40000000 > $REG/size
# cat $EP/back_invalidate
0
# echo decoder2.0 > $REG/target0
[   11.576260] cxl_core:cxl_port_attach_region:1319: cxl region0: mem0:endpoint2 decoder2.0 add: mem0:decoder2.0 @ 0 next: none nr_eps: 1 nr_targets: 1
[   11.576369] cxl_core:cxl_port_attach_region:1319: cxl region0: pci0000:0c:port1 decoder1.0 add: mem0:decoder2.0 @ 0 next: mem0 nr_eps: 1 nr_targets: 1
[   11.576381] cxl_core:cxl_port_setup_targets:1638: cxl region0: pci0000:0c:port1 iw: 1 ig: 4096
[   11.576385] cxl_core:cxl_port_setup_targets:1664: cxl region0: pci0000:0c:port1 target[0] = 0000:0c:00.0 for mem0:decoder2.0 @ 0
[   11.576404] cxl_core:cxl_calc_interleave_pos:2077: cxl_mem mem0: decoder:decoder2.0 parent:0000:0d:00.0 port:endpoint2 range:0x190000000-0x1cfffffff pos:0
[   11.576410] cxl_core:cxl_region_attach:2319: cxl decoder2.0: Test cxl_calc_interleave_pos(): success test_pos:0 target->pos:0
# cat $EP/back_invalidate
1
# echo 1 > $REG/commit
# cat $EP/back_invalidate
1
# cxl list -D
[
  {
    "root decoders":[
      {
        "decoder":"decoder0.0",
        "resource":6710886400,
        "size":4294967296,
        "interleave_ways":1,
        "accelmem_capable":true,
        "nr_targets":1
      }
    ]
  },
  {
    "port decoders":[
      {
        "decoder":"decoder1.0",
        "resource":6710886400,
        "size":1073741824,
        "interleave_ways":1,
        "region":"region0",
        "nr_targets":1
      }
    ]
  },
  {
    "endpoint decoders":[
      {
        "decoder":"decoder2.0",
        "resource":6710886400,
        "size":1073741824,
        "interleave_ways":1,
        "region":"region0",
        "dpa_resource":0,
        "dpa_size":1073741824,
        "mode":"ram"
      }
    ]
  }
]

2. Type3 device does not support BI, but CFMW has BI restriction
----------------------------------------------------------------
# echo decoder3.0 > $REG/target0
[    8.780244] cxl region0: mem0:decoder3.0 BI not enabled on device
[    8.780271] cxl_port endpoint3: failed to attach decoder3.0 to region0: -6

3. Type3 device supports BI but CFMW does not, create HDM-H region
------------------------------------------------------------------
# cxl list -D
[
  {
    "decoder":"decoder0.0",
    "resource":6710886400,
    "size":4294967296,
    "interleave_ways":1,
    "max_available_extent":4294967296,
    "pmem_capable":true,
    "volatile_capable":true,
    "accelmem_capable":true,
    "nr_targets":1
  }
]
# echo region0 > $ROOT/create_ram_region
[    7.957185] cxl_core:devm_cxl_add_region:2867: cxl_acpi ACPI0017:00: decoder0.0: created HDM-H region0
# cat $EP/back_invalidate
0
# echo decoder3.0 > $REG/target0
[    8.781886] cxl_core:cxl_port_attach_region:1319: cxl region0: mem0:endpoint3 decoder3.0 add: mem0:decoder3.0 @ 0 next: none nr_eps: 1 nr_targets: 1
[    8.781969] cxl_core:cxl_port_attach_region:1319: cxl region0: 0000:0d:00.0:port2 decoder2.0 add: mem0:decoder3.0 @ 0 next: mem0 nr_eps: 1 nr_targets: 1
[    8.782006] cxl_core:cxl_port_attach_region:1319: cxl region0: pci0000:0c:port1 decoder1.0 add: mem0:decoder3.0 @ 0 next: 0000:0d:00.0 nr_eps: 1 nr_targets: 1
[    8.782014] cxl_core:cxl_port_setup_targets:1638: cxl region0: pci0000:0c:port1 iw: 1 ig: 4096
[    8.782017] cxl_core:cxl_port_setup_targets:1664: cxl region0: pci0000:0c:port1 target[0] = 0000:0c:00.0 for mem0:decoder3.0 @ 0
[    8.782024] cxl_core:cxl_port_setup_targets:1638: cxl region0: 0000:0d:00.0:port2 iw: 1 ig: 4096
[    8.782027] cxl_core:cxl_port_setup_targets:1664: cxl region0: 0000:0d:00.0:port2 target[0] = 0000:0e:00.0 for mem0:decoder3.0 @ 0
[    8.782041] cxl_core:cxl_calc_interleave_pos:2077: cxl_mem mem0: decoder:decoder3.0 parent:0000:0f:00.0 port:endpoint3 range:0x190000000-0x1cfffffff pos:0
[    8.782046] cxl_core:cxl_region_attach:2319: cxl decoder3.0: Test cxl_calc_interleave_pos(): success test_pos:0 target->pos:0
# echo 1 > $REG/commit
# cat $EP/back_invalidate
0

4. Unbind + Bind
----------------
# echo mem0 > /sys/bus/cxl/drivers/cxl_mem/unbind
[   13.990226] cxl_core:cxl_port_commit_reap:888: cxl_port endpoint2: reap: decoder2.0 commit_end: -1
[   13.991350] cxl_core:__cxl_bi_ctrl_endpoint:1243: cxl_pci 0000:0d:00.0: BI requests disabled
[   13.992203] cxl_core:cxl_detach_ep:1564: cxl_mem mem0: disconnect mem0 from port1

# echo mem0 > /sys/bus/cxl/drivers/cxl_mem/bind
[   14.805903] cxl_core:devm_cxl_enumerate_ports:1879: cxl_mem mem0: scan: iter: mem0 dport_dev: 0000:0c:00.0 parent: pci0000:0c
[   14.805925] cxl_core:devm_cxl_enumerate_ports:1885: cxl_mem mem0: found already registered port port1:pci0000:0c
[   14.813031] cxl_core:__cxl_bi_ctrl_endpoint:1243: cxl_pci 0000:0d:00.0: BI requests enabled
[   14.834525] cxl_core:init_hdm_decoder:1116: cxl_port endpoint2: decoder2.0: range: 0x0-0xffffffffffffffff iw: 1 ig: 4096
[   14.835712] cxl_core:add_hdm_decoder:39: cxl_mem mem0: decoder2.0 added to endpoint2
[   14.842849] cxl_core:cxl_bus_probe:2307: cxl_port endpoint2: probe: 0
[   14.843183] cxl_core:cxl_bus_probe:2307: cxl_mem mem0: probe: 0

The same applies to the endpoint port, with the memdev rebind recovering the endpoint:

# echo endpoint2 > /sys/bus/cxl/drivers/cxl_port/unbind
[   16.495810] cxl_core:cxl_port_commit_reap:888: cxl_port endpoint2: reap: decoder2.0 commit_end: -1
[   16.496640] cxl_core:__cxl_bi_ctrl_endpoint:1243: cxl_pci 0000:0d:00.0: BI requests disabled
[   16.498846] cxl_core:cxl_detach_ep:1564: cxl_mem mem0: disconnect mem0 from port1

# echo mem0 > /sys/bus/cxl/drivers/cxl_mem/bind
[   17.310871] cxl_core:devm_cxl_enumerate_ports:1879: cxl_mem mem0: scan: iter: mem0 dport_dev: 0000:0c:00.0 parent: pci0000:0c
[   17.310901] cxl_core:devm_cxl_enumerate_ports:1885: cxl_mem mem0: found already registered port port1:pci0000:0c
[   17.320476] cxl_core:__cxl_bi_ctrl_endpoint:1243: cxl_pci 0000:0d:00.0: BI requests enabled
[   17.342413] cxl_core:init_hdm_decoder:1116: cxl_port endpoint2: decoder2.0: range: 0x0-0xffffffffffffffff iw: 1 ig: 4096
[   17.344062] cxl_core:add_hdm_decoder:39: cxl_mem mem0: decoder2.0 added to endpoint2
[   17.352670] cxl_core:cxl_bus_probe:2307: cxl_port endpoint2: probe: 0
[   17.354769] cxl_core:cxl_bus_probe:2307: cxl_mem mem0: probe: 0

From a cold boot, without a region ever created, the endpoint port
unbind only disables BI - there is no committed decoder to reap:

# echo endpoint2 > /sys/bus/cxl/drivers/cxl_port/unbind
[    8.261704] cxl_core:__cxl_bi_ctrl_endpoint:1243: cxl_pci 0000:0d:00.0: BI requests disabled
[    8.262349] cxl_core:cxl_detach_ep:1564: cxl_mem mem0: disconnect mem0 from port1

# echo mem0 > /sys/bus/cxl/drivers/cxl_mem/bind
[    9.078114] cxl_core:devm_cxl_enumerate_ports:1879: cxl_mem mem0: scan: iter: mem0 dport_dev: 0000:0c:00.0 parent: pci0000:0c
[    9.078145] cxl_core:devm_cxl_enumerate_ports:1885: cxl_mem mem0: found already registered port port1:pci0000:0c
[    9.086044] cxl_core:__cxl_bi_ctrl_endpoint:1243: cxl_pci 0000:0d:00.0: BI requests enabled
[    9.106885] cxl_core:init_hdm_decoder:1116: cxl_port endpoint2: decoder2.0: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
[    9.107812] cxl_core:add_hdm_decoder:39: cxl_mem mem0: decoder2.0 added to endpoint2
[    9.114859] cxl_core:cxl_bus_probe:2307: cxl_port endpoint2: probe: 0
[    9.116939] cxl_core:cxl_bus_probe:2307: cxl_mem mem0: probe: 0

5. Discovery behind a Switch
----------------------------
[    0.697822] cxl_core:cxl_probe_component_regs:103: cxl_pci 0000:0f:00.0: found BI Decoder capability (0xab4)
[    0.704872] cxl_core:cxl_probe_component_regs:103: pcieport 0000:0c:00.0: found BI Decoder capability (0xab4)
[    0.710326] cxl_core:cxl_probe_component_regs:97: cxl_port port2: found BI RT capability (0xaa8)
[    0.733373] cxl_core:cxl_probe_component_regs:103: pcieport 0000:0e:00.0: found BI Decoder capability (0xab4)
[    0.941065] cxl_core:__cxl_bi_wait_commit:1034: pcieport 0000:0e:00.0: BI-ID commit wait took 199255us
[    1.184128] cxl_core:__cxl_bi_wait_commit:1034: cxl_port port2: BI-ID commit wait took 243024us
[    1.184364] cxl_core:__cxl_bi_ctrl_endpoint:1243: cxl_pci 0000:0f:00.0: BI requests enabled

6. Corrupted hw (commit timeout handling)
-----------------------------------------
[    0.472917] cxl_core:cxl_probe_component_regs:103: pcieport 0000:0e:00.0: found BI Decoder capability (0xab4)
[    2.624316] pcieport 0000:0e:00.0: BI-ID commit timed out (2000000us)
[    4.656108] pcieport 0000:0e:00.0: BI-ID commit timed out (2000000us)
[    4.656152] cxl_core:devm_cxl_endpoint_decoders_setup:1320: cxl_port endpoint3: BI setup failed rc=-110

The second timeout is the undo of the DSP write, committed on the
way out.

7. Mixed Configurations (BI-capable Type 3 but DSP 68b)
-------------------------------------------------------
Not reachable from upstream qemu at the moment: x-256b-flit=off on a
cxl-downstream is not reflected in the LnkCtl2 bit cxl_pci_flit_256()
reads, so the path still enables. The suite's t7/t8 record this as
a SKIP; the refusal is by inspection only.

8. Auto-discovered (committed) BI decoders
------------------------------------------
For testing, qemu emulates a firmware-committed decoder (x-committed):

[    0.607519] cxl_core:devm_cxl_switch_port_decoders_setup:1270: cxl_port port1: Fallback to passthrough decoder
[    0.611600] cxl_core:__cxl_bi_ctrl_endpoint:1225: cxl_pci 0000:0d:00.0: adopting firmware-enabled BI
[    0.632964] cxl_core:init_hdm_decoder:1116: cxl_port endpoint2: decoder2.0: range: 0x190000000-0x19fffffff iw: 1 ig: 256
[    0.635422] cxl_core:devm_cxl_add_region:2867: cxl_acpi ACPI0017:00: decoder0.0: created HDM-DB region0
[    0.635808] cxl_core:__construct_region:3855: cxl_pci 0000:0d:00.0: mem0:decoder2.0: __construct_region region0 res: [mem 0x190000000-0x19fffffff flags 0x200] iw: 1 ig: 256
[    0.635871] cxl_core:cxl_region_sort_targets:2107: cxl region0: region sort successful
[    0.636344] cxl_core:devm_cxl_add_dax_region:101: cxl_region region0: region0: register dax_region0
[    0.636348] cxl_core:cxl_bus_probe:2307: cxl_region region0: probe: 0
# cat /sys/bus/cxl/devices/region0/commit
1
# cat /sys/bus/cxl/devices/decoder2.0/back_invalidate
1

A committed BI decoder under a window without the BI restriction is
refused at region assembly, the refusal naming the window:

[    0.501711] cxl_core:__cxl_bi_ctrl_endpoint:1225: cxl_pci 0000:0d:00.0: adopting firmware-enabled BI
[    0.522975] cxl decoder0.0: mem0:decoder2.0 coherency model not permitted by the window
[    0.522977] cxl_port:discover_region:55: cxl decoder2.0: failed to add to region: 0x190000000-0x19fffffff

The window check runs on both axes. A committed 2-way set mixing a BI
decoder with a host-only one under a BI window has its host-only
member refused, and the set never reaches a committed region:

[    0.633614] cxl_core:init_hdm_decoder:1116: cxl_port endpoint3: decoder3.0: range: 0x190000000-0x1afffffff iw: 2 ig: 4096
[    0.635468] cxl decoder0.0: mem0:decoder3.0 coherency model not permitted by the window
[    0.635473] cxl_port:discover_region:55: cxl decoder3.0: failed to add to region: 0x190000000-0x1afffffff
# cat /sys/bus/cxl/devices/region*/commit
0

And a committed decoder cannot inherit a region's coherency model the
way a decoder the driver programs does: a committed HDM-D (device
coherent, BI clear) accelerator decoder joining the region a committed
HDM-H peer constructed is refused (t16):

[    0.639668] cxl_core:devm_cxl_add_region:2867: cxl_acpi ACPI0017:00: decoder0.0: created HDM-H region0
[    0.641060] cxl region0: mem1:decoder4.0 coherency model mismatch: HDM-D vs HDM-H

9. Device reset
---------------
A Secondary Bus Reset through the kernel's reset attribute clears
the device's BI Enable, whose reset default is 0. .reset_done
compares cxlds->bi against the hardware and fails closed. With a
region attached but not yet committed (t34), the commit is refused
rather than programming BI into a device that no longer has it, and
a rebind recovers:

# echo decoder2.0 > $REG/target0
[    8.755919] cxl_core:cxl_port_attach_region:1319: cxl region0: mem0:endpoint2 decoder2.0 add: mem0:decoder2.0 @ 0 next: none nr_eps: 1 nr_targets: 1
[    8.756041] cxl_core:cxl_port_attach_region:1319: cxl region0: pci0000:0c:port1 decoder1.0 add: mem0:decoder2.0 @ 0 next: mem0 nr_eps: 1 nr_targets: 1
# cat $EP/target_type
accelerator
# echo cxl_bus > /sys/bus/pci/devices/0000:0d:00.0/reset_method
# echo 1 > /sys/bus/pci/devices/0000:0d:00.0/reset
[    9.574349] cxl_pci 0000:0d:00.0: resetting
[    9.580344] cxl_pci 0000:0d:00.0: reset via cxl_bus
[    9.593981] cxl_core:cxl_bi_reset_detected:1430: cxl_pci 0000:0d:00.0: BI disabled by reset
# echo 1 > $REG/commit
[   10.407149] cxl region0: mem0:decoder2.0 BI not enabled on device
# cat $EP/back_invalidate
0
# echo region0 > $ROOT/delete_region
# echo mem0 > /sys/bus/cxl/drivers/cxl_mem/unbind
[   12.048411] cxl_core:cxl_detach_ep:1564: cxl_mem mem0: disconnect mem0 from port1
# echo mem0 > /sys/bus/cxl/drivers/cxl_mem/bind
[   12.874360] cxl_core:__cxl_bi_ctrl_endpoint:1243: cxl_pci 0000:0d:00.0: BI requests enabled
[   12.904836] cxl_core:cxl_bus_probe:2307: cxl_port endpoint2: probe: 0
# echo region0 > $ROOT/create_ram_region
[   13.752094] cxl_core:devm_cxl_add_region:2867: cxl_acpi ACPI0017:00: decoder0.0: created HDM-DB region0
# echo decoder2.0 > $REG/target0
# echo 1 > $REG/commit
# cat $EP/back_invalidate
1

The same reset with the HDM-DB region committed (t27) trips the
existing decoder-loss detection alongside the BI invalidation:

# echo 1 > /sys/bus/pci/devices/0000:0d:00.0/reset
[    7.962842] cxl_pci 0000:0d:00.0: resetting
[    7.964156] cxl_pci 0000:0d:00.0: reset via cxl_bus
[    7.970272] cxl_core:cxl_bi_reset_detected:1430: cxl_pci 0000:0d:00.0: BI disabled by reset
[    7.970292] cxl_pci 0000:0d:00.0: SBR happened without memory regions removal.
[    7.970293] cxl_pci 0000:0d:00.0: System may be unstable if regions hosted system memory.
# cat $EP/back_invalidate
0

An FLR leaves the CXL.cache/mem component registers alone, so BI
Enable, the region and its decoders all survive it and nothing is
invalidated (t27 flr-region). The unbind after an invalidation still
unwinds the dport refcounts, and a reset below a switch leaves the
DSP's Enable and the Root Port's Forward in place for the unbind to
clear (t27 switch).

10. AER recovery
----------------
An AER Uncorrectable Fatal error injected into the endpoint (t28)
runs the recovery flow, which never reaches .reset_done: the memdev
bounce brings BI down through devres before the link reset, and the
re-attach after slot reset runs the enable path from scratch. An
HDM-DB region commits again afterwards.

[    8.440748] pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) Error message received from 0000:0d:00.0
[    8.440765] cxl_pci 0000:0d:00.0: AER: CXL Bus Error: severity=Uncorrectable (Fatal) (Inaccessible)
[    8.440797] pcieport 0000:0c:00.0: AER: broadcast error_detected message
[    8.488496] cxl_pci 0000:0d:00.0: mem0: frozen state error detected, disable CXL.mem
[    8.488792] cxl_core:__cxl_bi_ctrl_endpoint:1243: cxl_pci 0000:0d:00.0: BI requests disabled
[    8.492650] pcieport 0000:0c:00.0: AER: Root Port link has been reset (0)
[    8.492673] pcieport 0000:0c:00.0: AER: broadcast slot_reset message
[    8.492675] cxl_pci 0000:0d:00.0: mem0: restart CXL.mem after slot reset
[    8.499135] cxl_core:__cxl_bi_ctrl_endpoint:1243: cxl_pci 0000:0d:00.0: BI requests enabled
[    8.519570] pcieport 0000:0c:00.0: AER: broadcast resume message
[    8.519572] cxl_pci 0000:0d:00.0: mem0: error resume successful
[    8.519687] pcieport 0000:0c:00.0: AER: device recovery successful

11. Cascaded switches and interleaves across switches
-----------------------------------------------------
Two cascaded switches (t9): both route tables are found and committed,
the transit DSP takes Forward and the device-adjacent DSP Enable, and
an HDM-DB region commits two switch hops down next to an HDM-H one:

[    1.034321] cxl_core:cxl_probe_component_regs:97: cxl_port port2: found BI RT capability (0xaa8)
[    1.062426] cxl_core:cxl_probe_component_regs:97: cxl_port port3: found BI RT capability (0xaa8)
[    1.261552] cxl_core:__cxl_bi_wait_commit:1034: pcieport 0000:10:00.0: BI-ID commit wait took 165339us
[    1.368376] cxl_core:__cxl_bi_wait_commit:1034: cxl_port port3: BI-ID commit wait took 106716us
[    1.621908] cxl_core:__cxl_bi_wait_commit:1034: pcieport 0000:0e:00.0: BI-ID commit wait took 253353us
[    1.822125] cxl_core:__cxl_bi_wait_commit:1034: cxl_port port2: BI-ID commit wait took 200178us
[    1.822162] cxl_core:__cxl_bi_ctrl_endpoint:1243: cxl_pci 0000:11:00.0: BI requests enabled
[    7.676495] cxl_core:devm_cxl_add_region:2867: cxl_acpi ACPI0017:00: decoder0.0: created HDM-DB region0
[    7.929159] cxl_core:devm_cxl_add_region:2867: cxl_acpi ACPI0017:00: decoder0.1: created HDM-H region1

Three switch levels (t25), one commit per DSP and per route table:

[    0.971529] cxl_core:__cxl_bi_wait_commit:1034: pcieport 0000:12:00.0: BI-ID commit wait took 148067us
[    1.171001] cxl_core:__cxl_bi_wait_commit:1034: cxl_port port4: BI-ID commit wait took 199395us
[    1.371332] cxl_core:__cxl_bi_wait_commit:1034: pcieport 0000:10:00.0: BI-ID commit wait took 200263us
[    1.571774] cxl_core:__cxl_bi_wait_commit:1034: cxl_port port3: BI-ID commit wait took 200339us
[    1.773070] cxl_core:__cxl_bi_wait_commit:1034: pcieport 0000:0e:00.0: BI-ID commit wait took 200452us
[    1.973680] cxl_core:__cxl_bi_wait_commit:1034: cxl_port port2: BI-ID commit wait took 200378us
[    1.974046] cxl_core:__cxl_bi_ctrl_endpoint:1243: cxl_pci 0000:13:00.0: BI requests enabled

A 4-way HDM-DB region across two host bridges, each a switch with two
BI endpoints (t32): the root interleaves across the host bridges and
each USP decoder lands iw=2 below it, all four endpoints at bi=1:

[    7.877568] cxl_core:devm_cxl_add_region:2867: cxl_acpi ACPI0017:00: decoder0.0: created HDM-DB region0
[    8.039467] cxl_core:cxl_port_setup_targets:1638: cxl region0: pci0000:0c:port2 iw: 1 ig: 8192
[    8.039473] cxl_core:cxl_port_setup_targets:1664: cxl region0: pci0000:0c:port2 target[0] = 0000:0c:00.0 for mem0:decoder6.0 @ 0
[    8.039488] cxl_core:cxl_port_setup_targets:1638: cxl region0: 0000:0d:00.0:port3 iw: 2 ig: 8192
[    8.039491] cxl_core:cxl_port_setup_targets:1664: cxl region0: 0000:0d:00.0:port3 target[0] = 0000:0e:00.0 for mem0:decoder6.0 @ 0
[    8.039498] cxl_core:cxl_port_setup_targets:1638: cxl region0: pci0000:40:port1 iw: 1 ig: 8192
[    8.039501] cxl_core:cxl_port_setup_targets:1664: cxl region0: pci0000:40:port1 target[0] = 0000:40:00.0 for mem2:decoder8.0 @ 1

The same under one host bridge with two root ports (t33), the host
bridge decoder interleaving across the root ports:

[    7.754721] cxl_core:devm_cxl_add_region:2867: cxl_acpi ACPI0017:00: decoder0.0: created HDM-DB region0
[    7.824452] cxl_core:cxl_port_setup_targets:1638: cxl region0: pci0000:0c:port1 iw: 2 ig: 1024
[    7.824455] cxl_core:cxl_port_setup_targets:1664: cxl region0: pci0000:0c:port1 target[0] = 0000:0c:00.0 for mem0:decoder3.0 @ 0
[    7.824465] cxl_core:cxl_port_setup_targets:1638: cxl region0: 0000:0d:00.0:port2 iw: 2 ig: 2048
[    7.824468] cxl_core:cxl_port_setup_targets:1664: cxl region0: 0000:0d:00.0:port2 target[0] = 0000:0e:00.0 for mem0:decoder3.0 @ 0

Eight BI endpoints under one switch (t31) commit 4-way and 8-way
HDM-DB regions, the USP decoder at iw=8, and the shared root port
keeps Forward until the last of the eight endpoints is unbound.
A Type 2 (cxl-accel) and a Type 3 device interleave in one HDM-DB
region under a switch (t29).

Applies against v7.3-rc2. Please consider for v7.4.

[0] https://lore.kernel.org/linux-cxl/20260428200410.705675-1-dave@stgolabs.net/

Thanks!

Davidlohr Bueso (10):
  cxl: Add BI register probing and port initialization
  cxl/pci: Add BI topology enable/disable
  cxl/hdm: Add BI coherency support for endpoint decoders
  cxl: Add HDM-DB region creation
  cxl/hdm: Rename decoder coherency flags
  cxl/region: Log the coherency model at region creation
  cxl/pci: Split BI capability probe from setup
  cxl: Allow auto-committed BI hdm decoders
  cxl/test: Add mock BI topology support
  cxl/doc: Update maturity map with BI support

 Documentation/ABI/testing/sysfs-bus-cxl       |  17 +-
 Documentation/driver-api/cxl/maturity-map.rst |  17 +-
 drivers/cxl/acpi.c                            |  31 +-
 drivers/cxl/core/core.h                       |   2 +
 drivers/cxl/core/hdm.c                        |  67 ++-
 drivers/cxl/core/pci.c                        | 523 ++++++++++++++++++
 drivers/cxl/core/port.c                       |  48 +-
 drivers/cxl/core/region.c                     | 134 ++++-
 drivers/cxl/core/regs.c                       |  14 +
 drivers/cxl/cxl.h                             |  57 +-
 drivers/cxl/cxlmem.h                          |   2 +
 drivers/cxl/pci.c                             |   8 +-
 drivers/cxl/port.c                            |  46 ++
 include/cxl/cxl.h                             |  13 +-
 tools/testing/cxl/Kbuild                      |   1 +
 tools/testing/cxl/test/accel.c                |   2 +-
 tools/testing/cxl/test/cxl.c                  | 159 +++++-
 tools/testing/cxl/test/mock.c                 |  13 +
 tools/testing/cxl/test/mock.h                 |   1 +
 19 files changed, 1106 insertions(+), 49 deletions(-)

-- 
2.39.5

