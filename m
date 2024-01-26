Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2920A18040
	for <linux-cxl@vger.kernel.org>; Fri, 26 Jan 2024 12:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706272774; cv=none; b=Jmc9tQRvyL3cf1Z/lfDYDNMxt7ib3VC7rzur67oDljxVS90MmCL59UvrYO/JmLWAVn9EhTcIHmAoZrXgvSCfHHOjaHv9tqce7gQmfMynQ8I6H37q4wZxmcaQ2qt3C0bBtyhuuCFzOXGIR+zVqtFzFqx9DmQqY7I/JCtEuYXFLpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706272774; c=relaxed/simple;
	bh=GEr1shwMOCFDQBxr28+qJ0bcQH7UJKgpeLNwOE7ZUfc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LJW3vwq7oKEjcUeCe/3iWITlSuZX7Itn3eaJtgp4e5WFBMVvHrlHt3bHLpHT1T+GADQfkcLaGUPFyBFHtOPJDGzuC0FfGjdLOQIINCb1AnkCIftgZxQrKA8rS5JjxenC1/qjgXButeN0gkNYlYOTZM77NBMcEn9vtmNigXs8Je8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TLxyG0T8qz6J9v3;
	Fri, 26 Jan 2024 20:36:22 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 9E49E140A86;
	Fri, 26 Jan 2024 20:39:27 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Jan
 2024 12:39:27 +0000
Date: Fri, 26 Jan 2024 12:39:26 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Sajjan Rao <sajjanr@gmail.com>
CC: Dimitrios Palyvos <dimitrios.palyvos@zptcorp.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: qemu cxl memory expander shows numa_node -1
Message-ID: <20240126123926.000051bd@Huawei.com>
In-Reply-To: <CAAg4Pap9KzkgX=fgE7vNJYxEpGbHA-NVsgBY5npXizUbMhjp9A@mail.gmail.com>
References: <CAAg4PaqsGZvkDk_=PH+Oz-yeEUVcVsrumncAgegRKuxe_YoFhA@mail.gmail.com>
	<CAGEDW0fWCfuG3KrNSwDjNVGAZVL9NJgF26Jqyd840HfQdNGLbA@mail.gmail.com>
	<CAAg4Pard=zh_5p650UcNdQEoQWZLM6G7KRqdPQHLmaR4oZMJ3w@mail.gmail.com>
	<CAGEDW0dVEk-QXuL=DPVvSP4t5cafz6N-r_SrCxgFnBfFOsixSA@mail.gmail.com>
	<CAAg4PaqgZcTXkWuys7FZjQdRChTkKj-ZnJQCdxpTMCxy4Hghow@mail.gmail.com>
	<20230823175056.00001a84@Huawei.com>
	<CAAg4ParSB4_2FU2bu96A=3tSNuwHqZwK0wCS18EJoPAq9kYEkw@mail.gmail.com>
	<CAAg4Pap9KzkgX=fgE7vNJYxEpGbHA-NVsgBY5npXizUbMhjp9A@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 25 Jan 2024 13:45:09 +0530
Sajjan Rao <sajjanr@gmail.com> wrote:

> Looks like something changed in QEMU 8.2 that broke running code out
> of CXL memory with KVM disabled.
> I used "numactl --membind 2 ls" as suggested by Dimitrios earlier,
> this worked for me until I updated to the latest QEMU.
>=20
> Is this a known issue? Or am I missing something?

I'm confused on how the description below ever worked.
Assigning the underlying memdev=3Dcxl-mem1 to a numa node isn't going
to correctly build the connections the CFMWS PA range.

I think you are mapping the same memory backend twice - once via
the normal NUMA node configuration as normal RAM (part of the -m 10G)
and once via the CXL type3 device which then ends up connected up behind
the CFWMS.  This is not a good idea as there are two paths to the same
memory.  CXL memory should not be part of the size provided via the -m
parameter.

The NUMA configuration for CXL memory in QEMU (which is assuming OS first
set up today) does not use the ACPI tables (SRAT/SLIT/HMAT) that will
result from -numa entries in the QEMU command line but instead the kernel
creates a NUMA node per CFWMS entry and any devices connected to that end
up in appropriate NUMA node.

Jonathan

>=20
> Thanks,
> Sajjan
>=20
>=20
> On Thu, Aug 24, 2023 at 11:56=E2=80=AFAM Sajjan Rao <sajjanr@gmail.com> w=
rote:
> >
> > Understood. Thank you Jonathan.
> >
> > On Wed, Aug 23, 2023 at 10:21=E2=80=AFPM Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote: =20
> > >
> > > On Wed, 23 Aug 2023 16:43:13 +0530
> > > Sajjan Rao <sajjanr@gmail.com> wrote:
> > > =20
> > > > Thank you Dimitrios. That worked!
> > > >
> > > > On Mon, Aug 21, 2023 at 4:23=E2=80=AFPM Dimitrios Palyvos
> > > > <dimitrios.palyvos@zptcorp.com> wrote: =20
> > > > >
> > > > > Hi,
> > > > >
> > > > > Ah yes, I believe you need to enable the kernel config option
> > > > > CONFIG_CXL_REGION_INVALIDATION_TEST for the region creation to wo=
rk in
> > > > > QEMU. The help entry of that config option gives more info on the=
 why.
> > > > >
> > > > > Hope that helps!
> > > > >
> > > > > Kind regards,
> > > > > Dimitris
> > > > >
> > > > >
> > > > > On Mon, Aug 21, 2023 at 12:01=E2=80=AFPM Sajjan Rao <sajjanr@gmai=
l.com> wrote: =20
> > > > > >
> > > > > > Hello Dimitrios,
> > > > > >
> > > > > > Thank you for the pointers. I have the 6.4.10 kernel and modifi=
ed the
> > > > > > qemu options, but now I see an error creating the region.
> > > > > > Is there anything else I missed?
> > > > > >
> > > > > > [root@cxl-test /]# cxl create-region -d decoder0.0 -s 268435456=
 -t ram
> > > > > > [ 4144.982608] cxl region0: Failed to synchronize CPU cache sta=
te
> > > > > > cxl region: create_region: region0: failed to commit decode: No=
 such
> > > > > > device or address
> > > > > >
> > > > > > Thanks,
> > > > > > Sajjan
> > > > > >
> > > > > > -- qemu
> > > > > >
> > > > > > qemu-system-x86_64 \
> > > > > >  -hda /var/lib/libvirt/images/CXL-Test_1.qcow2 \
> > > > > >  -machine type=3Dq35,cxl=3Don \
> > > > > >  -m 4G \
> > > > > >  -smp cpus=3D2 \
> > > > > >  -accel tcg,thread=3Dsingle \
> > > > > >  -object memory-backend-ram,size=3D4G,id=3Dm0 \
> > > > > >  -object memory-backend-ram,size=3D256M,id=3Dcxl-mem1 \
> > > > > >  -numa node,memdev=3Dm0,cpus=3D0-1,nodeid=3D0 \
> > > > > >  -netdev user,id=3Dnet0,net=3D192.168.0.0/24,dhcpstart=3D192.16=
8.0.9  \
> > > > > >  -device virtio-net-pci,netdev=3Dnet0 \
> > > > > >  -device pxb-cxl,bus_nr=3D12,bus=3Dpcie.0,id=3Dcxl.1 \
> > > > > >  -device cxl-rp,port=3D0,bus=3Dcxl.1,id=3Dcxl_rp_port0,chassis=
=3D0,slot=3D2 \
> > > > > >  -device cxl-type3,bus=3Dcxl_rp_port0,volatile-memdev=3Dcxl-mem=
1,id=3Dcxl-mem1 \
> > > > > >  -M cxl-fmw.0.targets.0=3Dcxl.1,cxl-fmw.0.size=3D4G \
> > > > > >  -nographic
> > > > > >
> > > > > > -----
> > > > > >
> > > > > > [root@cxl-test /]# uname -r
> > > > > > 6.4.10-200.fc38.x86_64
> > > > > > [root@cxl-test /]# cxl list
> > > > > > [
> > > > > >   {
> > > > > >     "memdev":"mem0",
> > > > > >     "ram_size":268435456,
> > > > > >     "serial":0,
> > > > > >     "host":"0000:0d:00.0"
> > > > > >   }
> > > > > > ]
> > > > > > [root@cxl-test /]# cxl create-region -d decoder0.0 -s 268435456=
 -t ram
> > > > > > [ 4144.982608] cxl region0: Failed to synchronize CPU cache sta=
te
> > > > > > cxl region: create_region: region0: failed to commit decode: No=
 such
> > > > > > device or address
> > > > > >
> > > > > > [root@cxl-test /]#
> > > > > >
> > > > > > On Fri, Aug 18, 2023 at 8:31=E2=80=AFPM Dimitrios Palyvos
> > > > > > <dimitrios.palyvos@zptcorp.com> wrote: =20
> > > > > > >
> > > > > > > Hi,
> > > > > > >
> > > > > > > I am not an expert (and not 100% sure if that's what you want=
 to do),
> > > > > > > but here's one way to get your configuration to work:
> > > > > > > 1. Disable KVM. =20
> > >
> > > Just to second this - don't use KVM and expect it to work with CXL em=
ulation
> > > if you are trying to use kmem to present it as normal memory - it sho=
uld be fine
> > > as long as you never run instructions resident in that memory.
> > >
> > > It will crash in nasty ways due to various issues with instruction em=
ulation
> > > where it is running out of memory behind the emulated interleave deco=
ders.
> > >
> > > So far we haven't cared enough to add the complexity that would be ne=
eded
> > > to make that work.
> > >
> > > TCG is the way to go for now.
> > >
> > > Jonathan
> > > =20
> > > > > > > 2. Remove the CXL NUMA node from the QEMU command.
> > > > > > > 3. Use the ndctl utilities in the guest to initialize your CX=
L memory
> > > > > > > and associated NUMA node.
> > > > > > >
> > > > > > > More specifically, I changed your QEMU command as follows:
> > > > > > >
> > > > > > >     qemu-system-x86_64 \
> > > > > > >      -hda /var/lib/libvirt/images/CXL-Test_1.qcow2 \
> > > > > > >      -machine type=3Dq35,cxl=3Don \
> > > > > > >      -m 8G \
> > > > > > >      -smp cpus=3D8 \
> > > > > > >      -object memory-backend-ram,size=3D4G,id=3Dm0 \
> > > > > > >      -object memory-backend-ram,size=3D4G,id=3Dm1 \
> > > > > > >      -object memory-backend-ram,size=3D2G,id=3Dcxl-mem1 \
> > > > > > >      -numa node,memdev=3Dm0,cpus=3D0-3,nodeid=3D0 \
> > > > > > >      -numa node,memdev=3Dm1,cpus=3D4-7,nodeid=3D1 \
> > > > > > >      -netdev user,id=3Dnet0,net=3D192.168.0.0/24,dhcpstart=3D=
192.168.0.9  \
> > > > > > >      -device virtio-net-pci,netdev=3Dnet0 \
> > > > > > >      -device pxb-cxl,bus_nr=3D12,bus=3Dpcie.0,id=3Dcxl.1 \
> > > > > > >      -device cxl-rp,port=3D0,bus=3Dcxl.1,id=3Dcxl_rp_port0,ch=
assis=3D0,slot=3D2 \
> > > > > > >      -device cxl-type3,bus=3Dcxl_rp_port0,volatile-memdev=3Dc=
xl-mem1,id=3Dcxl-mem1 \
> > > > > > >      -M cxl-fmw.0.targets.0=3Dcxl.1,cxl-fmw.0.size=3D4G \
> > > > > > >      -nographic
> > > > > > >
> > > > > > > In the guest, install ndctl: https://github.com/pmem/ndctl
> > > > > > >
> > > > > > > After that, you should be able to see the CXL memory:
> > > > > > >     root@cxl-img:~# cxl list
> > > > > > >     [
> > > > > > >       {
> > > > > > >         "memdev":"mem0",
> > > > > > >         "ram_size":2147483648,
> > > > > > >         "serial":0,
> > > > > > >         "host":"0000:0d:00.0"
> > > > > > >       }
> > > > > > >     ]
> > > > > > >
> > > > > > > And initialize it as RAM:
> > > > > > >     root@cxl-img:~# cxl create-region -d decoder0.0 -s 214748=
3648 -t ram
> > > > > > >     ...
> > > > > > >
> > > > > > > root@cxl-img:~# lsmem --output-all
> > > > > > >     RANGE                                  SIZE  STATE REMOVA=
BLE BLOCK
> > > > > > > NODE  ZONES
> > > > > > >     0x0000000000000000-0x0000000007ffffff  128M online       =
yes     0
> > > > > > >    0   None
> > > > > > >     0x0000000008000000-0x000000007fffffff  1.9G online       =
yes  1-15
> > > > > > >    0  DMA32
> > > > > > >     0x0000000100000000-0x000000017fffffff    2G online       =
yes 32-47
> > > > > > >    0 Normal
> > > > > > >     0x0000000180000000-0x000000027fffffff    4G online       =
yes 48-79
> > > > > > >    1 Normal
> > > > > > >     0x0000000290000000-0x000000030fffffff    2G online       =
yes 82-97
> > > > > > >    2 Normal
> > > > > > >
> > > > > > >     Memory block size:       128M
> > > > > > >     Total online memory:      10G
> > > > > > >     Total offline memory:      0B
> > > > > > >
> > > > > > >
> > > > > > >     root@cxl-img:~# cat /proc/iomem
> > > > > > >     ...
> > > > > > >     290000000-38fffffff : CXL Window 0
> > > > > > >       290000000-30fffffff : region0
> > > > > > >         290000000-30fffffff : dax0.0
> > > > > > >           290000000-30fffffff : System RAM (kmem)
> > > > > > >
> > > > > > >
> > > > > > > Then you can generate traffic in the CXL NUMA node, for examp=
le:
> > > > > > >
> > > > > > >     root@cxl-img:~# numactl --membind 2 ls
> > > > > > >
> > > > > > > Note: The above is with linux v6.4.11.
> > > > > > >
> > > > > > > Hope that helps!
> > > > > > >
> > > > > > > Kind regards,
> > > > > > > Dimitris
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > On Fri, Aug 18, 2023 at 11:39=E2=80=AFAM Sajjan Rao <sajjanr@=
gmail.com> wrote: =20
> > > > > > > >
> > > > > > > > Hello,
> > > > > > > >
> > > > > > > > I have a qemu + cxl configuration coming up with one config=
ured type 3
> > > > > > > > device. My goal is to generate some cxl.mem traffic in this
> > > > > > > > configuration.
> > > > > > > > However the numa_node is always showing as -1. I have tried=
 various
> > > > > > > > qemu command line parameters including to explicitly set nu=
ma_node for
> > > > > > > > cxl devices.
> > > > > > > >
> > > > > > > > Here is my qemu command line
> > > > > > > > --------
> > > > > > > > qemu-system-x86_64 \
> > > > > > > >  -hda /var/lib/libvirt/images/CXL-Test_1.qcow2 \
> > > > > > > >  -machine type=3Dq35,accel=3Dkvm,cxl=3Don \
> > > > > > > >  -m 10G \
> > > > > > > >  -smp cpus=3D8 \
> > > > > > > >  -object memory-backend-ram,size=3D4G,id=3Dm0 \
> > > > > > > >  -object memory-backend-ram,size=3D4G,id=3Dm1 \
> > > > > > > >  -object memory-backend-ram,size=3D2G,id=3Dcxl-mem1 \
> > > > > > > >  -numa node,memdev=3Dm0,cpus=3D0-1,nodeid=3D0 \
> > > > > > > >  -numa node,memdev=3Dm1,cpus=3D2-3,nodeid=3D1 \
> > > > > > > >  -numa node,memdev=3Dcxl-mem1,cpus=3D4-7,nodeid=3D2 \
> > > > > > > >  -netdev user,id=3Dnet0,net=3D192.168.0.0/24,dhcpstart=3D19=
2.168.0.9  \
> > > > > > > >  -device virtio-net-pci,netdev=3Dnet0 \
> > > > > > > >  -device pxb-cxl,bus_nr=3D12,bus=3Dpcie.0,id=3Dcxl.1 \
> > > > > > > >  -device cxl-rp,port=3D0,bus=3Dcxl.1,id=3Dcxl_rp_port0,chas=
sis=3D0,slot=3D2 \
> > > > > > > >  -device cxl-type3,bus=3Dcxl_rp_port0,volatile-memdev=3Dcxl=
-mem1,id=3Dcxl-mem1 \
> > > > > > > >  -M cxl-fmw.0.targets.0=3Dcxl.1,cxl-fmw.0.size=3D4G \
> > > > > > > >  -enable-kvm \
> > > > > > > >  -nographic
> > > > > > > > -----
> > > > > > > >
> > > > > > > > I see that the cxl device is listed in lspci output
> > > > > > > > ------
> > > > > > > > #lspci | grep -i cxl
> > > > > > > > 0d:00.0 CXL: Intel Corporation Device 0d93 (rev 01)
> > > > > > > >
> > > > > > > > #lspci -s 0d:00.0 -vvv | grep -i numa
> > > > > > > > #
> > > > > > > >
> > > > > > > > -------
> > > > > > > >
> > > > > > > > sysfs output
> > > > > > > > ----------
> > > > > > > > #cat /sys/bus/cxl/devices/mem0/numa_node
> > > > > > > > -1
> > > > > > > > --------
> > > > > > > >
> > > > > > > > numactl output
> > > > > > > >
> > > > > > > > ------------------
> > > > > > > > #numactl -H
> > > > > > > > available: 3 nodes (0-2)
> > > > > > > > node 0 cpus: 0 1
> > > > > > > > node 0 size: 3910 MB
> > > > > > > > node 0 free: 3776 MB
> > > > > > > > node 1 cpus: 2 3
> > > > > > > > node 1 size: 4031 MB
> > > > > > > > node 1 free: 3927 MB
> > > > > > > > node 2 cpus: 4 5 6 7
> > > > > > > > node 2 size: 2011 MB
> > > > > > > > node 2 free: 1785 MB
> > > > > > > > node distances:
> > > > > > > > node   0   1   2
> > > > > > > >   0:  10  20  20
> > > > > > > >   1:  20  10  20
> > > > > > > >   2:  20  20  10
> > > > > > > > -------------------
> > > > > > > >
> > > > > > > > The numa_node 2 is expected to be mapped to a CXL device, I=
 do see
> > > > > > > > some activity in numastat output, but it's unclear if this =
is really
> > > > > > > > mapped to the CXL device since the device itself says numa_=
node is -1
> > > > > > > > (expected to show 2).
> > > > > > > >
> > > > > > > > Has anybody seen this behavior? Any help will be greatly ap=
preciated.
> > > > > > > >
> > > > > > > > Thanks,
> > > > > > > > Sajjan =20
> > > > > > >
> > > > > > > --
> > > > > > > **CONFIDENTIALITY NOTICE:*
> > > > > > > *
> > > > > > > *The contents of this email message and any
> > > > > > > attachments are intended solely for the addressee(s) and may =
contain
> > > > > > > confidential and/or privileged information and may be legally=
 protected
> > > > > > > from disclosure. If you are not the intended recipient of thi=
s message or
> > > > > > > their agent, or if this message has been addressed to you in =
error, please
> > > > > > > immediately alert the sender by reply email and then delete t=
his message
> > > > > > > and any attachments. If you are not the intended recipient, y=
ou are hereby
> > > > > > > notified that any use, dissemination, copying, or storage of =
this message
> > > > > > > or its attachments is strictly prohibited. * =20
> > > > >
> > > > >
> > > > >
> > > > > --
> > > > >
> > > > > Dimitrios Payvos-Giannas, PhD
> > > > >
> > > > > Software Engineer
> > > > >
> > > > > ZeroPoint Technologies
> > > > >
> > > > > Remove the waste.
> > > > >
> > > > > Release the power.
> > > > >
> > > > > --
> > > > > **CONFIDENTIALITY NOTICE:*
> > > > > *
> > > > > *The contents of this email message and any
> > > > > attachments are intended solely for the addressee(s) and may cont=
ain
> > > > > confidential and/or privileged information and may be legally pro=
tected
> > > > > from disclosure. If you are not the intended recipient of this me=
ssage or
> > > > > their agent, or if this message has been addressed to you in erro=
r, please
> > > > > immediately alert the sender by reply email and then delete this =
message
> > > > > and any attachments. If you are not the intended recipient, you a=
re hereby
> > > > > notified that any use, dissemination, copying, or storage of this=
 message
> > > > > or its attachments is strictly prohibited. * =20
> > > =20

