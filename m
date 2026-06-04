Received: from dragonfly.birch.relay.mailchannels.net (dragonfly.birch.relay.mailchannels.net [23.83.209.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D3A375F8B
	for <linux-cxl@vger.kernel.org>; Thu,  4 Jun 2026 15:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.209.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780587795; cv=none; b=cRY01ywJ//JXaHKZCJUQrjNjWoUnF3AQa7d/Y1grYQq9Tozc6TQCJf3LRvqPPB9Em9yvhMbE1mfLsmgLPnKv0Cmbso2BIunkOl028baldwgOK4nZWnJzrXF3a5lUb45sRhZwAjhVrKP3bgN+l7ce8767T7T+RDGckACutZ/+WoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780587795; c=relaxed/simple;
	bh=TfU8eWsopyUPqUS8n7ep+elRM90mEbrUfkJjtmfnAGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PVyZdkfR/w3RRogu1xEbLhIAPkHEhHQ93jYRm4TM1xV1d8jzsK90nGlkT02B1Jd6tU5LOuQb1Wvwt3rEuJeAdrmdfSy0yZLS899jTawNVr8/0nwzcDNP95hvQL2G67ARfh7S+jiIT9ryqrPqAgZ1gvANIrkdBE7VbcDOwRTCWxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=cKGTuKUx; arc=none smtp.client-ip=23.83.209.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="cKGTuKUx"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 9B7CA8C225A;
	Thu, 04 Jun 2026 15:43:07 +0000 (UTC)
Received: from pdx1-sub0-mail-a255.dreamhost.com (trex-green-3.trex.outbound.svc.cluster.local [100.101.207.57])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id D23BD8C2523;
	Thu, 04 Jun 2026 15:43:06 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Tank-Shrill: 100bfbb97eb750aa_1780587787280_215337007
X-MC-Loop-Signature: 1780587787280:3302998281
X-MC-Ingress-Time: 1780587787280
Received: from pdx1-sub0-mail-a255.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.101.207.57 (trex/7.1.5);
	Thu, 04 Jun 2026 15:43:07 +0000
Received: from offworld (186-79-219-2.fo.baf.movistar.cl [186.79.219.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a255.dreamhost.com (Postfix) with ESMTPSA id 4gWTNn1L4Dz106x;
	Thu,  4 Jun 2026 08:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1780587786;
	bh=BiUh1GmdwC8xpMfpZF6bAU1Jo1Gj33DdkRpRcym3KoM=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=cKGTuKUxmZEWV8nt8Bpr2Kxv7ns2bRYb3kwyPa9EFbGrQC9TcDs50LyYWOYzKYNDW
	 F0ONoBK5l3aqwN87Jd5gbYYuE6KCmhZtKaOuCKR+Dsr4E9+8SENiI6jqLNbU8lZvp7
	 Y44raRBEBFD3hTE9AC5NytS9N+TPHSdthHgqTNTGNpfLYIkAtcKfHjXQON6wK17GVb
	 b2oyCAKYPlQpMXowt6FSkVKuOdXrW4h5BNMUD2ND+34c8JwHotV+HTFAfdgQM2czTg
	 d6hnLmEmrxi8v1uPZioUSptugV+QTm0ImGLKSSZ9ekpfQuUKEm96iUxG3ZDN5VWP/c
	 nJ/q19euvJ4nw==
Date: Thu, 4 Jun 2026 08:42:59 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-cxl@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [PATCH 4/4] hw/cxl: Add per-capability CXL Fixed Memory Window
 restriction flags
Message-ID: <20260604154259.tq7vnnzuc74jif2m@offworld>
References: <20260602231806.2469011-1-dave@stgolabs.net>
 <20260602231806.2469011-5-dave@stgolabs.net>
 <20260604113426.206c4d39@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260604113426.206c4d39@jic23-huawei>
User-Agent: NeoMutt/20220429

On Thu, 04 Jun 2026, Jonathan Cameron wrote:

>On Tue,  2 Jun 2026 16:18:06 -0700
>Davidlohr Bueso <dave@stgolabs.net> wrote:
>
>> Expose the CFMWS Window Restrictions as named per-capability machine
>> properties (device-coherent, host-only, volatile, persistent,
>> fixed-config, back-invalidate), making the advertised restrictions
>> configurable per window.
>>
>> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
>Hi Davidlohr, looks good in general.
>
>Maybe I need more coffee but I don't thing the documented constraints
>are exactly the same as the ones in the code.

Sorry, I'm not sure I follow here.

>
>Thanks again for doing this!

No problem, thanks for reviewing.

>
>Jonathan
>
>> ---
>>  docs/system/devices/cxl.rst | 13 +++------
>>  hw/acpi/cxl.c               |  2 +-
>>  hw/cxl/cxl-host.c           | 55 +++++++++++++++++++++++++++++++++++++
>>  include/hw/cxl/cxl.h        | 12 ++++++++
>>  qapi/machine.json           | 29 +++++++++++++++++++
>>  5 files changed, 101 insertions(+), 10 deletions(-)
>>
>> diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
>> index 9d0771cdfd73..cf3f2c81785c 100644
>> --- a/docs/system/devices/cxl.rst
>> +++ b/docs/system/devices/cxl.rst
>> @@ -384,15 +384,14 @@ An example of 4 devices below a switch suitable for 1, 2 or 4 way interleave::
>>    -device cxl-type3,bus=swport3,persistent-memdev=cxl-mem3,lsa=cxl-lsa3,id=cxl-pmem3,sn=0x4 \
>>    -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k
>>
>> -An example of 4 type3 devices with volatile memory below a switch. Two of the devices
>> -use HDM-DB for coherence, which requires operating in Flit mode::
>> +An example of 2 type3 devices with volatile memory below a switch. The devices
>> +use HDM-DB for coherence, which requires operating in Flit mode and a CXL window
>> +configured to permit device-coherent Back-Invalidate model::
>
>Thanks for doing this!.  I wonder if the example should gain a second FMW to accommodate
>the original mixed device config. I'm fairly sure that should work and good to indicate
>that the mixed case is real.

I can do that.

>
>>
>>    qemu-system-x86_64 -M q35,cxl=on -m 4G,maxmem=8G,slots=8 -smp 4 \
>>    ...
>>    -object memory-backend-ram,id=cxl-mem0,share=on,size=256M \
>>    -object memory-backend-ram,id=cxl-mem1,share=on,size=256M \
>> -  -object memory-backend-ram,id=cxl-mem2,share=on,size=256M \
>> -  -object memory-backend-ram,id=cxl-mem3,share=on,size=256M \
>>    -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
>>    -device cxl-rp,port=0,bus=cxl.1,id=root_port0,chassis=0,slot=0 \
>>    -device cxl-rp,port=1,bus=cxl.1,id=root_port1,chassis=0,slot=1 \
>> @@ -401,11 +400,7 @@ use HDM-DB for coherence, which requires operating in Flit mode::
>>    -device cxl-type3,bus=swport0,volatile-memdev=cxl-mem0,id=cxl-mem0,sn=0x1,x-256b-flit=on,hdm-db=on \
>>    -device cxl-downstream,port=1,bus=us0,id=swport1,chassis=0,slot=5 \
>>    -device cxl-type3,bus=swport1,volatile-memdev=cxl-mem1,id=cxl-mem1,sn=0x2,x-256b-flit=on,hdm-db=on \
>> -  -device cxl-downstream,port=2,bus=us0,id=swport2,chassis=0,slot=6 \
>> -  -device cxl-type3,bus=swport2,volatile-memdev=cxl-mem2,id=cxl-mem2,sn=0x3 \
>> -  -device cxl-downstream,port=3,bus=us0,id=swport3,chassis=0,slot=7 \
>> -  -device cxl-type3,bus=swport3,volatile-memdev=cxl-mem3,id=cxl-mem3,sn=0x4 \
>> -  -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k
>> +  -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k,cxl-fmw.0.back-invalidate=on
>>
>>  A simple arm/virt example featuring a single direct connected CXL Type 3
>>  Volatile Memory device::
>> diff --git a/hw/acpi/cxl.c b/hw/acpi/cxl.c
>> index 5ce5e8e083ba..77c1db6561b4 100644
>> --- a/hw/acpi/cxl.c
>> +++ b/hw/acpi/cxl.c
>> @@ -172,7 +172,7 @@ static void cedt_build_cfmws(CXLFixedWindow *fw, Aml *cedt)
>>      build_append_int_noprefix(table_data, fw->enc_int_gran, 4);
>>
>>      /* Window Restrictions */
>> -    build_append_int_noprefix(table_data, 0xe, 2);
>> +    build_append_int_noprefix(table_data, fw->restrictions, 2);
>>
>>      /* QTG ID */
>>      build_append_int_noprefix(table_data, 0, 2);
>> diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
>> index f3479b19914f..7af431bf1555 100644
>> --- a/hw/cxl/cxl-host.c
>> +++ b/hw/cxl/cxl-host.c
>> @@ -61,6 +61,61 @@ static void cxl_fixed_memory_window_config(CXLFixedMemoryWindowOptions *object,
>>          fw->enc_int_gran = 0;
>>      }
>>
>> +    if (object->device_coherent) {
>> +        fw->restrictions |= CXL_FMW_DEVICE_COHERENT;
>> +    }
>> +    if (object->back_invalidate) {
>> +        if (object->has_device_coherent && !object->device_coherent) {
>> +            error_setg(errp, "CFMW BI requires device-coherent");
>> +            return;
>> +        }
>> +        fw->restrictions |= CXL_FMW_DEVICE_COHERENT | CXL_FMW_BI;
>> +    }
>> +    if (object->host_only) {
>> +        fw->restrictions |= CXL_FMW_HOST_ONLY;
>> +    } else if (!object->has_host_only &&
>> +               !(fw->restrictions & CXL_FMW_DEVICE_COHERENT)) {
>> +        /* host-only coherent is the default when no model is requested. */
>> +        fw->restrictions |= CXL_FMW_HOST_ONLY;
>> +    }
>> +
>> +    if (!(fw->restrictions & (CXL_FMW_DEVICE_COHERENT | CXL_FMW_HOST_ONLY))) {
>> +        error_setg(errp, "CFMW coherency model required");
>> +        return;
>> +    }
>> +
>> +    /*
>> +     * Reject the undefined and conflicting coherency combinations,
>> +     * per CXL r4.0 9.18.1.3.
>> +     */
>> +    if ((fw->restrictions & CXL_FMW_HOST_ONLY) &&
>> +        (fw->restrictions & CXL_FMW_BI)) {
>> +        error_setg(errp, "CFMW host-only coherency + BI is undefined behavior");
>> +        return;
>> +    }
>> +    if ((fw->restrictions & CXL_FMW_DEVICE_COHERENT) &&
>> +        (fw->restrictions & CXL_FMW_HOST_ONLY)) {
>> +        error_setg(errp,
>> +                   "CFMW device and host-only coherency are mutually exclusive");
>
>I'm confused. I thought this one was allowed by the spec?  Without a spec
>clarification I'm reluctant to prevent it.

The text is not clear, I agree. However, per Dan's pushback in the kernel series,
I took this as bit1 (host only) cannot be combined with anything dev coherent.
This is also why I drop the bit0 in the default restrictions. I am fine removing
this check here for now, but also have a kernel equivalent which fails the cfmw
parsing if any of the above is seen (maybe the failure could be downgraded to
a warning).

>
>> +        return;
>> +    }
>> +
>> +    if (object->fixed_config) {
>> +        fw->restrictions |= CXL_FMW_FIXED_CONFIG; /* no-op */
>> +    }
>> +
>> +    /* Volatile and persistent are permitted unless explicitly disabled. */
>> +    if (!object->has_q_volatile || object->q_volatile) {
>> +        fw->restrictions |= CXL_FMW_VOLATILE;
>> +    }
>> +    if (!object->has_persistent || object->persistent) {
>> +        fw->restrictions |= CXL_FMW_PERSISTENT;
>> +    }
>> +    if (!(fw->restrictions & (CXL_FMW_VOLATILE | CXL_FMW_PERSISTENT))) {
>> +        error_setg(errp, "CFMW volatile and/or persistent memory required");
>> +        return;
>> +    }
>> +
>>      fw->targets = g_malloc0_n(fw->num_targets, sizeof(*fw->targets));
>>      for (i = 0, target = object->targets; target; i++, target = target->next) {
>>          /* This link cannot be resolved yet, so stash the name for now */
>
>> diff --git a/qapi/machine.json b/qapi/machine.json
>> index 685e4e29b87d..a5be531403a1 100644
>> --- a/qapi/machine.json
>> +++ b/qapi/machine.json
>> @@ -551,15 +551,44 @@
>>  #     accesses will go to a given interleave target.  Accepted values
>>  #     [256, 512, 1k, 2k, 4k, 8k, 16k]
>>  #
>> +# @device-coherent: Window permits device-coherent (minimally HDM-D)
>> +#     accesses.  (since 11.0)
>
>Will be at least 11.1 as that's the cycle we are in now I think.

ack

>
>> +#
>> +# @host-only: Window permits host-only coherent (HDM-H) accesses.
>> +#     (since 11.0)
>> +#
>> +# @volatile: Window permits volatile memory.  (since 11.0)
>> +#
>> +# @persistent: Window permits persistent memory.  (since 11.0)
>> +#
>> +# @fixed-config: Window has a fixed device configuration.  Advertised
>> +#     in the CEDT only; not otherwise emulated.  (since 11.0)
>> +#
>> +# @back-invalidate: Window permits Back-Invalidate (HDM-DB).  Implies
>> +#     @device-coherent.  (since 11.0)
>If I read the code above right you check for device coherent. So
>I'd argue, should say Requires @device_coherent.

The intent here is to explain that we allow the user not to have to
explicitly pass both device-coherent=on and back-invalidate=on options
when do BI.

+    if (object->back_invalidate) {
+        if (object->has_device_coherent && !object->device_coherent) {
+            error_setg(errp, "CFMW BI requires device-coherent");
+            return;
+        }
+        fw->restrictions |= CXL_FMW_DEVICE_COHERENT | CXL_FMW_BI;
+    }

>
>> +#
>>  # @targets: Target root bridge IDs from -device ...,id=<ID> for each
>>  #     root bridge.
>>  #
>> +# Coherency defaults to host-only coherent; request a device model
>> +# with @device-coherent or @back-invalidate instead.  @volatile and
>
>@device-coherent and/or @back-invalidate instead.

Yes.

Thanks,
Davidlohr

>
>> +# @persistent are permitted unless set to false, and at least one is
>> +# required.  Clearing @host-only with no device model is rejected, as
>> +# are host-only coherent + back-invalidate and device-coherent +
>> +# host-only coherent.
>> +#
>>  # Since: 7.1
>>  ##
>>  { 'struct': 'CXLFixedMemoryWindowOptions',
>>    'data': {
>>        'size': 'size',
>>        '*interleave-granularity': 'size',
>> +      '*device-coherent': 'bool',
>> +      '*host-only': 'bool',
>> +      '*volatile': 'bool',
>> +      '*persistent': 'bool',
>> +      '*fixed-config': 'bool',
>> +      '*back-invalidate': 'bool',
>>        'targets': ['str'] }}
>>
>>  ##
>
