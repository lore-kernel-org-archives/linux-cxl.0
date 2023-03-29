Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B09AC6FD18
	for <linux-cxl@archiver.kernel.org>; Wed, 29 Mar 2023 18:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjC2SLG (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 29 Mar 2023 14:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjC2SLF (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 29 Mar 2023 14:11:05 -0400
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8F365A8
        for <linux-cxl@vger.kernel.org>; Wed, 29 Mar 2023 11:10:28 -0700 (PDT)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20230329180937usoutp010a55891964f9f639db865745557bf894~Q9jcdWcJa2924429244usoutp01T;
        Wed, 29 Mar 2023 18:09:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20230329180937usoutp010a55891964f9f639db865745557bf894~Q9jcdWcJa2924429244usoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1680113377;
        bh=TAlB8I5j2NwCmhKxrFGYQ6sJBYmxQB1/G9ZqLXYFyhU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=c2NwO1NUa6osD8qZAxqlo0VH4lcwL+rufNJY3fwXIvCG3bnmAgOnFvZe0vGnsul5p
         9W9LgthCJFf+l74Az+xFQaykuQKF/3U5oHy757ahojO25o2bsQDX+JY1jY7GhmGix5
         6J2viuWtrD5qFnhxsO3APi69HhOcV76jxZw3dN3s=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
        [203.254.195.109]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230329180937uscas1p185a0a799b23bf0b99227e0e575902784~Q9jcVy4LA0427504275uscas1p1D;
        Wed, 29 Mar 2023 18:09:37 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges1new.samsung.com (USCPEMTA) with SMTP id B1.57.09634.1EE74246; Wed,
        29 Mar 2023 14:09:37 -0400 (EDT)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
        [203.254.195.92]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230329180937uscas1p2aee5d0c49e66d2de6e5dbd884acb5705~Q9jcF8FqB0719307193uscas1p2B;
        Wed, 29 Mar 2023 18:09:37 +0000 (GMT)
X-AuditID: cbfec36d-9b3ff700000025a2-48-64247ee12d2c
Received: from SSI-EX1.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id 16.4D.09515.0EE74246; Wed,
        29 Mar 2023 14:09:36 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX1.ssi.samsung.com (105.128.2.226) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Wed, 29 Mar 2023 11:09:36 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Wed,
        29 Mar 2023 11:09:36 -0700
From:   Fan Ni <fan.ni@samsung.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "alison.schofield@intel.com" <alison.schofield@intel.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] cxl/region: Move coherence tracking into
 cxl_region_attach()
Thread-Topic: [PATCH] cxl/region: Move coherence tracking into
        cxl_region_attach()
Thread-Index: AQHZYmmeSQHUPAgPT0aTdI++pCKksg==
Date:   Wed, 29 Mar 2023 18:09:36 +0000
Message-ID: <20230329180929.GA1683747@bgt-140510-bm03>
In-Reply-To: <168002858817.50647.1217607907088920888.stgit@dwillia2-xfh.jf.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <50080D4AA41B674991570016DB173B60@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEKsWRmVeSWpSXmKPExsWy7djXc7oP61RSDG62iFncfXyBzWL61AuM
        FiduNrJZ7H/6nMVi1cJrbBbnZ51isbg14RiTA7tHy5G3rB6L97xk8vi8SS6AOYrLJiU1J7Ms
        tUjfLoEro/H3etaCBr6KX4vOsDUwHuLuYuTkkBAwkXh95QR7FyMXh5DASkaJVW1/GSGcViaJ
        mVfessJUnbizkQkisRaoqnsLC4TziVHi3talUP3LGCUWff/DAtLCJqAosa9rOxuILSKgLTFx
        zkFmkCJmgXNMEvN/X2UGSQgLBEt8mfiJFaIoROLhv83MELaexOnNU8BsFgFViU3X7gLZHBy8
        AmYSP/6HgYQ5BUIl9p54AlbCKCAm8f3UGiYQm1lAXOLWk/lMEGcLSiyavYcZwhaT+LfrIRuE
        rShx//tLdoh6HYkFuz+xQdh2Ej1fDkLFtSWWLXwN1ssLNOfkzCcsEL2SEgdX3AD7XkLgDIfE
        p8Z3UAtcJF79uAgNL2mJ6Wsus4DcLCGQLLHqIxdEOEdi/pItUHOsJRb+Wc80gVFlFpKzZyE5
        aRaSk2YhOWkWkpMWMLKuYhQvLS7OTU8tNsxLLdcrTswtLs1L10vOz93ECExGp/8dzt3BuOPW
        R71DjEwcjIcYJTiYlUR4f19TShHiTUmsrEotyo8vKs1JLT7EKM3BoiTOa2h7MllIID2xJDU7
        NbUgtQgmy8TBKdXApL7/zp9NuXqSbMxBTPrbqlSnTlQQfu8+cfX5hYVprjd+3o50Ozrjue1W
        wXt+opsOOi5UP3jX9N2VE2V1Ab+XO4Qoud9mUJrq0JxS0csTuGTxqn971KbF37jLv6nOuFn2
        sUrhsgK1o7Hbt1m+t7+11fPDFPmuvNIVJ7t9PXTcl3QUvzA6qqdY4/Kc26l9/wzOTQ5zMpYF
        qiYf5tryNNrhvvyfluK1bzZdM8/zE+v9/dto1izDTcc2nWj55i3uMDnUrGKqxLdrUT8f5P7a
        uu/I3wsZdbO9tsSL2a4s5K6xUlJyiDVnUJXcMz3rm037xlc1s02iFjhE2MVvYrHeFXPx69/V
        Usv/JURNunj66NWUBUosxRmJhlrMRcWJAEjKRzC1AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPIsWRmVeSWpSXmKPExsWS2cA0UfdhnUqKwQIxi7uPL7BZTJ96gdHi
        xM1GNov9T5+zWKxaeI3N4vysUywWtyYcY3Jg92g58pbVY/Gel0wenzfJBTBHcdmkpOZklqUW
        6dslcGU0/l7PWtDAV/Fr0Rm2BsZD3F2MnBwSAiYSJ+5sZOpi5OIQEljNKLFrwRZ2COcTo0TH
        rElQzjJGie+3bjGCtLAJKErs69rOBmKLCGhLTJxzkBmkiFngHJPE/N9XmUESwgLBEl8mfmKF
        KAqRmLN4NROErSdxevMUsBoWAVWJTdfuAtkcHLwCZhI//oeBhIWAyg/e/gNWzikQKrH3xBOw
        ckYBMYnvp9aAxZkFxCVuPZnPBPGCgMSSPeeZIWxRiZeP/7FC2IoS97+/ZIeo15FYsPsTG4Rt
        J9Hz5SBUXFti2cLXYL28AoISJ2c+YYHolZQ4uOIGywRGiVlI1s1CMmoWklGzkIyahWTUAkbW
        VYzipcXFuekVxcZ5qeV6xYm5xaV56XrJ+bmbGIFxfPrf4ZgdjPdufdQ7xMjEwXiIUYKDWUmE
        9/c1pRQh3pTEyqrUovz4otKc1OJDjNIcLErivB6xE+OFBNITS1KzU1MLUotgskwcnFINTFou
        pz8+Z0zZdpuDKZIzb92WC881fbbaHuq70mF2711w6M1VLJuqEieuU3lt/on55uc64QmdM4y4
        Lr79fOX1UmZOv4rASp5AX938dJHMy1fuPTS+u6Ho/L64MiOxx/EbhC07LoW5lE3TEbqxeftn
        dVZLOaV+E6M3RxbfnKKac/2mNPMP4bdz5ILqVK9evGCf9NZ5qr6Y9dSJ8+pj+nvMDyq6b9fe
        P7f7+qz2fF7N54nSwV/UVLJmvPkdezjw+/OsvXmy3qx7hR/aSF1pfH9izRpv5yKV+YEWK6af
        dnfY6/y1qfzRJ3XN1YtNN0xVeNacvZjx6bW8DoEvf7u/P+wWqp/7cV1Nw9o5Z4zevJi1bLYS
        S3FGoqEWc1FxIgArUS/sUgMAAA==
X-CMS-MailID: 20230329180937uscas1p2aee5d0c49e66d2de6e5dbd884acb5705
CMS-TYPE: 301P
X-CMS-RootMailID: 20230329180937uscas1p2aee5d0c49e66d2de6e5dbd884acb5705
References: <168002858817.50647.1217607907088920888.stgit@dwillia2-xfh.jf.intel.com>
        <CGME20230329180937uscas1p2aee5d0c49e66d2de6e5dbd884acb5705@uscas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Mar 28, 2023 at 11:36:28AM -0700, Dan Williams wrote:
> Each time the contents of a given HPA are potentially changed in a cache
> incoherent manner the CXL core sets CXL_REGION_F_INCOHERENT to
> invalidate CPU caches before the region is used.
>=20
> Successful invocation of attach_target() indicates that DPA has been
> newly assigned to a given HPA in the dynamic region creation flow.
> However, attach_target() is also reused in the autodiscovery flow where
> the region was activated by platform firmware. In that case there is no
> need to invalidate caches because that region is already in active use
> and nothing about the autodiscovery flow modifies the HPA-to-DPA
> relationship.
>=20
> Fixes: a32320b71f08 ("cxl/region: Add region autodiscovery")
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  drivers/cxl/core/region.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 52bbf6268d5f..b2fd67fcebfb 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1674,6 +1674,7 @@ static int cxl_region_attach(struct cxl_region *cxl=
r,
>  		if (rc)
>  			goto err_decrement;
>  		p->state =3D CXL_CONFIG_ACTIVE;
> +		set_bit(CXL_REGION_F_INCOHERENT, &cxlr->flags);
>  	}
> =20
>  	cxled->cxld.interleave_ways =3D p->interleave_ways;
> @@ -1775,8 +1776,6 @@ static int attach_target(struct cxl_region *cxlr,
> =20
>  	down_read(&cxl_dpa_rwsem);
>  	rc =3D cxl_region_attach(cxlr, cxled, pos);
> -	if (rc =3D=3D 0)
> -		set_bit(CXL_REGION_F_INCOHERENT, &cxlr->flags);
>  	up_read(&cxl_dpa_rwsem);
>  	up_write(&cxl_region_rwsem);
>  	return rc;
>=20
> =
