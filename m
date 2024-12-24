Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32582D517
	for <linux-cxl@vger.kernel.org>; Tue, 24 Dec 2024 15:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735052750; cv=none; b=oAKTURoAQNcWKYN3oiQesCGIRZylrVXGjezbhQ3K3OPz55aFM3bBluIxmRnaEr0yNRVuD90M5auq74UpWzjsmN1YxP3WIKcuMDQAYYqeX616vjMTvto1M+Aunq29cv8M0ZPXGka362YulNMIJfyJLxYIXubgE5U/XhjP823VsqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735052750; c=relaxed/simple;
	bh=xP18VedJh2ZQV7OEYUaAndZoehLqP4gWNYZSd88jmts=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DjlC5i/hQN3LMybXYQERgFMB4VByRxicWmJSL4Yi9XMjCXr99Wj0ISdjowXEWGfwQz5LczoIGPMNArqlarQIdylCQloIT1T1kyG2mGfxxyCo7JIdtzx8NfRsQ9CA3SikbM0ZEIGK38SpGvPK9M4ZI19Pme2q8ol1EMbDSqgDe70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YHdVY0Rcnz6K6Ly;
	Tue, 24 Dec 2024 23:05:25 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 0347D140447;
	Tue, 24 Dec 2024 23:05:45 +0800 (CST)
Received: from localhost (10.48.156.150) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 24 Dec
 2024 16:05:44 +0100
Date: Tue, 24 Dec 2024 15:05:39 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Alejandro Lucero Palau <alucerop@amd.com>
CC: Zhi Wang <zhiw@nvidia.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, <iommu@lists.linux.dev>, Lukas Wunner
	<lukas@wunner.de>
Subject: Re: RFC: Kernel CXL cache support (and IOMMU implications)
Message-ID: <20241224150539.00006cc6@huawei.com>
In-Reply-To: <37deb771-f521-7131-29cf-5f425a70249e@amd.com>
References: <cc2525a6-0f6a-c1c8-83e1-6396661efc8a@amd.com>
	<20241121003316.00001cd3@nvidia.com>
	<37deb771-f521-7131-29cf-5f425a70249e@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 13 Dec 2024 14:15:18 +0000
Alejandro Lucero Palau <alucerop@amd.com> wrote:

> On 11/20/24 22:33, Zhi Wang wrote:
> > On Tue, 19 Nov 2024 16:52:15 +0000
> > Alejandro Lucero Palau <alucerop@amd.com> wrote:
> >
> > Thanks so much for the doc. I just quickly went through the doc and here
> > are my comments. =20
>=20
>=20
> Hi Zhi,
>=20
>=20
> Thanks for your comments. I did not reply earlier waiting for more=20
> feedback from, mainly, the IOMMU kernel guys. Maybe CXL support is=20
> something most of them neither have contemplated nor aware of (maybe)=20
> requiring special handling. I really think IOMMU/DMA API will need some=20
> change, but this document is for discussing it and maybe proving me wrong.
>=20
>=20
> Let's hope replying to your comments keep things moving somehow ...

Sorry it took me so long to get to this!=20

I replied as I read through it, so thoughts may not be totally coherent.
Key points:

1. If you are doing CXL.cache on a device then either your host should be
   doing checking that the device is not accessing something it shouldn't or
   you should have done the work to ensure it is part of your trusted
   compute base.
2. Using restrictions on memory in the IOMMU page tables to avoid
   thrashing of coherency tracking resources / cache in the host is a non
   starter.  That puts a bound on the number used, but at the cost of
   breaking many use cases.  Page table coverage !=3D cachelines in device.
   a) Endpoint should be part of TCB, trusted not to use more than it is
      told.
   b) Host should not do rubbish QoS so the burden should be mainly on the
      badly behaving device=20
3. I'm not sure why (for what is discussed here) there is any problem with
   VM usecases. The same model used for ATS etc for PCIe VFs should apply
   just fine here.

Anyhow, that's enough muddying the waters for today.

Jonathan


>=20
> >> November, 2024
> >>
> >> Tittle: CXL Cache support by the kernel
> >> Author: Alejandro Lucero (alucerop@amd.com)
> >>
> >> Version 0.1
> >>
> >> Introduction
> >> =3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >> After the LPC where I presented the current status of the Type2 CXL.mem
> >> support
> >> patchset, and some ideas about supporting CXL.cache, it is time to dig
> >> deeper in
> >> this second goal, and discussing the security/reliability aspect as we=
ll.
> >>
> >> It is also important to try to describe how this is going to work and
> >> what the
> >> kernel needs to know and enforce. Reading the CXL specs when having in
> >> mind some
> >> specific use case can easily lead to assuming certains aspects with a
> >> different
> >> perspective from other readers/use cases. To start with, it is necessa=
ry to
> >> differentiate two "CXL cache" functionalities when a Type2 device is in
> >> place:
> >>
> >> 1) A Type2 device caching Host memory.
> >>
> >> 2) The Host caching HDM memory, that is the memory inside the Type2 CXL
> >> device.
> >>
> >> The first option is also what a Type1 device can do, and the kernel su=
pport
> >> needs to manage all those Type1/2 per CXL Root Complex knowing the res=
ources
> >> limitation, that is the snooping cache size.
> >>
> >> A snoop cache allows the host to track which memory is being used/cach=
ed by
> >> those devices, enforcing the cache coherency. The specs are not clear
> >> about some
> >> important aspects regarding how the host can enforce the proper use of
> >> this by
> >> devices or even if the snoop cache needs to do so. At pages 786 and 787
> >> of CXL
> >> specs 3.1, how the system software should deal with CXL cache devices =
is
> >> given,
> >> but this is inside a Hot-plug section. I think we can assume the Host
> >> firmware/BIOS will follow same approach for enabling CXL cache, and the
> >> kernel
> >> needs to look at those devices with CXL cache enabled by the BIOS for
> >> properly
> >> handling the available space in the snoop cache.
> >>
> >> It is also worth to mention the CXL.cache protocol can be used in the =
two
> >> "CXL cache" functionalities listed above. However, the last CXL spec i=
mplies
> >> CXL.cache only used for the first case. Some comments about what the
> >> specs say
> >>
> >> regarding number of devices with a cache for host memory:
> >>
> >>   =A0=A0=A0=A0=A0=A0=A0 - up to 16 Type1 and/or Type2 devices allowed =
per VH.
> >>
> >> can be easily confused with the limitations of just one CXL Type2 devi=
ce
> >> using
> >> CXL.cache for enforcing coherency of its HDM.=20

It has been a while since I read the relevant sections, but CXL 3.0 introdu=
ced
a cache ID that I thought was precisely to allow for multiple CXL.Cache age=
nts
per VCS (not the HDM-DB stuff that for this purpose is replacing bias
based coherency)  There may well not be any hosts that support that yet tho=
ugh
and it doesnt' really matter for rest of this discussion.

> >> This limitation is
> >> overcome with
> >> forcing Type2 device using HDM-DB, which relies on CXL.mem instead of
> >> CXL.cache
> >> for HDM cache coherency.
> >>
> >> While the Host is assumed to be able to access HDM in a Type2 device, =
and
> >> keeping data in the host cpu caches, it is the Type2 device
> >> responsibility to
> >> properly manage cache coherency of its HDM. There is nothing the kerne=
l can
> >> control here.
> >>
> >> Therefore the interesting part and what this documents tries to cover =
is the
> >> Host memory being cached by Type2 or Type1 devices. While the main goa=
l is
> >> discussing how the kernel needs to handle this, and to describe how it
> >> should
> >> work when CXL devices are used by the system/Host, some comments are m=
ade to
> >> cover the virtualization case where those CXL devices can potenetially
> >> be used
> >> (device passthrough) by guests/VMs. I try to expose the current securi=
ty
> >> problems where IOMMU is used for restricting what a guest controlled
> >> CXL.cache
> >> device can read/write in Host memory what I think needs to be clarifie=
d by
> >> hardware vendors.
> >>
> >>
> >> Understanding the memory accesses from CXL devices
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >> For the sake of presenting the case about kernel CXL.cache support, I'=
ll
> >> try to
> >> explain how it works (I should say "how I think it works") and the main
> >> points
> >> to discuss regarding how to implement this support. So, do not take th=
e next
> >> explanation as the definitive answer or guide, and if you think there
> >> are errors
> >> or maybe too much generalization at some points, please help fixing or
> >> adding
> >> further details. Also, consider some parts as just me thinking out lou=
d,
> >> what
> >> maybe help other people (or confuse them!).
> >>
> >> The CXL.cache protocol allows devices to be part of the coherency ring

Probably avoid 'ring' in terminology. Just "coherency of the system" is fine
I think.

> >> of the
> >> system.
> >>
> >> Let's start with a Type2 device reading from a specific host memory
> >> address. The
> >> final situation is 64bytes (cache line) from host memory copied to the
> >> device
> >> cache, supposedly for being used by the device/accelerator. If the data
> >> changes,
> >> because some host cpu modifies it, the device will be signalled by the
> >> coherency
> >> ring, so the device will know. The important point here is the device =
can be
> >> told because the Host knows the device has a copy or the only copy of =
that
> >> data/memory. And that is thanks to the snoop cache implemented by the

Probably refer to "coherency tracking" rather than say a snoop cache which =
is
just one way of doing it and don't specify where it is.  Could be in any nu=
mber
of places depending on system design.

> >> CXL Root
> >> Complex.
> >>
> >> A device caching host memory can be used as well for writes to host me=
mory
> >> through the cache coherency ring. A device can not just read host memo=
ry and
> >> keep it, but it can modified it. The implications of writes versus rea=
ds
> >> are not
> >> important for the goal of this document. It requires the device to
> >> support more
> >> protocol exchange cases, but regarding the snoop cache, it is irreleva=
nt.
> >>
> >> There arise obvious questions about how this snoop cache is going to w=
ork.
> >>
> >> First, with the simple case of just one device caching Host memory. Fr=
om the
> >> specs, the device CXL.cache should not be enabled by the Host if the d=
evice
> >> cache is bigger than the snoop cache. However, what does preclude a
> >> device to do
> >> more memory accesses than what the snoop cache can cover? This can be =
partly
> >> explained with some allocation control for CXL.cache what is discussed
> >> in the
> >> next section. But a "rogue" device could try things like this, what for
> >> the case
> >> of a single device using the snoop cache and without any other concern=
 about
> >> security, is probably fine:

If you are letting a device into your host coherency and you haven't done
a bunch of stuff to ensure it is not rogue you are on your own.  That stuff=
 is the
domain of technologies such as attestation and more basic stuff like supply=
 chain
management.

Having said that the host can easily identify such a problem and refuse to =
do
anything that would cause it to loose track + issue appropriate RAS event
(maybe including isolating the device).

> >>
> >>   =A0=A0=A0=A0=A0=A0=A0 - With a Type2, the snoop cache will tell the =
device to release
> >> another
> >>   =A0=A0=A0=A0=A0=A0=A0=A0=A0 line, meaning any modified line to be se=
nt back to the Host.
> >>   =A0=A0=A0=A0=A0=A0=A0 - Any performance problem will only have an im=
pact on the
> >> device itself.

Agreed the whole sizing thing is a performance question not so much a
correctness - though  a device might not make forwards progress
if it can't get enough data to do what it wants to do.

> >>
> >> Then the case of multiple CXL devices caching Host memory in the same
> >> CXL Root
> >> Complex and therefore same CXL Snoop Cache:
> >>
> >> * How can the snoop cache track reads from different devices without o=
ne
> >> device
> >>   =A0 monopolizing the full space?
> >>
> >>   =A0=A0=A0=A0=A0=A0=A0 - enforcing snoop cache slices by software?
> >>   =A0=A0=A0=A0=A0=A0=A0 - allowing specific/limited host ranges by the=
 kernel?

To me, that's a hardware problem.  Hardware that doesn't do the
QoS handling for this is broken. Sure we can quirk that if needed
but I'd do it in the first instance by declaring the hardware so
broken we only support one device doing CXL.cache for each set of
tracking resources.  Seems you say that later :)

> >> =20
> > I would like to compare it with the approaches that solves the similar
> > problem of the CPU cache since they might have similar essence.
> >
> > CPU cache suffered from the similar problems that noisy and
> > restless neighborhood keep poking the cache that might cause performance
> > drop. Nowadays, it is solved by the HW mechanism, cache allocation. For
> > Intel, it is called cache allocation technology(CAT) which is a subset =
of
> > Resource Director Technology(RDT). They can be also used in the
> > virtualization world.

Fine in theory in practice not used all that widely, but agreed similar
solutions could be applied here. They are a pain to tune though so I'd
expect to see better non configurable solutions for QoS first and the
ability to tweak only in a few generations time (could be wrong though!)

> >
> > Before SW gets the support from the HW, many research papers were talki=
ng
> > about solving it via page color. E.g. allocate the VM memory with page
> > color awareness for different VMs. But I don't think those ideas eventu=
ally
> > land in the mainline.
> >
> > Back to this prob, I think probably SW is going to rely on a HW mechani=
sm
> > to solve this problem nicely and decently, the same as CPU side. =20
>=20
>=20
> I agree with the need of relying on HW, what the following sentence (in=20
> the original doc) tried to summarize.
>=20
> But we need how this is done by HW for avoiding some undesirable=20
> situations if we just blindly configure CXL.cache to those devices=20
> advertising it and apparently without no problems regarding the snoop=20
> cache size.

I'm not convinced we need to do anything in software.  This is no worse than
head of line blocking on PCIe (bandwidth to host is often
less than that if all devices below some switches want to DMA to=20
host memory at the same time).  In theory we can tweak demand by
messing around with device specific stuff, or tweaking link controls
but in practice does anyone do this in a general purpose system?
Don't think so. We rely on sane QoS handling via credit allocations
etc and the switch doing something sensible.

Sure, a particular implementation might not do this, but that to
me is a quirk that we need to handle on a case by case basis.

>=20
>=20
> >> AFAIK, there is not any kind of hardware control for avoiding this
> >> contention.
> >> Note that with the proper checking by the BIOS and by the kernel (for
> >> hotplug or
> >> those not enabled devices yet during boot time), the size of total
> >> device caches
> >> allowed per CXL Root Complex should not be bigger than the snoop cache
> >> size, and
> >> therefore theoretically no contention at all ... if the devices do the=
 right
> >> thing. From software the only thing we can do is to ensure the CXL.cac=
he
> >> accesses from a device are within a range with same size than the enab=
led
> >> CXL.cache.
> >> =20
> > What would be the consequence if we violate this rule? =20
>=20
>=20
> Contention or just one device getting less snoop cache coverage implying=
=20
> requests from the snoop cache for flushing cached data before trying to=20
> access more data in the host.
>=20
> With a full snoop cache, a new access to uncached addresses will trigger=
=20
> some action by the snoop cache. I'm assuming it will be the device where=
=20
> that new access comes from the one receiving orders for first flushing=20
> cached data for making space, but I may be wrong.

That might be a design choice, but I don't see that being true in general.
Imagine a very simple QoS policy that aims to balance devices use of tracki=
ng
entrees.  In that case if only one agent is sending requests for a bit it
will rightly get all the entrees.  New agent wakes up and sends requests, t=
he
eviction will be an entry for the original agent.  Lots of other policies
will lead to that.

>=20
> But a rogue device, and the first using CXL.cache, could get most of the=
=20
> snoop cache if no other control existing. Has the snoop cache have this=20
> control per device about amount of tracked cachelines allowed? If so,=20
> who is configuring it properly? I would expect the kernel CXL core being=
=20
> the one after doing other checks for validation. If the CXL specs do not=
=20
> specify how, we can expect different implementations, and the kernel=20
> will need to implement a generic frontend layer with per vendor backends.

It's a host implementation thing. Out of scope for CXL. I'd expect we might
see RDT / MPAM whatever your favourite arch uses for resource controls for
this but even those are often soft limits so if only one agent
doing anything it still gets the whole set of tracking entrees.

As before though, I'm unconcerned about rogue devices as if such a device
is plugged in it can do a lot more damage than this! (your later thing
on lying about translated addresses).

>=20
>=20
> >> Therefore, some memory allocation API is required for dealing with the
> >> amount of
> >> memory the snoop cache can track, and the host memory a device can
> >> access to.
> >> The device needs the physical address to work with, and it is in this
> >> required
> >> translation from virtual to physical addresses where we can enforce the
> >> restriction. Of course, such an API does already exist, although not
> >> with the
> >> checking we need: the kernel DMA API.
> >>
> >>
> >> (Secure) memory allocation=A0 and CXL.cache
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> >>
> >> DMAs allow devices to perform read/write operations to system memory
> >> without any
> >> cpu intervention after the (meta)data about how to perform the DMA is
> >> given to
> >> the device. CXL.cache is more than DMA because the system memory cache=
s are
> >> implicitly involved but for the sake of handling this by the operating
> >> system,
> >> not too much different. The important point here is there is no restri=
ction
> >> about the DMAble memory to be used by a device, but due to the snoop c=
ache
> >> limitations, this needs to change for CXL: code aware of the snoop cac=
he
> >> state
> >> and what a device requires needs to be consulted for properly handling=
 the
> >> available space.

I'm not sure how this is connected to DMA mappings etc.

What we map in the page tables is an upper bound on what might be cached by
the device, but it is not the only thing applying that upper bound.
The device is making guarantees not to cache more than a certain amount of =
memory
at a time - likely a tiny subset of what is mapped. Imagine a DB accelerato=
r.
Those will typically having DMA mappings for many TB of data, but the query=
 engines
will only be using a tiny amount of it at any time. They will evict the cac=
helines
when they are done with reading particular data (usually as part of a point=
er chase).
Hence they will use only a few cachelines, but the page tables and indeed
address translation cache will cover much more.


> >> =20
> > As what I replied above, I think we probably need a HW mechanism to sol=
ve
> > this problem nicely and decently. (Thinking sharing cache is
> > also a pre-condition of side-channel attack, even here is a snoop state
> > cahce.) With the HW mechanism, allocating the space of snoop state
> > cache might imply a glue layer of snoop cache management for different
> > CXL HB vendors to plug into the CXL core. =20
>=20
>=20
> Just what I did mention above :-)
>=20
>=20
> Glad to have someone else seeing the problem.

I have no problem with an RDT type scheme but that is about performance
not correctness and is a fine turning on top of telling the devices we
have restricted tracking capacity.

>=20
>=20
> >
> > So when the CXL driver is initialized, the space of the snoop state cac=
he
> > is allocated. With that is solved, for restricting the device to access=
 the
> > memory (creating/mapping an IOVA for the DMA memory), SW can still leve=
rage
> > the current Linux IOMMU/DMA APIs.
> > =20
>=20
> This is my main concern. Note the DMA/IOMMU is likely needed for normal=20
> device operations, and that will be through CXL.io. Same mapping should=20
> then not be shared for CXL.cache, or it can, but with additional per=20
> mapping flags and obviously API changes. The implications here are=20
> obviously more important if IOMMU is enabled, at least if we take what=20
> the specs=A0 say about some ATS/IOMMU mapping only to be allowed by=20
> CXL.io. Without IOMMU, it turns into the problem of rogue devices=20
> monopolizing the snoop cache.

If the snoop cache implementation is that bad, go annoy the hardware
folk. + Rogue devices are not a thing in production systems, well they
are but constraining them is not a problem for this layer of the stack
(if FPGA or similar then checks for rogue accesses need to belong in the sh=
ell
around the bit you allow customers to program - if not cloud vendors
etc will not plug in your devices)


>=20
>=20
> >> Should we use the kernel DMA API for CXL.cache allocations? This API
> >> deals with
> >> memory coherency what is not needed for the CXL.cache case. However, i=
t is
> >> connected with the IOMMU functionality what is required for CXL.cache =
if
> >> it is
> >> enabled.
> >>
> >> I think the solution should be to implement a CXL.cache allocation API
> >> inside
> >> the CXL core dealing with the snoop cache available space, and to
> >> connect with
> >> IOMMU kernel code when it is enabled.

Just to check, does anyone care about these devices with iommu disabled?
In my opinion that should just be blocked on day one.

> >>
> >> A security aspect behind DMAs is a device has (usually) no restriction=
s for
> >> memory access. This is true in a system with no IOMMU hardware, and
> >> CXL.cache
> >> is not different in this case. With IOMMU is a different game though.
> >>
> >> First of all, IOMMU will be in place for CXL.io, what implies legacy T=
LP
> >> PCIe
> >> packets. A CXL.cache operation can not be handled by the IOMMU hardware
> >> and the
> >> spec states ATS to be used beforehand, that is, the CXL device asking
> >> the IOMMU
> >> hardware about the physical address to work with, and keeping that
> >> translation
> >> internally. The CXL spec specifies ATS service extensions for CXL, and
> >> some ATS
> >> requests can tell the device some addresses only to be used through
> >> CXL.io. This
> >> implies some sort of knowledge about CXL is required by the IOMMU/ATS
> >> hardware
> >> which depends on how the per device tables are programmed by the Host.

I think that is not (only?) about security, it is about correctness as some=
 hosts may
not support CXL.cache accesses to some regions of the host address map, e.g=
. peer
PCI device BARs for which we are doing UIO or similar.

> >> However,
> >> AFAIK, this is not supported yet by any Linux kernel IOMMU vendor
> >> support. Note
> >> the usual IOMMU device/domain tables will/can be used for normal DMA
> >> transfers,
> >> so IOMMU configuration, both in the Host and by the HW, needs to know
> >> which parts
> >> of the domain are for DMAs and which are for CXL.cache.

Potentially yes.  Though there are bunch of ways to do that which don't
necessarily expose them to the OS, they may be characterstics of the underl=
ying
HPA memory map.

> >>
> >> Assuming this support will be implemented at some point in the future,=
 the
> >> questions are, when?, and, how safe is it?
> >>
> >> Can a device issue CXL.cache operations using arbitrary physical
> >> addresses?

Of course, same as a PCIe device doing DMA with translated addresses.
You rely on attestation and in some cases sanity checks in the host
(they are still subject to the Confidential compute type checks on physical
 address space permissions for example).

This is what all the fun of device security is all about.  You must know
and trust devices before you let them do anything at all to host memory.

> >> It
> >> seems there are some cases where the hardware can take control of PCIe=
 TLP
> >> packets with the ATS bit on. For example, if there is a PCIe bridge in
> >> the path,
> >> and with that bridge using a specific redirection table based on
> >> configured ATS
> >> per device ranges, any TLP with the ATS bit on will be redirected based
> >> on such
> >> a table, and implying no redirection if no table entry. However, that
> >> does not
> >> seem to be in place for PCIe Root Complex implementations. For example=
, AMD
> >> IOMMU documentation states ATS TLP packets are not handled at all, imp=
lying
> >> trusting the device, and if more security is required, the IOMMU
> >> hardware can =20
> > Are you referring to the ATS translated request here? I think ATS itself
> > doesn't consider the security in its mind. =20
>=20
>=20
> It seems so, but I guess we agree that is not an option for VMs ...=20

Why not?  There is a still quite a bit of infrastructure needed for all the
iommufd work to land, but it's getting close.  That absolutely allows
for ATS - up to the host to check it trusts the device before assigning
any part of it to the VM.  On at least some architectures the translation
is the full 2 stage one to host physical address.

> Without IOMMU you can not have DMAs from passthrough devices, and if=20
> CXL.cache dodges the IOMMU checks (and none other security mechanism in=20
> place), CXL.cache should not be allowed in virtualization.

No difference to ATS for conventional PCIe. Sure you need to do your securi=
ty
checks. That's standard stuff. See what Lukas has been working on for last =
few
years around CMA + the bits of relevant confidential compute that are actua=
lly
useful for non CoCo usecases.

>=20
>=20
> >> check those TLP ATS packets as well, spoiling the ATS advantage. Note =
=20
> > Yes, AMD IOMMU has the secure ATS support, but as you said, it is pretty
> > straight-forward, basically just check every translated request when
> > enabled.

Interesting approach. I'd not noticed that before.

There are other solutions that keep enough tracking data in host to verify
translated requests are fine but if you've checked the device, none of that
should be needed.

> > =20
> >> this is
> >> PCIe, so CXL.io will likely keep the functionality, but CXL.cache oper=
ations
> >> follow another path with apparently no further control to enforce the =
right
> >> addresses within the allowed memory ranges per device are used.
> >>
> >> Because this apparently lack of security for IOMMU and CXL.cache, this
> >> implies a
> >> CXL device should not be used by VMs or any other user space controlled
> >> driver
> >> with CXL.cache being enabled. This seems a really serious limitation, =
so
> >> maybe
> >> I'm missing something here.
> >> =20
> > I think at least for CXL path, IOMMU should have the similar mechanism =
like
> > secure ATS, and let the user to choose if they want it to be enabled or
> > not.
> >
> > In reality, many CSP design the HW by themselves and trust their HW won=
't
> > do messy things, they may want to enable it only on the 3rd party HW.

Exactly.  They do a lot of paperwork and security audits.  These devices ha=
ve
to be in the trusted computing base to operate.

> >
> > For confidential computing world, secure ATS is mandatory, and performa=
nce
> > drop is the price of security. =20

That's a choice, but it's not the only one for confidential compute
and from my recollection of other CoCo solutions they don't all do
this.

>=20
>=20
> We can let the user to choose ... but in the virtualization world the=20
> provider does not want the user to choose ... and if CXL.cache is like=20
> DMAs without IOMMU, I would say this is a really good reason.

Just require appropriate attestation. That's a userspace policy (see
Lukas' series) + the one Dan has for confidential compute.

>=20
>=20
> >> Regarding virtualization, assuming the security problems do not exist =
or
> >> will be
> >> solved, while CXL.mem can be supported with an ahead mapping by the
> >> Host, with
> >> CXL.cache this needs to be handled when the related driver asks for sp=
ecific
> >> memory to access, and then to configure the IOMMU/ATS tables by the
> >> Host. This
> >> implies the emulation needs a backend, what an ahead mapping, as curre=
ntly
> >> proposed for CXL.mem can avoid.
> >>
> >> Finally, if my concerns about the security of CXL.cache with IOMMU are
> >> unfounded, at least this document should describe how is this solved a=
nd the
> >> security enforced by the hardware, and if the kernel requires to handl=
e it
> >> specifically (what I really think is the case, at least with IOMMU cha=
nges
> >> managed by the CXL core).

It's an implementation specific question. If you are selling a device that
uses cxl.cache, expect to do a lot of paperwork and security audits + proba=
bly
reveal a lot of implementation details to you major customers.

We should expose policy control to host userspace and provide it all the re=
levant
information.  I'm not yet convinced this has anything to do with DMA mappin=
g or
the IOMMU core code.  There might be some advantages in locking down access=
es
via CXL.io vs CXL.cache for some IOMMU designs but my understanding is that=
 is
not a universal thing at all.  If userspace says accept the device after do=
ing
all the certs etc are checked then it is part of the trusted compute base a=
nd
there will not need to be anything in the IOMMU page tables that is unique
to this.

> >>
> >>
> >> Summary
> >> =3D=3D=3D=3D=3D=3D
> >>
> >>
> >> Next the proposed tasks to perform for supporting CXL.cache:
> >>
> >>   =A0=A0=A0=A0=A0=A0=A0 - CXL core handling per device CXL.cache enabl=
ing based on CXL Root
> >>   =A0=A0=A0=A0=A0=A0=A0=A0=A0 Complex snoop cache state.

Agreed.

> >>
> >>   =A0=A0=A0=A0=A0=A0=A0 - CXL core implementing a CXL.cache host memor=
y allocation
> >> restricting
> >>   =A0=A0=A0=A0=A0=A0=A0=A0=A0 the physical memory a a device can acces=
s to through CXL.cache.

No on this one. It's a broken solution to a potential hardware solution.

> >>
> >>   =A0=A0=A0=A0=A0=A0=A0 - IOMMU being CXL aware and dealing with CXL.c=
ache vs CXL.io
> >> requests.

Not required in general. May be required for some host IOMMU architectures.
So we may need some hooks.

> >>
> >>   =A0=A0=A0=A0=A0=A0=A0 - Clarify CXL.cache and security with IOMMU.


Standard device security flows.  Policy for what counts as 'secure' may
be tighter, but it's no different to flows for PCIe devices in general.
Bring them into your TCB.

Jonathan

> >>
> >>
> >> =20
>=20
>=20

