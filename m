Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0321B29CE7
	for <linux-cxl@vger.kernel.org>; Tue, 28 Jan 2025 20:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738094664; cv=none; b=Hz9VeP/KKt3ZiZhZfM5TnGDCOjlswHebuAwn8mDcqxtZwgCVyq4HiSxHmvOdFcIqkGlVqfP8DiIg3pc6FwmjEMcln2qsQLdj2KKC9fQEfzpp0jfmu90dlaJ6zRtJ+o0sc/jxrrW6d11wj2Xkh/ZXdBhZsiD6w12gWcc1Hr5JlQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738094664; c=relaxed/simple;
	bh=F/hBs6H7oa1TvavYfa/MDi/uOb7QY9dZtdcDr+AoaVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XVVa/vHMXZtSZao4sUeNzl36PCXv80PC2sKIwnQRKyPxqOfOJdY4i70mRq9xcANDtKbI2zXI2sKIqRtC4h2sdwOItMPjfAKZblwaegT+5aO7Bg/koxLnLxGFsC60UCOE/sRLsnCOdvXUkkXw8oEYUkPR62bNl62sxJ3/Rk1FTb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q91wR/EP; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q91wR/EP"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2166022c5caso97281935ad.2
        for <linux-cxl@vger.kernel.org>; Tue, 28 Jan 2025 12:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738094661; x=1738699461; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xNul+umHiT/hHp10TJsC/Ux0aCzOPAOTrE5Gf9WyokU=;
        b=Q91wR/EPRhRHlv6OXKhO5yyRUZXz0gSaRLtyUhwAirBJtCXBRe3KjuMXWs/clELrUQ
         2sCmADoigVhggL7noMXjDtiXwT498Rv2/3ep2ZCOEFLNYXLiyP436pWZ6iQJggNTHVQa
         sYEyKiNkdhhmLBXiWE+Xmq89DJfsDMsT+42sJ1PP60eyyTgsg4Hc9OpinAPGx6qVHZy0
         BEl635BZ6iQViGZrL6jvoRtzKx+/dJBrmtJLVfrkt5pDk4gu8mHW+cqC0MgnUpGM6eIe
         Ni7IA+Knny0UOc4Zik5eAii9rwUHVufZ7UXrEKVgLQpg71xOBJB18IILD63r26hy9r+U
         cmdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738094661; x=1738699461;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xNul+umHiT/hHp10TJsC/Ux0aCzOPAOTrE5Gf9WyokU=;
        b=RExoEwpz9mrtRWZCKdmdMGbTxXSDJ03vpgRn6fezVjYurtQnqAhgMuy3lUqy2oya84
         3O/BS1Y8iVRm9rMcgSyGG7nrv008g7v42xdEUJkiAB2ntQrmF7nDyoWlHKiRaWjN1E+7
         SyAcNInlN9iRMGS65Hfw75HJTx9cb/X+mjvUW/58dJ4VFiz9EglWrHi4if5T4/tIVvAO
         8bXX1EGas9GIJAr1a0WzojgWaZ7o56hcVkNLb8yMW4UAzxNt3wb6Y5tt9j77ViDiokMO
         MS7uY+3EIBZc3YW7hvPTL/wDdfFeOK/1z8mtH6ZkVmKJ8og4TduskCvnwDviv7VAZl6y
         eTcg==
X-Forwarded-Encrypted: i=1; AJvYcCXiskfy/NOhrZJPJ2Shsxp8Z1tXrUVIxVQwdiLTpqOvA8t38dbqPTw1DOjNi8RI/8SQRGbogZO5sIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHgIN6x52k6gt+T5vCFUuDc8N60J/wDNxyEMTFoghz+tx1U7vh
	RifxVLr4RpvnkEMr9Pq56FMNlSt+7ssDYN58Z9Uwwfdgla/0yXi8F9uEaKiGr2eAGWo2jmqA+hT
	C6h4=
X-Gm-Gg: ASbGnctftgx0JtEmyyB5QXFISxVo1Dw0AUnRgp+phoezYsbJ3Gjif8ao/q3GYtVQW3x
	ZZEQS8yUkhCikNP0N87GAJJGpfke3eE3pLxwp7mFlealXIKtjVCwDMqS1KdHrre0erQJYNE2d/q
	Xn54S34g2elp2td5bzCAxIH4J1zK2z5evTMRI1AQeQQYD2qENrLaZNqATIfAqCzCBqLLRCSGQsV
	mXSx+ZWj44LnfrxNREPGdqZt/fyVso+efgpcngmW4SRyhKd5fXNqlP3XKNU/AVCTIB8AgbGoKlS
	mE9o2evFOiaCBcJHY3Gk4DJgDiVz
X-Google-Smtp-Source: AGHT+IHwtT6Sy3YAzqjTmqJkEtGNKK7GaXAPp8oVfRInoPqbWFoAnOa73zbLRekRV1vNYeCiQgsS5Q==
X-Received: by 2002:a05:6a21:8dc8:b0:1ea:ddd1:2fa7 with SMTP id adf61e73a8af0-1ed7a6b8105mr922882637.28.1738094661101;
        Tue, 28 Jan 2025 12:04:21 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f8a7614f4sm9903541b3a.97.2025.01.28.12.04.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2025 12:04:20 -0800 (PST)
Message-ID: <c595c1c1-63cc-462a-982e-66ac61a2eb9a@linaro.org>
Date: Tue, 28 Jan 2025 12:04:19 -0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH QEMU 0/3] cxl/plugins: Hotness Monitoring Unit with
 'real' data.
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: fan.ni@samsung.com, linux-cxl@vger.kernel.org, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, linuxarm@huawei.com,
 Niyas Sait <niyas.sait@huawei.com>
References: <20250124172905.84099-1-Jonathan.Cameron@huawei.com>
 <5e0876e8-4c2c-4ba5-86dc-d9ca241b743d@linaro.org>
 <20250127102009.00002dbd@huawei.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250127102009.00002dbd@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/27/25 02:20, Jonathan Cameron wrote:
> On Fri, 24 Jan 2025 12:55:52 -0800
> Pierrick Bouvier <pierrick.bouvier@linaro.org> wrote:
> 
>> Hi Jonathan,
>>
>> thanks for posting this. It's a creative usage of plugins.
>>
>> I think that your current approach, decoupling plugins, CHMU and device
>> model is a good thing.
>>
>> I'm not familiar with CXL, but one question that comes to my mind is:
>> Is that mandatory to do this analysis during execution (vs dumping
>> binary traces from CHMU and plugin and running an analysis post execution)?
> 
> Short answer is that post run analysis isn't of much use for developing the OS
> software story. It works to some degree if you are designing the tracking
> hardware or algorithms to use that hardware capture a snapshot of hotness -
> dealing with lack of counters, that sort of thing.
> 
> The main intent of this support is to drive live usage of the data in the OS.
> So it gets this hotness information and migrates more frequently accessed memory
> to a 'nearer'/lower latency memory node.
> 
>  From an OS point of view there will be two ways it uses it:
> 1) Offline application optimization  - that aligns with your suggestion of offline
>     analysis but would typically still need to be live because we have to do
>     the reverse maps and work out what was allocated in particular locations.
>     Not impossible to dump that information from QEMU + the guest OS but the usage
>     flow would then look quite different from what makes sense on real hardware
>     where all the data is available to the host OS directly.
> 2) Migration of memory.  This will dynamically change the PA backing a VA whilst
>     applications are running. The aim being to develop how that happens, we need
>     the dynamic state.
> 

In the end, are you modeling how the real CHMU will work, or simply 
gathering data to help designing it (number of counters, line size, ...)?

Pierrick

> Jonathan
> 
>>
>> Regards,
>> Pierrick
>>
>> On 1/24/25 09:29, Jonathan Cameron wrote:
>>> Hi All,
>>>
>>> This is an RFC mainly to seek feedback on the approach used, particularly
>>> the aspect of how to get data from a TCG plugin into a device model.
>>> Two options that we have tried
>>> 1. Socket over which the plugin sends data to an external server
>>>      (as seen here)
>>> 2. Register and manage a plugin from within a device model
>>>
>>> The external server approach keeps things loosely coupled, but at the cost
>>> of separately maintaining that server, protocol definitions etc and
>>> some overhead.
>>> The closely couple solution is neater, but I suspect might be controversial
>>> (hence I didn't start with that :)
>>>
>>> The code here is at best a PoC to illustrate what we have in mind
>>> It's not nice code at all, feature gaps, bugs and all!  So whilst
>>> review is always welcome I'm not requesting it for now.
>>>
>>> Kernel support was posted a while back but was done against fake data
>>> (still supported here if you don't provide the port parameter to the type3 device)
>>> https://lore.kernel.org/linux-cxl/20241121101845.1815660-1-Jonathan.Cameron@huawei.com/
>>> I'll post a minor update of that driver shortly to take into account
>>> a few specification clarifications but it should work with this without
>>> those.
>>>
>>> Note there are some other patches on the tree I generated this from
>>> so this may not apply to upstream. Easiest is probably to test
>>> using gitlab.com/jic23/qemu cxl-2025-01-24
>>>
>>> Thanks to Niyas for his suggestions on how to make all this work!
>>>
>>> Background
>>> ----------
>>>
>>> What is the Compute eXpress Link Hotness Monitoring unit and what is it for?
>>> - In a tiered memory equipped server with the slow tier being attached via
>>>     CXL the expectation is a given workload will benefit from putting data
>>>     that is frequently fetched from memory in lower latency directly attached
>>>     DRAM.  Less frequently used data can be served from the CXL attached memory
>>>     with no significant loss of performance.  Any data that is hot enough to
>>>     almost always be in cache doesn't matter as it is only fetch from memory
>>>     occasionally.
>>> - Working out which memory is best places where is hard to do and in some
>>>     workloads a dynamic problem. As such we need something we can measure
>>>     to provide some indication of what data is in the wrong place.
>>>     There are existing techniques to do this (page faulting, various
>>>     CPU tracing systems, access bit scanning etc) but they all have significant
>>>     overheads.
>>> - Monitoring accesses on the CXL device provides a path to getting good
>>>     data without those overheads.  These units are known as CXL Hotness
>>>     Monitoring Units or CHMUs.  Loosely speaking they count accesses to
>>>     granuals of data (e.g. 4KiB pages).  Exactly how they do that and
>>>     where they sacrifice data accuracy is an implementation trade off.
>>>
>>> Why do we need a model that gives real data?
>>> - In general there is a need to develop software on top of these units
>>>     to move data to the right place. Hard to evaluate that if we are making
>>>     up the info on what is 'hot'.
>>> - Need to allow for a bunch of 'impdef' solutions. Note that CHMU
>>>     in this patch set is an oracle - it has enough counters to count
>>>     every access.  That's not realistic but it doesn't get me shouted
>>>     at by our architecture teams for giving away any secrets.
>>>     If we move forward with this, I'll probably implement a limited
>>>     counter + full CAM solution (also unrealistic, but closer to real)
>>>     I'd be very interested in contributions of other approaches (there
>>>     are lots in the literature, under the term top-k)
>>> - Resources will be constrained, so whilst a CHMU might in theory
>>>     allow monitoring everything at once, that will come with a big
>>>     accuracy cost.  We need to design the algorithms that give us
>>>     good data given those constraints.
>>>
>>> So we need a solution to explore the design space and develop the software
>>> to take advantage of this hardware (there are various LSF/MM proposals
>>> on how to use this an other ways of tracking hotness).
>>> https://lore.kernel.org/all/20250123105721.424117-1-raghavendra.kt@amd.com/
>>> https://lore.kernel.org/lkml/Z4XUoWlU-UgRik18@gourry-fedora-PF4VCD3F/T/
>>>
>>> QEMU plugins give us a way to do this.  In particular the existing
>>> Cache plugin can be easily modified to tell use what memory addresses
>>> missed at the last level of emulated cache.  We can then filter those
>>> for the memory address range that maps to CXL and feed them to our
>>> counter implementation. On the other side, each instance of CXL type 3
>>> device can connect to this server and request hotness monitoring
>>> services + provide parameters etc.  Elements such as list threshold
>>> management and overflow detection etc are in the CXL HMU QEMU device mode.
>>> As noted above, we have an alternative approach that can closely couple
>>> things, so the device model registers the plugin directly and there
>>> is no server.
>>>
>>> How to use it!
>>> --------------
>>>
>>> It runs a little slow but it runs and generates somewhat plausible outputs.
>>> I'd definitely suggest running it with the pass through optimization
>>> patch on the CXL staging tree (and a single direct connected device).
>>> Your millage will vary if you try to use other parameters, or
>>> hotness units beyond the first one (implementation far from complete!)
>>>
>>> To run start the server in contrib/hmu/ providing a port number to listen
>>> on.
>>>
>>> ./chmu 4443
>>>
>>> Then launch QEMU with something like the following.
>>>
>>> qemu-system-aarch64 -icount shift=1 \
>>>    -plugin ../qemu/bin/native/contrib/plugins/libcache.so,port=4443,missfilterbase=1099511627776,missfiltersize=1099511627776,dcachesize=8192,dassoc=4,dblksize=64,icachesize=8192,iassoc=4,iblksize=64,l2cachesize=32768,l2assoc=16,l2blksize=64 \
>>>    -M virt,ras=on,nvdimm=on,gic-version=3,cxl=on,hmat=on -m 4g,maxmem=8g,slots=4 -cpu max -smp 4 \
>>>    -kernel Image \
>>>    -drive if=none,file=full.qcow2,format=qcow2,id=hd \
>>>    -device pcie-root-port,id=root_port1 \
>>>    -device virtio-blk-pci,drive=hd,x-max-bounce-buffer-size=512k \
>>>    -nographic -no-reboot -append 'earlycon memblock=debug root=/dev/vda2 fsck.mode=skip maxcpus=4 tp_printk' \
>>>    -monitor telnet:127.0.0.1:1234,server,nowait -bios QEMU_EFI.fd \
>>>    -object memory-backend-ram,size=4G,id=mem0 \
>>>    -object memory-backend-file,id=cxl-mem1,share=on,mem-path=/tmp/t3_cxl1.raw,size=1G,align=256M \
>>>    -object memory-backend-file,id=cxl-mem2,share=on,mem-path=/tmp/t3_cxl2.raw,size=1G,align=256M \
>>>    -object memory-backend-file,id=cxl-lsa1,share=on,mem-path=/tmp/t3_lsa1.raw,size=1M,align=1M \
>>>     -object memory-backend-file,id=cxl-mem3,share=on,mem-path=/tmp/t3_cxl3.raw,size=1G,align=256M \
>>>    -object memory-backend-file,id=cxl-mem4,share=on,mem-path=/tmp/t3_cxl4.raw,size=1G,align=256M \
>>>    -object memory-backend-file,id=cxl-lsa2,share=on,mem-path=/tmp/t3_lsa2.raw,size=1M,align=1M \
>>>    -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1,hdm_for_passthrough=true,numa_node=0\
>>>    -device cxl-rp,port=0,bus=cxl.1,id=cxl_rp_port0,chassis=0,slot=2 \
>>>    -device cxl-type3,bus=cxl_rp_port0,volatile-memdev=cxl-mem1,id=cxl-pmem1,lsa=cxl-lsa1,sn=3,x-speed=32,x-width=16,chmu-port=4443 \
>>>    -machine cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=8G,cxl-fmw.0.interleave-granularity=1k \
>>>    -numa node,nodeid=0,cpus=0-3,memdev=mem0 \
>>>    -numa node,nodeid=1 \
>>>    -object acpi-generic-initiator,id=bob2,pci-dev=bob,node=1 \
>>>    -numa node,nodeid=2 \
>>>    -object acpi-generic-port,id=bob11,pci-bus=cxl.1,node=2 \
>>>
>>> In the guest, create and bind the region - this brings up the CXL memory
>>> device so accesses go to the memory.
>>>
>>>     cd /sys/bus/cxl/devices/decoder0.0/
>>>     cat create_ram_region
>>>     echo region0 > create_ram_region
>>>     echo ram > /sys/bus/cxl/devices/decoder2.0/mode
>>>     echo ram > /sys/bus/cxl/devices/decoder3.0/mode
>>>     echo $((256 << 21)) > /sys/bus/cxl/devices/decoder2.0/dpa_size
>>>     cd /sys/bus/cxl/devices/region0/
>>>     echo 256 > interleave_granularity
>>>     echo 1 > interleave_ways
>>>     echo $((256 << 21)) > size
>>>     echo decoder2.0 > target0
>>>     echo 1 > commit
>>>     echo region0 > /sys/bus/cxl/drivers/cxl_region/bind
>>>
>>> Finally start perf with something like:
>>>
>>> ./perf record -a  -e cxl_hmu_mem0.0.0/epoch_type=0,access_type=6,\
>>> hotness_threshold=635,epoch_multiplier=4,epoch_scale=4,\
>>> range_base=0,range_size=4096/  ./stress.sh
>>>
>>> where stress.sh is
>>>
>>>     sleep 2
>>>     numactl --membind 3 stress-ng --vm 1 --vm-bytes 1M --vm-keep -t 5s
>>>     sleep 2
>>>
>>> See the results with
>>> ./perf report --dump-raw-trace | grep -A 200 HMU
>>>
>>> Enjoy and have a good weekend.
>>>
>>> Thanks,
>>>
>>> Jonathan
>>>
>>> Jonathan Cameron (3):
>>>     hw/cxl: Initial CXL Hotness Monitoring Unit Emulation
>>>     plugins: Add cache miss reporting over a socket.
>>>     contrib: Add example hotness monitoring unit server
>>>
>>>    include/hw/cxl/cxl.h        |   1 +
>>>    include/hw/cxl/cxl_chmu.h   | 154 ++++++++++++
>>>    include/hw/cxl/cxl_device.h |  13 +-
>>>    include/hw/cxl/cxl_pci.h    |   7 +-
>>>    contrib/hmu/hmu.c           | 312 ++++++++++++++++++++++++
>>>    contrib/plugins/cache.c     |  75 +++++-
>>>    hw/cxl/cxl-chmu.c           | 459 ++++++++++++++++++++++++++++++++++++
>>>    hw/mem/cxl_type3.c          |  25 +-
>>>    hw/cxl/meson.build          |   1 +
>>>    9 files changed, 1035 insertions(+), 12 deletions(-)
>>>    create mode 100644 include/hw/cxl/cxl_chmu.h
>>>    create mode 100644 contrib/hmu/hmu.c
>>>    create mode 100644 hw/cxl/cxl-chmu.c
>>>    
>>
> 

