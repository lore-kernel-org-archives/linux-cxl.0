Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648E9135A63
	for <linux-cxl@vger.kernel.org>; Mon, 27 Jan 2025 10:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737973218; cv=none; b=JRd7np3iheEWJagSTh1hP5bJY9qzFqzMo1ipxYawFbrNWgWaJT/eNGjG5O8RYF+DxmIGs/EfTc8jqJmJOavVXlA5MjGqIQf8HqvQzpGp0sSHLJAGuSvwNrL4Whdk2Mt0RDj4D5I1jKXfS/Sza9qMdrPKly0watpZ+lD67dgimmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737973218; c=relaxed/simple;
	bh=oQNCzn3YMBBGVQkkG0Xcng8cD7emYokNo3bA9GcU2Gg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X7DyE5dPJofGtoq55nmvouzq2rTH0B8ZRMStysmpyYYFPQQ+94eqGrP+qFIEXRvSA/2EYq62tfjHs8xuyroKVcHJ/Q7+ggdnNVzVnGD+R/GQDkrX1wi/CVqiV8YsNenF5gsOZgGsYH8FRzHnfg+w/Q37MU/CHkn3Z+0Hh2y8QtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YhPY96YNqz6K9CY;
	Mon, 27 Jan 2025 18:19:41 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id D542F140B73;
	Mon, 27 Jan 2025 18:20:11 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 27 Jan
 2025 11:20:11 +0100
Date: Mon, 27 Jan 2025 10:20:09 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
CC: <fan.ni@samsung.com>, <linux-cxl@vger.kernel.org>,
	<qemu-devel@nongnu.org>, Alex =?ISO-8859-1?Q?Benn=E9e?=
	<alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>, Mahmoud
 Mandour <ma.mandourr@gmail.com>, <linuxarm@huawei.com>, Niyas Sait
	<niyas.sait@huawei.com>
Subject: Re: [RFC PATCH QEMU 0/3] cxl/plugins: Hotness Monitoring Unit with
 'real' data.
Message-ID: <20250127102009.00002dbd@huawei.com>
In-Reply-To: <5e0876e8-4c2c-4ba5-86dc-d9ca241b743d@linaro.org>
References: <20250124172905.84099-1-Jonathan.Cameron@huawei.com>
	<5e0876e8-4c2c-4ba5-86dc-d9ca241b743d@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 24 Jan 2025 12:55:52 -0800
Pierrick Bouvier <pierrick.bouvier@linaro.org> wrote:

> Hi Jonathan,
>=20
> thanks for posting this. It's a creative usage of plugins.
>=20
> I think that your current approach, decoupling plugins, CHMU and device=20
> model is a good thing.
>=20
> I'm not familiar with CXL, but one question that comes to my mind is:
> Is that mandatory to do this analysis during execution (vs dumping=20
> binary traces from CHMU and plugin and running an analysis post execution=
)?

Short answer is that post run analysis isn't of much use for developing the=
 OS
software story. It works to some degree if you are designing the tracking
hardware or algorithms to use that hardware capture a snapshot of hotness -
dealing with lack of counters, that sort of thing.=20

The main intent of this support is to drive live usage of the data in the O=
S.
So it gets this hotness information and migrates more frequently accessed m=
emory
to a 'nearer'/lower latency memory node.

=46rom an OS point of view there will be two ways it uses it:
1) Offline application optimization  - that aligns with your suggestion of =
offline
   analysis but would typically still need to be live because we have to do
   the reverse maps and work out what was allocated in particular locations.
   Not impossible to dump that information from QEMU + the guest OS but the=
 usage
   flow would then look quite different from what makes sense on real hardw=
are
   where all the data is available to the host OS directly.
2) Migration of memory.  This will dynamically change the PA backing a VA w=
hilst
   applications are running. The aim being to develop how that happens, we =
need
   the dynamic state.

Jonathan

>=20
> Regards,
> Pierrick
>=20
> On 1/24/25 09:29, Jonathan Cameron wrote:
> > Hi All,
> >=20
> > This is an RFC mainly to seek feedback on the approach used, particular=
ly
> > the aspect of how to get data from a TCG plugin into a device model.
> > Two options that we have tried
> > 1. Socket over which the plugin sends data to an external server
> >     (as seen here)
> > 2. Register and manage a plugin from within a device model
> >=20
> > The external server approach keeps things loosely coupled, but at the c=
ost
> > of separately maintaining that server, protocol definitions etc and
> > some overhead.
> > The closely couple solution is neater, but I suspect might be controver=
sial
> > (hence I didn't start with that :)
> >=20
> > The code here is at best a PoC to illustrate what we have in mind
> > It's not nice code at all, feature gaps, bugs and all!  So whilst
> > review is always welcome I'm not requesting it for now.
> >=20
> > Kernel support was posted a while back but was done against fake data
> > (still supported here if you don't provide the port parameter to the ty=
pe3 device)
> > https://lore.kernel.org/linux-cxl/20241121101845.1815660-1-Jonathan.Cam=
eron@huawei.com/
> > I'll post a minor update of that driver shortly to take into account
> > a few specification clarifications but it should work with this without
> > those.
> >=20
> > Note there are some other patches on the tree I generated this from
> > so this may not apply to upstream. Easiest is probably to test
> > using gitlab.com/jic23/qemu cxl-2025-01-24
> >=20
> > Thanks to Niyas for his suggestions on how to make all this work!
> >=20
> > Background
> > ----------
> >=20
> > What is the Compute eXpress Link Hotness Monitoring unit and what is it=
 for?
> > - In a tiered memory equipped server with the slow tier being attached =
via
> >    CXL the expectation is a given workload will benefit from putting da=
ta
> >    that is frequently fetched from memory in lower latency directly att=
ached
> >    DRAM.  Less frequently used data can be served from the CXL attached=
 memory
> >    with no significant loss of performance.  Any data that is hot enoug=
h to
> >    almost always be in cache doesn't matter as it is only fetch from me=
mory
> >    occasionally.
> > - Working out which memory is best places where is hard to do and in so=
me
> >    workloads a dynamic problem. As such we need something we can measure
> >    to provide some indication of what data is in the wrong place.
> >    There are existing techniques to do this (page faulting, various
> >    CPU tracing systems, access bit scanning etc) but they all have sign=
ificant
> >    overheads.
> > - Monitoring accesses on the CXL device provides a path to getting good
> >    data without those overheads.  These units are known as CXL Hotness
> >    Monitoring Units or CHMUs.  Loosely speaking they count accesses to
> >    granuals of data (e.g. 4KiB pages).  Exactly how they do that and
> >    where they sacrifice data accuracy is an implementation trade off.
> >=20
> > Why do we need a model that gives real data?
> > - In general there is a need to develop software on top of these units
> >    to move data to the right place. Hard to evaluate that if we are mak=
ing
> >    up the info on what is 'hot'.
> > - Need to allow for a bunch of 'impdef' solutions. Note that CHMU
> >    in this patch set is an oracle - it has enough counters to count
> >    every access.  That's not realistic but it doesn't get me shouted
> >    at by our architecture teams for giving away any secrets.
> >    If we move forward with this, I'll probably implement a limited
> >    counter + full CAM solution (also unrealistic, but closer to real)
> >    I'd be very interested in contributions of other approaches (there
> >    are lots in the literature, under the term top-k)
> > - Resources will be constrained, so whilst a CHMU might in theory
> >    allow monitoring everything at once, that will come with a big
> >    accuracy cost.  We need to design the algorithms that give us
> >    good data given those constraints.
> >=20
> > So we need a solution to explore the design space and develop the softw=
are
> > to take advantage of this hardware (there are various LSF/MM proposals
> > on how to use this an other ways of tracking hotness).
> > https://lore.kernel.org/all/20250123105721.424117-1-raghavendra.kt@amd.=
com/
> > https://lore.kernel.org/lkml/Z4XUoWlU-UgRik18@gourry-fedora-PF4VCD3F/T/
> >=20
> > QEMU plugins give us a way to do this.  In particular the existing
> > Cache plugin can be easily modified to tell use what memory addresses
> > missed at the last level of emulated cache.  We can then filter those
> > for the memory address range that maps to CXL and feed them to our
> > counter implementation. On the other side, each instance of CXL type 3
> > device can connect to this server and request hotness monitoring
> > services + provide parameters etc.  Elements such as list threshold
> > management and overflow detection etc are in the CXL HMU QEMU device mo=
de.
> > As noted above, we have an alternative approach that can closely couple
> > things, so the device model registers the plugin directly and there
> > is no server.
> >=20
> > How to use it!
> > --------------
> >=20
> > It runs a little slow but it runs and generates somewhat plausible outp=
uts.
> > I'd definitely suggest running it with the pass through optimization
> > patch on the CXL staging tree (and a single direct connected device).
> > Your millage will vary if you try to use other parameters, or
> > hotness units beyond the first one (implementation far from complete!)
> >=20
> > To run start the server in contrib/hmu/ providing a port number to list=
en
> > on.
> >=20
> > ./chmu 4443
> >=20
> > Then launch QEMU with something like the following.
> >=20
> > qemu-system-aarch64 -icount shift=3D1 \
> >   -plugin ../qemu/bin/native/contrib/plugins/libcache.so,port=3D4443,mi=
ssfilterbase=3D1099511627776,missfiltersize=3D1099511627776,dcachesize=3D81=
92,dassoc=3D4,dblksize=3D64,icachesize=3D8192,iassoc=3D4,iblksize=3D64,l2ca=
chesize=3D32768,l2assoc=3D16,l2blksize=3D64 \
> >   -M virt,ras=3Don,nvdimm=3Don,gic-version=3D3,cxl=3Don,hmat=3Don -m 4g=
,maxmem=3D8g,slots=3D4 -cpu max -smp 4 \
> >   -kernel Image \
> >   -drive if=3Dnone,file=3Dfull.qcow2,format=3Dqcow2,id=3Dhd \
> >   -device pcie-root-port,id=3Droot_port1 \
> >   -device virtio-blk-pci,drive=3Dhd,x-max-bounce-buffer-size=3D512k \
> >   -nographic -no-reboot -append 'earlycon memblock=3Ddebug root=3D/dev/=
vda2 fsck.mode=3Dskip maxcpus=3D4 tp_printk' \
> >   -monitor telnet:127.0.0.1:1234,server,nowait -bios QEMU_EFI.fd \
> >   -object memory-backend-ram,size=3D4G,id=3Dmem0 \
> >   -object memory-backend-file,id=3Dcxl-mem1,share=3Don,mem-path=3D/tmp/=
t3_cxl1.raw,size=3D1G,align=3D256M \
> >   -object memory-backend-file,id=3Dcxl-mem2,share=3Don,mem-path=3D/tmp/=
t3_cxl2.raw,size=3D1G,align=3D256M \
> >   -object memory-backend-file,id=3Dcxl-lsa1,share=3Don,mem-path=3D/tmp/=
t3_lsa1.raw,size=3D1M,align=3D1M \
> >    -object memory-backend-file,id=3Dcxl-mem3,share=3Don,mem-path=3D/tmp=
/t3_cxl3.raw,size=3D1G,align=3D256M \
> >   -object memory-backend-file,id=3Dcxl-mem4,share=3Don,mem-path=3D/tmp/=
t3_cxl4.raw,size=3D1G,align=3D256M \
> >   -object memory-backend-file,id=3Dcxl-lsa2,share=3Don,mem-path=3D/tmp/=
t3_lsa2.raw,size=3D1M,align=3D1M \
> >   -device pxb-cxl,bus_nr=3D12,bus=3Dpcie.0,id=3Dcxl.1,hdm_for_passthrou=
gh=3Dtrue,numa_node=3D0\
> >   -device cxl-rp,port=3D0,bus=3Dcxl.1,id=3Dcxl_rp_port0,chassis=3D0,slo=
t=3D2 \
> >   -device cxl-type3,bus=3Dcxl_rp_port0,volatile-memdev=3Dcxl-mem1,id=3D=
cxl-pmem1,lsa=3Dcxl-lsa1,sn=3D3,x-speed=3D32,x-width=3D16,chmu-port=3D4443 \
> >   -machine cxl-fmw.0.targets.0=3Dcxl.1,cxl-fmw.0.size=3D8G,cxl-fmw.0.in=
terleave-granularity=3D1k \
> >   -numa node,nodeid=3D0,cpus=3D0-3,memdev=3Dmem0 \
> >   -numa node,nodeid=3D1 \
> >   -object acpi-generic-initiator,id=3Dbob2,pci-dev=3Dbob,node=3D1 \
> >   -numa node,nodeid=3D2 \
> >   -object acpi-generic-port,id=3Dbob11,pci-bus=3Dcxl.1,node=3D2 \
> >=20
> > In the guest, create and bind the region - this brings up the CXL memory
> > device so accesses go to the memory.
> >=20
> >    cd /sys/bus/cxl/devices/decoder0.0/
> >    cat create_ram_region
> >    echo region0 > create_ram_region
> >    echo ram > /sys/bus/cxl/devices/decoder2.0/mode
> >    echo ram > /sys/bus/cxl/devices/decoder3.0/mode
> >    echo $((256 << 21)) > /sys/bus/cxl/devices/decoder2.0/dpa_size
> >    cd /sys/bus/cxl/devices/region0/
> >    echo 256 > interleave_granularity
> >    echo 1 > interleave_ways
> >    echo $((256 << 21)) > size
> >    echo decoder2.0 > target0
> >    echo 1 > commit
> >    echo region0 > /sys/bus/cxl/drivers/cxl_region/bind
> >=20
> > Finally start perf with something like:
> >=20
> > ./perf record -a  -e cxl_hmu_mem0.0.0/epoch_type=3D0,access_type=3D6,\
> > hotness_threshold=3D635,epoch_multiplier=3D4,epoch_scale=3D4,\
> > range_base=3D0,range_size=3D4096/  ./stress.sh
> >=20
> > where stress.sh is
> >=20
> >    sleep 2
> >    numactl --membind 3 stress-ng --vm 1 --vm-bytes 1M --vm-keep -t 5s
> >    sleep 2
> >=20
> > See the results with
> > ./perf report --dump-raw-trace | grep -A 200 HMU
> >=20
> > Enjoy and have a good weekend.
> >=20
> > Thanks,
> >=20
> > Jonathan
> >=20
> > Jonathan Cameron (3):
> >    hw/cxl: Initial CXL Hotness Monitoring Unit Emulation
> >    plugins: Add cache miss reporting over a socket.
> >    contrib: Add example hotness monitoring unit server
> >=20
> >   include/hw/cxl/cxl.h        |   1 +
> >   include/hw/cxl/cxl_chmu.h   | 154 ++++++++++++
> >   include/hw/cxl/cxl_device.h |  13 +-
> >   include/hw/cxl/cxl_pci.h    |   7 +-
> >   contrib/hmu/hmu.c           | 312 ++++++++++++++++++++++++
> >   contrib/plugins/cache.c     |  75 +++++-
> >   hw/cxl/cxl-chmu.c           | 459 ++++++++++++++++++++++++++++++++++++
> >   hw/mem/cxl_type3.c          |  25 +-
> >   hw/cxl/meson.build          |   1 +
> >   9 files changed, 1035 insertions(+), 12 deletions(-)
> >   create mode 100644 include/hw/cxl/cxl_chmu.h
> >   create mode 100644 contrib/hmu/hmu.c
> >   create mode 100644 hw/cxl/cxl-chmu.c
> >  =20
>=20

