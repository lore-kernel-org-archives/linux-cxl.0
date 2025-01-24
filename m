Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BC8136E09
	for <linux-cxl@vger.kernel.org>; Fri, 24 Jan 2025 15:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737731992; cv=none; b=rSqYB0R75qJLtSMOljM1Q0ylr6chMxm86odBzGfWz2jV8aPf0E3flZiSgah2vYYFcHQUyR58+Xtnc4pHbFEMNd9KCrSK5zt+zNBAS7PnZsOJ03bsXdGn3WjA5WLp6dnDYy9Z03/87T8DQJzd/5C4JdkM7dGR2jBi17qbTLqvbzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737731992; c=relaxed/simple;
	bh=vXR+eRMEbFt4hluFbIHMyshS/JOSNgO9TvOhLL4Z8h0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sgx3XdrvAf808ScoYu6diX/RG86F8v4WIAGYwj5T02aLjiFiCbzH7105C1MmDTi7SDiTVuYWA1awuyoCy/Wkfbg5VJAB02Nhyuyb/PRHmeef3Dre9uBV/rT/M5nhMJLPhQHH/3PUAw7osj/4zAGofTIdNwhEgTRFaf1eIz5Qq44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YfhJZ0LSnz6M4Kb;
	Fri, 24 Jan 2025 23:17:50 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id BDB7F140736;
	Fri, 24 Jan 2025 23:19:48 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 24 Jan
 2025 16:19:48 +0100
Date: Fri, 24 Jan 2025 15:19:46 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Vinayak Holikatti <vinayak.kh@samsung.com>
CC: <qemu-devel@nongnu.org>, <krish.reddy@samsung.com>,
	<vishak.g@samsung.com>, <a.manzanares@samsung.com>,
	<alok.rathore@samsung.com>, <s5.kumari@samsung.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/2] hw/cxl/cxl-mailbox-utils: Add support for Media
 operations Sanitize and Write Zeros commands (8.2.9.9.5.3)
Message-ID: <20250124151946.0000134f@huawei.com>
In-Reply-To: <20250123050903.92336-3-vinayak.kh@samsung.com>
References: <20250123050903.92336-1-vinayak.kh@samsung.com>
	<CGME20250123050913epcas5p45fb9a638e62f436076da283e86e54ea2@epcas5p4.samsung.com>
	<20250123050903.92336-3-vinayak.kh@samsung.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 23 Jan 2025 10:39:03 +0530
Vinayak Holikatti <vinayak.kh@samsung.com> wrote:

>     CXL spec 3.1 section 8.2.9.9.5.3 describes media operations commands.
>     CXL devices supports media operations Sanitize and Write zero command.

As before, don't indent this.

>=20
> Signed-off-by: Vinayak Holikatti <vinayak.kh@samsung.com>
> ---
>  hw/cxl/cxl-mailbox-utils.c  | 217 ++++++++++++++++++++++++++++++++++--
>  include/hw/cxl/cxl_device.h |  11 ++
>  2 files changed, 220 insertions(+), 8 deletions(-)
>=20
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 2315d07fb1..89847ddd9d 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -1722,6 +1722,145 @@ static CXLRetCode cmd_sanitize_overwrite(const st=
ruct cxl_cmd *cmd,
>      return CXL_MBOX_BG_STARTED;
>  }
> =20
> +#define DPA_RANGE_GRANULARITY 64

Could use existing CXL_CACHELINE_SIZE definition for this, though I guess
strictly speaking it could be unrelated.

> +struct dpa_range_list_entry {
> +    uint64_t starting_dpa;
> +    uint64_t length;
> +};
> +
> +static int validate_dpa_addr(CXLType3Dev *ct3d, uint64_t dpa_addr,
> +                             size_t length)
> +{
> +    MemoryRegion *vmr =3D NULL, *pmr =3D NULL, *dc_mr =3D NULL;
> +    uint64_t vmr_size =3D 0, pmr_size =3D 0, dc_size =3D 0;
> +    int rc =3D 0;
> +
> +    if ((dpa_addr % DPA_RANGE_GRANULARITY) ||
> +         (length % DPA_RANGE_GRANULARITY)) {
Probably makes sense to also check for length 0 here as that would
be very odd if sent.
> +        return -EINVAL;
> +    }
> +
> +    if (ct3d->hostvmem) {
> +        vmr =3D host_memory_backend_get_memory(ct3d->hostvmem);
> +        vmr_size =3D memory_region_size(vmr);
> +    }
> +    if (ct3d->hostpmem) {
> +        pmr =3D host_memory_backend_get_memory(ct3d->hostpmem);
> +        pmr_size =3D memory_region_size(pmr);
> +    }
> +    if (ct3d->dc.host_dc) {
> +        dc_mr =3D host_memory_backend_get_memory(ct3d->dc.host_dc);
> +        dc_size =3D memory_region_size(dc_mr);
> +    }
> +
> +    if (!vmr && !pmr && !dc_mr) {
> +        return -ENODEV;
> +    }
> +
> +    if (dpa_addr >=3D vmr_size + pmr_size + dc_size ||
> +        (dpa_addr + length) > vmr_size + pmr_size + dc_size) {

If length is checked as non zero above, only the second test is needed.

> +        return -EINVAL;
> +    }
> +
> +    if (dpa_addr > vmr_size + pmr_size) {
> +        if (!ct3_test_region_block_backed(ct3d, dpa_addr, length)) {
> +            return -ENODEV;
> +        }
> +    }
> +
> +
> +    return rc;

return 0. rc is never set to anything else.

> +}
> +
> +static int sanitize_range(CXLType3Dev *ct3d, uint64_t dpa_addr, size_t l=
ength,
> +                          uint8_t fill_value)
> +{
> +
> +    MemoryRegion *vmr =3D NULL, *pmr =3D NULL;
> +    uint64_t vmr_size =3D 0, pmr_size =3D 0;
> +    AddressSpace *as =3D NULL;
> +    MemTxAttrs mem_attrs =3D {0};
> +
> +    if (ct3d->hostvmem) {
> +        vmr =3D host_memory_backend_get_memory(ct3d->hostvmem);
> +        vmr_size =3D memory_region_size(vmr);
> +    }
> +    if (ct3d->hostpmem) {
> +        pmr =3D host_memory_backend_get_memory(ct3d->hostpmem);
> +        pmr_size =3D memory_region_size(pmr);
> +    }
> +
> +    if (dpa_addr < vmr_size) {
> +        as =3D &ct3d->hostvmem_as;
> +    } else if (dpa_addr < vmr_size + pmr_size) {
> +        as =3D &ct3d->hostpmem_as;
> +    } else {
> +        if (!ct3_test_region_block_backed(ct3d, dpa_addr, length)) {
> +            return -ENODEV;
> +        }
> +        as =3D &ct3d->dc.host_dc_as;
> +    }

You could factor out everything down to here and then use that
for the validate_dpa_addr() as finding an address space means
we also checked the address is valid. Otherwise it does not match.

> +
> +    return  address_space_set(as, dpa_addr,

odd spacing after return. Should just be one space.

> +                              fill_value, length, mem_attrs);
> +}
> +
> +/* Perform the actual device zeroing */
> +static void __do_sanitize(CXLType3Dev *ct3d)
> +{
> +    struct CXLSanitizeInfo  *san_info =3D ct3d->media_op_sanitize;

Single space only before *san_info

> +    int dpa_range_count =3D san_info->dpa_range_count;
> +    int rc =3D 0;
> +
> +    for (int i =3D 0; i < dpa_range_count; i++) {
> +        rc =3D sanitize_range(ct3d, san_info->dpa_range_list[i].starting=
_dpa,
> +                san_info->dpa_range_list[i].length, san_info->fill_value=
);
> +        if (rc) {
> +            goto exit;
> +        }
> +    }
> +    cxl_discard_all_event_records(&ct3d->cxl_dstate);

Add a comment on why we are deleting event records when sanitizing a small
part of memory?

> +exit:
> +    g_free(ct3d->media_op_sanitize);
> +    ct3d->media_op_sanitize =3D NULL;
> +    return;
> +}
> +
> +static int get_sanitize_duration(uint64_t total_mem)

Where did this come from?  Factor out the existing code
in cmd_santize_overwrite() instead of duplicating this stack
of if/else if

Ideally do that as a precursor patch as it's just code movement.


> +{
> +    int secs =3D 0;
> +
> +    if (total_mem <=3D 512) {
> +        secs =3D 4;
> +    } else if (total_mem <=3D 1024) {
> +        secs =3D 8;
> +    } else if (total_mem <=3D 2 * 1024) {
> +        secs =3D 15;
> +    } else if (total_mem <=3D 4 * 1024) {
> +        secs =3D 30;
> +    } else if (total_mem <=3D 8 * 1024) {
> +        secs =3D 60;
> +    } else if (total_mem <=3D 16 * 1024) {
> +        secs =3D 2 * 60;
> +    } else if (total_mem <=3D 32 * 1024) {
> +        secs =3D 4 * 60;
> +    } else if (total_mem <=3D 64 * 1024) {
> +        secs =3D 8 * 60;
> +    } else if (total_mem <=3D 128 * 1024) {
> +        secs =3D 15 * 60;
> +    } else if (total_mem <=3D 256 * 1024) {
> +        secs =3D 30 * 60;
> +    } else if (total_mem <=3D 512 * 1024) {
> +        secs =3D 60 * 60;
> +    } else if (total_mem <=3D 1024 * 1024) {
> +        secs =3D 120 * 60;
> +    } else {
> +        secs =3D 240 * 60; /* max 4 hrs */
> +    }
> +
> +    return secs;
> +}
> +
>  enum {
>      MEDIA_OP_GENERAL  =3D 0x0,
>      MEDIA_OP_SANITIZE =3D 0x1,
> @@ -1729,10 +1868,9 @@ enum {
>  } MEDIA_OPERATION_CLASS;
> =20
>  enum {
> -    MEDIA_OP_SUB_DISCOVERY =3D 0x0,
> -    MEDIA_OP_SUB_SANITIZE =3D 0x0,
> -    MEDIA_OP_SUB_ZERO     =3D 0x1,
> -    MEDIA_OP_SUB_CLASS_MAX
> +    MEDIA_OP_GEN_DISCOVERY =3D 0x0,
> +    MEDIA_OP_SAN_SANITIZE =3D 0x0,
> +    MEDIA_OP_SAN_ZERO     =3D 0x1,

See naming suggestions in first patch. Make sure to tidy up so you don't in=
troduce
them there then change them here!

>  } MEDIA_OPERATION_SUB_CLASS;
> =20
>  struct media_op_supported_list_entry {
> @@ -1777,9 +1915,14 @@ static CXLRetCode cmd_media_operations(const struc=
t cxl_cmd *cmd,
>      };
>      } QEMU_PACKED *media_op_in_pl =3D (void *)payload_in;
> =20
> +

Blank line here doesn't add anything.

> +    CXLType3Dev *ct3d =3D CXL_TYPE3(cci->d);
>      uint8_t media_op_cl =3D media_op_in_pl->media_operation_class;
>      uint8_t media_op_subclass =3D media_op_in_pl->media_operation_subcla=
ss;
>      uint32_t dpa_range_count =3D media_op_in_pl->dpa_range_count;
> +    uint8_t fill_value =3D 0;
> +    uint64_t total_mem =3D 0;
> +    int secs =3D 0;
> =20
>      if (len_in < sizeof(*media_op_in_pl)) {
>          return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
> @@ -1788,7 +1931,7 @@ static CXLRetCode cmd_media_operations(const struct=
 cxl_cmd *cmd,
>      switch (media_op_cl) {
>      case MEDIA_OP_GENERAL:
>          switch (media_op_subclass) {
> -        case MEDIA_OP_SUB_DISCOVERY:
> +        case MEDIA_OP_GEN_DISCOVERY:
>              int count =3D 0;
>              struct media_op_discovery_out_pl *media_out_pl =3D
>                  (void *)payload_out;
> @@ -1806,7 +1949,7 @@ static CXLRetCode cmd_media_operations(const struct=
 cxl_cmd *cmd,
>                  return CXL_MBOX_INVALID_INPUT;
>              }
> =20
> -            media_out_pl->dpa_range_granularity =3D CXL_CAPACITY_MULTIPL=
IER;
> +            media_out_pl->dpa_range_granularity =3D DPA_RANGE_GRANULARIT=
Y;
>              media_out_pl->total_supported_operations =3D MAX_SUPPORTED_O=
PS;
>              if (num_ops > 0) {
>                  for (int i =3D start_index; i < MAX_SUPPORTED_OPS; i++) {
> @@ -1824,22 +1967,73 @@ disc_out:
>              media_out_pl->num_of_supported_operations =3D count;
>              *len_out =3D sizeof(struct media_op_discovery_out_pl) +
>              (sizeof(struct media_op_supported_list_entry) * count);
> -            break;
> +            goto exit;
return CXL_MBOX_SUCCESS;  No purpose in having the exit label as nothing
to be done.


>          default:
>              return CXL_MBOX_UNSUPPORTED;
>          }
>          break;
>      case MEDIA_OP_SANITIZE:
> +    {

=46rom code here not obvious why scoping {} needed.

>          switch (media_op_subclass) {
> -
> +        case MEDIA_OP_SAN_SANITIZE:
> +            if (len_in < (sizeof(*media_op_in_pl) +
> +                   (dpa_range_count * sizeof(struct dpa_range_list_entry=
)))) {
> +                return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
> +            }
The check applies to all current cases. So move it outside this switch stat=
ement
to remove duplication.  Here all you should do is set the fill_value;

> +            fill_value =3D 0xF;
> +            goto sanitize_range;
> +        case MEDIA_OP_SAN_ZERO:
> +            if (len_in < (sizeof(*media_op_in_pl) +
> +                (dpa_range_count * sizeof(struct dpa_range_list_entry)))=
) {
> +                return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
> +            }
> +            fill_value =3D 0;
> +            goto sanitize_range;
Why goto. Just break...
>          default:
>              return CXL_MBOX_UNSUPPORTED;
>          }
and have the stuff below under the sanitize_range label here.

>          break;
> +    }
>      default:
>          return CXL_MBOX_UNSUPPORTED;
>      }
> =20
> +sanitize_range:
> +    if (dpa_range_count > 0) {
> +        for (int i =3D 0; i < dpa_range_count; i++) {
> +            if (validate_dpa_addr(ct3d,
> +                media_op_in_pl->dpa_range_list[i].starting_dpa,
> +                media_op_in_pl->dpa_range_list[i].length)) {
> +                return CXL_MBOX_INVALID_INPUT;
> +            }
> +            total_mem +=3D media_op_in_pl->dpa_range_list[i].length;
> +        }
> +        ct3d->media_op_sanitize =3D g_malloc0(sizeof(struct CXLSanitizeI=
nfo) +
> +                                  (dpa_range_count *
> +                                  sizeof(struct dpa_range_list_entry)));
> +
> +        if (ct3d->media_op_sanitize) {
> +            ct3d->media_op_sanitize->dpa_range_count =3D dpa_range_count;
> +            ct3d->media_op_sanitize->fill_value =3D fill_value;
> +            memcpy(ct3d->media_op_sanitize->dpa_range_list,
> +                   media_op_in_pl->dpa_range_list,
> +                   (dpa_range_count *
> +                   sizeof(struct dpa_range_list_entry)));
> +            secs =3D get_sanitize_duration(total_mem >> 20);
> +            goto start_bg;
> +        }
> +    } else if (dpa_range_count =3D=3D 0) {
> +        goto exit;
    if (dpa_range_count =3D=3D 0) {
       return CXL_MBOX_SUCCESS;
    }
    for (i =3D 0; i < dpa_range_count; i++)

//that is return early in the simple case the no need for else
and the extra level of indent on these long lines.


> +    }
> +
> +start_bg:
> +    /* EBUSY other bg cmds as of now */
> +    cci->bg.runtime =3D secs * 1000UL;
> +    *len_out =3D 0;
> +    /* sanitize when done */
> +    cxl_dev_disable_media(&ct3d->cxl_dstate);
Why?  This is santizing part of the device. As I undestand it the
main aim is to offload cleanup when the device is in use. Definitely
don't want to disable media.  If I'm missing a reason please give
a spec reference.

> +    return CXL_MBOX_BG_STARTED;
> +exit:
>      return CXL_MBOX_SUCCESS;
>  }
> =20
> @@ -3154,6 +3348,13 @@ static void bg_timercb(void *opaque)
>              cxl_dev_enable_media(&ct3d->cxl_dstate);
>          }
>          break;
> +        case 0x4402: /* Media Operations sanitize */
> +        {
> +            CXLType3Dev *ct3d =3D CXL_TYPE3(cci->d);
> +            __do_sanitize(ct3d);
> +            cxl_dev_enable_media(&ct3d->cxl_dstate);
Ah. You turn it back on here.   Specification reference needed.
> +        }
> +        break;
>          case 0x4304: /* scan media */
>          {
>              CXLType3Dev *ct3d =3D CXL_TYPE3(cci->d);
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index a64739be25..6d82eb266a 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -581,6 +581,15 @@ typedef struct CXLSetFeatureInfo {
>      size_t data_size;
>  } CXLSetFeatureInfo;
> =20
> +struct CXLSanitizeInfo {
> +    uint32_t dpa_range_count;
> +    uint8_t fill_value;
> +    struct {
> +            uint64_t starting_dpa;
> +            uint64_t length;
> +    } dpa_range_list[0];
[]
> +};
> +
>  struct CXLType3Dev {
>      /* Private */
>      PCIDevice parent_obj;
> @@ -651,6 +660,8 @@ struct CXLType3Dev {
>          uint8_t num_regions; /* 0-8 regions */
>          CXLDCRegion regions[DCD_MAX_NUM_REGION];
>      } dc;
> +
> +    struct CXLSanitizeInfo  *media_op_sanitize;
Here we just need to know there is a definition of struct
CXLSantizeInfo not what form it takes.  So use a forwards
defintion and push the definition of struct CXLSanitizeInfo
down to where it is needed only (in the c file).

Thanks,

Jonathan

>  };
> =20
>  #define TYPE_CXL_TYPE3 "cxl-type3"

