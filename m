Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F8449362C
	for <linux-cxl@vger.kernel.org>; Fri,  4 Sep 2026 14:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788531809; cv=none; b=b2KqGtjCz9LgpX+9qxS/ZrEx8vGujQxu16VdK5EWNQYAl39zZHYRXdXJjHJlkObxSoX3VQFS8onnfKplVb/jj+rzeMFts2XToSrJdf+TUHZmSGEr6KxiKbt6aVkS3Yk0AsHIp7b02lnK3gyrJ5RbBLc5dGpGDurU9btC5tjm6HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788531809; c=relaxed/simple;
	bh=ablA0y54jl7vyhuRawRKw5efz2YEF9cB4oDw8tuaXYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ZL9TLEnrVeeUDpk+9PrUHHl9j3LeZ36pOuI5K7aS7tzMRA+DDKPySeAjUGFFHsi+r7B3WwbOsdvOY2hc5WZrheo3tmg/zXaTOnlnu8PvXvaBRNzJnlvb8CNoDI52NenMV6zKmIEDfgoFTtPUkow741F6OESx8jOwsRLuWVNQgfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ql0bk6nf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ql0bk6nf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788531805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zlvAeZ5BVe+Clxx9SqJuL3MQ8UJUVicNHrhOy6P/WBQ=;
	b=Ql0bk6nf7L3Zpmup55j/VbtM/pQPuAWpo7OugKsn5svC4eQUu2wu2xakki+FYwgy0lMWMi
	JruVkI1zmL1xB6JjXeEGrOplqwt1E9+k2Oy8hXvx2FyYMKRhhmc5XZeZXYWlTnLQVEbnTp
	iVn/0cC6eGTnu7XvWmnBj7GJeZHKSBw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-D62CtZ0SMvGC9hqEVAQOVQ-1; Fri, 04 Sep 2026 10:23:24 -0400
X-MC-Unique: D62CtZ0SMvGC9hqEVAQOVQ-1
X-Mimecast-MFC-AGG-ID: D62CtZ0SMvGC9hqEVAQOVQ_1788531804
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-485835753caso879873f8f.3
        for <linux-cxl@vger.kernel.org>; Fri, 04 Sep 2026 07:23:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788531803; x=1789136603;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zlvAeZ5BVe+Clxx9SqJuL3MQ8UJUVicNHrhOy6P/WBQ=;
        b=GPxuehCTsYdx4OgqdjuTNvCX6iuceczF1l8NHRAW93yQuVXT/e9boVjB3tCZx01qjY
         f+dFpDk9ltfhxL09AQKKMhyFIBaxtho8lIKYCycjIcG4gWcqFX4A3SrSCyCTSah+JCKm
         4/Q/VsVVoK8UHiMI0xAIv894auRnUmjE5nDaVIE+E/weN4pZmTtZtCehxjCbJ+DiW8lV
         /ZmN5WS5R0E/uVXNWwRYS+uk9trPt1WEa47SI1OxjOJ7fNudujNYFACG843RzlFtdgHA
         b6pGN5AH4QXanxGxfgnBSLf2TBYGNu1qq7OWjvA2U5k/Z+ka/iqRKK7Dac5HLtB2KlgS
         bkow==
X-Forwarded-Encrypted: i=1; AKwUvBzEbsFDqBxtVADS2av4cP46H2xLFWFmFjkbemv4vbflb2oEaYihkz2TBRdPSUk4lZLcroV/bzcPGL0=@vger.kernel.org
X-Gm-Message-State: AFuF++nQSUtksN/7ziXNZ88PH3s96ewGVBx8eSsLEydgOl8h24rCWXcz
	xgYjovMQVL/GVMaLNKfRjV3cScNDDHKpFPwl+09qoCLE4egnZaKSHJAaq2bhQnBlgnt9HYRmD6x
	rJ/R47cmByD8uzocrxhaklQHgQtJK/Lr30dJ9pq0Dg/Ez5trPCVsM0ye3u56/yw==
X-Gm-Gg: AYBFou2lEbEyeD3JaCyIn/xwKL/frBvcv+6OzV7eYsWp5FFlwddzDdIZN7D3Wq6qMI/
	NX1HaMZdow5cozpxDgjokH4N+QJwZF4H+QlSyBKejG6SjWk2+p6Zl4FXS84nlT+LE2MuYWFKjSF
	TvTzmpVjIMnNQbHTW5Te4rEcMHG02X8oShg+dau7dZViSyDOjvmgL/eOow4Tn7J4sFVKMyo3Nik
	pn4Tuzn9keRAmIrTMErc0+zc8Wc8NvUjPYmsi677MVPw1P/aAWEi25MiNj/pCGwtVVHwd5zlRfC
	eKFFDrSolZQE/7iV0BqsUxC4kb7oym1Xk+sMaim12SK2lUV2WS/agUWM0hIn541IVIz+yQbn3SZ
	h2sk/WTy/ZrAtAE3+wxc/mV4=
X-Received: by 2002:a05:6000:2388:b0:485:8a46:7054 with SMTP id ffacd0b85a97d-4858a46714amr4918042f8f.38.1788531802968;
        Fri, 04 Sep 2026 07:23:22 -0700 (PDT)
X-Received: by 2002:a05:6000:2388:b0:485:8a46:7054 with SMTP id ffacd0b85a97d-4858a46714amr4917885f8f.38.1788531801396;
        Fri, 04 Sep 2026 07:23:21 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883bbcddsm6608413f8f.20.2026.09.04.07.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 07:23:20 -0700 (PDT)
Date: Fri, 4 Sep 2026 10:23:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Chen Pei <cp0613@linux.alibaba.com>
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, imammedo@redhat.com,
	sunilvl@ventanamicro.com, jic23@kernel.org, pbonzini@redhat.com,
	liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
	zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
	anisinha@redhat.com, dave.jiang@intel.com,
	alison.schofield@intel.com, junjie.cao@intel.com, guoren@kernel.org,
	qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v5 0/6] hw/riscv/virt: Add CXL support to the RISC-V virt
 machine
Message-ID: <20260904074710-mutt-send-email-mst@kernel.org>
References: <20260831132340.5345-1-cp0613@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260831132340.5345-1-cp0613@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4wu0dRijMh4T7R1zXOB0OFxj0tnUwSJbijO5vH_-SCI_1788531804
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Aug 31, 2026 at 09:23:31PM +0800, Chen Pei wrote:
> This series adds CXL support to the RISC-V virt machine, following the
> approach used by the ARM virt machine: CXL host bridges (pxb-cxl) are
> described as ACPI0016 devices, an ACPI0017 (CXLM) device is added to the
> DSDT with a _DEP on the CXL host bridges, and a CEDT table is built. A
> bios-tables test is added to pin down the generated ACPI tables.


I am guessing this will be merged by riscv maintainers?

acpi things

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> Changes since v4
> ----------------
>   - tests/qtest: DSDT.cxl regenerated against the in-tree
>     edk2-riscv-code.fd blob that the test boots (Junjie): the v4 golden
>     carried the window allocation of my local edk2-stable202602 build.
>     The 64-bit window is now 0x400100000..0x40010FFFF with the matching
>     PCI0 range shift; the AML fragment in the commit message is updated
>     accordingly.  CEDT.cxl is unchanged.
>   - hw/riscv/virt: pci_bus_add_fw_cfg_extra_pci_roots() moved out of
>     the cxl block (Junjie), so plain pxb-pcie expander bridges are also
>     advertised to firmware with cxl=off, in line with arm/virt, pc and
>     hppa.
>   - Collected review tags.
> 
> Changes since v3
> ----------------
>   - The CXL host bridge resource handling is reworked, following Junjie
>     Cao's suggestion (and Igor Mammedov's earlier "fix UEFI" direction):
>     instead of reserving a fixed 256 MiB carve-out and simulating the
>     firmware PCI initialization in QEMU, the machine now advertises the
>     pxb-cxl expander root buses to firmware via the etc/extra-pci-roots
>     fw_cfg file (pci_bus_add_fw_cfg_extra_pci_roots(), as arm/virt and
>     x86 do).  EDK2's PciBusDxe then enumerates behind the CXL host
>     bridge and assigns the root-port window and bus numbers, and
>     build_crs() emits a correct _CRS for the ACPI0016 host bridge.
>     This keeps the machine code minimal (a single call, no carve-out),
>     scales to multiple pxb-cxl host bridges, and lets firmware size the
>     window to what is actually behind the bridge.
>   - The bios-tables test is split into the staged flow documented in
>     bios-tables-test.c, and ordered the same way the riscv64 goldens were
>     originally added upstream (Sunil V L's commit cc3ba2422554 et al.):
>     the feature code comes first, then three consecutive commits -- empty
>     golden files + allowed-diff.h, the test code, and the populated golden
>     master binaries with an emptied allowed-diff.h.
> 
> Changes since v2
> ----------------
>   - hw/riscv/virt: The MMIO-window patch no longer touches the common
>     gpex code (Igor).  The gpex_cfg.cxl_mmio32 field and the is_cxl
>     static _CRS branch are dropped; the ACPI0016 _CRS now comes from the
>     generic build_crs() path.  Since EDK2 does not enumerate the pxb-cxl
>     expander bridge, riscv simulates the firmware PCI initialization
>     (reserved window + depth-first bridge bus numbers) and re-applies it
>     via a reset handler.
>   - hw/riscv/virt: Drops the machine-global window/bus-range synthesis
>     that did not scale past one pxb-cxl (Junjie).  The series targets a
>     single CXL host bridge for now, documented in the commit message and
>     a TODO.
>   - hw/riscv/virt: CXL host register region and FMW setup folded into a
>     single cxl_host_state_init() helper; redundant braces removed in
>     create_fdt_pcie() (Daniel).
>   - hw/riscv/virt-acpi-build: the _DEP commit message documents the
>     kernel-compatibility behaviour (Alistair).
>   - Carried review tags: Sunil V L's Reviewed-by on the _DEP patch and
>     Alistair Francis's Acked-by on the test.
> 
> Changes since v1
> ----------------
>   - hw/riscv/virt: PCIBus *bus renamed to PCIBus *pci_bus (Jonathan).
>   - hw/riscv/virt: Dropped outer if (s->pci_bus) guard around
>     cxl_hook_up_pxb_registers(); the function already handles a NULL
>     bus internally (Jonathan).
>   - hw/riscv/virt-acpi-build: All s->bus references updated to
>     s->pci_bus; iasl -d decompiled DSDT fragment added to commit
>     message.
>   - hw/riscv/virt,gpex: Commit message expanded with PCI-to-PCI Bridge
>     Spec §3.2.5.8/9/10 citations (Jonathan).
>   - Original patch 4 ("Map committed HDM decoder ranges as RAM for
>     direct DMA") dropped; superseded by Alireza Sanaee's v8 series [1],
>     which is now merged upstream and thus no longer a prerequisite.
>   - New patch 4: RISC-V ACPI bios-tables test for CXL, with golden AML
>     files generated and included.
> 
> [1] https://lore.kernel.org/qemu-devel/20260318171918.146-1-alireza.sanaee@huawei.com/
> 
> Test
> ----
> Built riscv64-softmmu and ran the new bios-tables test together with the
> existing riscv64 ACPI tests; all pass.
> 
> Also booted an RVA22 guest with EDK2 firmware, using pxb-cxl + cxl-rp +
> cxl-type3 + a CFMW: EDK2's PciBusDxe enumerates behind the CXL host
> bridge (advertised via etc/extra-pci-roots), the root port and Type3
> device show up (0000:0c:00.0 / 0000:0d:00.0), and 'cxl list' reports
> the memdev (4 GiB) and the CFMWS root decoder.
> 
> QEMU invocation (CXL-relevant options shown):
> 
>     qemu-system-riscv64 \
>         -M virt,aia=aplic-imsic,acpi=on,cxl=on \
>         -cpu rva22s64 -smp 2 -m 4G \
>         -object memory-backend-ram,id=vmem0,share=on,size=4G \
>         -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
>         -device cxl-rp,port=0,bus=cxl.1,id=rp0,chassis=0,slot=2 \
>         -device cxl-type3,bus=rp0,volatile-memdev=vmem0 \
>         -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G \
>         ...
> 
> Verification (total system memory grows by 4 GiB after onlining):
> 
>     # cxl list
>     # cxl enable-memdev mem0
>     # cxl create-region -m -t ram -d decoder0.0 -w 1 mem0 -s 4G
>     # daxctl online-memory dax0.0
>     # free -h
> 
> Chen Pei (6):
>   hw/riscv/virt: Add CXL support to the RISC-V virt machine
>   hw/riscv/virt-acpi-build: Add _DEP to ACPI0017 for CXL host bridge
>     dependency
>   hw/riscv/virt: Advertise the CXL host bridge to firmware via
>     extra-pci-roots
>   tests/qtest: Prepare golden files for the RISC-V CXL ACPI test
>   tests/qtest: Add RISC-V ACPI bios tables test for CXL
>   tests/qtest: Update RISC-V CXL ACPI golden master binaries
> 
>  hw/riscv/Kconfig                      |   2 +
>  hw/riscv/virt-acpi-build.c            |  52 +++++++++++++++++++++++++
>  hw/riscv/virt.c                       |  46 ++++++++++++++++++++++
>  include/hw/riscv/virt.h               |   3 ++
>  tests/data/acpi/riscv64/virt/CEDT.cxl | Bin 0 -> 108 bytes
>  tests/data/acpi/riscv64/virt/DSDT.cxl | Bin 0 -> 6331 bytes
>  tests/qtest/bios-tables-test.c        |  54 ++++++++++++++++++++++++++
>  7 files changed, 157 insertions(+)
>  create mode 100644 tests/data/acpi/riscv64/virt/CEDT.cxl
>  create mode 100644 tests/data/acpi/riscv64/virt/DSDT.cxl
> 
> -- 
> 2.50.1

