Received: from black.elm.relay.mailchannels.net (black.elm.relay.mailchannels.net [23.83.212.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49FD395D8B
	for <linux-cxl@vger.kernel.org>; Tue, 22 Sep 2026 23:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.212.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790120820; cv=none; b=SuKevKN/AsseXbqV3V5XfJpvRUBQIp2rkuv4aPMLbtuPbl4SY05czqlDkXFrtHVzzrtNQLllrsyOGUzwyYDnSIfrPzlEdU2E2+Cmfu9/6j0oKv3eOrIdyBdZJRKhxl9UCSYROGS9BHtbL8NZoOmk52DGs7DE3XRZhsxuwvUyDKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790120820; c=relaxed/simple;
	bh=EBFz7Hkbs4AReHF6sLKb2rujS3QeTnBFNaeLmsnwDFM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WEB9/5/1IPDLbAap4SItnMJPXjpMLXwLJRSkohpfeujxNPFOzcDiaYDXiR46mJ0ktW4BD8NAfsHlDKQBEwyjz6l1++DFv+nEpq1z7/FPPmYBPJgaEFVmx/Tyo8afDrLgNbcz++1/sNdXcrXi8Ot1TmC2qyJUgvDyJnnbgYnlXng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=TKkF1Z2H; arc=none smtp.client-ip=23.83.212.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="TKkF1Z2H"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id D4CC64C01E1;
	Tue, 22 Sep 2026 23:39:03 +0000 (UTC)
Received: from pdx1-sub0-mail-a228.dreamhost.com (trex-green-6.trex.outbound.svc.cluster.local [100.99.73.40])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 6EA0B4C2105;
	Tue, 22 Sep 2026 23:38:59 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Stop-Vacuous: 2537a2370c78f6a5_1790120343801_2932025610
X-MC-Loop-Signature: 1790120343800:1218385249
X-MC-Ingress-Time: 1790120343800
Received: from pdx1-sub0-mail-a228.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.73.40 (trex/8.0.2);
	Tue, 22 Sep 2026 23:39:03 +0000
Received: from offworld.lan (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a228.dreamhost.com (Postfix) with ESMTPSA id 4hqGl64bXdzND;
	Tue, 22 Sep 2026 16:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1790120339;
	bh=j0yEudRLgPb/6+fxk3jdET2vI9h4+tYy8JDeME/Pmo8=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=TKkF1Z2HfVKwSWw9fkXpngyZ1MO6vOFY37c6FVOm4aYBh2C5dHeIaCJcD02/fsL2G
	 qcID5Wv8Eaowf2AfnYFO5t813byHhQELPz5W7wnpGMTFNjYJgo1rhKbTkqF+sKG0zK
	 zivpVikYj8/uOc7Mt4jGPjk1qNxX6YNBb87Os5rLJNriH81AjHSw7q4H03kyfTSEVu
	 7QMUtqKXrdy6UQGTHbwXz9hH8lVYOLV36ix9rz5gOMdKNUBkKZ+dnId9IOZOBin7pB
	 svTdqgoOGeneLABa+JT87peFzunoXXCkI9HgemG2FVp914UjbX/BDxeoKNivxaQWqw
	 qiDzXyg5AB3cg==
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
Subject: [PATCH v9 0/10] cxl: Support Back-Invalidate
Date: Tue, 22 Sep 2026 16:38:37 -0700
Message-Id: <cover.1790103847.git.dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

Changes from v8 (https://lore.kernel.org/all/20260909170302.1550680-1-dave@stgolabs.net/):
  - Patch 2: small cleanups (Jonathan)
  - Patch 2: cxl_bi_reset_detected() upgraded to dev_warn (Ming)
  - Patch 2: increased commit timeout from 5s to 20s.
  - Patch 4: fixed a race when a reset occurs while commiting a decoder (sashiko)
  - Patch 4: extra safety check in HDM-H region refuses a Type 2 device outright.
  - Patch 4: also program the ISP (Interleave Set Position), per Table 8-123.
  - Patch 7: fixed the bogus code movement (Jonathan)
  - Patch 8: changelog cleanups
  - Patch 8: fixed rollback to only cleanup after the levels that were not adopted.
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

The qemu-based test suite covers 35 topologies, including cascaded
switches, interleaves across switches, firmware-adopted paths, device
hotplug, resets and AER recovery:

  https://github.com/davidlohr/cxl-bi-tests

This passes regression testing (nothing breaks) ndctl suite via cxl_test,
with the mock HDM-DB window of patch 9 and the BI phase covering HDM-DB
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
  [   24.993387] cxl_core:devm_cxl_add_region:2893: cxl_acpi ACPI0017:00: decoder0.0: created HDM-DB region0
# echo ram > $EP/mode
# echo 0x40000000 > $EP/dpa_size
# echo 1 > $REG/interleave_ways
# echo 4096 > $REG/interleave_granularity
# echo 0x40000000 > $REG/size
# cat $EP/back_invalidate
0
# echo decoder2.0 > $REG/target0
  [   25.297164] cxl_core:cxl_port_attach_region:1337: cxl region0: mem0:endpoint2 decoder2.0 add: mem0:decoder2.0 @ 0 next: none nr_eps: 1 nr_targets: 1
  [   25.298015] cxl_core:cxl_port_attach_region:1337: cxl region0: pci0000:0c:port1 decoder1.0 add: mem0:decoder2.0 @ 0 next: mem0 nr_eps: 1 nr_targets: 1
  [   25.298028] cxl_core:cxl_port_setup_targets:1656: cxl region0: pci0000:0c:port1 iw: 1 ig: 4096
  [   25.298033] cxl_core:cxl_port_setup_targets:1682: cxl region0: pci0000:0c:port1 target[0] = 0000:0c:00.0 for mem0:decoder2.0 @ 0
  [   25.298100] cxl_core:cxl_calc_interleave_pos:2095: cxl_mem mem0: decoder:decoder2.0 parent:0000:0d:00.0 port:endpoint2 range:0x190000000-0x1cfffffff pos:0
  [   25.298107] cxl_core:cxl_region_attach:2345: cxl decoder2.0: Test cxl_calc_interleave_pos(): success test_pos:0 target->pos:0
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
  [   23.899220] cxl region0: mem0:decoder3.0 BI not enabled on device
  [   23.899232] cxl_port endpoint3: failed to attach decoder3.0 to region0: -6

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
  [   31.490138] cxl_core:devm_cxl_add_region:2893: cxl_acpi ACPI0017:00: decoder0.0: created HDM-H region0
# cat $EP/back_invalidate
0
# echo decoder3.0 > $REG/target0
  [   31.632582] cxl_core:cxl_port_attach_region:1337: cxl region0: mem0:endpoint3 decoder3.0 add: mem0:decoder3.0 @ 0 next: none nr_eps: 1 nr_targets: 1
  [   31.633610] cxl_core:cxl_port_attach_region:1337: cxl region0: 0000:0d:00.0:port2 decoder2.0 add: mem0:decoder3.0 @ 0 next: mem0 nr_eps: 1 nr_targets: 1
  [   31.634202] cxl_core:cxl_port_attach_region:1337: cxl region0: pci0000:0c:port1 decoder1.0 add: mem0:decoder3.0 @ 0 next: 0000:0d:00.0 nr_eps: 1 nr_targets: 1
  [   31.634213] cxl_core:cxl_port_setup_targets:1656: cxl region0: pci0000:0c:port1 iw: 1 ig: 4096
  [   31.634220] cxl_core:cxl_port_setup_targets:1682: cxl region0: pci0000:0c:port1 target[0] = 0000:0c:00.0 for mem0:decoder3.0 @ 0
  [   31.634229] cxl_core:cxl_port_setup_targets:1656: cxl region0: 0000:0d:00.0:port2 iw: 1 ig: 4096
  [   31.634233] cxl_core:cxl_port_setup_targets:1682: cxl region0: 0000:0d:00.0:port2 target[0] = 0000:0e:00.0 for mem0:decoder3.0 @ 0
  [   31.634308] cxl_core:cxl_calc_interleave_pos:2095: cxl_mem mem0: decoder:decoder3.0 parent:0000:0f:00.0 port:endpoint3 range:0x190000000-0x1cfffffff pos:0
  [   31.634315] cxl_core:cxl_region_attach:2345: cxl decoder3.0: Test cxl_calc_interleave_pos(): success test_pos:0 target->pos:0
# echo 1 > $REG/commit
# cat $EP/back_invalidate
0

4. Unbind + Bind
----------------
# echo mem0 > /sys/bus/cxl/drivers/cxl_mem/unbind
  [   26.194997] cxl_core:cxl_port_commit_reap:896: cxl_port endpoint2: reap: decoder2.0 commit_end: -1
  [   26.197733] cxl_core:__cxl_bi_ctrl_endpoint:1263: cxl_pci 0000:0d:00.0: BI requests disabled
  [   26.201748] cxl_core:cxl_detach_ep:1564: cxl_mem mem0: disconnect mem0 from port1
# echo mem0 > /sys/bus/cxl/drivers/cxl_mem/bind
  [   26.256271] cxl_core:devm_cxl_enumerate_ports:1879: cxl_mem mem0: scan: iter: mem0 dport_dev: 0000:0c:00.0 parent: pci0000:0c
  [   26.256292] cxl_core:devm_cxl_enumerate_ports:1885: cxl_mem mem0: found already registered port port1:pci0000:0c
  [   26.269012] cxl_core:__cxl_bi_ctrl_endpoint:1263: cxl_pci 0000:0d:00.0: BI requests enabled
  [   26.291271] cxl_core:init_hdm_decoder:1124: cxl_port endpoint2: decoder2.0: range: 0x0-0xffffffffffffffff iw: 1 ig: 4096
  [   26.293837] cxl_core:add_hdm_decoder:39: cxl_mem mem0: decoder2.0 added to endpoint2
  [   26.307375] cxl_core:cxl_bus_probe:2307: cxl_port endpoint2: probe: 0
  [   26.308261] cxl_core:cxl_bus_probe:2307: cxl_mem mem0: probe: 0

The same applies to the endpoint port, with the memdev rebind recovering the endpoint:

# echo endpoint2 > /sys/bus/cxl/drivers/cxl_port/unbind
  [   28.405676] cxl_core:__cxl_bi_ctrl_endpoint:1263: cxl_pci 0000:0d:00.0: BI requests disabled
  [   28.407658] cxl_core:cxl_detach_ep:1564: cxl_mem mem0: disconnect mem0 from port1
# echo mem0 > /sys/bus/cxl/drivers/cxl_mem/bind
  [   28.434197] cxl_core:devm_cxl_enumerate_ports:1879: cxl_mem mem0: scan: iter: mem0 dport_dev: 0000:0c:00.0 parent: pci0000:0c
  [   28.434212] cxl_core:devm_cxl_enumerate_ports:1885: cxl_mem mem0: found already registered port port1:pci0000:0c
  [   28.443657] cxl_core:__cxl_bi_ctrl_endpoint:1263: cxl_pci 0000:0d:00.0: BI requests enabled
  [   28.463701] cxl_core:init_hdm_decoder:1124: cxl_port endpoint2: decoder2.0: range: 0x0-0xffffffffffffffff iw: 1 ig: 4096
  [   28.465437] cxl_core:add_hdm_decoder:39: cxl_mem mem0: decoder2.0 added to endpoint2
  [   28.477717] cxl_core:cxl_bus_probe:2307: cxl_port endpoint2: probe: 0
  [   28.478784] cxl_core:cxl_bus_probe:2307: cxl_mem mem0: probe: 0

From a cold boot, without a region ever created, the endpoint port
unbind only disables BI - there is no committed decoder to reap:

# echo endpoint2 > /sys/bus/cxl/drivers/cxl_port/unbind
  [   23.966972] cxl_core:__cxl_bi_ctrl_endpoint:1263: cxl_pci 0000:0d:00.0: BI requests disabled
  [   23.974945] cxl_core:cxl_detach_ep:1564: cxl_mem mem0: disconnect mem0 from port1
# echo mem0 > /sys/bus/cxl/drivers/cxl_mem/bind
  [   24.027859] cxl_core:devm_cxl_enumerate_ports:1879: cxl_mem mem0: scan: iter: mem0 dport_dev: 0000:0c:00.0 parent: pci0000:0c
  [   24.028120] cxl_core:devm_cxl_enumerate_ports:1885: cxl_mem mem0: found already registered port port1:pci0000:0c
  [   24.044858] cxl_core:__cxl_bi_ctrl_endpoint:1263: cxl_pci 0000:0d:00.0: BI requests enabled
  [   24.066776] cxl_core:init_hdm_decoder:1124: cxl_port endpoint2: decoder2.0: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
  [   24.071118] cxl_core:add_hdm_decoder:39: cxl_mem mem0: decoder2.0 added to endpoint2
  [   24.093375] cxl_core:cxl_bus_probe:2307: cxl_port endpoint2: probe: 0
  [   24.095149] cxl_core:cxl_bus_probe:2307: cxl_mem mem0: probe: 0

5. Discovery behind a Switch
----------------------------
One BI-capable device on a switch downstream port, the switch under a
root port, all in 256B flit. The capability walk finds a BI Decoder
on the device, the root port and the downstream port, and the route
table on the switch upstream port:

  [    4.586464] cxl_core:cxl_probe_component_regs:103: cxl_pci 0000:0f:00.0: found BI Decoder capability (0xab4)
  [    4.614453] cxl_core:cxl_probe_component_regs:103: pcieport 0000:0c:00.0: found BI Decoder capability (0xab4)
  [    4.626522] cxl_core:cxl_probe_component_regs:97: cxl_port port2: found BI RT capability (0xaa8)
  [    4.659230] cxl_core:cxl_probe_component_regs:103: pcieport 0000:0e:00.0: found BI Decoder capability (0xab4)
  [    4.886128] cxl_core:__cxl_bi_wait_commit:1036: pcieport 0000:0e:00.0: BI-ID commit wait took 205136us
  [    5.086370] cxl_core:__cxl_bi_wait_commit:1036: cxl_port port2: BI-ID commit wait took 200129us
  [    5.086462] cxl_core:__cxl_bi_ctrl_endpoint:1263: cxl_pci 0000:0f:00.0: BI requests enabled

6. Corrupted hw (commit timeout handling)
-----------------------------------------
A switch downstream port that never completes its BI Decoder commit,
advertising a ten second window. The walk has already enabled the
level below it, the two commits here, and waits the window out.

  [    4.193899] cxl_core:__cxl_bi_wait_commit:1036: pcieport 0000:10:00.0: BI-ID commit wait took 200066us
  [    4.449016] cxl_core:__cxl_bi_wait_commit:1036: cxl_port port3: BI-ID commit wait took 255032us
  [   14.828756] pcieport 0000:0e:00.0: BI-ID commit timed out (10000000us)
  [   14.932637] cxl_core:__cxl_bi_wait_commit:1036: pcieport 0000:10:00.0: BI-ID commit wait took 103738us
  [   15.132948] cxl_core:__cxl_bi_wait_commit:1036: cxl_port port3: BI-ID commit wait took 200221us
  [   15.132962] cxl_core:devm_cxl_endpoint_decoders_setup:1328: cxl_port endpoint4: BI setup failed rc=-110

7. Mixed Configurations (BI-capable Type 3 behind a 68B hop)
------------------------------------------------------------
  [    4.173147] cxl_core:cxl_probe_component_regs:103: cxl_pci 0000:0f:00.0: found BI Decoder capability (0xab4)
  [    4.200485] cxl_core:cxl_probe_component_regs:103: pcieport 0000:0c:00.0: found BI Decoder capability (0xab4)
  [    4.244721] cxl_core:cxl_probe_component_regs:103: pcieport 0000:0e:00.0: found BI Decoder capability (0xab4)
  [    4.260459] cxl_core:cxl_bi_probe_capable:1437: cxl_pci 0000:0f:00.0: BI not supported by USP
# cat /sys/bus/cxl/devices/endpoint3/decoder3.0/back_invalidate
0
# echo decoder3.0 > /sys/bus/cxl/devices/region0/target0
  [   23.861378] cxl region0: mem0:decoder3.0 BI not enabled on device
  [   23.861390] cxl_port endpoint3: failed to attach decoder3.0 to region0: -6

The same endpoint decoder still commits into an HDM-H region on the
plain window:

# echo region1 > /sys/bus/cxl/devices/decoder0.1/create_ram_region
  [   23.919038] cxl_core:devm_cxl_add_region:2893: cxl_acpi ACPI0017:00: decoder0.1: created HDM-H region1
# echo decoder3.0 > /sys/bus/cxl/devices/region1/target0
# echo 1 > /sys/bus/cxl/devices/region1/commit
# cat /sys/bus/cxl/devices/endpoint3/decoder3.0/back_invalidate
0

8. Auto-discovered (committed) BI decoders
------------------------------------------
For testing, qemu emulates a firmware-committed decoder (x-committed) with this patch:
https://lore.kernel.org/all/20260909184728.mznbg6ox6nqnvv5p@offworld/

  [    3.580967] cxl_core:devm_cxl_switch_port_decoders_setup:1278: cxl_port port1: Fallback to passthrough decoder
  [    3.600179] cxl_core:__cxl_bi_ctrl_endpoint:1246: cxl_pci 0000:0d:00.0: adopting firmware-enabled BI
  [    3.622024] cxl_core:init_hdm_decoder:1124: cxl_port endpoint2: decoder2.0: range: 0x190000000-0x19fffffff iw: 1 ig: 256
  [    3.702584] cxl_core:devm_cxl_add_region:2893: cxl_acpi ACPI0017:00: decoder0.0: created HDM-DB region0
  [    3.704378] cxl_core:__construct_region:3881: cxl_pci 0000:0d:00.0: mem0:decoder2.0: __construct_region region0 res: [mem 0x190000000-0x19fffffff flags 0x200] iw: 1 ig: 256
  [    3.704496] cxl_core:cxl_region_sort_targets:2125: cxl region0: region sort successful
  [    3.711326] cxl_core:devm_cxl_add_dax_region:101: cxl_region region0: region0: register dax_region0
  [    3.711418] cxl_core:cxl_bus_probe:2307: cxl_region region0: probe: 0
# cat /sys/bus/cxl/devices/region0/commit
1
# cat /sys/bus/cxl/devices/decoder2.0/back_invalidate
1

A committed BI decoder under a window without the BI restriction is
refused at region assembly, the refusal naming the window:

  [    2.234650] cxl decoder0.0: mem0:decoder2.0 coherency model not permitted by the window
  [    2.234660] cxl_port:discover_region:55: cxl decoder2.0: failed to add to region: 0x190000000-0x1cfffffff

A committed 2-way set mixing a BI
decoder with a host-only one under a BI window has its host-only
member refused whichever is discovered first: constructing a host-only
region under the window is refused by the window check above, and
joining the HDM-DB region the BI member constructed is refused at
attach. The set never reaches a committed region:

  [    4.560729] cxl_core:__construct_region:3881: cxl_pci 0000:0d:00.0: mem1:decoder3.0: __construct_region region0 res: [mem 0x190000000-0x1afffffff flags 0x200] iw: 2 ig: 4096
  [    4.560897] cxl region0: mem0:decoder4.0 BI not enabled on device
  [    4.560907] cxl_port endpoint4: failed to attach decoder4.0 to region0: -6
# cat /sys/bus/cxl/devices/region*/commit
0

And a committed decoder cannot inherit a region's coherency model the
way a decoder the driver programs does: a committed HDM-H decoder
joining the region a committed HDM-D (device coherent, BI clear)
accelerator decoder constructed is refused (t16):

  [    4.018297] cxl region0: mem1:decoder4.0 coherency model mismatch: HDM-H vs HDM-D

9. Device reset
---------------
A Secondary Bus Reset through the kernel's reset attribute clears
the device's BI Enable, whose reset default is 0. .reset_done
compares cxlds->bi against the hardware and fails closed. With a
region attached but not yet committed (t34), the commit is refused
rather than programming BI into a device that no longer has it, and
a rebind recovers:

# echo region0 > $ROOT/create_ram_region
  [   29.218817] cxl_core:devm_cxl_add_region:2893: cxl_acpi ACPI0017:00: decoder0.0: created HDM-DB region0
# echo ram > $EP/mode
# echo 0x40000000 > $EP/dpa_size
# echo 1 > $REG/interleave_ways
# echo 4096 > $REG/interleave_granularity
# echo 0x40000000 > $REG/size
# echo decoder2.0 > $REG/target0
  [   29.509650] cxl_core:cxl_port_attach_region:1337: cxl region0: mem0:endpoint2 decoder2.0 add: mem0:decoder2.0 @ 0 next: none nr_eps: 1 nr_targets: 1
  [   29.512124] cxl_core:cxl_port_attach_region:1337: cxl region0: pci0000:0c:port1 decoder1.0 add: mem0:decoder2.0 @ 0 next: mem0 nr_eps: 1 nr_targets: 1
  [   29.512147] cxl_core:cxl_port_setup_targets:1656: cxl region0: pci0000:0c:port1 iw: 1 ig: 4096
  [   29.512156] cxl_core:cxl_port_setup_targets:1682: cxl region0: pci0000:0c:port1 target[0] = 0000:0c:00.0 for mem0:decoder2.0 @ 0
  [   29.512250] cxl_core:cxl_calc_interleave_pos:2095: cxl_mem mem0: decoder:decoder2.0 parent:0000:0d:00.0 port:endpoint2 range:0x190000000-0x1cfffffff pos:0
  [   29.512261] cxl_core:cxl_region_attach:2345: cxl decoder2.0: Test cxl_calc_interleave_pos(): success test_pos:0 target->pos:0
# cat $EP/target_type
accelerator
# echo cxl_bus > /sys/bus/pci/devices/0000:0d:00.0/reset_method
# echo 1 > /sys/bus/pci/devices/0000:0d:00.0/reset
  [   29.689264] cxl_pci 0000:0d:00.0: resetting
  [   29.693340] cxl_pci 0000:0d:00.0: reset via cxl_bus
  [   29.706996] cxl_pci 0000:0d:00.0: BI disabled by reset
# echo 1 > $REG/commit
  [   29.778974] cxl region0: mem0:decoder2.0 BI not enabled on device
# cat $EP/back_invalidate
0
# echo region0 > $ROOT/delete_region
# echo mem0 > /sys/bus/cxl/drivers/cxl_mem/unbind
  [   29.951722] cxl_core:cxl_detach_ep:1564: cxl_mem mem0: disconnect mem0 from port1
# echo mem0 > /sys/bus/cxl/drivers/cxl_mem/bind
  [   29.991544] cxl_core:devm_cxl_enumerate_ports:1879: cxl_mem mem0: scan: iter: mem0 dport_dev: 0000:0c:00.0 parent: pci0000:0c
  [   29.991690] cxl_core:devm_cxl_enumerate_ports:1885: cxl_mem mem0: found already registered port port1:pci0000:0c
  [   30.010281] cxl_core:__cxl_bi_ctrl_endpoint:1263: cxl_pci 0000:0d:00.0: BI requests enabled
  [   30.033870] cxl_core:init_hdm_decoder:1124: cxl_port endpoint2: decoder2.0: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
  [   30.036668] cxl_core:add_hdm_decoder:39: cxl_mem mem0: decoder2.0 added to endpoint2
  [   30.058387] cxl_core:cxl_bus_probe:2307: cxl_port endpoint2: probe: 0
  [   30.059643] cxl_core:cxl_bus_probe:2307: cxl_mem mem0: probe: 0
# echo region0 > $ROOT/create_ram_region
  [   32.117872] cxl_core:devm_cxl_add_region:2893: cxl_acpi ACPI0017:00: decoder0.0: created HDM-DB region0
# echo ram > $EP/mode
# echo 0x40000000 > $EP/dpa_size
# echo 1 > $REG/interleave_ways
# echo 4096 > $REG/interleave_granularity
# echo 0x40000000 > $REG/size
# echo decoder2.0 > $REG/target0
  [   32.277068] cxl_core:cxl_port_attach_region:1337: cxl region0: mem0:endpoint2 decoder2.0 add: mem0:decoder2.0 @ 0 next: none nr_eps: 1 nr_targets: 1
  [   32.279775] cxl_core:cxl_port_attach_region:1337: cxl region0: pci0000:0c:port1 decoder1.0 add: mem0:decoder2.0 @ 0 next: mem0 nr_eps: 1 nr_targets: 1
  [   32.279787] cxl_core:cxl_port_setup_targets:1656: cxl region0: pci0000:0c:port1 iw: 1 ig: 4096
  [   32.279791] cxl_core:cxl_port_setup_targets:1682: cxl region0: pci0000:0c:port1 target[0] = 0000:0c:00.0 for mem0:decoder2.0 @ 0
  [   32.279829] cxl_core:cxl_calc_interleave_pos:2095: cxl_mem mem0: decoder:decoder2.0 parent:0000:0d:00.0 port:endpoint2 range:0x190000000-0x1cfffffff pos:0
  [   32.279834] cxl_core:cxl_region_attach:2345: cxl decoder2.0: Test cxl_calc_interleave_pos(): success test_pos:0 target->pos:0
# echo 1 > $REG/commit
# cat $EP/back_invalidate
1

The same reset with the HDM-DB region committed (t27) trips the
existing decoder-loss detection alongside the BI invalidation:

# echo 1 > /sys/bus/pci/devices/0000:0d:00.0/reset
  [   32.911044] cxl_pci 0000:0d:00.0: resetting
  [   32.914293] cxl_pci 0000:0d:00.0: reset via cxl_bus
  [   32.924874] cxl_pci 0000:0d:00.0: BI disabled by reset
  [   32.924933] cxl_pci 0000:0d:00.0: SBR happened without memory regions removal.
  [   32.924939] cxl_pci 0000:0d:00.0: System may be unstable if regions hosted system memory.
# cat $EP/back_invalidate
0

A reset landing after the commit's own check but before the decoder
is programmed is caught by re-reading BI Decoder Control once the
target is committed, and the target is undone (t34):

  [   20.297283] cxl region0: mem0:decoder2.0 BI disabled by reset during commit

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

  [   17.897615] pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) Error message received from 0000:0d:00.0
  [   17.897625] cxl_pci 0000:0d:00.0: AER: CXL Bus Error: severity=Uncorrectable (Fatal) (Inaccessible)
  [   17.897640] pcieport 0000:0c:00.0: AER: broadcast error_detected message
  [   17.962187] cxl_pci 0000:0d:00.0: mem0: frozen state error detected, disable CXL.mem
  [   17.964566] cxl_core:__cxl_bi_ctrl_endpoint:1263: cxl_pci 0000:0d:00.0: BI requests disabled
  [   17.971633] pcieport 0000:0c:00.0: AER: Root Port link has been reset (0)
  [   17.971669] pcieport 0000:0c:00.0: AER: broadcast slot_reset message
  [   17.971673] cxl_pci 0000:0d:00.0: mem0: restart CXL.mem after slot reset
  [   17.978508] cxl_core:__cxl_bi_ctrl_endpoint:1263: cxl_pci 0000:0d:00.0: BI requests enabled
  [   18.002146] pcieport 0000:0c:00.0: AER: broadcast resume message
  [   18.002149] cxl_pci 0000:0d:00.0: mem0: error resume successful
  [   18.002264] pcieport 0000:0c:00.0: AER: device recovery successful

11. Cascaded switches and interleaves across switches
-----------------------------------------------------
Two cascaded switches (t9): both route tables are found and committed,
the transit DSP takes Forward and the device-adjacent DSP Enable, and
an HDM-DB region commits two switch hops down next to an HDM-H one:

  [    3.925810] cxl_core:cxl_probe_component_regs:103: cxl_pci 0000:11:00.0: found BI Decoder capability (0xab4)
  [    3.952095] cxl_core:cxl_probe_component_regs:103: pcieport 0000:0c:00.0: found BI Decoder capability (0xab4)
  [    3.962438] cxl_core:cxl_probe_component_regs:97: cxl_port port2: found BI RT capability (0xaa8)
  [    3.994843] cxl_core:cxl_probe_component_regs:103: pcieport 0000:0e:00.0: found BI Decoder capability (0xab4)
  [    4.005908] cxl_core:cxl_probe_component_regs:97: cxl_port port3: found BI RT capability (0xaa8)
  [    4.038754] cxl_core:cxl_probe_component_regs:103: pcieport 0000:10:00.0: found BI Decoder capability (0xab4)
  [    4.254819] cxl_core:__cxl_bi_wait_commit:1036: pcieport 0000:10:00.0: BI-ID commit wait took 199243us
  [    4.521752] cxl_core:__cxl_bi_wait_commit:1036: cxl_port port3: BI-ID commit wait took 266850us
  [    4.722287] cxl_core:__cxl_bi_wait_commit:1036: pcieport 0000:0e:00.0: BI-ID commit wait took 200248us
  [    4.922630] cxl_core:__cxl_bi_wait_commit:1036: cxl_port port2: BI-ID commit wait took 200306us
  [    4.922904] cxl_core:__cxl_bi_ctrl_endpoint:1263: cxl_pci 0000:11:00.0: BI requests enabled
  [   18.222672] cxl_core:devm_cxl_add_region:2893: cxl_acpi ACPI0017:00: decoder0.0: created HDM-DB region0
  [   19.199474] cxl_core:devm_cxl_add_region:2893: cxl_acpi ACPI0017:00: decoder0.1: created HDM-H region1

Three switch levels (t25), one commit per DSP and per route table:

  [    4.023015] cxl_core:__cxl_bi_wait_commit:1036: pcieport 0000:12:00.0: BI-ID commit wait took 199517us
  [    4.131842] cxl_core:__cxl_bi_wait_commit:1036: cxl_port port4: BI-ID commit wait took 108731us
  [    4.333385] cxl_core:__cxl_bi_wait_commit:1036: pcieport 0000:10:00.0: BI-ID commit wait took 201430us
  [    4.533024] cxl_core:__cxl_bi_wait_commit:1036: cxl_port port3: BI-ID commit wait took 199604us
  [    4.733365] cxl_core:__cxl_bi_wait_commit:1036: pcieport 0000:0e:00.0: BI-ID commit wait took 200222us
  [    4.854051] cxl_core:__cxl_bi_wait_commit:1036: cxl_port port2: BI-ID commit wait took 120593us
  [    4.854130] cxl_core:__cxl_bi_ctrl_endpoint:1263: cxl_pci 0000:13:00.0: BI requests enabled

A 4-way HDM-DB region across two host bridges, each a switch with two
BI endpoints (t32): the root interleaves across the host bridges and
each USP decoder lands iw=2 below it, all four endpoints at bi=1:

  [   25.637378] cxl_core:devm_cxl_add_region:2893: cxl_acpi ACPI0017:00: decoder0.0: created HDM-DB region0
  [   26.175977] cxl_core:cxl_port_setup_targets:1656: cxl region0: pci0000:0c:port2 iw: 1 ig: 8192
  [   26.175981] cxl_core:cxl_port_setup_targets:1682: cxl region0: pci0000:0c:port2 target[0] = 0000:0c:00.0 for mem2:decoder6.0 @ 0
  [   26.175991] cxl_core:cxl_port_setup_targets:1656: cxl region0: 0000:0d:00.0:port4 iw: 2 ig: 8192
  [   26.175994] cxl_core:cxl_port_setup_targets:1682: cxl region0: 0000:0d:00.0:port4 target[0] = 0000:0e:00.0 for mem2:decoder6.0 @ 0
  [   26.176000] cxl_core:cxl_port_setup_targets:1656: cxl region0: pci0000:40:port1 iw: 1 ig: 8192
  [   26.176003] cxl_core:cxl_port_setup_targets:1682: cxl region0: pci0000:40:port1 target[0] = 0000:40:00.0 for mem0:decoder5.0 @ 1
  [   26.176011] cxl_core:cxl_port_setup_targets:1656: cxl region0: 0000:41:00.0:port3 iw: 2 ig: 8192
  [   26.176013] cxl_core:cxl_port_setup_targets:1682: cxl region0: 0000:41:00.0:port3 target[0] = 0000:42:00.0 for mem0:decoder5.0 @ 1
  [   26.176020] cxl_core:cxl_port_setup_targets:1682: cxl region0: pci0000:0c:port2 target[0] = 0000:0c:00.0 for mem3:decoder8.0 @ 2
  [   26.176027] cxl_core:cxl_port_setup_targets:1682: cxl region0: 0000:0d:00.0:port4 target[1] = 0000:0e:01.0 for mem3:decoder8.0 @ 2
  [   26.176034] cxl_core:cxl_port_setup_targets:1682: cxl region0: pci0000:40:port1 target[0] = 0000:40:00.0 for mem1:decoder7.0 @ 3
  [   26.176041] cxl_core:cxl_port_setup_targets:1682: cxl region0: 0000:41:00.0:port3 target[1] = 0000:42:01.0 for mem1:decoder7.0 @ 3

The same under one host bridge with two root ports (t33), the host
bridge decoder interleaving across the root ports:

  [   21.913291] cxl_core:devm_cxl_add_region:2893: cxl_acpi ACPI0017:00: decoder0.0: created HDM-DB region0
  [   22.506974] cxl_core:cxl_port_setup_targets:1656: cxl region0: pci0000:0c:port1 iw: 2 ig: 1024
  [   22.506981] cxl_core:cxl_port_setup_targets:1682: cxl region0: pci0000:0c:port1 target[0] = 0000:0c:00.0 for mem1:decoder5.0 @ 0
  [   22.506997] cxl_core:cxl_port_setup_targets:1656: cxl region0: 0000:0d:00.0:port3 iw: 2 ig: 2048
  [   22.507003] cxl_core:cxl_port_setup_targets:1682: cxl region0: 0000:0d:00.0:port3 target[0] = 0000:0e:00.0 for mem1:decoder5.0 @ 0
  [   22.507015] cxl_core:cxl_port_setup_targets:1682: cxl region0: pci0000:0c:port1 target[1] = 0000:0c:01.0 for mem3:decoder6.0 @ 1
  [   22.507026] cxl_core:cxl_port_setup_targets:1656: cxl region0: 0000:11:00.0:port2 iw: 2 ig: 2048
  [   22.507031] cxl_core:cxl_port_setup_targets:1682: cxl region0: 0000:11:00.0:port2 target[0] = 0000:12:00.0 for mem3:decoder6.0 @ 1
  [   22.507044] cxl_core:cxl_port_setup_targets:1682: cxl region0: pci0000:0c:port1 target[1] = 0000:0c:00.0 for mem2:decoder7.0 @ 2
  [   22.507056] cxl_core:cxl_port_setup_targets:1682: cxl region0: 0000:0d:00.0:port3 target[1] = 0000:0e:01.0 for mem2:decoder7.0 @ 2
  [   22.507068] cxl_core:cxl_port_setup_targets:1682: cxl region0: pci0000:0c:port1 target[1] = 0000:0c:01.0 for mem0:decoder4.0 @ 3
  [   22.507080] cxl_core:cxl_port_setup_targets:1682: cxl region0: 0000:11:00.0:port2 target[1] = 0000:12:01.0 for mem0:decoder4.0 @ 3


Applies against v7.3-rc4. Please consider for v7.4.

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

 Documentation/ABI/testing/sysfs-bus-cxl       |  22 +
 Documentation/driver-api/cxl/maturity-map.rst |  16 +-
 drivers/cxl/acpi.c                            |  31 +-
 drivers/cxl/core/core.h                       |   9 +
 drivers/cxl/core/hdm.c                        |  75 ++-
 drivers/cxl/core/pci.c                        | 545 ++++++++++++++++++
 drivers/cxl/core/port.c                       |  48 +-
 drivers/cxl/core/region.c                     | 160 ++++-
 drivers/cxl/core/regs.c                       |  14 +
 drivers/cxl/cxl.h                             |  58 +-
 drivers/cxl/cxlmem.h                          |   2 +
 drivers/cxl/pci.c                             |   8 +-
 drivers/cxl/port.c                            |  46 ++
 include/cxl/cxl.h                             |  13 +-
 tools/testing/cxl/Kbuild                      |   1 +
 tools/testing/cxl/test/accel.c                |   2 +-
 tools/testing/cxl/test/cxl.c                  | 171 +++++-
 tools/testing/cxl/test/mock.c                 |  13 +
 tools/testing/cxl/test/mock.h                 |   1 +
 19 files changed, 1188 insertions(+), 47 deletions(-)

--
2.39.5

