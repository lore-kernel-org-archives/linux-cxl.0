Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7312836BE
	for <linux-cxl@vger.kernel.org>; Tue, 16 Jun 2026 13:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781615922; cv=none; b=PymF/4Pu3ueoDjVilAja8IvjHUDUcJjbT9OgHsXJl6v3u+3LeLSDRuDWiDg9kiDNrjR2MfJltcZh+FLfGwGuGk8DylBA73YI3no8CZRQBoVu5zQB315sk/uzn4zxSJ0RgxkPuOMwlh5vpafLg44Y1eqrsHX0VT6osvrl0WZYogM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781615922; c=relaxed/simple;
	bh=6Ht1vp1j7ipDYCGk8SiOOr+itYayINPLrzjdfp/COVw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MiEbggPzWKff5RyCWKOlj4zqr5mq6lI/j8fit3/nUUEmlbXi3jI8cYsUk9KYyynNyGty2GWQ3NvwgHIyG8KetMRwnpoP0FauJFf5h31hBWdlWWxtfRmx/tMX0N4XyYJ5QaYe/qTocPs900hN3gXpBkieOk9TpMVzMBMePCsMM8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lHOrDkLH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lHOrDkLH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 495391F000E9;
	Tue, 16 Jun 2026 13:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781615921;
	bh=uW9mcMh7/hBtvtP2AdmPP6jmDcbzO/hzpp7mhFNBRx0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lHOrDkLHX2EB/Cg8HC86B/gAlGTFAooFJ+f2BHUW9kgfjBZ9Iwd1imbI1HvU5J9uX
	 c495OSmYvdJVvn/oGShoq87YmAXefgQRP7v9YrnU7THzOqvIqxOHEnbZpDg7gP19I5
	 DzN7dnyb1F7iSvzj/zeltcOnsUVIvvkK5bbZit+uTMxUfq/+e94EnflC8dfvU9kJ5K
	 hxVyd+8jQ+LxnoYoWMFOnQ+OpVcSTNjCPwVP49giEy73SIFu5Qp62wVntXBKsk1i9E
	 FluloenluhZ9/f/ahpLv1WXXprxYVnbPeSe4cmu2U11gT1aG1InZASmN4O/e3sEhI1
	 EW5iZOQm3cJYQ==
Date: Tue, 16 Jun 2026 14:18:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: linux-cxl@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [PATCH 4/4] hw/cxl: Add per-capability CXL Fixed Memory Window
 restriction flags
Message-ID: <20260616141834.012ad646@jic23-huawei>
In-Reply-To: <20260604154259.tq7vnnzuc74jif2m@offworld>
References: <20260602231806.2469011-1-dave@stgolabs.net>
	<20260602231806.2469011-5-dave@stgolabs.net>
	<20260604113426.206c4d39@jic23-huawei>
	<20260604154259.tq7vnnzuc74jif2m@offworld>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Jun 2026 08:42:59 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> On Thu, 04 Jun 2026, Jonathan Cameron wrote:
> 
> >On Tue,  2 Jun 2026 16:18:06 -0700
> >Davidlohr Bueso <dave@stgolabs.net> wrote:
> >  
> >> Expose the CFMWS Window Restrictions as named per-capability machine
> >> properties (device-coherent, host-only, volatile, persistent,
> >> fixed-config, back-invalidate), making the advertised restrictions
> >> configurable per window.
> >>
> >> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>  
> >Hi Davidlohr, looks good in general.
> >
> >Maybe I need more coffee but I don't thing the documented constraints
> >are exactly the same as the ones in the code.  
> 
> Sorry, I'm not sure I follow here.

Was (I think) just a reference two what I was seeing as biggest issue called
out below. Let me carry on discussion down there.

> 
> >
> >Thanks again for doing this!  
> 
> No problem, thanks for reviewing.
> 
> >
> >Jonathan
> >  
> >> ---
> >>  docs/system/devices/cxl.rst | 13 +++------
> >>  hw/acpi/cxl.c               |  2 +-
> >>  hw/cxl/cxl-host.c           | 55 +++++++++++++++++++++++++++++++++++++
> >>  include/hw/cxl/cxl.h        | 12 ++++++++
> >>  qapi/machine.json           | 29 +++++++++++++++++++
> >>  5 files changed, 101 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
> >> index 9d0771cdfd73..cf3f2c81785c 100644
> >> --- a/docs/system/devices/cxl.rst
> >> +++ b/docs/system/devices/cxl.rst
> >> @@ -384,15 +384,14 @@ An example of 4 devices below a switch suitable for 1, 2 or 4 way interleave::
> >>    -device cxl-type3,bus=swport3,persistent-memdev=cxl-mem3,lsa=cxl-lsa3,id=cxl-pmem3,sn=0x4 \
> >>    -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k
> >>
> >> -An example of 4 type3 devices with volatile memory below a switch. Two of the devices
> >> -use HDM-DB for coherence, which requires operating in Flit mode::
> >> +An example of 2 type3 devices with volatile memory below a switch. The devices
> >> +use HDM-DB for coherence, which requires operating in Flit mode and a CXL window
> >> +configured to permit device-coherent Back-Invalidate model::  
> >
> >Thanks for doing this!.  I wonder if the example should gain a second FMW to accommodate
> >the original mixed device config. I'm fairly sure that should work and good to indicate
> >that the mixed case is real.  
> 
> I can do that.
> 
> >  
> >>
> >>    qemu-system-x86_64 -M q35,cxl=on -m 4G,maxmem=8G,slots=8 -smp 4 \
> >>    ...
> >>    -object memory-backend-ram,id=cxl-mem0,share=on,size=256M \
> >>    -object memory-backend-ram,id=cxl-mem1,share=on,size=256M \
> >> -  -object memory-backend-ram,id=cxl-mem2,share=on,size=256M \
> >> -  -object memory-backend-ram,id=cxl-mem3,share=on,size=256M \
> >>    -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
> >>    -device cxl-rp,port=0,bus=cxl.1,id=root_port0,chassis=0,slot=0 \
> >>    -device cxl-rp,port=1,bus=cxl.1,id=root_port1,chassis=0,slot=1 \
> >> @@ -401,11 +400,7 @@ use HDM-DB for coherence, which requires operating in Flit mode::
> >>    -device cxl-type3,bus=swport0,volatile-memdev=cxl-mem0,id=cxl-mem0,sn=0x1,x-256b-flit=on,hdm-db=on \
> >>    -device cxl-downstream,port=1,bus=us0,id=swport1,chassis=0,slot=5 \
> >>    -device cxl-type3,bus=swport1,volatile-memdev=cxl-mem1,id=cxl-mem1,sn=0x2,x-256b-flit=on,hdm-db=on \
> >> -  -device cxl-downstream,port=2,bus=us0,id=swport2,chassis=0,slot=6 \
> >> -  -device cxl-type3,bus=swport2,volatile-memdev=cxl-mem2,id=cxl-mem2,sn=0x3 \
> >> -  -device cxl-downstream,port=3,bus=us0,id=swport3,chassis=0,slot=7 \
> >> -  -device cxl-type3,bus=swport3,volatile-memdev=cxl-mem3,id=cxl-mem3,sn=0x4 \
> >> -  -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k
> >> +  -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k,cxl-fmw.0.back-invalidate=on
> >>
> >>  A simple arm/virt example featuring a single direct connected CXL Type 3
> >>  Volatile Memory device::
> >> diff --git a/hw/acpi/cxl.c b/hw/acpi/cxl.c
> >> index 5ce5e8e083ba..77c1db6561b4 100644
> >> --- a/hw/acpi/cxl.c
> >> +++ b/hw/acpi/cxl.c
> >> @@ -172,7 +172,7 @@ static void cedt_build_cfmws(CXLFixedWindow *fw, Aml *cedt)
> >>      build_append_int_noprefix(table_data, fw->enc_int_gran, 4);
> >>
> >>      /* Window Restrictions */
> >> -    build_append_int_noprefix(table_data, 0xe, 2);
> >> +    build_append_int_noprefix(table_data, fw->restrictions, 2);
> >>
> >>      /* QTG ID */
> >>      build_append_int_noprefix(table_data, 0, 2);
> >> diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
> >> index f3479b19914f..7af431bf1555 100644
> >> --- a/hw/cxl/cxl-host.c
> >> +++ b/hw/cxl/cxl-host.c
> >> @@ -61,6 +61,61 @@ static void cxl_fixed_memory_window_config(CXLFixedMemoryWindowOptions *object,
> >>          fw->enc_int_gran = 0;
> >>      }
> >>
> >> +    if (object->device_coherent) {
> >> +        fw->restrictions |= CXL_FMW_DEVICE_COHERENT;
> >> +    }
> >> +    if (object->back_invalidate) {
> >> +        if (object->has_device_coherent && !object->device_coherent) {
> >> +            error_setg(errp, "CFMW BI requires device-coherent");
> >> +            return;
> >> +        }
> >> +        fw->restrictions |= CXL_FMW_DEVICE_COHERENT | CXL_FMW_BI;
> >> +    }
> >> +    if (object->host_only) {
> >> +        fw->restrictions |= CXL_FMW_HOST_ONLY;
> >> +    } else if (!object->has_host_only &&
> >> +               !(fw->restrictions & CXL_FMW_DEVICE_COHERENT)) {
> >> +        /* host-only coherent is the default when no model is requested. */
> >> +        fw->restrictions |= CXL_FMW_HOST_ONLY;
> >> +    }
> >> +
> >> +    if (!(fw->restrictions & (CXL_FMW_DEVICE_COHERENT | CXL_FMW_HOST_ONLY))) {
> >> +        error_setg(errp, "CFMW coherency model required");
> >> +        return;
> >> +    }
> >> +
> >> +    /*
> >> +     * Reject the undefined and conflicting coherency combinations,
> >> +     * per CXL r4.0 9.18.1.3.
> >> +     */
> >> +    if ((fw->restrictions & CXL_FMW_HOST_ONLY) &&
> >> +        (fw->restrictions & CXL_FMW_BI)) {
> >> +        error_setg(errp, "CFMW host-only coherency + BI is undefined behavior");
> >> +        return;
> >> +    }
> >> +    if ((fw->restrictions & CXL_FMW_DEVICE_COHERENT) &&
> >> +        (fw->restrictions & CXL_FMW_HOST_ONLY)) {
> >> +        error_setg(errp,
> >> +                   "CFMW device and host-only coherency are mutually exclusive");  
> >
> >I'm confused. I thought this one was allowed by the spec?  Without a spec
> >clarification I'm reluctant to prevent it.  
> 
> The text is not clear, I agree. However, per Dan's pushback in the kernel series,
> I took this as bit1 (host only) cannot be combined with anything dev coherent.
> This is also why I drop the bit0 in the default restrictions. I am fine removing
> this check here for now, but also have a kernel equivalent which fails the cfmw
> parsing if any of the above is seen (maybe the failure could be downgraded to
> a warning).

I'm not in a position to push for spec clarification on this at the moment
so whilst it remains a 'possibility' let this through here.
> 
> >  
> >> +        return;
> >> +    }
> >> +
> >> +    if (object->fixed_config) {
> >> +        fw->restrictions |= CXL_FMW_FIXED_CONFIG; /* no-op */
> >> +    }
> >> +
> >> +    /* Volatile and persistent are permitted unless explicitly disabled. */
> >> +    if (!object->has_q_volatile || object->q_volatile) {
> >> +        fw->restrictions |= CXL_FMW_VOLATILE;
> >> +    }
> >> +    if (!object->has_persistent || object->persistent) {
> >> +        fw->restrictions |= CXL_FMW_PERSISTENT;
> >> +    }
> >> +    if (!(fw->restrictions & (CXL_FMW_VOLATILE | CXL_FMW_PERSISTENT))) {
> >> +        error_setg(errp, "CFMW volatile and/or persistent memory required");
> >> +        return;
> >> +    }
> >> +
> >>      fw->targets = g_malloc0_n(fw->num_targets, sizeof(*fw->targets));
> >>      for (i = 0, target = object->targets; target; i++, target = target->next) {
> >>          /* This link cannot be resolved yet, so stash the name for now */  
> >  
> >> diff --git a/qapi/machine.json b/qapi/machine.json
> >> index 685e4e29b87d..a5be531403a1 100644
> >> --- a/qapi/machine.json
> >> +++ b/qapi/machine.json
> >> @@ -551,15 +551,44 @@

> >  
> >> +#
> >> +# @host-only: Window permits host-only coherent (HDM-H) accesses.
> >> +#     (since 11.0)
> >> +#
> >> +# @volatile: Window permits volatile memory.  (since 11.0)
> >> +#
> >> +# @persistent: Window permits persistent memory.  (since 11.0)
> >> +#
> >> +# @fixed-config: Window has a fixed device configuration.  Advertised
> >> +#     in the CEDT only; not otherwise emulated.  (since 11.0)
> >> +#
> >> +# @back-invalidate: Window permits Back-Invalidate (HDM-DB).  Implies
> >> +#     @device-coherent.  (since 11.0)  
> >If I read the code above right you check for device coherent. So
> >I'd argue, should say Requires @device_coherent.  
> 
> The intent here is to explain that we allow the user not to have to
> explicitly pass both device-coherent=on and back-invalidate=on options
> when do BI.

I think I must have read this wrong wrt to it setting it under the hood.
Maybe the checks above are about not allowing an explicit =off for device-coherent.
If so perhaps we can call that out.  Implies @device-coherent if not explicitly
configured otherwise.


> 
> +    if (object->back_invalidate) {
> +        if (object->has_device_coherent && !object->device_coherent) {
> +            error_setg(errp, "CFMW BI requires device-coherent");
> +            return;
> +        }
> +        fw->restrictions |= CXL_FMW_DEVICE_COHERENT | CXL_FMW_BI;
> +    }
> 
> >  
> >> +#
> >>  # @targets: Target root bridge IDs from -device ...,id=<ID> for each
> >>  #     root bridge.
> >>  #
> >> +# Coherency defaults to host-only coherent; request a device model
> >> +# with @device-coherent or @back-invalidate instead.  @volatile and  
> >
> >@device-coherent and/or @back-invalidate instead.  
> 
> Yes.
> 
> Thanks,
> Davidlohr
> 
> >  
> >> +# @persistent are permitted unless set to false, and at least one is
> >> +# required.  Clearing @host-only with no device model is rejected, as
> >> +# are host-only coherent + back-invalidate and device-coherent +
> >> +# host-only coherent.
> >> +#
> >>  # Since: 7.1
> >>  ##
> >>  { 'struct': 'CXLFixedMemoryWindowOptions',
> >>    'data': {
> >>        'size': 'size',
> >>        '*interleave-granularity': 'size',
> >> +      '*device-coherent': 'bool',
> >> +      '*host-only': 'bool',
> >> +      '*volatile': 'bool',
> >> +      '*persistent': 'bool',
> >> +      '*fixed-config': 'bool',
> >> +      '*back-invalidate': 'bool',
> >>        'targets': ['str'] }}
> >>
> >>  ##  
> >  
> 

