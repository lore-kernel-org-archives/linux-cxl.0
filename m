Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794076752;
	b=ZF0TaB+72mAphh7Q1NPTGnPYe1ynVnR1mPFIYcj1aXLatMU3TbBZnES3aSfjRiasKaKf
	 fzPSyuKsiTnQmvS/R/NP6qt2u/ZZjBGWKxG8SzaeiVXKbXvgIkyjczukpYocM6RbJ5mKN
	 o0G6F8AaoVOnp2NWs9s6qOVOSq4ia0ypyIkZzHUuXO/IhAlGSsjf8IFBZhXdxOyYT+8U8
	 oBPKFy/j+Stu+EHl4m/XCqmZ/bePQKK5K85W3hc2qoQ486YIidylxOeXIASQQK/DUnO3+
	 n0tFjq6/696e2sqNSzsqpWyGFPn8wYHc5XL4LxRo/0toATrj8leOrwF3e+2tLt8/AVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794076752;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=YpEg/lDvlZA/9XSlQlgteWdrCWq9LNtbMiRiaSbaG98=;
	b=oNfNxsJvA2KqFne88/ToKhjDkSepMmB1RvdvXFKGCPABC9fBz/FwHo8rLvLHePymYcLN
	 cKfWYZXvym6ZZg4FkfuG6l+9aoHPPhE2cCTfaB/7smQv6fQI1zBYdkRj7ObCwj6QyoVpO
	 zEYS8ZGP04121IHQvbAXZsF9buQjktSH1ZJWXQb4yFuvIsclxiSe4tFlWDqry9tsQlade
	 JnLfcs4vulpOs4C3DYqPyq/eBaxnWfW5sYMXU2rih8v7o28V/ygCUoRe0elHsHsN4Jgg5
	 AkGi/XpaMnmzFZ/cU+De1Hl4+GzjPoiPTynj+6C0RHNVTKt7B2CD87S4SIBvm+73GVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OynjPoV7;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB02606A326
	for <linux-cxl@vger.kernel.org>; Sat,  7 Nov 2026 18:39:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EB02606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OynjPoV7
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-36eb1cb7aabso2679576eec.0
        for <linux-cxl@vger.kernel.org>; Sat, 07 Nov 2026 10:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794076750; x=1794681550; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YpEg/lDvlZA/9XSlQlgteWdrCWq9LNtbMiRiaSbaG98=;
        b=OynjPoV7F+80QFHifu2Psd0/opHjdzAPLJloFFN+yEI0Yb8+O+zXdK9pezCQsAlv3q
         tyAP+JyqVDqXgwRlULU6vBm72Pl9u3d2QVv3tsUx7e3wIZdgh8XMHX7oDK2yO4tXQW9q
         MXlkmGw0to3TCYIxpKrkCuQFqgBgvRHyCbQpHHJNEICREKfB1EzcgR1xiu1RX0hswCt9
         9NYgkRyEc5J5sFd8EyBpxLpT9Asl64mP7FiSz5D2ShyRb1CVoecEKt/vvnplUvWK50aU
         icwMC3RR0iXO9gQ6+vqFs38VDZxk7++Nc3KnwBx5SdN2axh9x38keY6RrhtWpkviahIM
         HMGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794076750; x=1794681550;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YpEg/lDvlZA/9XSlQlgteWdrCWq9LNtbMiRiaSbaG98=;
        b=hFGTBNnA2WLS5ZfRMZoi2JXfVcfCIQv+Rwz2FtpbOQt7zs1dS9Og3rXLzY8y8vOnJJ
         QelFs9OUOSFUZUTxH61gCxmDu5sQDNbGKK8VGUuQcjjufvE5Y5yA1cHeFLJgNYe9d2Sq
         qwKXBbitUeRbFw4jmwcUvmrqGhGdwqNWk1nlXjS0t7vCjALEHHGSynCYaF24BL/OLpqI
         0W34IW8R7EV4Wz9A+X21VWNRca6QdmX/fGXCBINC75Opy47NaHYuSDuIwGuJ+6vORq10
         i2bbYL4BgK8I1plaG8hTQQ8aBJhnr2QnGSW4ZOpHRhJKkpPEEJztACdHOxufdwQOxoUc
         hSFQ==
X-Forwarded-Encrypted: i=1; AL+hErHRNBynaP1A3CLCIuNvpxA9Gy6QeBETYHHglYTNy0P5M/ScW4o/VhggLUxNa1hUup2CEzrw2iZlBHM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/oVOpK1rZxaUDBwuYGPnvAFuHhqJg87GeRfw640aQgWJFk90Ee
	/HVAI7nDXphCF23rcXSQUwapPGn77zBmVsltS7XfbpvyEuzBglj7O8zZP57PAA==
X-Gm-Gg: AYBFou0+TQi4vOF8zpn4LRvshyQSoljj330AuhB1/x5YPfVVsVr7VWbZksiwDDU4qlc
	KBBqb2h1U1whGrSNHmYeV0yr8e6BqxPNLSW/OxtbRDQZ/u6iOmCCualK/hFq8vYODZdNnqgxCtT
	Th8BsY08vH7NpRXSE/cwmXfKdmjCnfW1UTGtiP1PHFmi4Dnamkjb03X4zQhkLnyb9Ra8sNvbY8E
	lveX6phO4s7FKmXvq8iK4+jDi5wif8U2eGnD7/HaTOPSB0I6Tlw/wofkowQYVWNfeUXAO8XXuhK
	KYrj16qnEnxOu2Cq27X3VSA99SxEQpuARJpSKMVqHc2+EKK12qfPX1bFYnGvJcjYuTR+PERw+Fy
	Xoh7BnYpzLzXKve63J801TU9cXxzc++CIiaa0cn32ALKdY1JCzl7uIPOO1/MagIHGhuNif4ORKe
	ljzc8osP9u5hb6RuAKGi9rvDQATiBwTe9Smtsao57SrUtLYmhiiNcxmOZBn1QH229LlEIlIvufe
	CxWF+tO1uibhDAaj02+g25O4EqTyxXh/ocxdMnPfWEQHjCnRYXLi7NxNOUlaH09ELfbfN7gPnCE
	3i5T2kVexiT4l7jgbvlU7H0iM64b+9+er7CPIzytjBlPWF9vpEcvDZI6tMX9wLTNYrF6tkY4rw=
	=
X-Received: by 2002:a05:693c:80c1:b0:36a:1732:1e7 with SMTP id 5a478bee46e88-36f76d0f26emr8522418eec.31.1794076750215;
        Sat, 07 Nov 2026 10:39:10 -0800 (PST)
Received: from ?IPV6:240d:1a:8bb:4a00:40e6:d5b1:9360:f028? ([240d:1a:8bb:4a00:40e6:d5b1:9360:f028])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36faa4b4680sm17118089eec.20.2026.11.07.10.39.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Nov 2026 10:39:09 -0800 (PST)
Message-ID: <0b67947b-e4ee-4e47-b61f-c6ae06501298@gmail.com>
Date: Sun, 8 Nov 2026 03:39:06 +0900
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
To: Jonathan Cameron <jic23@kernel.org>, Yukiya Takaki <fj2110jc@fujitsu.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Anisa Su <anisa.su@samsung.com>,
 Igor Mammedov <imammedo@redhat.com>, Junjie Cao <junjie.cao@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>, linux-cxl@vger.kernel.org,
 qemu-arm@nongnu.org, "Wolski, Tomasz" <tomasz.wolski@fujitsu.com>,
 lizhijian@fujitsu.com, y-goto@fujitsu.com
References: <cover.1793003983.git.fj2110jc@fujitsu.com>
 <20261105215411.33262db7@jic23-hlaptop>
Content-Language: en-US
From: Yukiya Takaki <yukiya.takaki@gmail.com>
In-Reply-To: <20261105215411.33262db7@jic23-hlaptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jonathan,

Thank you for your suggestion.

> On Mon, 26 Oct 2026 19:03:21 +0900
> Yukiya Takaki <fj2110jc@fujitsu.com> wrote:
>
>> Hello everyone,
>>
>> I’m a student intern, and this is my first time sending patches to an open source mailing list.
>>
>> This patch series configures QEMU’s CXL Type 3 devices so that guest operating systems can automatically discover
>> and create CXL regions during boot, aligning QEMU’s behavior with real hardware.
> Hi Yukiya,
>
> Interesting project.
>
>> Background and motivation
>>    Currently, during guest boot QEMU does not provide the information or register programming needed for the guest OS
>>    to initialize CXL Type 3 memory, so using it still requires an explicit action in the guest (for example, running the cxl create-region command).
>>    By contrast, on some physical systems the firmware automatically allocates CXL memory ranges and exposes them to the OS,
>>     allowing the Linux CXL driver to discover and create regions during boot.
>>    This patch series is a first, experimental attempt to reproduce that behavior in QEMU.
>>
>>    Some parts of this implementation are based on Li, Zhijian’s work in:
>>    https://github.com/zhijianli88/qemu/tree/program-decoder-v2
>>
>>    I would like to ask for feedback on whether this approach makes sense and whether I should continue to enhance it.
>>
>> Approach
>>    This patch first adds a program_hdm_decoder option to cxl-type3.
>>    When program-hdm-decoder is enabled on cxl-type3, QEMU will:
>>      1) program endpoint/host-bridge HDM decoder state,
>>      2) expose Type 3 ranges as E820_SOFT_RESERVED on x86,
>>      3) create memory-only NUMA nodes for those ranges,
>>      4) emit SRAT memory-affinity entries mapping each Type 3 HPA range to its node ID
>>
>>    On real hardware, HDM decoder programming and memory layout are typically handled by firmware, so they would ideally be managed by SeaBIOS.
>>    However, in the current QEMU/SeaBIOS model, E820 and SRAT are built on the QEMU side, and pushing HDM decoder programming
>>    into SeaBIOS would introduce additional complexity and risk inconsistencies.
> So, did you explore doing this in a similar fashion to PCI enumeration?
>
> That's done the bios and is very similar in that there is a mix of
> policy and rules in how it is configured that we really don't want
> in qemu.  With that ACPI tables are then built in QEMU that contain
> values read back from what was setup. The main thing I'm thinking of
> here is the PXB handling that relies on the bios having done the
> PCI enumeration first rather than doing it in qemu.
> The arm code is here
> https://elixir.bootlin.com/qemu/v11.1.3/source/hw/pci-host/gpex-acpi.c#L103
> x86 probably this:
> https://elixir.bootlin.com/qemu/v11.1.3/source/hw/i386/acpi-build.c#L1038
>
> My immediate instinct is that would look more like a conventional bios
> flow.  It would also have the significant benefit of putting the enumerating
> and configuration code into an open source bios, something I hoped would come out
> early ARM work on this (see linux plumbers - I think this is right session)
> https://lpc.events/event/16/contributions/1254/attachments/1113/2136/CXL%20Type-3%20device%20discovery,%20configuration%20in%20firmware%20and%20prepare%20ACPI%20tables%20for%20kernel%20usage.pdf
>
> Then we'd regenerate the SRAT, HMAT etc before handling to the OS.
> (I'm not sure this works for e820 having never touched that flow).
>
> There is a lot of policy involved in CXL configuration and I'd not
> want to replicate that part in QEMU. At best we'd want to pass
> some hints to the bios.
>
> Flow wise that would mean adding to acpi_build_update() some code
> to do the necessary srat and other table updates.  That would
> definitely work for the actual ACPI tables, but I gather e820 is
> rather different...  However, e820 real table is I think
> actually constructed by seabios so can that just make the
> necessary updates after programming the CXL decoders etc?
>
> Now if you did this on SBSA-ref and arm you'd have to do it
> all in the bios (as that generates everything) and the whole
> problem would be much more standard.
>
> Given we have that option on arm/sbsa-ref I don't currently
> see a reason to explore the bios flows on arm/virt.
>
> I also gather (from asking an LLM so might be wrong) that there
> are options that boot qemu on x86 with tables generated
> by the bios, not qemu.  Legacy path in seabios, coreboot and
> and ovmf path used with xen.  Maybe working with them avoids
> the extra complexity of bounce backwards and forwards between
> qemu and the firmware (though I think I'd probably avoid these).
>
> Anyhow, interested to see where you go with this.
> Definitely useful for those of us working with platforms that
> never do the bios programmed flow but have to test it when
> making changes!
>
> Jonathan

I was not aware of how the PCI enumeration and acpi_build_update() flow 
works.
Using this approach, I think we can automatically configure CXL Type 3 
memory
while keeping the allocation policy on the BIOS side, and then have QEMU
update the SRAT based on the programmed decoders.

Also, although I have only looked into the SeaBIOS code so far, some E820
entries are indeed added directly in SeaBIOS, so I think we can insert the
E820_SOFT_RESERVED entries on the SeaBIOS side as well.

I will work on v2 using this approach.

Best regards,
Yukiya


>> Testing
>>    We ran tests in the following environment and confirmed that CXL regions were created at boot, NUMA nodes were set up,
>>    and E820_SOFT_RESERVED entries appeared in the E820 table:
>>
>>    - BIOS: SeaBIOS c2a33ad9ad1452e23b41c4ac44a3bc6be8ebc4cf
>>    - CXL memory: 4 GB
>>    - CFMWS: 4 GB
>>    - Host bridge: 1
>>
>>    The following is the startup script.
>>
>>    sudo /path/to/qemu/build/qemu-system-x86_64 \
>>      -name guest=cxl \
>>      -nographic \
>>      -machine q35,accel=tcg,nvdimm=on,cxl=on \
>>      -cpu max -smp 4,sockets=4,cores=1,threads=1 \
>>      -m size=4G,slots=10,maxmem=20G \
>>      -drive file=/path/to/image.qcow2,format=qcow2,index=0,media=disk,id=hd \
>>      -bios /path/to/seabios/out/bios.bin \
>>      -nic bridge,br=virbr0,model=e1000e,mac=52:54:00:b5:4e:7c \
>>      -object memory-backend-ram,size=2G,id=m0 \
>>      -object memory-backend-ram,size=2G,id=m1 \
>>      -numa node,nodeid=0,cpus=0-1,memdev=m0 \
>>      -numa node,nodeid=1,cpus=2-3,memdev=m1 \
>>      -device pcie-root-port,id=pci-root,slot=4,bus=pcie.0,chassis=0 \
>>      -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1,hdm_for_passthrough=true \
>>      -device cxl-rp,port=0,id=root_port13,bus=cxl.1,chassis=0,slot=2 \
>>      -object memory-backend-ram,size=4G,share=on,id=vmem0 \
>>      -device cxl-type3,bus=root_port13,volatile-memdev=vmem0,id=cxl-vmem0,program-hdm-decoder=true \
>>      -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k
>>    
>>    Furthermore, we conducted the experiment in which we added two CXL Type3.
>>
>>    - CXL memory: 4 GB × 2
>>    - CFMWS: 4 GB × 2
>>
>>    The following is the startup script.
>>      
>>    sudo /path/to/qemu/build/qemu-system-x86_64 \
>>      -name guest=cxl \
>>      -nographic \
>>      -machine q35,accel=tcg,nvdimm=on,cxl=on,hmat=on \
>>      -cpu max -smp 4,sockets=4,cores=1,threads=1 \
>>      -m size=4G,slots=10,maxmem=20G \
>>      -drive file=/path/to/image.qcow2,format=qcow2,index=0,media=disk,id=hd \
>>      -bios /path/to/seabios/out/bios.bin \
>>      -nic bridge,br=virbr0,model=e1000e,mac=52:54:00:b5:4e:7c \
>>      -object memory-backend-ram,size=2G,id=m0 \
>>      -object memory-backend-ram,size=2G,id=m1 \
>>      -numa node,nodeid=0,cpus=0-1,memdev=m0 \
>>      -numa node,nodeid=1,cpus=2-3,memdev=m1 \
>>      -device pcie-root-port,id=pci-root,slot=4,bus=pcie.0,chassis=0 \
>>      -device pcie-root-port,id=pci-root-net,chassis=5,slot=5,bus=pcie.0 \
>>      -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1,hdm_for_passthrough=true \
>>      -device cxl-rp,port=0,id=root_port13,bus=cxl.1,chassis=0,slot=2 \
>>      -device cxl-rp,port=3,id=root_port14,bus=cxl.1,chassis=2,slot=4 \
>>      -object memory-backend-ram,size=4G,share=on,id=vmem0 \
>>      -object memory-backend-ram,size=4G,share=on,id=vmem1 \
>>      -device cxl-type3,bus=root_port13,volatile-memdev=vmem0,id=cxl-vmem0,program-hdm-decoder=true \
>>      -device cxl-type3,bus=root_port14,volatile-memdev=vmem1,id=cxl-vmem1,program-hdm-decoder=true \
>>      -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k,cxl-fmw.1.targets.0=cxl.1,cxl-fmw.1.size=4G,cxl-fmw.1.interleave-granularity=4k
>>
>>
>> How to use
>>    Specify the following parameters when starting QEMU:
>>
>>    - bios <SeaBIOS binary that includes commit c2a33ad9ad1452e23b41c4ac44a3bc6be8ebc4cf> to ensure that E820_SOFT_RESERVED entries are exposed
>>    - Add hmat=on to the -machine option [1]
>>    - Add program-hdm-decoder=true to each -device cxl-type3 option
>>      [1] On Linux, the kernel first checks E820_SOFT_RESERVED ranges. When multiple CXL Type 3 devices share a contiguous HPA range,
>>          these ranges tend to be merged into a single region, so the CXL driver cannot reliably initialize per‑device regions based on E820 alone.
>>          SRAT entries for CXL memory are therefore needed, and the guest seems to discard SRAT when `hmat=on` is not specified,
>>          so HMAT must be enabled.
>>
>> QEMU base commit: bddb785e791e415db38884848d068457e226f5e3
>>
>> TODO
>>    With the current implementation of this patch, the following configurations are either not supported or have not been sufficiently tested.
>>    As a result, automatic creation of CXL regions in the guest OS may fail:
>>
>>    - A CXL persistent memory device is included
>>    - Interleaved configurations
>>    - Cases where the memory size specified by CFMWS does not match the size of the CXL Type 3 backend memory
>>    - Configurations where CXL memory is attached via a switch
>>    - Multi-target CFMWS environments
>>    - ARM environments
>>    - HMAT does not yet include information about CXL memory devices
>>
>>    The following behaviors are also provisional implementations and may need further refinement:
>>     - A new NUMA node ID is assigned to each CXL memory device. This should be improved either to reflect more accurate NUMA distances for CXL memory,
>>       or to allow the NUMA node IDs to be specified by the user.
>>     - Assignment of CXL Type 3 devices to CFMWS address ranges. On physical systems, platform firmware typically generates CFMWS entries
>>       based on the detected CXL topology and its address-space allocation. In QEMU, however, CFMWS entries are configured explicitly
>>       through machine options. The current implementation therefore has to infer which CFMWS range should be used for each Type 3 device.
>>       This selection logic may need further refinement. Possible approaches include improving the selection and validation logic,
>>       adding an explicit option to associate each Type 3 device with a CFMWS entry,
>>       or generating CFMWS entries automatically from the configured CXL topology and devices.
>>     - HDM decoder reset sequencing and state reconstruction.
>>       The current implementation prevents the host bridge HDM decoder configuration from being overwritten later in the same reset
>>       by moving the common initialization of the host bridge component registers from the reset path to the realization path.
>>       However, ideally, after the registers have been restored to their reset values, the host bridge HDM decoder configuration
>>       automatically programmed by QEMU should be reconstructed as part of reset processing.
>>
>> Thanks,
>>
>> ------
>>
>> Yukiya Takaki (7):
>>    QEMU/hw/cxl: add program-hdm-decoder option for CXL Type 3 devices
>>    QEMU/hw/cxl:add HPA offset tracking for CXL Type 3 devices
>>    QEMU: hw/cxl: add helper to get HPA range for CXL Type 3
>>    QEMU/hw/cxl: auto‑program HDM decoders for CXL Type 3
>>    QEMU/hw/cxl: expose CXL Type 3 ranges as E820_SOFT_RESERVED on x86
>>    QEMU/hw/cxl: Create NUMA nodes for CXL Type 3 memory
>>    add CXL Type 3 memory ranges to SRAT
>>
>>   hw/acpi/cxl_type3.c                 |  30 +++++
>>   hw/acpi/meson.build                 |   1 +
>>   hw/arm/cxl.c                        |  10 ++
>>   hw/arm/meson.build                  |   2 +
>>   hw/cxl/cxl-host.c                   |  63 ++++++++++
>>   hw/i386/acpi-build.c                |   7 ++
>>   hw/i386/cxl.c                       |  11 ++
>>   hw/i386/meson.build                 |   1 +
>>   hw/i386/pc.c                        |   2 +
>>   hw/mem/cxl_type3.c                  | 177 ++++++++++++++++++++++++++++
>>   hw/pci-bridge/pci_expander_bridge.c |  13 +-
>>   include/hw/cxl/cxl.h                |   2 +
>>   include/hw/cxl/cxl_device.h         |   6 +
>>   include/hw/cxl/cxl_host.h           |   3 +
>>   include/hw/mem/cxl_type3.h          |   8 ++
>>   15 files changed, 334 insertions(+), 2 deletions(-)
>>   create mode 100644 hw/acpi/cxl_type3.c
>>   create mode 100644 hw/arm/cxl.c
>>   create mode 100644 hw/i386/cxl.c
>>   create mode 100644 include/hw/mem/cxl_type3.h
>>

