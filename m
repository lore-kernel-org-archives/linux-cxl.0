Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CFF3DD519
	for <linux-cxl@vger.kernel.org>; Wed, 24 Jun 2026 17:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782321701; cv=none; b=jbB4EVWdMG+iRp4T0VwBEIckk58NiwlNANNAVo8XA+473IUlb/aezPztm4VCGAtDVaLUDDxkXkp0ngesvKjZlZ/MRYD52nAnTPnrlAfxOxJgZQ0ilNqfDyaWVwmhVoW0xmTh5E3BUEoSyGYWaeg6FNwBTM4qRqNmMcoromEZ2i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782321701; c=relaxed/simple;
	bh=ChbWbppzlWEcqWQ8wOZ+7+vYywCRIr65myz45sCmHdQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HWRKHkLjW2+0GH5NQBO/YX0N8uzYFnuJyIjOX1gcxESPqdTdb3/LdPZOkdA0/ULH+O0tKW2R9Lvvz6AvogjtyV795ajqcQ1m1o34x4VKrX3JK1rWDvyjhL5H+wlesAxftWVq/3QBsAp8X1gJuOOwEfpWzV1wKCpQBucV14C5DRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=khfuI7kL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kmPx0kJK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="khfuI7kL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kmPx0kJK"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65OFfNpt3844902
	for <linux-cxl@vger.kernel.org>; Wed, 24 Jun 2026 17:21:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	z0A/4SjiYWXJjRjSBt/M4fA2Wa/xhI0L8g0aA+Jfe3s=; b=khfuI7kLkwbDgpQW
	w9myvXDTjI6wobwlJs83UDKdvPiEW9lecdR9qAqFSDsnZPeIwGjhXO5hWMV/VEV5
	qlnq99/Vudojh/7k2XllxoGs6XoiZh6tWHX1zbGeKibaWTiGnqKV/qY1LJ106qTt
	pwgbwgFWylWaatHSmJZXMPDtbsSQaDYn2HsxwEqe96ft6S+iT4JG+qbwqYSaSq1p
	eudreMFvzAqcH9q8KFC4HbvbeQs632/R8miqvEOhxyr70MX0SvuVM2gxzcGiailX
	pUWdEOK0/ICaIv4853Srg6jtqbODRorAmWhX9ZDnCxtCjNWZ6/LxFLMFnsEgOhYO
	13dbnQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f05ajkf7u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-cxl@vger.kernel.org>; Wed, 24 Jun 2026 17:21:36 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30c1f6c5559so1266681eec.0
        for <linux-cxl@vger.kernel.org>; Wed, 24 Jun 2026 10:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782321695; x=1782926495; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z0A/4SjiYWXJjRjSBt/M4fA2Wa/xhI0L8g0aA+Jfe3s=;
        b=kmPx0kJK8bKP3KMoM14H0ayXwOks5ALDqLgY7KZvL0UnJu6D0I6RNOE3Mu8Y339EJp
         +5yVyHavkfIiWQZ08TRGP0CrEWdUJy7wPJLCdnLc9WQEsNY67Zi0CW7L9Njv5y+q+Oxj
         ExdzD1ZQ2M6NaU8FU26IoeOXAycWiqpQsLhr7tnANQEKrAbm8yhRixfWmfJjCKoJj9BF
         j0RzokLcnyOrXLiUGw4Nz4yXU/0J+UWI5Lk3RFjqDEjoJemeSqHohUs9Lyqxbu/E/7zG
         F6EwhdPfi+G01zslE9Klloj7N3UiL7kdVR1bV8BvWvxCekmml8SxQVwnJ5U05/M3Newb
         LgwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782321695; x=1782926495;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z0A/4SjiYWXJjRjSBt/M4fA2Wa/xhI0L8g0aA+Jfe3s=;
        b=V1b764WoxI1lfmdGIsEmYfsuXHCWwYn4Zm6cVld9i/S8hFLTJw60wyPA4TZBlvUva/
         OGZofK5ABpHP260aqPglH5M66Wep+eh3waZat+Z/KprVWHNazuiqp+kOT4uk+RsZ3U0L
         a9LxN6QX7aL372E5rrIJntgHxQ0nleeQxsR43lwlpljhTOcWi0as7kuH094IzpXXxtkB
         j3k07tb/aTU01Y4RpZbkuSUALPcceUCIdqWW9yAyn26pjBrB8+9AhN2I6PeiX9uAnaxA
         0sSPDrLdWK6n9HpF5+cXu6RN1hWi4rGNH+sU3cybeJ7L2fwXXgsAz4RCR9ikAM4561l0
         jFHg==
X-Forwarded-Encrypted: i=1; AHgh+Rp2HtZFU+dBZEy9uA5dglglug6E6oGdGt8avu2pmknKCehfH/UaQSXHeUKqL2ruBrpLw53o0WpNkg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYDMMAy7HwA1NeT9ojJz97H6DU8ScdBytq4YyBh8eQovK18c7T
	xBtXebDc8SazrfTO4d3RJbKhtQW/9ox6gitucaVuqsODSVBejm+pp8LDnmS5Hx8odb7RZwKWD3+
	fv865JZD4iYy5bQ625c3y2t54fbbAakyFflbkdqM2bQAdlMQ3/O3WYunMitJ/0BA=
X-Gm-Gg: AfdE7cnVUOOg0V15ayr+CjU21V4VrHRjbfUTCJ2z7H8KxYQlF0w7DLNKCHrA+7F/6gY
	+ZM0wbp8tezhWk41NBTlUtNdnZCNwbQTA5y61YVrLTIC/o/8TUAV8jnVUWeZoGCjycjPYt8yOKd
	0AerYPUJThA0HuGcEAbgW9nQWOrd0w74KveYwNgLxrKEy5K/otbDDPqOQbFncEAZk4NTodUjBLf
	FSVo99IxjDdErgUcEI0IAGDeOcC1+rlWKNvBxfED7Dobv+viA7/qYkBZ5yByc7G6L+Ar334kyfR
	iK4RNcmpGp0z4a4P1CHOxDak07vt8/GdVq7Zchz2nzV+BbgscKZ2X8CQ9BJwrddeG8OY6Pf24ph
	ajVQaPYQr2ghxErnOHhJxhaF0NaQKih43OWjUIJQWRsQo
X-Received: by 2002:a05:7300:3256:b0:304:2cc9:2ba8 with SMTP id 5a478bee46e88-30c68e47e84mr4060554eec.30.1782321695093;
        Wed, 24 Jun 2026 10:21:35 -0700 (PDT)
X-Received: by 2002:a05:7300:3256:b0:304:2cc9:2ba8 with SMTP id 5a478bee46e88-30c68e47e84mr4060497eec.30.1782321694308;
        Wed, 24 Jun 2026 10:21:34 -0700 (PDT)
Received: from [192.168.68.103] ([189.79.21.40])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7ca87caasm483524eec.27.2026.06.24.10.21.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 10:21:32 -0700 (PDT)
Message-ID: <79017627-4888-415a-9686-16367490b5b5@oss.qualcomm.com>
Date: Wed, 24 Jun 2026 14:21:24 -0300
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] hw/riscv/virt,gpex: Provide 32-bit MMIO window for
 CXL host bridges
To: Chen Pei <cp0613@linux.alibaba.com>, jic23@kernel.org, pbonzini@redhat.com,
        palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
        zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
        sunilvl@ventanamicro.com, dave.jiang@intel.com,
        alison.schofield@intel.com, imammedo@redhat.com, mst@redhat.com,
        guoren@kernel.org
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, linux-cxl@vger.kernel.org
References: <20260618093827.3507-1-cp0613@linux.alibaba.com>
 <20260618093827.3507-4-cp0613@linux.alibaba.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260618093827.3507-4-cp0613@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDE0NCBTYWx0ZWRfX7Acbz4UaCYQz
 V8h6V743DrvehNRBb5eodLrIGkaShGyO+6Az9pIxryTekM4CtC6hYAMWzhZ7Zqww13KrJFbXpsG
 tT2RVTX7zQAqDDdGgXUwVm/2MhEsYY8=
X-Proofpoint-GUID: US0dqbbkLoEP1zK44tGbscmRn7vN39cI
X-Proofpoint-ORIG-GUID: US0dqbbkLoEP1zK44tGbscmRn7vN39cI
X-Authority-Analysis: v=2.4 cv=DbUnbPtW c=1 sm=1 tr=0 ts=6a3c1220 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=SRrdq9N9AAAA:8 a=YeOTPVOvUyn0jVLZ81oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDE0NCBTYWx0ZWRfXyz5lfqf2uNzh
 yFyWQ44biIiUPME3sqoQkNLRsWioCWUTM6Vlt+yjG5b92Od2Tm7LYw7mIEUR/bds1UNTF5Z3IQ/
 7i8rIahoLLOz9HJoO5lmOW9YF5zlaPkdaYRd7xs0xdiRNQVnct2YLYc/vhxN+SEQxgTsA8371SP
 cmwZnZomlldv4udta9w8cCTWDdMs3snr7qW5QE5t8Zl5G/J9MJFtr6aLUsizLVF3korKrETquyv
 SJmKuYKUm86Q72auPLpg5LKxNMr/fA8KbdoLskqWZVldzeSgYA3rKICATL5r06O2UXCVTSRxREB
 rSRQnLC732aFLm3bbhtDtWoRkIUPAPW0NcgzuBsW8W//HVi9gsPwcBqyTXks6zQXwDdpGBugK3R
 djgJCp6Xd1gYt+z5b79VEMYGX9Xt+A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2606240144



On 6/18/2026 6:38 AM, Chen Pei wrote:
> CXL component register BAR (BAR0 on CXL Root Port and Type3 device)
> and the CXL device register BAR (BAR2 on Type3 device) are declared
> as 64-bit non-prefetchable memory.  Per the PCI-to-PCI Bridge
> Architecture Specification Rev 1.2 (PCI-SIG, 2003):
> 
>    - §3.2.5.8 (Memory Base/Limit): the non-prefetchable window covers
>      only 32-bit addresses (AD[31:20]); the Type 1 header defines no
>      upper-32-bit extension for it.
>    - §3.2.5.9 (Prefetchable Memory Base/Limit): the bottom 4 bits
>      encode 64-bit support (01h), but this applies exclusively to the
>      *prefetchable* window.
>    - §3.2.5.10 (Prefetchable Base/Limit Upper 32 Bits): optional
>      registers for AD[63:32] of the prefetchable range only.
> 
> The architecture therefore allows a 64-bit window only when it is also
> prefetchable; there is no 64-bit non-prefetchable form.  PCIe inherits
> this Type 1 header layout unchanged.  Linux thus places 64-bit
> non-prefetchable BARs in the 32-bit non-prefetchable bridge window,
> which requires the bridge to own enough address space below 4 GiB.
> 
> On RISC-V virt the 32-bit PCIe MMIO range (1 GiB at 0x40000000) is
> currently consumed entirely by PCI0, so CXL host bridges (ACPI0016)
> have no non-prefetchable window and Linux fails to assign these BARs.
> Marking the BARs prefetchable would work around it, but the CXL
> component registers have read/write side effects and are not
> prefetchable per the PCIe specification.
> 
> Reserve the top 256 MiB of the 32-bit MMIO window exclusively for
> CXL host bridges:
> - Shrink PCI0's mmio32 window by 256 MiB in virt.c so that UEFI's
>    PciHostBridgeDxe and the ACPI _CRS for PCI0 never claim that range
> - Store the reserved range in a new gpex_cfg.cxl_mmio32 field
> - In gpex-acpi.c, emit the cxl_mmio32 range as the Memory resource
>    in the CXL host bridge _CRS instead of re-using build_crs() (which
>    returns an empty set when UEFI has not assigned resources yet)
> - Reduce the FDT 'ranges' for PCI0 by the same 256 MiB so that UEFI
>    firmware driven by device-tree also respects the reservation
> 
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
> ---
>   hw/pci-host/gpex-acpi.c    | 36 +++++++++++++++++++++--
>   hw/riscv/virt.c            | 58 +++++++++++++++++++++++++++++++-------
>   include/hw/pci-host/gpex.h |  1 +
>   3 files changed, 83 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
> index d9820f9b41..d8b943b665 100644
> --- a/hw/pci-host/gpex-acpi.c
> +++ b/hw/pci-host/gpex-acpi.c
> @@ -158,9 +158,41 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
>                * Resources defined for PXBs are composed of the following parts:
>                * 1. The resources the pci-bridge/pcie-root-port need.
>                * 2. The resources the devices behind pxb need.
> +             *
> +             * For CXL host bridges on platforms where UEFI (driven by
> +             * FDT 'ranges') does not assign PCI resources for the CXL
> +             * root bridge before ACPI table construction, build_crs()
> +             * would return an empty resource set.  When the platform
> +             * has reserved a dedicated MMIO window for CXL host bridges
> +             * (cfg->cxl_mmio32), emit that window as a static _CRS
> +             * instead.  The platform is responsible for shrinking PCI0's
> +             * mmio32 window so the two do not overlap.
>                */
> -            crs = build_crs(PCI_HOST_BRIDGE(BUS(bus)->parent), &crs_range_set,
> -                            cfg->pio.base, 0, 0, 0);
> +            if (is_cxl && cfg->cxl_mmio32.size) {
> +                uint64_t cxl_base = cfg->cxl_mmio32.base;
> +                uint64_t cxl_size = cfg->cxl_mmio32.size;
> +
> +                crs = aml_resource_template();
> +
> +                /* 32-bit MMIO range for CXL devices */
> +                aml_append(crs,
> +                    aml_dword_memory(AML_POS_DECODE, AML_MIN_FIXED,
> +                                     AML_MAX_FIXED, AML_NON_CACHEABLE,
> +                                     AML_READ_WRITE, 0,
> +                                     cxl_base,
> +                                     cxl_base + cxl_size - 1,
> +                                     0, cxl_size));
> +
> +                /* Bus number range */
> +                aml_append(crs,
> +                    aml_word_bus_number(AML_MIN_FIXED, AML_MAX_FIXED,
> +                                       AML_POS_DECODE, 0,
> +                                       bus_num, bus_num + 15,
> +                                       0, 16));
> +            } else {
> +                crs = build_crs(PCI_HOST_BRIDGE(BUS(bus)->parent),
> +                                &crs_range_set, cfg->pio.base, 0, 0, 0);
> +            }
>               aml_append(dev, aml_name_decl("_CRS", crs));
>   
>               if (is_cxl) {
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 84b91b4322..9c1a001553 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -113,6 +113,9 @@ static const MemMapEntry virt_memmap[] = {
>   /* PCIe high mmio for RV64, size is fixed but base depends on top of RAM */
>   #define VIRT64_HIGH_PCIE_MMIO_SIZE  (16 * GiB)
>   
> +/* 32-bit MMIO range carved out of VIRT_PCIE_MMIO for CXL host bridges */
> +#define VIRT_CXL_MMIO32_SIZE        (256 * MiB)
> +
>   static MemMapEntry virt_high_pcie_memmap;
>   
>   #define VIRT_FLASH_SECTOR_SIZE (256 * KiB)
> @@ -890,15 +893,28 @@ static void create_fdt_pcie(RISCVVirtState *s,
>       }
>       qemu_fdt_setprop_sized_cells(ms->fdt, name, "reg", 2,
>           s->memmap[VIRT_PCIE_ECAM].base, 2, s->memmap[VIRT_PCIE_ECAM].size);
> -    qemu_fdt_setprop_sized_cells(ms->fdt, name, "ranges",
> -        1, FDT_PCI_RANGE_IOPORT, 2, 0,
> -        2, s->memmap[VIRT_PCIE_PIO].base, 2, s->memmap[VIRT_PCIE_PIO].size,
> -        1, FDT_PCI_RANGE_MMIO,
> -        2, s->memmap[VIRT_PCIE_MMIO].base,
> -        2, s->memmap[VIRT_PCIE_MMIO].base, 2, s->memmap[VIRT_PCIE_MMIO].size,
> -        1, FDT_PCI_RANGE_MMIO_64BIT,
> -        2, virt_high_pcie_memmap.base,
> -        2, virt_high_pcie_memmap.base, 2, virt_high_pcie_memmap.size);
> +    {
> +        /*
> +         * When CXL is enabled, reserve the last 256 MiB of the 32-bit
> +         * MMIO window for CXL host bridges and exclude it from the main
> +         * PCIe host bridge's FDT 'ranges' so UEFI's PciHostBridgeDxe
> +         * does not allocate that range to PCI0.  The CXL host bridge
> +         * _CRS declares this range independently.
> +         */
> +        hwaddr mmio32_size = s->memmap[VIRT_PCIE_MMIO].size;
> +        if (s->cxl_devices_state.is_enabled) {
> +            mmio32_size -= VIRT_CXL_MMIO32_SIZE;
> +        }
> +        qemu_fdt_setprop_sized_cells(ms->fdt, name, "ranges",
> +            1, FDT_PCI_RANGE_IOPORT, 2, 0,
> +            2, s->memmap[VIRT_PCIE_PIO].base, 2, s->memmap[VIRT_PCIE_PIO].size,
> +            1, FDT_PCI_RANGE_MMIO,
> +            2, s->memmap[VIRT_PCIE_MMIO].base,
> +            2, s->memmap[VIRT_PCIE_MMIO].base, 2, mmio32_size,
> +            1, FDT_PCI_RANGE_MMIO_64BIT,
> +            2, virt_high_pcie_memmap.base,
> +            2, virt_high_pcie_memmap.base, 2, virt_high_pcie_memmap.size);
> +    }

We can get rid of the braces - it's just adding an extra identation level while
not doing anything special.  'mmio32_size' can be declared at the start
of create_fdt_pcie().

Thanks,
Daniel

>   
>       if (virt_is_iommu_sys_enabled(s)) {
>           qemu_fdt_setprop_cells(ms->fdt, name, "iommu-map",
> @@ -1728,7 +1744,29 @@ static void virt_machine_init(MachineState *machine)
>               qdev_get_gpio_in(virtio_irqchip, VIRTIO_IRQ + i));
>       }
>   
> -    gpex_pcie_init(system_memory, pcie_irqchip, s);
> +    DeviceState *pcie_dev = gpex_pcie_init(system_memory, pcie_irqchip, s);
> +
> +    /*
> +     * If CXL is enabled, reserve the last 256 MiB of the 32-bit MMIO
> +     * window for CXL host bridges so the bridge non-prefetchable window
> +     * can hold CXL device BARs (component registers and similar 64-bit
> +     * non-prefetchable BARs that need a < 4 GiB address).
> +     *
> +     * - Shrink PCI0's mmio32 advertised in the ACPI _CRS by the same
> +     *   256 MiB so the two ranges do not overlap (the FDT 'ranges'
> +     *   shrink happens in create_fdt_pcie()).
> +     * - Store the reserved range in cxl_mmio32 so gpex-acpi.c can emit
> +     *   a correct _CRS for the CXL host bridge (ACPI0016).
> +     */
> +    if (s->cxl_devices_state.is_enabled) {
> +        GPEXHost *gpex = GPEX_HOST(pcie_dev);
> +        gpex->gpex_cfg.cxl_mmio32.size = VIRT_CXL_MMIO32_SIZE;
> +        gpex->gpex_cfg.cxl_mmio32.base =
> +            s->memmap[VIRT_PCIE_MMIO].base +
> +            s->memmap[VIRT_PCIE_MMIO].size - VIRT_CXL_MMIO32_SIZE;
> +        /* Shrink PCI0's advertised 32-bit MMIO window to exclude CXL range */
> +        gpex->gpex_cfg.mmio32.size -= VIRT_CXL_MMIO32_SIZE;
> +    }
>   
>       create_platform_bus(s, mmio_irqchip);
>   
> diff --git a/include/hw/pci-host/gpex.h b/include/hw/pci-host/gpex.h
> index 1da9c85bce..d38fbbacd6 100644
> --- a/include/hw/pci-host/gpex.h
> +++ b/include/hw/pci-host/gpex.h
> @@ -43,6 +43,7 @@ struct GPEXConfig {
>       MemMapEntry mmio32;
>       MemMapEntry mmio64;
>       MemMapEntry pio;
> +    MemMapEntry cxl_mmio32;
>       int         irq;
>       PCIBus      *bus;
>       bool        pci_native_hotplug;

