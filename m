Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F69C7E576
	for <linux-cxl@vger.kernel.org>; Wed, 24 Jan 2024 16:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706115503; cv=none; b=O3V+PSCK/XrhJrLFA0jBwQgT1RcOhZjAPcfhwU3Lj06GwQOfX1Ox5T67NxegnwvwtKDgpANOeMOkR/M2T10lDbUDC/GBf0HXGWnxxFwe+PN3PWa6p3s0QLL1GbH1q/2XnalUhgfKbx3e9mmqNDOr3wt0BDV3Av0QURjtYfAg5ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706115503; c=relaxed/simple;
	bh=unF6iGryB/Zw/IktTiIQ88/87xyyVKjhrLZzf/bKQh8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uxJlzzoa9nU0prlCInFXX8lH88TpOJ2I1o06d5fgelcfOCzTuIKnc5u1lWTqHJXp4AFR4RnNe25w/Y2JCx8D8RSg8Y1DRKnKlcxRD2YvBnwFrJosqJrsSLKDCu48CgTrPvCnte8iCjB7WJPT0rzYoL9YJmI/0AlUmfUWISIZfNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TKqnw3CR7z6J9jy;
	Thu, 25 Jan 2024 00:55:16 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id D70131400D3;
	Thu, 25 Jan 2024 00:58:16 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Jan
 2024 16:58:16 +0000
Date: Wed, 24 Jan 2024 16:58:15 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>,
	<a.manzanares@samsung.com>, <dave@stgolabs.net>, <nmtadam.samsung@gmail.com>,
	<nifan@outlook.com>, <jim.harris@samsung.com>, "Fan Ni" <fan.ni@samsung.com>
Subject: Re: [PATCH v3 9/9] hw/mem/cxl_type3: Add dpa range validation for
 accesses to dc regions
Message-ID: <20240124165815.00007e46@Huawei.com>
In-Reply-To: <20231107180907.553451-10-nifan.cxl@gmail.com>
References: <20231107180907.553451-1-nifan.cxl@gmail.com>
	<20231107180907.553451-10-nifan.cxl@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue,  7 Nov 2023 10:07:13 -0800
nifan.cxl@gmail.com wrote:

> From: Fan Ni <fan.ni@samsung.com>
>=20
> Not all dpa range in the dc regions is valid to access until an extent
DPA ... DC etc

> covering the range has been added. Add a bitmap for each region to
> record whether a dc block in the region has been backed by dc extent.
> For the bitmap, a bit in the bitmap represents a dc block. When a dc
> extent is added, all the bits of the blocks in the extent will be set,
> which will be cleared when the extent is released.
>=20
> Signed-off-by: Fan Ni <fan.ni@samsung.com>

Hi Fan, one query inline and a few comments.

Jonathan

>=20
> --
> JC changes:
> - Rebase on what will be next gitlab.com/jic23/qemu CXL staging tree.
> - Drop unnecessary handling of failed bitmap allocations. In common with
>   most QEMU allocations they fail hard anyway.
> - Use previously factored out cxl_find_region() helper
> - Minor editorial stuff in comments such as spec version references
>   according to the standard form I'm trying to push through the code.
> Picked up J=F8rgen's fix:
> https://lore.kernel.org/qemu-devel/d0d7ca1d-81bc-19b3-4904-d60046ded844@w=
dc.com/T/#u
> ---
>  hw/cxl/cxl-mailbox-utils.c  | 31 +++++++++------
>  hw/mem/cxl_type3.c          | 78 +++++++++++++++++++++++++++++++++++++
>  include/hw/cxl/cxl_device.h | 15 +++++--
>  3 files changed, 109 insertions(+), 15 deletions(-)
>=20
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 8e6a98753a..6be92fb5ba 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -1401,10 +1401,9 @@ CXLDCDRegion *cxl_find_dc_region(CXLType3Dev *ct3d=
, uint64_t dpa, uint64_t len)
>  }
> =20
>  void cxl_insert_extent_to_extent_list(CXLDCDExtentList *list,
> -                                             uint64_t dpa,
> -                                             uint64_t len,
> -                                             uint8_t *tag,
> -                                             uint16_t shared_seq)
> +                                      uint64_t dpa, uint64_t len,
> +                                      uint8_t *tag,
> +                                      uint16_t shared_seq)

avoid noisy whitespace changes like this.


> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 43cea3d818..4ec65a751a 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c

> +/*
> + * Check whether a DPA range [dpa, dpa + len) has been backed with DC ex=
tents.
> + * Used when validating read/write to dc regions
> + */
> +bool ct3_test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
> +                                  uint64_t len)
> +{
> +    CXLDCDRegion *region;
> +    uint64_t nbits;
> +    long nr;
> +
> +    region =3D cxl_find_dc_region(ct3d, dpa, len);
> +    if (!region) {
> +        return false;
> +    }
> +
> +    nr =3D (dpa - region->base) / region->block_size;
> +    nbits =3D DIV_ROUND_UP(len, region->block_size);
> +    return find_next_zero_bit(region->blk_bitmap, nr + nbits, nr) =3D=3D=
 nr + nbits;
I'm not sure how this works... Is it taking a size or an end point?

Linux equivalent takes size, so I'd expect

    return find_next_zero_bit(region->blk_bitmap, nbits, nr);
Perhaps a comment would avoid any future confusion on this.

> +}
> +
> +/*
> + * Mark the DPA range [dpa, dap + len) to be unbacked and inaccessible. =
This
> + * happens when a dc extent is return by the host.
> + */
> +void ct3_clear_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
> +                                   uint64_t len)
> +{
> +    CXLDCDRegion *region;
> +    uint64_t nbits;
> +    long nr;
> +
> +    region =3D cxl_find_dc_region(ct3d, dpa, len);
> +    if (!region) {
> +        return;
> +    }
> +
> +    nr =3D (dpa - region->base) / region->block_size;
> +    nbits =3D len / region->block_size;
> +    bitmap_clear(region->blk_bitmap, nr, nbits);
> +}
> +

