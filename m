Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793846193;
	b=KmRFb3efZ1PVBoVWYlqJjzg7eh1GlFrWiNadX9fxM29sOwh+egxVnN8ud4KGxloxmm3S
	 AQI0W52JOU15Vp3+6xnNMeA7uV7DDl9Vw7/QXG4nwnI6cdroUhaAyH0cWrEUQqqlkzn0v
	 p/VJfu1dhXIV1gCNpIHyIbh0sstGBBy6skCTA3btUCyUEfJI+iLyjvTo5XOwm5ZJkvsRc
	 Jfb+y6aHKEXP2OGEINRTgZn36kyiq+yk0xk1gBk+uzcViN8mmbyDAKVc/5dPrDrgLU+MX
	 R9TBVsjfXUTlbVqfhbh4GzyS/xZ2RRD99n9qUiBjA7z5LxunZYnpkLj35LgnX/xk8Fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793846193;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=nViQXEXb8FJgMvus18RjRAnfJrMbGBdJOVdrFbyGTMQ=;
	b=3sTTSQ+SdLB0WUaeGaZstmftp2OdBlrXI1rbfhb/y5BBBx7IP4dYQIGad/JWZ9BPSxFQ
	 dNQ3M6nblW0IVoWfiMa9Ac+S4ZbKs8l3TvXHBVCjoGBAw3t5UVSOrFFvTm+2VDFNW55A7
	 9q1sz0MfNvrGrdTOwi4MmdRv56K9h9G7pq4Dbmh7wUpk7jQ/C0PStyJOiLtl2W9e+AKsq
	 alN8u+9WWx4X6U+IWApYx0f7iTLGf0EyGf9EQ+nSNV4hEhRyuvuEo3/lJIN+2W0RLYwEp
	 DsQLZIeNNqnSjqeAkJISXrBZpxr+H2Sf4DiMiEZoPiwuarOeNdnagY7ocg6pLTRWGrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kkptAAVg;
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B0D606A31B
	for <linux-cxl@vger.kernel.org>; Thu,  5 Nov 2026 02:36:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6B0D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kkptAAVg
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ed2bfe3252so328525ad.3
        for <linux-cxl@vger.kernel.org>; Wed, 04 Nov 2026 18:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793846192; x=1794450992; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nViQXEXb8FJgMvus18RjRAnfJrMbGBdJOVdrFbyGTMQ=;
        b=kkptAAVgwI1IbYVsRqOfHoA8AHY9X4pJTfUcPoV3N0iIhGIlQXlDjbmHJXczwo530Y
         GoCV5YMIJ4gvl3focQqJx7Vn01znYLBNNLUyCACBze1U/pyzCe+jDPJ2x3CMFTI2Qo63
         jG/oLOjb0xeDzM2kKwy+ZMsaemXHy96dhMI0m1uNo5eJr3kgYfGzjEBkj7y77eFJbpYq
         Y5iLl+TjIweiBo0goHKrZXTzfM6S+rk7bUfM1UdbrH7HbDKONvvk73v0wQw+VUknbwW4
         x5FYY14Jd3EANNPPxtafNzgwo5wBUE6+babDqNVfHcb3ZoNXYp4e4qTHUk0PD7fSkTqc
         gDwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793846192; x=1794450992;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nViQXEXb8FJgMvus18RjRAnfJrMbGBdJOVdrFbyGTMQ=;
        b=V0xRoXPVeZH8/QRMPnNl1008tbg8CasOZbpaeaMRzkuKRlpoNoknw10MBphhgzwTdB
         UmTCj5GuZsfNoFKzUNZeIZm52EMp1oMQKAPRe3NPHpv/nKBtLHDE2xzLkfW6jxSoZ1To
         4m9VL4LLPp5TT89wY/r8o9o0RwBBEZy2DfB9FFfjMIfyCZYKXGFvGl7uMAtfP6h2JTjz
         s1+1KSFvCqV8BjRLJLfJt2Y+JN2ppF3dshi13Ljdx9MWMg9bqJEC+M12cJ9rqDP0ucVj
         sYWw9imrZdM4X4aSc3yCW4KHrF6WAIS6OsxKkrQj/ntVBjHydLOlMGgXc2ppeLuzJhX3
         XqEA==
X-Forwarded-Encrypted: i=1; AKwUvBwGQ4Qel0XPimYrrEhPAUnrT85q5+w3BUxd3mpHabgRPuxy4sunx+446aBZr/dzvM3qOW7IUoZqgvg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+57hgccyypcddBpOpz48/AnjuhYtMWhUmdgzSnd7lm8rn10h01
	NZjVSW7j/rf/HfxpRCMZap/yI53NL9qOH+28oA245eLfAWUD10oce15c
X-Gm-Gg: AYBFou3TbXvVkVkiMfauFcWesGTVxa2hAu9z/ANkP8KKywIoV4lChggsFt3IJm5jvet
	jmyc21mpF/qF9aqUaRpVHMnXatMVxEhoZOVgQRP5OkM8FhqHDI0LDnkWZ2v2/9i0cc6ZvYvRROg
	Ln00vOT3JKaoUTfguftjscD3PD9RtRI5svq8DKRPQZT7nEUzM3+JDn3XnehEvbomADAqSEEnFGm
	AoJh498f1zlN/omdqhuOzo3B46ytj1nQt1ozxvYeGVyN1Ic4IxNqZ4plorNMso1ihAme+1v1CSE
	l0qkkPOmi2WSnl3j1XoMvujJTHIgCPcFiL5rJhBf2XFn6LmDqD7vkgEgdn5nDl9uJvJOUwdGCTT
	ndNJC/cJzPpPWZHLvTo9hwRmQeT309epXYFQRoyS+QDpnO5jtZiGk0en70cCYjx1cZu4WU76z6e
	/iPr82nByDB65qB/UgbOukI5HR9iA6lJUp6VnC71flmUxssdhwtABrwxBj8CJPB2C8LyUxGpVCI
	mVIaY5oSK9d0RQcPX8WmLrgwDKgJL9yfjRX40wioHAYeiE3xuAXR2y4rRf6fjcPBG/16Q4rG2Tj
	p3/whaVctcculMDetdelZUHEqg==
X-Received: by 2002:a17:903:1844:b0:2e9:8bd4:577d with SMTP id d9443c01a7336-2eb364de4d8mr173672565ad.37.1793846191761;
        Wed, 04 Nov 2026 18:36:31 -0800 (PST)
Received: from cxlqual ([220.120.90.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed0921c78fsm12134315ad.74.2026.11.04.18.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 18:36:30 -0800 (PST)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Thu, 5 Nov 2026 11:38:48 +0900
To: Yukiya Takaki <fj2110jc@fujitsu.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
	Ani Sinha <anisinha@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Junjie Cao <junjie.cao@intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	linux-cxl@vger.kernel.org, qemu-arm@nongnu.org,
	"Wolski, Tomasz" <tomasz.wolski@fujitsu.com>, lizhijian@fujitsu.com,
	y-goto@fujitsu.com, yukiya.takaki@gmail.com
Subject: Re: [PATCH RFC 0/7] QEMU/hw/cxl: Allow CXL Type 3 memory regions to
 be initialized at guest boot
Message-ID: <auvsOE3OlS5I9ueG@cxlqual>
References: <cover.1793003983.git.fj2110jc@fujitsu.com>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1793003983.git.fj2110jc@fujitsu.com>

On Mon, Oct 26, 2026 at 07:03:21PM +0900, Yukiya Takaki wrote:
> Hello everyone,
> 
> I’m a student intern, and this is my first time sending patches to an open source mailing list.
> 
> This patch series configures QEMU’s CXL Type 3 devices so that guest operating systems can automatically discover
> and create CXL regions during boot, aligning QEMU’s behavior with real hardware.
> 
> Background and motivation
>   Currently, during guest boot QEMU does not provide the information or register programming needed for the guest OS
>   to initialize CXL Type 3 memory, so using it still requires an explicit action in the guest (for example, running the cxl create-region command).
>   By contrast, on some physical systems the firmware automatically allocates CXL memory ranges and exposes them to the OS,
>    allowing the Linux CXL driver to discover and create regions during boot.
>   This patch series is a first, experimental attempt to reproduce that behavior in QEMU.
> 
>   Some parts of this implementation are based on Li, Zhijian’s work in:
>   https://github.com/zhijianli88/qemu/tree/program-decoder-v2
> 
>   I would like to ask for feedback on whether this approach makes sense and whether I should continue to enhance it.
> 
> Approach
>   This patch first adds a program_hdm_decoder option to cxl-type3.
>   When program-hdm-decoder is enabled on cxl-type3, QEMU will:
>     1) program endpoint/host-bridge HDM decoder state,
>     2) expose Type 3 ranges as E820_SOFT_RESERVED on x86,
>     3) create memory-only NUMA nodes for those ranges,
>     4) emit SRAT memory-affinity entries mapping each Type 3 HPA range to its node ID
> 
>   On real hardware, HDM decoder programming and memory layout are typically handled by firmware, so they would ideally be managed by SeaBIOS.
>   However, in the current QEMU/SeaBIOS model, E820 and SRAT are built on the QEMU side, and pushing HDM decoder programming
>   into SeaBIOS would introduce additional complexity and risk inconsistencies.
> 
Hi again,

Thank you for your contribution. I think this series can be valuable for
helping test autodiscovery in the kernel driver. I spent more time looking over this
patchset and in my view, the main blockers for making this ready for upstream are:

1.The HPA state is kept in the wrong place.
Patch 2 adds hpa_offset, idx and node to CXLType3Dev but and endpoint should
not track host state.

I also think it makes more sense to make program-dhm-decoder a machine
option (-M program-hdm-decoder...) instead of having it on cxl-type3
endpoint

2. Host bridge register init moved from reset to realize.
As you mentioned below, "The current implementation prevents the host
bridge HDM decoder configuration from being overwritten later in the same reset
by moving the common initialization of the host bridge component registers from
the reset path to the realization path."

To more accurately emulate what firmware does, maybe you can try
something like the following?

1. Add program-hdm option to machine (hw/cxl/cxl-host.c, include/hw/cxl/cxl.h)

typedef struct CXLState {
    bool is_enabled;
+   bool program_hdm_decoders;
    ...
} CXLState;

+static void machine_set_hdm_auto(Object *obj, Visitor *v, const char *name,
+                                 void *opaque, Error **errp)
+{
+    CXLState *cxl_state = opaque;
+    bool value;
+
+    if (!visit_type_bool(v, name, &value, errp)) {
+        return;
+    }
+    cxl_state->program_hdm_decoders = value;
+}

 void cxl_machine_init(Object *obj, CXLState *state)
 {
     ...
+    object_property_add(obj, "cxl-hdm-auto", "bool", machine_get_hdm_auto,
+                        machine_set_hdm_auto, NULL, state);
+    object_property_set_description(obj, "cxl-hdm-auto",
+                                    "Set on/off to have HDM decoders "
+                                    "programmed at reset as firmware would");

2. Add cxl_fmws_program_decoders() to pxb_cxl reset exit.
Every device has 3 reset phase: enter, hold, and exit. Currently,
pxb-cxl has:
- enter = none
- hold = pxb_cxL-dev_reset(), which zeroes registers
- exit = none

Register cxl_fmws_program_decoders() to pxb-cxl reset exit.

cxl-host.c:
+void cxl_fmws_for_each_auto_range(PXBCXLDev *pxb)
{

+ /* use existing helper cxl_fmws_get_all_sorted to iterate */
+ GSList *fws = cxl_fmws_get_all_sorted(), *it;
+
+for (it = fws; it; it = it->next) {
+    CXLFixedWindow *fw = CXL_FMW(it->data);
	/* program decoders here */

+    }
}
 ...

+/* Call from the pxb-cxl reset exit phase, see pxb_cxl_dev_reset_exit() */
+void cxl_fmws_program_decoders(PXBCXLDev *pxb)
+{
+    cxl_fmws_for_each_auto_range(pxb);
+}

--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
 #include "hw/cxl/cxl.h"
+#include "hw/cxl/cxl_host.h"

+static void pxb_cxl_dev_reset_exit(Object *obj, ResetType type)
+{
+    PXBCXLDev *pxb = PXB_CXL_DEV(obj);
+    PXBCXLDevClass *pc = PXB_CXL_DEV_GET_CLASS(obj);
+
+    if (pc->parent_phases.exit) {
+        pc->parent_phases.exit(obj, type);
+    }
+    if (pxb->cxl_state && pxb->cxl_state->program_hdm_decoders) {
+        cxl_fmws_program_decoders(pxb);
+    }
+}
+
static void pxb_cxl_dev_class_init(ObjectClass *klass, const void *data)
 {
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
     ...
     device_class_set_legacy_reset(dc, pxb_cxl_dev_reset);
+    rc->phases.exit = pxb_cxl_dev_reset_exit;
 }

This way, we shouldn't need to store the extra state (hpa_offset,etc.)
in the cxl-type3 endpoints.

I'm also not that familiar with the machine initialization and reset
stages, so maybe this approach doesn't work, but this is my best guess.

Thanks,
Anisa

> Testing
>   We ran tests in the following environment and confirmed that CXL regions were created at boot, NUMA nodes were set up,
>   and E820_SOFT_RESERVED entries appeared in the E820 table:
> 
>   - BIOS: SeaBIOS c2a33ad9ad1452e23b41c4ac44a3bc6be8ebc4cf
>   - CXL memory: 4 GB
>   - CFMWS: 4 GB
>   - Host bridge: 1
> 
>   The following is the startup script.
> 
>   sudo /path/to/qemu/build/qemu-system-x86_64 \
>     -name guest=cxl \
>     -nographic \
>     -machine q35,accel=tcg,nvdimm=on,cxl=on \
>     -cpu max -smp 4,sockets=4,cores=1,threads=1 \
>     -m size=4G,slots=10,maxmem=20G \
>     -drive file=/path/to/image.qcow2,format=qcow2,index=0,media=disk,id=hd \
>     -bios /path/to/seabios/out/bios.bin \
>     -nic bridge,br=virbr0,model=e1000e,mac=52:54:00:b5:4e:7c \
>     -object memory-backend-ram,size=2G,id=m0 \
>     -object memory-backend-ram,size=2G,id=m1 \
>     -numa node,nodeid=0,cpus=0-1,memdev=m0 \
>     -numa node,nodeid=1,cpus=2-3,memdev=m1 \
>     -device pcie-root-port,id=pci-root,slot=4,bus=pcie.0,chassis=0 \
>     -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1,hdm_for_passthrough=true \
>     -device cxl-rp,port=0,id=root_port13,bus=cxl.1,chassis=0,slot=2 \
>     -object memory-backend-ram,size=4G,share=on,id=vmem0 \
>     -device cxl-type3,bus=root_port13,volatile-memdev=vmem0,id=cxl-vmem0,program-hdm-decoder=true \
>     -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k
>   
>   Furthermore, we conducted the experiment in which we added two CXL Type3.
> 
>   - CXL memory: 4 GB × 2
>   - CFMWS: 4 GB × 2
> 
>   The following is the startup script.
>     
>   sudo /path/to/qemu/build/qemu-system-x86_64 \
>     -name guest=cxl \
>     -nographic \
>     -machine q35,accel=tcg,nvdimm=on,cxl=on,hmat=on \
>     -cpu max -smp 4,sockets=4,cores=1,threads=1 \
>     -m size=4G,slots=10,maxmem=20G \
>     -drive file=/path/to/image.qcow2,format=qcow2,index=0,media=disk,id=hd \
>     -bios /path/to/seabios/out/bios.bin \
>     -nic bridge,br=virbr0,model=e1000e,mac=52:54:00:b5:4e:7c \
>     -object memory-backend-ram,size=2G,id=m0 \
>     -object memory-backend-ram,size=2G,id=m1 \
>     -numa node,nodeid=0,cpus=0-1,memdev=m0 \
>     -numa node,nodeid=1,cpus=2-3,memdev=m1 \
>     -device pcie-root-port,id=pci-root,slot=4,bus=pcie.0,chassis=0 \
>     -device pcie-root-port,id=pci-root-net,chassis=5,slot=5,bus=pcie.0 \
>     -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1,hdm_for_passthrough=true \
>     -device cxl-rp,port=0,id=root_port13,bus=cxl.1,chassis=0,slot=2 \
>     -device cxl-rp,port=3,id=root_port14,bus=cxl.1,chassis=2,slot=4 \
>     -object memory-backend-ram,size=4G,share=on,id=vmem0 \
>     -object memory-backend-ram,size=4G,share=on,id=vmem1 \
>     -device cxl-type3,bus=root_port13,volatile-memdev=vmem0,id=cxl-vmem0,program-hdm-decoder=true \
>     -device cxl-type3,bus=root_port14,volatile-memdev=vmem1,id=cxl-vmem1,program-hdm-decoder=true \
>     -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k,cxl-fmw.1.targets.0=cxl.1,cxl-fmw.1.size=4G,cxl-fmw.1.interleave-granularity=4k
> 
> 
> How to use
>   Specify the following parameters when starting QEMU:
> 
>   - bios <SeaBIOS binary that includes commit c2a33ad9ad1452e23b41c4ac44a3bc6be8ebc4cf> to ensure that E820_SOFT_RESERVED entries are exposed
>   - Add hmat=on to the -machine option [1]
>   - Add program-hdm-decoder=true to each -device cxl-type3 option
>     [1] On Linux, the kernel first checks E820_SOFT_RESERVED ranges. When multiple CXL Type 3 devices share a contiguous HPA range,
>         these ranges tend to be merged into a single region, so the CXL driver cannot reliably initialize per‑device regions based on E820 alone.
>         SRAT entries for CXL memory are therefore needed, and the guest seems to discard SRAT when `hmat=on` is not specified,
>         so HMAT must be enabled.
> 
> QEMU base commit: bddb785e791e415db38884848d068457e226f5e3
> 
> TODO
>   With the current implementation of this patch, the following configurations are either not supported or have not been sufficiently tested.
>   As a result, automatic creation of CXL regions in the guest OS may fail:
> 
>   - A CXL persistent memory device is included
>   - Interleaved configurations
>   - Cases where the memory size specified by CFMWS does not match the size of the CXL Type 3 backend memory
>   - Configurations where CXL memory is attached via a switch
>   - Multi-target CFMWS environments
>   - ARM environments
>   - HMAT does not yet include information about CXL memory devices
> 
>   The following behaviors are also provisional implementations and may need further refinement:
>    - A new NUMA node ID is assigned to each CXL memory device. This should be improved either to reflect more accurate NUMA distances for CXL memory,
>      or to allow the NUMA node IDs to be specified by the user.
>    - Assignment of CXL Type 3 devices to CFMWS address ranges. On physical systems, platform firmware typically generates CFMWS entries
>      based on the detected CXL topology and its address-space allocation. In QEMU, however, CFMWS entries are configured explicitly
>      through machine options. The current implementation therefore has to infer which CFMWS range should be used for each Type 3 device.
>      This selection logic may need further refinement. Possible approaches include improving the selection and validation logic,
>      adding an explicit option to associate each Type 3 device with a CFMWS entry,
>      or generating CFMWS entries automatically from the configured CXL topology and devices.
>    - HDM decoder reset sequencing and state reconstruction.
>      The current implementation prevents the host bridge HDM decoder configuration from being overwritten later in the same reset
>      by moving the common initialization of the host bridge component registers from the reset path to the realization path.
>      However, ideally, after the registers have been restored to their reset values, the host bridge HDM decoder configuration
>      automatically programmed by QEMU should be reconstructed as part of reset processing.
> 
> Thanks,
> 
> ------
> 
> Yukiya Takaki (7):
>   QEMU/hw/cxl: add program-hdm-decoder option for CXL Type 3 devices
>   QEMU/hw/cxl:add HPA offset tracking for CXL Type 3 devices
>   QEMU: hw/cxl: add helper to get HPA range for CXL Type 3
>   QEMU/hw/cxl: auto‑program HDM decoders for CXL Type 3
>   QEMU/hw/cxl: expose CXL Type 3 ranges as E820_SOFT_RESERVED on x86
>   QEMU/hw/cxl: Create NUMA nodes for CXL Type 3 memory
>   add CXL Type 3 memory ranges to SRAT
> 
>  hw/acpi/cxl_type3.c                 |  30 +++++
>  hw/acpi/meson.build                 |   1 +
>  hw/arm/cxl.c                        |  10 ++
>  hw/arm/meson.build                  |   2 +
>  hw/cxl/cxl-host.c                   |  63 ++++++++++
>  hw/i386/acpi-build.c                |   7 ++
>  hw/i386/cxl.c                       |  11 ++
>  hw/i386/meson.build                 |   1 +
>  hw/i386/pc.c                        |   2 +
>  hw/mem/cxl_type3.c                  | 177 ++++++++++++++++++++++++++++
>  hw/pci-bridge/pci_expander_bridge.c |  13 +-
>  include/hw/cxl/cxl.h                |   2 +
>  include/hw/cxl/cxl_device.h         |   6 +
>  include/hw/cxl/cxl_host.h           |   3 +
>  include/hw/mem/cxl_type3.h          |   8 ++
>  15 files changed, 334 insertions(+), 2 deletions(-)
>  create mode 100644 hw/acpi/cxl_type3.c
>  create mode 100644 hw/arm/cxl.c
>  create mode 100644 hw/i386/cxl.c
>  create mode 100644 include/hw/mem/cxl_type3.h
> 
> -- 
> 2.52.0
> 
