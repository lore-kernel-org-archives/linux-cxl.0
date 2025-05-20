Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D764124169B
	for <linux-cxl@vger.kernel.org>; Tue, 20 May 2025 13:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747747760; cv=none; b=ZGqe6Y7fltnUJqAiGaO/cCZcVm6Pmdyrx5XKfJldHvTmglL4Pe4Dftz1weD+h245defpH4sxwgVSJgHG7RExHbxy2julyxbUBrsXYILhctjgy+1pmwyZEGnPzIzOjsa2vu6XvV7JW6M6Bp/IpJsGESkC0XogI4uyghFSfdOTio8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747747760; c=relaxed/simple;
	bh=j089AoWkb5NJ6XTAL9o3XDJglwwgp6c0AjpXOn0x+Wo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uj4rEQp0JVpm8aPErzWg1lEIUNswF23NrQOVZZGEhbs20NGpOwMr+H+2Ux0Xoh48a/XQFGuJg62wk1udIHZJH8OCEAjlZ3rizaRT/PASpKCQ6Sn7toPUrZE1ilCTSDemu/moztplCrMzRR5Rz1GlUEwBJtmve8FAqfbqCQnCTIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b1wNl4r29z6L4sk;
	Tue, 20 May 2025 21:28:23 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id EF1B61402F7;
	Tue, 20 May 2025 21:29:13 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 20 May
 2025 15:29:13 +0200
Date: Tue, 20 May 2025 14:29:11 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <anisa.su887@gmail.com>
CC: <qemu-devel@nongnu.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
	<linux-cxl@vger.kernel.org>, Anisa Su <anisa.su@samsung.com>
Subject: Re: [PATCH v2 07/10] cxl-mailbox-utils: 0x5602 - FMAPI Set DC
 Region Config
Message-ID: <20250520142911.00002ece@huawei.com>
In-Reply-To: <20250508001754.122180-8-anisa.su887@gmail.com>
References: <20250508001754.122180-1-anisa.su887@gmail.com>
	<20250508001754.122180-8-anisa.su887@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu,  8 May 2025 00:01:03 +0000
anisa.su887@gmail.com wrote:

> From: Anisa Su <anisa.su@samsung.com>
>=20
> FM DCD Management command 0x5602 implemented per CXL r3.2 Spec Section 7.=
6.7.6.3
>=20
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
Hi Anisa

A few really trivial things inline.

Jonathan

> ---
>  hw/cxl/cxl-mailbox-utils.c   | 97 ++++++++++++++++++++++++++++++++++++
>  hw/mem/cxl_type3.c           |  2 +-
>  include/hw/cxl/cxl_device.h  |  3 ++
>  include/hw/cxl/cxl_mailbox.h |  6 +++
>  include/hw/cxl/cxl_opcodes.h |  1 +
>  5 files changed, 108 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 6afc45833d..fe38a13f71 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -3426,6 +3426,96 @@ static CXLRetCode cmd_fm_get_host_dc_region_config=
(const struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
> =20
> +static void cxl_mbox_dc_event_create_record_hdr(CXLType3Dev *ct3d,
> +                                                CXLEventRecordHdr *hdr)
> +{
> +    /*
> +     * CXL r3.1 section 8.2.9.2.1.6: Dynamic Capacity Event Record
Completely trivial but for new code we try to reference
the latest released spec (as only one that is downloadable
from a click through on the consortium website.)

I'll have another go on next release at persuading them to leave
the links to older spec versions (so far no luck!)

Anyhow, it's r3.2 section 8.2.10.2.1.6: Dynamic Capacity Event Record

If nothing else comes up I'll change that whilst adding it to my
staging tree.

I'm not sure I'll post one of those though until the tcg bug is
fixed.

Looks like you updated all the others already.

> +     *
> +     * All Dynamic Capacity event records shall set the Event Record Sev=
erity
> +     * field in the Common Event Record Format to Informational Event. A=
ll
> +     * Dynamic Capacity related events shall be logged in the Dynamic Ca=
pacity
> +     * Event Log.
> +     */
> +    uint8_t flags =3D 1 << CXL_EVENT_TYPE_INFO;
> +
> +    st24_le_p(&hdr->flags, flags);
> +    hdr->length =3D sizeof(struct CXLEventDynamicCapacity);
> +    memcpy(&hdr->id, &dynamic_capacity_uuid, sizeof(hdr->id));
> +    stq_le_p(&hdr->timestamp, cxl_device_get_timestamp(&ct3d->cxl_dstate=
));
> +}
> +
> +/* CXL r3.2 section 7.6.7.6.3: Set Host DC Region Configuration (Opcode =
5602) */
> +static CXLRetCode cmd_fm_set_dc_region_config(const struct cxl_cmd *cmd,
> +                                              uint8_t *payload_in,
> +                                              size_t len_in,
> +                                              uint8_t *payload_out,
> +                                              size_t *len_out,
> +                                              CXLCCI *cci)
> +{
> +    struct {
> +        uint8_t reg_id;
> +        uint8_t rsvd[3];
> +        uint64_t block_sz;
> +        uint8_t flags;
> +        uint8_t rsvd2[3];
> +    } QEMU_PACKED *in =3D (void *)payload_in;
> +    CXLType3Dev *ct3d =3D CXL_TYPE3(cci->d);
> +    CXLEventDynamicCapacity dcEvent =3D {};
> +    CXLDCRegion *region;
> +
> +    region =3D &ct3d->dc.regions[in->reg_id];

Trivial but we could roll that in to the declaration as its a simple
look up that can't fail.

> +
> +    /*
> +     * CXL r3.2 7.6.7.6.3: Set DC Region Configuration
> +     * This command shall fail with Unsupported when the Sanitize on Rel=
ease
> +     * field does not match the region=E2=80=99s configuration... and th=
e device
> +     * does not support reconfiguration of the Sanitize on Release setti=
ng.
> +     *
> +     * Currently not reconfigurable, so always fail if sanitize bit
> +     * doesn't match.
> +     */
> +    if ((in->flags & 0x1) !=3D (region->flags & 0x1)) {

We should have a define for that 0x1 probably.

> +        return CXL_MBOX_UNSUPPORTED;
> +    }
> +
> +    if (in->reg_id >=3D DCD_MAX_NUM_REGION) {
> +        return CXL_MBOX_UNSUPPORTED;
> +    }
> +
> +    /* Check that no extents are in the region being reconfigured */
> +    if (!bitmap_empty(region->blk_bitmap, region->len / region->block_si=
ze)) {
> +        return CXL_MBOX_UNSUPPORTED;
> +    }
> +
> +    /* Check that new block size is supported */
> +    if (!test_bit(BIT((int) log2(in->block_sz)),
> +                  &region->supported_blk_size_bitmask)) {
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +
> +    /* Free bitmap and create new one for new block size. */
> +    qemu_mutex_lock(&region->bitmap_lock);
> +    g_free(region->blk_bitmap);
> +    region->blk_bitmap =3D bitmap_new(region->len / in->block_sz);
> +    qemu_mutex_unlock(&region->bitmap_lock);
> +    region->block_size =3D in->block_sz;
> +
> +    /* Create event record and insert into event log */
> +    cxl_mbox_dc_event_create_record_hdr(ct3d, &dcEvent.hdr);
> +    dcEvent.type =3D DC_EVENT_REGION_CONFIG_UPDATED;
> +    dcEvent.validity_flags =3D 1;
> +    dcEvent.host_id =3D 0;
> +    dcEvent.updated_region_id =3D in->reg_id;
> +
> +    if (cxl_event_insert(&ct3d->cxl_dstate,
> +                         CXL_EVENT_TYPE_DYNAMIC_CAP,
> +                         (CXLEventRecordRaw *)&dcEvent)) {
> +        cxl_event_irq_assert(ct3d);
> +    }
> +    return CXL_MBOX_SUCCESS;
> +}
