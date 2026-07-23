Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3FC4908C5;
	Thu, 23 Jul 2026 23:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784850441; cv=none; b=TsbdMJMGvLSLWUdLmHQTbx0zZrAlU9eFBXJT6zgWWvGt4YO0pntKvGJ1LWR85Hk9B2rOGPmxjdS+StHS3Wr2yCAnRm7WygloehxGYdgyQnpbdJt7Q/sbVJF+d+S68MP86zMw4yhX5gPV2wno1ZQEVN7QNyVAvCd2hYK2ZThMvCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784850441; c=relaxed/simple;
	bh=DIIs9wQGIXfg6QF+bu8LBTKejR4KOrlMU8xA1xBiFpc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h3QgLPM7b6vlZ5pbWA/e22qI1pwGtX3unQZ+AzvmkxcwVhO94IkkI/TzjGf31zUHIMGP6fqvuVp+rNKT3dealzH9TrKbBLAgNhmOoTFWCnhnpZcxab+bhFCOqM77T2GSjZzj7GgTzdbPSICfKXM6TFDDXS/tAI9lp+plK+l4RMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YFZUXdDV; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YFZUXdDV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784850439; x=1816386439;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DIIs9wQGIXfg6QF+bu8LBTKejR4KOrlMU8xA1xBiFpc=;
  b=YFZUXdDVDZcU65bfHPdOHpvor6oBUQ0YLe1T4lr7peX7gT+MSP5sM3vw
   6C73Rrvz62dmPV89n7hkqUCxQlhVrM9KMP7afopVXmlve+D9dwbDZcYgK
   Denr6Z4K9gDae/vODrA2TKZTm68NIGyCF6rHOgAUEgag2Yykoq/AoJosU
   CyqHM98VX6dgaARqsUBz5cEp47OatO05x5oviGLPqcR6Ll1sJefDKGeqK
   1zynH/GV+PmqvzL2f0gSe1t4v3PvOYXcQq4hederXzrJcSW3gAroBIBX5
   CuDGrK+JQBVVDkb2MqwARAWWyk+SgNDmiXnvMYVJCYATs8/jaOQHjzZni
   g==;
X-CSE-ConnectionGUID: Ud2gyX+SR5+SUdML57pAcg==
X-CSE-MsgGUID: LIi9RuezS/yvmUZwzEFDeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="73060248"
X-IronPort-AV: E=Sophos;i="6.25,181,1779174000"; 
   d="scan'208";a="73060248"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 16:47:19 -0700
X-CSE-ConnectionGUID: AIJPz/wESPS6Jpc+hsegdw==
X-CSE-MsgGUID: drZHywXBQcySTgiLbMZ4WA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,181,1779174000"; 
   d="scan'208";a="257297242"
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.110.160]) ([10.125.110.160])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 16:47:18 -0700
Message-ID: <e3021037-f674-4974-adbe-eb7564f0c4b4@intel.com>
Date: Thu, 23 Jul 2026 16:47:17 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl/hdm: Enforce CFMWS memory type policy at decoder
 commit time
To: Mayank Rana <mayank.rana@oss.qualcomm.com>, linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, linux-kernel@vger.kernel.org
References: <20260711003341.2602368-1-mayank.rana@oss.qualcomm.com>
 <61531e60-0171-4d7e-b61b-ac0790a38ede@intel.com>
 <115d2157-d4d2-4897-a9c8-fe42fec0bbf9@oss.qualcomm.com>
 <41540b44-8142-4b80-b876-0ff3f7ddd619@oss.qualcomm.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <41540b44-8142-4b80-b876-0ff3f7ddd619@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 7/23/26 4:18 PM, Mayank Rana wrote:
> Hi Dave
> 
> On 7/15/2026 3:26 PM, Mayank Rana wrote:
>> Hi Dave
>>
>> Thank you for review comments.
>>
>> On 7/13/2026 8:47 AM, Dave Jiang wrote:
>>>
>>>
>>> On 7/10/26 5:33 PM, Mayank Rana wrote:
>>>> A CXL Fixed Memory Window Structure (CFMWS) in the ACPI CEDT table
>>>> carries a restrictions field that describes the memory types a platform
>>>> window supports.  cfmws_to_decoder_flags() translates this into
>>>> CXL_DECODER_F_TYPE2 (HDM-DB permitted) and CXL_DECODER_F_TYPE3 (HDM-H
>>>> permitted) flags on the root decoder.
>>>>
>>>> However, nothing currently prevents a caller from committing an endpoint
>>>> or switch decoder whose target_type conflicts with the CFMWS policy:
>>>>
>>>>    - A decoder with target_type == CXL_DECODER_DEVMEM (HDM-DB) can be
>>>>      committed on a window that lacks CXL_DECODER_F_TYPE2 (HDM-H only).
>>>>      A dual-capable device will accept HOSTONLY=0 + COMMIT=1 without
>>>>      asserting COMMIT_ERROR, silently violating platform policy.
>>>>
>>>>    - Symmetrically, a decoder with target_type == CXL_DECODER_HOSTONLYMEM
>>>>      (HDM-H) can be committed on a window that lacks CXL_DECODER_F_TYPE3
>>>>      (HDM-DB only), again violating ACPI CFMWS restrictions.
>>>>
>>>> Add a check in cxl_decoder_commit() that walks from the decoder's
>>>> assigned region to the root decoder and rejects the commit with
>>>> -EOPNOTSUPP if the decoder's target_type requires a capability flag that
>>>> the CFMWS window does not advertise:
>>>>
>>>>    - CXL_DECODER_DEVMEM      requires CXL_DECODER_F_TYPE2 on root decoder
>>>>    - CXL_DECODER_HOSTONLYMEM requires CXL_DECODER_F_TYPE3 on the root
>>>>      decoder
>>>>
>>>> required_flag is initialized to zero so that any future target_type
>>>> values not covered by the if/else-if chain leave the enforcement check
>>>> a no-op via the leading required_flag && guard.
>>>>
>>>> This makes the CFMWS restrictions field authoritative for memory type
>>>> enforcement in both directions, regardless of individual device capability.
>>>> The existing COMMIT_ERROR path in cxld_await_commit() remains as a
>>>> secondary safeguard for devices that cannot support the requested mode.
>>>
>>> Can you please trim the commit log? The AI generated verbiage is excessively wordy. A simple and more to the point short log that conveys all the information would be appreciated.
>> ok. noted down.
>>>>
>>>> Fixes: 3e23d17ce198 ("cxl/acpi: Use the ACPI CFMWS to create static decoder objects")
>>>> Assisted-by: Claude:claude-sonnet-4-6
>>>> Signed-off-by: Mayank Rana <mayank.rana@oss.qualcomm.com>
>>>> ---
>>>>    - Initialize required_flag = 0 and use explicit else-if for
>>>>      CXL_DECODER_HOSTONLYMEM; guard enforcement with required_flag &&
>>>>      so unknown target_type values skip the check cleanly
>>>>
>>>> Changes in v2:
>>>>    - Extend enforcement to cover both directions: HDM-H commits on
>>>>      HDM-DB-only windows are now rejected in addition to HDM-DB commits
>>>>      on HDM-H-only windows (reported by Sashiko AI review)
>>>>    - Generalize condition from single DEVMEM check to type-dispatch
>>>>      selecting required_flag based on target_type
>>>>    - Update commit message and subject to reflect bidirectional policy
>>>>
>>>> Testing
>>>> -------
>>>>
>>>> The bug and fix were validated using QEMU with a modified CXL configuration.
>>>>
>>>> Two test-only changes were applied (not part of this patch):
>>>>
>>>>    1. QEMU ACPI (hw/acpi/cxl.c): CFMWS restrictions field changed from
>>>>       0x0f to 0x02 (ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM only, without
>>>>       RESTRICT_DEVMEM).  This causes cfmws_to_decoder_flags() to set
>>>>       CXL_DECODER_F_TYPE3 only on the root decoder, simulating a platform
>>>>       that does not permit HDM-DB.
>>>>
>>>>    2. Kernel (drivers/cxl/core/hdm.c): init_hdm_decoder() uncommitted
>>>>       endpoint path changed to force CXL_DECODER_DEVMEM unconditionally,
>>>>       simulating a dual-capable device (supports both HDM-H and HDM-DB).
>>>>       QEMU's cxl-type3 device reports CXL_DEVTYPE_CLASSMEM and defaults
>>>>       to HOSTONLYMEM; this override exercises the DEVMEM commit path that
>>>>       a real Type-2 or dual-capable Type-3 device would trigger.
>>>>
>>>> Bug reproduction (without this patch):
>>>>
>>>>    # cxl create-region -m mem0 -d decoder0.0 -t pmem
>>>>    created 1 region
>>>>
>>>>    HDM-DB committed silently despite CFMWS advertising HDM-H only.
>>>>    No error or warning in dmesg.
>>>>
>>>> Fix validation (with this patch):
>>>>
>>>>    # cxl create-region -m mem0 -d decoder0.0 -t pmem
>>>>    cxl region: cmd_create_region: created 0 regions
>>>>
>>>>    dmesg:
>>>>      cxl_core: cxl region0: mem0:decoder2.0 type mismatch: 2 vs 3
>>>>      cxl_port endpoint2: failed to attach decoder2.0 to region0: -6
>>>>
>>>>    The decoder's target_type (2=DEVMEM) mismatches the region's required
>>>>    type (3=HOSTONLYMEM) enforced by the CFMWS restriction -- commit blocked.
>>>>
>>>> QEMU invocation:
>>>>
>>>>    qemu-system-x86_64 \
>>>>      -kernel bzImage \
>>>>      -append "root=/dev/sda rw console=ttyS0" \
>>>>      -drive file=rootfs.img,index=0,media=disk,format=raw \
>>>>      -M q35,cxl=on -m 4G,maxmem=8G,slots=8 -smp 4 \
>>>>      -object memory-backend-file,id=cxl-mem1,share=on,mem-path=/tmp/ cxltest.raw,size=256M \
>>>>      -object memory-backend-file,id=cxl-lsa1,share=on,mem-path=/tmp/ lsa.raw,size=256M \
>>>>      -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
>>>>      -device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
>>>>      -device cxl-type3,bus=root_port13,persistent-memdev=cxl- mem1,lsa=cxl-lsa1,id=cxl-pmem0,sn=0x1 \
>>>>      -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G \
>>>>      -nographic
>>>>
>>>>
>>>> drivers/cxl/core/hdm.c | 29 +++++++++++++++++++++++++++++
>>>>   1 file changed, 29 insertions(+)
>>>>
>>>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
>>>> index 0c80b76a5f9b..127a187cdadb 100644
>>>> --- a/drivers/cxl/core/hdm.c
>>>> +++ b/drivers/cxl/core/hdm.c
>>>> @@ -802,6 +802,7 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
>>>>       struct cxl_port *port = to_cxl_port(cxld->dev.parent);
>>>>       struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
>>>>       void __iomem *hdm = cxlhdm->regs.hdm_decoder;
>>>> +    struct cxl_root_decoder *cxlrd;
>>>>       int id = cxld->id, rc;
>>>>       if (cxld->flags & CXL_DECODER_F_ENABLE)
>>>> @@ -834,6 +835,34 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
>>>>           }
>>>>       }
>>>> +    /*
>>>> +     * Enforce CFMWS memory type policy: reject commits where the decoder
>>>> +     * target_type conflicts with the root decoder's CFMWS restrictions.
>>>> +     * - HDM-DB (DEVMEM) requires CXL_DECODER_F_TYPE2 on the root decoder.
>>>> +     * - HDM-H (HOSTONLYMEM) requires CXL_DECODER_F_TYPE3 on the root decoder.
>>>> +     * - Unknown target_type values leave required_flag zero; skip enforcement.
>>>> +     */
>>>> +    if (cxld->region) {
>>>
>>> I don't think we should gate the check based on whether cxld->region is valid or not. Can you please take a look at core/ region.c:271:cxl_region_decode_reset() and do something similar to acquire the root decoder by walking up the port hierachy? That should apply the policy check unconditionally. I would also suggest putting this entire block in a helper function.
>> will refer suggested API, and rework upon this.
> Thanks for the pointer -- I looked closely at cxl_region_decode_reset()
> and want to flag something before sending v3, since a literal port-walk
> doesn't fully replace the region lookup here.
> 
> cxl_region_decode_reset() doesn't derive the decoder from the port walk
> alone: it's called with cxlr already known, and at each port level uses cxl_rr_load(iter, cxlr) -- keyed by the region -- to find the decoder assigned to that region at that port. The walk finds the *port*; cxlr still finds the *decoder*.
> 
> The reason that matters for this check specifically: a single CXL root
> port can host multiple root decoders, one per CFMWS window, each with
> its own restrictions. A pure walk up to is_cxl_root(port) would tell us this decoder's SPA range originates somewhere under that root port, but not *which* of its root decoders' CFMWS restrictions apply -- only the region (or the port's region_ref tracking, which is  also region-keyed) can disambiguate that.
> 
> So v3 keeps the region-based lookup (cxld->region->dev.parent ->
> to_cxl_root_decoder()), but addresses what I take to be the actual concern -- silently skipping the policy check -- by making the check itself unconditional instead of gated:
> 
> if (dev_WARN_ONCE(&cxld->dev, !cxld->region,
>                        "commit without region assignment\n"))
>             return -ENXIO;
> 

ok sounds good

> A decoder reaching commit() without a region assigned is now treated as
> a bug (loud WARN + rejected commit) rather than something the check quietly steps around. By the time cxl_decoder_commit() runs, the region assignment has already happened during region assembly (cxl_rr_assign_decoder()), so this should not be reachable in practice. Also pulled the whole block into cxl_decoder_cfmws_check() as suggested.
> 
> v3 to follow shortly with this and the F_DEVMEM/F_HOSTONLY rename per
> Davidlohr's BI series.

Davidlohr seems to indicate that with his code series, this patch may not be needed?

DJ

> 
> Thanks,
> Mayank
>>> DJ
>>>
>>>> +        unsigned long required_flag = 0;
>>>> +        const char *type_name;
>>>> +
>>>> +        cxlrd = to_cxl_root_decoder(cxld->region->dev.parent);
>>>> +        if (cxld->target_type == CXL_DECODER_DEVMEM) {
>>>> +            required_flag = CXL_DECODER_F_TYPE2;
>>>> +            type_name = "HDM-DB";
>>>> +        } else if (cxld->target_type == CXL_DECODER_HOSTONLYMEM) {
>>>> +            required_flag = CXL_DECODER_F_TYPE3;
>>>> +            type_name = "HDM-H";
>>>> +        }
>>>> +
>>>> +        if (required_flag && !(cxlrd->cxlsd.cxld.flags & required_flag)) {
>>>> +            dev_err(&port->dev,
>>>> +                "%s commit rejected on %s, CFMWS does not permit this memory type\n",
>>>> +                type_name, dev_name(&cxld->dev));
>>>> +            return -EOPNOTSUPP;
>>>> +        }
>>>> +    }
>>>> +
>>>>       scoped_guard(rwsem_read, &cxl_rwsem.dpa)
>>>>           setup_hw_decoder(cxld, hdm);
>>>
>> Regards,
>> Mayank
>>
> 

