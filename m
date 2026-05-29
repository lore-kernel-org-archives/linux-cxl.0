Received: from www3579.sakura.ne.jp (www3579.sakura.ne.jp [49.212.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26522367B7F
	for <linux-cxl@vger.kernel.org>; Fri, 29 May 2026 14:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.243.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780064721; cv=none; b=hqJa7pIlpJpL5A4M3zHkfc7pdih+A8qLKmMEUp6odJfRJESbcekIxdLysxkqjkZ8JOV5kZ2po6i6Hs7CH8D6uwz5Hr3x1HPpPAVQ3hDxtTY4Rwm528k6dUR0eylUnnpaWQEWg5uU/9lDYBp0lZpU1la2WrfyHXc8HnU4RaRsoSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780064721; c=relaxed/simple;
	bh=oJG+ic0/UlMgs9uSpXHRVHdCD9/0T5bJhGrJdXR96VI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KBNjsMIYqz1vOIHsOZs5lUDrxpbgaETyNKNWiGToSWETSzLq72AJxgtlOfYeLG9nAs6wVGkwRJzNvQ/uqlpwELVfsR2B5cXT5yEdVFVuHtI8KwSzrC396oeL5QC8k5dTxpsqKDLDIUAX0EpPNpgf0R+N1k3ZAYIBMlpd9G8i0AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp; dkim=fail (0-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b=dpk8dmvF reason="key not found in DNS"; arc=none smtp.client-ip=49.212.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b="dpk8dmvF"
Received: from [192.168.10.145] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
	(authenticated bits=0)
	by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 64TDd2YZ057184
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 29 May 2026 22:39:03 +0900 (JST)
	(envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=ARPVCavVU5+6sb54n8Daa5m5t7+of2b1Asseo7o7Q3U=;
        c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20250326; t=1780061943; v=1;
        b=dpk8dmvFc3zoeQfwo1geyHXDpSxC9t7mBit4v9GlrXNUOC5SLEyuaKexdwCTt/Ze
         JvThuJxWnZmKdhZIaXUGd6wh9tqfBrTzdajMrEbCIAuRKe2Y/Y5ZtZ2lwqDPpVOS
         KaQzK/biZtTBSIH1QiD9xHi9gEcEUiA3W4TkpYZkhAdWc2hWbDgxmttM6xHQlq+t
         /undmNDxmayuHhfOmel5nkmEhmh1v6HXdfDHg6EgYL6H8W4sUmlimckug89faQc7
         Dc+xR7Uvw1sLa/1sGeJuLpY7QyOQjt38oNuls/dEeFbCBnwOqUu1BWL6t30B/M/X
         ZdXMkQ1YNqFvlWdtq5BV6A==
Message-ID: <7b025488-0517-42ae-9f2b-fce720312163@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 29 May 2026 22:39:02 +0900
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/cxl: Fix cxl_fmws_set_memmap() range check
To: Jonathan Cameron <jic23@kernel.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
        Fan Ni <fan.ni@samsung.com>, Paolo Bonzini <pbonzini@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
        linux-cxl@vger.kernel.org
References: <20260528-cxl-v1-1-a470c8255264@rsg.ci.i.u-tokyo.ac.jp>
 <20260529140001.435eaebd@jic23-huawei>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260529140001.435eaebd@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026/05/29 22:00, Jonathan Cameron wrote:
> On Thu, 28 May 2026 21:24:05 +0900
> Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
> 
>> cxl_fmws_set_memmap() leaves the zero-initialized base address of a CXL
>> fixed window unchanged when it does not fit in the memory map, which
>> results in incorrect mapping. Change the function to report an error
>> instead.
>>
>> The Arm virt machine passes the exclusive end of the memory map while
>> the i386 pc machine passes the inclusive end to cxl_fmws_set_memmap().
>> Change the i386 pc machine to pass the exclusive end and perform the
>> range check accordingly in cxl_fmws_set_memmap().
> Hi,
> 
> 
> +CC linux-cxl as more folk there who might take a look at this.
> (also my remove my dead huawei address)
> 
> What are the results of this on users?  Obviously the CFMWS doesn't
> work, but how do they observe that.
> 
> Also seems like this is a fix and it can be a lot more minimal
> (just one error_fatal use).
> 
> Jonathan
> 
> 
>>
>> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>> ---
>>   include/hw/cxl/cxl_host.h |  2 +-
>>   hw/arm/virt.c             |  6 +++---
>>   hw/cxl/cxl-host-stubs.c   |  4 ++--
>>   hw/cxl/cxl-host.c         | 12 +++++++-----
>>   hw/i386/pc.c              | 12 ++++++------
>>   5 files changed, 19 insertions(+), 17 deletions(-)
>>
>> diff --git a/include/hw/cxl/cxl_host.h b/include/hw/cxl/cxl_host.h
>> index 21619bb748ab..ed34c3159f59 100644
>> --- a/include/hw/cxl/cxl_host.h
>> +++ b/include/hw/cxl/cxl_host.h
>> @@ -16,7 +16,7 @@
>>   void cxl_machine_init(Object *obj, CXLState *state);
>>   void cxl_fmws_link_targets(Error **errp);
>>   void cxl_hook_up_pxb_registers(PCIBus *bus, CXLState *state, Error **errp);
>> -hwaddr cxl_fmws_set_memmap(hwaddr base, hwaddr max_addr);
>> +bool cxl_fmws_set_memmap(hwaddr *cursor, hwaddr end, Error **errp);
>>   void cxl_fmws_update_mmio(void);
>>   GSList *cxl_fmws_get_all_sorted(void);
>>   
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index b090233893c5..a22778575cfb 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -2536,9 +2536,9 @@ static void virt_set_memmap(VirtMachineState *vms, int pa_bits)
>>       if (device_memory_size > 0) {
>>           machine_memory_devices_init(ms, device_memory_base, device_memory_size);
>>       }
>> -    vms->highest_gpa = cxl_fmws_set_memmap(ROUND_UP(vms->highest_gpa + 1,
>> -                                                    256 * MiB),
>> -                                           BIT_ULL(pa_bits)) - 1;
>> +    vms->highest_gpa = ROUND_UP(vms->highest_gpa + 1, 256 * MiB);
>> +    cxl_fmws_set_memmap(&vms->highest_gpa, BIT_ULL(pa_bits), &error_fatal);
>> +    vms->highest_gpa--;
> 
> Hmm. The previous code kept the tight coupling of cxl_fmws_set_memmap()
> returning an address that we then decremented as the value is inclusive.
> This loses that clarity to my eyes.
> 
> Perhaps we now need a comment.
> 
>>   }
>>   
>>   static VirtGICType finalize_gic_version_do(const char *accel_name,
>> diff --git a/hw/cxl/cxl-host-stubs.c b/hw/cxl/cxl-host-stubs.c
>> index 9b515913ea4d..fa87cea0e8b9 100644
>> --- a/hw/cxl/cxl-host-stubs.c
>> +++ b/hw/cxl/cxl-host-stubs.c
>> @@ -11,9 +11,9 @@
>>   void cxl_fmws_link_targets(Error **errp) {};
>>   void cxl_machine_init(Object *obj, CXLState *state) {};
>>   void cxl_hook_up_pxb_registers(PCIBus *bus, CXLState *state, Error **errp) {};
>> -hwaddr cxl_fmws_set_memmap(hwaddr base, hwaddr max_addr)
>> +bool cxl_fmws_set_memmap(hwaddr *base, hwaddr max_addr, Error **errp)
> 
> Feels like a more minimal solution is to just use error_fatal() internally and
> keep the original return of value.

I followed what other functions (cxl_fmws_link_targets() and 
cxl_hook_up_pxb_registers()) do.

> 
>>   {
>> -    return base;
>> +    return true;
>>   };
>>   void cxl_fmws_update_mmio(void) {};
>>   
>> diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
>> index a94b893e9991..33421b3ca174 100644
>> --- a/hw/cxl/cxl-host.c
>> +++ b/hw/cxl/cxl-host.c
>> @@ -429,7 +429,7 @@ void cxl_fmws_update_mmio(void)
>>       object_child_foreach_recursive(object_get_root(), cxl_fmws_mmio_map, NULL);
>>   }
>>   
>> -hwaddr cxl_fmws_set_memmap(hwaddr base, hwaddr max_addr)
>> +bool cxl_fmws_set_memmap(hwaddr *cursor, hwaddr end, Error **errp)
> 
> The cursor naming makes little sense to me. It is an address.

It is not really "base" though and it's moving during execution; please 
see how the resulting value is used in cxl_fmws_set_memmap(). The naming 
represents the moving nature and has no implication on being an address.

> Also the rename to end doesn't seem to bring any more clarity over max_addr.
> I guess maybe you did this because it's an exclusive value? I'm not sure end
> conveys that any more than max_addr.

Indeed the rename was done because it's exclusive. max_addr is 
misleading as it implies inclusive and "end" is not at least, though it 
still doesn't tell it is the exclusive end.

> 
> 
>>   {
>>       GSList *cfmws_list, *iter;
>>       CXLFixedWindow *fw;
>> @@ -437,14 +437,16 @@ hwaddr cxl_fmws_set_memmap(hwaddr base, hwaddr max_addr)
>>       cfmws_list = cxl_fmws_get_all_sorted();
>>       for (iter = cfmws_list; iter; iter = iter->next) {
>>           fw = CXL_FMW(iter->data);
>> -        if (base + fw->size <= max_addr) {
>> -            fw->base = base;
>> -            base += fw->size;
>> +        if (end - *cursor < fw->size) {
> I'm not seeing why this form is an improvement on the original test.

The original form overflows when fw->size is too big and I'm just being 
careful here.

Regards,
Akihiko Odaki

> 
>> +            error_setg(errp, "A CXL fixed memory window does not fit in the memory map");
> 
> This bit I'm fine with!  Makes sense to error out as otherwise we get a rather
> confusing result.
> 
>> +            return false;
>>           }
>> +        fw->base = *cursor;
>> +        *cursor += fw->size;
>>       }
>>       g_slist_free(cfmws_list);
>>   
>> -    return base;
>> +    return true;
>>   }
>>   
>>   static void cxl_fmw_realize(DeviceState *dev, Error **errp)
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index 2ecad3c503fb..eadf37096533 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -747,7 +747,7 @@ void pc_memory_init(PCMachineState *pcms,
>>       PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
>>       X86MachineState *x86ms = X86_MACHINE(pcms);
>>       hwaddr maxphysaddr, maxusedaddr;
>> -    hwaddr cxl_base, cxl_resv_end = 0;
>> +    hwaddr cxl_cursor = 0;
> As above, I'm not sure how the cursor naming is useful. Its
> an address so I'd expect naming to reflect that. To me base does
> and cursor (which to me is typically the current position of an
> iterator) does not.
> 
>>       X86CPU *cpu = X86_CPU(first_cpu);
>>       uint64_t res_mem_end;
>>   
>> @@ -857,11 +857,11 @@ void pc_memory_init(PCMachineState *pcms,
>>           MemoryRegion *mr = &pcms->cxl_devices_state.host_mr;
>>           hwaddr cxl_size = MiB;
>>   
>> -        cxl_base = pc_get_cxl_range_start(pcms);
>> +        cxl_cursor = pc_get_cxl_range_start(pcms);
>>           memory_region_init(mr, OBJECT(machine), "cxl_host_reg", cxl_size);
>> -        memory_region_add_subregion(system_memory, cxl_base, mr);
>> -        cxl_base = ROUND_UP(cxl_base + cxl_size, 256 * MiB);
>> -        cxl_resv_end = cxl_fmws_set_memmap(cxl_base, maxphysaddr);
>> +        memory_region_add_subregion(system_memory, cxl_cursor, mr);
>> +        cxl_cursor = ROUND_UP(cxl_cursor + cxl_size, 256 * MiB);
>> +        cxl_fmws_set_memmap(&cxl_cursor, maxphysaddr + 1, &error_fatal);
>>           cxl_fmws_update_mmio();
>>       }
>>   
>> @@ -892,7 +892,7 @@ void pc_memory_init(PCMachineState *pcms,
>>       rom_set_fw(fw_cfg);
>>   
>>       if (pcms->cxl_devices_state.is_enabled) {
>> -        res_mem_end = cxl_resv_end;
>> +        res_mem_end = cxl_cursor;
>>       } else if (machine->device_memory) {
>>           res_mem_end = machine->device_memory->base
>>                         + memory_region_size(&machine->device_memory->mr);
>>
>> ---
>> base-commit: e89049b3ba5f1f0468bc0d294173345597514a1b
>> change-id: 20260528-cxl-d3bf91bac0c6
>>
>> Best regards,
>> --
>> Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>>
>>
> 

