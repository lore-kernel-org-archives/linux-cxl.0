Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.83.218.248
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794175694;
	b=ug/8QiJs3itc3yiWb+3T6DwzTWuBtjop7zghoagAPhRdOa6nHz94N4NSMnbV8DV6ehVX
	 IIhy5Julklsgf3AafqHYnB/mJvTemZd+A+OAjTHkIezZ2eJ1Md6LrUgNtkgTgRujJYsol
	 vXC1mRMk1TS2InHBdqkZLTBekwIUA/0mzlrEYXok0UnUSD2i/+IHAEQvOu5pkdV93YaEj
	 ZyqqfIgEwJxQ3TNV+n9yel5N5XxynT5prwxB2Ycgj7EV4qpM2dFmr2S9bT0/nx5IBYed3
	 gvSDAIclFYRf9/Eu9kzRGrQh3nBBIo2aQmNiyVLC/+PwEJtp9KD3rnchiBytjBM6f3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794175694;
	h=DMARC-Filter:X-Sender-Id:Received:Received:X-Sender-Id:X-MC-Relay:
	 X-MailChannels-SenderId:X-MailChannels-Auth-Id:X-Chemical-Scare:
	 X-MC-Loop-Signature:X-MC-Ingress-Time:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=IbBun5jkzkvEBf31Xo+0kB3qS2Sc5EqUB7FVQWYvMk4=;
	b=1cLR+Rej3YXaDqLicPv/s2jymYTJwSn07XHatZBEFBv89+9fhDNOIQn2GdDG5tarQFt8
	 9qM0EdTanXiDT2PvHF8J31vpgiCdaABXqT6Tuup1mLHIBc0vfjD/BDX73VGlg71mAzAu/
	 nICQiM/LG5mYH9BpI1y7QDN5ri/SWdRQEUF8zYSIGnqJCX9mNtMLJtwv5nA7lsnQxr2JU
	 bmSZRIASdqWeJ30kKqW5Oz/j1/HYyybxquw/0mUUx6HM9cO6zHXeCESd7Ti77XWWJthe/
	 KQQwOXuulG/rckmLzIHSNDgtD2cGY6evxUqIAiNn4/yaY9zZf4y2X2YtMHHP91olyxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=stgolabs.net;
	spf=fail smtp.mailfrom=stgolabs.net;
	dkim=pass header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=Lqstc3X5;
	arc=none smtp.remote-ip=23.83.218.248
Received: from tiger.tulip.relay.mailchannels.net (tiger.tulip.relay.mailchannels.net [23.83.218.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC47606A31C
	for <linux-cxl@vger.kernel.org>; Sun,  8 Nov 2026 22:08:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BC47606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=Lqstc3X5
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 8D7364C2260;
	Sun, 08 Nov 2026 22:08:07 +0000 (UTC)
Received: from pdx1-sub0-mail-a246.dreamhost.com (trex-green-7.trex.outbound.svc.cluster.local [100.99.170.189])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 186C34C21E3;
	Sun, 08 Nov 2026 22:08:06 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Chemical-Scare: 7f9e5bb92eb09b33_1794175686335_2197105427
X-MC-Loop-Signature: 1794175686335:272876508
X-MC-Ingress-Time: 1794175686335
Received: from pdx1-sub0-mail-a246.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.170.189 (trex/8.0.2);
	Sun, 08 Nov 2026 22:08:06 +0000
Received: from offworld.tailf5af7a.ts.net (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a246.dreamhost.com (Postfix) with ESMTPSA id 4jN6VY2qTkz105F;
	Sun,  8 Nov 2026 14:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1794175685;
	bh=IbBun5jkzkvEBf31Xo+0kB3qS2Sc5EqUB7FVQWYvMk4=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=Lqstc3X5KGc0pOkU8P5hEuvkGUoXrO0hr4DyFlCowBDCoKoWd0/Q5Ev6hx19M/Wsk
	 8Aph4x+FedLu9E5kHQfo+Kt87sODEHHLw/YzaJdQEXm/A4YPoGfkNA4nHSjzYzYFV6
	 g9/OCAZuU/lR2vsxZt77yffInsocMZyZmFhn70PfExPv1MrjcVR/fi1KN4/Y9emL7Q
	 9X10M0rbbCoAha6WB0NWRLeA6QvgnGiBjRCVRw2q1V+XUXGuZx3nSTKF/xA02MQ8Mc
	 d/tqvZqIIJoFQkRBOpDQq49eWvBctlL52DV0wX+HF9T9e5N7ncOrTAj5ncdQlFOoKe
	 1w5bNHkd6IRYA==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com
Cc: jic23@kernel.org,
	alison.schofield@intel.com,
	ming.li@zohomail.com,
	icheng@nvidia.com,
	benjamin.cheatham@amd.com,
	linux-cxl@vger.kernel.org,
	dave@stgolabs.net
Subject: [PATCH v11 00/10] cxl: Support Back-Invalidate
Date: Sun,  8 Nov 2026 14:07:29 -0800
Message-Id: <cover.1794172701.git.dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

Changes from v10 (https://lore.kernel.org/all/cover.1793567979.git.dave@stgolabs.net/):
  - Patch 2: READ_ONCE()/WRITE_ONCE() for cxlds->bi.
  - Patch 4: a commit that finds BI Enable wiped after its own check now
    also clears cxlds->bi, as .reset_done would. (sashiko)
  - Patch 4: dropped the unreachable CFMWS check for BI without Device
    Coherent (sashiko)
  - Patch 4: the BI bit readback in cxl_decoder_commit() and F_BI in
    CXL_DECODER_F_RESET_MASK moved here from patch 8 (Ming)
  - Collected Reviewed-by tags.

This series is the plumbing to enable HDM-DB in Linux. The model allows
Type 2 and Type 3 devices to expose their local memory to the host CPU
in a coherent manner. In alignment with what was discussed at 2024 LPC
type2 support session, this series takes the Type 3 memory expander
approach, which is more direct. Further, afaik there is no Type 2 + BI
hardware out there.

A flagship use case of Type 3 + BI is coherent shared memory, and
there is currently a big gap in this regard (ie: GFAM). Another
is P2P via PCIe UIO, which is also lacking today. Media Operation
(4402h) for ranged sanitize/zero also trigger snoops and there are
some patches out there[0]. As such this series focuses on BI enablement
in terms of discovery and configuration.

A device firmware already enabled for BI is taken up as found
(patch 2), and the levels firmware staged above it are adopted level
by level (patch 8). A BI decoder firmware committed is recorded at
enumeration; one that cannot route BISnp, or whose BI bit
contradicts its window, is refused (patches 7-8). See sections 8
and 12.

o Patch 1 probes BI capabilities during register discovery, and maps BI
  Decoder registers.

o Patch 2 implements the BI-ID allocation (and deallocation) from
  the endpoint port's lifecycle, at any switch depth. It takes up a
  device firmware already enabled, keeps BI up for a device that still
  decodes with BI at teardown, and detects a reset that wiped the
  device's BI Enable.

o Patch 3 adds coherency support for endpoint decoders based on the
  HDM's Supported Coherency Models.

o Patch 4 adds support for HDM-DB region creation.

o Patch 5 trivially renames some coherency flags.

o Patch 6 logs the coherency model (HDM-H, HDM-D, HDM-DB) when a
  region is created.

o Patch 7 splits the BI capability walk from BI-ID allocation so the
  answer is available when committed decoders are first parsed.

o Patch 8 handles BI decoders that firmware committed, and is required
  rather than optional: through patch 7 such a decoder is assembled
  without its BI bit ever being looked at. It records the bit
  (CXL_DECODER_F_BI), refuses BI with a host-only range type or on a
  path that cannot route BISnp, refuses a committed decoder whose BI
  bit does not match its window, and adopts a firmware-staged path
  level by level.

o Patch 9 adds a mock BI topology to cxl_test.

o Patch 10 updates the maturity map.

Semantics
---------
Who owns a BI level, and when one may be cleared or must be committed,
comes down to three rules:

  1. A level is cleared only if this driver brought it up from zero and
     has not since held it. A dport found with Enable or Forward
     already set while nothing this driver counts is routed through it
     is held for the dport's lifetime, whoever set it.

  2. The device keeps BI Enable while one of its HDM decoders still
     decodes with BI. At release the driver reads the decoders from the
     hardware; if one is committed with BI set, the device keeps its
     Enable and every level on its path is held. A failed walk never
     holds.

  3. A commit is owed when a level's BI-ID assignments change, never
     per register write: once for each device newly enabled below it,
     and once when its last device is unassigned. An adopted level, a
     held level reaching zero, and a root port are not committed.

Locked BI HDM decoders need no special case; rules 1 and 2 cover them.
A decoder committed with Lock On Commit set cannot be reset, and one in
a locked region is never reset by this driver, so either keeps decoding
with BI after the driver lets go of it. Release reads the Committed and
BI bits from the hardware, not the lock, so this holds whether or not
the kernel knows the decoder is locked: the device keeps BI Enable and
every level on its path is held. That covers an unbind, an orderly
hot-remove, and switch ports above the device being deleted and later
re-created, where the re-created levels read up and are held again. A
rebind takes the device up as found and adopts the levels left up for
it, with no write (see testing below t24 fw-locked, fw-switch-locked
and fw-orphan, t17 locked-remove, t25 nested-hold).


Testing
-------

The qemu-based test suite covers 35 topologies, including cascaded
switches, interleaves across switches, firmware-adopted and partially
staged paths, locked decoders, device hotplug, resets and AER recovery.
All 41 suites pass (914 checks).

  https://github.com/davidlohr/cxl-bi-tests

The QEMU knobs the suites use to stage firmware state and inject
commit faults are described in that repo's README. QEMU v11.x declares
Host-only together with BI on its BI windows, which this series
rejects as undefined; QEMU master no longer does (cb52f088f221).

This passes regression testing (nothing breaks) ndctl suite via
cxl_test, all 18 tests with KASAN, lockdep and UBSAN enabled, with the
mock HDM-DB window of patch 9 and the BI phase covering HDM-DB
assembly, cxl_acpi rebind replay and the Type 2 accelerator. The BI
mock device test script along with tooling to consume the new sysfs ABI
from this series is in the ndctl tree here:

  https://github.com/davidlohr/ndctl/tree/cxl-back-invalidate-test

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
# echo region0 > $ROOT/create_ram_region
  [   15.856712] cxl_core:devm_cxl_add_region:2921: cxl_acpi ACPI0017:00: decoder0.0: created HDM-DB region0
# echo ram > $EP/mode
# echo 0x40000000 > $EP/dpa_size
# echo 1 > $REG/interleave_ways
# echo 4096 > $REG/interleave_granularity
# echo 0x40000000 > $REG/size
# cat $EP/back_invalidate
0
# echo decoder2.0 > $REG/target0
  [   18.577151] cxl_core:cxl_port_attach_region:1351: cxl region0: mem0:endpoint2 decoder2.0 add: mem0:decoder2.0 @ 0 next: none nr_eps: 1 nr_targets: 1
  [   18.578039] cxl_core:cxl_port_attach_region:1351: cxl region0: pci0000:0c:port1 decoder1.0 add: mem0:decoder2.0 @ 0 next: mem0 nr_eps: 1 nr_targets: 1
  [   18.578063] cxl_core:cxl_port_setup_targets:1671: cxl region0: pci0000:0c:port1 iw: 1 ig: 4096
  [   18.578070] cxl_core:cxl_port_setup_targets:1697: cxl region0: pci0000:0c:port1 target[0] = 0000:0c:00.0 for mem0:decoder2.0 @ 0
  [   18.578158] cxl_core:cxl_calc_interleave_pos:2096: cxl_mem mem0: decoder:decoder2.0 parent:0000:0d:00.0 port:endpoint2 range:0x190000000-0x1cfffffff pos:0
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
# (region0 created on decoder0.0; interleave ways/granularity, size and DPA set as in section 1)
# echo decoder3.0 > $REG/target0
  [   15.483525] cxl_core:cxl_region_check_coherency:2144: cxl region0: mem0:decoder3.0 BI not enabled on device
  [   15.483533] cxl_port endpoint3: failed to attach decoder3.0 to region0: -6

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
  [   15.801502] cxl_core:devm_cxl_add_region:2921: cxl_acpi ACPI0017:00: decoder0.0: created HDM-H region0
# (interleave ways/granularity, size and DPA set as in section 1)
# cat $EP/back_invalidate
0
# echo decoder3.0 > $REG/target0
  [   16.611397] cxl_core:cxl_port_attach_region:1351: cxl region0: mem0:endpoint3 decoder3.0 add: mem0:decoder3.0 @ 0 next: none nr_eps: 1 nr_targets: 1
  [   16.611805] cxl_core:cxl_port_attach_region:1351: cxl region0: 0000:0d:00.0:port2 decoder2.0 add: mem0:decoder3.0 @ 0 next: mem0 nr_eps: 1 nr_targets: 1
  [   16.612149] cxl_core:cxl_port_attach_region:1351: cxl region0: pci0000:0c:port1 decoder1.0 add: mem0:decoder3.0 @ 0 next: 0000:0d:00.0 nr_eps: 1 nr_targets: 1
  [   16.612155] cxl_core:cxl_port_setup_targets:1671: cxl region0: pci0000:0c:port1 iw: 1 ig: 4096
  [   16.612158] cxl_core:cxl_port_setup_targets:1697: cxl region0: pci0000:0c:port1 target[0] = 0000:0c:00.0 for mem0:decoder3.0 @ 0
  [   16.612164] cxl_core:cxl_port_setup_targets:1671: cxl region0: 0000:0d:00.0:port2 iw: 1 ig: 4096
  [   16.612166] cxl_core:cxl_port_setup_targets:1697: cxl region0: 0000:0d:00.0:port2 target[0] = 0000:0e:00.0 for mem0:decoder3.0 @ 0
  [   16.612211] cxl_core:cxl_calc_interleave_pos:2096: cxl_mem mem0: decoder:decoder3.0 parent:0000:0f:00.0 port:endpoint3 range:0x190000000-0x1cfffffff pos:0
# echo 1 > $REG/commit
# cat $EP/back_invalidate
0

4. Unbind + Bind
----------------
On section 1's system, with region0 still committed:

# echo mem0 > /sys/bus/cxl/drivers/cxl_mem/unbind
  [   20.559469] cxl_core:cxl_port_commit_reap:991: cxl_port endpoint2: reap: decoder2.0 commit_end: -1
  [   20.563821] cxl_core:__cxl_bi_ctrl_endpoint:1303: cxl_pci 0000:0d:00.0: BI requests disabled
  [   20.564756] cxl_core:cxl_detach_ep:1609: cxl_mem mem0: disconnect mem0 from port1
# echo mem0 > /sys/bus/cxl/drivers/cxl_mem/bind
  [   20.952772] cxl_core:devm_cxl_enumerate_ports:1945: cxl_mem mem0: scan: iter: mem0 dport_dev: 0000:0c:00.0 parent: pci0000:0c
  [   20.952787] cxl_core:devm_cxl_enumerate_ports:1951: cxl_mem mem0: found already registered port port1:pci0000:0c
  [   20.959742] cxl_core:__cxl_bi_ctrl_endpoint:1303: cxl_pci 0000:0d:00.0: BI requests enabled
  [   20.980606] cxl_core:init_hdm_decoder:1214: cxl_port endpoint2: decoder2.0: range: 0x0-0xffffffffffffffff iw: 1 ig: 4096
  [   20.982581] cxl_core:add_hdm_decoder:40: cxl_mem mem0: decoder2.0 added to endpoint2
  [   20.992731] cxl_core:cxl_bus_probe:2390: cxl_port endpoint2: probe: 0
  [   20.993261] cxl_core:cxl_bus_probe:2390: cxl_mem mem0: probe: 0

The same applies to the endpoint port, with the memdev rebind
recovering the endpoint:

# echo endpoint2 > /sys/bus/cxl/drivers/cxl_port/unbind
  [   23.441567] cxl_core:__cxl_bi_ctrl_endpoint:1303: cxl_pci 0000:0d:00.0: BI requests disabled
  [   23.444331] cxl_core:cxl_detach_ep:1609: cxl_mem mem0: disconnect mem0 from port1
# echo mem0 > /sys/bus/cxl/drivers/cxl_mem/bind
  [   23.828837] cxl_core:devm_cxl_enumerate_ports:1945: cxl_mem mem0: scan: iter: mem0 dport_dev: 0000:0c:00.0 parent: pci0000:0c
  [   23.828854] cxl_core:devm_cxl_enumerate_ports:1951: cxl_mem mem0: found already registered port port1:pci0000:0c
  [   23.837017] cxl_core:__cxl_bi_ctrl_endpoint:1303: cxl_pci 0000:0d:00.0: BI requests enabled
  [   23.858724] cxl_core:init_hdm_decoder:1214: cxl_port endpoint2: decoder2.0: range: 0x0-0xffffffffffffffff iw: 1 ig: 4096
  [   23.859613] cxl_core:add_hdm_decoder:40: cxl_mem mem0: decoder2.0 added to endpoint2
  [   23.862914] cxl_core:cxl_bus_probe:2390: cxl_port endpoint2: probe: 0
  [   23.863297] cxl_core:cxl_bus_probe:2390: cxl_mem mem0: probe: 0

>From a cold boot, without a region ever created, the endpoint port
unbind only disables BI - there is no committed decoder to reap:

# echo endpoint2 > /sys/bus/cxl/drivers/cxl_port/unbind
  [   15.532967] cxl_core:__cxl_bi_ctrl_endpoint:1303: cxl_pci 0000:0d:00.0: BI requests disabled
  [   15.539194] cxl_core:cxl_detach_ep:1609: cxl_mem mem0: disconnect mem0 from port1
# echo mem0 > /sys/bus/cxl/drivers/cxl_mem/bind
  [   15.950005] cxl_core:devm_cxl_enumerate_ports:1945: cxl_mem mem0: scan: iter: mem0 dport_dev: 0000:0c:00.0 parent: pci0000:0c
  [   15.950021] cxl_core:devm_cxl_enumerate_ports:1951: cxl_mem mem0: found already registered port port1:pci0000:0c
  [   15.956131] cxl_core:__cxl_bi_ctrl_endpoint:1303: cxl_pci 0000:0d:00.0: BI requests enabled
  [   15.976762] cxl_core:init_hdm_decoder:1214: cxl_port endpoint2: decoder2.0: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
  [   15.978163] cxl_core:add_hdm_decoder:40: cxl_mem mem0: decoder2.0 added to endpoint2
  [   15.984492] cxl_core:cxl_bus_probe:2390: cxl_port endpoint2: probe: 0
  [   15.984878] cxl_core:cxl_bus_probe:2390: cxl_mem mem0: probe: 0

5. Discovery behind a Switch
----------------------------
One BI-capable device on a switch downstream port, the switch under a
root port, all in 256B flit. The capability walk finds a BI Decoder
on the device, the root port and the downstream port, and the route
table on the switch upstream port:

  [    1.576146] cxl_core:cxl_probe_component_regs:103: cxl_pci 0000:0f:00.0: found BI Decoder capability (0xab4)
  [    1.585191] cxl_core:cxl_probe_component_regs:103: pcieport 0000:0c:00.0: found BI Decoder capability (0xab4)
  [    1.588697] cxl_core:cxl_probe_component_regs:97: cxl_port port2: found BI RT capability (0xaa8)
  [    1.618201] cxl_core:cxl_probe_component_regs:103: pcieport 0000:0e:00.0: found BI Decoder capability (0xab4)
  [    1.765119] cxl_core:__cxl_bi_wait_commit:1058: pcieport 0000:0e:00.0: BI-ID commit wait took 140737us
  [    1.965340] cxl_core:__cxl_bi_wait_commit:1058: cxl_port port2: BI-ID commit wait took 200139us
  [    1.965412] cxl_core:__cxl_bi_ctrl_endpoint:1303: cxl_pci 0000:0f:00.0: BI requests enabled

6. Corrupted hw (commit timeout handling)
-----------------------------------------
A switch downstream port that never completes its BI Decoder commit,
advertising a two second window (t23). It is the device-adjacent level
and the first one the walk programs, so there is nothing below it to
unwind. The walk waits the window out, restores the control register and
commits the undo, which times out as well, and BI setup fails. The
device's BI Enable is never set; the endpoint still enumerates its
decoders and probes, with back_invalidate reading 0:

  [    3.907286] pcieport 0000:0e:00.0: BI-ID commit timed out (2000000us)
  [    5.954857] pcieport 0000:0e:00.0: BI-ID commit timed out (2000000us)
  [    5.954962] cxl_core:devm_cxl_endpoint_decoders_setup:1457: cxl_port endpoint3: BI setup failed rc=-110
  [    5.988287] cxl_core:cxl_bus_probe:2390: cxl_port endpoint3: probe: 0
  [    5.989110] cxl_core:cxl_bus_probe:2390: cxl_mem mem0: probe: 0

7. Mixed Configurations (BI-capable Type 3 behind a 68B hop)
------------------------------------------------------------
  [    1.613617] cxl_core:cxl_probe_component_regs:103: cxl_pci 0000:0f:00.0: found BI Decoder capability (0xab4)
  [    1.623517] cxl_core:cxl_probe_component_regs:103: pcieport 0000:0c:00.0: found BI Decoder capability (0xab4)
  [    1.654123] cxl_core:cxl_probe_component_regs:103: pcieport 0000:0e:00.0: found BI Decoder capability (0xab4)
  [    1.658849] cxl_core:cxl_bi_probe_capable:1497: cxl_pci 0000:0f:00.0: BI not supported by USP
# cat /sys/bus/cxl/devices/endpoint3/decoder3.0/back_invalidate
0
# echo region0 > /sys/bus/cxl/devices/decoder0.0/create_ram_region
  [   15.848894] cxl_core:devm_cxl_add_region:2921: cxl_acpi ACPI0017:00: decoder0.0: created HDM-DB region0
# (interleave ways 1, granularity 256, size and DPA 256M)
# echo decoder3.0 > /sys/bus/cxl/devices/region0/target0
  [   15.913258] cxl_core:cxl_region_check_coherency:2144: cxl region0: mem0:decoder3.0 BI not enabled on device
  [   15.913270] cxl_port endpoint3: failed to attach decoder3.0 to region0: -6

The same endpoint decoder still commits into an HDM-H region on the
plain window:

# echo region1 > /sys/bus/cxl/devices/decoder0.1/create_ram_region
  [   15.996159] cxl_core:devm_cxl_add_region:2921: cxl_acpi ACPI0017:00: decoder0.1: created HDM-H region1
# (interleave ways 1, granularity 256, size and DPA 256M)
# echo decoder3.0 > /sys/bus/cxl/devices/region1/target0
# echo 1 > /sys/bus/cxl/devices/region1/commit
# cat /sys/bus/cxl/devices/endpoint3/decoder3.0/back_invalidate
0

8. Auto-discovered (committed) BI decoders
------------------------------------------
For testing, qemu emulates a firmware-committed decoder (x-committed)
with this patch:
https://lore.kernel.org/all/20260909184728.mznbg6ox6nqnvv5p@offworld/

  [    1.531772] cxl_core:devm_cxl_switch_port_decoders_setup:1407: cxl_port port1: Fallback to passthrough decoder
  [    1.546029] cxl_core:__cxl_bi_ctrl_endpoint:1286: cxl_pci 0000:0d:00.0: adopting firmware-enabled BI
  [    1.567513] cxl_core:init_hdm_decoder:1214: cxl_port endpoint2: decoder2.0: range: 0x190000000-0x19fffffff iw: 1 ig: 256
  [    1.579179] cxl_core:devm_cxl_add_region:2921: cxl_acpi ACPI0017:00: decoder0.0: created HDM-DB region0
  [    1.580453] cxl_core:__construct_region:3930: cxl_pci 0000:0d:00.0: mem0:decoder2.0: __construct_region region0 res: [mem 0x190000000-0x19fffffff flags 0x200] iw: 1 ig: 256
  [    1.580520] cxl_core:cxl_region_sort_targets:2126: cxl region0: region sort successful
  [    1.585749] cxl_core:devm_cxl_add_dax_region:101: cxl_region region0: region0: register dax_region0
  [    1.585825] cxl_core:cxl_bus_probe:2390: cxl_region region0: probe: 0
# cat /sys/bus/cxl/devices/region0/commit
1
# cat /sys/bus/cxl/devices/decoder2.0/back_invalidate
1

A committed BI decoder under a window without the BI restriction is
refused at region assembly, the refusal naming the window (t16 neg,
t24 fw-orphan):

  [    1.533388] cxl_core:__cxl_bi_ctrl_endpoint:1286: cxl_pci 0000:0d:00.0: adopting firmware-enabled BI
  [    1.563754] cxl decoder0.0: mem0:decoder2.0 coherency model not permitted by the window
  [    1.563760] cxl_port:discover_region:58: cxl decoder2.0: failed to add to region: 0x190000000-0x1cfffffff

A committed 2-way set mixing a BI decoder with a host-only one under
a BI window has its host-only member refused whichever is discovered
first: constructing a host-only region under the window is refused by
the window check above, and joining the HDM-DB region the BI member
constructed is refused at attach ("BI not enabled on device"). The
set never reaches a committed region (t16 mixed).

And a committed decoder cannot inherit a region's coherency model the
way a decoder the driver programs does. Of a committed 2-way set
pairing an HDM-D (device coherent, BI clear) accelerator decoder with
an HDM-H Type 3 one under a window that permits both, whichever member
constructs the region, the other is refused at attach (t16 mixed-trt).
Here the Type 3 constructed it:

  [    1.802379] cxl_core:devm_cxl_add_region:2921: cxl_acpi ACPI0017:00: decoder0.0: created HDM-H region0
  [    1.803579] cxl_core:__construct_region:3930: cxl_pci 0000:41:00.0: mem0:decoder3.0: __construct_region region0 res: [mem 0x190000000-0x1afffffff flags 0x200] iw: 2 ig: 4096
  [    1.812579] cxl_core:cxl_region_check_coherency:2178: cxl region0: mem1:decoder4.0 coherency model mismatch: HDM-D vs HDM-H
  [    1.812584] cxl_port endpoint4: failed to attach decoder4.0 to region0: -6

That holds for as long as the decoder is committed in hardware, not
only while it sits in the region discovered for it. A member of a
committed 2-way HDM-DB set whose peer never commits leaves its auto
region waiting, uncommitted. Deleting that region resets nothing, so
the decoder keeps the type it decodes, and an HDM-H region on a plain
window refuses it rather than take it in: cxl_decoder_commit() skips
an already committed decoder, so the region would report committed
with the decoder never reprogrammed (t16 orphan):

  [    1.738705] cxl_core:__cxl_bi_ctrl_endpoint:1286: cxl_pci 0000:0d:00.0: adopting firmware-enabled BI
  [    1.765548] cxl_core:devm_cxl_add_region:2921: cxl_acpi ACPI0017:00: decoder0.0: created HDM-DB region0
  [    1.766270] cxl_core:__construct_region:3930: cxl_pci 0000:0d:00.0: mem0:decoder4.0: __construct_region region0 res: [mem 0x190000000-0x1afffffff flags 0x200] iw: 2 ig: 4096
# cat /sys/bus/cxl/devices/region0/commit
0
# echo region0 > /sys/bus/cxl/devices/decoder0.0/delete_region
# cat /sys/bus/cxl/devices/decoder4.0/target_type
accelerator
# echo region1 > /sys/bus/cxl/devices/decoder0.1/create_ram_region
  [   18.281105] cxl_core:devm_cxl_add_region:2921: cxl_acpi ACPI0017:00: decoder0.1: created HDM-H region1
# echo 4096 > /sys/bus/cxl/devices/region1/interleave_granularity
# echo 1 > /sys/bus/cxl/devices/region1/interleave_ways
# cat /sys/bus/cxl/devices/decoder4.0/dpa_size > /sys/bus/cxl/devices/region1/size
# echo decoder4.0 > /sys/bus/cxl/devices/region1/target0
  [   18.290076] cxl_core:cxl_region_check_coherency:2178: cxl region1: mem0:decoder4.0 coherency model mismatch: HDM-DB vs HDM-H
  [   18.290085] cxl_port endpoint4: failed to attach decoder4.0 to region1: -6

The attach refusals are dev_dbg, like the upstream type mismatch
refusal they extend, and show above with dynamic debug enabled; the
failed attach itself is always reported. The window refusal at region
construction is logged as an error.

9. Device reset
---------------
A Secondary Bus Reset through the kernel's reset attribute clears
the device's BI Enable, whose reset default is 0. .reset_done
compares cxlds->bi against the hardware and fails closed. With a
region attached but not yet committed (t34), the commit is refused
rather than programming BI into a device that no longer has it, and
a rebind recovers:

# echo region0 > $ROOT/create_ram_region
  [   32.874887] cxl_core:devm_cxl_add_region:2923: cxl_acpi ACPI0017:00: decoder0.0: created HDM-DB region0
# echo ram > $EP/mode
# echo 0x40000000 > $EP/dpa_size
# echo 1 > $REG/interleave_ways
# echo 4096 > $REG/interleave_granularity
# echo 0x40000000 > $REG/size
# echo decoder2.0 > $REG/target0
  [   42.160977] cxl_core:cxl_port_attach_region:1352: cxl region0: mem0:endpoint2 decoder2.0 add: mem0:decoder2.0 @ 0 next: none nr_eps: 1 nr_targets: 1
  [   42.161826] cxl_core:cxl_port_attach_region:1352: cxl region0: pci0000:0c:port1 decoder1.0 add: mem0:decoder2.0 @ 0 next: mem0 nr_eps: 1 nr_targets: 1
  [   42.161855] cxl_core:cxl_port_setup_targets:1672: cxl region0: pci0000:0c:port1 iw: 1 ig: 4096
  [   42.161861] cxl_core:cxl_port_setup_targets:1698: cxl region0: pci0000:0c:port1 target[0] = 0000:0c:00.0 for mem0:decoder2.0 @ 0
  [   42.161950] cxl_core:cxl_calc_interleave_pos:2097: cxl_mem mem0: decoder:decoder2.0 parent:0000:0d:00.0 port:endpoint2 range:0x190000000-0x1cfffffff pos:0
# cat $EP/target_type
accelerator
# echo cxl_bus > /sys/bus/pci/devices/0000:0d:00.0/reset_method
# echo 1 > /sys/bus/pci/devices/0000:0d:00.0/reset
  [   46.777456] cxl_pci 0000:0d:00.0: resetting
  [   46.779842] cxl_pci 0000:0d:00.0: reset via cxl_bus
  [   46.791052] cxl_pci 0000:0d:00.0: BI disabled by reset
# echo 1 > $REG/commit
  [   48.330230] cxl region0: mem0:decoder2.0 BI not enabled on device
# cat $EP/back_invalidate
0
# echo region0 > $ROOT/delete_region
# echo mem0 > /sys/bus/cxl/drivers/cxl_mem/unbind
  [   52.958258] cxl_core:cxl_detach_ep:1609: cxl_mem mem0: disconnect mem0 from port1
# echo mem0 > /sys/bus/cxl/drivers/cxl_mem/bind
  [   55.514094] cxl_core:devm_cxl_enumerate_ports:1945: cxl_mem mem0: scan: iter: mem0 dport_dev: 0000:0c:00.0 parent: pci0000:0c
  [   55.514112] cxl_core:devm_cxl_enumerate_ports:1951: cxl_mem mem0: found already registered port port1:pci0000:0c
  [   55.525896] cxl_core:__cxl_bi_ctrl_endpoint:1303: cxl_pci 0000:0d:00.0: BI requests enabled
  [   55.546633] cxl_core:init_hdm_decoder:1214: cxl_port endpoint2: decoder2.0: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
  [   55.548510] cxl_core:add_hdm_decoder:40: cxl_mem mem0: decoder2.0 added to endpoint2
  [   55.560094] cxl_core:cxl_bus_probe:2390: cxl_port endpoint2: probe: 0
  [   55.560571] cxl_core:cxl_bus_probe:2390: cxl_mem mem0: probe: 0
# echo region0 > $ROOT/create_ram_region
  [   57.125912] cxl_core:devm_cxl_add_region:2923: cxl_acpi ACPI0017:00: decoder0.0: created HDM-DB region0
# echo ram > $EP/mode
# echo 0x40000000 > $EP/dpa_size
# echo 1 > $REG/interleave_ways
# echo 4096 > $REG/interleave_granularity
# echo 0x40000000 > $REG/size
# echo decoder2.0 > $REG/target0
  [   66.390681] cxl_core:cxl_port_attach_region:1352: cxl region0: mem0:endpoint2 decoder2.0 add: mem0:decoder2.0 @ 0 next: none nr_eps: 1 nr_targets: 1
  [   66.391015] cxl_core:cxl_port_attach_region:1352: cxl region0: pci0000:0c:port1 decoder1.0 add: mem0:decoder2.0 @ 0 next: mem0 nr_eps: 1 nr_targets: 1
  [   66.391021] cxl_core:cxl_port_setup_targets:1672: cxl region0: pci0000:0c:port1 iw: 1 ig: 4096
  [   66.391024] cxl_core:cxl_port_setup_targets:1698: cxl region0: pci0000:0c:port1 target[0] = 0000:0c:00.0 for mem0:decoder2.0 @ 0
  [   66.391054] cxl_core:cxl_calc_interleave_pos:2097: cxl_mem mem0: decoder:decoder2.0 parent:0000:0d:00.0 port:endpoint2 range:0x190000000-0x1cfffffff pos:0
# echo 1 > $REG/commit
# cat $EP/back_invalidate
1

The same reset with the HDM-DB region committed (t27) trips the
existing decoder-loss detection alongside the BI invalidation:

# echo 1 > /sys/bus/pci/devices/0000:0d:00.0/reset
  [   71.053003] cxl_pci 0000:0d:00.0: resetting
  [   71.058635] cxl_pci 0000:0d:00.0: reset via cxl_bus
  [   71.065247] cxl_pci 0000:0d:00.0: BI disabled by reset
  [   71.065264] cxl_pci 0000:0d:00.0: SBR happened without memory regions removal.
  [   71.065267] cxl_pci 0000:0d:00.0: System may be unstable if regions hosted system memory.
# cat $EP/back_invalidate
0

A reset landing after the commit's own check but before the decoder
is programmed is caught by re-reading BI Decoder Control once the
target is committed, and the target is undone. The refusal also fails
cxlds->bi closed, as .reset_done would have: the still-attached
decoder stops reporting HDM-DB, a fresh HDM-DB attach is refused at
attach rather than at commit, and a rebind recovers (t34). The run
below clears BI Enable through /dev/mem before the commit, leaving
cxlds->bi set, to stand in for a reset whose .reset_done has not yet
run:

# echo 1 > $REG/commit
  [   91.858170] cxl region0: mem0:decoder2.0 BI disabled by reset during commit
  [   91.858190] cxl_core:cxl_port_commit_reap:991: cxl_port endpoint2: reap: decoder2.0 commit_end: -1
# cat $REG/commit
0
# cat $EP/back_invalidate
0
# echo region0 > $ROOT/delete_region
# echo region0 > $ROOT/create_ram_region
  [   98.035100] cxl_core:devm_cxl_add_region:2923: cxl_acpi ACPI0017:00: decoder0.0: created HDM-DB region0
# (interleave ways/granularity, size and DPA set as in section 1)
# echo decoder2.0 > $REG/target0
  [  107.263070] cxl_core:cxl_region_check_coherency:2146: cxl region0: mem0:decoder2.0 BI not enabled on device
  [  107.263083] cxl_port endpoint2: failed to attach decoder2.0 to region0: -6
# echo region0 > $ROOT/delete_region
# echo mem0 > /sys/bus/cxl/drivers/cxl_mem/unbind
  [  111.914996] cxl_core:cxl_detach_ep:1609: cxl_mem mem0: disconnect mem0 from port1
# echo mem0 > /sys/bus/cxl/drivers/cxl_mem/bind
  [  114.469635] cxl_core:__cxl_bi_ctrl_endpoint:1303: cxl_pci 0000:0d:00.0: BI requests enabled
# echo region0 > $ROOT/create_ram_region
  [  116.078623] cxl_core:devm_cxl_add_region:2923: cxl_acpi ACPI0017:00: decoder0.0: created HDM-DB region0
# (interleave ways/granularity, size and DPA set as in section 1)
# echo decoder2.0 > $REG/target0
  [  125.339245] cxl_core:cxl_port_attach_region:1352: cxl region0: mem0:endpoint2 decoder2.0 add: mem0:decoder2.0 @ 0 next: none nr_eps: 1 nr_targets: 1
# echo 1 > $REG/commit
# cat $EP/back_invalidate
1

An FLR leaves the CXL.cache/mem component registers alone, so BI
Enable, the region and its decoders all survive it and nothing is
invalidated (t27 flr-region). Resets around a switch, including one
below a held level, are in section 15.

10. AER recovery
----------------
An AER Uncorrectable Fatal error injected into the endpoint (t28)
runs the recovery flow, which never reaches .reset_done: the memdev
bounce brings BI down through devres before the link reset, and the
re-attach after slot reset runs the enable path from scratch. An
HDM-DB region commits again afterwards.

  [   17.122893] pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) Error message received from 0000:0d:00.0
  [   17.122901] cxl_pci 0000:0d:00.0: AER: CXL Bus Error: severity=Uncorrectable (Fatal) (Inaccessible)
  [   17.122920] pcieport 0000:0c:00.0: AER: broadcast error_detected message
  [   17.175801] cxl_pci 0000:0d:00.0: mem0: frozen state error detected, disable CXL.mem
  [   17.176523] cxl_core:__cxl_bi_ctrl_endpoint:1303: cxl_pci 0000:0d:00.0: BI requests disabled
  [   17.181262] pcieport 0000:0c:00.0: AER: Root Port link has been reset (0)
  [   17.181288] pcieport 0000:0c:00.0: AER: broadcast slot_reset message
  [   17.181291] cxl_pci 0000:0d:00.0: mem0: restart CXL.mem after slot reset
  [   17.190943] cxl_core:__cxl_bi_ctrl_endpoint:1303: cxl_pci 0000:0d:00.0: BI requests enabled
  [   17.218302] pcieport 0000:0c:00.0: AER: broadcast resume message
  [   17.218307] cxl_pci 0000:0d:00.0: mem0: error resume successful
  [   17.218481] pcieport 0000:0c:00.0: AER: device recovery successful
  [   19.522263] cxl_core:devm_cxl_add_region:2921: cxl_acpi ACPI0017:00: decoder0.0: created HDM-DB region0

With a committed HDM-DB region live (t28 region), the bounce resets
the endpoint decoder before BI comes down, so no decoder is left
decoding with BI once BI Enable is cleared. The region is detached
and decommitted but left for userspace to delete, and a new one
commits after recovery:

  [   17.976231] cxl_pci 0000:0d:00.0: mem0: frozen state error detected, disable CXL.mem
  [   17.977026] cxl_core:cxl_port_commit_reap:991: cxl_port endpoint2: reap: decoder2.0 commit_end: -1
  [   17.977436] cxl_core:__cxl_bi_ctrl_endpoint:1303: cxl_pci 0000:0d:00.0: BI requests disabled
  [   18.018267] pcieport 0000:0c:00.0: AER: device recovery successful
  [   20.270882] cxl_core:devm_cxl_add_region:2921: cxl_acpi ACPI0017:00: decoder0.0: created HDM-DB region1

11. Cascaded switches and interleaves across switches
-----------------------------------------------------
Two cascaded switches (t9): both route tables are found and committed,
the transit DSP takes Forward and the device-adjacent DSP Enable, and
an HDM-DB region commits two switch hops down next to an HDM-H one:

  [    1.638170] cxl_core:cxl_probe_component_regs:103: cxl_pci 0000:11:00.0: found BI Decoder capability (0xab4)
  [    1.648278] cxl_core:cxl_probe_component_regs:103: pcieport 0000:0c:00.0: found BI Decoder capability (0xab4)
  [    1.653275] cxl_core:cxl_probe_component_regs:97: cxl_port port2: found BI RT capability (0xaa8)
  [    1.683172] cxl_core:cxl_probe_component_regs:103: pcieport 0000:0e:00.0: found BI Decoder capability (0xab4)
  [    1.691573] cxl_core:cxl_probe_component_regs:97: cxl_port port3: found BI RT capability (0xaa8)
  [    1.717012] cxl_core:cxl_probe_component_regs:103: pcieport 0000:10:00.0: found BI Decoder capability (0xab4)
  [    1.923997] cxl_core:__cxl_bi_wait_commit:1058: pcieport 0000:10:00.0: BI-ID commit wait took 195797us
  [    2.178803] cxl_core:__cxl_bi_wait_commit:1058: cxl_port port3: BI-ID commit wait took 254725us
  [    2.379136] cxl_core:__cxl_bi_wait_commit:1058: pcieport 0000:0e:00.0: BI-ID commit wait took 200277us
  [    2.647352] cxl_core:__cxl_bi_wait_commit:1058: cxl_port port2: BI-ID commit wait took 268086us
  [    2.647521] cxl_core:__cxl_bi_ctrl_endpoint:1303: cxl_pci 0000:11:00.0: BI requests enabled
  [   15.870770] cxl_core:devm_cxl_add_region:2921: cxl_acpi ACPI0017:00: decoder0.0: created HDM-DB region0
  [   16.525134] cxl_core:devm_cxl_add_region:2921: cxl_acpi ACPI0017:00: decoder0.1: created HDM-H region1

Unbinding the outer switch port takes the cascade down (t9 phase 2):
the device's BI Enable is released first, then each DSP is cleared and
committed on the way up, along with its switch's route table, the
deallocate sequence of 9.14.2:

  [   18.314428] cxl_core:__cxl_bi_ctrl_endpoint:1303: cxl_pci 0000:11:00.0: BI requests disabled
  [   18.424815] cxl_core:__cxl_bi_wait_commit:1058: pcieport 0000:10:00.0: BI-ID commit wait took 110308us
  [   18.626048] cxl_core:__cxl_bi_wait_commit:1058: cxl_port port3: BI-ID commit wait took 201026us
  [   18.826717] cxl_core:__cxl_bi_wait_commit:1058: pcieport 0000:0e:00.0: BI-ID commit wait took 200370us
  [   19.027462] cxl_core:__cxl_bi_wait_commit:1058: cxl_port port2: BI-ID commit wait took 200510us

A rebind commits all four again.

Three switch levels (t25), one commit per DSP and per route table:

  [    2.145524] cxl_core:__cxl_bi_wait_commit:1058: pcieport 0000:12:00.0: BI-ID commit wait took 134272us
  [    2.400261] cxl_core:__cxl_bi_wait_commit:1058: cxl_port port4: BI-ID commit wait took 254563us
  [    2.600108] cxl_core:__cxl_bi_wait_commit:1058: pcieport 0000:10:00.0: BI-ID commit wait took 199741us
  [    2.800669] cxl_core:__cxl_bi_wait_commit:1058: cxl_port port3: BI-ID commit wait took 200458us
  [    3.001641] cxl_core:__cxl_bi_wait_commit:1058: pcieport 0000:0e:00.0: BI-ID commit wait took 200649us
  [    3.108539] cxl_core:__cxl_bi_wait_commit:1058: cxl_port port2: BI-ID commit wait took 106634us
  [    3.108813] cxl_core:__cxl_bi_ctrl_endpoint:1303: cxl_pci 0000:13:00.0: BI requests enabled

A 4-way HDM-DB region across two host bridges, each a switch with two
BI endpoints (t32): the root interleaves across the host bridges and
each USP decoder lands iw=2 below it, all four endpoints at bi=1:

  [   17.078571] cxl_core:devm_cxl_add_region:2921: cxl_acpi ACPI0017:00: decoder0.0: created HDM-DB region0
  [   17.491240] cxl_core:cxl_port_setup_targets:1671: cxl region0: pci0000:0c:port2 iw: 1 ig: 8192
  [   17.491246] cxl_core:cxl_port_setup_targets:1697: cxl region0: pci0000:0c:port2 target[0] = 0000:0c:00.0 for mem2:decoder8.0 @ 0
  [   17.491258] cxl_core:cxl_port_setup_targets:1671: cxl region0: 0000:0d:00.0:port3 iw: 2 ig: 8192
  [   17.491263] cxl_core:cxl_port_setup_targets:1697: cxl region0: 0000:0d:00.0:port3 target[0] = 0000:0e:00.0 for mem2:decoder8.0 @ 0
  [   17.491271] cxl_core:cxl_port_setup_targets:1671: cxl region0: pci0000:40:port1 iw: 1 ig: 8192
  [   17.491275] cxl_core:cxl_port_setup_targets:1697: cxl region0: pci0000:40:port1 target[0] = 0000:40:00.0 for mem3:decoder7.0 @ 1
  [   17.491285] cxl_core:cxl_port_setup_targets:1671: cxl region0: 0000:41:00.0:port4 iw: 2 ig: 8192
  [   17.491289] cxl_core:cxl_port_setup_targets:1697: cxl region0: 0000:41:00.0:port4 target[0] = 0000:42:00.0 for mem3:decoder7.0 @ 1
  [   17.491299] cxl_core:cxl_port_setup_targets:1697: cxl region0: pci0000:0c:port2 target[0] = 0000:0c:00.0 for mem0:decoder5.0 @ 2
  [   17.491309] cxl_core:cxl_port_setup_targets:1697: cxl region0: 0000:0d:00.0:port3 target[1] = 0000:0e:01.0 for mem0:decoder5.0 @ 2
  [   17.491319] cxl_core:cxl_port_setup_targets:1697: cxl region0: pci0000:40:port1 target[0] = 0000:40:00.0 for mem1:decoder6.0 @ 3
  [   17.491329] cxl_core:cxl_port_setup_targets:1697: cxl region0: 0000:41:00.0:port4 target[1] = 0000:42:01.0 for mem1:decoder6.0 @ 3

The same under one host bridge with two root ports (t33), the host
bridge decoder interleaving across the root ports:

  [   17.116490] cxl_core:devm_cxl_add_region:2921: cxl_acpi ACPI0017:00: decoder0.0: created HDM-DB region0
  [   17.544042] cxl_core:cxl_port_setup_targets:1671: cxl region0: pci0000:0c:port1 iw: 2 ig: 1024
  [   17.544044] cxl_core:cxl_port_setup_targets:1697: cxl region0: pci0000:0c:port1 target[0] = 0000:0c:00.0 for mem2:decoder6.0 @ 0
  [   17.544053] cxl_core:cxl_port_setup_targets:1671: cxl region0: 0000:0d:00.0:port3 iw: 2 ig: 2048
  [   17.544055] cxl_core:cxl_port_setup_targets:1697: cxl region0: 0000:0d:00.0:port3 target[0] = 0000:0e:00.0 for mem2:decoder6.0 @ 0
  [   17.544060] cxl_core:cxl_port_setup_targets:1697: cxl region0: pci0000:0c:port1 target[1] = 0000:0c:01.0 for mem0:decoder5.0 @ 1
  [   17.544065] cxl_core:cxl_port_setup_targets:1671: cxl region0: 0000:11:00.0:port2 iw: 2 ig: 2048
  [   17.544067] cxl_core:cxl_port_setup_targets:1697: cxl region0: 0000:11:00.0:port2 target[0] = 0000:12:00.0 for mem0:decoder5.0 @ 1
  [   17.544073] cxl_core:cxl_port_setup_targets:1697: cxl region0: pci0000:0c:port1 target[1] = 0000:0c:00.0 for mem1:decoder4.0 @ 2
  [   17.544079] cxl_core:cxl_port_setup_targets:1697: cxl region0: 0000:0d:00.0:port3 target[1] = 0000:0e:01.0 for mem1:decoder4.0 @ 2
  [   17.544084] cxl_core:cxl_port_setup_targets:1697: cxl region0: pci0000:0c:port1 target[1] = 0000:0c:01.0 for mem3:decoder7.0 @ 3
  [   17.544089] cxl_core:cxl_port_setup_targets:1697: cxl region0: 0000:11:00.0:port2 target[1] = 0000:12:01.0 for mem3:decoder7.0 @ 3

12. Firmware-staged paths behind switches
-----------------------------------------
A device whose BI Enable firmware already set is taken as found (patch
2), and patch 8 takes its path the same way, from the device up: a
level is adopted, with no write and no commit, only while nothing this
driver routed sits below it, it already holds the role the walk would
write, and its BI Decoder and its switch's route table both read
committed. The first level that falls short ends adoption, and from
there up the driver programs and commits as for a new device. A level
found up, adopted or not, is held: this driver never clears it.

With the device and both switch levels of t9's shape staged (t24
fw-path), nothing is committed where t9 committed four times (a root
port never commits):

  [    1.724285] cxl_core:cxl_probe_component_regs:97: cxl_port port2: found BI RT capability (0xaa8)
  [    1.757353] cxl_core:cxl_probe_component_regs:103: pcieport 0000:0e:00.0: found BI Decoder capability (0xab4)
  [    1.767828] cxl_core:cxl_probe_component_regs:97: cxl_port port3: found BI RT capability (0xaa8)
  [    1.797714] cxl_core:cxl_probe_component_regs:103: pcieport 0000:10:00.0: found BI Decoder capability (0xab4)
  [    1.809306] cxl_core:__cxl_bi_ctrl_endpoint:1286: cxl_pci 0000:11:00.0: adopting firmware-enabled BI

Leave only the inner route table uncommitted (fw-partial) and no level
is adopted: the adjacent DSP fails on its switch's route table, and
from there up everything is committed, the correctly staged transit
included, four commits rather than two. The device's own Enable is
still taken as found:

  [    1.936171] cxl_core:__cxl_bi_wait_commit:1058: pcieport 0000:10:00.0: BI-ID commit wait took 192789us
  [    2.135862] cxl_core:__cxl_bi_wait_commit:1058: cxl_port port3: BI-ID commit wait took 199616us
  [    2.335752] cxl_core:__cxl_bi_wait_commit:1058: pcieport 0000:0e:00.0: BI-ID commit wait took 199858us
  [    2.435437] cxl_core:__cxl_bi_wait_commit:1058: cxl_port port2: BI-ID commit wait took 99643us
  [    2.435577] cxl_core:__cxl_bi_ctrl_endpoint:1286: cxl_pci 0000:11:00.0: adopting firmware-enabled BI

Two firmware-enabled devices sharing a staged transit DSP
(fw-shared-dsp): the first adopts both of its switch levels with no
commit; the second adopts its own adjacent DSP, finds the transit
already counted, and from there up commits exactly the transit decoder
and the outer route table:

  [    1.813094] cxl_core:__cxl_bi_ctrl_endpoint:1286: cxl_pci 0000:12:00.0: adopting firmware-enabled BI
  [    2.006189] cxl_core:__cxl_bi_wait_commit:1058: pcieport 0000:0e:00.0: BI-ID commit wait took 154721us
  [    2.123792] cxl_core:__cxl_bi_wait_commit:1058: cxl_port port2: BI-ID commit wait took 117578us
  [    2.123809] cxl_core:__cxl_bi_ctrl_endpoint:1286: cxl_pci 0000:11:00.0: adopting firmware-enabled BI

Staged levels above a device firmware did not enable (fresh-dev) are
not adopted: the device is new below them, so they are committed for
it (Tables 8-152, 8-156) and the driver enables the device. They were
found up, so the unbind releases the device but leaves the DSP at
Enable, with no deallocate commit:

  [    1.830229] cxl_core:__cxl_bi_wait_commit:1058: pcieport 0000:0e:00.0: BI-ID commit wait took 145515us
  [    1.935515] cxl_core:__cxl_bi_wait_commit:1058: cxl_port port2: BI-ID commit wait took 105208us
  [    1.935587] cxl_core:__cxl_bi_ctrl_endpoint:1303: cxl_pci 0000:0f:00.0: BI requests enabled
  [   17.693540] cxl_core:__cxl_bi_ctrl_endpoint:1303: cxl_pci 0000:0f:00.0: BI requests disabled
  [   17.696025] cxl_core:cxl_detach_ep:1609: cxl_mem mem0: disconnect mem0 from port2

13. A BI decoder that outlives the driver
-----------------------------------------
An HDM decoder can keep decoding after the driver lets go: a locked
one cannot be reset, a locked region is never reset, and a committed
decoder that never joined a region is left alone. BI Enable is the
device-wide permission behind such a range, so release reads the
device's HDM decoders from the hardware (patch 2). If one is still
committed with its BI bit set, the device keeps its Enable and every
level on its path is held. The check reads the Committed and BI bits,
not the lock.

The decoder section 8 shows refused by the window stays committed
with no region (t24 fw-orphan). The unbind keeps the device's
Enable, with no "BI requests disabled", and holds the root port the
walk itself brought up; the rebind adopts it all again without a
write:

# echo 0000:0d:00.0 > /sys/bus/pci/drivers/cxl_pci/unbind
  [   17.584871] cxl_core:cxl_detach_ep:1609: cxl_mem mem0: disconnect mem0 from port1
# echo 0000:0d:00.0 > /sys/bus/pci/drivers/cxl_pci/bind
  [   20.471048] cxl_core:__cxl_bi_ctrl_endpoint:1286: cxl_pci 0000:0d:00.0: adopting firmware-enabled BI
  [   20.508076] cxl decoder0.0: mem0:decoder2.0 coherency model not permitted by the window

The same for a hot-removed device whose decoder was committed with BI
and Lock On Commit (t17 locked-remove): no disable on the way out, and
its adjacent DSP reads back Enable afterwards:

  [   36.742754] pcieport 0000:0e:02.0: pciehp: Slot(6): Button press: will power off in 5 sec
  [   41.904582] pcieport 0000:0e:02.0: pciehp: pciehp_unconfigure_device: domain:bus:dev = 0000:11:00
  [   41.913321] cxl_core:cxl_detach_ep:1609: cxl_mem mem0: disconnect mem0 from port2
  [   41.913365] cxl_core:cxl_detach_ep:1609: cxl_mem mem0: disconnect mem0 from port1
  [   41.925222] pci 0000:11:00.0: device released

A hold outlives its switch ports. With a locked BI decoder on memA and
both endpoints unbound, the switch ports are deleted; memB (mem1 below)
then binds alone through re-created dports that remember nothing (t25
nested-hold). The re-created transit reads Forward with nothing
counted, so it is held again, and is still committed for memB, a new
device below it. memB's unbind clears only its own adjacent DSP,
committing it with the inner route table; the transit keeps Forward
for memA, and the switch ports are deleted again at the end:

  [   38.495473] cxl_core:__cxl_bi_wait_commit:1058: pcieport 0000:10:00.0: BI-ID commit wait took 115255us
  [   38.599460] cxl_core:__cxl_bi_wait_commit:1058: cxl_port port3: BI-ID commit wait took 103903us
  [   38.704372] cxl_core:__cxl_bi_wait_commit:1058: pcieport 0000:0e:00.0: BI-ID commit wait took 104809us
  [   38.904649] cxl_core:__cxl_bi_wait_commit:1058: cxl_port port2: BI-ID commit wait took 200198us
  [   38.904712] cxl_core:__cxl_bi_ctrl_endpoint:1303: cxl_pci 0000:11:00.0: BI requests enabled
  [   40.902283] cxl_core:__cxl_bi_ctrl_endpoint:1303: cxl_pci 0000:11:00.0: BI requests disabled
  [   41.060586] cxl_core:__cxl_bi_wait_commit:1058: pcieport 0000:10:00.0: BI-ID commit wait took 160559us
  [   41.260825] cxl_core:__cxl_bi_wait_commit:1058: cxl_port port3: BI-ID commit wait took 203050us
  [   41.261556] cxl_core:cxl_detach_ep:1609: cxl_mem mem1: disconnect mem1 from port3
  [   41.262034] cxl_core:cxl_detach_ep:1626: cxl_mem mem1: delete port3
  [   41.271155] cxl_core:cxl_detach_ep:1626: cxl_mem mem1: delete port2

QEMU cannot stage a locked decoder, so t17 and t25 commit it from the
guest through /dev/mem. Upstream QEMU does not enforce Lock On Commit;
these runs used a QEMU carrying "hw/cxl: Enforce Lock On Commit on HDM
decoders", not yet upstream.

14. Commit faults: an unwind never holds
----------------------------------------
A failed commit restores that level's previous value, committing the
restore if the walk wrote one, and the walk unwinds through the same
release as teardown (patch 2): a level the walk brought up is cleared
and committed, a level it adopted is held and left as firmware had it,
and the device, whose Enable is the walk's last step, is never touched.
Unlike teardown, an unwind holds nothing for a decoder that already
decodes with BI: the device's BI was never taken up, so there is no path
to keep. Setup fails, the probe continues with BI off, and an HDM-DB
attach is refused.

A transit DSP that rejects every commit, above a device whose decoder
was committed with BI behind the driver (t25 live-rollback, the
rebind's walk): the adjacent DSP and inner route table are committed,
the transit rejects its commit and then the commit of its restore, the
adjacent level is cleared and committed rather than held, and the
region built from the committed decoder refuses it:

  [   19.301946] cxl_core:__cxl_bi_wait_commit:1058: pcieport 0000:10:00.0: BI-ID commit wait took 200415us
  [   19.502386] cxl_core:__cxl_bi_wait_commit:1058: cxl_port port3: BI-ID commit wait took 200233us
  [   19.702742] pcieport 0000:0e:00.0: BI-ID commit rejected by hardware
  [   19.903084] pcieport 0000:0e:00.0: BI-ID commit rejected by hardware
  [   20.103526] cxl_core:__cxl_bi_wait_commit:1058: pcieport 0000:10:00.0: BI-ID commit wait took 200294us
  [   20.303914] cxl_core:__cxl_bi_wait_commit:1058: cxl_port port3: BI-ID commit wait took 200124us
  [   20.303925] cxl_core:devm_cxl_endpoint_decoders_setup:1457: cxl_port endpoint4: BI setup failed rc=-5
  [   20.325216] cxl_core:init_hdm_decoder:1214: cxl_port endpoint4: decoder4.0: range: 0x190000000-0x1cfffffff iw: 1 ig: 256
  [   20.340658] cxl_core:cxl_region_check_coherency:2144: cxl region0: mem0:decoder4.0 BI not enabled on device
  [   20.340663] cxl_port endpoint4: failed to attach decoder4.0 to region0: -6

The two rejections are the commit of the new value and the commit of
the restored one, since restoring the register is itself a BI-ID
change; the emulated fault rejects both, where real hardware would
normally accept the restore.

15. Resets below and above a switch
-----------------------------------
The reset handling of section 9 still applies; what is new is how it
meets a switch and a held level. A reset of a device behind a switch
(t27 switch) invalidates cxlds->bi, and the unbind that follows
leaves the device alone, its Enable already clear, while still clearing
the DSP the driver brought up and committing it with its route table:

  [   17.220400] cxl_pci 0000:0f:00.0: resetting
  [   17.221471] cxl_pci 0000:0f:00.0: reset via cxl_bus
  [   17.227903] cxl_pci 0000:0f:00.0: BI disabled by reset
  [   19.714878] cxl_core:__cxl_bi_wait_commit:1058: pcieport 0000:0e:00.0: BI-ID commit wait took 200819us
  [   19.915605] cxl_core:__cxl_bi_wait_commit:1058: cxl_port port2: BI-ID commit wait took 200509us
  [   19.921869] cxl_core:cxl_detach_ep:1609: cxl_mem mem0: disconnect mem0 from port2

When that DSP was staged by firmware (t27 held-reset), it was found up
and is held: after the same reset the unbind leaves the device alone,
the DSP reads back Enable, and only the root port the driver brought
up is cleared. The rebind adopts nothing, since the reset cleared the
device's Enable, and commits the held DSP and its route table again,
the device being new below them:

  [   23.155746] cxl_core:__cxl_bi_wait_commit:1058: pcieport 0000:0e:00.0: BI-ID commit wait took 200933us
  [   23.356282] cxl_core:__cxl_bi_wait_commit:1058: cxl_port port2: BI-ID commit wait took 200309us
  [   23.356364] cxl_core:__cxl_bi_ctrl_endpoint:1303: cxl_pci 0000:0f:00.0: BI requests enabled

A bus reset issued from the root port, above the switch (t27
switch-sbr), wipes the switch's BI Decoder and route table with the
device, while the root port keeps Forward. Only the device's .reset_done
sees it, so the dports keep their counts and the unbind still reaches
the root port and clears it. The rebind finds nothing up and programs
the switch from scratch, and an HDM-DB region commits:

  [   27.466061] cxl_core:__cxl_bi_wait_commit:1058: pcieport 0000:0e:00.0: BI-ID commit wait took 200541us
  [   27.666632] cxl_core:__cxl_bi_wait_commit:1058: cxl_port port2: BI-ID commit wait took 200227us
  [   27.666742] cxl_core:__cxl_bi_ctrl_endpoint:1303: cxl_pci 0000:0f:00.0: BI requests enabled
  [   32.146539] cxl_core:devm_cxl_add_region:2921: cxl_acpi ACPI0017:00: decoder0.0: created HDM-DB region0

Applies against Linus' latest. Please consider for v7.5.

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
  cxl: Handle auto-committed BI hdm decoders
  cxl/test: Add mock BI topology support
  cxl/doc: Update maturity map with BI support

 Documentation/ABI/testing/sysfs-bus-cxl       |  22 +
 Documentation/driver-api/cxl/maturity-map.rst |  16 +-
 drivers/cxl/acpi.c                            |  18 +-
 drivers/cxl/core/core.h                       |  10 +
 drivers/cxl/core/hdm.c                        | 122 +++-
 drivers/cxl/core/pci.c                        | 583 ++++++++++++++++++
 drivers/cxl/core/port.c                       |  48 +-
 drivers/cxl/core/region.c                     | 168 ++++-
 drivers/cxl/core/regs.c                       |  14 +
 drivers/cxl/cxl.h                             |  66 +-
 drivers/cxl/cxlmem.h                          |   2 +
 drivers/cxl/pci.c                             |   8 +-
 drivers/cxl/port.c                            |  46 ++
 include/cxl/cxl.h                             |  13 +-
 tools/testing/cxl/Kbuild                      |   1 +
 tools/testing/cxl/test/accel.c                |   2 +-
 tools/testing/cxl/test/cxl.c                  | 149 ++++-
 tools/testing/cxl/test/mock.c                 |  13 +
 tools/testing/cxl/test/mock.h                 |   1 +
 19 files changed, 1251 insertions(+), 51 deletions(-)

-- 
2.39.5

