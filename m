Received: from shrimp.cherry.relay.mailchannels.net (shrimp.cherry.relay.mailchannels.net [23.83.223.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF867448BBD
	for <linux-cxl@vger.kernel.org>; Tue, 28 Jul 2026 14:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.223.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785249710; cv=none; b=WkGUmS3UqSfH3an5KjHSvEQK8CO8EoQqKgn+UilTOcHwLVdvq5jK63K+92eI3t5NRHufwvDSOADRDJVj6E+7bllyUdlIvqTu53kSUxfy6Pec0leyi2O1f3cZRE64vsIrhSe+zH1oa3hMw9UXJzZXKZdvvv1SD8za0YnzAUfDYn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785249710; c=relaxed/simple;
	bh=fJBNvw2F+6gakPYpU1EFasMVbvsbqZu60vswHh9iGog=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cAtilPAIHvWjVO1mLu1VgPD8f5Hu2FW4ZchQK6dV6AHSyRuHTwQwONJLcOQSmdP6dcjuiUcDGke9CtQsnw1zBCjaZwYbgJJku+0+uGwWdaWs+sz974QU4ve/IITGFBdiQedf8fWCQ1eRnVb+35x9p0v16gKxFxubpxf2x8p8Hak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=C3miZxNU; arc=none smtp.client-ip=23.83.223.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="C3miZxNU"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id DC7794224B;
	Tue, 28 Jul 2026 14:41:47 +0000 (UTC)
Received: from pdx1-sub0-mail-a216.dreamhost.com (trex-green-7.trex.outbound.svc.cluster.local [100.111.244.85])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 7085E41DA1;
	Tue, 28 Jul 2026 14:41:46 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Belong-Share: 0ddabf48401c8326_1785249706620_804313506
X-MC-Loop-Signature: 1785249706620:3588340614
X-MC-Ingress-Time: 1785249706619
Received: from pdx1-sub0-mail-a216.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.111.244.85 (trex/8.0.2);
	Tue, 28 Jul 2026 14:41:46 +0000
Received: from offworld.lan (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a216.dreamhost.com (Postfix) with ESMTPSA id 4h8dT559KBz2N;
	Tue, 28 Jul 2026 07:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1785249706;
	bh=kPw/B0C1wJUUsM7keHisZwmswFMn7O0YyxaKyaiaqqc=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=C3miZxNUeLicizZIe8FZXg3WCoWRHa11zg2y4GPVilCsgkiinI24tWjPnFImPM395
	 JqvcNInNLJP9hXXSDdXOtXOBlmENqAkTTWFy5GQIPDeSv3y780qDvYXO/BSeivrtoQ
	 EThWzI5ycLPC36hSby8cax2KmveLBtGxThtQQK8UHVZpz50+1fPNbK7+1UqWQT1gvs
	 WqnhTUTkC3OzEmLWzLZUFWoJLElqhwY5mNJDe5Xumq0DnBFFfg8k5ys0TuN79Ygn2B
	 SIwyx4M5Dk4MeDuEpxZzAoTUfXikOiGmtK6m9X9Mq6Eb6Mvec9HefymCoRnkVbgYtq
	 Lv5UTz1cwzbXg==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com
Cc: jic23@kernel.org,
	alison.schofield@intel.com,
	icheng@nvidia.com,
	benjamin.cheatham@amd.com,
	alucerop@amd.com,
	dongjoo.seo1@samsung.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org
Subject: [PATCH v7 0/8] cxl: Support Back-Invalidate
Date: Tue, 28 Jul 2026 07:41:28 -0700
Message-Id: <20260728144136.709882-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

Changes from v6 (https://lore.kernel.org/all/20260727193601.651871-1-dave@stgolabs.net/):
  - Consolidated the BI setup/teardown into patch 2, using the
    endpoint port lifecycle from the start. Patch 7 is folded into patch 2.
  - Patch 3's BOTH-coherency comment moved to patch 4, where the
    behavior it describes lands (Sashiko).
  - Patch 4 drops the endpoint type-mismatch assertion: we already 
    rejected by the region attach checks.
  - Patch 4 restores the endpoint default target_type on a failed
    attach, not just on detach (Sashiko).

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

Unlike previous versions, an auto-committed BI decoder found during
enumeration is no longer rejected: patches 7-8 adopt the inherited
configuration when the device and path are BI capable, refusing only
broken combinations. See the auto-discovery tests section below.

o Patch 1 probes BI capabilities during register discovery, and maps BI
  Decoder registers.

o Patch 2 implements the BI-ID allocation (and deallocation) from
  the endpoint port's lifecycle.

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

Testing
-------

Testing has been done on top of upstream qemu with the CFMW options series:

  https://lore.kernel.org/all/20260720233242.901544-1-dave@stgolabs.net/

A new qemu-based test suite has been added for full automation and pounding,
covering many topologies and corner cases:

  https://github.com/davidlohr/cxl-bi-tests

This passes regression testing (nothing breaks) ndctl suite via cxl_test.

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
[    7.662871] cxl_core:devm_cxl_add_region:2824: cxl_acpi ACPI0017:00: decoder0.0: created HDM-DB region0
# REG=/sys/bus/cxl/devices/region0
# echo ram > $EP/mode
# echo 0x40000000 > $EP/dpa_size
# echo 1 > $REG/interleave_ways
# echo 4096 > $REG/interleave_granularity
# echo 0x40000000 > $REG/size
# cat $EP/bi
0
# echo decoder2.0 > $REG/target0
[    8.153566] cxl_core:cxl_port_attach_region:1288: cxl region0: mem0:endpoint2 decoder2.0 add: mem0:decoder2.0 @ 0 next: none nr_eps: 1 nr_targets: 1
[    8.157683] cxl_core:cxl_port_attach_region:1288: cxl region0: pci0000:0c:port1 decoder1.0 add: mem0:decoder2.0 @ 0 next: mem0 nr_eps: 1 nr_targets: 1
[    8.159570] cxl_core:cxl_port_setup_targets:1623: cxl region0: pci0000:0c:port1 iw: 1 ig: 4096
[    8.160487] cxl_core:cxl_port_setup_targets:1631: cxl region0: pci0000:0c:port1 target[0] = 0000:0c:00.0 for mem0:decoder2.0 @ 0
[    8.161759] cxl_core:cxl_calc_interleave_pos:2041: cxl_mem mem0: decoder:decoder2.0 parent:0000:0d:00.0 port:endpoint2 range:0x190000000-0x1cfffffff pos:0
[    8.163681] cxl_core:cxl_region_attach:2265: cxl decoder2.0: Test cxl_calc_interleave_pos(): success test_pos:0 target->pos:0
# cat $EP/bi
1
# echo 1 > $REG/commit
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
# echo decoder2.0 > $REG/target0
[    7.311927] cxl region0: mem0:decoder2.0 BI not enabled on device
[    7.313907] cxl_port endpoint2: failed to attach decoder2.0 to region0: -6

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
[    7.679496] cxl_core:devm_cxl_add_region:2824: cxl_acpi ACPI0017:00: decoder0.0: created HDM-H region0
# cat $EP/bi
0
# echo decoder2.0 > $REG/target0
[    8.165400] cxl_core:cxl_port_attach_region:1288: cxl region0: mem0:endpoint2 decoder2.0 add: mem0:decoder2.0 @ 0 next: none nr_eps: 1 nr_targets: 1
[    8.167128] cxl_core:cxl_port_attach_region:1288: cxl region0: pci0000:0c:port1 decoder1.0 add: mem0:decoder2.0 @ 0 next: mem0 nr_eps: 1 nr_targets: 1
[    8.168834] cxl_core:cxl_port_setup_targets:1623: cxl region0: pci0000:0c:port1 iw: 1 ig: 4096
[    8.169893] cxl_core:cxl_port_setup_targets:1631: cxl region0: pci0000:0c:port1 target[0] = 0000:0c:00.0 for mem0:decoder2.0 @ 0
[    8.171302] cxl_core:cxl_calc_interleave_pos:2041: cxl_mem mem0: decoder:decoder2.0 parent:0000:0d:00.0 port:endpoint2 range:0x190000000-0x1cfffffff pos:0
[    8.173036] cxl_core:cxl_region_attach:2265: cxl decoder2.0: Test cxl_calc_interleave_pos(): success test_pos:0 target->pos:0
# echo 1 > $REG/commit
# cat $EP/bi
0

4. Unbind + Bind
----------------
# echo mem0 > /sys/bus/cxl/drivers/cxl_mem/unbind
[    7.645330] cxl_core:__cxl_bi_ctrl_endpoint:1218: cxl_pci 0000:0d:00.0: BI requests disabled
[    7.648838] cxl_core:cxl_port_commit_reap:900: cxl_port endpoint2: reap: decoder2.0 commit_end: -1
[    7.651284] cxl_core:cxl_detach_ep:1556: cxl_mem mem0: disconnect mem0 from port1

# echo mem0 > /sys/bus/cxl/drivers/cxl_mem/bind
[    8.909437] cxl_core:devm_cxl_enumerate_ports:1871: cxl_mem mem0: scan: iter: mem0 dport_dev: 0000:0c:00.0 parent: pci0000:0c
[    8.911170] cxl_core:devm_cxl_enumerate_ports:1877: cxl_mem mem0: found already registered port port1:pci0000:0c
[    8.945969] cxl_core:init_hdm_decoder:1128: cxl_port endpoint2: decoder2.0: range: 0x0-0xffffffffffffffff iw: 1 ig: 4096
[    8.949705] cxl_core:add_hdm_decoder:39: cxl_mem mem0: decoder2.0 added to endpoint2
[    8.960378] cxl_core:__cxl_bi_ctrl_endpoint:1218: cxl_pci 0000:0d:00.0: BI requests enabled
[    8.961196] cxl_core:cxl_bus_probe:2299: cxl_port endpoint2: probe: 0
[    8.962592] cxl_core:cxl_bus_probe:2299: cxl_mem mem0: probe: 0

The same applies to the endpoint port, with the memdev rebind recovering the endpoint:

# echo endpoint2 > /sys/bus/cxl/drivers/cxl_port/unbind
[   10.483509] cxl_core:__cxl_bi_ctrl_endpoint:1218: cxl_pci 0000:0d:00.0: BI requests disabled
[   10.487570] cxl_core:cxl_port_commit_reap:900: cxl_port endpoint2: reap: decoder2.0 commit_end: -1
[   10.491501] cxl_core:cxl_detach_ep:1556: cxl_mem mem0: disconnect mem0 from port1

# echo mem0 > /sys/bus/cxl/drivers/cxl_mem/bind
[   11.754957] cxl_core:devm_cxl_enumerate_ports:1871: cxl_mem mem0: scan: iter: mem0 dport_dev: 0000:0c:00.0 parent: pci0000:0c
[   11.756343] cxl_core:devm_cxl_enumerate_ports:1877: cxl_mem mem0: found already registered port port1:pci0000:0c
[   11.789821] cxl_core:init_hdm_decoder:1128: cxl_port endpoint2: decoder2.0: range: 0x0-0xffffffffffffffff iw: 1 ig: 4096
[   11.794674] cxl_core:add_hdm_decoder:39: cxl_mem mem0: decoder2.0 added to endpoint2
[   11.805772] cxl_core:__cxl_bi_ctrl_endpoint:1218: cxl_pci 0000:0d:00.0: BI requests enabled
[   11.806810] cxl_core:cxl_bus_probe:2299: cxl_port endpoint2: probe: 0
[   11.808661] cxl_core:cxl_bus_probe:2299: cxl_mem mem0: probe: 0

From a cold boot, without a region ever created, the endpoint port
unbind only disables BI - there is no committed decoder to reap:

# echo endpoint2 > /sys/bus/cxl/drivers/cxl_port/unbind
[   22.046813] cxl_core:__cxl_bi_ctrl_endpoint:1218: cxl_pci 0000:0d:00.0: BI requests disabled
[   22.049676] cxl_core:cxl_detach_ep:1556: cxl_mem mem0: disconnect mem0 from port1

# echo mem0 > /sys/bus/cxl/drivers/cxl_mem/bind
[   24.270628] cxl_core:devm_cxl_enumerate_ports:1871: cxl_mem mem0: scan: iter: mem0 dport_dev: 0000:0c:00.0 parent: pci0000:0c
[   24.273682] cxl_core:devm_cxl_enumerate_ports:1877: cxl_mem mem0: found already registered port port1:pci0000:0c
[   24.312426] cxl_core:init_hdm_decoder:1128: cxl_port endpoint2: decoder2.0: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
[   24.315677] cxl_core:add_hdm_decoder:39: cxl_mem mem0: decoder2.0 added to endpoint2
[   24.332406] cxl_core:__cxl_bi_ctrl_endpoint:1218: cxl_pci 0000:0d:00.0: BI requests enabled
[   24.334427] cxl_core:cxl_bus_probe:2299: cxl_port endpoint2: probe: 0
[   24.337952] cxl_core:cxl_bus_probe:2299: cxl_mem mem0: probe: 0

5. Discovery behind a Switch
----------------------------
[    0.782301] cxl_core:cxl_probe_component_regs:102: cxl_pci 0000:0f:00.0: found BI Decoder capability (0xab4)
[    0.851085] cxl_core:cxl_probe_component_regs:102: pcieport 0000:0c:00.0: found BI Decoder capability (0xab4)
[    0.866840] cxl_core:cxl_probe_component_regs:96: cxl_port port2: found BI RT capability (0xaa8)
[    0.902485] cxl_core:cxl_probe_component_regs:102: pcieport 0000:0e:00.0: found BI Decoder capability (0xab4)
[    1.221118] cxl_core:__cxl_bi_wait_commit:1032: pcieport 0000:0e:00.0: BI-ID commit wait took 250908us
[    1.368581] cxl_core:__cxl_bi_wait_commit:1032: cxl_port port2: BI-ID commit wait took 146455us
[    1.371579] cxl_core:__cxl_bi_ctrl_endpoint:1218: cxl_pci 0000:0f:00.0: BI requests enabled

6. Corrupted hw (commit timeout handling)
-----------------------------------------
[    1.003566] cxl_core:cxl_probe_component_regs:102: pcieport 0000:0e:00.0: found BI Decoder capability (0xab4)
[    3.203147] pcieport 0000:0e:00.0: BI-ID commit timed out (2000000us)
[    3.206048] cxl_port:cxl_endpoint_port_probe:190: cxl_port endpoint3: BI setup failed rc=-110

7. Mixed Configurations (BI-capable Type 3 but DSP 68b)
-------------------------------------------------------
[    0.837902] cxl_mem:cxl_mem_probe:155: cxl_mem mem0: BI setup failed rc=-22

8. Auto-discovered (committed) BI decoders
------------------------------------------
For testing, qemu hack emulates auto-committed decoder:

[    0.670374] cxl_core:devm_cxl_switch_port_decoders_setup:1282: cxl_port port1: Fallback to passthrough decoder
[    0.718374] cxl_core:init_hdm_decoder:1128: cxl_port endpoint2: decoder2.0: range: 0x190000000-0x19fffffff iw: 1 ig: 256
[    0.728498] cxl_core:__cxl_bi_ctrl_endpoint:1200: cxl_pci 0000:0d:00.0: adopting firmware-enabled BI
[    0.730880] cxl_core:devm_cxl_add_region:2824: cxl_acpi ACPI0017:00: decoder0.0: created HDM-DB region0
[    0.731906] cxl_core:__construct_region:3810: cxl_pci 0000:0d:00.0: mem0:decoder2.0: __construct_region region0 res: [mem 0x190000000-0x19fffffff flags 0x200] iw: 1 ig: 256
[    0.734473] cxl_core:cxl_region_sort_targets:2071: cxl region0: region sort successful
[    0.739452] cxl_core:devm_cxl_add_dax_region:101: cxl_region region0: region0: register dax_region0
[    0.740239] cxl_core:cxl_bus_probe:2299: cxl_region region0: probe: 0
# cat /sys/bus/cxl/devices/region0/commit
1
# cat /sys/bus/cxl/devices/decoder2.0/bi
1

A committed BI decoder under a window without the BI restriction is
refused at region assembly:

[    0.794477] cxl_core:__cxl_bi_ctrl_endpoint:1200: cxl_pci 0000:0d:00.0: adopting firmware-enabled BI
[    0.795396] cxl_pci 0000:0d:00.0: mem0:decoder2.0 BI decoder in a non-BI window
[    0.796050] cxl_port:discover_region:55: cxl decoder2.0: failed to add to region: 0x190000000-0x19fffffff

Applies against v7.2-rc5. Please consider for v7.3.

[0] https://lore.kernel.org/linux-cxl/20260428200410.705675-1-dave@stgolabs.net/

Thanks!

Davidlohr Bueso (8):
  cxl: Add BI register probing and port initialization
  cxl/pci: Add BI topology enable/disable
  cxl/hdm: Add BI coherency support for endpoint decoders
  cxl: Add HDM-DB region creation
  cxl/hdm: Rename decoder coherency flags
  cxl/region: Log the coherency model at region creation
  cxl/pci: Split BI capability probe from setup
  cxl: Allow auto-committed BI hdm decoders

 Documentation/ABI/testing/sysfs-bus-cxl |  18 +-
 drivers/cxl/acpi.c                      |  19 +-
 drivers/cxl/core/core.h                 |   2 +
 drivers/cxl/core/hdm.c                  |  68 ++++-
 drivers/cxl/core/pci.c                  | 456 ++++++++++++++++++++++++++++++++
 drivers/cxl/core/port.c                 |  48 +++-
 drivers/cxl/core/region.c               | 106 ++++++--
 drivers/cxl/core/regs.c                 |  14 +
 drivers/cxl/cxl.h                       |  55 +++-
 drivers/cxl/cxlmem.h                    |   2 +
 drivers/cxl/port.c                      |  54 ++++
 include/cxl/cxl.h                       |  10 +
 12 files changed, 810 insertions(+), 42 deletions(-)

--
2.39.5
