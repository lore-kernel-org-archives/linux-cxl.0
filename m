Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EC763A9
	for <linux-cxl@vger.kernel.org>; Fri, 13 Jun 2025 12:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749819473; cv=none; b=gFsV5839wZQhYDXx8pouJ1qM4gd/p/ewBsa+T+asaNFQ76gUA4dXAHlrfugZ0oliUrk6l6+gtwY2IFhGf/2T8K8hSqCt7Her4y1l/5KC0F7LW2Zb8M0DN49F1QpMUaecuNBsrU8UJU633NFIDcg569yrrzLLpwFhHoQC0YsmUow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749819473; c=relaxed/simple;
	bh=d1baM/ePSuB8O16mHtFi9wZjouCvpWecO+JQ3spIQzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JOgypS0JCOJhH2PLULztgbiZXYuCt2LY8ZS7OvuWFf0h9z0r6KYorQQso0xXgGHF43YI2JhYXOnyPfi/qIxKv2j6r1PpaXueHQW193pLSy01iSDNguo2tKq3YPlPZPGkGbJ6SI7iSS7JfXh97ZP80gUbV+MeaeW2FyVCrYlI9+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I0TMq1Z4; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I0TMq1Z4"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7113ac6d4b3so17721577b3.3
        for <linux-cxl@vger.kernel.org>; Fri, 13 Jun 2025 05:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749819471; x=1750424271; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5e5DLwd9hQN7WIN5NYjTG58rp8CGAwEIUDrxIuaZN+E=;
        b=I0TMq1Z4a6dXR5bHDPZ1hVF0WQPcUFzDIq4SB25cJqFKXdRUoeOWNnaEa5lDm1mvo5
         klmCAK5hpOALNXoyUMyFtj7xZAsU3RJbub/vl8MZFoi4Pb4+JlTXyu+q60hR53p3lcbs
         NwRVjhTvD6Okghybqf5+Za+N2EP0xFt+X2dvvfYOYgc7ALVepx+emcvjimVZbV3cttSt
         /2+88+fCPV0sPT38rA0wG6cp5XLldCBUJ0GBTKz1JF9e8lhSFSysoox9Y96+aePXHftZ
         bxz+r6FKLqpPd23Vt83gr7pnkZF+WPLHIC4hP/Dh+TNfJkFTvC+9IQOgvSSbmTD01UJC
         6s1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749819471; x=1750424271;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5e5DLwd9hQN7WIN5NYjTG58rp8CGAwEIUDrxIuaZN+E=;
        b=RmCCLWJrdQFfFroovv0VjSVNPmM+T0F43gbExZ/xCRffTwZNUPgq7WsNOK0RJOHBnS
         YD3wcajPXF7xr5m/cez+rgmhfY99FSfTLIeApm980XHbj0hzQi/XhfyibRM29AdaQRYs
         8zPtaNolplOkg3O3MAYG9N5gVe5UbAzpoPFhblOw1SeRMnMgeoGh6BdHEDhzlWpiGKCY
         ACwfM11EV3jYXHDU5tjA4gJqg+AmQvk3M11i1dfapl+eJNgU+MXtb0xB+uXBHq7yos6f
         f7uVSG1lVErxx65HUVMd/xpXc1OYyH8gpLlLFjo+lJ+mikBNyxzLQI9iNxT++nSEcNL9
         5TTA==
X-Forwarded-Encrypted: i=1; AJvYcCX80aGxmGvEtzN8sblA5VZ40vEH6hHx7gKYXscXCJOqKnbrg1nbm4cZNolXZtn6Rz7TdEakcZYySso=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFkSpZawVbHsudU6yPZ5gs2oVn31qhUn+NjId43ooLIE8TqwyN
	JcTfDCmuOq7vqEpqo702HMtw/cYCL82G4HNSs0FYDbaBbNjNize5ydSDgK69rEmfHwHDaiCogM0
	NjeMED6FXQnoYcrTGRluq3sEi9noFZILFKgOATPFjGA==
X-Gm-Gg: ASbGncv+s74bCMwTIhyovt4v0X+xJkN2nYUXPCpueUTm+n0VcQEyYJCuaCWXVXnU+0r
	YqnDcDs/2NEA96aVkYLf8n1VmdzLau0unriSIP9gCFwfil0knm4v5x6ZfqIK9fdRZtiHUsI8tb1
	IzT4qINeLW3CTwqXiNXsd+MIWCNhxD3poyD/ybMdkGK98E
X-Google-Smtp-Source: AGHT+IGOqdMgK2uR5dYMh+4m6yWvXA5HHWIhp0IPRI9GXw8RTzt2MNwCVJQ74vJuTdZKitYKMfh0RBIxhRkxEj0eMow=
X-Received: by 2002:a05:690c:d1c:b0:70c:a854:8384 with SMTP id
 00721157ae682-71163645c81mr50388717b3.11.1749819470736; Fri, 13 Jun 2025
 05:57:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612134338.1871023-1-Jonathan.Cameron@huawei.com> <20250612134338.1871023-4-Jonathan.Cameron@huawei.com>
In-Reply-To: <20250612134338.1871023-4-Jonathan.Cameron@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Jun 2025 13:57:39 +0100
X-Gm-Features: AX0GCFv5MSwU1aQDZ69b1dKRTca84UO3VVXOn0u2BXHQNHBteShBJRs4HFTae4I
Message-ID: <CAFEAcA-J+vAGfEV67PezA72rUiqpuqTBT=8hJLc1sw+xo3XHWQ@mail.gmail.com>
Subject: Re: [PATCH v15 3/4] hw/arm/virt: Basic CXL enablement on
 pci_expander_bridge instances pxb-cxl
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, Fan Ni <fan.ni@samsung.com>, mst@redhat.com, 
	Zhijian Li <lizhijian@fujitsu.com>, Itaru Kitayama <itaru.kitayama@linux.dev>, linuxarm@huawei.com, 
	linux-cxl@vger.kernel.org, qemu-arm@nongnu.org, 
	Yuquan Wang <wangyuquan1236@phytium.com.cn>, 
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
	Alireza Sanaee <alireza.sanaee@huawei.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Jun 2025 at 14:45, Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> Code based on i386/pc enablement. The memory layout places space for 16
> host bridge register regions after the GIC_REDIST2 in the extended memmap.
> The CFMWs are placed above the extended memmap.
>
> Only create the CEDT table if cxl=on set for the machine.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> ---
> v15: No changes.
> ---
>  include/hw/arm/virt.h    |  4 ++++
>  hw/arm/virt-acpi-build.c | 34 ++++++++++++++++++++++++++++++++++
>  hw/arm/virt.c            | 29 +++++++++++++++++++++++++++++
>  3 files changed, 67 insertions(+)

Can we have some user-facing documentation, please?
(docs/system/arm/virt.rst -- can just be a brief mention
and link to docs/system/devices/cxl.rst if you want to put the
examples of aarch64 use in there.)

> @@ -220,6 +223,7 @@ static const MemMapEntry base_memmap[] = {
>  static MemMapEntry extended_memmap[] = {
>      /* Additional 64 MB redist region (can contain up to 512 redistributors) */
>      [VIRT_HIGH_GIC_REDIST2] =   { 0x0, 64 * MiB },
> +    [VIRT_CXL_HOST] =           { 0x0, 64 * KiB * 16 }, /* 16 UID */

This is going to shuffle the memory map around, even if CXL
isn't enabled, which will break migration compatibility.
You need to do something to ensure that the CXL region isn't
included in the calculations of the base addresses for these
regions if CXL isn't enabled.

>      [VIRT_HIGH_PCIE_ECAM] =     { 0x0, 256 * MiB },
>      /* Second PCIe window */
>      [VIRT_HIGH_PCIE_MMIO] =     { 0x0, DEFAULT_HIGH_PCIE_MMIO_SIZE },

If you're OK with having the CXL host region at the end of the
list then that's a simpler way to avoid its presence disturbing
the layout of the existing regions, but you might not like it
being at such a high physaddr.

> @@ -1621,6 +1625,17 @@ static void create_pcie(VirtMachineState *vms)
>      }
>  }
>
> +static void create_cxl_host_reg_region(VirtMachineState *vms)
> +{
> +    MemoryRegion *sysmem = get_system_memory();
> +    MemoryRegion *mr = &vms->cxl_devices_state.host_mr;

This looks odd -- why are we reaching directly into the cxl_devices_state
to fish out a MemoryRegion and init it?

> +    memory_region_init(mr, OBJECT(vms), "cxl_host_reg",
> +                       vms->memmap[VIRT_CXL_HOST].size);
> +    memory_region_add_subregion(sysmem, vms->memmap[VIRT_CXL_HOST].base, mr);
> +    vms->highmem_cxl = true;
> +}
> +
>  static void create_platform_bus(VirtMachineState *vms)
>  {
>      DeviceState *dev;
> @@ -1737,6 +1752,12 @@ void virt_machine_done(Notifier *notifier, void *data)
>      struct arm_boot_info *info = &vms->bootinfo;
>      AddressSpace *as = arm_boot_address_space(cpu, info);
>
> +    cxl_hook_up_pxb_registers(vms->bus, &vms->cxl_devices_state,
> +                              &error_fatal);
> +
> +    if (vms->cxl_devices_state.is_enabled) {
> +        cxl_fmws_link_targets(&error_fatal);
> +    }
>      /*
>       * If the user provided a dtb, we assume the dynamic sysbus nodes
>       * already are integrated there. This corresponds to a use case where
> @@ -1783,6 +1804,7 @@ static inline bool *virt_get_high_memmap_enabled(VirtMachineState *vms,
>  {
>      bool *enabled_array[] = {
>          &vms->highmem_redists,
> +        &vms->highmem_cxl,
>          &vms->highmem_ecam,
>          &vms->highmem_mmio,
>      };
> @@ -1890,6 +1912,9 @@ static void virt_set_memmap(VirtMachineState *vms, int pa_bits)
>      if (device_memory_size > 0) {
>          machine_memory_devices_init(ms, device_memory_base, device_memory_size);
>      }
> +
> +    cxl_fmws_set_memmap(ROUND_UP(vms->highest_gpa + 1, 256 * MiB),
> +                        BIT_ULL(pa_bits));

Isn't this stomping over the HIGH_PCIE memory window (or
whatever else happens to be at the top end of memory) ?

Also taking highest_gpa and then rounding it up looks suspicious:
if it's the highest GPA then anything larger than that is off
the end of the physical address space.

Plus cxl_fmws_set_memmap() names its arguments base, max_addr:
"highest gpa, rounded up" doesn't sound like a base address.

(Looking at our current code that sets and adjusts highest_gpa,
it looks a bit weird: maybe we're setting it to values that aren't
what the variable name claims it's doing, and that's why this
code happens to work ?)

>  }
>
>  static VirtGICType finalize_gic_version_do(const char *accel_name,
> @@ -2340,6 +2365,8 @@ static void machvirt_init(MachineState *machine)
>      memory_region_add_subregion(sysmem, vms->memmap[VIRT_MEM].base,
>                                  machine->ram);
>
> +    cxl_fmws_update_mmio();
> +
>      virt_flash_fdt(vms, sysmem, secure_sysmem ?: sysmem);
>
>      create_gic(vms, sysmem);
> @@ -2395,6 +2422,7 @@ static void machvirt_init(MachineState *machine)
>      create_rtc(vms);
>
>      create_pcie(vms);
> +    create_cxl_host_reg_region(vms);
>
>      if (has_ged && aarch64 && firmware_loaded && virt_is_acpi_enabled(vms)) {
>          vms->acpi_dev = create_acpi_ged(vms);
> @@ -3365,6 +3393,7 @@ static void virt_instance_init(Object *obj)
>
>      vms->oem_id = g_strndup(ACPI_BUILD_APPNAME6, 6);
>      vms->oem_table_id = g_strndup(ACPI_BUILD_APPNAME8, 8);
> +    cxl_machine_init(obj, &vms->cxl_devices_state);
>  }

cxl defaults to disabled, right? (i.e. we don't need the
machine-version specific stuff to keep it from being enabled
on old versioned machine types).

thanks
-- PMM
