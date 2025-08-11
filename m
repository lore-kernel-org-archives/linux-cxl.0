Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EEB1DFDAB
	for <linux-cxl@vger.kernel.org>; Mon, 11 Aug 2025 16:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754930024; cv=none; b=tKpmnPa4ppBpWXXNk0IByv8y4JjhxbrGp+UgnP0/se7Rtyd7ovWJ7LG5tEXT2YUX04yFXv9AwjepVO0Sw4lys6gPPEw/NslFEp4LvvJIANlqty+OVwMa0qhAG924O3bmngCWQkl1GRpaDPfYPY0yjzbGRFQy1Vt/DKCHZDQIhB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754930024; c=relaxed/simple;
	bh=Zy1tsBFQ+TGpKtw7gQPlSiKAV4wyFpI4xS7QEroLtjY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dzK9/VTgRhhvEfZONLyAnOaej+8td5MCpp8WJFPY1X30MUIpvePbiFNptUzwg6hQyHSuaybWwGGcyq7eUYdQ6GcDlnuWBWlOB/wNtrvplLFlY8pYYFqPbeoWucAToxxPet3OIiltoyhJOa7TJwuDYCBcwRCmCdoB/S3efmC0HBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c10Sf55gyz6L5Y4;
	Tue, 12 Aug 2025 00:28:50 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 17C3D140278;
	Tue, 12 Aug 2025 00:33:38 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 11 Aug
 2025 18:33:37 +0200
Date: Mon, 11 Aug 2025 17:33:36 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <ira.weiny@intel.com>, <alucerop@amd.com>, <a.manzanares@samsung.com>,
	<linux-cxl@vger.kernel.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH 4/4] hw/cxl: Support type3 HDM-DB
Message-ID: <20250811173336.00003255@huawei.com>
In-Reply-To: <20250811033405.332295-5-dave@stgolabs.net>
References: <20250811033405.332295-1-dave@stgolabs.net>
	<20250811033405.332295-5-dave@stgolabs.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Sun, 10 Aug 2025 20:34:05 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> Add basic plumbing for memory expander devices that support Back
> Invalidation. This introduces a 'hdm-db=on|off' parameter and
> exposes the relevant BI RT/Decoder component cachemem registers.
> 
> Some noteworthy properties:
>  - Devices require enabling Flit mode.
>  - Explicit BI-ID commit is required.
>  - HDM decoder support both host and dev coherency models.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Hi Davidlohr,

Ran out of time last week, so didn't get as far on this as I should have done.
Anyhow, comments follow.

> ---
>  docs/system/devices/cxl.rst    |  23 ++++++
>  hw/cxl/cxl-component-utils.c   | 135 +++++++++++++++++++++++++++++++--
>  hw/mem/cxl_type3.c             |  14 +++-
>  include/hw/cxl/cxl_component.h |  54 ++++++++++++-
>  include/hw/cxl/cxl_device.h    |   3 +
>  5 files changed, 217 insertions(+), 12 deletions(-)
> 
> diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
> index bf7908429af8..4815de0f2dc4 100644
> --- a/docs/system/devices/cxl.rst
> +++ b/docs/system/devices/cxl.rst
> @@ -384,6 +384,29 @@ An example of 4 devices below a switch suitable for 1, 2 or 4 way interleave::
>    -device cxl-type3,bus=swport3,persistent-memdev=cxl-mem3,lsa=cxl-lsa3,id=cxl-pmem3,sn=0x4 \
>    -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k
>  
> +An example of 4 type3 devices with volatile memory below a switch. Two of the devices
> +use HDM-DB for coherence::
> +
> +  qemu-system-x86_64 -M q35,cxl=on -m 4G,maxmem=8G,slots=8 -smp 4 \
> +  ...
> +  -object memory-backend-file,id=cxl-mem0,share=on,mem-path=/tmp/cxltest.raw,size=256M \
> +  -object memory-backend-file,id=cxl-mem1,share=on,mem-path=/tmp/cxltest1.raw,size=256M \
> +  -object memory-backend-file,id=cxl-mem2,share=on,mem-path=/tmp/cxltest2.raw,size=256M \
> +  -object memory-backend-file,id=cxl-mem3,share=on,mem-path=/tmp/cxltest3.raw,size=256M \
> +  -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
> +  -device cxl-rp,port=0,bus=cxl.1,id=root_port0,chassis=0,slot=0 \
> +  -device cxl-rp,port=1,bus=cxl.1,id=root_port1,chassis=0,slot=1 \
> +  -device cxl-upstream,bus=root_port0,id=us0,256b-flit=on \
> +  -device cxl-downstream,port=0,bus=us0,id=swport0,chassis=0,slot=4 \
> +  -device cxl-type3,bus=swport0,volatile-memdev=cxl-mem0,id=cxl-mem0,sn=0x1,256b-flit=on,hdm-db=on \
> +  -device cxl-downstream,port=1,bus=us0,id=swport1,chassis=0,slot=5 \
> +  -device cxl-type3,bus=swport1,volatile-memdev=cxl-mem1,id=cxl-mem1,sn=0x2,256b-flit=on,hdm-db=on \
> +  -device cxl-downstream,port=2,bus=us0,id=swport2,chassis=0,slot=6 \
> +  -device cxl-type3,bus=swport2,volatile-memdev=cxl-mem2,id=cxl-mem2,sn=0x3 \
> +  -device cxl-downstream,port=3,bus=us0,id=swport3,chassis=0,slot=7 \
> +  -device cxl-type3,bus=swport3,volatile-memdev=cxl-mem3,id=cxl-mem3,sn=0x4 \
> +  -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k
> +
>  A simple arm/virt example featuring a single direct connected CXL Type 3
>  Volatile Memory device::
>  
> diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
> index a43d227336ca..dfdbf23a427c 100644
> --- a/hw/cxl/cxl-component-utils.c
> +++ b/hw/cxl/cxl-component-utils.c
> @@ -71,10 +71,40 @@ static uint64_t cxl_cache_mem_read_reg(void *opaque, hwaddr offset,
>      case 4:
>          if (cregs->special_ops && cregs->special_ops->read) {
>              return cregs->special_ops->read(cxl_cstate, offset, 4);

I'm not 100% sure we ever used the special_ops->read.  Might be able to just rip that
out.  

> -        } else {
> -            QEMU_BUILD_BUG_ON(sizeof(*cregs->cache_mem_registers) != 4);
> -            return cregs->cache_mem_registers[offset / 4];
>          }
> +
> +        QEMU_BUILD_BUG_ON(sizeof(*cregs->cache_mem_registers) != 4);
> +
> +        if (offset == A_CXL_BI_RT_STATUS ||
> +            offset == A_CXL_BI_DECODER_STATUS) {

I suppose this does exist for all types, so special_ops->read doesn't
make sense and it indeed belongs in here.

> +            int type;
> +            uint64_t started;
> +
> +            type = (offset == A_CXL_BI_RT_STATUS) ?
> +                    CXL_BISTATE_RT : CXL_BISTATE_DECODER;
> +            started = cxl_cstate->bi_state[type].last_commit;
> +
> +            if (started) {
> +                uint32_t val, *cache_mem = cregs->cache_mem_registers;

I'd split
               uing32_t *cache_mem = cregs->cache_mem_registers;
               uint32_t val = cache_mem[offset / 4];

> +                uint64_t now;
> +                int set;
> +
> +                val = cregs->cache_mem_registers[offset / 4];

You just added a local variable cache_mem.

> +                now = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
> +                /* arbitrary 100 ms to do the commit */
> +                set = !!(now >= started + 100);
> +
> +                if (offset == A_CXL_BI_RT_STATUS) {
> +                    val = FIELD_DP32(val, CXL_BI_RT_STATUS, COMMITTED, set);
> +                } else {
> +                    val = FIELD_DP32(val, CXL_BI_DECODER_STATUS, COMMITTED,
> +                                     set);
> +                }
> +                stl_le_p((uint8_t *)cache_mem + offset, val);
> +            }
> +        }
> +
> +        return cregs->cache_mem_registers[offset / 4];
>      case 8:
>          qemu_log_mask(LOG_UNIMP,
>                        "CXL 8 byte cache mem registers not implemented\n");
> @@ -123,6 +153,47 @@ static void dumb_hdm_handler(CXLComponentState *cxl_cstate, hwaddr offset,
>      }
>  }
>  
> +static void dumb_bi_handler(CXLComponentState *cxl_cstate, hwaddr offset,

Can probably drop the dumb.  For the HDM decoder one it was
meant to remind me to come back and add validity checks etc
(which I haven't done yet!) That will accept parameters that make
no sense and hence fail in rather hard to debug ways.

I don't think the same applies to this.

> +                            uint32_t value)
> +{
> +    ComponentRegisters *cregs = &cxl_cstate->crb;
> +    uint32_t sts, *cache_mem = cregs->cache_mem_registers;
> +    bool to_commit = false;
> +    int type;
> +
> +    switch (offset) {
> +    case A_CXL_BI_RT_CTRL:
> +        to_commit = FIELD_EX32(value, CXL_BI_RT_CTRL, COMMIT);
> +        if (to_commit) {
> +            sts = cxl_cache_mem_read_reg(cxl_cstate,
> +                                         R_CXL_BI_RT_STATUS, 4);
> +            sts = FIELD_DP32(sts, CXL_BI_RT_STATUS, COMMITTED, 0);
> +            stl_le_p((uint8_t *)cache_mem + R_CXL_BI_RT_STATUS, sts);
> +            type = CXL_BISTATE_RT;
> +        }
> +        break;
> +    case A_CXL_BI_DECODER_CTRL:
> +        to_commit = FIELD_EX32(value, CXL_BI_DECODER_CTRL, COMMIT);
> +        if (to_commit) {
> +            sts = cxl_cache_mem_read_reg(cxl_cstate,
> +                                         R_CXL_BI_DECODER_STATUS, 4);
> +            sts = FIELD_DP32(sts, CXL_BI_DECODER_STATUS, COMMITTED, 0);
> +            stl_le_p((uint8_t *)cache_mem + R_CXL_BI_DECODER_STATUS, sts);
> +            type = CXL_BISTATE_DECODER;
> +        }
> +        break;
> +    default:
> +        break;
> +    }
> +
> +    if (to_commit) {
> +        cxl_cstate->bi_state[type].last_commit =
> +                qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
> +    }
> +
> +    stl_le_p((uint8_t *)cache_mem + offset, value);
> +}

> @@ -248,7 +322,7 @@ static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk,

As on later functions I think we need to pass in a separate flag rather than
using the type (for long term maintenance reasons)

>      ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, INTERLEAVE_4K, 1);
>      ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
>                       POISON_ON_ERR_CAP, 0);
> -    if (type == CXL2_TYPE3_DEVICE) {
> +    if (type == CXL2_TYPE3_DEVICE || type == CXL3_TYPE3_DEVICE) {
>          ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, 3_6_12_WAY, 1);
>          ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, 16_WAY, 1);
>      } else {
> @@ -260,7 +334,8 @@ static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk,
>                       UIO_DECODER_COUNT, 0);
>      ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, MEMDATA_NXM_CAP, 0);
>      ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
> -                     SUPPORTED_COHERENCY_MODEL, 0); /* Unknown */
> +                     SUPPORTED_COHERENCY_MODEL,
> +                     type == CXL3_TYPE3_DEVICE ? 3:0); /* host+dev or Unknown */

Spaces around the :

>      ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_GLOBAL_CONTROL,
>                       HDM_DECODER_ENABLE, 0);
>      write_msk[R_CXL_HDM_DECODER_GLOBAL_CONTROL] = 0x3;

>  
> +static void bi_rt_init_common(uint32_t *reg_state, uint32_t *write_msk)
> +{
> +    /* switch usp must commit the new BI-ID, timeout of 2secs */
> +    ARRAY_FIELD_DP32(reg_state, CXL_BI_RT_CAPABILITY, EXPLICIT_COMMIT, 1);
> +
> +    ARRAY_FIELD_DP32(reg_state, CXL_BI_RT_CTRL, COMMIT, 0);
> +    write_msk[R_CXL_BI_RT_CTRL] = 0xffffffff;

0x1 (See below)

> +
> +    ARRAY_FIELD_DP32(reg_state, CXL_BI_RT_STATUS, COMMITTED, 0);
> +    ARRAY_FIELD_DP32(reg_state, CXL_BI_RT_STATUS, ERR_NOT_COMMITTED, 0);
> +    ARRAY_FIELD_DP32(reg_state, CXL_BI_RT_STATUS, COMMIT_TMO_SCALE, 0x6);
> +    ARRAY_FIELD_DP32(reg_state, CXL_BI_RT_STATUS, COMMIT_TMO_BASE, 0x2);
> +}
> +
> +static void bi_decoder_init_common(uint32_t *reg_state, uint32_t *write_msk)
> +{
> +    ARRAY_FIELD_DP32(reg_state, CXL_BI_DECODER_CAPABILITY, HDM_D, 0);
> +    /* switch dsp must commit the new BI-ID, timeout of 2secs */
> +    ARRAY_FIELD_DP32(reg_state, CXL_BI_DECODER_CAPABILITY, EXPLICIT_COMMIT, 1);

Reserved for EP and root ports. I think we need to pass type into this function
so we can set this to 0 for those types and 1 for others.

> +
> +    ARRAY_FIELD_DP32(reg_state, CXL_BI_DECODER_CTRL, BI_FW, 0);
> +    ARRAY_FIELD_DP32(reg_state, CXL_BI_DECODER_CTRL, BI_ENABLE, 0);
> +    ARRAY_FIELD_DP32(reg_state, CXL_BI_DECODER_CTRL, COMMIT, 0);
> +    write_msk[R_CXL_BI_DECODER_CTRL] = 0xffffffff;

IIRC should only have the non reserved bits in the write_msk.  So 0x7

> +
> +    ARRAY_FIELD_DP32(reg_state, CXL_BI_DECODER_STATUS, COMMITTED, 0);
> +    ARRAY_FIELD_DP32(reg_state, CXL_BI_DECODER_STATUS, ERR_NOT_COMMITTED, 0);
> +    ARRAY_FIELD_DP32(reg_state, CXL_BI_DECODER_STATUS, COMMIT_TMO_SCALE, 0x6);
> +    ARRAY_FIELD_DP32(reg_state, CXL_BI_DECODER_STATUS, COMMIT_TMO_BASE, 0x2);
> +}

> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index ecd3a7703b35..1e55d13c1e93 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -447,6 +447,7 @@ static void build_dvsecs(CXLType3Dev *ct3d)
>      CXLComponentState *cxl_cstate = &ct3d->cxl_cstate;
>      CXLDVSECRegisterLocator *regloc_dvsec;
>      uint8_t *dvsec;
> +    uint16_t type = ct3d->hdmdb ? CXL3_TYPE3_DEVICE : CXL2_TYPE3_DEVICE;

Using a type for this feels like something that won't scale as we add
more features. Perhaps stick to CXL2_TYPE3_DEVICE (perhaps renamed)
and a separate boolean.

>      uint32_t range1_size_hi = 0, range1_size_lo = 0,
>               range1_base_hi = 0, range1_base_lo = 0,
>               range2_size_hi = 0, range2_size_lo = 0,
> @@ -491,7 +492,7 @@ static void build_dvsecs(CXLType3Dev *ct3d)
>          .range2_base_hi = range2_base_hi,
>          .range2_base_lo = range2_base_lo,
>      };
> -    cxl_component_create_dvsec(cxl_cstate, CXL2_TYPE3_DEVICE,
> +    cxl_component_create_dvsec(cxl_cstate, type,
>                                 PCIE_CXL_DEVICE_DVSEC_LENGTH,
>                                 PCIE_CXL_DEVICE_DVSEC,
>                                 PCIE_CXL31_DEVICE_DVSEC_REVID, dvsec);
> @@ -521,14 +522,14 @@ static void build_dvsecs(CXLType3Dev *ct3d)
>          },
>      };
>  
> -    cxl_component_create_dvsec(cxl_cstate, CXL2_TYPE3_DEVICE,
> +    cxl_component_create_dvsec(cxl_cstate, type,
>                                 REG_LOC_DVSEC_LENGTH, REG_LOC_DVSEC,
>                                 REG_LOC_DVSEC_REVID, (uint8_t *)regloc_dvsec);
>      dvsec = (uint8_t *)&(CXLDVSECDeviceGPF){
>          .phase2_duration = 0x603, /* 3 seconds */
>          .phase2_power = 0x33, /* 0x33 miliwatts */
>      };
> -    cxl_component_create_dvsec(cxl_cstate, CXL2_TYPE3_DEVICE,
> +    cxl_component_create_dvsec(cxl_cstate, type,
>                                 GPF_DEVICE_DVSEC_LENGTH, GPF_DEVICE_DVSEC,
>                                 GPF_DEVICE_DVSEC_REVID, dvsec);
>  
> @@ -539,7 +540,7 @@ static void build_dvsecs(CXLType3Dev *ct3d)
>          .status                  = ct3d->flitmode ? 0x6 : 0x26, /* same */
>          .rcvd_mod_ts_data_phase1 = 0xef, /* WTF? */
>      };
> -    cxl_component_create_dvsec(cxl_cstate, CXL2_TYPE3_DEVICE,
> +    cxl_component_create_dvsec(cxl_cstate, type,
>                                 PCIE_CXL3_FLEXBUS_PORT_DVSEC_LENGTH,
>                                 PCIE_FLEXBUS_PORT_DVSEC,
>                                 PCIE_CXL3_FLEXBUS_PORT_DVSEC_REVID, dvsec);
> @@ -969,6 +970,11 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
>          return false;
>      }
>  
> +    if (!ct3d->flitmode && ct3d->hdmdb) {
> +        error_setg(errp, "hdm-db requires operating in 256b flit");
> +        return false;
> +    }
> +
>      if (ct3d->hostvmem) {
>          MemoryRegion *vmr;
>          char *v_name;
> diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
> index cd92cb02532a..acec76152ad0 100644
> --- a/include/hw/cxl/cxl_component.h
> +++ b/include/hw/cxl/cxl_component.h
> @@ -29,6 +29,7 @@ enum reg_type {
>      CXL2_UPSTREAM_PORT,
>      CXL2_DOWNSTREAM_PORT,
>      CXL3_SWITCH_MAILBOX_CCI,
> +    CXL3_TYPE3_DEVICE, /* hdm-db */

I'm wondering about this - whilst it's true that CXL3 allows
an hdm-db it also enabled a bunch of other things I don't think
we want to gate on this.  Could we just pass a separate parameter
for it?

>  };


> +/* to track BI explicit commit handling */
> +enum {
> +    CXL_BISTATE_RT = 0, /* switch usp */

Could spell out Route table somewhere. I couldn't remember what
RT was for.

> +    CXL_BISTATE_DECODER, /* switch dsp */

Also endpoints, root ports etc. 

> +    CXL_BISTATE_MAX
> +};
> +
> +typedef struct bi_state {
> +    /* last 0->1 transition */
> +    uint64_t last_commit;
> +} BIState;
> +
>  typedef struct component_registers {
>      /*
>       * Main memory region to be registered with QEMU core.
> @@ -260,6 +309,7 @@ typedef struct cxl_component {
>  
>      CDATObject cdat;
>      CXLCompObject compliance;
> +    BIState bi_state[CXL_BISTATE_MAX];
>  } CXLComponentState;
>  
>  void cxl_component_register_block_init(Object *obj,
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 0abfd678b875..75603b8180b5 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -841,6 +841,9 @@ struct CXLType3Dev {
>      CXLMemSparingReadAttrs rank_sparing_attrs;
>      CXLMemSparingWriteAttrs rank_sparing_wr_attrs;
>  
> +    /* BI flows */
> +    bool hdmdb;
> +
>      struct dynamic_capacity {
>          HostMemoryBackend *host_dc;
>          AddressSpace host_dc_as;

