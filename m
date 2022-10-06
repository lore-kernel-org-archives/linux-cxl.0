Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B728FC4332F
	for <linux-cxl@archiver.kernel.org>; Thu,  6 Oct 2022 15:52:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbiJFPwR (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 6 Oct 2022 11:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbiJFPwP (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 6 Oct 2022 11:52:15 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B164A99C7
        for <linux-cxl@vger.kernel.org>; Thu,  6 Oct 2022 08:52:10 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id mx8so1420137qvb.8
        for <linux-cxl@vger.kernel.org>; Thu, 06 Oct 2022 08:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B2o9ZROGbxRs9xRX9MabbA1puhx8ft3d7HPuUza0guk=;
        b=RYSBceZ0muIaRCBnYmDykL9LYKu+e3R4EZPUnVaDyxdOBxLXh62ZZX+qtbXiUvB2KA
         C96dPC7tpStP1WiFf1liG1RPn/KTWcuHSG2+doC55oQXqJ8KiSYqnw5URojRZAAftvaw
         MSkn5LgBqm6qyA1eNu4xyDpRXXtUofDfiP3k2SIpNvOr2zOoVhHQq/vSlgXplZHHCqrs
         fqJ+WPPLHGuS9gwhKeGG3wBRPBc/Pg2fgJr+/mzJn+93QkHgWfFCjNcXss6oJGyv85OH
         OeMwFLZkqXbLHZ8oQFtMrGjoSy32L8bhYSMJW0HgEeUS3mXmuoOXBOxll/FgW7vdIcP1
         HdSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B2o9ZROGbxRs9xRX9MabbA1puhx8ft3d7HPuUza0guk=;
        b=gcwiGPIuwhv+5XA3PkcEdGSN87wyykcJslmWfky5IBstz2wNqs77He0hrDYrU32Mhm
         itlBNB1nPqgaOOOnSCkPehccXQS3wk93yjPIJ1yHeceXTAbN4va78/1VStLTqclG5w8J
         13DlKI6W3hQlVCP3h46qdfS605j7TfEHmf1EnNVNbcTmooAVJKFgxOzFIPbt+4eG8zeN
         Au9ILpsS6omnp/smn5wxGCJUH5Te+qNiV7+5J2DFn0f+So8j9RvHYqJYRKTnSPo8xIeY
         2RdbI4slh5NokUpQRvJq6ZUDlgL6AiAViaeMPlZZxdOTaC1cGyzNLw5i8oKeDigxM+9g
         wheA==
X-Gm-Message-State: ACrzQf3Bwbw/FJT9oyJm1pHLjiPlorPzYCCeA/QwFnW0rgW8hxzklfMD
        HtdMkmv1WRmBkurFqqnnXQ==
X-Google-Smtp-Source: AMsMyM5LE7C4YkdlkzG3xoy2DYZgeYK7gW+oqsQnxBOQpfG+wwSP7qDYn1VdRTw0dmJHUpWvBSrfsw==
X-Received: by 2002:ad4:5dee:0:b0:4ac:b757:ccd with SMTP id jn14-20020ad45dee000000b004acb7570ccdmr702228qvb.76.1665071529265;
        Thu, 06 Oct 2022 08:52:09 -0700 (PDT)
Received: from fedora (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id o15-20020a05620a22cf00b006bb78d095c5sm18201578qki.79.2022.10.06.08.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 08:52:08 -0700 (PDT)
Date:   Thu, 6 Oct 2022 11:52:06 -0400
From:   Gregory Price <gourry.memverge@gmail.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "a.manzanares@samsung.com" <a.manzanares@samsung.com>,
        Ben Widawsky <bwidawsk@kernel.org>
Subject: Re: [PATCH RFC] hw/cxl: type 3 devices can now present volatile or
 persistent memory
Message-ID: <Yz75ppPOwYCvNamy@fedora>
References: <20221006000103.49542-1-gregory.price@memverge.com>
 <20221006094557.000035ab@huawei.com>
 <20221006095007.00001271@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006095007.00001271@huawei.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Oct 06, 2022 at 09:50:07AM +0100, Jonathan Cameron wrote:
> On Thu, 6 Oct 2022 09:45:57 +0100
> Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> 
> > Great to see this.
> > 
> > Missing Signed-off by so we can't apply this (no developer certificate of
> > origin)  Probably want your from address to match that and I've no idea
> > if your fully name is Gourry (apologies if it is!)
> > 
> > +CC linux-cxl as most folks who will be interested in this hang out there
> > and are more likely to noticed it than burried on qemu-devel.
> > Also +CC some others who will be interested in this discussion.
> > 
> > Please also cc the listed CXL QEMU maintainers (myself and Ben W) - see
> > MAINTAINERS
> > 


Sorry about that, this is my literal first patch submission to the
kernel devlists ever, I'm still getting my environment set up (just
learning mutt as I type this).

Gourry is a nickname I go by, but I see pseudonyms are not particularly
welcome on the lists, so no worries.


In addition, I'm relatively new to the QEMU, CXL, and PCIe ecosystem, so
please excuse some of my ignorance of the overall state of things -
doing my best to pickup as quickly as possible.


> I forgot to ask.  How are you testing this?
> 
> One of the blockers for volatile support was that we had no means to poke
> it properly as the kernel doesn't yet support volatile capacity and
> no one has done the relevant work in EDK2 or similar to do it before the kernel boots.
> There has been some work on EDK2 support for ARM N2 FVPs from 
> Saanta Pattanayak, but not upstream eyt.
> https://lpc.events/event/16/contributions/1254/ 
> 
> Thanks,
> 
> Jonathan
>

Presently this is untested for exactly the reasons you described. I had
originally intended to shoot off a cover letter with this patch
discussing the issue, but I managed to much that up... so lets just plop
that in here:


[PATCH RFC] hw/cxl: Volatile Type-3 CXL Devices

The idea behind this patch is simple: Not all type-3 devices are
persistent memory devices, so add a simple boolean (is_pmem) to the
attributes of type-3 devices and have the mailbox-utility report memory
accordingly (persistent_capacity if is_pmem, else volatile_capacity).

In an emulated system, there isn't really a difference between the
devices except for the backing storage (file vs ram), but having an
emulation mode for each is useful for the sake of testing fabric
manager/orchestrator corner cases.

At the moment this can be tested with `cxl list` and it will show
the ram capacity as requested, instead of pmem capacity.


There are a few issues with this patch set that i'm not able to discern
the right answer to just yet, and was hoping for some input:

1) The PCI device type is set prior to realize/attributes, and is
currently still set to PCI_CLASS_STORAGE_EXPRESS.  Should this instead
be PCI_CLASS_MEMORY_CXL when presenting as a simple memory expander?


1a) If so, that means we'll probably need to make type-3 into an abstract
class of devices and explicitly create devices that represents vmem and
pmem devices separately.  That could probably be done within cxl_type3.c
since most of the code will be shared anyway.

But this is confusing, because a pmem device can be made to operate in
volatile mode... so should it ALSO be assigned as PCI_CLASS_MEMORY_CXL,
and a volatile device simply be a pmem device with persistence turned
off? Many design questions here.


1b) If not, does this have an appreciable affect on system-setup from
the perspective of the EFI/Bios? It should be possible, (see #2) to have
the EFI/bios setup memory expanders and just present them to the kernel
as additional, available memory as if more ram is simply present.



2) EDK2 sets the memory area as a reserved, and the memory is not
configured by the system as ram.  I'm fairly sure edk2 just doesn't
support this yet, but there's a chicken/egg problem.  If the device
isn't there, there's nothing to test against... if there's nothing to
test against, no one will write the support.  So I figure we should kick
start the process (probably by getting it wrong on the first go around!)



3) Upstream linux drivers haven't touched ram configurations yet.  I
just configured this with Dan Williams yesterday on IRC.  My
understanding is that it's been worked on but nothing has been
upstreamed, in part because there are only a very small set of devices
available to developers at the moment.


4) Should (is_pmem) be defaulted to 'true' (or invert and make the flag
(is_vmem)), and should pmem devices also present their memory as
volatile capacity?  I think they should, because all pmem devices should
be capable of running in a volatile mode.


> > 
> > Would it be possible to introduce this support in a fashion that allowed
> > us to transition to devices presenting both without needing a change of
> > interface?  With hindsight the memdev naming of the existing parameter is
> > less than helpful, but one path to doing this would be to allow for
> > an alternative memdev-volatile= parameter.  For now we can keep the patch
> > small by only supporting either memdev or memdev-volatile

My understanding of the current design is the the memdev backing itself
is irrelevant.  You can totally have file-memdevs backing a volatile
reagion and a ram-memdev backing a persistent region.

By adding more/alternative flags that can conflict with each other, we
will also create a boondoggle on intialization.

I had first considered making Type3Dev into an abstract device and
instantiating separate explicit pmem and vmem devices, but ultimatly
that just looked like 2 empty structures wrapping Type3Dev and setting
the internal is_pmem boolean... lol.

> > 
> > That way when we want to come along and add mixed devices later, we simply
> > enable supporting the specification of two different memory backends.
> > 
> > The tricky bit then would be to support variable capacity (devices can
> > support a region of memory which may be persistent or non persistent
> > depending on settings - see Set Partition Info).
> > 
> > So my gut feeling is we may eventually allow all of:
> > 
> > 1) single memory backend for persistent or volatile.
> > 2) two memory backends, covering a persistent region and a volatile region
> >   (likely you may want actual non volatile backend for the persistent
> >    region but not the volatile one).
> > 3) single memory backend in which we can allow for the Set Partition Info stuff
> >    to work.
> >

Seems a little odd to use two memory backends.  Of what use is it to the
software developers, it should be completely transparent to them, right?

The only thing I can think of is maybe reset mechanics for volatile
regions being set differently than persistent regions, but even then it
seems simple enough to just emulate the behavior and use a single
backing device.

> > As we move beyond just one backend that is presented as persistent we need
> > to define the interface...
> > 
> > I can think of far too many options!  Let me lay out a few for comment.
> > 
> > A) Array of memory backends, separate control of configurable size
> >    + starting persistent size, starting volatile size.
> >    Default of one memory backend gives you current non-volatile only.
> >    To get volatile only you provide one memory backend and set
> >    persistent size to 0 and volatile size to size of memory backend.
> > 
> > B) Two memory backends, (later add some trickery around presented size)
> >    memdev as defined is persistent memory (maybe we deprecate that interface
> >    and make it memdev-persistent) memdev-volatile as volatile.

I had considered this, but - at least in my head - you're describing a
multi-logical device.  The device we're looking at right now is a basic
Single-Logical Device which can be either persistent or volatile.

This goes back to my question:  Should we be designing this SLD as a
component which can slot into an MLD, or are there special features of
a MLD sub-device that aren't present on an SLD?

Basically I just don't see the need for multiple backends, as opposed to
multiple devices which are separately manageable.

If I'm misunderstanding something, please let me know.

> > 
> >    Steps to add functionality.
> >    1. Add your code to enable volatile but use 'which memdev is supplied' to
> >       act as the flag.  For now supply both is an error.
> >    2. Enable static volatile + non-volatile devices (both memdevs supplied).
> >    3. (hackish) Add a control for amount of partionable capacity.  Cheat
> >       and remove that capacity from both memdevs.  Changing partition just
> >       messes without how much of each memdev is used.  We'd need to be a little
> >       careful to ensure we wipe data etc.
> > 
> > You code mostly looks good to me so I think discussion here is going to be
> > all about the interface and how we build one more suitable for the future!
> > 
> > Jonathan
> > 
> > 
> > 
> > 

Feels like I'm 



> > >  Example command lines
> > >  ---------------------
> > > -A very simple setup with just one directly attached CXL Type 3 device::
> > > +A very simple setup with just one directly attached CXL Type 3 Persistent Memory device::
> > >  
> > >    qemu-system-aarch64 -M virt,gic-version=3,cxl=on -m 4g,maxmem=8G,slots=8 -cpu max \
> > >    ...
> > > @@ -308,7 +308,18 @@ A very simple setup with just one directly attached CXL Type 3 device::
> > >    -object memory-backend-file,id=cxl-lsa1,share=on,mem-path=/tmp/lsa.raw,size=256M \
> > >    -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
> > >    -device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
> > > -  -device cxl-type3,bus=root_port13,memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-pmem0 \
> > > +  -device cxl-type3,bus=root_port13,pmem=true,memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-pmem0 \
> > > +  -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G  
> > 
> > Can't do this as it breaks any existing setup.  If a flag makes sense (I don't think
> > it is flexible enough) then would need to be volatile so it not being present
> > will correspond to false and current situation.
> > 

this would be another reason to simply default the pmem flag to true.
It would allow existing setups to continue as-is.

I can make this swap, but i think the above discussions were more
important to get started (and why this is an RFC).



> > > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > > index bc1bb18844..3ed4dfeb69 100644
> > > --- a/hw/cxl/cxl-mailbox-utils.c
> > > +++ b/hw/cxl/cxl-mailbox-utils.c
> > > @@ -138,7 +138,7 @@ static ret_code cmd_firmware_update_get_info(struct cxl_cmd *cmd,
> > >      } QEMU_PACKED *fw_info;
> > >      QEMU_BUILD_BUG_ON(sizeof(*fw_info) != 0x50);
> > >  
> > > -    if (cxl_dstate->pmem_size < (256 << 20)) {
> > > +    if (cxl_dstate->mem_size < (256 << 20)) {  
> > 
> > Huh.  I wonder why this check is here in the first place? Looks very odd given why
> > should we be checking the memory size in a firmware update based command.
> > 
> > Probably cut and paste error long ago. 
> > 


I had actually wondered about all these 256MB alignment checks, and
whether they should actually be sunken into the device creation rather
than strewn around.  I would have to go digging through the spec to see
whether there is explicit error handling at each level if a device
presents an out-of-spec size.

Something for another patch.



> > > @@ -338,10 +340,10 @@ static void ct3_class_init(ObjectClass *oc, void *data)
> > >      pc->class_id = PCI_CLASS_STORAGE_EXPRESS;
> > >      pc->vendor_id = PCI_VENDOR_ID_INTEL;
> > >      pc->device_id = 0xd93; /* LVF for now */
> > > -    pc->revision = 1;
> > > +    pc->revision = 2;  
> > Given the driver isn't checking this and your code change isn't breaking
> > older versions I would not update the revision for this.
> > 

Will drop that from the patch
