Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765DB332604
	for <linux-cxl@vger.kernel.org>; Wed, 24 Jun 2026 16:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782319382; cv=none; b=VM4Q+MszfigjJKteDDFHqAuTdEOuscudpE5g8M+IxR0lx2W7oKKnij8+Zlfk6Oda0bDPHd2qJQm23iZ+vbvj1Q5RgJkTx+RUC4C+zRd6EleC6n8VnQ21b1k5F5NW4nJcvF442NodJC0zCXytL6NhTUlvYRgVDNZoTMtNKx1d6LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782319382; c=relaxed/simple;
	bh=MWWd2KV9KNteSN3oNF32yn4mpN1qJSf0X1a0CIFcaYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AbcrvEEaQJHzMb/TnBgPXJBmMFITAR9es4AGO6Q4jgD029RvfeJ3Lm9hE4XU8bE/P66fDQPmVaVmKCUqvZ4q8ssawOxQDEbzGWVx4az3oKtqMjNNwG0VkDADbBq9Uo2s3HnYEQJ7Yez+gpKUvw9XaBUZhIsBlAv80Fasmx7aBLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fui+YcFt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YLwSRTZP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fui+YcFt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YLwSRTZP"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65OFfYTG3212448
	for <linux-cxl@vger.kernel.org>; Wed, 24 Jun 2026 16:43:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	08xMVtcPU9aNDwBr/6YtUFxpftYU+nnvK8OHIg9s0mk=; b=fui+YcFtBcrRvaZ9
	SKYSbDMAFp/cM0zcwevjsWu89TN3LVkwZGTOoXvgp9KqwNR/4vLE25P71GHMaeLO
	c1j+6K5pohkvx9QolAF0HMoYgw2NjB7DNJqRGLpeRT0Z220cJ7YLFAxZUH5FpvLH
	2xNiIyeYxdvp2SR6bmquxUttZVf3ssqUR3oC5SiqZXkwN5xFUpCcsr6IWe+XwQCy
	MoUT5pPQLh0xecRW1HKBuuNroWPU2k7xFPZLyDjYI8O/A6/5hhnueMgbYmWZNlph
	Z0K04tcYdlzqFgh8H6f97r6MkOb3EAEqLEZ95sKEEWgd0o83M2nUM71g3cYh1/Tc
	8VVlJg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0d451n1h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-cxl@vger.kernel.org>; Wed, 24 Jun 2026 16:42:59 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30c17f62afdso44073eec.0
        for <linux-cxl@vger.kernel.org>; Wed, 24 Jun 2026 09:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782319379; x=1782924179; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=08xMVtcPU9aNDwBr/6YtUFxpftYU+nnvK8OHIg9s0mk=;
        b=YLwSRTZPlZy80GrXYdoyp4u5Ue9GFrvSDrB3iC/AvoSGbBpFCHUGS4KumqrnOPoNAS
         KbTmAoW9+GiN0aji/bINrW+8Umeu0EWKDSBa85AYsFMJid+WA0/W/ap004Qoo3PAHd+6
         DFbTUm5ic2nNaNN2Dzl8mzfB2u2W7r3EYr6EnaJrBwwyZrNkL8SlqcQWtn3kkdTgWPbM
         a0tLx18TTUFOiiqisi5PxafFGsaqNZljKdi3SmTMyNEMpEf8Rad2soyNyvI2GSlWOIWd
         mdbPZPKvpmlF/vKbBW9EGGNKUJ+3x9zxL0OYkjGOiPbl7dXs7YWlhA3r1izjKBZW2ot8
         iF3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782319379; x=1782924179;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=08xMVtcPU9aNDwBr/6YtUFxpftYU+nnvK8OHIg9s0mk=;
        b=jTd6lo7HN1we0vSr7AuWmEQxTV4z8alsRoRRrOcHSLQJMfP3IEUQGd9+z/xZSjCbJR
         Zqv9JXUkuPwxVQqSZxD80PtO2IQVno78prJMd78rR9yVVqN0m86WPdf0Pxlv46i1zX4q
         RAdM+yh5k4XUTk9H1w8KTYHaFfitkD8hWY8+PYQMEtMNiYT7XlyBUxO8DhL729WEwZl1
         j+iaaAWqai94a5/DBTXmzVTVvmPcWYQm+pbvULMtkDCwlGHB8YQau6Fs1KIwTIApSRZ4
         uUupRxRyD2TfJ+w9h/6gU6DAK1XdC4OBoFUKsDB1q4pblUK7IRShuC7Ib7K3pbQL/JlG
         i/yg==
X-Forwarded-Encrypted: i=1; AHgh+RpF9N5uo5eSkAOpn57ratNdKFrhSd/1TA5XOsVDD1c6HGus6+EvNeRzRs/3Xu71fi1o39cMCYgnKCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlH0/qI2nQXW2W/z/njRdhxO5dVmtE6FFiDWyIF2N3QGcKCBp/
	pxX338mBOJH0K51xYOb+qZGJs9DJfJi5tCaTAdMNldXKZoUPuMbgly8z9pU83x5acR2bw0yfI4F
	eAPLWtc5EjkqdzmLpSsQaeRjhasVqVdNQYSMQVO7p4kwtKaaTbLuZqofKtsV+EoU=
X-Gm-Gg: AfdE7cko+PUpMibQ6oT7DeayNYjUc0t1iw7RPNdy1WDzHNCtUwBxiz+8UTJLxIwQYQZ
	MQSR8i7AnRDQfuqSCGZshL/dK2XLJPBxrSejdrPo3t6FXLSu4R+p+JRdWUClwjAAIQ9oXaYlZFb
	rIhdXXwkAjtdJQV0I/8U1zjXJfH5e8g0r+tJdOwv8HgSpUwC0bxEmvQa24pMI2rNMAfv4prblw0
	CfQmRbvEgiit4bDyg/I1Dk9h1JLVIYW8ZogYchBgr/Te0ug98HvEFgab53IHg10fGiI0CZxaFsD
	LuFyfzX2sEJsUYAbar2+k+ypUbfz4ZOGoLaPmOxo0WYP9YOzz9edAH8L/l0PSml26QkXS65QtZQ
	1VDnP/Ap5kqXWuDhyqTjstDHNmePcUlp0hf5vjLHERgss
X-Received: by 2002:a05:7301:7106:b0:2f4:d190:37bf with SMTP id 5a478bee46e88-30c5563f2e8mr4507528eec.16.1782319378808;
        Wed, 24 Jun 2026 09:42:58 -0700 (PDT)
X-Received: by 2002:a05:7301:7106:b0:2f4:d190:37bf with SMTP id 5a478bee46e88-30c5563f2e8mr4507498eec.16.1782319378075;
        Wed, 24 Jun 2026 09:42:58 -0700 (PDT)
Received: from [192.168.68.103] ([189.79.21.40])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c8b1ae5sm400755eec.16.2026.06.24.09.42.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 09:42:57 -0700 (PDT)
Message-ID: <9279723a-b079-4749-b3a5-e6e7ecfd2121@oss.qualcomm.com>
Date: Wed, 24 Jun 2026 13:42:48 -0300
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] hw/riscv/virt: Add CXL support to the RISC-V virt
 machine
To: Chen Pei <cp0613@linux.alibaba.com>, jic23@kernel.org, pbonzini@redhat.com,
        palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
        zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
        sunilvl@ventanamicro.com, dave.jiang@intel.com,
        alison.schofield@intel.com, imammedo@redhat.com, mst@redhat.com,
        guoren@kernel.org
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, linux-cxl@vger.kernel.org
References: <20260618093827.3507-1-cp0613@linux.alibaba.com>
 <20260618093827.3507-2-cp0613@linux.alibaba.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260618093827.3507-2-cp0613@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDE0MCBTYWx0ZWRfXxuK7k/5x6BIx
 G2pN5BUYAj1gxWFT8DLdx1nW1e346XtytEmAVGxsZfJh5LMXirMWQtzfXoC7npOYYpyRYAaDASa
 6k7n2ctNhdJAydOcAcLgX/a9z+yh7O0=
X-Proofpoint-GUID: QWbhbMe1O8rumTw56qMizp-0w-wbZjHJ
X-Authority-Analysis: v=2.4 cv=Ar7eGu9P c=1 sm=1 tr=0 ts=6a3c0913 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=SRrdq9N9AAAA:8 a=OKAgqmDqJgUB0MQQqyQA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: QWbhbMe1O8rumTw56qMizp-0w-wbZjHJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDE0MCBTYWx0ZWRfX1XbvoJ8MOrBw
 +yyoB233FPrIMCR+9kGlLScFYmupw1NxhG+d9XbeM/6M7uIqvMt6YgSuzB3Ri7ISBQO2J+IyHRy
 P6t/uPPS5FA62Oh0Fo/wUrkgppBCADpHS7BVcOzj+1CxuinCct2hC1kzFLRMveEIlpBCvlgtIY4
 bHMCg7TYF1gSehOxNnDT9NaPrz5Sx7qdTk3ei2Jn9pGdzvXoygtdBdSfRY0PgVNPGU2ipcEyDhG
 VW1ZVBgLY7JjIUNxDMf28P1qgJMdbEkeNNtWJHaeijqYLJ0Ihiy58vU2Bm4VhHsJTW7JzJFEGx1
 /GwleCgIRmoSrKAl3yxHkohDyFtXfgiipKMjoAIPQEt5EbeSFmH9zQh1QJGPZmhphBPMb/HlFBC
 hJS6mPUcjDkDXr53oYaExNiNwNHjWQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 spamscore=0 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606240140

Hi,

On 6/18/2026 6:38 AM, Chen Pei wrote:
> Enable CXL support on the RISC-V virt machine following the same
> approach used by the ARM virt machine:
> - Add PXB and ACPI_CXL Kconfig selections
> - Add CXLState and PCIBus pointer to RISCVVirtState
> - Register CXL machine properties via cxl_machine_init()
> - Create CXL host register region above the PCIe high MMIO region
> - Call cxl_hook_up_pxb_registers() and cxl_fmws_link_targets() at
>    machine_done time
> - Map Fixed Memory Windows above the CXL host register region
> - Add ACPI0017 device in DSDT and build CEDT table in virt-acpi-build.c
> 
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
> ---
>   hw/riscv/Kconfig           |  2 ++
>   hw/riscv/virt-acpi-build.c | 20 +++++++++++++++++++
>   hw/riscv/virt.c            | 40 ++++++++++++++++++++++++++++++++++++++
>   include/hw/riscv/virt.h    |  3 +++
>   4 files changed, 65 insertions(+)
> 
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index 2518b04175..ebd0355f09 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -66,8 +66,10 @@ config RISCV_VIRT
>       select VIRTIO_MMIO
>       select FW_CFG_DMA
>       select PLATFORM_BUS
> +    select PXB
>       select ACPI
>       select ACPI_PCI
> +    select ACPI_CXL
>   
>   config SHAKTI_C
>       bool
> diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> index 413d47d70e..309d64b322 100644
> --- a/hw/riscv/virt-acpi-build.c
> +++ b/hw/riscv/virt-acpi-build.c
> @@ -29,12 +29,16 @@
>   #include "hw/acpi/aml-build.h"
>   #include "hw/acpi/pci.h"
>   #include "hw/acpi/utils.h"
> +#include "hw/acpi/cxl.h"
>   #include "hw/intc/riscv_aclint.h"
>   #include "hw/nvram/fw_cfg_acpi.h"
>   #include "hw/pci-host/gpex.h"
> +#include "hw/pci/pci_bus.h"
>   #include "hw/riscv/virt.h"
>   #include "hw/riscv/numa.h"
>   #include "hw/virtio/virtio-acpi.h"
> +#include "hw/cxl/cxl.h"
> +#include "hw/cxl/cxl_host.h"
>   #include "kvm/kvm_riscv.h"
>   #include "migration/vmstate.h"
>   #include "qapi/error.h"
> @@ -503,6 +507,17 @@ static void build_dsdt(GArray *table_data,
>           acpi_dsdt_add_gpex_host(scope, PCIE_IRQ + VIRT_IRQCHIP_NUM_SOURCES * 2);
>       }
>   
> +    if (s->cxl_devices_state.is_enabled) {
> +        Aml *cxl_dev = aml_device("CXLM");
> +        aml_append(cxl_dev, aml_name_decl("_HID", aml_string("ACPI0017")));
> +        Aml *method = aml_method("_STA", 0, AML_NOTSERIALIZED);
> +        aml_append(method, aml_return(aml_int(0x0B)));
> +        aml_append(cxl_dev, method);
> +        build_cxl_dsm_method(cxl_dev);
> +
> +        aml_append(scope, cxl_dev);
> +    }
> +
>       aml_append(dsdt, scope);
>   
>       /* copy AML table into ACPI tables blob and patch header there */
> @@ -910,6 +925,11 @@ static void virt_acpi_build(RISCVVirtState *s, AcpiBuildTables *tables)
>                      s->oem_table_id);
>       }
>   
> +    if (s->cxl_devices_state.is_enabled) {
> +        cxl_build_cedt(table_offsets, tables_blob, tables->linker,
> +                       s->oem_id, s->oem_table_id, &s->cxl_devices_state);
> +    }
> +
>       if (ms->numa_state->num_nodes > 0) {
>           acpi_add_table(table_offsets, tables_blob);
>           build_srat(tables_blob, tables->linker, s);
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index ce64eaaef7..84b91b4322 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -55,6 +55,8 @@
>   #include "hw/pci/pci.h"
>   #include "hw/pci-host/gpex.h"
>   #include "hw/display/ramfb.h"
> +#include "hw/cxl/cxl.h"
> +#include "hw/cxl/cxl_host.h"
>   #include "hw/acpi/aml-build.h"
>   #include "qapi/qapi-visit-common.h"
>   #include "hw/virtio/virtio-iommu.h"
> @@ -1259,9 +1261,27 @@ static inline DeviceState *gpex_pcie_init(MemoryRegion *sys_mem,
>       }
>   
>       GPEX_HOST(dev)->gpex_cfg.bus = PCI_HOST_BRIDGE(dev)->bus;
> +    s->pci_bus = PCI_HOST_BRIDGE(dev)->bus;
>       return dev;
>   }
>   
> +static void create_cxl_host_reg_region(RISCVVirtState *s)
> +{
> +    MemoryRegion *sysmem = get_system_memory();
> +    MemoryRegion *mr = &s->cxl_devices_state.host_mr;
> +    hwaddr base;
> +
> +    if (!s->cxl_devices_state.is_enabled) {
> +        return;
> +    }
> +
> +    base = virt_high_pcie_memmap.base + virt_high_pcie_memmap.size;
> +    base = ROUND_UP(base, 64 * KiB);
> +
> +    memory_region_init(mr, OBJECT(s), "cxl_host_reg", 64 * KiB * 16);
> +    memory_region_add_subregion(sysmem, base, mr);
> +}
> +
>   static FWCfgState *create_fw_cfg(const MachineState *ms, hwaddr base)
>   {
>       FWCfgState *fw_cfg;
> @@ -1426,6 +1446,13 @@ static void virt_machine_done(Notifier *notifier, void *data)
>                                        machine_done);
>       MachineState *machine = MACHINE(s);
>       hwaddr start_addr = s->memmap[VIRT_DRAM].base;
> +
> +    cxl_hook_up_pxb_registers(s->pci_bus, &s->cxl_devices_state,
> +                              &error_fatal);
> +
> +    if (s->cxl_devices_state.is_enabled) {
> +        cxl_fmws_link_targets(&error_fatal);
> +    }
>       hwaddr firmware_end_addr;
>       vaddr kernel_start_addr;
>       const char *firmware_name = riscv_default_firmware_name(&s->soc[0]);
> @@ -1663,6 +1690,17 @@ static void virt_machine_init(MachineState *machine)
>               ROUND_UP(virt_high_pcie_memmap.base, virt_high_pcie_memmap.size);
>       }
>   
> +    create_cxl_host_reg_region(s);
> +
> +    if (s->cxl_devices_state.is_enabled) {
> +        hwaddr cxl_base = virt_high_pcie_memmap.base +
> +                          virt_high_pcie_memmap.size;
> +        cxl_base += memory_region_size(&s->cxl_devices_state.host_mr);
> +        cxl_base = ROUND_UP(cxl_base, 256 * MiB);
> +        cxl_fmws_set_memmap(cxl_base, UINT64_MAX);
> +        cxl_fmws_update_mmio();
> +    }
> +

create_cxl_host_reg_region() is doing the same check:

if (!s->cxl_devices_state.is_enabled) {
(...)

Maybe we could squash these update_mmio() lines in the same helper to have
everything CXL related in the same place.  The helper would need to be
renamed to something more appropriate (e.g. cxl_host_state_init() since we're
at init time).


Patch LGTM otherwise. Thanks,
Daniel

>       /* register system main memory (actual RAM) */
>       memory_region_add_subregion(system_memory, s->memmap[VIRT_DRAM].base,
>                                   machine->ram);
> @@ -1769,6 +1807,8 @@ static void virt_machine_instance_init(Object *obj)
>       s->oem_table_id = g_strndup(ACPI_BUILD_APPNAME8, 8);
>       s->acpi = ON_OFF_AUTO_AUTO;
>       s->iommu_sys = ON_OFF_AUTO_AUTO;
> +
> +    cxl_machine_init(obj, &s->cxl_devices_state);
>   }
>   
>   static char *virt_get_aia_guests(Object *obj, Error **errp)
> diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
> index 18a2a323a3..7d559ac610 100644
> --- a/include/hw/riscv/virt.h
> +++ b/include/hw/riscv/virt.h
> @@ -24,6 +24,7 @@
>   #include "hw/core/sysbus.h"
>   #include "hw/block/flash.h"
>   #include "hw/intc/riscv_imsic.h"
> +#include "hw/cxl/cxl.h"
>   
>   #define VIRT_CPUS_MAX_BITS             9
>   #define VIRT_CPUS_MAX                  (1 << VIRT_CPUS_MAX_BITS)
> @@ -64,6 +65,8 @@ struct RISCVVirtState {
>       struct GPEXHost *gpex_host;
>       OnOffAuto iommu_sys;
>       uint16_t pci_iommu_bdf;
> +    CXLState cxl_devices_state;
> +    PCIBus *pci_bus;
>   };
>   
>   enum {

