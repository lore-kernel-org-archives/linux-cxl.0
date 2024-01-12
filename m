Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6355D8E0
	for <linux-cxl@vger.kernel.org>; Fri, 12 Jan 2024 08:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="kmAvem62"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5578485fc0eso5142649a12.1
        for <linux-cxl@vger.kernel.org>; Fri, 12 Jan 2024 00:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1705047256; x=1705652056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VKb3pXA3O7QJEj9qo6R8Br8Dqg0hH16HzN0jOTIU5CY=;
        b=kmAvem62xRtqzawnQQOaqI15wcoVqj92DAXCh0Rv6MfOzPs8rndR5I4Yutt6uGi9jk
         eIb5edVc8e92YMcnnQsdFiOPYXhc6/LNxt8ZVf5UCNHD2WiDYAXzGz/OZUqqQMsERtz3
         9a6YwW3rC0VOoSXut8mVzUwQKiYP7tiyVTcyjYaX5n2aBBIS0/ItHBoa1Q8EJR5CEcFl
         eoYxYsfyAaRHm/Czf/rf0TtMn65gNCMHFLkWASVWi6xLknItAZhb13PS6n28JeuRe3SO
         GRvMG7ujotqmMJiL0bhl0TxeNk7Rs7rN2hrvasN0MvoMxDS+7TycmKFVJxWUvJKAi7GG
         THSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705047256; x=1705652056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VKb3pXA3O7QJEj9qo6R8Br8Dqg0hH16HzN0jOTIU5CY=;
        b=pSQVM4QO7PfJsBLMz2pfd9Mfx6LlMVvuukkZ8yILIdRbeIIg2FAQMv62JPbiMw6yT+
         tJhtFXtD12SrH5bpn446IcpoqO4XCDURwo+5gjlbMNbkim0RbMnalis5eueovfxPb/FF
         fRa06YrJGqVT8Kl9FD+JanM3ERfldbGIIbqhFLGYrV2bgB/+dCuTqmjZHL1+f4g6ausL
         Dz2T3LbU1nKHfMgnHtYF1YlVZc3VMzitXxXKUrWsGplJpDjmKzszCv7c/4JNIHL8d/iN
         ZSyKiyNckVVslNnq7URC3eAPWsncwuUSzs2mRjm9IN8W8uqKmfJVn4/kPowNatR0+3di
         y17A==
X-Gm-Message-State: AOJu0YwJ9Kyw6OxL5pTaNT8LPYPtfv4+i2Vj0BWCDjLRgZtGNv1ZfcBW
	YBKngz+k2A8ufFsfuPvwkeDDYivQuKFnN6z5w1Ky2Xu1cOh+hQ==
X-Google-Smtp-Source: AGHT+IFiFE1mg3Ou42N8EKtfdnhiQN1fItrBbzyubruEBUXHkcUgv7iMSLfYfu4GiAjCUieiEfS7XXBwbT3DdXNntPk=
X-Received: by 2002:aa7:d859:0:b0:554:4dde:4ca6 with SMTP id
 f25-20020aa7d859000000b005544dde4ca6mr511278eds.4.1705047255771; Fri, 12 Jan
 2024 00:14:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87fs00njft.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <PH0PR08MB7955E9F08CCB64F23963B5C3A860A@PH0PR08MB7955.namprd08.prod.outlook.com>
 <87edezc5l1.fsf@yhuang6-desk2.ccr.corp.intel.com> <PH0PR08MB79550922630FEC47E4B4D3A3A860A@PH0PR08MB7955.namprd08.prod.outlook.com>
 <87a5pmddl5.fsf@yhuang6-desk2.ccr.corp.intel.com> <PH0PR08MB79552F35351FA57EF4BD64B4A860A@PH0PR08MB7955.namprd08.prod.outlook.com>
 <87wmspbpma.fsf@yhuang6-desk2.ccr.corp.intel.com> <ZZwrIoP9+ey7rp3C@memverge.com>
 <87o7dv897s.fsf@yhuang6-desk2.ccr.corp.intel.com> <20240109155049.00003f13@Huawei.com>
 <ZZ2Jd7/7rFD0o5S3@memverge.com> <CAAYibXhe81ez06tP5K7zGkX9P=Ot+DcSysVyDvh13aSEDD63aA@mail.gmail.com>
 <20240110141821.0000370d@Huawei.com> <CAAYibXgwqY6Og_4NqGGEni=2Xgx=DPxaMc3GdBUE6FREKVCq8w@mail.gmail.com>
 <87il3z2g03.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87il3z2g03.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Hao Xiang <hao.xiang@bytedance.com>
Date: Fri, 12 Jan 2024 00:14:04 -0800
Message-ID: <CAAYibXh5DWcAJrqXi-V1v61DY_Xeb8BiMGoOxn1fJ_YBc2L8KQ@mail.gmail.com>
Subject: Re: [External] Re: [EXT] Re: [RFC PATCH v2 0/2] Node migration
 between memory tiers
To: "Huang, Ying" <ying.huang@intel.com>
Cc: "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Gregory Price <gregory.price@memverge.com>, 
	Srinivasulu Thanneeru <sthanneeru@micron.com>, Srinivasulu Opensrc <sthanneeru.opensrc@micron.com>, 
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "mhocko@suse.com" <mhocko@suse.com>, 
	"tj@kernel.org" <tj@kernel.org>, "john@jagalactic.com" <john@jagalactic.com>, 
	Eishan Mirakhur <emirakhur@micron.com>, Vinicius Tavares Petrucci <vtavarespetr@micron.com>, 
	Ravis OpenSrc <Ravis.OpenSrc@micron.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Wei Xu <weixugc@google.com>, "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 11:02=E2=80=AFPM Huang, Ying <ying.huang@intel.com>=
 wrote:
>
> Hao Xiang <hao.xiang@bytedance.com> writes:
>
> > On Wed, Jan 10, 2024 at 6:18=E2=80=AFAM Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:
> >>
> >> On Tue, 9 Jan 2024 16:28:15 -0800
> >> Hao Xiang <hao.xiang@bytedance.com> wrote:
> >>
> >> > On Tue, Jan 9, 2024 at 9:59=E2=80=AFAM Gregory Price <gregory.price@=
memverge.com> wrote:
> >> > >
> >> > > On Tue, Jan 09, 2024 at 03:50:49PM +0000, Jonathan Cameron wrote:
> >> > > > On Tue, 09 Jan 2024 11:41:11 +0800
> >> > > > "Huang, Ying" <ying.huang@intel.com> wrote:
> >> > > > > Gregory Price <gregory.price@memverge.com> writes:
> >> > > > > > On Thu, Jan 04, 2024 at 02:05:01PM +0800, Huang, Ying wrote:
> >> > > > > It's possible to change the performance of a NUMA node changed=
, if we
> >> > > > > hot-remove a memory device, then hot-add another different mem=
ory
> >> > > > > device.  It's hoped that the CDAT changes too.
> >> > > >
> >> > > > Not supported, but ACPI has _HMA methods to in theory allow chan=
ging
> >> > > > HMAT values based on firmware notifications...  So we 'could' ma=
ke
> >> > > > it work for HMAT based description.
> >> > > >
> >> > > > Ultimately my current thinking is we'll end up emulating CXL typ=
e3
> >> > > > devices (hiding topology complexity) and you can update CDAT but
> >> > > > IIRC that is only meant to be for degraded situations - so if yo=
u
> >> > > > want multiple performance regions, CDAT should describe them for=
m the start.
> >> > > >
> >> > >
> >> > > That was my thought.  I don't think it's particularly *realistic* =
for
> >> > > HMAT/CDAT values to change at runtime, but I can imagine a case wh=
ere
> >> > > it could be valuable.
> >> > >
> >> > > > > > https://lore.kernel.org/linux-cxl/CAAYibXjZ0HSCqMrzXGv62cMLn=
cS_81R3e1uNV5Fu4CPm0zAtYw@mail.gmail.com/
> >> > > > > >
> >> > > > > > This group wants to enable passing CXL memory through to KVM=
/QEMU
> >> > > > > > (i.e. host CXL expander memory passed through to the guest),=
 and
> >> > > > > > allow the guest to apply memory tiering.
> >> > > > > >
> >> > > > > > There are multiple issues with this, presently:
> >> > > > > >
> >> > > > > > 1. The QEMU CXL virtual device is not and probably never wil=
l be
> >> > > > > >    performant enough to be a commodity class virtualization.
> >> > > >
> >> > > > I'd flex that a bit - we will end up with a solution for virtual=
ization but
> >> > > > it isn't the emulation that is there today because it's not poss=
ible to
> >> > > > emulate some of the topology in a peformant manner (interleaving=
 with sub
> >> > > > page granularity / interleaving at all (to a lesser degree)). Th=
ere are
> >> > > > ways to do better than we are today, but they start to look like
> >> > > > software dissagregated memory setups (think lots of page faults =
in the host).
> >> > > >
> >> > >
> >> > > Agreed, the emulated device as-is can't be the virtualization devi=
ce,
> >> > > but it doesn't mean it can't be the basis for it.
> >> > >
> >> > > My thought is, if you want to pass host CXL *memory* through to th=
e
> >> > > guest, you don't actually care to pass CXL *control* through to th=
e
> >> > > guest.  That control lies pretty squarely with the host/hypervisor=
.
> >> > >
> >> > > So, at least in theory, you can just cut the type3 device out of t=
he
> >> > > QEMU configuration entirely and just pass it through as a distinct=
 numa
> >> > > node with specific hmat qualities.
> >> > >
> >> > > Barring that, if we must go through the type3 device, the question=
 is
> >> > > how difficult would it be to just make a stripped down type3 devic=
e
> >> > > to provide the informational components, but hack off anything
> >> > > topology/interleave related? Then you just do direct passthrough a=
s you
> >> > > described below.
> >> > >
> >> > > qemu/kvm would report errors if you tried to touch the naughty bit=
s.
> >> > >
> >> > > The second question is... is that device "compliant" or does it ne=
ed
> >> > > super special handling from the kernel driver :D?  If what i descr=
ibed
> >> > > is not "compliant", then it's probably a bad idea, and KVM/QEMU sh=
ould
> >> > > just hide the CXL device entirely from the guest (for this use cas=
e)
> >> > > and just pass the memory through as a numa node.
> >> > >
> >> > > Which gets us back to: The memory-tiering component needs a way to
> >> > > place nodes in different tiers based on HMAT/CDAT/User Whim. All t=
hree
> >> > > of those seem like totally valid ways to go about it.
> >> > >
> >> > > > > >
> >> > > > > > 2. When passing memory through as an explicit NUMA node, but=
 not as
> >> > > > > >    part of a CXL memory device, the nodes are lumped togethe=
r in the
> >> > > > > >    DRAM tier.
> >> > > > > >
> >> > > > > > None of this has to do with firmware.
> >> > > > > >
> >> > > > > > Memory-type is an awful way of denoting membership of a tier=
, but we
> >> > > > > > have HMAT information that can be passed through via QEMU:
> >> > > > > >
> >> > > > > > -object memory-backend-ram,size=3D4G,id=3Dram-node0 \
> >> > > > > > -object memory-backend-ram,size=3D4G,id=3Dram-node1 \
> >> > > > > > -numa node,nodeid=3D0,cpus=3D0-4,memdev=3Dram-node0 \
> >> > > > > > -numa node,initiator=3D0,nodeid=3D1,memdev=3Dram-node1 \
> >> > > > > > -numa hmat-lb,initiator=3D0,target=3D0,hierarchy=3Dmemory,da=
ta-type=3Daccess-latency,latency=3D10 \
> >> > > > > > -numa hmat-lb,initiator=3D0,target=3D0,hierarchy=3Dmemory,da=
ta-type=3Daccess-bandwidth,bandwidth=3D10485760 \
> >> > > > > > -numa hmat-lb,initiator=3D0,target=3D1,hierarchy=3Dmemory,da=
ta-type=3Daccess-latency,latency=3D20 \
> >> > > > > > -numa hmat-lb,initiator=3D0,target=3D1,hierarchy=3Dmemory,da=
ta-type=3Daccess-bandwidth,bandwidth=3D5242880
> >> > > > > >
> >> > > > > > Not only would it be nice if we could change tier membership=
 based on
> >> > > > > > this data, it's realistically the only way to allow guests t=
o accomplish
> >> > > > > > memory tiering w/ KVM/QEMU and CXL memory passed through to =
the guest.
> >> > > >
> >> > > > This I fully agree with.  There will be systems with a bunch of =
normal DDR with different
> >> > > > access characteristics irrespective of CXL. + likely HMAT soluti=
ons will be used
> >> > > > before we get anything more complex in place for CXL.
> >> > > >
> >> > >
> >> > > Had not even considered this, but that's completely accurate as we=
ll.
> >> > >
> >> > > And more discretely: What of devices that don't provide HMAT/CDAT?=
 That
> >> > > isn't necessarily a violation of any standard.  There probably cou=
ld be
> >> > > a release valve for us to still make those devices useful.
> >> > >
> >> > > The concern I have with not implementing a movement mechanism *at =
all*
> >> > > is that a one-size-fits-all initial-placement heuristic feels gros=
s
> >> > > when we're, at least ideologically, moving toward "software define=
d memory".
> >> > >
> >> > > Personally I think the movement mechanism is a good idea that gets=
 folks
> >> > > where they're going sooner, and it doesn't hurt anything by existi=
ng. We
> >> > > can change the initial placement mechanism too.
> >> >
> >> > I think providing users a way to "FIX" the memory tiering is a backu=
p
> >> > option. Given that DDRs with different access characteristics provid=
e
> >> > the relevant CDAT/HMAT information, the kernel should be able to
> >> > correctly establish memory tiering on boot.
> >>
> >> Include hotplug and I'll be happier!  I know that's messy though.
> >>
> >> > Current memory tiering code has
> >> > 1) memory_tier_init() to iterate through all boot onlined memory
> >> > nodes. All nodes are assumed to be fast tier (adistance
> >> > MEMTIER_ADISTANCE_DRAM is used).
> >> > 2) dev_dax_kmem_probe to iterate through all devdax controlled memor=
y
> >> > nodes. This is the place the kernel reads the memory attributes from
> >> > HMAT and recognizes the memory nodes into the correct tier (devdax
> >> > controlled CXL, pmem, etc).
> >> > If we want DDRs with different memory characteristics to be put into
> >> > the correct tier (as in the guest VM memory tiering case), we probab=
ly
> >> > need a third path to iterate the boot onlined memory nodes and also =
be
> >> > able to read their memory attributes. I don't think we can do that i=
n
> >> > 1) because the ACPI subsystem is not yet initialized.
> >>
> >> Can we move it later in general?  Or drag HMAT parsing earlier?
> >> ACPI table availability is pretty early, it's just that we don't bothe=
r
> >> with HMAT because nothing early uses it.
> >> IIRC SRAT parsing occurs way before memory_tier_init() will be called.
> >
> > I tested the call sequence under a debugger earlier. hmat_init() is
> > called after memory_tier_init(). Let me poke around and see what our
> > options are.
>
> This sounds reasonable.
>
> Please keep in mind that we need a way to identify the base line memory
> type(default_dram_type).  A simple method is to use NUMA nodes with CPU
> attached.  But I remember that Aneesh said that some NUMA nodes without
> CPU will need to be put in default_dram_type too on their systems.  We
> need a way to identify that.

Yes, I am doing some prototyping the way you described. In
memory_tier_init(), we will just set the memory tier for the NUMA
nodes with CPU. In hmat_init(), I am trying to call back to mm to
finish the memory tier initialization for the CPUless NUMA nodes. If a
CPUless numa node can't get the effective adistance from
mt_calc_adistance(), we will fallback to add that node to
default_dram_type.
The other thing I want to experiment is to call mt_calc_adistance() on
a memory node with CPU and see what kind of adistance will be
returned.

>
> --
> Best Regards,
> Huang, Ying
