Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56251DC04A
	for <linux-cxl@vger.kernel.org>; Fri, 24 Jan 2025 20:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737752156; cv=none; b=jAboL+YtdUfisZie3PqizFem0sJLeoswDJUIl+KRrk2XcpbzNKy/0/q4GGwJbsJ2p6zPgq+cRz/n0OCc8ihjyZwQtSoWJVKZjMH9gtKFcD0IcwpBQ35QLOGB1TSWRWjpYr7O/pGEfS83ueOgYBd5ojMXV+CwtcPuyQ/ttXtFBVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737752156; c=relaxed/simple;
	bh=iDOdGmXDukOqTvPYhkvkvYAEtlxwNrEtpbIdj40qLSs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sY42GI5sSt6mFTjE1Q4yxpR68v7JS0dI4aNmZh7DdU0AMX0c7k9GGYUpYA8CzgO5i+tZj+TKgwODTxZBUCk+DTuXeN9WFPO+lQajrn5HEGvMEyiK7FLGs4r7v+xnkdbYFF4tarNgSVghlk7HGiwGLawzgMRFdEM/93gbSar/Iq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pEnOfKVs; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pEnOfKVs"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ef760a1001so4493685a91.0
        for <linux-cxl@vger.kernel.org>; Fri, 24 Jan 2025 12:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737752154; x=1738356954; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U6FnozzX9nVS9BAq/1xG0i26esx4cIKO1Neb9g49Yt8=;
        b=pEnOfKVsH7ou7UjSdq3HtOsjH6SlC3wZhosMvKMcXLAA7R+D2j6mOkYHPLV2LFuPW5
         1IcGAHr1gR5uqGUWRe8xhebXGpxlDJiHfBPnzKyGR339fYC2ULVOEl4QvQM4gO4gcFJv
         tBj/IvSOpBzNcqajbFszMufExHBpzBXusbSAMjYTmq4zO5VGqyGfWVQLKSp/p8gBO+pN
         KiKKOxd0DsAAgeM9bb4rGYH7t975jODN9MyVzJ3T4jAguUKrSDsZftXKBBSYOcopmKX/
         MVOJbkB/udIz4gQ8pmMBXDEucX+Na1LGY9l0vrYHzMTLlA4KWAuEvZPSscgLHNe5KW+p
         /ZNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737752154; x=1738356954;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U6FnozzX9nVS9BAq/1xG0i26esx4cIKO1Neb9g49Yt8=;
        b=j4liKWY+mTiQNqDOGW6VOwlfiyyLhD23rY6LQ0mZFjPah/UhUPbe34/S71I8nmit5P
         yZgZ9Mi/QOjnrP5BQr9SjfjTN/G3qrIJSgrnt2sHgexHBh/SXsbhRhWBSKQgZTqg4eFZ
         On0yeb1pdVFlzQAQbrL4xsjUcuGmykcPIFE64XfFmhdJt56W169wBEdZaXo57ZyEW3vw
         w9edmVbonpB07er54trJz98RY6W52/WtcL7qSJpLcnZMLjGBOyJ+V2CCbxGmi/CkmWaR
         uD36z9TZRjzSaI1hhbWLkBZdyZLkMvBDS9kzW7Oi8oPyXJaQQd/YLRjJ3u4DeHx93XP+
         PuNQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+Y44XvW0Ahmncv7koWr0t1afjHPrYrp7YT4KU6a1rCuNcfKxSR73OcRhVccNbzF1/rQ5EmWyQ3Vs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYVvK21AepFMwISOvsyBmjXk8U+OTwzclFRD4wg83DRzCBsBd3
	xZMN2mZJbH717mFutFcZRZqaR8iWdmMP8OAFx+DQLIrOsWfxaS7Nwk5PiEmCnP8=
X-Gm-Gg: ASbGncudP9nZo48ziSlhlx+mQEIa4PJnvZypOH1OzVEWlY6xeOxZP8qYhnUpPpbg6Yg
	7zNd5hJ4Md/VIQrDQW2gAztT6EjUzTKc8ictR1HGOULDxhFuU70iSlcXwb9Pb1M8c4DKA8XJ0WP
	M5xVz/2CDp5I1w1FrXRlCvFel4OB8thE6p7BIsWBNGLozm5WDsHxRh5+u7JylXE6jtF2/Igdyur
	mUf1a/Q14OT4tVFw2mM3zmB491Oe84gNU7zdNaby5kxb7ld5qN9nzvqD9f9z61+Lwp+m+IbLcLB
	JoMr5/9/gJMYK1d/KA==
X-Google-Smtp-Source: AGHT+IFxJqFL0oZzZR/fk6wOsEKv/sE3I31janPZen4o17fN8ocXzP4nLD+iZxSWmLnEWNeD9+qKxQ==
X-Received: by 2002:a17:90b:5485:b0:2ee:ee77:2263 with SMTP id 98e67ed59e1d1-2f782c4bd9amr50052136a91.7.1737752153847;
        Fri, 24 Jan 2025 12:55:53 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffa773dfsm2219205a91.40.2025.01.24.12.55.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2025 12:55:53 -0800 (PST)
Message-ID: <5e0876e8-4c2c-4ba5-86dc-d9ca241b743d@linaro.org>
Date: Fri, 24 Jan 2025 12:55:52 -0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH QEMU 0/3] cxl/plugins: Hotness Monitoring Unit with
 'real' data.
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, fan.ni@samsung.com,
 linux-cxl@vger.kernel.org, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, linuxarm@huawei.com,
 Niyas Sait <niyas.sait@huawei.com>
References: <20250124172905.84099-1-Jonathan.Cameron@huawei.com>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250124172905.84099-1-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jonathan,

thanks for posting this. It's a creative usage of plugins.

I think that your current approach, decoupling plugins, CHMU and device 
model is a good thing.

I'm not familiar with CXL, but one question that comes to my mind is:
Is that mandatory to do this analysis during execution (vs dumping 
binary traces from CHMU and plugin and running an analysis post execution)?

Regards,
Pierrick

On 1/24/25 09:29, Jonathan Cameron wrote:
> Hi All,
> 
> This is an RFC mainly to seek feedback on the approach used, particularly
> the aspect of how to get data from a TCG plugin into a device model.
> Two options that we have tried
> 1. Socket over which the plugin sends data to an external server
>     (as seen here)
> 2. Register and manage a plugin from within a device model
> 
> The external server approach keeps things loosely coupled, but at the cost
> of separately maintaining that server, protocol definitions etc and
> some overhead.
> The closely couple solution is neater, but I suspect might be controversial
> (hence I didn't start with that :)
> 
> The code here is at best a PoC to illustrate what we have in mind
> It's not nice code at all, feature gaps, bugs and all!  So whilst
> review is always welcome I'm not requesting it for now.
> 
> Kernel support was posted a while back but was done against fake data
> (still supported here if you don't provide the port parameter to the type3 device)
> https://lore.kernel.org/linux-cxl/20241121101845.1815660-1-Jonathan.Cameron@huawei.com/
> I'll post a minor update of that driver shortly to take into account
> a few specification clarifications but it should work with this without
> those.
> 
> Note there are some other patches on the tree I generated this from
> so this may not apply to upstream. Easiest is probably to test
> using gitlab.com/jic23/qemu cxl-2025-01-24
> 
> Thanks to Niyas for his suggestions on how to make all this work!
> 
> Background
> ----------
> 
> What is the Compute eXpress Link Hotness Monitoring unit and what is it for?
> - In a tiered memory equipped server with the slow tier being attached via
>    CXL the expectation is a given workload will benefit from putting data
>    that is frequently fetched from memory in lower latency directly attached
>    DRAM.  Less frequently used data can be served from the CXL attached memory
>    with no significant loss of performance.  Any data that is hot enough to
>    almost always be in cache doesn't matter as it is only fetch from memory
>    occasionally.
> - Working out which memory is best places where is hard to do and in some
>    workloads a dynamic problem. As such we need something we can measure
>    to provide some indication of what data is in the wrong place.
>    There are existing techniques to do this (page faulting, various
>    CPU tracing systems, access bit scanning etc) but they all have significant
>    overheads.
> - Monitoring accesses on the CXL device provides a path to getting good
>    data without those overheads.  These units are known as CXL Hotness
>    Monitoring Units or CHMUs.  Loosely speaking they count accesses to
>    granuals of data (e.g. 4KiB pages).  Exactly how they do that and
>    where they sacrifice data accuracy is an implementation trade off.
> 
> Why do we need a model that gives real data?
> - In general there is a need to develop software on top of these units
>    to move data to the right place. Hard to evaluate that if we are making
>    up the info on what is 'hot'.
> - Need to allow for a bunch of 'impdef' solutions. Note that CHMU
>    in this patch set is an oracle - it has enough counters to count
>    every access.  That's not realistic but it doesn't get me shouted
>    at by our architecture teams for giving away any secrets.
>    If we move forward with this, I'll probably implement a limited
>    counter + full CAM solution (also unrealistic, but closer to real)
>    I'd be very interested in contributions of other approaches (there
>    are lots in the literature, under the term top-k)
> - Resources will be constrained, so whilst a CHMU might in theory
>    allow monitoring everything at once, that will come with a big
>    accuracy cost.  We need to design the algorithms that give us
>    good data given those constraints.
> 
> So we need a solution to explore the design space and develop the software
> to take advantage of this hardware (there are various LSF/MM proposals
> on how to use this an other ways of tracking hotness).
> https://lore.kernel.org/all/20250123105721.424117-1-raghavendra.kt@amd.com/
> https://lore.kernel.org/lkml/Z4XUoWlU-UgRik18@gourry-fedora-PF4VCD3F/T/
> 
> QEMU plugins give us a way to do this.  In particular the existing
> Cache plugin can be easily modified to tell use what memory addresses
> missed at the last level of emulated cache.  We can then filter those
> for the memory address range that maps to CXL and feed them to our
> counter implementation. On the other side, each instance of CXL type 3
> device can connect to this server and request hotness monitoring
> services + provide parameters etc.  Elements such as list threshold
> management and overflow detection etc are in the CXL HMU QEMU device mode.
> As noted above, we have an alternative approach that can closely couple
> things, so the device model registers the plugin directly and there
> is no server.
> 
> How to use it!
> --------------
> 
> It runs a little slow but it runs and generates somewhat plausible outputs.
> I'd definitely suggest running it with the pass through optimization
> patch on the CXL staging tree (and a single direct connected device).
> Your millage will vary if you try to use other parameters, or
> hotness units beyond the first one (implementation far from complete!)
> 
> To run start the server in contrib/hmu/ providing a port number to listen
> on.
> 
> ./chmu 4443
> 
> Then launch QEMU with something like the following.
> 
> qemu-system-aarch64 -icount shift=1 \
>   -plugin ../qemu/bin/native/contrib/plugins/libcache.so,port=4443,missfilterbase=1099511627776,missfiltersize=1099511627776,dcachesize=8192,dassoc=4,dblksize=64,icachesize=8192,iassoc=4,iblksize=64,l2cachesize=32768,l2assoc=16,l2blksize=64 \
>   -M virt,ras=on,nvdimm=on,gic-version=3,cxl=on,hmat=on -m 4g,maxmem=8g,slots=4 -cpu max -smp 4 \
>   -kernel Image \
>   -drive if=none,file=full.qcow2,format=qcow2,id=hd \
>   -device pcie-root-port,id=root_port1 \
>   -device virtio-blk-pci,drive=hd,x-max-bounce-buffer-size=512k \
>   -nographic -no-reboot -append 'earlycon memblock=debug root=/dev/vda2 fsck.mode=skip maxcpus=4 tp_printk' \
>   -monitor telnet:127.0.0.1:1234,server,nowait -bios QEMU_EFI.fd \
>   -object memory-backend-ram,size=4G,id=mem0 \
>   -object memory-backend-file,id=cxl-mem1,share=on,mem-path=/tmp/t3_cxl1.raw,size=1G,align=256M \
>   -object memory-backend-file,id=cxl-mem2,share=on,mem-path=/tmp/t3_cxl2.raw,size=1G,align=256M \
>   -object memory-backend-file,id=cxl-lsa1,share=on,mem-path=/tmp/t3_lsa1.raw,size=1M,align=1M \
>    -object memory-backend-file,id=cxl-mem3,share=on,mem-path=/tmp/t3_cxl3.raw,size=1G,align=256M \
>   -object memory-backend-file,id=cxl-mem4,share=on,mem-path=/tmp/t3_cxl4.raw,size=1G,align=256M \
>   -object memory-backend-file,id=cxl-lsa2,share=on,mem-path=/tmp/t3_lsa2.raw,size=1M,align=1M \
>   -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1,hdm_for_passthrough=true,numa_node=0\
>   -device cxl-rp,port=0,bus=cxl.1,id=cxl_rp_port0,chassis=0,slot=2 \
>   -device cxl-type3,bus=cxl_rp_port0,volatile-memdev=cxl-mem1,id=cxl-pmem1,lsa=cxl-lsa1,sn=3,x-speed=32,x-width=16,chmu-port=4443 \
>   -machine cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=8G,cxl-fmw.0.interleave-granularity=1k \
>   -numa node,nodeid=0,cpus=0-3,memdev=mem0 \
>   -numa node,nodeid=1 \
>   -object acpi-generic-initiator,id=bob2,pci-dev=bob,node=1 \
>   -numa node,nodeid=2 \
>   -object acpi-generic-port,id=bob11,pci-bus=cxl.1,node=2 \
> 
> In the guest, create and bind the region - this brings up the CXL memory
> device so accesses go to the memory.
> 
>    cd /sys/bus/cxl/devices/decoder0.0/
>    cat create_ram_region
>    echo region0 > create_ram_region
>    echo ram > /sys/bus/cxl/devices/decoder2.0/mode
>    echo ram > /sys/bus/cxl/devices/decoder3.0/mode
>    echo $((256 << 21)) > /sys/bus/cxl/devices/decoder2.0/dpa_size
>    cd /sys/bus/cxl/devices/region0/
>    echo 256 > interleave_granularity
>    echo 1 > interleave_ways
>    echo $((256 << 21)) > size
>    echo decoder2.0 > target0
>    echo 1 > commit
>    echo region0 > /sys/bus/cxl/drivers/cxl_region/bind
> 
> Finally start perf with something like:
> 
> ./perf record -a  -e cxl_hmu_mem0.0.0/epoch_type=0,access_type=6,\
> hotness_threshold=635,epoch_multiplier=4,epoch_scale=4,\
> range_base=0,range_size=4096/  ./stress.sh
> 
> where stress.sh is
> 
>    sleep 2
>    numactl --membind 3 stress-ng --vm 1 --vm-bytes 1M --vm-keep -t 5s
>    sleep 2
> 
> See the results with
> ./perf report --dump-raw-trace | grep -A 200 HMU
> 
> Enjoy and have a good weekend.
> 
> Thanks,
> 
> Jonathan
> 
> Jonathan Cameron (3):
>    hw/cxl: Initial CXL Hotness Monitoring Unit Emulation
>    plugins: Add cache miss reporting over a socket.
>    contrib: Add example hotness monitoring unit server
> 
>   include/hw/cxl/cxl.h        |   1 +
>   include/hw/cxl/cxl_chmu.h   | 154 ++++++++++++
>   include/hw/cxl/cxl_device.h |  13 +-
>   include/hw/cxl/cxl_pci.h    |   7 +-
>   contrib/hmu/hmu.c           | 312 ++++++++++++++++++++++++
>   contrib/plugins/cache.c     |  75 +++++-
>   hw/cxl/cxl-chmu.c           | 459 ++++++++++++++++++++++++++++++++++++
>   hw/mem/cxl_type3.c          |  25 +-
>   hw/cxl/meson.build          |   1 +
>   9 files changed, 1035 insertions(+), 12 deletions(-)
>   create mode 100644 include/hw/cxl/cxl_chmu.h
>   create mode 100644 contrib/hmu/hmu.c
>   create mode 100644 hw/cxl/cxl-chmu.c
> 

