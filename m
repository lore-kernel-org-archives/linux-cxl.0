Received: from crab.ash.relay.mailchannels.net (crab.ash.relay.mailchannels.net [23.83.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A57E1CFBA
	for <linux-cxl@vger.kernel.org>; Sat, 16 May 2026 02:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.222.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778898077; cv=pass; b=MdKHGoTPemlmXrNbyyxx2oVmHOPFiGoCPdOO6KYM3v0O3765aHnvBePni7Y70/4pHf1LIf2GN0vBMKahMyF2KsArMNELHBFwA3/DczrdPbPjtvegA7llinlmcaVkZf17gOf0eHMNjtF0tLqkm8mxfzSefiGat2IxjBgd1T8T4oY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778898077; c=relaxed/simple;
	bh=DQt4lBGWmZ4HhLbK0YlHULxDi3Sl1ZNqayXYXDvFWQc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RtV31Kkz2RkocDXNpN/1YKbc4uCIpVUTxa3ZSQUtxdt7m16OIi15l+LZm1IztGVcIrFlLmc6+bKL0hIk5vo0ysykoHiqI8W/tfyb+qLgvtlTGe6Zer53anvIdvz30wv0ETQZYKFzn8/BD9DP+lA8nRN3TK75Nmxw5lY/U83iNRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=YZtzeVWV; arc=pass smtp.client-ip=23.83.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="YZtzeVWV"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id CBFA46410DA;
	Sat, 16 May 2026 02:21:08 +0000 (UTC)
Received: from pdx1-sub0-mail-a238.dreamhost.com (trex-green-0.trex.outbound.svc.cluster.local [100.98.13.152])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 5BE34641126;
	Sat, 16 May 2026 02:21:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1778898068;
	b=9jTBwa7jns1SWXkrvXPp3OVOFQ3I1qg1tLDlLfUharfGzWFBRiX8RcfiFZgxkHLTp61rV0
	QGy9mDF1+H8S5/5840nTnUL0i5bCfUO+yjbJEtSKkHZxPVTFqCXLEpNB+dSg1nf6a1CmsX
	Th5IAMUj2yjOH3JsgLAjyGNYC1I/pdj9hjbcLI+jcHExL/5mL9mZeGaGgqDTAjHwJVs7eQ
	J2MiQfcSKHc6rczdf8AK3lF9Ry72tLpi4p9J6pe61F1sa7yIz5QuHkcX2rzuQIDhmtcaIk
	hAuJHFif4+bIfLa8cR2Q303y+eLcxK9LSddMFV4i1QKgn+skuFGwScDWX8nqZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1778898068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=slTARHsEt3HHpnLQrAcgL5e90V4OwCF7sXKFRereW6I=;
	b=SY2170PP3xoXXJYgoyG2m8on9xnlJU6vkmHwbBEYPLczCC5rv+TCsrSIhFej0F/J7tDe3z
	iii/cJnVr4Zd5MlZKkqFI8IPe7uR6beN5gShTahtrk6wMuAwDtBVmKIK31LrzpCeZ8SCZB
	nRbL6i117yGaKfIxA9KCH5zkoeMNDb5Q9FgdMy/dRUmLy4i3ZJ4jBaPuCAllLtqgUtD/Om
	TYOtGeyXW+M+b7D9jz0q6jPIJGiSVXNTc8q2tngOphpU4W20GMnM4jHSF8LkbM6E23MSTH
	Ao2w8lhGzHUkcfNdVgFhDq4sRZME05waQ9ZNDDhDhGD4dR+gk11Sa0x/xjGCKg==
ARC-Authentication-Results: i=1;
	rspamd-5c5444c55f-pp2pm;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Spot-Quick: 26116df923ccf7c9_1778898068713_817630234
X-MC-Loop-Signature: 1778898068713:4238135290
X-MC-Ingress-Time: 1778898068713
Received: from pdx1-sub0-mail-a238.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.98.13.152 (trex/7.1.5);
	Sat, 16 May 2026 02:21:08 +0000
Received: from offworld.lan (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a238.dreamhost.com (Postfix) with ESMTPSA id 4gHSVB48zYzyqP;
	Fri, 15 May 2026 19:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1778898067;
	bh=slTARHsEt3HHpnLQrAcgL5e90V4OwCF7sXKFRereW6I=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=YZtzeVWVa/O6E4BSHtq1RHRzYCz/aJ2MpL+eE1e1ydPHW0YEAWrLLefj+cTi+lKKP
	 YrO8hLkaOrkQslbsXv19FHe5dCk9n1sCkfPMTsm1eQmBHpdpKS4AjBJ7FDiEGiMl1D
	 EOkG2voK6lgEUJY6jX8Ixlc5Zs01w04RlmnBRyb3EThMwFhsAsvcSH47QaFqykjpF5
	 2vwNBN/QWi4tG3BlrW4iOL82e1HXWrnCjMgmjligBKSC6f4bjyhHqMzVpT4MNQZXvt
	 7LrgnaUaKNjWpy3rFdLqoIqA+Kg1OftAVcPz/o3KGa3giWevZKxf3b7NT8DzTawbaI
	 MT3HLv7IJC1tQ==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com,
	djbw@kernel.org
Cc: jic23@kernel.org,
	benjamin.cheatham@amd.com,
	alucerop@amd.com,
	alison.schofield@intel.com,
	ira.weiny@intel.com,
	gourry@gourry.net,
	dongjoo.seo1@samsung.com,
	anisa.su@samsung.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org
Subject: [PATCH v2 0/5] cxl: Support Back-Invalidate
Date: Fri, 15 May 2026 19:20:31 -0700
Message-Id: <20260516022037.1761453-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

Changes from v1 (https://lore.kernel.org/all/20260315202741.3264295-1-dave@stgolabs.net/):
  o Merged patch 1 throughout the series.
  o Updated cxl references to 4.0 (Jonathan)
  o Split bi into bi_rt and bi_decoder in struct cxl_component_regs (Jonathan)
  o Use port->regs instead of a new uport_regs (Jonathan, Ben, Dave)
  o Simplify/rework reg map init (Ben)
  o The dealloc teardown is added to the setup call for cxl_mem lifecycle. (Ben)
  o Cleanup while loops for topology iteration (Ben)

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
  
o Patch 2 implements the BI-ID allocation (and deallocation) via a new
  cxl_bi_setup().
  
o Patch 3 introduces cxl_dpa_set_coherence() to switch between
  host-only and device-coherent modes.

o Patch 4 adds ABI (sysfs) for HDM-DB region creation.

o Patch 5 trivially wires cxl_bi_setup() into cxl_mem_probe().

Testing has been done with the qemu HDM-DB Type 3 counterpart (now
merged).

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
[   60.287852] cxl_core:cxl_region_can_probe:4085: cxl_region region0: config state: 0
[   60.289161] cxl_core:cxl_bus_probe:2322: cxl_region region0: probe: -6
[   60.290562] cxl_core:devm_cxl_add_region:2735: cxl_acpi ACPI0017:00: decoder0.0: created region0

Configure the region with the same IG, IW the root and endpoint decoders
# echo 256 > /sys/bus/cxl/devices/region0/interleave_granularity
# echo 1 > /sys/bus/cxl/devices/region0/interleave_ways
# echo 0x40000000 > /sys/bus/cxl/devices/region0/size

Link the endpoint decoder as a target in the region
# echo decoder2.0 > /sys/bus/cxl/devices/region0/target0
[  107.024528] cxl_core:cxl_port_attach_region:1292: cxl region0: mem0:endpoint2 decoder2.0 add: mem0:decoder2.0 @ 0 next: none nr_eps: 1 nr_targets: 1
[  107.027218] cxl_core:cxl_port_attach_region:1292: cxl region0: pci0000:0c:port1 decoder1.0 add: mem0:decoder2.0 @ 0 next: mem0 nr_eps: 1 nr_targets: 1
[  107.029212] cxl_core:cxl_port_setup_targets:1610: cxl region0: pci0000:0c:port1 iw: 1 ig: 256
[  107.030462] cxl_core:cxl_port_setup_targets:1635: cxl region0: pci0000:0c:port1 target[0] = 0000:0c:00.0 for mem0:decoder2.0 @ 0
[  107.032175] cxl_core:cxl_calc_interleave_pos:2005: cxl_mem mem0: decoder:decoder2.0 parent:0000:0d:00.0 port:endpoint2 range:0x110000000-0x14fffffff pos:0
[  107.034065] cxl_core:cxl_region_attach:2213: cxl decoder2.0: Test cxl_calc_interleave_pos(): success test_pos:0 cxled->pos:0

Commit the changes
# echo 1 > /sys/bus/cxl/devices/region0/commit

# cxl list -D (tooling still needs updated to show decoder target type)
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



2. On a Type 3 HDM-DB volatile device, create one BI and one regular region.
---------------------------------------------------------------------------
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
        "max_available_extent":9663676416,
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
        "resource":4563402752,
        "size":536870912,
        "interleave_ways":1,
        "region":"region0",
        "nr_targets":1
      },
      {
        "decoder":"decoder1.1",
        "resource":5100273664,
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
        "resource":4563402752,
        "size":536870912,
        "interleave_ways":1,
        "region":"region0",
        "dpa_resource":0,
        "dpa_size":536870912,
        "mode":"ram"
      },
      {
        "decoder":"decoder2.1",
        "resource":5100273664,
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
[    0.736421] cxl_core:cxl_bi_ctrl_endpoint:1124: cxl_pci 0000:0e:00.0: BI requests enabled

# echo mem0 > /sys/bus/cxl/drivers/cxl_mem/unbind
[  245.823941] cxl_core:cxl_bi_ctrl_endpoint:1124: cxl_pci 0000:0e:00.0: BI requests disabled
[  245.826795] cxl_core:cxl_port_commit_reap:915: cxl_port port1: reap: decoder1.1 commit_end: 0
[  245.833687] cxl_core:cxl_port_commit_reap:915: cxl_port endpoint2: reap: decoder2.1 commit_end: 0
[  245.835909] cxl_core:cxl_port_commit_reap:915: cxl_port port1: reap: decoder1.0 commit_end: -1
[  245.838351] cxl_core:cxl_port_commit_reap:915: cxl_port endpoint2: reap: decoder2.0 commit_end: -1
[  245.840773] cxl_core:cxl_detach_ep:1582: cxl_mem mem0: disconnect mem0 from port1

# echo mem0 > /sys/bus/cxl/drivers/cxl_mem/bind
[  274.069306] cxl_core:devm_cxl_enumerate_ports:1897: cxl_mem mem0: scan: iter: mem0 dport_dev: 0000:0c:01.0 parent: c
[  274.073705] cxl_core:devm_cxl_enumerate_ports:1903: cxl_mem mem0: found already registered port port1:pci0000:0c
[  274.075243] cxl_core:cxl_port_alloc:793: cxl_mem mem0: host-bridge: pci0000:0c
[  274.078191] cxl_core:cxl_cdat_get_length:487: cxl_port endpoint2: CDAT length 160
[  274.085249] cxl_core:cxl_port_perf_data_calculate:207: cxl_port endpoint2: Failed to retrieve ep perf coordinates.
[  274.088401] cxl_core:cxl_endpoint_parse_cdat:423: cxl_port endpoint2: Failed to do perf coord calculations.
[  274.113595] cxl_core:init_hdm_decoder:1129: cxl_port endpoint2: decoder2.0: range: 0x0-0xffffffffffffffff iw: 1 ig:6
[  274.117190] cxl_core:add_hdm_decoder:39: cxl_mem mem0: decoder2.0 added to endpoint2
[  274.118840] cxl_core:init_hdm_decoder:1129: cxl_port endpoint2: decoder2.1: range: 0x0-0xffffffffffffffff iw: 1 ig:6
[  274.121448] cxl_core:add_hdm_decoder:39: cxl_mem mem0: decoder2.1 added to endpoint2
[  274.122833] cxl_core:init_hdm_decoder:1129: cxl_port endpoint2: decoder2.2: range: 0x0-0xffffffffffffffff iw: 1 ig:6
[  274.125143] cxl_core:add_hdm_decoder:39: cxl_mem mem0: decoder2.2 added to endpoint2
[  274.126618] cxl_core:init_hdm_decoder:1129: cxl_port endpoint2: decoder2.3: range: 0x0-0xffffffffffffffff iw: 1 ig:6
[  274.128329] cxl_core:add_hdm_decoder:39: cxl_mem mem0: decoder2.3 added to endpoint2
[  274.129296] cxl_core:cxl_bus_probe:2322: cxl_port endpoint2: probe: 0
[  274.130374] cxl_core:devm_cxl_add_port:1001: cxl_mem mem0: endpoint2 added to port1
[  274.131159] cxl_core:cxl_bi_ctrl_endpoint:1124: cxl_pci 0000:0e:00.0: BI requests enabled
[  274.131858] cxl_core:cxl_bus_probe:2322: cxl_mem mem0: probe: 0


4. Discovery of 2 BI capable devices behind a switch (w/ flit mode)
-------------------------------------------------------------------
[    0.826785] cxl_core:cxl_probe_component_regs:102: cxl_pci 0000:10:00.0: found BI Decoder capability (0xab4)
[    0.851769] cxl_core:cxl_probe_component_regs:102: cxl_pci 0000:0f:00.0: found BI Decoder capability (0xab4)
[    0.897871] cxl_core:cxl_probe_component_regs:102: pcieport 0000:0c:00.0: found BI Decoder capability (0xab4)
[    1.092842] cxl_port:cxl_port_init_bi:134: cxl_port port2: BI RT registers not found
[    1.099965] cxl_core:cxl_probe_component_regs:96: cxl_port port2: found BI RT capability (0xaa8)
[    1.135528] cxl_core:cxl_probe_component_regs:102: pcieport 0000:0e:02.0: found BI Decoder capability (0xab4)
[    1.140404] cxl_core:cxl_probe_component_regs:102: pcieport 0000:0e:03.0: found BI Decoder capability (0xab4)
[    1.231808] cxl_core:cxl_is_bi_capable:934: cxl_pci 0000:12:00.0: No BI Decoder registers.
[    1.232783] cxl_core:cxl_probe_component_regs:102: pcieport 0000:0e:00.0: found BI Decoder capability (0xab4)
[    1.278969] cxl_port:cxl_port_init_bi:126: cxl_port endpoint5: BI Decoder registers not found
[    1.335363] cxl_core:cxl_is_bi_capable:934: cxl_pci 0000:11:00.0: No BI Decoder registers.
[    1.335988] cxl_core:cxl_probe_component_regs:102: pcieport 0000:0e:01.0: found BI Decoder capability (0xab4)
[    1.541584] cxl_core:__cxl_bi_commit:1027: pcieport 0000:0e:00.0: BI-ID commit wait took 204936us
[    1.547472] cxl_core:cxl_bi_ctrl_endpoint:1124: cxl_pci 0000:0f:00.0: BI requests enabled
[    1.797585] cxl_core:__cxl_bi_commit:1027: pcieport 0000:0e:01.0: BI-ID commit wait took 203346us
[    1.801055] cxl_core:cxl_bi_ctrl_endpoint:1124: cxl_pci 0000:10:00.0: BI requests enabled

5. Mixed Configurations (BI-capable Type 3 but DSP 68b)
-------------------------------------------------------
[    1.475849] cxl_mem:cxl_mem_probe:160: cxl_mem mem3: BI setup failed rc=-22

# echo 1 > /sys/bus/cxl/devices/decoder5.0/bi
-bash: echo: write error: Invalid argument

# echo region0 > /sys/bus/cxl/devices/decoder0.0/create_ram_bi_region
# echo decoder5.0 > /sys/bus/cxl/devices/region0/target0
[  384.895032] cxl_core:cxl_region_attach:2062: cxl region0: mem0:decoder5.0 BI not enabled on device
[  384.896300] cxl_port endpoint5: failed to attach decoder5.0 to region0: -6


6. Detect mismatch between decoder and region types
---------------------------------------------------
# echo 1 > /sys/bus/cxl/devices/decoder2.0/bi
# echo region0 > /sys/bus/cxl/devices/decoder0.0/create_ram_region    <- no bi
...
# echo decoder2.0 > /sys/bus/cxl/devices/region0/target0
[   24.738308] cxl_core:cxl_region_attach:2048: cxl region0: mem0:decoder2.0 type mismatch: 2 vs 3

7. Corrupted hw (commit timeout handling)
-----------------------------------------
[    1.311323] cxl_core:__cxl_bi_get_timeout_us:953: pcieport 0000:0e:00.0: Invalid BI commit timeout scale: 9
[    6.348610] cxl_core:__cxl_bi_commit:1027: pcieport 0000:0e:00.0: BI-ID commit timed out (5000000us)
[    6.356933] cxl_core:__cxl_bi_get_timeout_us:953: pcieport 0000:0e:00.0: Invalid BI commit timeout scale: 9
[   11.404735] cxl_core:__cxl_bi_commit:1027: pcieport 0000:0e:00.0: BI-ID commit timed out (5000000us)
[   11.409333] cxl_mem:cxl_mem_probe:155: cxl_mem mem2: BI setup failed rc=-110
[   11.432828] cxl_port:cxl_port_init_bi:126: cxl_port endpoint6: BI Decoder registers not found
[   11.471585] cxl_core:cxl_is_bi_capable:934: cxl_pci 0000:10:00.0: No BI Decoder registers.

Applies against 'fixes' branch (7.1-rc3) from cxl.git.

[0] https://lore.kernel.org/linux-cxl/20260428200410.705675-1-dave@stgolabs.net/

Thanks!

Davidlohr Bueso (5):
  cxl: Add BI register probing and port initialization
  cxl/pci: Add BI topology enable/disable
  cxl/hdm: Add BI coherency support for endpoint decoders
  cxl: Add HDM-DB region creation and sysfs interface
  cxl/mem: Wire up BI for Type 3 device

 Documentation/ABI/testing/sysfs-bus-cxl |  39 ++-
 drivers/cxl/acpi.c                      |   2 +
 drivers/cxl/core/core.h                 |   4 +
 drivers/cxl/core/hdm.c                  |  53 +++-
 drivers/cxl/core/pci.c                  | 319 ++++++++++++++++++++++++
 drivers/cxl/core/port.c                 |  64 ++++-
 drivers/cxl/core/region.c               |  60 ++++-
 drivers/cxl/core/regs.c                 |  14 ++
 drivers/cxl/cxl.h                       |  41 +++
 drivers/cxl/cxlmem.h                    |   2 +
 drivers/cxl/mem.c                       |   4 +
 drivers/cxl/port.c                      |  89 +++++++
 include/cxl/cxl.h                       |   8 +
 13 files changed, 688 insertions(+), 11 deletions(-)


base-commit: 5d6919055dec134de3c40167a490f33c74c12581
--
2.39.5

