Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794505981;
	b=U7NmVDQ6NQiNOAv+E0q0BKUVGBZX6exiUqRVp/4yNeDoXiGvucyc/EHrn9eR/y3+HKdG
	 16M1siqsVbxOr34TB65wJK5IBfC/hExQR4+60tBO0PaG+HDzx/+CyxM2MCxZSE9bYj9Gx
	 w3ZQlG0WJ4g0GwPVVr7/ReSZgkh0IcY6f6UIRulhXsRoeDrUr8EEVK863rc1qZd/kHq78
	 SBM2wdPRJxP75iRM6q+hPJvDHHuhgEa32Yx1zG3gv2zYVzm2vGqKDJX2JfWort7YPNpkr
	 dRFBpYU5CECdEV4QWaTrkvKtHPP+LoOGeLJVcawBcTLD6DoAZwQYuqpdcTDGJfbTG/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794505981;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=F2YnP0s7EXjVFhqc1+OhYJjUXanL7Ulcltk2cgVR7UY=;
	b=H15BEPh+sY4EKF3f7XCBy+zUl78ed1H5EMBGu548VPJj9D214PbsqJ09u2YnUbsSxm3A
	 q5F1+5M6+GrYLXnpPlvAoaEMLQgXlTdoGv5qZfRn7gsbid72w52H/oNVm5zIG5hJNhBHz
	 irJntBKmivRbfhTouw7ct5DFXxeCfIWGH+molvAeUf5t2Jwbu9yOlFC3pMMtuCPd+Ldm2
	 GW1BtxMtTBrriyi+rRBKx0jq17wZZRsrTORaL6ptNO+WMctNprH7XKqpkzUJAUOAWJus8
	 jp0YaNTTPmxZjcHbOb32P0hGwlKGLruR2Y05oBgoWgoO9TII3vWo7fCStMTuqq00N0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SugGLgMq;
	arc=none smtp.remote-ip=209.85.160.51
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682FA606A31C
	for <linux-cxl@vger.kernel.org>; Thu, 12 Nov 2026 17:53:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 682FA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SugGLgMq
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-4a77761ff8aso14210fac.2
        for <linux-cxl@vger.kernel.org>; Thu, 12 Nov 2026 09:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794505979; x=1795110779; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F2YnP0s7EXjVFhqc1+OhYJjUXanL7Ulcltk2cgVR7UY=;
        b=SugGLgMqr4Y1Ti5Xib+/ATK92e2GDZMv2n22agwPu48FC2EeHR7UwnNKp9zVrJ7IIB
         gFsFhhyyZTN98O/l+F7PJ+8ZLM0ENhRV4HayV6qD6LyOkS4c15VVTKGpvdmjp6unDTXc
         221+gBFcNZxgCV0J1Pu+ttRyIZKVLiqaU84FWLLSTcWbvlIQAiBZvSP+ekt75poyihuh
         RlsgeMhRDS533GLeEcQmycWUvhhDg7Dfdo8RwfBO9F+kqCSXoQXPStvLRvVuxOyJjNQf
         aOZobM+2fPBuyB8zF7t3PPjI3ZTJQcNBMXPfQhfrmBUy2kRTy86Oc8Hlxfs0Z2+0A/30
         Wz8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794505979; x=1795110779;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F2YnP0s7EXjVFhqc1+OhYJjUXanL7Ulcltk2cgVR7UY=;
        b=ixRZI43kcII6C2bz9TAxKIy6C7oFW28a057huF09/seLGulygx7ekXS7kkEa5GxPJI
         w2uILt7zDKcFJr8BYmjdKjJCJl9DKc2oZlgpDZNZjpiv13cn7VYoklMH1wiXZAiwheJ/
         4NPQYMHXxzo1gCj4abvkuM5lxAwU49r92uvmwpYScjdX2VyCUrAA5C16VBQbP4SsxFWp
         SSspPTZFRz2oJ4AXJjlZYCzWz1p1uBBij+4I7QJ4fZtt0e/atPnvMkMLlCi8+Kc0/cmR
         YMUCGlHcpyCWJqEb1HYWK0jD66MpRgR0uJScyTWlKSV931tWo4vTLsN1NpyAFIgPuIgm
         /1zA==
X-Forwarded-Encrypted: i=1; AL+hErEvScxilpsT3TJqcYgXSEY1UmKmWq8xENyH64EJktJKNlOasuYk1m0hg+nWY6O9JFmyy7CdHqn/Ep0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+RBT1WEIFkM5yeQWyNyuzyvvzJWBgXL1yv1s+f5Q3w7SjjgcZ4
	cEx06TjmMEJ6ByINPdIYR9LJ6Q7d07gox3hvv68hr8rf/8ZQj37lgL1G
X-Gm-Gg: AYBFou1vPkCVX4oV5G91UsdVu9Wk+aAMylk+KGcGyS8N3ZW/LiXN4y0VFjYH6CDyCuQ
	Us/q8aceVYIq6JJpe+zJqoBTiLslyI2rAwOglnbDpmlJnczJP6hJAqkYWepn4U7kDNLPt7uRa57
	gD6KLdvFj9L+3Oj8NJL+Zmnz5eyCSPK4BtM7FckcinIF+8YmMDa8O5KBfbJ9mYdwSBaGZjD1Sn2
	z9lNKt0PXoZHcl6+V6lXQtf0KHNVfz17ZEL7haMgpokU5yytjTTBqibL6dDmoMt4dQ52Bmn974r
	FMxf6H010a0rjdPWkRzwQm7t+f/HuFbAlfnTWeQ5TsHUk3iVh1996ltw0oXcr3w+8zKplrreQKy
	0DsGCibkL2C+nyQp2heUjSFP0prbziyK/oFD62bB6ktbJGOp4acuHT0hE3CghzGnX1yCvhHYj17
	XrptXOamktdWLBXIl6MqxezPQkIa3a2Cp84JoOXCZDcwmO90Io/HYa3CXv7puAb0FIQ1NNMbtch
	ZiyOuK1B7CLW5yU7tw4rSmdXq4Y8Hs+Bk4YIFhOkuHfzoh3cj1obOmLWH8n/CcFvYhW43b2IEsE
	MRF2lN3/EoVHMDXXxSbtqIN4owXjJl+XfADZ
X-Received: by 2002:a05:6870:9f11:b0:494:76db:2aa8 with SMTP id 586e51a60fabf-4afdf191441mr400506fac.5.1794505979154;
        Thu, 12 Nov 2026 09:52:59 -0800 (PST)
Received: from [172.31.11.98] ([209.52.143.85])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4ae22f6a1aesm6023059fac.4.2026.11.12.09.52.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 09:52:58 -0800 (PST)
Message-ID: <fd4eaf33-363b-4f14-88d6-9723d1bf0f16@gmail.com>
Date: Thu, 12 Nov 2026 10:52:54 -0700
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
Subject: Re: [RFC 00/18] hw/cxl: Add a CXL Type-2 device
To: mhonap@nvidia.com, jic23@kernel.org, alwilliamson@nvidia.com,
 clg@redhat.com, xueshuai@linux.alibaba.com, ira.weiny@intel.com,
 zhiw@nvidia.com, mst@redhat.com, pierrick.bouvier@oss.qualcomm.com,
 junjie.cao@linux.dev, anisa.su@samsung.com, pbonzini@redhat.com,
 ankita@nvidia.com, vsethi@nvidia.com, skolothumtho@nvidia.com,
 mochs@nvidia.com, Weqaar Janjua <weqaar.janjua@packetfive.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Cc: cjia@nvidia.com, kjaju@nvidia.com, qemu-devel@nongnu.org,
 linux-cxl@vger.kernel.org
References: <20261106035911.1280066-1-mhonap@nvidia.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@gmail.com>
In-Reply-To: <20261106035911.1280066-1-mhonap@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026/11/05 20:58, mhonap@nvidia.com wrote:
> From: Manish Honap <mhonap@nvidia.com>
> 
> Hello,
> 
> This series adds cxl-type2, an emulated CXL Type-2 device with volatile
> device memory. It is emulated in such a way that all the Linux checks
> are satisfied so that CXL passthrough using vfio-pci (vfio-cxl) can be
> developed and tested in a guest without Type-2 hardware.
> 
> This series builds on the Type-2 model from Zhi's series (carried in
> Cédric's tree) and carries one fix from Shuai's tree. Shuai's tree also
> set up the decoders through device properties and stubbed CXL Reset; the
> firmware setup and CXL Reset here are new code.
> Carried patches keep their authors, with a note for each change.
> 
> The device:
> - PCI ID 1b36:0017 and the processing accelerator class 0x1200;
> - PCIe DVSEC for CXL Devices with CXL.cache, CXL.mem, one HDM range,
>    cache write-back and invalidate, CXL Reset and Mem Clr; Register
>    Locator and Flex Bus Port DVSECs;
> - CXL.cache advertised but not modelled. The device sends no CXL.cache
>    requests, and its memory is host RAM, which is coherent already. A
>    cache write-back and invalidate completes at once. The capability is
>    set because vfio-cxl takes a device as Type-2 only when it reports
>    both CXL.cache and CXL.mem;
> - component registers with one HDM decoder;
> - slot 0, function 0 below a CXL root port of a pxb-cxl, memory in one
>    fixed memory window selected with fmw-index, cold plug only (no
>    hotplug or unplug), not migratable.
> 
> No Linux driver claims the device on its own. cxl_pci does not bind to
> the accelerator class, and sfc, the other driver that calls the CXL
> core Type-2 interface, matches only its own devices. A guest binds
> cxl-type2 to vfio-pci, which hands it to vfio-cxl. Testing the CXL core
> Type-2 interface without vfio-cxl needs a driver for 1b36:0017 that
> calls it. There is none yet.
> 
> QEMU has no firmware that commits the HDM decoders of a CXL route at
> boot, and Linux attaches a Type-2 device only to a committed region
> (devm_cxl_probe_mem()). So QEMU does that step itself. cxl-type2
> registers its range with its pxb-cxl at realize (patch 13). At every
> reset the pxb-cxl commits HDM decoder 0 for it (patch 12), and the
> device commits its own decoder with Lock On Commit and enables
> CXL.cache, CXL.mem and HDM decoding (patch 14). A pxb-cxl with a
> registered range keeps its HDM decoder even with a single root port,
> where it would otherwise pass accesses through. Type-3 devices, and
> pxb-cxl without a registered range, are not affected.
> 
> A CXL Reset keeps the locked decoder committed, as RWL fields are not
> affected by CXL Reset once locked (CXL r4.0 Table 8-1). DVSEC Control,
> the range bases and HDM Decoder Global Control return to their
> defaults, which leaves Mem_Enable and HDM Decoder Enable at 0. While
> either is 0 the device drops CXL.mem, so guest accesses to its memory
> fail until software sets both bits again. The CXL.io part of the reset
> is not emulated. CONFIG_LOCK makes the RWL DVSEC fields read only until
> a system reset.
> 
> Patches:
> - 1-7:   Shared CXL code: read-0 ops for the CXL.io range of the
>           component registers, helpers from Zhi, an HDM decoder count,
>           DVSEC bit names, a device-neutral view for the direct mapping
>           code, PCI IDs;
> - 8-17:  The device; patch 16 also exports the default component
>           register write handling, so the device can check the enable
>           bits after a write;
> - 18:    Docs;
> 
> Left for later series:
> - The CXL device registers with the mailbox, event logs and MSI-X, and
>    the CDAT;
> - Direct mapping lifecycle fixes for Type-3 and switch topologies, and
>    Lock On Commit in host bridges and switches;
> - Fixes for guest-triggered aborts on 1 and 2 byte mailbox writes and a
>    repeated DOE Go;
> - Software-programmed decoders, for Linux-created Type-2 regions;
> - A Type-2 device below a CXL switch, and migration.
> 
> Testing:
> - Build every commit for x86_64 and aarch64, checkpatch for style.
> - vfio-cxl selftest (vfio_cxl_type2_test) in an Arm L1 guest on KVM,
>    with the device below a CXL root port and an SMMUv3: 19 of 19 pass
> 
> - Not tested: x86_64 L1, a build without CONFIG_CXL_TYPE2_DEVICE.
> 
> The Linux vfio-cxl series(v5) this was tested with:
> https://lore.kernel.org/r/20260916183540.3813685-1-mhonap@nvidia.com
> 
> Sent as RFC to get comments on the series structure and to request
> 1b36:0017 devid for cxl-type2 device allocation.

Note: that device ID has already been requested for a device called 
CnuasNIC:

("[PATCH v3 0/6] hw: Add Cnuas virtual devices")
https://lore.kernel.org/qemu-devel/20260929202358.725310-1-weqaar.janjua@packetfive.com/

Regards,
Akihiko Odaki

> 
> References:
> [PATCH RFC 0/5] hw/cxl: Type 2 Device RFC
> https://lore.kernel.org/linux-cxl/20230517-rfc-type2-dev-v1-0-6eb2e470981b@intel.com/
> 
> Type-2 emulation trees:
> 
> [1] Zhi Wang
> https://github.com/zhiwang-nvidia/qemu/commits/zhi/qemu-type2-emulation-for-review
> 
> [2] Cédric Le Goater
> https://github.com/legoater/qemu/tree/cxl-type2
> 
> [3] Shuai Xue
> https://gitee.com/axiqia/qemu-kvm/tree/cxl-type2-test
> 
> Manish Honap (12):
>    hw/cxl: Make HDM decoder initialization count-aware
>    hw/cxl: Define the CXL Device DVSEC capability and control bits
>    hw/cxl: Find the memory of a CXL device through one helper
>    hw/pci: Add PCI IDs for the CXL Type-2 device
>    hw/mem: Require a CXL root port of a pxb-cxl for cxl-type2
>    hw/pci-bridge: Add firmware HDM decoder state to pxb-cxl
>    hw/mem: Bind cxl-type2 to a fixed memory window
>    hw/mem: Commit the cxl-type2 HDM decoder at reset
>    hw/mem: Add CXL.cache with cache write-back and invalidate to
>      cxl-type2
>    hw/mem: Implement CXL Reset for cxl-type2
>    hw/mem: Clear the cxl-type2 volatile memory on a CXL Reset request
>    docs/cxl: Document the CXL Type-2 device
> 
> Shuai Xue (1):
>    hw/cxl: Give the component register .io sub-region read-0 ops
> 
> Zhi Wang (5):
>    hw/cxl: Factor out cxl_host_addr_to_dpa()
>    hw/cxl: Introduce cxl_component_update_dvsec()
>    hw/cxl: Introduce CXL type-2 device emulation
>    hw/cxl: Add the CXL type-2 DVSECs and component registers
>    hw/cxl: Map the CXL type-2 device memory through the fixed windows
> 
>   MAINTAINERS                             |   1 +
>   docs/specs/pci-ids.rst                  |   2 +
>   docs/system/devices/cxl.rst             |  68 +++
>   hw/cxl/cxl-component-utils.c            | 227 +++++++++-
>   hw/cxl/cxl-host.c                       | 130 ++++--
>   hw/mem/Kconfig                          |   5 +
>   hw/mem/cxl_type2.c                      | 580 ++++++++++++++++++++++++
>   hw/mem/cxl_type2_stubs.c                |  20 +
>   hw/mem/cxl_type3.c                      |  68 +--
>   hw/mem/meson.build                      |   2 +
>   hw/pci-bridge/pci_expander_bridge_cxl.c |  27 +-
>   include/hw/cxl/cxl.h                    |   1 +
>   include/hw/cxl/cxl_component.h          |  26 ++
>   include/hw/cxl/cxl_device.h             |  27 ++
>   include/hw/cxl/cxl_pci.h                |  31 ++
>   include/hw/pci/pci.h                    |   1 +
>   include/hw/pci/pci_bridge.h             |   6 +
>   include/hw/pci/pci_ids.h                |   3 +
>   18 files changed, 1102 insertions(+), 123 deletions(-)
>   create mode 100644 hw/mem/cxl_type2.c
>   create mode 100644 hw/mem/cxl_type2_stubs.c
> 
> 
> base-commit: f71afb409a87c4ecd0f9d63a5963eb645dfab780

