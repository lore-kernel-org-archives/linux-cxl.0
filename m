Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728C81BD9E5
	for <linux-cxl@vger.kernel.org>; Fri, 24 Jan 2025 17:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737739759; cv=none; b=EERa34zBt5qS/FfiYjWwggdHTY6WSgcUlEVCnePYiXgAnSy1B8pIFX47IKK0JzFulqXnKDDbg/6YImt76L/zPqZ6FU4Le+VlrdvNOxdr6zrNlsTGRRmCBWzpYLEMYFv7z3DchZ3gQ8Li1H9jQBMqSR+VPFN1/0CdDBHmkxiZf3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737739759; c=relaxed/simple;
	bh=/JobIW6v9PNuB2gbw8Wb464M/ZJ9ON65MW25lFQb5t0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bHc+c9tUUvOo9HTyMPrW9j3ivevemnHSB3rQWWwM3qUEXSrbLvtCJRnw7Y7lNYYTr+dsHOnDYAAG855VtltMEZ2xraf/9QjZvFVMZWGzkEwQdlpGFsSQ+jKczRIqk/wjZM9bUXrSA7Qc6CZp9VTvF2WRgoecIEnNpbplstfNl24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Yfl9m1gJ8z6M4Xp;
	Sat, 25 Jan 2025 01:27:08 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 1B1951402DB;
	Sat, 25 Jan 2025 01:29:07 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 24 Jan 2025 18:29:06 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <fan.ni@samsung.com>, <linux-cxl@vger.kernel.org>, <qemu-devel@nongnu.org>
CC: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Alexandre Iooss
	<erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>, Pierrick
 Bouvier <pierrick.bouvier@linaro.org>, <linuxarm@huawei.com>, Niyas Sait
	<niyas.sait@huawei.com>
Subject: [RFC PATCH QEMU 0/3] cxl/plugins: Hotness Monitoring Unit with 'real' data.
Date: Fri, 24 Jan 2025 17:29:02 +0000
Message-ID: <20250124172905.84099-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 frapeml500008.china.huawei.com (7.182.85.71)

Hi All,

This is an RFC mainly to seek feedback on the approach used, particularly
the aspect of how to get data from a TCG plugin into a device model.
Two options that we have tried
1. Socket over which the plugin sends data to an external server
   (as seen here)
2. Register and manage a plugin from within a device model

The external server approach keeps things loosely coupled, but at the cost
of separately maintaining that server, protocol definitions etc and
some overhead.
The closely couple solution is neater, but I suspect might be controversial
(hence I didn't start with that :)

The code here is at best a PoC to illustrate what we have in mind
It's not nice code at all, feature gaps, bugs and all!  So whilst
review is always welcome I'm not requesting it for now.

Kernel support was posted a while back but was done against fake data
(still supported here if you don't provide the port parameter to the type3 device)
https://lore.kernel.org/linux-cxl/20241121101845.1815660-1-Jonathan.Cameron@huawei.com/
I'll post a minor update of that driver shortly to take into account
a few specification clarifications but it should work with this without
those.

Note there are some other patches on the tree I generated this from
so this may not apply to upstream. Easiest is probably to test
using gitlab.com/jic23/qemu cxl-2025-01-24

Thanks to Niyas for his suggestions on how to make all this work!

Background
----------

What is the Compute eXpress Link Hotness Monitoring unit and what is it for?
- In a tiered memory equipped server with the slow tier being attached via
  CXL the expectation is a given workload will benefit from putting data
  that is frequently fetched from memory in lower latency directly attached
  DRAM.  Less frequently used data can be served from the CXL attached memory
  with no significant loss of performance.  Any data that is hot enough to
  almost always be in cache doesn't matter as it is only fetch from memory
  occasionally.
- Working out which memory is best places where is hard to do and in some
  workloads a dynamic problem. As such we need something we can measure
  to provide some indication of what data is in the wrong place.
  There are existing techniques to do this (page faulting, various
  CPU tracing systems, access bit scanning etc) but they all have significant
  overheads.
- Monitoring accesses on the CXL device provides a path to getting good
  data without those overheads.  These units are known as CXL Hotness
  Monitoring Units or CHMUs.  Loosely speaking they count accesses to
  granuals of data (e.g. 4KiB pages).  Exactly how they do that and
  where they sacrifice data accuracy is an implementation trade off.

Why do we need a model that gives real data?
- In general there is a need to develop software on top of these units
  to move data to the right place. Hard to evaluate that if we are making
  up the info on what is 'hot'.
- Need to allow for a bunch of 'impdef' solutions. Note that CHMU
  in this patch set is an oracle - it has enough counters to count
  every access.  That's not realistic but it doesn't get me shouted
  at by our architecture teams for giving away any secrets.
  If we move forward with this, I'll probably implement a limited
  counter + full CAM solution (also unrealistic, but closer to real)
  I'd be very interested in contributions of other approaches (there
  are lots in the literature, under the term top-k)
- Resources will be constrained, so whilst a CHMU might in theory
  allow monitoring everything at once, that will come with a big
  accuracy cost.  We need to design the algorithms that give us
  good data given those constraints.

So we need a solution to explore the design space and develop the software
to take advantage of this hardware (there are various LSF/MM proposals
on how to use this an other ways of tracking hotness).
https://lore.kernel.org/all/20250123105721.424117-1-raghavendra.kt@amd.com/
https://lore.kernel.org/lkml/Z4XUoWlU-UgRik18@gourry-fedora-PF4VCD3F/T/

QEMU plugins give us a way to do this.  In particular the existing
Cache plugin can be easily modified to tell use what memory addresses
missed at the last level of emulated cache.  We can then filter those
for the memory address range that maps to CXL and feed them to our
counter implementation. On the other side, each instance of CXL type 3
device can connect to this server and request hotness monitoring
services + provide parameters etc.  Elements such as list threshold
management and overflow detection etc are in the CXL HMU QEMU device mode.
As noted above, we have an alternative approach that can closely couple
things, so the device model registers the plugin directly and there
is no server.

How to use it!
--------------

It runs a little slow but it runs and generates somewhat plausible outputs.
I'd definitely suggest running it with the pass through optimization
patch on the CXL staging tree (and a single direct connected device).
Your millage will vary if you try to use other parameters, or
hotness units beyond the first one (implementation far from complete!)

To run start the server in contrib/hmu/ providing a port number to listen
on.

./chmu 4443

Then launch QEMU with something like the following.

qemu-system-aarch64 -icount shift=1 \
 -plugin ../qemu/bin/native/contrib/plugins/libcache.so,port=4443,missfilterbase=1099511627776,missfiltersize=1099511627776,dcachesize=8192,dassoc=4,dblksize=64,icachesize=8192,iassoc=4,iblksize=64,l2cachesize=32768,l2assoc=16,l2blksize=64 \
 -M virt,ras=on,nvdimm=on,gic-version=3,cxl=on,hmat=on -m 4g,maxmem=8g,slots=4 -cpu max -smp 4 \
 -kernel Image \
 -drive if=none,file=full.qcow2,format=qcow2,id=hd \
 -device pcie-root-port,id=root_port1 \
 -device virtio-blk-pci,drive=hd,x-max-bounce-buffer-size=512k \
 -nographic -no-reboot -append 'earlycon memblock=debug root=/dev/vda2 fsck.mode=skip maxcpus=4 tp_printk' \
 -monitor telnet:127.0.0.1:1234,server,nowait -bios QEMU_EFI.fd \
 -object memory-backend-ram,size=4G,id=mem0 \
 -object memory-backend-file,id=cxl-mem1,share=on,mem-path=/tmp/t3_cxl1.raw,size=1G,align=256M \
 -object memory-backend-file,id=cxl-mem2,share=on,mem-path=/tmp/t3_cxl2.raw,size=1G,align=256M \
 -object memory-backend-file,id=cxl-lsa1,share=on,mem-path=/tmp/t3_lsa1.raw,size=1M,align=1M \
  -object memory-backend-file,id=cxl-mem3,share=on,mem-path=/tmp/t3_cxl3.raw,size=1G,align=256M \
 -object memory-backend-file,id=cxl-mem4,share=on,mem-path=/tmp/t3_cxl4.raw,size=1G,align=256M \
 -object memory-backend-file,id=cxl-lsa2,share=on,mem-path=/tmp/t3_lsa2.raw,size=1M,align=1M \
 -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1,hdm_for_passthrough=true,numa_node=0\
 -device cxl-rp,port=0,bus=cxl.1,id=cxl_rp_port0,chassis=0,slot=2 \
 -device cxl-type3,bus=cxl_rp_port0,volatile-memdev=cxl-mem1,id=cxl-pmem1,lsa=cxl-lsa1,sn=3,x-speed=32,x-width=16,chmu-port=4443 \
 -machine cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=8G,cxl-fmw.0.interleave-granularity=1k \
 -numa node,nodeid=0,cpus=0-3,memdev=mem0 \
 -numa node,nodeid=1 \
 -object acpi-generic-initiator,id=bob2,pci-dev=bob,node=1 \
 -numa node,nodeid=2 \
 -object acpi-generic-port,id=bob11,pci-bus=cxl.1,node=2 \

In the guest, create and bind the region - this brings up the CXL memory
device so accesses go to the memory.

  cd /sys/bus/cxl/devices/decoder0.0/
  cat create_ram_region
  echo region0 > create_ram_region
  echo ram > /sys/bus/cxl/devices/decoder2.0/mode
  echo ram > /sys/bus/cxl/devices/decoder3.0/mode
  echo $((256 << 21)) > /sys/bus/cxl/devices/decoder2.0/dpa_size
  cd /sys/bus/cxl/devices/region0/
  echo 256 > interleave_granularity
  echo 1 > interleave_ways
  echo $((256 << 21)) > size
  echo decoder2.0 > target0
  echo 1 > commit
  echo region0 > /sys/bus/cxl/drivers/cxl_region/bind

Finally start perf with something like:

./perf record -a  -e cxl_hmu_mem0.0.0/epoch_type=0,access_type=6,\
hotness_threshold=635,epoch_multiplier=4,epoch_scale=4,\
range_base=0,range_size=4096/  ./stress.sh

where stress.sh is

  sleep 2
  numactl --membind 3 stress-ng --vm 1 --vm-bytes 1M --vm-keep -t 5s
  sleep 2

See the results with
./perf report --dump-raw-trace | grep -A 200 HMU

Enjoy and have a good weekend.

Thanks,

Jonathan

Jonathan Cameron (3):
  hw/cxl: Initial CXL Hotness Monitoring Unit Emulation
  plugins: Add cache miss reporting over a socket.
  contrib: Add example hotness monitoring unit server

 include/hw/cxl/cxl.h        |   1 +
 include/hw/cxl/cxl_chmu.h   | 154 ++++++++++++
 include/hw/cxl/cxl_device.h |  13 +-
 include/hw/cxl/cxl_pci.h    |   7 +-
 contrib/hmu/hmu.c           | 312 ++++++++++++++++++++++++
 contrib/plugins/cache.c     |  75 +++++-
 hw/cxl/cxl-chmu.c           | 459 ++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3.c          |  25 +-
 hw/cxl/meson.build          |   1 +
 9 files changed, 1035 insertions(+), 12 deletions(-)
 create mode 100644 include/hw/cxl/cxl_chmu.h
 create mode 100644 contrib/hmu/hmu.c
 create mode 100644 hw/cxl/cxl-chmu.c

-- 
2.43.0

