Received: from siberian.tulip.relay.mailchannels.net (siberian.tulip.relay.mailchannels.net [23.83.218.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775031E98E6
	for <linux-cxl@vger.kernel.org>; Tue, 12 Aug 2025 01:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.246
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754960963; cv=pass; b=hrgylrg6wOKsa7MUWcQwtxP5pb7YcWwEpr4Tp3hWzSUEd4mkoOGyGuGIKIucu3zVINS6T2VQE/pBaSu35HJknRRxTg876kEifUtwjaFs/ZpZdjzXOWMilL4Eup9mBfiPxU/+tFYWSnH9fUlsCGUTIBssIoxLWGHVIPp/pCFUIZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754960963; c=relaxed/simple;
	bh=AUM1fBwvmJmx6wgpiW8qVhIo1udkQUNw0o8Amq7rPXk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=paBk48CXXaFKEtVCjC0rO7DVXnfmRfVD1Y7eRUEGvPe4Qe3+CQHOLmy5pAJWcHWe87wAFE0NVbvBs/jvqaHaIB/BJhfNoOWtB/8IjpGd6frM25hBXeJOyfxrCeyXndRSiwFbvQvxKnXLDZVX7tz47aJMMqqZkbmmvt/QVbOKJKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=ENc7cLM+; arc=pass smtp.client-ip=23.83.218.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="ENc7cLM+"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 6EEE91C5336;
	Tue, 12 Aug 2025 01:02:31 +0000 (UTC)
Received: from pdx1-sub0-mail-a202.dreamhost.com (100-96-2-147.trex-nlb.outbound.svc.cluster.local [100.96.2.147])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 118421C52FE;
	Tue, 12 Aug 2025 01:02:31 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1754960551; a=rsa-sha256;
	cv=none;
	b=Mmel96M/obqRytGKNTsZLMzav3nMRULE/683TLVCBdl4PK8/n7Pr7tCwD1IFd6RrchDTAR
	B/r+kK72uliC2/OLaLPxxEdyPoTUHqrt5skiqG3MhyVXtU59tHWK5Z9dnTfu3oqQCZrw8T
	k682tUPh1plDVUyiAe1tSKglxczVSlJyb6tQInXeTvEdCm8BWM+kp7zRO0SG7M7vL1Zswq
	sL4zclMMldsMn2UIhBuh/C6gerhxwRy+qGjOgrp/bOTVxcW3o7TiOL7tZxhjfQGzhMPC1W
	+/v4SvhT4TwAukTgInYzPsWSN8qKehYj9sKwpWWHtKLoJ3e3HC2RdMjvmJzLxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1754960551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=Hh5ysexVrTFznrGHAtfg5xgKbvMyGCXSjv80IO3knVE=;
	b=kiet00VKEmekzPkHu7cc+GVueRRbI+pN3HShPPxcNFR2QLlG8CTZ/zax8ruE8WHIqyC8ux
	aN1gl3x3Y1M2iRwFlNfIynHN87bqpHOSwrEsEKGJEVEK21flTbKmIOWGEpevpCGK71O6ly
	LdEZrn0KST/3inasQQbI/X0sDlPGVb877yCGIswtJDU/A71g/0Y2m7vfQeH2v9uZNMeQdi
	51XuyPqzUPNLiI7ogSBn+qQ2A4Zalt0fG/Abcep3qbJH7i1Dj/fMJ+1fHXL+ycVuuBMMER
	YiKIc/qMNpP77Lgsep0L6IzO58m8GCkK0TX7Znvc3hEjWR0yO3QtcU+ZfExi8w==
ARC-Authentication-Results: i=1;
	rspamd-7c5968dc44-5phbq;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Whimsical-Spot: 753ced002dcfbfb2_1754960551362_785055954
X-MC-Loop-Signature: 1754960551362:74361862
X-MC-Ingress-Time: 1754960551361
Received: from pdx1-sub0-mail-a202.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.2.147 (trex/7.1.3);
	Tue, 12 Aug 2025 01:02:31 +0000
Received: from offworld.lan (syn-076-167-199-067.res.spectrum.com [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a202.dreamhost.com (Postfix) with ESMTPSA id 4c1CsL2LMYz2B;
	Mon, 11 Aug 2025 18:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1754960550;
	bh=Hh5ysexVrTFznrGHAtfg5xgKbvMyGCXSjv80IO3knVE=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=ENc7cLM+ryGRiJi8jopAMJsUooRHgtKVXrEEkAJ76haWdeeLKZc7qaD3EWXvvQHC/
	 94xLAa0s0ILCwUh1tmkfdit0PpamEounNGbMO+fZ6PrFwN3YmRdF5FKZKNmIpNzHWP
	 YN3WiQ0oQYqS6xp16p+1+vz3Mlk2TGRsYwxSKu/2BHEidjnKjOIbT6m1T6K3tinHqY
	 ImRyq4YIxgwG2oRVu+V/leaYc7iyoTrbJlKDSp84iwcPA9HUonuQay+blSLGvxNVTZ
	 YFqqqGM8JHqfXe5Dx6i5QHcekYH2P7AZF3LnzCdNn4kan1vYc568Apa0Fm+lIwcvjV
	 c6CYyb0fFNHpw==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com,
	dan.j.williams@intel.com
Cc: jonathan.cameron@huawei.com,
	ira.weiny@intel.com,
	alison.schofield@intel.com,
	alucerop@amd.com,
	a.manzanares@samsung.com,
	anisa.su@samsung.com,
	linux-cxl@vger.kernel.org,
	dave@stgolabs.net
Subject: [PATCH RFC 0/3] cxl: Initial support for Back-Invalidate
Date: Mon, 11 Aug 2025 18:02:25 -0700
Message-Id: <20250812010228.2589787-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

The following is some initial plumbing to enabling HDM-DB in Linux. This model allows devices,
specifically Type 2 and Type 3 devices, to expose their local memory to the host CPU in a
coherent manner, In alignment with what was discussed at last year's LPC type2 support session,
this series takes the type3 memory expander approach, which is more direct.

While this is an early RFC and I'm sure many thoughts, the next phase of this would be to
integrate Bi with Alejandro's Type2 work as well as with Jonathan's Cache Coherency subsystem
series (aka memregion inv)... this might be a good topic for the upcoming LPC's devmem session:
	https://lore.kernel.org/linux-cxl/20250624141355.269056-1-alejandro.lucero-palau@amd.com
	https://lore.kernel.org/linux-cxl/20250624154805.66985-1-Jonathan.Cameron@huawei.com

o Patch 1 adds the BI cachemem register discovery along with two interfaces around cxlds to allow
the setup and deallocations of BI-IDs. The idea is for type3 memdevs and future type2 devices
to make use of cxlds->bi when committing HDM decoders, such that different device coherence models
can be differentiated as:

	type2 hdm-db: cxlds->type == CXL_DEVTYPE_DEVMEM && cxlds->bi == true
	type2 hdm-d:  cxlds->type == CXL_DEVTYPE_DEVMEM && cxlds->bi == false
	type3 hdm-h:  cxlds->type == CXL_DEVTYPE_CLASSMEM && cxlds->bi == false
	type3 hdm-db: cxlds->type == CXL_DEVTYPE_CLASSMEM && cxlds->bi == true
	
Because ->bi becoming true does not depend on auto-committing upon HDM decoder port/enumeration
(port driver), for now this is set as unsupported and will error out when initializing the HDM
decoder that has its BI bit set.

o Patch 2 renames/updates some of the CXL Window coherency restrictions. This should be picked
up regardless as the spec has been updated already.

o Patch 3 deals with the HDM decoder programming changes around whether or not to set the
BI bit. Based on the model above, decoder target types are straightforward: DEVMEM or HOSTONLY
for type2 and regular type3, but for type3 HDM-DB, this is not as clear, for which this patch
will 1) rely on the HDM capability for supporting coherence models, and 2) allow, when possible,
to change it by the user when configuring the BI-capable HDM decoder. It gives the user sysfs
tools to create BI-enabled memory regions (see testing below).

Testing has been done with the qemu hdm-db type3 counterpart:
	https://lore.kernel.org/linux-cxl/20250806055708.196851-1-dave@stgolabs.net/

1. BI discovery + BI-ID setup flow.
----------------------------------
i. 1 direct attached + 1 regular (hdm-h)
-+-[0000:00]-+-00.0
 |           +-01.0
 |           +-02.0
 |           +-03.0
 |           +-1f.0
 |           +-1f.2
 |           \-1f.3
 \-[0000:0c]-+-00.0-[0d]----00.0
             \-01.0-[0e]----00.0

[    0.799322] cxl_core:cxl_probe_component_regs:102: pci 0000:0c:00.0: found BI Decoder capability (0xab4)
[    0.805787] cxl_core:cxl_probe_component_regs:102: pci 0000:0c:01.0: found BI Decoder capability (0xab4)
[    1.862826] cxl_core:cxl_probe_component_regs:102: cxl_pci 0000:0d:00.0: found BI Decoder capability (0xab4)
[    1.944015] cxl_core:__cxl_is_bi_capable:1115: cxl_pci 0000:0e:00.0: No BI Decoder registers.
[    1.994400] cxl_core:__cxl_bi_decoder_endpoint_enable:1279: cxl_pci 0000:0d:00.0: device capable of issuing BI requests

ii. 4 attached hdm-db to a 4x switch under the rp
-+-[0000:00]-+-00.0
 |           +-01.0
 |           +-02.0
 |           +-03.0
 |           +-1f.0
 |           +-1f.2
 |           \-1f.3
 \-[0000:0c]-+-00.0-[0d-12]----00.0-[0e-12]--+-00.0-[0f]----00.0
             |                               +-01.0-[10]----00.0
             |                               +-02.0-[11]----00.0
             |                               \-03.0-[12]----00.0
             \-01.0-[13]--

[    1.866181] cxl_core:cxl_probe_component_regs:102: cxl_pci 0000:10:00.0: found BI Decoder capability (0xab4)
[    1.871194] cxl_core:cxl_probe_component_regs:102: cxl_pci 0000:0f:00.0: found BI Decoder capability (0xab4)
[    1.891820] cxl_core:cxl_probe_component_regs:96: cxl port2: found BI RT capability (0xaa8)
[    1.896952] cxl_core:cxl_probe_component_regs:102: pcieport 0000:0e:00.0: found BI Decoder capability (0xab4)
[    1.897578] cxl_core:cxl_probe_component_regs:102: pcieport 0000:0e:01.0: found BI Decoder capability (0xab4)
[    1.906578] cxl_core:cxl_probe_component_regs:102: pcieport 0000:0e:02.0: found BI Decoder capability (0xab4)
[    2.036098] cxl_core:cxl_probe_component_regs:102: pcieport 0000:0e:03.0: found BI Decoder capability (0xab4)
[    3.740107] cxl_core:__cxl_bi_commit:1180: pcieport 0000:0e:03.0: BI-ID commit wait took 212059us
[    3.944239] cxl_core:__cxl_bi_commit_rt:1170: cxl_port port2: BI-ID commit wait took 202985us
[    3.950446] cxl_core:__cxl_bi_decoder_endpoint_enable:1278: cxl_pci 0000:12:00.0: device capable of issuing BI requests
[    4.192058] cxl_core:__cxl_bi_commit:1180: pcieport 0000:0e:02.0: BI-ID commit wait took 207341us
[    4.400570] cxl_core:__cxl_bi_commit_rt:1170: cxl_port port2: BI-ID commit wait took 207559us
[    4.411170] cxl_core:__cxl_bi_decoder_endpoint_enable:1278: cxl_pci 0000:11:00.0: device capable of issuing BI requests
[    4.664350] cxl_core:__cxl_bi_commit:1180: pcieport 0000:0e:01.0: BI-ID commit wait took 205648us
[    4.872299] cxl_core:__cxl_bi_commit_rt:1170: cxl_port port2: BI-ID commit wait took 204156us
[    4.884823] cxl_core:__cxl_bi_decoder_endpoint_enable:1278: cxl_pci 0000:10:00.0: device capable of issuing BI requests
[    5.128481] cxl_core:__cxl_bi_commit:1180: pcieport 0000:0e:00.0: BI-ID commit wait took 203259us
[    5.336216] cxl_core:__cxl_bi_commit_rt:1170: cxl_port port2: BI-ID commit wait took 204688us
[    5.341730] cxl_core:__cxl_bi_decoder_endpoint_enable:1278: cxl_pci 0000:0f:00.0: device capable of issuing BI requests

# echo 1 > /sys/bus/pci/devices/0000\:0f\:00.0/remove
[   52.280098] cxl_core:__cxl_bi_commit:1180: pcieport 0000:0e:00.0: BI-ID commit wait took 204661us
[   52.488101] cxl_core:__cxl_bi_commit_rt:1170: cxl_port port2: BI-ID commit wait took 206595us
[   52.497619] cxl_core:cxl_detach_ep:1500: cxl_mem mem0: disconnect mem0 from port2
[   52.500290] cxl_core:cxl_detach_ep:1500: cxl_mem mem0: disconnect mem0 from port1

2. HDM Decoder with BI through ad-hoc region creation.
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
[  154.073077] cxl_core:cxl_region_can_probe:3588: cxl_region region0: config state: 0
[  154.073495] cxl_core:cxl_bus_probe:2125: cxl_region region0: probe: -6
[  154.073939] cxl_core:devm_cxl_add_region:2563: cxl_acpi ACPI0017:00: decoder0.0: created region0

Configure the region with the same IG, IW the root and endpoint decoders
# echo 256 > /sys/bus/cxl/devices/region0/interleave_granularity
# echo 1 > /sys/bus/cxl/devices/region0/interleave_ways
# echo 0x40000000 > /sys/bus/cxl/devices/region0/size
 
Link the endpoint decoder as a target in the region
# echo decoder2.0 > /sys/bus/cxl/devices/region0/target0
[  177.351922] cxl_core:cxl_port_attach_region:1174: cxl region0: mem0:endpoint2 decoder2.0 add: mem0:decoder2.0 @ 0 next: none nr_eps: 1 nr_targets: 1
[  177.353539] cxl_core:cxl_port_attach_region:1174: cxl region0: pci0000:0c:port1 decoder1.0 add: mem0:decoder2.0 @ 0 next: mem0 nr_eps: 1 nr_targets: 1
[  177.354133] cxl_core:cxl_port_setup_targets:1494: cxl region0: pci0000:0c:port1 iw: 1 ig: 256
[  177.354508] cxl_core:cxl_port_setup_targets:1518: cxl region0: pci0000:0c:port1 target[0] = 0000:0c:00.0 for mem0:decoder2.0 @ 0
[  177.355182] cxl_core:cxl_calc_interleave_pos:1885: cxl_mem mem0: decoder:decoder2.0 parent:0000:0d:00.0 port:endpoint2 range:0x120000000-0x15fffffff pos:0
[  177.355793] cxl_core:cxl_region_attach:2087: cxl decoder2.0: Test cxl_calc_interleave_pos(): success test_pos:0 cxled->pos:0

Commit the changes
# echo 1 > /sys/bus/cxl/devices/region0/commit
[  183.126515] cxl region0: Bypassing cpu_cache_invalidate_memregion() for testing!
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

ii. On a type3 HDM-DB volatile device, create one BI and one regular region.
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
# echo region0 > /sys/bus/cxl/devices/decoder0.0/create_ram_region
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

iii. Detect mismatch between decoder and region types.
[  217.911488] cxl_core:cxl_region_attach:1977: cxl region1: mem0:decoder2.0 type mismatch: 2 vs 3
[   23.269994] cxl_core:cxl_region_attach:1987: cxl region0: mem0:decoder2.0 type mismatch: 3 vs 2 (no HDM-DB device)

Applies against the 'next' branch of cxl.git.

Thanks!

Davidlohr Bueso (3):
  cxl/pci: Back-Invalidate device discovery and setup
  acpi, tables: Rename coherency CFMW restrictions
  cxl: Support creating HDM-DB regions

 Documentation/ABI/testing/sysfs-bus-cxl |  41 ++-
 drivers/cxl/acpi.c                      |   6 +-
 drivers/cxl/core/core.h                 |   4 +
 drivers/cxl/core/hdm.c                  |  56 ++++-
 drivers/cxl/core/pci.c                  | 318 ++++++++++++++++++++++++
 drivers/cxl/core/port.c                 |  57 ++++-
 drivers/cxl/core/region.c               |  57 ++++-
 drivers/cxl/core/regs.c                 |  13 +
 drivers/cxl/cxl.h                       |  47 +++-
 drivers/cxl/cxlmem.h                    |   3 +
 drivers/cxl/mem.c                       |   2 +
 drivers/cxl/pci.c                       |   5 +
 drivers/cxl/port.c                      |  67 +++++
 include/acpi/actbl1.h                   |   5 +-
 tools/testing/cxl/test/cxl.c            |  18 +-
 15 files changed, 661 insertions(+), 38 deletions(-)

-- 
2.39.5

