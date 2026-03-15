Received: from buffalo.tulip.relay.mailchannels.net (buffalo.tulip.relay.mailchannels.net [23.83.218.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35EE37A48A
	for <linux-cxl@vger.kernel.org>; Sun, 15 Mar 2026 20:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773607500; cv=pass; b=gdubGzzzChjzJbzrkEVhTCTkCxUjhK8jawnEXca95tKX7NJT5wLH7mQw9NrMACe3CIJpsLj8g2lImXx2vp3KdVPhI5kvXRKS3vsQcC0J4a/c/wS4M3MmmsPHQkJ7Aay02NDjKmvhlAS3uN2o1aMv49cQuMgmE9ZoWT7+/4O96x0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773607500; c=relaxed/simple;
	bh=LOhOHESAlFxwMOYn5ooIf1LD3F8K4fN4rt5H3mJWjjs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Rk3fFl05V8xkFX6PrvAn+AYGmzadNwlJpU5hZ19L8xjwrdkQPt9tZP9W9uf9sbubUeCTIRQM6ObbVtnfuWsoWopxgsTyY1bMELEUY/PRLBo4O4/VWuBfjFwe5Ax3JAIxVepVKT3In4qlBoLc71kpqmiFx2gOT9GgGrX4uGxgCIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=QTkt9d6l; arc=pass smtp.client-ip=23.83.218.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="QTkt9d6l"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 64E2F7E2867;
	Sun, 15 Mar 2026 20:27:44 +0000 (UTC)
Received: from pdx1-sub0-mail-a246.dreamhost.com (100-115-72-50.trex-nlb.outbound.svc.cluster.local [100.115.72.50])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id EA38D7E25A1;
	Sun, 15 Mar 2026 20:27:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1773606464;
	b=AMuBOdQClCuT6P6IBQwdt2bvJlXva00Ps1M6UVWcRHkjeoCdgNUAwaH8FHCfSori5acd6A
	+RkDLjUSwI+1r1z0SK5r2BqxGeWJg+ddU0QgPFmSEdSmcOOIgbeDTjDSaYpkY8uN/YtfEg
	UBLti3xc3r4Yk6Is7j5b2PtZIJqFWg89xSGWaa6g5j2cpe9ogmrGwcQj7waBfuyiaLHxiC
	hOgdcUWDjSvjuzvCWR7CovTesfbXtDmc8RMAdiUbN5iVYLzXefw+N+IzcsEc5nGH9P5ary
	cImm3bagLCrWF4Y28nIimKRpFOFYkPG7csjZS0LAifynVTWB5uVBjEy0PpbppQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1773606464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=xH7L2reEGCLau+eNQXki7tn4O5KxczWK08CXcNj4E1g=;
	b=sAymOIYmMTJn8gxo7iJFv+sI8sB+lML6XrmCK8XVbqYS/kzC291Scz5Ql2KwKLduQ3m8ae
	GIdWGIbcnvwCpWR0/KhJUwuID0a1UPzZ9TrTxYp6iR8emXeryW7aBAEEwKN5hj/z5whj54
	pxx43qtLErAWtrl6fmt0fjPq8QLx4VwjpLUby9FQUzzfqopGtA8gUTzTfMAPM3X0UJ+5q7
	YxPCk5zGq36nMZXZMhKRu0+ZDZQlX0M4IzhGPgOfiOr4/NxaEsGlLlidBuVn8d3gJ5YLYs
	pYJNFSVfFgNQED/o/gIh2Nk32G8flhtEqArUe5MpbKy0iFUVIYJPB6CC87GsiA==
ARC-Authentication-Results: i=1;
	rspamd-c9674b64d-6ngsr;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Ruddy-Society: 0beadc6f53a49615_1773606464227_1856015680
X-MC-Loop-Signature: 1773606464226:3734005159
X-MC-Ingress-Time: 1773606464226
Received: from pdx1-sub0-mail-a246.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.115.72.50 (trex/7.1.5);
	Sun, 15 Mar 2026 20:27:44 +0000
Received: from offworld.lan (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a246.dreamhost.com (Postfix) with ESMTPSA id 4fYqXb1n2qz107M;
	Sun, 15 Mar 2026 13:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1773606463;
	bh=xH7L2reEGCLau+eNQXki7tn4O5KxczWK08CXcNj4E1g=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=QTkt9d6lbPuCtWemu6ytghmudSq+QZCwZpFpwEeGtzs6NewVhrOOav56DgrV39SSp
	 x3Fhwc81NzYlwrNfAskN+q5rF6YfPOZxjVqwDKVGWpTBKa5kKwZcwSZKPPQnBgXPmm
	 1/yMikbiwIXnP6PwFxRWWq9qECaVCEvimGa8cjXZtlAJxXGpDl8WCoPjCZRHh5+gb7
	 B/9wq8qXoLGhBVMUA3LK2f45jWzv4WLjww2c/p0UD16xNopn1G9Wrg4heYLSTE4PfV
	 4m3A6V5TW/ly4cPXQ+UYiFCGYp+Rs2eO0tQPKgC2HSrBqbgpCxtyGqCwOtDJwbXjVq
	 GazS3rTRPRcnA==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com,
	dan.j.williams@intel.com
Cc: jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	ira.weiny@intel.com,
	gourry@gourry.net,
	dongjoo.seo1@samsung.com,
	anisa.su@samsung.com,
	linux-cxl@vger.kernel.org,
	Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH 0/6] cxl: Support Back-Invalidate
Date: Sun, 15 Mar 2026 13:27:35 -0700
Message-Id: <20260315202741.3264295-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

Changes from rfc (https://lore.kernel.org/all/20250812010228.2589787-1-dave@stgolabs.net/):
  o Dropped rfc status and split the series into smaller patches.
  o Renamed from toggle to ctrl + cleanup cxl_bi_ctrl_dport() by using a
    switch statement + better variable declarations. (Jonathan)
  o Introduce proper definitions for HDM supported coherence models. (Jonathan)
  o Fixed a regs remapping (unbind+bind) issue.
  o Added rollback logic if enabling BI on a component fails during the
    hierarchy walk.
  o Reworked BI regmaps.
  o BI-ID deallocation via delete_endpoint() instead of in cxl_detach_ep().

The following is the initial plumbing to enabling HDM-DB in Linux. This model
allows type2 and type3 devices, to expose their local memory to the host CPU
in a coherent manner. In alignment with what was discussed at 2024 LPC type2
support session, this series takes the type3 memory expander approach, which
is more direct. Further, afaik there is no type2+BI hardware out there.

A flagship use case of type3 + BI is coherent shared memory, and there is
currently a big gap in this regard (ie: GFAM). Another one is P2P via PCIe UIO,
which is also lacking today. Media Operation (4402h) command for ranged
sanitize/zero also trigger snoops, but such cmd support is missing as well
in the driver (albeit this might be the easiest entry point). As such this
series focuses on BI enablement in terms of discovery and configuration.

This adds two interfaces around cxlds to allow the setup and deallocations of
BI-IDs. The idea is for type3 memdevs and future type2 devices to make use of
cxlds->bi when committing HDM decoders, such that different device coherence
models can be differentiated as:

	type2 hdm-d:  cxlds->type == CXL_DEVTYPE_DEVMEM && cxlds->bi == false
	type2 hdm-db: cxlds->type == CXL_DEVTYPE_DEVMEM && cxlds->bi == true
	type3 hdm-h:  cxlds->type == CXL_DEVTYPE_CLASSMEM && cxlds->bi == false
	type3 hdm-db: cxlds->type == CXL_DEVTYPE_CLASSMEM && cxlds->bi == true

Because ->bi becoming true does not depend on auto-committing upon HDM decoder
port/enumeration (port driver), for now this is set as unsupported and will error
out when initializing the HDM decoder that has its BI bit set.

o Patch 1 adds BI Decoder and BI Route Table register definitions, capability IDs,
  and structures.
  
o Patch 2 probes BI capabilities during register discovery and maps BI Decoder
  registers on dports and endpoints, and BI Route Table registers on upstream
  switch ports.

o Patch 3 implements the BI-ID allocation and deallocation API. Both do the
  required hierarchy iteration (bottom-up) ensuring it is safe to enable/disable
  BI for every component.
  
o Patch 4 wires BI setup into cxl_mem_probe and teardown.

o Patch 5 introduces cxl_dpa_set_coherence() to switch between host-only and
  device coherent modes, and programs the BI control bit at commit time.

o Patch 6 adds sysfs interfaces for creating BI-enabled region for memory
  devices.

Testing has been done with the qemu HDM-DB type3 counterpart (now merged).

1. HDM Decoder with BI through ad-hoc region creation.
------------------------------------------------------
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
    "accelmem_capable":true,
    "nr_targets":1
  }
]

Program the endpoint decoder
# echo ram > /sys/bus/cxl/devices/decoder2.0/mode
# echo 1 > /sys/bus/cxl/devices/decoder2.0/bi
# echo 0x40000000 > /sys/bus/cxl/devices/decoder2.0/dpa_size

Create a region in the root decoder
# echo region0 > /sys/bus/cxl/devices/decoder0.0/create_ram_bi_region
[   22.730899] cxl_core:cxl_region_can_probe:4214: cxl_region region0: config state: 0
[   22.732655] cxl_core:cxl_bus_probe:2334: cxl_region region0: probe: -6
[   22.734200] cxl_core:devm_cxl_add_region:2636: cxl_acpi ACPI0017:00: decoder0.0: created region0


Configure the region with the same IG, IW the root and endpoint decoders
# echo 256 > /sys/bus/cxl/devices/region0/interleave_granularity
# echo 1 > /sys/bus/cxl/devices/region0/interleave_ways
# echo 0x40000000 > /sys/bus/cxl/devices/region0/size

Link the endpoint decoder as a target in the region
# echo decoder2.0 > /sys/bus/cxl/devices/region0/target0
[   99.819398] cxl_core:cxl_port_attach_region:1244: cxl region0: mem0:endpoint2 decoder2.0 add: mem0:decoder2.0 @ 0 n1
[   99.821802] cxl_core:cxl_port_attach_region:1244: cxl region0: pci0000:0c:port1 decoder1.0 add: mem0:decoder2.0 @ 01
[   99.823965] cxl_core:cxl_port_setup_targets:1562: cxl region0: pci0000:0c:port1 iw: 1 ig: 256
[   99.825153] cxl_core:cxl_port_setup_targets:1587: cxl region0: pci0000:0c:port1 target[0] = 0000:0c:01.0 for mem0:d0
[   99.826715] cxl_core:cxl_calc_interleave_pos:1956: cxl_mem mem0: decoder:decoder2.0 parent:0000:0e:00.0 port:endpoi0
[   99.828491] cxl_core:cxl_region_attach:2157: cxl decoder2.0: Test cxl_calc_interleave_pos(): success test_pos:0 cxl0

Commit the changes
# echo 1 > /sys/bus/cxl/devices/region0/commit
[  134.556073] cxl region0: Bypassing cpu_cache_invalidate_memregion() for testing!
non interleaved decoder 120000000 40000000 0
non interleaved decoder 120000000 40000000 0

# cxl list -D (tooling still needs updated to show decoder target type)
[
  {
    "root decoders":[
      {
        "decoder":"decoder0.0",
        "resource":4563402752,
        "size":10737418240,
        "interleave_ways":1,
        "max_available_extent":9395240960,
        "pmem_capable":true,
        "volatile_capable":true,
        "accelmem_capable":true,
        "nr_targets":1
      }
    ]
  },
  {
    "port decoders":[
      {
        "decoder":"decoder1.0",
        "resource":4831838208,
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
        "resource":4831838208,
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


2. On a type3 HDM-DB volatile device, create one BI and one regular region.
--------------------------------------------------------------------------
# echo ram > /sys/bus/cxl/devices/decoder2.0/mode
# echo 1 > /sys/bus/cxl/devices/decoder2.0/bi
# echo 0x20000000 > /sys/bus/cxl/devices/decoder2.0/dpa_size
# echo region0 > /sys/bus/cxl/devices/decoder0.0/create_ram_bi_region
# echo 256 > /sys/bus/cxl/devices/region0/interleave_granularity
# echo 1 > /sys/bus/cxl/devices/region0/interleave_ways
# echo 0x20000000 > /sys/bus/cxl/devices/region0/size
# echo decoder2.0 > /sys/bus/cxl/devices/region0/target0
# echo 1 > /sys/bus/cxl/devices/region0/commit

# echo ram > /sys/bus/cxl/devices/decoder2.1/mode
# echo 0 > /sys/bus/cxl/devices/decoder2.1/bi (this is already the default)
# echo 0x20000000 > /sys/bus/cxl/devices/decoder2.1/dpa_size
# echo region1 > /sys/bus/cxl/devices/decoder0.0/create_ram_region
# echo 256 > /sys/bus/cxl/devices/region1/interleave_granularity
# echo 1 > /sys/bus/cxl/devices/region1/interleave_ways
# echo 0x20000000 > /sys/bus/cxl/devices/region1/size
# echo decoder2.1 > /sys/bus/cxl/devices/region1/target0
# echo 1 > /sys/bus/cxl/devices/region1/commit

# cxl list -D
[
  {
    "root decoders":[
      {
        "decoder":"decoder0.0",
        "resource":4563402752,
        "size":10737418240,
        "interleave_ways":1,
        "max_available_extent":9395240960,
        "pmem_capable":true,
        "volatile_capable":true,
        "accelmem_capable":true,
        "nr_targets":1
      }
    ]
  },
  {
    "port decoders":[
      {
        "decoder":"decoder1.0",
        "resource":4831838208,
        "size":536870912,
        "interleave_ways":1,
        "region":"region0",
        "nr_targets":1
      },
      {
        "decoder":"decoder1.1",
        "resource":5368709120,
        "size":536870912,
        "interleave_ways":1,
        "region":"region1",
        "nr_targets":1
      }
    ]
  },
  {
    "endpoint decoders":[
      {
        "decoder":"decoder2.0",
        "resource":4831838208,
        "size":536870912,
        "interleave_ways":1,
        "region":"region0",
        "dpa_resource":0,
        "dpa_size":536870912,
        "mode":"ram"
      },
      {
        "decoder":"decoder2.1",
        "resource":5368709120,
        "size":536870912,
        "interleave_ways":1,
        "region":"region1",
        "dpa_resource":536870912,
        "dpa_size":536870912,
        "mode":"ram"
      }
    ]
  }
]

3. Unbind + Bind
----------------
[    0.799944] cxl_core:cxl_bi_ctrl_endpoint:1123: cxl_pci 0000:0d:00.0: device capable of issuing BI requests

# echo mem0 > /sys/bus/cxl/drivers/cxl_mem/unbind
[  108.682475] cxl_core:cxl_bi_ctrl_endpoint:1123: cxl_pci 0000:0d:00.0: device incapable of issuing BI requests
[  108.685569] cxl_core:cxl_detach_ep:1600: cxl_mem mem0: disconnect mem0 from port1

# echo mem0 > /sys/bus/cxl/drivers/cxl_mem/bind
[  152.828550] cxl_core:devm_cxl_enumerate_ports:1906: cxl_mem mem0: scan: iter: mem0 dport_dev: 0000:0c:00.0 parent: c
[  152.833431] cxl_core:devm_cxl_enumerate_ports:1912: cxl_mem mem0: found already registered port port1:pci0000:0c
[  152.836573] cxl_core:cxl_port_alloc:802: cxl_mem mem0: host-bridge: pci0000:0c
[  152.838898] cxl_core:cxl_cdat_get_length:486: cxl_port endpoint2: CDAT length 160
[  152.846065] cxl_core:cxl_port_perf_data_calculate:207: cxl_port endpoint2: Failed to retrieve ep perf coordinates.
[  152.848011] cxl_core:cxl_endpoint_parse_cdat:423: cxl_port endpoint2: Failed to do perf coord calculations.
[  152.870738] cxl_core:init_hdm_decoder:1139: cxl_port endpoint2: decoder2.0: range: 0x0-0xffffffffffffffff iw: 1 ig:6
[  152.876618] cxl_core:add_hdm_decoder:39: cxl_mem mem0: decoder2.0 added to endpoint2
[  152.880951] cxl_core:init_hdm_decoder:1139: cxl_port endpoint2: decoder2.1: range: 0x0-0xffffffffffffffff iw: 1 ig:6
[  152.883983] cxl_core:add_hdm_decoder:39: cxl_mem mem0: decoder2.1 added to endpoint2
[  152.885263] cxl_core:init_hdm_decoder:1139: cxl_port endpoint2: decoder2.2: range: 0x0-0xffffffffffffffff iw: 1 ig:6
[  152.887181] cxl_core:add_hdm_decoder:39: cxl_mem mem0: decoder2.2 added to endpoint2
[  152.888514] cxl_core:init_hdm_decoder:1139: cxl_port endpoint2: decoder2.3: range: 0x0-0xffffffffffffffff iw: 1 ig:6
[  152.890362] cxl_core:add_hdm_decoder:39: cxl_mem mem0: decoder2.3 added to endpoint2
[  152.891493] cxl_core:cxl_bus_probe:2334: cxl_port endpoint2: probe: 0
[  152.892420] cxl_core:devm_cxl_add_port:1010: cxl_mem mem0: endpoint2 added to port1
[  152.893360] cxl_core:cxl_bi_ctrl_endpoint:1123: cxl_pci 0000:0d:00.0: device capable of issuing BI requests
[  152.894395] cxl_core:cxl_bus_probe:2334: cxl_mem mem0: probe: 0

Unbind both devices:
# echo mem0 > /sys/bus/cxl/drivers/cxl_mem/unbind
[  344.593463] cxl_core:cxl_bi_ctrl_endpoint:1123: cxl_pci 0000:0d:00.0: device incapable of issuing BI requests
# echo mem1 > /sys/bus/cxl/drivers/cxl_mem/unbind
[  349.861528] cxl_core:cxl_bi_ctrl_endpoint:1123: cxl_pci 0000:0e:00.0: device incapable of issuing BI requests

4. Discovery of 2 BI capable devices behind a switch (w/ flit mode)
-------------------------------------------------------------------
[    0.758525] cxl_core:cxl_probe_component_regs:102: cxl_pci 0000:11:00.0: found BI Decoder capability (0xab4)
[    0.767234] cxl_core:cxl_probe_component_regs:102: cxl_pci 0000:0f:00.0: found BI Decoder capability (0xab4)
[    0.842162] cxl_core:cxl_probe_component_regs:102: pcieport 0000:0c:00.0: found BI Decoder capability (0xab4)
[    0.863272] cxl_port:cxl_uport_init_bi:94: cxl_port port2: BI RT registers not found
[    0.907717] cxl_core:cxl_probe_component_regs:96: cxl_port port2: found BI RT capability (0xaa8)
[    1.113556] cxl_core:cxl_probe_component_regs:102: pcieport 0000:0e:03.0: found BI Decoder capability (0xab4)
[    1.128571] cxl_core:cxl_probe_component_regs:102: pcieport 0000:0e:01.0: found BI Decoder capability (0xab4)
[    1.281506] cxl_core:cxl_probe_component_regs:102: pcieport 0000:0e:02.0: found BI Decoder capability (0xab4)
[    1.290050] cxl_core:cxl_probe_component_regs:102: pcieport 0000:0e:00.0: found BI Decoder capability (0xab4)
[    1.612582] cxl_core:__cxl_bi_commit:1024: pcieport 0000:0e:00.0: BI-ID commit wait took 203541us
[    1.616836] cxl_core:cxl_bi_ctrl_endpoint:1123: cxl_pci 0000:0f:00.0: device capable of issuing BI requests
[    1.820621] cxl_core:__cxl_bi_commit:1024: pcieport 0000:0e:02.0: BI-ID commit wait took 203526us
[    1.823760] cxl_core:cxl_bi_ctrl_endpoint:1123: cxl_pci 0000:11:00.0: device capable of issuing BI requests

5. Mixed Configurations (BI-capable type3 but DSP 68b)
------------------------------------------------------
[    0.842026] cxl_core:cxl_probe_component_regs:102: cxl_pci 0000:11:00.0: found BI Decoder capability (0xab4)
[    0.842092] cxl_core:cxl_probe_component_regs:102: cxl_pci 0000:0f:00.0: found BI Decoder capability (0xab4)
[    0.878436] cxl_core:cxl_probe_component_regs:102: pcieport 0000:0c:00.0: found BI Decoder capability (0xab4)
[    1.297020] cxl_core:cxl_probe_component_regs:102: pcieport 0000:0e:03.0: found BI Decoder capability (0xab4)
[    1.315171] cxl_core:cxl_probe_component_regs:102: pcieport 0000:0e:02.0: found BI Decoder capability (0xab4)
[    1.475849] cxl_mem:cxl_mem_probe:160: cxl_mem mem3: BI setup failed rc=-22
[    1.476831] cxl_core:cxl_probe_component_regs:102: pcieport 0000:0e:01.0: found BI Decoder capability (0xab4)
[    1.477785] cxl_core:cxl_probe_component_regs:102: pcieport 0000:0e:00.0: found BI Decoder capability (0xab4)
[    1.671067] cxl_mem:cxl_mem_probe:160: cxl_mem mem0: BI setup failed rc=-22

# echo 1 > /sys/bus/cxl/devices/decoder5.0/bi 
-bash: echo: write error: Invalid argument

# echo region0 > /sys/bus/cxl/devices/decoder0.0/create_ram_bi_region
[  287.198551] cxl_core:cxl_region_can_probe:4227: cxl_region region0: config state: 0
[  287.200005] cxl_core:cxl_bus_probe:2334: cxl_region region0: probe: -6
[  287.201012] cxl_core:devm_cxl_add_region:2649: cxl_acpi ACPI0017:00: decoder0.0: created region0

# echo decoder5.0 > /sys/bus/cxl/devices/region0/target0
[  384.895032] cxl_core:cxl_region_attach:2062: cxl region0: mem0:decoder5.0 BI not enabled on device
[  384.896300] cxl_port endpoint5: failed to attach decoder5.0 to region0: -6
-bash: echo: write error: No such device or address


6. Detect mismatch between decoder and region types
---------------------------------------------------
# echo ram > /sys/bus/cxl/devices/decoder2.0/mode
# echo 1 > /sys/bus/cxl/devices/decoder2.0/bi
# echo 0x40000000 > /sys/bus/cxl/devices/decoder2.0/dpa_size
# echo region0 > /sys/bus/cxl/devices/decoder0.0/create_ram_region <- no bi
# echo 256 > /sys/bus/cxl/devices/region0/interleave_granularity
# echo 1 > /sys/bus/cxl/devices/region0/interleave_ways
# echo 0x40000000 > /sys/bus/cxl/devices/region0/size
# echo decoder2.0 > /sys/bus/cxl/devices/region0/target0
# echo 1 > /sys/bus/cxl/devices/region0/commit
[   24.738308] cxl_core:cxl_region_attach:2048: cxl region0: mem0:decoder2.0 type mismatch: 2 vs 3

Applies against the 'next' branch of cxl.git + the type2 support preparation
series (https://lore.kernel.org/linux-cxl/20260306164741.3796372-1-alejandro.lucero-palau@amd.com)

Thanks!

Davidlohr Bueso (6):
  cxl: Add Back-Invalidate register definitions and structures
  cxl: Add BI register probing and port initialization
  cxl/pci: Add Back-Invalidate topology enable/disable
  cxl: Wire BI setup and dealloc into device lifecycle
  cxl/hdm: Add BI coherency support for endpoint decoders
  cxl: Add HDM-DB region creation and sysfs interface

 Documentation/ABI/testing/sysfs-bus-cxl |  40 ++-
 drivers/cxl/acpi.c                      |   2 +
 drivers/cxl/core/core.h                 |   4 +
 drivers/cxl/core/hdm.c                  |  60 ++++-
 drivers/cxl/core/pci.c                  | 339 ++++++++++++++++++++++++
 drivers/cxl/core/port.c                 |  63 ++++-
 drivers/cxl/core/region.c               |  65 ++++-
 drivers/cxl/core/regs.c                 |  13 +
 drivers/cxl/cxl.h                       |  41 +++
 drivers/cxl/cxlmem.h                    |   2 +
 drivers/cxl/mem.c                       |  20 ++
 drivers/cxl/port.c                      |  88 ++++++
 include/cxl/cxl.h                       |   5 +
 13 files changed, 726 insertions(+), 16 deletions(-)

-- 
2.39.5

