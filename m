Received: from silver.cherry.relay.mailchannels.net (silver.cherry.relay.mailchannels.net [23.83.223.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B112E975E
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jun 2026 01:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.223.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780622021; cv=none; b=DcsPKFqjDjX9PhcS+wAC02SRnOeogeKEovfuerotRrePSm0CjB+Ut1vhfxxLHM/KbcwuvhHaM6rlddFrzasxPnzR7w7SfkA2UQLpqI6Gc4+N/zao99i1XwMkyIdgyJ4MxX9zJGmPZhmmq5BXklKkfRSrrT5fObNUB9DgqLYKuPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780622021; c=relaxed/simple;
	bh=IvEWLsEn3GToZDqNoijE+r8WSgzm4tr0FwQosqjo1Og=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IhMq/hO+qMj3aLwopv5uC/T0eFYPqwRHoV6N6GzvN/SWBhkeSNX2zy14zGV1pn/royAB+f0rBSPc4cuwKK/xJl/kEt6T6ZjaZAHfYfmHRCnJgR36ajema3OyNGa3XF1ARATItE2MpOqKItmk8EsmMyQT06bW7jjbPjSuMXcXPPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=H0dgU04x; arc=none smtp.client-ip=23.83.223.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="H0dgU04x"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id B801A461E14;
	Fri, 05 Jun 2026 00:33:58 +0000 (UTC)
Received: from pdx1-sub0-mail-a258.dreamhost.com (trex-green-6.trex.outbound.svc.cluster.local [100.105.222.229])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id E0762461E37;
	Fri, 05 Jun 2026 00:33:57 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Oafish-Belong: 21d3a1c00c50c01a_1780619638558_2018322751
X-MC-Loop-Signature: 1780619638557:463131696
X-MC-Ingress-Time: 1780619638557
Received: from pdx1-sub0-mail-a258.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.105.222.229 (trex/7.1.5);
	Fri, 05 Jun 2026 00:33:58 +0000
Received: from localhost.localdomain (186-79-219-2.fo.baf.movistar.cl [186.79.219.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a258.dreamhost.com (Postfix) with ESMTPSA id 4gWj9F74B6z1040;
	Thu,  4 Jun 2026 17:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1780619637;
	bh=WAIDPMq/oiL7jrm0+ND53eL5wPjSqENNYdg3guECuOc=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=H0dgU04x9KaId/EyLOlqP0U96Evh+GA2kxZDKaqUvEZAm4FdSn0BDKsbU8gS7oERc
	 11COaPWXAtPkeC4vZzIubOpgq+2BPWR2EW/U+S9RDcEptYYEfKQAMqI+OWTHP7fD0u
	 t6cMnRcVe4ZjN2m6Rziwb8Z3MWvNvO+RazsRp6FK8pXwcOX6gnTaktVw0yGKf6m4KG
	 UTH/fCDXd++W1n+xNyPDPeNfHbzXsOCTs8n8FivalbDEXNjvx/TwUN1soBpJHW6ND8
	 ZVUvIEvQrsOkNce+ydYeohEy/H0JTuY4dkFO34EE+o3JrHpQJIJsoJSETmmrbOK37l
	 X9hrpn/fT625Q==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com,
	djbw@kernel.org
Cc: jic23@kernel.org,
	benjamin.cheatham@amd.com,
	alucerop@amd.com,
	alison.schofield@intel.com,
	gourry@gourry.net,
	dongjoo.seo1@samsung.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org
Subject: [PATCH v4 0/5] cxl: Support Back-Invalidate
Date: Thu,  4 Jun 2026 17:33:24 -0700
Message-Id: <20260605003329.2584012-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

Changes from v3 (https://lore.kernel.org/all/20260516022037.1761453-1-dave@stgolabs.net/):
 - In patch 1, map BI Decoder of root port/DSP at dport creation time
   in cxl_port_add_dport() (Ben).
 - In patch 2, BI rt/decoder commit logic to be a function instead
   of a macro approach. (Dave)
 - Patch 4 is reworked to have endpoint decoders use the coherency
   model based on the root decoder's cfmw restrictions (Dan).   
 - Folded patch 5 into patch 2 (Dave)
 - Moved 'nr_bi' counter from port to dport (Sashiko).
 - Added a new patch 5 for a trivial flag rename.

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

The idea is for Type 3 memdevs and future Type 2 devices to make use
of cxlds->bi when committing HDM decoders, such that different device
coherence models can be differentiated as:

	type2 hdm-d:  cxlds->type == CXL_DEVTYPE_DEVMEM && cxlds->bi == false
	type2 hdm-db: cxlds->type == CXL_DEVTYPE_DEVMEM && cxlds->bi == true
	type3 hdm-h:  cxlds->type == CXL_DEVTYPE_CLASSMEM && cxlds->bi == false
	type3 hdm-db: cxlds->type == CXL_DEVTYPE_CLASSMEM && cxlds->bi == true

Because ->bi becoming true does not depend on auto-committing upon HDM
decoder enumeration (port driver), for now an already-committed BI
decoder during enumeration is unsupported and the driver errors out.

o Patch 1 probes BI capabilities during register discovery, and maps BI
  Decoder registers.
  
o Patch 2 implements the BI-ID allocation (and deallocation).
  
o Patch 3 adds coherency support for endpoint decoders based on what the
root decoder restricts.

o Patch 4 adds support for HDM-DB region creation.

o Patch 5 trivially renames some coherency flags.

Testing has been done with the qemu HDM-DB Type 3 counterpart + this series:
  https://lore.kernel.org/all/20260602231806.2469011-1-dave@stgolabs.net/

1. HDM Decoder with BI through ad-hoc region creation.
------------------------------------------------------
# cxl list -D
[
  {
    "decoder":"decoder0.0",
    "resource":4563402752,
    "size":10737418240,
    "interleave_ways":1,
    "accelmem_capable":true,
    "nr_targets":1
  }
]

# ROOT=/sys/bus/cxl/devices/decoder0.0
# EP=/sys/bus/cxl/devices/decoder2.0
# echo region0 > $ROOT/create_ram_region
# REG=/sys/bus/cxl/devices/region0
# echo ram > $EP/mode
# echo 0x40000000 > $EP/dpa_size
# echo 1 > $REG/interleave_ways
# echo 4096 > $REG/interleave_granularity
# echo 0x40000000 > $REG/size
# cat $EP/bi
0
# echo decoder2.0 > $REG/target0
[   53.495224] cxl_core:cxl_port_attach_region:1290: cxl region0: mem0:endpoint2 decoder2.0 add: mem0:decoder2.0 @ 0 next: none nr_eps:1
[   53.497758] cxl_core:cxl_port_attach_region:1290: cxl region0: pci0000:0c:port1 decoder1.0 add: mem0:decoder2.0 @ 0 next: mem0 nr_ep1
[   53.499892] cxl_core:cxl_port_setup_targets:1608: cxl region0: pci0000:0c:port1 iw: 1 ig: 4096
[   53.501233] cxl_core:cxl_port_setup_targets:1633: cxl region0: pci0000:0c:port1 target[0] = 0000:0c:00.0 for mem0:decoder2.0 @ 0
[   53.502985] cxl_core:cxl_calc_interleave_pos:2003: cxl_mem mem0: decoder:decoder2.0 parent:0000:0d:00.0 port:endpoint2 range:0x110000
[   53.504895] cxl_core:cxl_region_attach:2226: cxl decoder2.0: Test cxl_calc_interleave_pos(): success test_pos:0 cxled->pos:0
# cat $EP/bi
1
# echo 1 > $REG/commit
# cxl list -D
[
  {
    "root decoders":[
      {
        "decoder":"decoder0.0",
        "resource":4563402752,
        "size":10737418240,
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
        "resource":4563402752,
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
        "resource":4563402752,
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
# echo decoder2.0 > $REG/target0
[  104.557797] cxl region0: mem0:decoder2.0 BI not enabled on device
[  104.561014] cxl_port endpoint2: failed to attach decoder2.0 to region0: -6

3. Type3 device supports BI but CFMW does not, create HDM-H region
------------------------------------------------------------------
# cxl list -D
[
  {
    "decoder":"decoder0.0",
    "resource":4563402752,
    "size":10737418240,
    "interleave_ways":1,
    "max_available_extent":10737418240,
    "pmem_capable":true,
    "volatile_capable":true,
    "nr_targets":1
  }
]
# echo decoder2.0 > $REG/target0
[  124.712027] cxl_core:cxl_port_attach_region:1290: cxl region0: mem0:endpoint2 decoder2.0 add: mem0:decoder2.0 @ 0 next: none nr_eps:1
[  124.714329] cxl_core:cxl_port_attach_region:1290: cxl region0: pci0000:0c:port1 decoder1.0 add: mem0:decoder2.0 @ 0 next: mem0 nr_ep1
[  124.716407] cxl_core:cxl_port_setup_targets:1608: cxl region0: pci0000:0c:port1 iw: 1 ig: 4096
[  124.718269] cxl_core:cxl_port_setup_targets:1633: cxl region0: pci0000:0c:port1 target[0] = 0000:0c:00.0 for mem0:decoder2.0 @ 0
[  124.722076] cxl_core:cxl_calc_interleave_pos:2003: cxl_mem mem0: decoder:decoder2.0 parent:0000:0d:00.0 port:endpoint2 range:0x110000
[  124.724454] cxl_core:cxl_region_attach:2226: cxl decoder2.0: Test cxl_calc_interleave_pos(): success test_pos:0 cxled->pos:0
# cxl list -D
[
  {
    "root decoders":[
      {
        "decoder":"decoder0.0",
        "resource":4563402752,
        "size":10737418240,
        "interleave_ways":1,
        "max_available_extent":9663676416,
        "pmem_capable":true,
        "volatile_capable":true,
        "nr_targets":1
      }
    ]
  },
  {
    "port decoders":[
      {
        "decoder":"decoder1.0",
        "resource":4563402752,
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
        "resource":4563402752,
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


3. Unbind + Bind
----------------
# echo mem0 > /sys/bus/cxl/drivers/cxl_mem/unbind
[ 64.553865] cxl_core:__cxl_bi_ctrl_endpoint:1163: cxl_pci 0000:0d:00.0: BI requests disabled
[ 64.557464] cxl_core:cxl_port_commit_reap:898: cxl_port port1: reap: decoder1.0 commit_end: -1
[ 64.559529] cxl_core:cxl_port_commit_reap:898: cxl_port endpoint2: reap: decoder2.0 commit_end: -1
[ 64.563576] cxl_core:cxl_detach_ep:1541: cxl_mem mem0: disconnect mem0 from port1

 echo mem0 > /sys/bus/cxl/drivers/cxl_mem/bind
[ 5073.975585] cxl_core:devm_cxl_enumerate_ports:1856: cxl_mem mem0: scan: iter: mem0 dport_dev: 0000:0c:00.0 parent: pci0000:0c
[ 5073.978125] cxl_core:devm_cxl_enumerate_ports:1862: cxl_mem mem0: found already registered port port1:pci0000:0c
[ 5073.980013] cxl_core:cxl_port_alloc:752: cxl_mem mem0: host-bridge: pci0000:0c
[ 5073.982601] cxl_core:cxl_cdat_get_length:488: cxl_port endpoint2: CDAT length 160
[ 5073.988634] cxl_core:cxl_port_perf_data_calculate:207: cxl_port endpoint2: Failed to retrieve ep perf coordinates.
[ 5073.991824] cxl_core:cxl_endpoint_parse_cdat:423: cxl_port endpoint2: Failed to do perf coord calculations.
[ 5074.016377] cxl_core:init_hdm_decoder:1112: cxl_port endpoint2: decoder2.0: range: 0x0-0xffffffffffffffff iw: 1 ig: 4096
[ 5074.021643] cxl_core:add_hdm_decoder:39: cxl_mem mem0: decoder2.0 added to endpoint2
[ 5074.023072] cxl_core:init_hdm_decoder:1112: cxl_port endpoint2: decoder2.1: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
[ 5074.025527] cxl_core:add_hdm_decoder:39: cxl_mem mem0: decoder2.1 added to endpoint2
[ 5074.027751] cxl_core:init_hdm_decoder:1112: cxl_port endpoint2: decoder2.2: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
[ 5074.032182] cxl_core:add_hdm_decoder:39: cxl_mem mem0: decoder2.2 added to endpoint2
[ 5074.033535] cxl_core:init_hdm_decoder:1112: cxl_port endpoint2: decoder2.3: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
[ 5074.035690] cxl_core:add_hdm_decoder:39: cxl_mem mem0: decoder2.3 added to endpoint2
[ 5074.036904] cxl_core:cxl_bus_probe:2281: cxl_port endpoint2: probe: 0
[ 5074.038017] cxl_core:devm_cxl_add_port:960: cxl_mem mem0: endpoint2 added to port1
[ 5074.039153] cxl_core:__cxl_bi_ctrl_endpoint:1163: cxl_pci 0000:0d:00.0: BI requests enabled
[ 5074.040168] cxl_core:cxl_bus_probe:2281: cxl_mem mem0: probe: 0


4. Discovery behind a Switch
----------------------------
# dmesg | grep BI
[    0.628477] cxl_core:cxl_probe_component_regs:102: cxl_pci 0000:0f:00.0: found BI Decoder capability (0xab4)
[    0.737987] cxl_core:cxl_probe_component_regs:102: pcieport 0000:0c:00.0: found BI Decoder capability (0xab4)
[    0.747784] cxl_port:cxl_port_map_bi:109: cxl_port port2: BI RT registers not found
[    0.755151] cxl_core:cxl_probe_component_regs:96: cxl_port port2: found BI RT capability (0xaa8)
[    0.790106] cxl_core:cxl_probe_component_regs:102: pcieport 0000:0e:00.0: found BI Decoder capability (0xab4)
[    0.943920] cxl_core:__cxl_bi_wait_commit:994: pcieport 0000:0e:00.0: BI-ID commit wait took 101750us
[    0.944767] cxl_core:__cxl_bi_ctrl_endpoint:1163: cxl_pci 0000:0f:00.0: BI requests enabled

5. Corrupted hw (commit timeout handling)
-----------------------------------------
[    0.617234] cxl_core:cxl_probe_component_regs:102: cxl_pci 0000:0f:00.0: found BI Decoder capability (0xab4)
[    0.706959] cxl_core:cxl_probe_component_regs:102: pcieport 0000:0c:00.0: found BI Decoder capability (0xab4)
[    0.718585] cxl_port:cxl_port_map_bi:109: cxl_port port2: BI RT registers not found
[    0.743932] cxl_core:cxl_probe_component_regs:96: cxl_port port2: found BI RT capability (0xaa8)
[    0.783715] cxl_core:cxl_probe_component_regs:102: pcieport 0000:0e:00.0: found BI Decoder capability (0xab4)
[    2.994821] cxl_core:__cxl_bi_wait_commit:985: pcieport 0000:0e:00.0: BI-ID commit timed out (2000000us)
[    5.010606] cxl_core:__cxl_bi_wait_commit:985: pcieport 0000:0e:00.0: BI-ID commit timed out (2000000us)
[    5.013423] cxl_mem:cxl_mem_probe:155: cxl_mem mem0: BI setup failed rc=-110

6. Mixed Configurations (BI-capable Type 3 but DSP 68b)
-------------------------------------------------------
[    0.837902] cxl_mem:cxl_mem_probe:155: cxl_mem mem0: BI setup failed rc=-22


Applies against 'next' branch from cxl.git.

[0] https://lore.kernel.org/linux-cxl/20260428200410.705675-1-dave@stgolabs.net/

Thanks!

Davidlohr Bueso (5):
  cxl: Add BI register probing and port initialization
  cxl/pci: Add BI topology enable/disable
  cxl/hdm: Add BI coherency support for endpoint decoders
  cxl: Add HDM-DB region creation
  cxl/hdm: Rename decoder coherency flags

 Documentation/ABI/testing/sysfs-bus-cxl |  18 +-
 drivers/cxl/acpi.c                      |  15 +-
 drivers/cxl/core/hdm.c                  |  38 ++-
 drivers/cxl/core/pci.c                  | 365 ++++++++++++++++++++++++
 drivers/cxl/core/port.c                 |  33 ++-
 drivers/cxl/core/region.c               |  51 ++--
 drivers/cxl/core/regs.c                 |  14 +
 drivers/cxl/cxl.h                       |  45 ++-
 drivers/cxl/cxlmem.h                    |   2 +
 drivers/cxl/mem.c                       |   4 +
 drivers/cxl/port.c                      |  71 +++++
 include/cxl/cxl.h                       |   8 +
 12 files changed, 631 insertions(+), 33 deletions(-)

-- 
2.39.5

