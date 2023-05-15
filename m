Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A6EC77B75
	for <linux-cxl@archiver.kernel.org>; Mon, 15 May 2023 16:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238267AbjEOQSP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 15 May 2023 12:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242482AbjEOQSO (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 15 May 2023 12:18:14 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE17E67
        for <linux-cxl@vger.kernel.org>; Mon, 15 May 2023 09:18:11 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QKkzD14Ksz67DYv;
        Tue, 16 May 2023 00:17:12 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 15 May
 2023 17:18:08 +0100
Date:   Mon, 15 May 2023 17:18:07 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Gregory Price <gregory.price@memverge.com>
CC:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        Vincent Hache <vhache@rambus.com>, Fan Ni <fan.ni@samsung.com>
Subject: Re: [RFC] cxl: Multi-headed device design
Message-ID: <20230515171807.00006d8f@Huawei.com>
In-Reply-To: <ZBpe6btfLuuAS35g@memverge.com>
References: <ZBpe6btfLuuAS35g@memverge.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 21 Mar 2023 21:50:33 -0400
Gregory Price <gregory.price@memverge.com> wrote:

Hi Gregory,

Sorry I took so long to reply to this. Busy month...

Vince presented at LSF-MM so I feel it's fair game to CC him kernel
patches and he may be able to point you in right direction for a few
things in this mail.


> Originally I was planning to kick this off with a patch set, but i've
> decided my current prototype does not fit the extensibility requirements
> to go from SLD to MH-SLD to MH-MLD.
> 
> 
> So instead I'd like to kick off by just discussing the data structures
> and laugh/cry a bit about some of the frustrating ambiguities for MH-SLDs
> when it comes to the specification.
> 
> I apologize for the sheer length of this email, but it really is just
> that complex.

hehe.  I read this far when you first sent it and decided to put
it on the todo list rather than reading the rest ;)

> 
> 
> =============================================================
>  What does the specification say about Multi-headed Devices? 
> =============================================================
> 
> Defining each relevant component according to the specification:
> 
> >
> > VCS - Virtual CXL Switch
> > * Includes entities within the physical switch belonging to a
> >   single VH. It is identified using the VCS ID.
> > 
> > 
> > VH - Virtual Hierarchy.
> > * Everything from the CXL RP down.
> > 
> > 
> > LD - Logical Device
> > * Entity that represents a CXL Endpoint that is bound to a VCS.
> >   An SLD device contains one LD.  An MLD contains multiple LDs.
> > 
> > 
> > SLD - Single Logical Device
> > * That's it, that's the definition.
> > 
> > 
> > MLD - Multi Logical Device
> > * Multi-Logical Device. CXL component that contains multiple LDs,
> >   out of which one LD is reserved for configuration via the FM API,
> >   and each remaining LD is suitable for assignment to a different
> >   host. Currently MLDs are architected only for Type 3 LDs.
> > 
> > 
> > MH-SLD - Mutli-Headed SLD
> > * CXL component that contains multiple CXL ports, each presenting an
> >   SLD. The ports must correctly operate when connected to any
> >   combination of common or different hosts.
> > 
> > 
> > MH-MLD - Multi-Headed MLD
> > * CXL component that contains multiple CXL ports, each presenting an MLD
> >   or SLD. The ports must correctly operate when connected to any
> >   combination of common or different hosts. The FM-API is used to
> >   configure each LD as well as the overall MH-MLD.
> > 
> >   MH-MLDs are considered a specialized type of MLD and, as such, are
> >   subject to all functional and behavioral requirements of MLDs.
> >   
> 
> Ambiguity #1:
> 
> * An SLD contains 1 Logical Device.
> * An MH-SLD presents multiple SLDs, one per head.
> 
> Ergo an MH-SLD contains multiple LDs which makes it an MLD according to the
> definition of LD, but not according to the definition of MLD, or MH-MLD.

I'd go with 'sort of'.  SLD is a presentation of a device to a host.
It can be a normal single headed MLD that has been plugged directly into a host.

So for extra fun points you can have one MH-MLD that has some ports connected
to switches and other directly to hosts. Thus it can present as SLD on some
upstream ports and as MLD on others.

> 
> Now is the winter of my discontent.
> 
> The Specification says this about MH-SLD's in other sections
> 
> > 2.4.3 Pooled and Shared FAM
> > 
> > LD-FAM includes several device variants.
> > 
> > A multi-headed Single Logical Device (MH-SLD) exposes multiple LDs, each with
> > a dedicated link.
> > 
> >
> > 2.5 Multi-Headed Device
> > 
> > There are two types of Multi-Headed Devices that are distinguied by how
> > they present themselves on each head:
> > *  MH-SLD, which present SLDs on all head
> > *  MH-MLD, which may present MLDs on any of their heads

Yup. MH-SLD is the cheap device - not capable of MLD support to any upstream
port - so it can skip some functionality.

> >
> >
> > Management of heads in Multi-Headed Devices follows the model defined for
> > the device presented by that head:
> > *  Heads that present SLDs may support the port management and control
> >     features that are available for SLDs
> > *  Heads that present MLDs may support the port management and control
> >    features that are available for MLDs
> >  
> 
> I want to make very close note of this.  SLD's are managed like SLDs
> SLDs, MLDs are managed like MLDs.  MH-SLDs, according to this, should be
> managed like SLDs from the perspective of each host.

True, but an MH-MLD device connected directly to a host will also 
be managed (at some level anyway) as an SLD on that particular port.

> 
> That's pretty straight forward.
> 
> >
> > Management of memory resources in Multi-Headed Devices follows the model
> > defined for MLD components because both MH-SLDs and MH-MLDs must support
> > the isolation of memory resources, state, context, and management on a
> > per-LD basis.  LDs within the device are mapped to a single head.
> > 
> > *  In MH-SLDs, there is a 1:1 mapping between heads and LDs.
> > *  In MH-MLDs, multiple LDs are mapped to at most one head.
> > 
> > 
> > Multi-Headed Devices expose a dedicated Component Command Interface (CCI),
> > the LD Pool CCI, for management of all LDs within the device. The LD Pool
> > CCI may be exposed as an MCTP-based CCI or can be accessed via the Tunnel
> > Management Command command through a head’s Mailbox CCI, as detailed in
> > Section 7.6.7.3.1.  
> 
> 2.5.1 continues on to describe "LD Management in MH-MLDs" but just ignores
> that MH-SLDs (may) exist.  That's frustrating to say the least, but I
> suppose we can gather from context that MH-SLD's *MAY NOT* have LD
> management controls.

Hmm. In theory you could have an MH-SLD that used a config from flash or similar
but that would be odd.  We need some level of dynamic control to make these
devices useful.  Doesn't mean the spec should exclude dumb devices, but
we shouldn't concentrate on them for emulation.

One possible usecase would be a device that always shares all it's memory on
all ports. Yuk.


> 
> Lets see if that assumption holds.
> 
> > 7.6.7.3 MLD Port Command Set
> >
> > 7.6.7.3.1 Tunnel Management Command (Opcode 5300h)  
> 
> The referenced section at the end of 2.5 seems to also suggest that
> MH-SLDs do not (or don't have to?) implement the tunnel management
> command set.  It sends us to the MLD command set, and SLDs don't get
> managed like MLDs - ergo it's not relevant?
> 
> The final mention of MH-SLDs is mentioned in section 9.13.3
> 
> > 9.13.3 Dynamic Capacity Device
> > ...
> >  MH-SLD or MH-MLD based DCD shall forcefully release shared Dynamic
> >  Capacity associated with all associated hosts upon a Conventional Reset
> >  of a head.
> >  
> 
> From this we can gather that the specification foresaw someone making a
> memory pool from an MH-SLD... but without LD management. We can fill in
> some blanks and assume that if someone wanted to, they could make a
> shared memory device and implement pooling via software controls.

When you say software controls?  I'm not sure I follow. 
> 
> That'd be a neat bodge/hack.  But that's not important right now.
> 
Fair enough. Moving on.

> 
> Finally, we look at what the mailbox command-set requirements are for
> multi-headed devices:
> 
> > 7.6.7.5 Multi-Headed Device Command Set
> > The Multi-Headed device command set includes commands for querying the
> > Head-to-LD mapping in a Multi-Headed device. Support for this command
> > set is required on the LD Pool CCI of a Multi-Headed device.
> >  
> 
> Ambiguity #2: Ok, now we're not sure whether an MH-SLD is supposed to
> expose an LD Pool CCI or not.  Also, is a MH-SLD supposed to show up
> as something other than just an SLD?  This is really confusing.
> 
> Going back to the MLD Port Command set, we see
> 
> > Valid targets for the tunneled commands include switch MLD Ports,
> > valid LDs within an MLD, and the LD Pool CCI in a Multi-Headed device.  
> 
> Whatever the case, there's only a single command in the MHD command set:
> 
> > 7.6.7.5.1 Get Multi-Headed Info (Opcode 5500h)  
> 
> This command is pretty straight forward, it just tells you what the head
> to LD mapping is for each of the LDs in the device.  Presumably this is
> what gets modified by the FM-APIs when LDs are attached to VCS ports.
> 
> For the simplest MH-SLD device, these fields would be immutable, and
> there would be a single LD for each head, where head_id == ld_id.

Agreed.

> 
> 
> 
> So summarizing, what I took away from this was the following:
> 
> In the simplest form of MH-SLD, there's is neither a switch, nor is
> thereo LD management.  So, presumably, we don't HAVE to implement the
> MHD commands to say we "have MH-SLD support".

Whilst theoretically possible - I don' think such a device is interesting.
Minimum I'd want to see is something with multiple upstream SLD ports
and a management LD with appropriate interface to poke it.

The MLD side of things is interesting only once we support MLDs in general
in QEMU CXL emulation and even then they are near invisible to a host
and are more interesting for emulating fabric management.

What you may want to do is take Fan's work on DCD and look at doing
a simple MH-SLD device that uses same cheat of just using QMP commands
to do the configuration.  That's an intermediate step to us getting
the FM-API and similar commands implemented.

> 
> 
> ========
>  Design
> ========
> 
> Ok... that's a lot to break down.  Here's what I think the roadmap
> toward multi-headed multi-logical device support should look like:
> 
> 1. SLD - we have this.  This is struct CXLType3Dev

We could look at Switch + MLD after this, but lots of work to
get the FM-API stuff in place that makes that interesting.
The advantage being we'd have the ability to move LDs around that I
think you are interested in.

> 
> 2. MH-SLD No Switch, No Pool CCI.

I'd fiddle that a little.  To be useful it needs the functionality
that a pool CCI provides - something to change the confirmation, but
that can be impdef - (QMP stuff like Fan Ni did for DCD).
I'm not sure we want to upstream the QMP side of things but it gives
a path to start messing around iwth this quicker.

> 
> 3. MH-SLD w/ Pool CCI  (Implementing only Get Multi-Headed Info)

I'd do this + DCD.

> 
> 4. MH-SLD w/ Switch (Implementing remap-ability of LD to Head)

Hmm. You want this for migration I guess.  I'd be tempted to jump
directly to DCD.  I'm not even sure if the spec really allows this
sort of remapping with out a switch / MHD because DCD covers that gap.

> 
> 5. MH-MLD - the whole kit and kaboodle.
> 
> 
> Lets talk about what the first MH-SLD might look like.
> 
> 
> =================================
> 2. MH-SLD No Switch, No Pool CCI.
> =================================
> 
> 1. The device has a "memory pool" that "backs" each Logical Device, and
>    the specification does not limit whether this memory is discrete
>    or may be shared between heads.
> 
>    In QEMU, we can represent this with a shared or file memory backend:
> 
> -object memory-backend-file,id=mem0,mem-path=/tmp/mem0,size=4G,share=true
> 
> 
> 2. Each QEMU instance has a discrete SLD that amounts to its own private
>    CXLType3Dev.  However, each "Head" maps back to the same common
>    memory backend:
> 
> -device cxl-type3,bus=rp0,volatile-memdev=mem0,id=cxl-mem0
> 
> 
> And that's it.  In fact, you can do this now, no changes needed!
> 
> 
> But it's also not very useful.  You can only use the memory in devdax
> mode, since it's a shared memory region. You could already do this via
> the /dev/shm interface, so it's not even new functionality.
> 
> In theory you could build a pooling service in software-only on top of
> memory blocks. That's an exercise left to the reader.

Yeah. Let's not do this step.

> 
> 
> ================================================================
> 3. MH-SLD w/ Pool CCI  (Implementing only Get Multi-Headed Info)
> ================================================================
> 
> This is a little more complicated, we have our first bit of shared
> state.  Originally I had considered a shared memory region in
> CXLType3Dev, but this is a backwards abstraction (A MH-SLD contains
> mutliple SLDs, an SLD does not contain an MHD State).


> 
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 7b72345079..1a9f2708e1 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -356,16 +356,6 @@ typedef struct CXLPoison {
>  typedef QLIST_HEAD(, CXLPoison) CXLPoisonList;
>  #define CXL_POISON_LIST_LIMIT 256
> 
> +struct CXLMHDState {
> +    uint8_t nr_heads;
> +    uint8_t nr_lds;
> +    uint8_t ldmap[];
> +};
> +
>  struct CXLType3Dev {
>      /* Private */
>      PCIDevice parent_obj;
> @@ -377,15 +367,6 @@ struct CXLType3Dev {
>      HostMemoryBackend *lsa;
>      uint64_t sn;
> 
> +
> +    /* Multi-headed device settings */
> +    struct {
> +        bool active;
> +        uint32_t headid;
> +        uint32_t shmid;
> +        struct CXLMHDState *state;
> +    } mhd;
> +
> 
> 
> The way you would instantiate this would be a via a separate process
> that initializes the shared memory region:
> 
> shmid1=`ipcmk -M 4096 | grep -o -E '[0-9]+' | head -1`
> ./cxl_mhd_init 4 $shmid1
> -device cxl-type3,bus=rp0,volatile-memdev=mem0,id=cxl-mem0,mhd=true,mhd_head=0,mhd_shmid=$1
> 
> ./cxl_mhd_init would simply setup the nr_heads/lds field and such
> and set ldmap[0-3] to the values [0-3].  i.e. the head-to-ld mappings
> are static (head_id==ld_id).
> 
> 
> 
> But like I said, this is a backwards abstraction, so realistically we
> should flip this around such that we have the following:
> 
> struct CXLMHD_SharedState {
> 	uint8_t nr_heads;
> 	uint8_t nr_lds;
> 	uint8_t ldmap[];
> };
> 
> struct CXLMH_SLD {
> 	uint32_t headid;
> 	uint32_t shmid;
> 	struct CXLMHD_SharedState *state;
> 	struct CXLType3Dev sld;
> };
> 
> The shared state would be instantiated the same way as above.
> 
> With this we'd basically just create a new memory device:
> 
> hw/mem/cxl_mh_sld.c
> 
> 
> This is pretty straightforward - we just expose some of cxl_type3.c
> functions in order to instantiate the device accordingly, the rest of it
> just becomes passthrough because... it's just a cxl_type3.c device.
> 
> 
> This ultimately manifests as:
> 
> shmid1=`ipcmk -M 4096 | grep -o -E '[0-9]+' | head -1`
> 
> ./cxl_mhd_init 4 $shmid1
> 
> -device cxl-mhd-sld,bus=rp0,volatile-memdev=mem0,id=cxl-mem0,mhd_head=0,mhd_shmid=shmid
> 
> 
> Note: This is the patch set i'm working towards, but I presume there
> might be some (strong) opinions, so i didn't want to get too far into
> development before posting this.

Key here is that what is actually interesting is MH-SLD with Dynamic Capacity,
not just sharing the whole mapped memory.  That gives us the flexibility to
move memory between heads.

A few different moving parts are needed and I think we'd end up with something that
looks like

-device cxl-mhd,volatile-memdev=mem0,id=backend
-device cxl-mhd-sld,mhd=backend,bus=rp0,mhd-head=0,id=dev1,tunnel=true
-device cxl-mhd-sld,mhd=backend,bus=rp1,mhd-head=1,id=dev2

dev1 provides the tunneling interface, but the actual implementation of
the pool CCI and actual memory mappings is in the backend. Note that backend
might be proxy to an external process, or a client/server approach between multiple
QEMU instances.

The Pool CCI is accessed via tunnel from dev1 and can both query everything about
the two heads and also perform DCD capacity add / release on the LDs. That can
potentially include shared capacity and all the other bells and whistles we get
doing DCD on an MLD device.

or squish some parts and make a more extensible type3 device and have.

-device cxl-type3,volatile-memdev=mem0,bus=rp0,mhd-head=0,id=dev1,mhd-main=true
-device cxl-type3,mhd=dev1,bus=rp1,mhd-head=1,id=dev2

Possibly adding socket numbers as options if we are doing multi qemu support
(can do that later I think as long as we've thought about how to do the command
 line). 
> 
> 
> ==============================================================
> 4. MH-SLD w/ Switch (Implementing LD management in an SLD)
> ==============================================================
> 
> Is it even rational to try to build such a device?
> 
> MH-SLDs have a 1-to-1 mapping of Head:Logical Device.
> 
> Presumably each SLD maps the entirety of the "pooled" memory,
> but the specification does not state that is true.  You could, for
> example, setup each Logical Device to map to a particular portion of the
> shared/pooled memory area:

DCD is again key here.
You can't move LDs around on an MH-SLD, but5 you can move capacity around
between them using DCD.

> 
> -object memory-backend-file,id=mem0,mem-path=/tmp/mem0,size=4G,share=true
> 
> QEMU #1
> -device cxl-mhd-sld,bus=rp0,volatile-memdev=mem0,id=cxl-mem0,mhd_head=0,mhd_shmid=shmid,dpa_base=0,dpa_limit=1G
> 
> QEMU #2
> -device cxl-mhd-sld,bus=rp0,volatile-memdev=mem0,id=cxl-mem0,mhd_head=0,mhd_shmid=shmid,dpa_base=1G,dpa_limit=1G
> 
> ... and so on.
> 
> At least in theory, this would involve implementing something that
> changes which SLD is mapped to a QEMU instance - but functionally this
> is just changing the base and limit of each SLD.
> 
> It's interesting from a functional testing perspective, there's a bunch
> of CCI/Tunnel commands that could be implemented, and presumably this
> would require a separate process to manage/serialize appropriately.
> 

If this is interesting, do a normal MLD and switch first. The MHD case is
something to stack on top of that.


> =======================================
> 5. MH-MLD - the whole kit and kaboodle.
> =======================================
> 
> If we implemented MH-SLD w/ Switching, then presumably it's just on step
> further to create an MLD:
> 
> struct CXLMH_MLD {
>         uint32_t headid;
>         uint32_t shmid;
>         struct CXLMHD_SharedState *state;
>         struct CXLType3Dev ldmap[];
> };
> 
> But i'm greatly oversimplifying here.  It's much more expressive to
> describe an MLD in terms of a multi-tired switch in the QEMU topology,
> similar to what can be done right now:
> 
> -device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=12 \
> -device cxl-rp,id=rp0,port=0,bus=cxl.0,chassis=0,slot=0 \
> -device cxl-rp,id=rp1,port=1,bus=cxl.0,chassis=0,slot=1 \
> -device cxl-upstream,bus=rp0,id=us0 \
> -device cxl-downstream,port=0,bus=us0,id=swport0,chassis=0,slot=4 \
> -device cxl-downstream,port=1,bus=us0,id=swport1,chassis=0,slot=5 \
> -device cxl-type3,bus=swport0,volatile-memdev=mem0,id=cxl-mem0 \
> -M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k
> 
> 
> But in order to make this multi-headed, some amount of this state would need
> to be encapsulated in a shared memory region (or would it? I don't know, i
> haven't finished this thought experiment yet).

Someone (wherever the LD pool CCI is) needs to hold shared state.
Lots of options for that. 

> 
> 
> =====
>  FIN 
> =====
> 
> I realize this was a long.  If you made it to the end of this email,
> thank you reading my TED talk.  I greatly appreciate any comments,
> even if it's just "You've gone too deep, Gregory." ;]

:) You've only just got started.  This goes much deeper!

> 
> Regards,
> ~Gregory

To my mind there are a series of steps and questions here.

Which 'hotplug model'.
1) LD model for moving capacity
  - If doing LD model, do MLDs and configurable switches first. Needed as a step along the
    path anyway.  Deal with all the mess that brings and come back to MHD - as you note it
    only makes sense with a switch in the path, so MLDs are a subset of the functionality anyway.

2) DCD model for moving cacapcity
  - MH-SLD with a pool CCI used to do DCD operations on the LDs.  Extension of
    what Fan Ni is looking at.  He's making an SLD pretend to be a device
    where DCD makes sense - whilst still using the CXL type 3 device. We probably shouldn't
    do that without figuring out how to do an MHD-SLD - or at least a head that we intend
    to hang this new stuff off - potentially just using the existing type 3 device with
    more parameters as one of the MH-SLD heads that doesn't have the control interface and
    different parameters if it does have the tunnel to the Pool CCI.

Implementing MCTP CCI.  Probably a later step, but need to think what that looks like.
I'm thinking we proxy it through to wherever the pool CCI ends up.  Should be easy enough
if a little ugly.

So question is whether it's worth a highly modular design, or we just keep tacking
flexibility onto existing Type 3 device emulation.  These are all type 3 devices
after all ;)

Lots of fun details to hammer out.

Jonathan

