Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072963E6DC3
	for <linux-cxl@vger.kernel.org>; Thu,  4 Jun 2026 10:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780569275; cv=none; b=TwvGhR2w79ygnzRkyc1A2wBNYIDP3Rt+kZ++PVBcDfGzbTL5oO5Ma+CcvT5qKRmeuus5AR0GJmZGxAhsrlAo/PUcWy2TcVRL1xFH0QXUPxHqIXEk4NfodAbdKbAciHCP4b0BFB4Q2+MYnfmXgy9bVYptyUXNgHaF3uhcHMBus0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780569275; c=relaxed/simple;
	bh=0A7h9k44+++c05aCY4Ey+CrLJJKaAwYh+sd8Gwo0Dc0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pBvd043NBSL3BqGeBVJFTRwIahZLFhkFojpWTQIdPyLx/a+AJUjkApzL7XxE+PvAwPHxjlxrTQY2wc7GWFZxroHzMfKr037weTRpJfQoXK5LLZKgd0TsHIKW2Yn9vbc/mJaCYQflyG4iyKv2HZgmSNb3ABum0EHikOn530jXt8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gdZSZNrS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gdZSZNrS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B7321F00898;
	Thu,  4 Jun 2026 10:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780569273;
	bh=3MorWzOwcqPnO9EIzhLpcQwjoiJQNzP3FzM6U0l6wt8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gdZSZNrSKJAP4dZgDq231Ult83At18PGIU024sl8iyJPFE4t9u4F6ot9qtglQSzHE
	 uQ094JsJt+G+dC2hotj4nStDj4xhQeg8Y2/qNN+rPe+H8zdrP6pKdS4aLH7zMwe4hv
	 Znj18So/X4fcYay1PwLfngNePD6H0l+z5yiiY84l8KuGpkz3JmjtGxwnVVisx44svx
	 AzUMB9QBHgViQcSfsrTRvclieZRv7qHvTbRzepEqGIfO3Ri/1eG/mbDjNawsfVGZaY
	 DnWIcpy05tWeTBjLWxCiKVU8L/9Y+qvJvuYZcOZpFfrwPIBJ9eDaXbzPCy9TIwW9uY
	 c8VIvU0yDcpbQ==
Date: Thu, 4 Jun 2026 11:34:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: linux-cxl@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [PATCH 4/4] hw/cxl: Add per-capability CXL Fixed Memory Window
 restriction flags
Message-ID: <20260604113426.206c4d39@jic23-huawei>
In-Reply-To: <20260602231806.2469011-5-dave@stgolabs.net>
References: <20260602231806.2469011-1-dave@stgolabs.net>
	<20260602231806.2469011-5-dave@stgolabs.net>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  2 Jun 2026 16:18:06 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> Expose the CFMWS Window Restrictions as named per-capability machine
> properties (device-coherent, host-only, volatile, persistent,
> fixed-config, back-invalidate), making the advertised restrictions
> configurable per window.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Hi Davidlohr, looks good in general.

Maybe I need more coffee but I don't thing the documented constraints
are exactly the same as the ones in the code.

Thanks again for doing this!

Jonathan

> ---
>  docs/system/devices/cxl.rst | 13 +++------
>  hw/acpi/cxl.c               |  2 +-
>  hw/cxl/cxl-host.c           | 55 +++++++++++++++++++++++++++++++++++++
>  include/hw/cxl/cxl.h        | 12 ++++++++
>  qapi/machine.json           | 29 +++++++++++++++++++
>  5 files changed, 101 insertions(+), 10 deletions(-)
> 
> diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
> index 9d0771cdfd73..cf3f2c81785c 100644
> --- a/docs/system/devices/cxl.rst
> +++ b/docs/system/devices/cxl.rst
> @@ -384,15 +384,14 @@ An example of 4 devices below a switch suitable for 1, 2 or 4 way interleave::
>    -device cxl-type3,bus=swport3,persistent-memdev=cxl-mem3,lsa=cxl-lsa3,id=cxl-pmem3,sn=0x4 \
>    -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k
>  
> -An example of 4 type3 devices with volatile memory below a switch. Two of the devices
> -use HDM-DB for coherence, which requires operating in Flit mode::
> +An example of 2 type3 devices with volatile memory below a switch. The devices
> +use HDM-DB for coherence, which requires operating in Flit mode and a CXL window
> +configured to permit device-coherent Back-Invalidate model::

Thanks for doing this!.  I wonder if the example should gain a second FMW to accommodate
the original mixed device config. I'm fairly sure that should work and good to indicate
that the mixed case is real.

>  
>    qemu-system-x86_64 -M q35,cxl=on -m 4G,maxmem=8G,slots=8 -smp 4 \
>    ...
>    -object memory-backend-ram,id=cxl-mem0,share=on,size=256M \
>    -object memory-backend-ram,id=cxl-mem1,share=on,size=256M \
> -  -object memory-backend-ram,id=cxl-mem2,share=on,size=256M \
> -  -object memory-backend-ram,id=cxl-mem3,share=on,size=256M \
>    -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
>    -device cxl-rp,port=0,bus=cxl.1,id=root_port0,chassis=0,slot=0 \
>    -device cxl-rp,port=1,bus=cxl.1,id=root_port1,chassis=0,slot=1 \
> @@ -401,11 +400,7 @@ use HDM-DB for coherence, which requires operating in Flit mode::
>    -device cxl-type3,bus=swport0,volatile-memdev=cxl-mem0,id=cxl-mem0,sn=0x1,x-256b-flit=on,hdm-db=on \
>    -device cxl-downstream,port=1,bus=us0,id=swport1,chassis=0,slot=5 \
>    -device cxl-type3,bus=swport1,volatile-memdev=cxl-mem1,id=cxl-mem1,sn=0x2,x-256b-flit=on,hdm-db=on \
> -  -device cxl-downstream,port=2,bus=us0,id=swport2,chassis=0,slot=6 \
> -  -device cxl-type3,bus=swport2,volatile-memdev=cxl-mem2,id=cxl-mem2,sn=0x3 \
> -  -device cxl-downstream,port=3,bus=us0,id=swport3,chassis=0,slot=7 \
> -  -device cxl-type3,bus=swport3,volatile-memdev=cxl-mem3,id=cxl-mem3,sn=0x4 \
> -  -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k
> +  -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k,cxl-fmw.0.back-invalidate=on
>  
>  A simple arm/virt example featuring a single direct connected CXL Type 3
>  Volatile Memory device::
> diff --git a/hw/acpi/cxl.c b/hw/acpi/cxl.c
> index 5ce5e8e083ba..77c1db6561b4 100644
> --- a/hw/acpi/cxl.c
> +++ b/hw/acpi/cxl.c
> @@ -172,7 +172,7 @@ static void cedt_build_cfmws(CXLFixedWindow *fw, Aml *cedt)
>      build_append_int_noprefix(table_data, fw->enc_int_gran, 4);
>  
>      /* Window Restrictions */
> -    build_append_int_noprefix(table_data, 0xe, 2);
> +    build_append_int_noprefix(table_data, fw->restrictions, 2);
>  
>      /* QTG ID */
>      build_append_int_noprefix(table_data, 0, 2);
> diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
> index f3479b19914f..7af431bf1555 100644
> --- a/hw/cxl/cxl-host.c
> +++ b/hw/cxl/cxl-host.c
> @@ -61,6 +61,61 @@ static void cxl_fixed_memory_window_config(CXLFixedMemoryWindowOptions *object,
>          fw->enc_int_gran = 0;
>      }
>  
> +    if (object->device_coherent) {
> +        fw->restrictions |= CXL_FMW_DEVICE_COHERENT;
> +    }
> +    if (object->back_invalidate) {
> +        if (object->has_device_coherent && !object->device_coherent) {
> +            error_setg(errp, "CFMW BI requires device-coherent");
> +            return;
> +        }
> +        fw->restrictions |= CXL_FMW_DEVICE_COHERENT | CXL_FMW_BI;
> +    }
> +    if (object->host_only) {
> +        fw->restrictions |= CXL_FMW_HOST_ONLY;
> +    } else if (!object->has_host_only &&
> +               !(fw->restrictions & CXL_FMW_DEVICE_COHERENT)) {
> +        /* host-only coherent is the default when no model is requested. */
> +        fw->restrictions |= CXL_FMW_HOST_ONLY;
> +    }
> +
> +    if (!(fw->restrictions & (CXL_FMW_DEVICE_COHERENT | CXL_FMW_HOST_ONLY))) {
> +        error_setg(errp, "CFMW coherency model required");
> +        return;
> +    }
> +
> +    /*
> +     * Reject the undefined and conflicting coherency combinations,
> +     * per CXL r4.0 9.18.1.3.
> +     */
> +    if ((fw->restrictions & CXL_FMW_HOST_ONLY) &&
> +        (fw->restrictions & CXL_FMW_BI)) {
> +        error_setg(errp, "CFMW host-only coherency + BI is undefined behavior");
> +        return;
> +    }
> +    if ((fw->restrictions & CXL_FMW_DEVICE_COHERENT) &&
> +        (fw->restrictions & CXL_FMW_HOST_ONLY)) {
> +        error_setg(errp,
> +                   "CFMW device and host-only coherency are mutually exclusive");

I'm confused. I thought this one was allowed by the spec?  Without a spec
clarification I'm reluctant to prevent it.


> +        return;
> +    }
> +
> +    if (object->fixed_config) {
> +        fw->restrictions |= CXL_FMW_FIXED_CONFIG; /* no-op */
> +    }
> +
> +    /* Volatile and persistent are permitted unless explicitly disabled. */
> +    if (!object->has_q_volatile || object->q_volatile) {
> +        fw->restrictions |= CXL_FMW_VOLATILE;
> +    }
> +    if (!object->has_persistent || object->persistent) {
> +        fw->restrictions |= CXL_FMW_PERSISTENT;
> +    }
> +    if (!(fw->restrictions & (CXL_FMW_VOLATILE | CXL_FMW_PERSISTENT))) {
> +        error_setg(errp, "CFMW volatile and/or persistent memory required");
> +        return;
> +    }
> +
>      fw->targets = g_malloc0_n(fw->num_targets, sizeof(*fw->targets));
>      for (i = 0, target = object->targets; target; i++, target = target->next) {
>          /* This link cannot be resolved yet, so stash the name for now */

> diff --git a/qapi/machine.json b/qapi/machine.json
> index 685e4e29b87d..a5be531403a1 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -551,15 +551,44 @@
>  #     accesses will go to a given interleave target.  Accepted values
>  #     [256, 512, 1k, 2k, 4k, 8k, 16k]
>  #
> +# @device-coherent: Window permits device-coherent (minimally HDM-D)
> +#     accesses.  (since 11.0)

Will be at least 11.1 as that's the cycle we are in now I think.

> +#
> +# @host-only: Window permits host-only coherent (HDM-H) accesses.
> +#     (since 11.0)
> +#
> +# @volatile: Window permits volatile memory.  (since 11.0)
> +#
> +# @persistent: Window permits persistent memory.  (since 11.0)
> +#
> +# @fixed-config: Window has a fixed device configuration.  Advertised
> +#     in the CEDT only; not otherwise emulated.  (since 11.0)
> +#
> +# @back-invalidate: Window permits Back-Invalidate (HDM-DB).  Implies
> +#     @device-coherent.  (since 11.0)
If I read the code above right you check for device coherent. So
I'd argue, should say Requires @device_coherent.

> +#
>  # @targets: Target root bridge IDs from -device ...,id=<ID> for each
>  #     root bridge.
>  #
> +# Coherency defaults to host-only coherent; request a device model
> +# with @device-coherent or @back-invalidate instead.  @volatile and

@device-coherent and/or @back-invalidate instead.

> +# @persistent are permitted unless set to false, and at least one is
> +# required.  Clearing @host-only with no device model is rejected, as
> +# are host-only coherent + back-invalidate and device-coherent +
> +# host-only coherent.
> +#
>  # Since: 7.1
>  ##
>  { 'struct': 'CXLFixedMemoryWindowOptions',
>    'data': {
>        'size': 'size',
>        '*interleave-granularity': 'size',
> +      '*device-coherent': 'bool',
> +      '*host-only': 'bool',
> +      '*volatile': 'bool',
> +      '*persistent': 'bool',
> +      '*fixed-config': 'bool',
> +      '*back-invalidate': 'bool',
>        'targets': ['str'] }}
>  
>  ##

