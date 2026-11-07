Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794076733;
	b=zbo7yKdmUFPUBRCxCh06az7iTgeF9sz2hUUludvYiNYdTgCzHwl6xYPon5fx9m9kAig0
	 tZazRrIkMa2MW1DhpyacRFYi4mGe1dH/7LRT2YLGs/EeAs8JwRGyZeHsmeMiPvJQkjH/e
	 SONbLPXMAKLK694rKRYQrXRhMwqE72TPEuJZHgGamQhTVVbYbX35u4AZ2OzUvd8eIWJ0J
	 KOmtTP1tg6824KxUyMPpJoDcUnmJ8FqufbiP31cOyxNF1p9PwX6XfUikcOTT4Np7qo3uQ
	 0pBXV3OBkmtd3dJ81y5cMo/mxWuVvkui3rMIw7dEeNiVUrjXHkWM9FY2PrBI8Rzizeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794076733;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=spvN2Kkvvjth7KTaOcEznDk2ANdelsRyRzkG/ByDJJI=;
	b=NpqYnH2/CgKDx8AyE1BLJ7/qeA7DTGsRzkhdIE/dNOMAVXtamP29GV9oJHoS0sx6mUGm
	 cy6nHaFdr2ygakmTN+TUHwxj1gFCN2MlpSjDd7IWe3ykfMVjXRy94p1oooi++U2WapWj6
	 rM+TiTen4vQa55CroUM23u+8YNH/OiKALJHNiFqXAgQCHG4H/ti1CTL+G1KLFYklSUi7K
	 dJMvyig+GTVBE4zDxzGFATI9ULYNMUPorjP9DxATmzGkoQigBWYEz/vBMF+zK7ebBZJFg
	 QMkN8BJN4MMoArnS0TJa5ATGYZ9AHJW1KnYOGdM0nItco/8fcj42D8eLBx1DN0QeXmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yY6I7N+B;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7748606A32C
	for <linux-cxl@vger.kernel.org>; Sat,  7 Nov 2026 18:38:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7748606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yY6I7N+B
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1b2513decc3so1101888c88.1
        for <linux-cxl@vger.kernel.org>; Sat, 07 Nov 2026 10:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794076732; x=1794681532; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=spvN2Kkvvjth7KTaOcEznDk2ANdelsRyRzkG/ByDJJI=;
        b=yY6I7N+Bnq7VGXLv0BdDDyr23In2SaCG9L1QzTEvrKJXEZYE8jhQEUTrdXmgP2OUwf
         OIOHUcFADdgnLqCyw9PPxgVuMQAu62kkPKTIPIjV/5Md5D69fGVnlLaKH6R8GS8S/2Tv
         QI+lP+mjZq3Jo5t98A+nEod5FIsDgwPjQqflnEg7ntu+m0OcYLZKlAUDMoZzpNtfT5Cn
         vSHpIaQ6YgjN1TK/MusEraisBWp3mwaC1ms/jeUBx8KRU7wbbRzB/3UOtrYx/FXCXNj3
         wWXBOnsSIWR3KUo6wE3Om/vTQzb+cPW1KvrZEE4LGDSgBat1YN0OAyIV9ya3HC4+h3Ob
         Nj7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794076732; x=1794681532;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=spvN2Kkvvjth7KTaOcEznDk2ANdelsRyRzkG/ByDJJI=;
        b=PTlTzTuvLBt1uT2X+mkb7Wx/70sQKOJxkGMsj0SUpx2ZRDat/d3hTh6Y3ICqjD0S8R
         u3+b9JskiKl5/cVsVZDrtWMlimOPtQhJ6ZxXGUOU/g5jjUqQcEatIpfCeZwD5WRQeGI2
         TMKfIAGQDBG1QWRG8FdoHzxiiWBSRcozRnNLVHrRzpOny8xObq6UAEF6yolA2bZdwRHw
         ewyhyv4Z9Hhkzp+ZSwRmKLIOAKJK1FZGUlYeEBFVDSVGi7phXjQlGSaMVTZgSGadpglM
         Kxl3drEyZXOmUs193Dy3IIcWVoIMgGp4bfQ0S6JDzfMb93sqwExbKOtdYW/L3xOsvpiQ
         dMow==
X-Forwarded-Encrypted: i=1; AKwUvBwPHROjdjjpgKr0Hfs/8eRyb/bdGdNVI259TGbplFXDunjoj4qGB53k565xo+/ShhwQKmzXrWaODRg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/VjoZaE9FyxeHFOxgGiYd2nIGA0C/MricZsAi6wXipAyb0E7VC
	2n5MbBXPgZMGRLj5xF7l7ebFKUwjorVDwdQ9BL4fWjSJkNjWkvvqNuOj
X-Gm-Gg: AYBFou2A7fz2KSjvIRKctidUgU+3QiGikYa6mC39RYJa+V2O0PmxwI/A1beV6+IyAmE
	EB5FVK+p1cerpuDantcyOnw+k+BTT/XSMQ5JF42oxRGDXf7T7tPezhK2UeN5uH7hg27qob+KaYn
	QQbk1s+xbKg51eAIFwY64ByQVfH837FRosp7vfvaOyW0FqNMEV4ZGXPtJaGtDIPFYZwATU+cKzK
	XK6rnGnRvljotjJDl6ChvwZ7xwOzK7fGx6ypDRgI6Batj5cJUtIfOS1ZlVAIB40UrwREIpqfhRx
	OAVolZZJ1r/en5rrPfFMwzfbaHRJ7Em+gujK2ad4gGYYt8whzI72+Kf5k6XPjRkTWU8CUa7/Efl
	SILcDfMgFBLx1zXH44Ta33janypf669OWQkVfUvpj293SkEfHe9aTR80eAR17VStniOfSdDmtbR
	MXAM4RLWf7vD7pHVFVlv5X/i2uq41b2VcyHRb05ENnBJJAgS8aiRUQhgK3oOIEi8zoTlOJ/fGg8
	v6T+bCqOeHx+jYJgG9/Dv/kteiWsi0gvoJSaPMzoh2sW8CfcdmskDaVeRPnnI+wtB0zh3oToqJt
	FpHJPyjpGHVzefj/aMJJdDvYKA5aXAVZ5wfQCT7FKWbr+lvuL6seT9ZNa4GitU912I38ky+3gA=
	=
X-Received: by 2002:a05:7022:5f1a:b0:1ac:d029:70b5 with SMTP id a92af1059eb24-1b25d348c97mr7292152c88.33.1794076731454;
        Sat, 07 Nov 2026 10:38:51 -0800 (PST)
Received: from ?IPV6:240d:1a:8bb:4a00:40e6:d5b1:9360:f028? ([240d:1a:8bb:4a00:40e6:d5b1:9360:f028])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3771ea85bsm188340c88.18.2026.11.07.10.38.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Nov 2026 10:38:51 -0800 (PST)
Message-ID: <dc9a4c1d-bc3c-4a02-8e75-a7cee80d976d@gmail.com>
Date: Sun, 8 Nov 2026 03:38:48 +0900
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/7] QEMU/hw/cxl: Allow CXL Type 3 memory regions to
 be initialized at guest boot
To: Anisa Su <anisa.su887@gmail.com>
Cc: Yukiya Takaki <fj2110jc@fujitsu.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Jonathan Cameron <jic23@kernel.org>,
 Junjie Cao <junjie.cao@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, linux-cxl@vger.kernel.org,
 qemu-arm@nongnu.org, "Wolski, Tomasz" <tomasz.wolski@fujitsu.com>,
 lizhijian@fujitsu.com, y-goto@fujitsu.com
References: <cover.1793003983.git.fj2110jc@fujitsu.com>
 <auvsOE3OlS5I9ueG@cxlqual> <au0GIiKIggftlWe2@cxlqual>
Content-Language: en-US
From: Yukiya Takaki <yukiya.takaki@gmail.com>
In-Reply-To: <au0GIiKIggftlWe2@cxlqual>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Anisa,

> On Thu, Nov 05, 2026 at 11:38:48AM +0900, Anisa Su wrote:
>> On Mon, Oct 26, 2026 at 07:03:21PM +0900, Yukiya Takaki wrote:
>>> Hello everyone,
>>>
>>> I’m a student intern, and this is my first time sending patches to an open source mailing list.
>>>
>>> This patch series configures QEMU’s CXL Type 3 devices so that guest operating systems can automatically discover
>>> and create CXL regions during boot, aligning QEMU’s behavior with real hardware.
>>>
>>> Background and motivation
>>>    Currently, during guest boot QEMU does not provide the information or register programming needed for the guest OS
>>>    to initialize CXL Type 3 memory, so using it still requires an explicit action in the guest (for example, running the cxl create-region command).
>>>    By contrast, on some physical systems the firmware automatically allocates CXL memory ranges and exposes them to the OS,
>>>     allowing the Linux CXL driver to discover and create regions during boot.
>>>    This patch series is a first, experimental attempt to reproduce that behavior in QEMU.
>>>
>>>    Some parts of this implementation are based on Li, Zhijian’s work in:
>>>    https://github.com/zhijianli88/qemu/tree/program-decoder-v2
>>>
>>>    I would like to ask for feedback on whether this approach makes sense and whether I should continue to enhance it.
>>>
>>> Approach
>>>    This patch first adds a program_hdm_decoder option to cxl-type3.
>>>    When program-hdm-decoder is enabled on cxl-type3, QEMU will:
>>>      1) program endpoint/host-bridge HDM decoder state,
>>>      2) expose Type 3 ranges as E820_SOFT_RESERVED on x86,
>>>      3) create memory-only NUMA nodes for those ranges,
>>>      4) emit SRAT memory-affinity entries mapping each Type 3 HPA range to its node ID
>>>
>>>    On real hardware, HDM decoder programming and memory layout are typically handled by firmware, so they would ideally be managed by SeaBIOS.
>>>    However, in the current QEMU/SeaBIOS model, E820 and SRAT are built on the QEMU side, and pushing HDM decoder programming
>>>    into SeaBIOS would introduce additional complexity and risk inconsistencies.
>>>
> Ignore my previous suggestion and listen to Jonathan :)

Thank you very much for taking the time to review my patches!

I will follow Jonathan's suggestion and explore moving the HDM decoder
programming and E820 updates to SeaBIOS, while updating the SRAT in QEMU
via acpi_build_update() for v2.

Best regards,
Yukiya


>
> Thanks,
> Anisa
>
>> Hi again,
>>
>> Thank you for your contribution. I think this series can be valuable for
>> helping test autodiscovery in the kernel driver. I spent more time looking over this
>> patchset and in my view, the main blockers for making this ready for upstream are:
>>
>> 1.The HPA state is kept in the wrong place.
>> Patch 2 adds hpa_offset, idx and node to CXLType3Dev but and endpoint should
>> not track host state.
>>
>> I also think it makes more sense to make program-dhm-decoder a machine
>> option (-M program-hdm-decoder...) instead of having it on cxl-type3
>> endpoint
>>
>> 2. Host bridge register init moved from reset to realize.
>> As you mentioned below, "The current implementation prevents the host
>> bridge HDM decoder configuration from being overwritten later in the same reset
>> by moving the common initialization of the host bridge component registers from
>> the reset path to the realization path."
>>
>> To more accurately emulate what firmware does, maybe you can try
>> something like the following?
>>
>> 1. Add program-hdm option to machine (hw/cxl/cxl-host.c, include/hw/cxl/cxl.h)
>>
>> typedef struct CXLState {
>>      bool is_enabled;
>> +   bool program_hdm_decoders;
>>      ...
>> } CXLState;
>>
>> +static void machine_set_hdm_auto(Object *obj, Visitor *v, const char *name,
>> +                                 void *opaque, Error **errp)
>> +{
>> +    CXLState *cxl_state = opaque;
>> +    bool value;
>> +
>> +    if (!visit_type_bool(v, name, &value, errp)) {
>> +        return;
>> +    }
>> +    cxl_state->program_hdm_decoders = value;
>> +}
>>
>>   void cxl_machine_init(Object *obj, CXLState *state)
>>   {
>>       ...
>> +    object_property_add(obj, "cxl-hdm-auto", "bool", machine_get_hdm_auto,
>> +                        machine_set_hdm_auto, NULL, state);
>> +    object_property_set_description(obj, "cxl-hdm-auto",
>> +                                    "Set on/off to have HDM decoders "
>> +                                    "programmed at reset as firmware would");
>>
>> 2. Add cxl_fmws_program_decoders() to pxb_cxl reset exit.
>> Every device has 3 reset phase: enter, hold, and exit. Currently,
>> pxb-cxl has:
>> - enter = none
>> - hold = pxb_cxL-dev_reset(), which zeroes registers
>> - exit = none
>>
>> Register cxl_fmws_program_decoders() to pxb-cxl reset exit.
>>
>> cxl-host.c:
>> +void cxl_fmws_for_each_auto_range(PXBCXLDev *pxb)
>> {
>>
>> + /* use existing helper cxl_fmws_get_all_sorted to iterate */
>> + GSList *fws = cxl_fmws_get_all_sorted(), *it;
>> +
>> +for (it = fws; it; it = it->next) {
>> +    CXLFixedWindow *fw = CXL_FMW(it->data);
>> 	/* program decoders here */
>>
>> +    }
>> }
>>   ...
>>
>> +/* Call from the pxb-cxl reset exit phase, see pxb_cxl_dev_reset_exit() */
>> +void cxl_fmws_program_decoders(PXBCXLDev *pxb)
>> +{
>> +    cxl_fmws_for_each_auto_range(pxb);
>> +}
>>
>> --- a/hw/pci-bridge/pci_expander_bridge.c
>> +++ b/hw/pci-bridge/pci_expander_bridge.c
>>   #include "hw/cxl/cxl.h"
>> +#include "hw/cxl/cxl_host.h"
>>
>> +static void pxb_cxl_dev_reset_exit(Object *obj, ResetType type)
>> +{
>> +    PXBCXLDev *pxb = PXB_CXL_DEV(obj);
>> +    PXBCXLDevClass *pc = PXB_CXL_DEV_GET_CLASS(obj);
>> +
>> +    if (pc->parent_phases.exit) {
>> +        pc->parent_phases.exit(obj, type);
>> +    }
>> +    if (pxb->cxl_state && pxb->cxl_state->program_hdm_decoders) {
>> +        cxl_fmws_program_decoders(pxb);
>> +    }
>> +}
>> +
>> static void pxb_cxl_dev_class_init(ObjectClass *klass, const void *data)
>>   {
>> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
>>       ...
>>       device_class_set_legacy_reset(dc, pxb_cxl_dev_reset);
>> +    rc->phases.exit = pxb_cxl_dev_reset_exit;
>>   }
>>
>> This way, we shouldn't need to store the extra state (hpa_offset,etc.)
>> in the cxl-type3 endpoints.
>>
>> I'm also not that familiar with the machine initialization and reset
>> stages, so maybe this approach doesn't work, but this is my best guess.
>>
>> Thanks,
>> Anisa
>>
>>> Testing
>>>    We ran tests in the following environment and confirmed that CXL regions were created at boot, NUMA nodes were set up,
>>>    and E820_SOFT_RESERVED entries appeared in the E820 table:
>>>
>>>    - BIOS: SeaBIOS c2a33ad9ad1452e23b41c4ac44a3bc6be8ebc4cf
>>>    - CXL memory: 4 GB
>>>    - CFMWS: 4 GB
>>>    - Host bridge: 1
>>>
>>>    The following is the startup script.
>>>
>>>    sudo /path/to/qemu/build/qemu-system-x86_64 \
>>>      -name guest=cxl \
>>>      -nographic \
>>>      -machine q35,accel=tcg,nvdimm=on,cxl=on \
>>>      -cpu max -smp 4,sockets=4,cores=1,threads=1 \
>>>      -m size=4G,slots=10,maxmem=20G \
>>>      -drive file=/path/to/image.qcow2,format=qcow2,index=0,media=disk,id=hd \
>>>      -bios /path/to/seabios/out/bios.bin \
>>>      -nic bridge,br=virbr0,model=e1000e,mac=52:54:00:b5:4e:7c \
>>>      -object memory-backend-ram,size=2G,id=m0 \
>>>      -object memory-backend-ram,size=2G,id=m1 \
>>>      -numa node,nodeid=0,cpus=0-1,memdev=m0 \
>>>      -numa node,nodeid=1,cpus=2-3,memdev=m1 \
>>>      -device pcie-root-port,id=pci-root,slot=4,bus=pcie.0,chassis=0 \
>>>      -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1,hdm_for_passthrough=true \
>>>      -device cxl-rp,port=0,id=root_port13,bus=cxl.1,chassis=0,slot=2 \
>>>      -object memory-backend-ram,size=4G,share=on,id=vmem0 \
>>>      -device cxl-type3,bus=root_port13,volatile-memdev=vmem0,id=cxl-vmem0,program-hdm-decoder=true \
>>>      -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k
>>>    
>>>    Furthermore, we conducted the experiment in which we added two CXL Type3.
>>>
>>>    - CXL memory: 4 GB × 2
>>>    - CFMWS: 4 GB × 2
>>>
>>>    The following is the startup script.
>>>      
>>>    sudo /path/to/qemu/build/qemu-system-x86_64 \
>>>      -name guest=cxl \
>>>      -nographic \
>>>      -machine q35,accel=tcg,nvdimm=on,cxl=on,hmat=on \
>>>      -cpu max -smp 4,sockets=4,cores=1,threads=1 \
>>>      -m size=4G,slots=10,maxmem=20G \
>>>      -drive file=/path/to/image.qcow2,format=qcow2,index=0,media=disk,id=hd \
>>>      -bios /path/to/seabios/out/bios.bin \
>>>      -nic bridge,br=virbr0,model=e1000e,mac=52:54:00:b5:4e:7c \
>>>      -object memory-backend-ram,size=2G,id=m0 \
>>>      -object memory-backend-ram,size=2G,id=m1 \
>>>      -numa node,nodeid=0,cpus=0-1,memdev=m0 \
>>>      -numa node,nodeid=1,cpus=2-3,memdev=m1 \
>>>      -device pcie-root-port,id=pci-root,slot=4,bus=pcie.0,chassis=0 \
>>>      -device pcie-root-port,id=pci-root-net,chassis=5,slot=5,bus=pcie.0 \
>>>      -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1,hdm_for_passthrough=true \
>>>      -device cxl-rp,port=0,id=root_port13,bus=cxl.1,chassis=0,slot=2 \
>>>      -device cxl-rp,port=3,id=root_port14,bus=cxl.1,chassis=2,slot=4 \
>>>      -object memory-backend-ram,size=4G,share=on,id=vmem0 \
>>>      -object memory-backend-ram,size=4G,share=on,id=vmem1 \
>>>      -device cxl-type3,bus=root_port13,volatile-memdev=vmem0,id=cxl-vmem0,program-hdm-decoder=true \
>>>      -device cxl-type3,bus=root_port14,volatile-memdev=vmem1,id=cxl-vmem1,program-hdm-decoder=true \
>>>      -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k,cxl-fmw.1.targets.0=cxl.1,cxl-fmw.1.size=4G,cxl-fmw.1.interleave-granularity=4k
>>>
>>>
>>> How to use
>>>    Specify the following parameters when starting QEMU:
>>>
>>>    - bios <SeaBIOS binary that includes commit c2a33ad9ad1452e23b41c4ac44a3bc6be8ebc4cf> to ensure that E820_SOFT_RESERVED entries are exposed
>>>    - Add hmat=on to the -machine option [1]
>>>    - Add program-hdm-decoder=true to each -device cxl-type3 option
>>>      [1] On Linux, the kernel first checks E820_SOFT_RESERVED ranges. When multiple CXL Type 3 devices share a contiguous HPA range,
>>>          these ranges tend to be merged into a single region, so the CXL driver cannot reliably initialize per‑device regions based on E820 alone.
>>>          SRAT entries for CXL memory are therefore needed, and the guest seems to discard SRAT when `hmat=on` is not specified,
>>>          so HMAT must be enabled.
>>>
>>> QEMU base commit: bddb785e791e415db38884848d068457e226f5e3
>>>
>>> TODO
>>>    With the current implementation of this patch, the following configurations are either not supported or have not been sufficiently tested.
>>>    As a result, automatic creation of CXL regions in the guest OS may fail:
>>>
>>>    - A CXL persistent memory device is included
>>>    - Interleaved configurations
>>>    - Cases where the memory size specified by CFMWS does not match the size of the CXL Type 3 backend memory
>>>    - Configurations where CXL memory is attached via a switch
>>>    - Multi-target CFMWS environments
>>>    - ARM environments
>>>    - HMAT does not yet include information about CXL memory devices
>>>
>>>    The following behaviors are also provisional implementations and may need further refinement:
>>>     - A new NUMA node ID is assigned to each CXL memory device. This should be improved either to reflect more accurate NUMA distances for CXL memory,
>>>       or to allow the NUMA node IDs to be specified by the user.
>>>     - Assignment of CXL Type 3 devices to CFMWS address ranges. On physical systems, platform firmware typically generates CFMWS entries
>>>       based on the detected CXL topology and its address-space allocation. In QEMU, however, CFMWS entries are configured explicitly
>>>       through machine options. The current implementation therefore has to infer which CFMWS range should be used for each Type 3 device.
>>>       This selection logic may need further refinement. Possible approaches include improving the selection and validation logic,
>>>       adding an explicit option to associate each Type 3 device with a CFMWS entry,
>>>       or generating CFMWS entries automatically from the configured CXL topology and devices.
>>>     - HDM decoder reset sequencing and state reconstruction.
>>>       The current implementation prevents the host bridge HDM decoder configuration from being overwritten later in the same reset
>>>       by moving the common initialization of the host bridge component registers from the reset path to the realization path.
>>>       However, ideally, after the registers have been restored to their reset values, the host bridge HDM decoder configuration
>>>       automatically programmed by QEMU should be reconstructed as part of reset processing.
>>>
>>> Thanks,
>>>
>>> ------
>>>
>>> Yukiya Takaki (7):
>>>    QEMU/hw/cxl: add program-hdm-decoder option for CXL Type 3 devices
>>>    QEMU/hw/cxl:add HPA offset tracking for CXL Type 3 devices
>>>    QEMU: hw/cxl: add helper to get HPA range for CXL Type 3
>>>    QEMU/hw/cxl: auto‑program HDM decoders for CXL Type 3
>>>    QEMU/hw/cxl: expose CXL Type 3 ranges as E820_SOFT_RESERVED on x86
>>>    QEMU/hw/cxl: Create NUMA nodes for CXL Type 3 memory
>>>    add CXL Type 3 memory ranges to SRAT
>>>
>>>   hw/acpi/cxl_type3.c                 |  30 +++++
>>>   hw/acpi/meson.build                 |   1 +
>>>   hw/arm/cxl.c                        |  10 ++
>>>   hw/arm/meson.build                  |   2 +
>>>   hw/cxl/cxl-host.c                   |  63 ++++++++++
>>>   hw/i386/acpi-build.c                |   7 ++
>>>   hw/i386/cxl.c                       |  11 ++
>>>   hw/i386/meson.build                 |   1 +
>>>   hw/i386/pc.c                        |   2 +
>>>   hw/mem/cxl_type3.c                  | 177 ++++++++++++++++++++++++++++
>>>   hw/pci-bridge/pci_expander_bridge.c |  13 +-
>>>   include/hw/cxl/cxl.h                |   2 +
>>>   include/hw/cxl/cxl_device.h         |   6 +
>>>   include/hw/cxl/cxl_host.h           |   3 +
>>>   include/hw/mem/cxl_type3.h          |   8 ++
>>>   15 files changed, 334 insertions(+), 2 deletions(-)
>>>   create mode 100644 hw/acpi/cxl_type3.c
>>>   create mode 100644 hw/arm/cxl.c
>>>   create mode 100644 hw/i386/cxl.c
>>>   create mode 100644 include/hw/mem/cxl_type3.h
>>>
>>> -- 
>>> 2.52.0
>>>
