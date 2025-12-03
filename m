Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C8C2AD2C
	for <linux-cxl@vger.kernel.org>; Wed,  3 Dec 2025 20:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764794160; cv=none; b=TABNyqMqfqpdovL5sCltAzxwQKJHy1tuBWU1hiQUva7G7q2PfUSV8ggaLLX3aGhAiAMw1V9SaeoDRam6FbPE4VV3FSbxYXn9gRXY/bovydFX64KI/gF7nDcSyDAvTbALoz6UtnUhMgBab9hy9SaVD7Pm8X/XTwZ1GTne+ZqbJKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764794160; c=relaxed/simple;
	bh=9qePrqNymg4r46B6Q0OJJWY8yKi8nCv8858Xb6T84uw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pHUj87hH+TnArxoNumQsmKV5/tjd774TeNzsIPtAcJLvlatAapjpkIjp1CLpeLxhQUYIscUhUgCViU0jTU3Ku95rmS0ekQAW0Gf3KGYqzZJpgb8xAJLIezdacfj1u4eOCxsEoNFj6/KdTKYSWQ7G0vX/cKdSpOCvb34swz5Fmx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FpMaEg8G; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FpMaEg8G"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7b80fed1505so154270b3a.3
        for <linux-cxl@vger.kernel.org>; Wed, 03 Dec 2025 12:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764794158; x=1765398958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LEX1KF9cVhZXNRbTAUTfbL2k8LCaJFOW6eD9jCYJwY4=;
        b=FpMaEg8GNbqtx1TLAzwOmsdvBXvkoOgxgHGSyT7J+0ZAQqTlzPe9WnLg2kmdycWhG7
         se9EN5Qs46Sl66Yf5ybTpr4fREAZec1lyUF/IaGKUQl/dzUofzVqUMjgsQFEEwmsEHkm
         o6fIO7VFSsjJlOHqr4VY/4kXlrYNkExDqlmlZAIjH1Vqkluf1V/fLwMrvY9LuICS2kxE
         toTrXpmJWFXX9NjeNcnJX5qEND6Yu370qRxnDN2E+QAc/IxQxLxOVwolbaKcaIRUqr4O
         jJ1EBuBsXtwgHGXnWxhHvHvDdOML5WQbokdhSNw6Brp9FzK/PDWXR0aLDIWD6kP7QB2c
         45xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764794158; x=1765398958;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LEX1KF9cVhZXNRbTAUTfbL2k8LCaJFOW6eD9jCYJwY4=;
        b=T5fpDCOwRZdCB+zKOHzaJ1y4RGkJEq/4lrrY3sOBC39asn6Zg0osnJZ1g7Uu/N4JEL
         JuJ41S2YUUerePME4E3CK0NbA/pXblLQGORgF2WGJfzW7ckJvsXeJtpNNriE4QQSmb0q
         TNgsr1TA7GEA4q1vk3obhXWw0q1YYDh9AHY2zY6CUv6H6+7wCbL03BvMGdc3crlLu4li
         N0Ge4haA87dQ5YVMHoJpJoNd7OnC+w+dperliDYhJ+IBDxxahQSaZVNFJvJgpKqIY1Zu
         f2ehBZxxdTpT9uS4oRfaWaH1q7E6v6AkHRVLmks8p+ZcsCp/NgxthyWcVyWN0sZxdJka
         3q/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXWj8sEaYf5ProXMz6yHwIY9GTdwkoEEzs8FN0mA0fEy+r7AOaBIN4VKGsnGQLLyLTjbDuCuApDh0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCwSudiQE5s4+NLEyVe74Kg8koUrT6f+3M985JLvcxdf4zOc8C
	BL1DLeKQn9siAVXaeyfClG4IhTstVxBoI5wVGHjZdBnDIVHhUumD7Ouc
X-Gm-Gg: ASbGncv8rYYDDOSxBSluFhxOz1kSwq/ikUIQ8uqgyDCPKfYsRmTyiZE/E7OVbzXc/xQ
	SIWqJ+lVAvF2fvanQIZeJZCrYB3evNRrfyQ53stzjs4yYHF4rl1wUaQSu67EK6oXutf2ulKtZSx
	0R3DjX9wVMcTrpzBKKPnowJ5iUMCq3RUBM5K1ZKA5CslP8RVccJE+nVb9Rdge8rZitIu4O+8WOi
	0aH/AY2afKOGZvFP4jFMBUr01i6+3UG0HPxgO+gkS8jhbogj5PCxntihze/MRnaKlFyx+b2Ikww
	RdJAJsEBjGAQyWGzOmncksC30CKLKen/mpXlMLvB/PtEVcY39+KmxZ9yOmnoPv2oiZ+lFMnhmfe
	F2oJ2vlBqbwda09O1ScCRRhNBoEh/kDZ2ig0RoLDQ3d3kNkhsG1b7IR+DN4mx/M5YZuTPtAyjgF
	5DaE9vJu1/+H9Ba96AQkiLRsIeuyu0lhth
X-Google-Smtp-Source: AGHT+IHpEO/qyt6IQywFUWeWAAuS23PTi8IGgLpD6B4XCw/rrjEoGDfeKhw1oBhLU+oszQBM6mV0lA==
X-Received: by 2002:a05:7022:11d:b0:119:e56b:957b with SMTP id a92af1059eb24-11df0bbdcf6mr3955877c88.0.1764794158187;
        Wed, 03 Dec 2025 12:35:58 -0800 (PST)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcb04a07bsm88257115c88.7.2025.12.03.12.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 12:35:57 -0800 (PST)
From: anisa.su887@gmail.com
To: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org
Cc: nifan.cxl@gmail.com,
	dongjoo.seo1@samsung.com,
	Anisa Su <anisa.su@samsung.com>
Subject: [RFC PATCH 0/3] Add Support for Multiple DC Regions
Date: Wed,  3 Dec 2025 20:29:10 +0000
Message-ID: <20251203203540.1091827-1-anisa.su887@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Anisa Su <anisa.su@samsung.com>

This patchset introduces support for multiple DC regions. It is rebased on top
of the latest branch published to Ira's repository:
https://github.com/weiny2/linux-kernel/tree/dcd-v6-2025-09-23.
We hope it will be useful in the meantime for others and restart some
discussion around how to move DCD forward.

The corresponding NDCTL support can be found on this branch:
https://github.com/anisa-su993/anisa-ndctl/tree/multiple-dc-region-support.
I will reply to this thread with a reference to the thread for the
NDCTL patches once published.

Testing:
This patchset was tested on a QEMU VM with the following topology:

PCIE Root (pcie.0)
│
├─ CXL Fixed Memory Window cxl-fmw.0
├─ CXL Root Complex cxl.0
│  └─ Root Port root_port1
│     └─ CXL Type-3 Device cxl-dcd0
│
├─ CXL Fixed Memory Window cxl-fmw.1
├─ CXL Root Complex cxl.1
│  └─ Root Port root_port2
│     └─ CXL Type-3 Device cxl-dcd1
└─

"-object memory-backend-file,id=cxl-mem1,share=on,mem-path=/tmp/t3_cxl1.raw,size=8G \
-object memory-backend-file,id=cxl-lsa1,share=on,mem-path=/tmp/t3_lsa1.raw,size=1M \
-object memory-backend-file,id=cxl-mem2,share=on,mem-path=/tmp/t3_cxl2.raw,size=8G \
-object memory-backend-file,id=cxl-lsa2,share=on,mem-path=/tmp/t3_lsa2.raw,size=1M \
-device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.0,hdm_for_passthrough=true \
-device pxb-cxl,bus_nr=48,bus=pcie.0,id=cxl.1,hdm_for_passthrough=true \
-device cxl-rp,port=0,bus=cxl.0,id=root_port1,chassis=0,slot=1 \
-device cxl-rp,port=1,bus=cxl.1,id=root_port2,chassis=1,slot=1 \
-device cxl-type3,bus=root_port1,volatile-dc-memdev=cxl-mem1,id=cxl-dcd0,lsa=cxl-lsa1,num-dc-regions=8,sn=99 \
-device cxl-type3,bus=root_port2,volatile-dc-memdev=cxl-mem2,id=cxl-dcd1,lsa=cxl-lsa2,num-dc-regions=8,sn=100 \
-machine cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=8G,cxl-fmw.1.targets.0=cxl.1,cxl-fmw.1.size=8G"

2 CFMWs and 2 root complexes are emulated because QEMU creates
4 decoders/topology level. With 1 root complex, there are only 4 upstream
decoders. Therefore in order to create 4+ regions, we need a total of
8 upstream decoders. This does mean that we are only able to create
4 regions on each device, although up to 8 are supported.

Using `cxl list`, we can see mem0 and mem1 have dynamic_ram_* capablities:
root@deb-101020-bm01:~# cxl list
[
  {
    "memdevs":[
      {
        "memdev":"mem0",
        "dynamic_ram_0_size":1073741824,
        "dynamic_ram_1_size":1073741824,
        "dynamic_ram_2_size":1073741824,
        "dynamic_ram_3_size":1073741824,
        "dynamic_ram_4_size":1073741824,
        "dynamic_ram_5_size":1073741824,
        "dynamic_ram_6_size":1073741824,
        "dynamic_ram_7_size":1073741824,
        "serial":100,
        "host":"0000:31:00.0",
        "firmware_version":"BWFW VERSION 00"
      },
      {
        "memdev":"mem1",
        "dynamic_ram_0_size":1073741824,
        "dynamic_ram_1_size":1073741824,
        "dynamic_ram_2_size":1073741824,
        "dynamic_ram_3_size":1073741824,
        "dynamic_ram_4_size":1073741824,
        "dynamic_ram_5_size":1073741824,
        "dynamic_ram_6_size":1073741824,
        "dynamic_ram_7_size":1073741824,
        "serial":99,
        "host":"0000:0d:00.0",
        "firmware_version":"BWFW VERSION 00"
      }
    ]
  }
]

To create the 8 regions:
cxl create-region -m -d decoder0.0 -w 1 -s 1G mem1 -t dynamic_ram_0
cxl create-region -m -d decoder0.0 -w 1 -s 1G mem1 -t dynamic_ram_1
cxl create-region -m -d decoder0.0 -w 1 -s 1G mem1 -t dynamic_ram_2
cxl create-region -m -d decoder0.0 -w 1 -s 1G mem1 -t dynamic_ram_3

cxl create-region -m -d decoder0.1 -w 1 -s 1G mem0 -t dynamic_ram_4
cxl create-region -m -d decoder0.1 -w 1 -s 1G mem0 -t dynamic_ram_5
cxl create-region -m -d decoder0.1 -w 1 -s 1G mem0 -t dynamic_ram_6
cxl create-region -m -d decoder0.1 -w 1 -s 1G mem0 -t dynamic_ram_7


We can verify the 8 regions:
root@deb-101020-bm01:~# cxl list
[
  {
    "memdevs":[
...
  },
  {
    "regions":[
      {
        "region":"region0",
        "resource":79993765888,
        "size":1073741824,
        "interleave_ways":1,
        "interleave_granularity":256,
        "decode_state":"commit"
      },
      {
        "region":"region6",
        "resource":81067507712,
        "size":1073741824,
        "interleave_ways":1,
        "interleave_granularity":256,
        "decode_state":"commit"
      },
      {
        "region":"region7",
        "resource":82141249536,
        "size":1073741824,
        "interleave_ways":1,
        "interleave_granularity":256,
        "decode_state":"commit"
      },
      {
        "region":"region8",
        "resource":83214991360,
        "size":1073741824,
        "interleave_ways":1,
        "interleave_granularity":256,
        "decode_state":"commit"
      },
      {
        "region":"region1",
        "resource":88315265024,
        "size":1073741824,
        "interleave_ways":1,
        "interleave_granularity":256,
        "decode_state":"commit"
      },
      {
        "region":"region2",
        "resource":89389006848,
        "size":1073741824,
        "interleave_ways":1,
        "interleave_granularity":256,
        "decode_state":"commit"
      },
      {
        "region":"region3",
        "resource":90462748672,
        "size":1073741824,
        "interleave_ways":1,
        "interleave_granularity":256,
        "decode_state":"commit"
      },
      {
        "region":"region4",
        "resource":91536490496,
        "size":1073741824,
        "interleave_ways":1,
        "interleave_granularity":256,
        "decode_state":"commit"
      }
    ]
  }
]

Extents of various sizes (128MB, 256MB, 512MB, and 1GB) are added from mem1,
which correspond to regions 0-3, then DAX devices are created from them.
The extent DPAs are as follows, which allows each one to map to a distinct
region:
 - [0-128] --> region0
 - [1024-1280] --> region1
 - [2048-2560] --> region2
 - [3072-4096] --> region3

The correct sizes can be verified when creating the DAX device.
root@deb-101020-bm01:~/libcxlmi# daxctl create-device -r region0
[
  {
    "chardev":"dax0.1",
    "size":134217728,
    "target_node":1,
    "align":2097152,
    "mode":"devdax"
  }
]
created 1 device
root@deb-101020-bm01:~/libcxlmi# daxctl create-device -r region1
[
  {
    "chardev":"dax1.1",
    "size":268435456,
    "target_node":1,
    "align":2097152,
    "mode":"devdax"
  }
]
created 1 device
root@deb-101020-bm01:~/libcxlmi# daxctl create-device -r region2
[
  {
    "chardev":"dax2.1",
    "size":536870912,
    "target_node":1,
    "align":2097152,
    "mode":"devdax"
  }
]
created 1 device
root@deb-101020-bm01:~/libcxlmi# daxctl create-device -r region3
[
  {
    "chardev":"dax3.1",
    "size":1073741824,
    "target_node":1,
    "align":2097152,
    "mode":"devdax"
  }
]
created 1 device

Then the DAX devices are reconfigured to system-ram mode and verified with lsmem.
root@deb-101020-bm01:~/libcxlmi# daxctl reconfigure-device dax0.1 -m system-ram
[
  {
    "chardev":"dax0.1",
    "size":134217728,
    "target_node":1,
    "align":2097152,
    "mode":"system-ram",
    "online_memblocks":1,
    "total_memblocks":1,
    "movable":true
  }
]
reconfigured 1 device
root@deb-101020-bm01:~/libcxlmi# daxctl reconfigure-device dax1.1 -m system-ram
...
root@deb-101020-bm01:~/libcxlmi# daxctl reconfigure-device dax2.1 -m system-ram
...
root@deb-101020-bm01:~/libcxlmi# daxctl reconfigure-device dax3.1 -m system-ram
...


root@deb-101020-bm01:~/libcxlmi# lsmem
RANGE                                  SIZE  STATE REMOVABLE   BLOCK
0x0000000000000000-0x000000007fffffff    2G online       yes    0-15
0x0000000100000000-0x000000027fffffff    6G online       yes   32-79
0x00000012a0000000-0x00000012a7ffffff  128M online       yes     596
0x00000012e0000000-0x00000012efffffff  256M online       yes 604-605
0x0000001320000000-0x000000133fffffff  512M online       yes 612-615
0x0000001360000000-0x000000139fffffff    1G online       yes 620-627

Memory block size:                128M
Total online memory:              9.9G
Total offline memory:               0B

-------------------------------------------------------------------------------
Note: I did try hacking QEMU to create 8 decoders at each level to avoid having
2 separate host bridges/DCDs by modifying include/hw/cxl/cxl_component.h like so:

#define CXL_HDM_DECODER_COUNT 8
HDM_DECODER_INIT(0);
HDM_DECODER_INIT(1);
HDM_DECODER_INIT(2);
HDM_DECODER_INIT(3);
HDM_DECODER_INIT(4);
HDM_DECODER_INIT(5);
HDM_DECODER_INIT(6);
HDM_DECODER_INIT(7);

However, when attempting to create the 5th cxl region,
I ran into a timeout error when committing the decoders.
Did not spend much time pursuing this further, most likely
need to change more things on the QEMU side.
But the 8 decoders do show up correctly under sysfs.

Fan Ni (3):
  core/region: fix return logic for store_targetN
  dax/cxl: add existing dc extents when probing dax region
  dcd: Add support for multiple DC regions

 drivers/cxl/core/cdat.c   |   2 +-
 drivers/cxl/core/core.h   |   9 +-
 drivers/cxl/core/extent.c |   2 +-
 drivers/cxl/core/hdm.c    |  18 +++-
 drivers/cxl/core/mbox.c   |  39 +++++----
 drivers/cxl/core/memdev.c | 179 +++++++++++++++++++++++++-------------
 drivers/cxl/core/port.c   |  45 ++++++++--
 drivers/cxl/core/region.c |  65 ++++++++------
 drivers/cxl/cxl.h         |  23 ++++-
 drivers/cxl/cxlmem.h      |   5 +-
 drivers/dax/cxl.c         |  28 ++----
 11 files changed, 281 insertions(+), 134 deletions(-)

-- 
2.51.0

