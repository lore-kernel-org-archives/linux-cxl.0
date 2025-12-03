Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931FF158535
	for <linux-cxl@vger.kernel.org>; Wed,  3 Dec 2025 21:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764796769; cv=none; b=TL3Nxqi0vU0hfcqOd4GE5oI2NitgetErJUPBYbWptWGMtRHn3Uq7pQ2h9qG6SK8TbjIY8ltj0KydUG7k8oDF23pRH1zK62w5jlprcyZYFPtvuVp/0JYOOaiDm3aIRiJZ/+EiRWcsqLUJ5epK5f3Py8ARohOnzB6sE5BetUJb7SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764796769; c=relaxed/simple;
	bh=x8qXC15/Cgop3/K39LwGYppSCTxA3BgaImYAalJPkb8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MJ7xEqpzV42Vq1/24yGwCAnuvz9oM2nyMFHBVeImpwnmqMun8JitGihsdgQ7xtwthbXePxr2grs4R0dnPLXjcKWHWrgxP5uqL94OEMeI0xsjSHQp5NJmZP34Wzrcx3AZFsk22INY+kyjbIMkyjcWHIhmPVKwXE/ku11iCvhPuWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RNXehJGg; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RNXehJGg"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3436d6ca17bso145446a91.3
        for <linux-cxl@vger.kernel.org>; Wed, 03 Dec 2025 13:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764796767; x=1765401567; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QvAamsCq1XkVVXH71kkXw+EqO7rzJ4O2VYlpeut4OGs=;
        b=RNXehJGgfwKwqED5vhbLHTHjsJM7ubI2ow8TZyyWT/jVHYb7m/B9tsXwoWsM0x1Jcp
         5xCbwewPYBzD8UVbrBqdV02NimXyr8iSQu76XzL+ZIw+tPvQH9UIa71sKeQPoNnFPxxf
         be0dNm8foBGc6aAiVwKekA2c2ErCcHlp5YOxrU4Cga5O3cBUmneungic/KzwRicpZJyU
         ay1z4+ntlfFv5YzPVrrLLv3XgRKVrqhUUle4aJ7ofc+Jj5bHsHvvEOLW3/e3Qio7sZRT
         FKLRzdPJcgQhZMncT/4nr0JSuV2I7rYE6NNIqsbkpWqcnul4ofdhJ90bXTXq8xNUKct7
         LZwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764796767; x=1765401567;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QvAamsCq1XkVVXH71kkXw+EqO7rzJ4O2VYlpeut4OGs=;
        b=RDDx5RCj/mCw2tnzyAKTvvl99Qx3ZoBwthT+fA7UXGOgSejGQtPw1KiCRmmqjDTGjT
         9yoiN27g6rCjU/d5geBz6AXV0hSr8sS2/vi+jYzpqD+K/vVULxF16qnU/L4oIB6K1ykC
         wv3zSAKDfBZHdhEaKx+IPkwGdZ7dU65WFk5BW1qjUbrfT7n6o38lBjdz2EJCiBbDop5C
         y1+8HFjX3hGFNA6C4KzS/rnEqGoawd5SDaS2l9m2HXVT5LEWsx3mnNftMP/dXYFwgfuf
         tokAHXv+NjhwQ2igisF24SKS2X9S5n2de17n9WQCWz1+8q8dZDgjCGY3FyDdKHpcQEoj
         /W5w==
X-Gm-Message-State: AOJu0YzRNqQfE9sx6/OiShnbS8s5QrE2SVfHlJztO0UA3SbcESfWNo7i
	gEjo2Fby2MldWRi1ygcsrV0fv6cgpD5f+PuLNE1vqfFTRZ7QNBmFDjT0tLEqcQ==
X-Gm-Gg: ASbGncsp+FCL+nhywWu9JZaretoUCsfSsNkMpkMwIIppF2tjy39I5G++D1re9GIwSI/
	pSgDJQBwi3EOP0GoUYScYy2lHkqy6OTcDmoJhOTFiuazNsGjkRbi6AEXUQqaQUKmHKvBqmX7/fC
	QrxEjcSFiAAo/oXPRSh2B/PBO3VacJ/0ZEJ38SC9ieg3cquTQvWIIrv+5eebsQIH+rJPsTnwPbp
	btMvNGu6LBem8JI5vcjFnMDd+8ne614Y4Pu/K6KLgcPwx/JZ6xibR5zO27SNz4hhoQhvlA1dQ4Z
	67O36XxEckUT8HpdQAGQlqoDU8M/j4c9Zq4k9MGPEMi37vMsO4rjyEhanySk8+rWZrcntFRxhSd
	VoOduqMN6dNekGa8hxen9ZVdw4iYWKRoOd2uzVOclTlzN2ww66JNIX4YKOkWRH2AHE+N2Soyq4i
	Ihal8ilJtxtlHsNPCobGYQh9X/wh1IElOFewfvvg==
X-Google-Smtp-Source: AGHT+IG5oma5XZltcByQMBBLA883nmzhZSBFYDt3tsNsfUu7urZS18FL9TsDQWOkfB9yP9MyKJ8odg==
X-Received: by 2002:a17:90b:2fd0:b0:330:82b1:ef76 with SMTP id 98e67ed59e1d1-349126d814bmr3998774a91.28.1764796766511;
        Wed, 03 Dec 2025 13:19:26 -0800 (PST)
Received: from deb-101020-bm01.eng.stellus.in ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-349129beec4sm1327648a91.2.2025.12.03.13.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 13:19:26 -0800 (PST)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Wed, 3 Dec 2025 21:19:24 +0000
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, dave@stgolabs.net,
	linux-cxl@vger.kernel.org, nifan.cxl@gmail.com,
	dongjoo.seo1@samsung.com
Subject: Re: [RFC PATCH 0/3] Add Support for Multiple DC Regions
Message-ID: <aTCpXMxnxtq4ZAPI@deb-101020-bm01.eng.stellus.in>
References: <20251203203540.1091827-1-anisa.su887@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251203203540.1091827-1-anisa.su887@gmail.com>

On Wed, Dec 03, 2025 at 08:29:10PM +0000, anisa.su887@gmail.com wrote:
> From: Anisa Su <anisa.su@samsung.com>
> 
> This patchset introduces support for multiple DC regions. It is rebased on top
> of the latest branch published to Ira's repository:
> https://github.com/weiny2/linux-kernel/tree/dcd-v6-2025-09-23.
> We hope it will be useful in the meantime for others and restart some
> discussion around how to move DCD forward.
> 
> The corresponding NDCTL support can be found on this branch:
> https://github.com/anisa-su993/anisa-ndctl/tree/multiple-dc-region-support.
> I will reply to this thread with a reference to the thread for the
> NDCTL patches once published.
> 

NDCTL thread: https://lore.kernel.org/linux-cxl/20251203211642.1104918-1-anisa.su887@gmail.com/T/#u

> Testing:
> This patchset was tested on a QEMU VM with the following topology:
> 
> PCIE Root (pcie.0)
> │
> ├─ CXL Fixed Memory Window cxl-fmw.0
> ├─ CXL Root Complex cxl.0
> │  └─ Root Port root_port1
> │     └─ CXL Type-3 Device cxl-dcd0
> │
> ├─ CXL Fixed Memory Window cxl-fmw.1
> ├─ CXL Root Complex cxl.1
> │  └─ Root Port root_port2
> │     └─ CXL Type-3 Device cxl-dcd1
> └─
> 
> "-object memory-backend-file,id=cxl-mem1,share=on,mem-path=/tmp/t3_cxl1.raw,size=8G \
> -object memory-backend-file,id=cxl-lsa1,share=on,mem-path=/tmp/t3_lsa1.raw,size=1M \
> -object memory-backend-file,id=cxl-mem2,share=on,mem-path=/tmp/t3_cxl2.raw,size=8G \
> -object memory-backend-file,id=cxl-lsa2,share=on,mem-path=/tmp/t3_lsa2.raw,size=1M \
> -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.0,hdm_for_passthrough=true \
> -device pxb-cxl,bus_nr=48,bus=pcie.0,id=cxl.1,hdm_for_passthrough=true \
> -device cxl-rp,port=0,bus=cxl.0,id=root_port1,chassis=0,slot=1 \
> -device cxl-rp,port=1,bus=cxl.1,id=root_port2,chassis=1,slot=1 \
> -device cxl-type3,bus=root_port1,volatile-dc-memdev=cxl-mem1,id=cxl-dcd0,lsa=cxl-lsa1,num-dc-regions=8,sn=99 \
> -device cxl-type3,bus=root_port2,volatile-dc-memdev=cxl-mem2,id=cxl-dcd1,lsa=cxl-lsa2,num-dc-regions=8,sn=100 \
> -machine cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=8G,cxl-fmw.1.targets.0=cxl.1,cxl-fmw.1.size=8G"
> 
> 2 CFMWs and 2 root complexes are emulated because QEMU creates
> 4 decoders/topology level. With 1 root complex, there are only 4 upstream
> decoders. Therefore in order to create 4+ regions, we need a total of
> 8 upstream decoders. This does mean that we are only able to create
> 4 regions on each device, although up to 8 are supported.
> 
> Using `cxl list`, we can see mem0 and mem1 have dynamic_ram_* capablities:
> root@deb-101020-bm01:~# cxl list
> [
>   {
>     "memdevs":[
>       {
>         "memdev":"mem0",
>         "dynamic_ram_0_size":1073741824,
>         "dynamic_ram_1_size":1073741824,
>         "dynamic_ram_2_size":1073741824,
>         "dynamic_ram_3_size":1073741824,
>         "dynamic_ram_4_size":1073741824,
>         "dynamic_ram_5_size":1073741824,
>         "dynamic_ram_6_size":1073741824,
>         "dynamic_ram_7_size":1073741824,
>         "serial":100,
>         "host":"0000:31:00.0",
>         "firmware_version":"BWFW VERSION 00"
>       },
>       {
>         "memdev":"mem1",
>         "dynamic_ram_0_size":1073741824,
>         "dynamic_ram_1_size":1073741824,
>         "dynamic_ram_2_size":1073741824,
>         "dynamic_ram_3_size":1073741824,
>         "dynamic_ram_4_size":1073741824,
>         "dynamic_ram_5_size":1073741824,
>         "dynamic_ram_6_size":1073741824,
>         "dynamic_ram_7_size":1073741824,
>         "serial":99,
>         "host":"0000:0d:00.0",
>         "firmware_version":"BWFW VERSION 00"
>       }
>     ]
>   }
> ]
> 
> To create the 8 regions:
> cxl create-region -m -d decoder0.0 -w 1 -s 1G mem1 -t dynamic_ram_0
> cxl create-region -m -d decoder0.0 -w 1 -s 1G mem1 -t dynamic_ram_1
> cxl create-region -m -d decoder0.0 -w 1 -s 1G mem1 -t dynamic_ram_2
> cxl create-region -m -d decoder0.0 -w 1 -s 1G mem1 -t dynamic_ram_3
> 
> cxl create-region -m -d decoder0.1 -w 1 -s 1G mem0 -t dynamic_ram_4
> cxl create-region -m -d decoder0.1 -w 1 -s 1G mem0 -t dynamic_ram_5
> cxl create-region -m -d decoder0.1 -w 1 -s 1G mem0 -t dynamic_ram_6
> cxl create-region -m -d decoder0.1 -w 1 -s 1G mem0 -t dynamic_ram_7
> 
> 
> We can verify the 8 regions:
> root@deb-101020-bm01:~# cxl list
> [
>   {
>     "memdevs":[
> ...
>   },
>   {
>     "regions":[
>       {
>         "region":"region0",
>         "resource":79993765888,
>         "size":1073741824,
>         "interleave_ways":1,
>         "interleave_granularity":256,
>         "decode_state":"commit"
>       },
>       {
>         "region":"region6",
>         "resource":81067507712,
>         "size":1073741824,
>         "interleave_ways":1,
>         "interleave_granularity":256,
>         "decode_state":"commit"
>       },
>       {
>         "region":"region7",
>         "resource":82141249536,
>         "size":1073741824,
>         "interleave_ways":1,
>         "interleave_granularity":256,
>         "decode_state":"commit"
>       },
>       {
>         "region":"region8",
>         "resource":83214991360,
>         "size":1073741824,
>         "interleave_ways":1,
>         "interleave_granularity":256,
>         "decode_state":"commit"
>       },
>       {
>         "region":"region1",
>         "resource":88315265024,
>         "size":1073741824,
>         "interleave_ways":1,
>         "interleave_granularity":256,
>         "decode_state":"commit"
>       },
>       {
>         "region":"region2",
>         "resource":89389006848,
>         "size":1073741824,
>         "interleave_ways":1,
>         "interleave_granularity":256,
>         "decode_state":"commit"
>       },
>       {
>         "region":"region3",
>         "resource":90462748672,
>         "size":1073741824,
>         "interleave_ways":1,
>         "interleave_granularity":256,
>         "decode_state":"commit"
>       },
>       {
>         "region":"region4",
>         "resource":91536490496,
>         "size":1073741824,
>         "interleave_ways":1,
>         "interleave_granularity":256,
>         "decode_state":"commit"
>       }
>     ]
>   }
> ]
> 
> Extents of various sizes (128MB, 256MB, 512MB, and 1GB) are added from mem1,
> which correspond to regions 0-3, then DAX devices are created from them.
> The extent DPAs are as follows, which allows each one to map to a distinct
> region:
>  - [0-128] --> region0
>  - [1024-1280] --> region1
>  - [2048-2560] --> region2
>  - [3072-4096] --> region3
> 
> The correct sizes can be verified when creating the DAX device.
> root@deb-101020-bm01:~/libcxlmi# daxctl create-device -r region0
> [
>   {
>     "chardev":"dax0.1",
>     "size":134217728,
>     "target_node":1,
>     "align":2097152,
>     "mode":"devdax"
>   }
> ]
> created 1 device
> root@deb-101020-bm01:~/libcxlmi# daxctl create-device -r region1
> [
>   {
>     "chardev":"dax1.1",
>     "size":268435456,
>     "target_node":1,
>     "align":2097152,
>     "mode":"devdax"
>   }
> ]
> created 1 device
> root@deb-101020-bm01:~/libcxlmi# daxctl create-device -r region2
> [
>   {
>     "chardev":"dax2.1",
>     "size":536870912,
>     "target_node":1,
>     "align":2097152,
>     "mode":"devdax"
>   }
> ]
> created 1 device
> root@deb-101020-bm01:~/libcxlmi# daxctl create-device -r region3
> [
>   {
>     "chardev":"dax3.1",
>     "size":1073741824,
>     "target_node":1,
>     "align":2097152,
>     "mode":"devdax"
>   }
> ]
> created 1 device
> 
> Then the DAX devices are reconfigured to system-ram mode and verified with lsmem.
> root@deb-101020-bm01:~/libcxlmi# daxctl reconfigure-device dax0.1 -m system-ram
> [
>   {
>     "chardev":"dax0.1",
>     "size":134217728,
>     "target_node":1,
>     "align":2097152,
>     "mode":"system-ram",
>     "online_memblocks":1,
>     "total_memblocks":1,
>     "movable":true
>   }
> ]
> reconfigured 1 device
> root@deb-101020-bm01:~/libcxlmi# daxctl reconfigure-device dax1.1 -m system-ram
> ...
> root@deb-101020-bm01:~/libcxlmi# daxctl reconfigure-device dax2.1 -m system-ram
> ...
> root@deb-101020-bm01:~/libcxlmi# daxctl reconfigure-device dax3.1 -m system-ram
> ...
> 
> 
> root@deb-101020-bm01:~/libcxlmi# lsmem
> RANGE                                  SIZE  STATE REMOVABLE   BLOCK
> 0x0000000000000000-0x000000007fffffff    2G online       yes    0-15
> 0x0000000100000000-0x000000027fffffff    6G online       yes   32-79
> 0x00000012a0000000-0x00000012a7ffffff  128M online       yes     596
> 0x00000012e0000000-0x00000012efffffff  256M online       yes 604-605
> 0x0000001320000000-0x000000133fffffff  512M online       yes 612-615
> 0x0000001360000000-0x000000139fffffff    1G online       yes 620-627
> 
> Memory block size:                128M
> Total online memory:              9.9G
> Total offline memory:               0B
> 
> -------------------------------------------------------------------------------
> Note: I did try hacking QEMU to create 8 decoders at each level to avoid having
> 2 separate host bridges/DCDs by modifying include/hw/cxl/cxl_component.h like so:
> 
> #define CXL_HDM_DECODER_COUNT 8
> HDM_DECODER_INIT(0);
> HDM_DECODER_INIT(1);
> HDM_DECODER_INIT(2);
> HDM_DECODER_INIT(3);
> HDM_DECODER_INIT(4);
> HDM_DECODER_INIT(5);
> HDM_DECODER_INIT(6);
> HDM_DECODER_INIT(7);
> 
> However, when attempting to create the 5th cxl region,
> I ran into a timeout error when committing the decoders.
> Did not spend much time pursuing this further, most likely
> need to change more things on the QEMU side.
> But the 8 decoders do show up correctly under sysfs.
> 
> Fan Ni (3):
>   core/region: fix return logic for store_targetN
>   dax/cxl: add existing dc extents when probing dax region
>   dcd: Add support for multiple DC regions
> 
>  drivers/cxl/core/cdat.c   |   2 +-
>  drivers/cxl/core/core.h   |   9 +-
>  drivers/cxl/core/extent.c |   2 +-
>  drivers/cxl/core/hdm.c    |  18 +++-
>  drivers/cxl/core/mbox.c   |  39 +++++----
>  drivers/cxl/core/memdev.c | 179 +++++++++++++++++++++++++-------------
>  drivers/cxl/core/port.c   |  45 ++++++++--
>  drivers/cxl/core/region.c |  65 ++++++++------
>  drivers/cxl/cxl.h         |  23 ++++-
>  drivers/cxl/cxlmem.h      |   5 +-
>  drivers/dax/cxl.c         |  28 ++----
>  11 files changed, 281 insertions(+), 134 deletions(-)
> 
> -- 
> 2.51.0
> 
