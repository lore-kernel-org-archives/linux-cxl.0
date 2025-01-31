Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC5F154420
	for <linux-cxl@vger.kernel.org>; Fri, 31 Jan 2025 20:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.189.100.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738357159; cv=none; b=A/gttn8CWI6CVwrAEwPJkKjERQ2VHe0QDeglDZoum0xzWT9esIC+xUJFkJbRWou2fSrbVDnrVmMFcDuVmjcK4AgeMmhdqUJjFxxdcNQcbzJ7GmvuNwrPx0nMn4+bbBXFOPIPZyqJDef+EQ2IFwRwA1pbM1Bxy+nLW7FkHXvTEmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738357159; c=relaxed/simple;
	bh=hBlUv5JkNUXoCtMPtcn7RkXX0nGZrartyYJwTBJjwFM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version:References; b=Jdu5ehWjKjZ566BBhmPwLmHdW42V2UCrV36uCCKJoNcdlSIfAuSDb/As0qoHwkp3jcYfbFfTk02q/N7t8hdvoaLiKMMGg5h3C0OwahzNyO+b+8gqb6xe+149NVd85Jx7eGiBj1wDolLPGT6fGdZMyJwD9u0fTAl+REHaXpcE474=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=t7GS5NfJ; arc=none smtp.client-ip=211.189.100.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="t7GS5NfJ"
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
	by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20250131204829usoutp014b58434d3884b8bb7c53a0059a090342~f4gj5H1sg3065430654usoutp01I;
	Fri, 31 Jan 2025 20:48:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20250131204829usoutp014b58434d3884b8bb7c53a0059a090342~f4gj5H1sg3065430654usoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1738356509;
	bh=dn7AOiMrkvNFM8GcWtlfX244WruKGylU+ySg/8RP0As=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=t7GS5NfJeAEqeDNFy8xFK3kbOyJo3tG2Ec1MM5So5hCt0i5xGPX7yAqK3hoiVprS8
	 W6KiPrHWCOmXceviTITsIV70ATFElfDNA9/unKX3nUUYnnEDXbTfp+oiAM2EF2qsd7
	 OXuWkoMOxIrb/iSfG/afOq7r2DWo3X5i+7CeJf4Q=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
	[203.254.195.112]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
	20250131204829uscas1p2668fbb862b969d8174b239270e8b33e2~f4gjscg9e0635406354uscas1p29;
	Fri, 31 Jan 2025 20:48:29 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
	ussmges3new.samsung.com (USCPEMTA) with SMTP id C2.9A.10853.C173D976; Fri,
	31 Jan 2025 15:48:28 -0500 (EST)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
	[203.254.195.92]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
	20250131204828uscas1p283110e0caa90588d2caffa1067a944b0~f4gjL5P7A1415014150uscas1p2L;
	Fri, 31 Jan 2025 20:48:28 +0000 (GMT)
X-AuditID: cbfec370-4b7ff70000002a65-76-679d371cd42e
Received: from SSI-EX4.ssi.samsung.com ( [105.128.3.66]) by
	ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id 82.22.23624.C173D976; Fri,
	31 Jan 2025 15:48:28 -0500 (EST)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
	SSI-EX4.ssi.samsung.com (105.128.2.229) with Microsoft SMTP Server
	(version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
	15.1.2507.44; Fri, 31 Jan 2025 12:48:27 -0800
Received: from SSI-EX3.ssi.samsung.com ([105.128.8.30]) by
	SSI-EX3.ssi.samsung.com ([105.128.8.30]) with mapi id 15.01.2507.044; Fri,
	31 Jan 2025 12:48:27 -0800
From: Adam Manzanares <a.manzanares@samsung.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: Vinayak Holikatti <vinayak.kh@samsung.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>, "krish.reddy@samsung.com"
	<krish.reddy@samsung.com>, "vishak.g@samsung.com" <vishak.g@samsung.com>,
	"alok.rathore@samsung.com" <alok.rathore@samsung.com>,
	"s5.kumari@samsung.com" <s5.kumari@samsung.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/2] hw/cxl/cxl-mailbox-utils: Add support for Media
 operations Sanitize and Write Zeros commands (8.2.9.9.5.3)
Thread-Topic: [PATCH 2/2] hw/cxl/cxl-mailbox-utils: Add support for Media
	operations Sanitize and Write Zeros commands (8.2.9.9.5.3)
Thread-Index: AQHbbVtToxMXh83zVkezCaraYyzDprMmkjIAgAtcIgA=
Date: Fri, 31 Jan 2025 20:48:27 +0000
Message-ID: <Z503EpvqMczHIZqF@sjvm-adma01.eng.stellus.in>
In-Reply-To: <20250124151946.0000134f@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9D4DB61AC3B29E4CABDF7F19B705F2E5@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsWy7djXc7oy5nPTDRbOsbZYtfAam8X5WadY
	LI737mBxYPZoOfKW1ePJtc1MHp83yQUwR3HZpKTmZJalFunbJXBl/Fy2grngTFXF1hXfWBoY
	G8K6GDk5JARMJJo3H2HvYuTiEBJYyShx+8hkJginlUni3roLbDBVL/+fZoZIrGGU2Dm7C6rq
	E6PEiRm7oTJLGCUOHDjFAtLCJmAg8fv4RmYQW0TASOLdjUmMIEXMAu+YJGbdngdWJCzQyijx
	YVU+SEJEoI1R4tDMJ0BzOYAcK4n775VBalgEVCXubJ3DBGLzClhKXDj/DczmFDCUODhjAdgc
	RgExie+n1oDFmQXEJW49mc8EcbegxKLZe5ghbDGJf7seQv2jKHH/+0t2iHodiQW7P7FB2HYS
	c5f8g7K1JZYtfM0MsVdQ4uTMJywQvZISB1fcYAG5WUJgC4fE4RMXoZa5SHzY8RHKlpaYvuYy
	VEO+xK62K1BHVEhcfd0NdYS1xMI/65kmMKrMQnL3LCQ3zUJy0ywkN81CctMCRtZVjOKlxcW5
	6anFxnmp5XrFibnFpXnpesn5uZsYgYnm9L/DBTsYb936qHeIkYmD8RCjBAezkggvx+E56UK8
	KYmVValF+fFFpTmpxYcYpTlYlMR5VQ60pgsJpCeWpGanphakFsFkmTg4pRqY9AuNzsZNyb9+
	YbaM9i/59XPSdy812/73oZtBhFTpS8FsCy+mTTfXcu9VeHbDXm32eduWKUdzzjXFxQceWXQv
	Kf9hXdOhj05RFVftxFYmXOR7v12wvn+/SsPi5MPzHz3edyVlretKu78zAt5d3l0rab5oPY+l
	y9ykTbWl7ffPhluu3Xm7IXeiyq5Hyhu06lbe3T1Z4sz/w9l+6Xt+VdZImO7y9jmwUmGSvvJz
	zjX9B/Ptni3/MldAmvXda38ns7rUqLMn6lwLX1RtFjFVOO67NZ9LXGDtQ/e7X6srtvUWLuRn
	XF81Vbb0tnuOb657xnaR31erNFfqzv33K+OuquilqNSL23V3SvYLXTuYljJdSYmlOCPRUIu5
	qDgRACxnLGqjAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHIsWRmVeSWpSXmKPExsWS2cDspCtjPjfd4M4rGYtVC6+xWZyfdYrF
	4njvDhYHZo+WI29ZPZ5c28zk8XmTXABzFJdNSmpOZllqkb5dAlfGz2UrmAvOVFVsXfGNpYGx
	IayLkZNDQsBE4uX/08xdjFwcQgKrGCVmX9nMCOF8YpT4vOsNK4SzhFGiYcMERpAWNgEDid/H
	NzKD2CICRhLvbkwC62AWeMMksfn7X7CEsEAro8SHVfkgCRGBNkaJjVN/sHQxcgA5VhL33yuD
	1LAIqErc2TqHCcTmFbCUuHD+GxPEtheMEtNP7WcBSXAKGEocnLEAzGYUEJP4fmoNWAOzgLjE
	rSfzmSCeEJBYsuc8M4QtKvHy8T9WCFtR4v73l+wQ9ToSC3Z/YoOw7STmLvkHZWtLLFv4mhni
	CEGJkzOfsED0SkocXHGDZQKjxCwk62YhGTULyahZSEbNQjJqASPrKkbx0uLi3PSKYuO81HK9
	4sTc4tK8dL3k/NxNjMAoPf3vcMwOxnu3PuodYmTiYDzEKMHBrCTCy3F4TroQb0piZVVqUX58
	UWlOavEhRmkOFiVx3rsPNFKFBNITS1KzU1MLUotgskwcnFINTFVqlrxT77j7ef9UdHTjW9w6
	5/ASCxvtu1LT9rvlufqn/FTxuxQcn9q5UHDi1mdvmlLOR96ufZKz1PWm2PUPRefjN567tUL7
	dnMO77E8dQsptv5lisKTdNqUNe7cFbr53ztlk1GhWZSS4vMcS/NQRs3/5VNq2U8eWfmQf13U
	2R1nMy4vkLpzqW2rwFTf9F7btvJX3XFLX5xj3iXgzWfgIOuW4yxeb5eS/uqaJt9EH8sEzp6b
	VicWSAQ/VDgyZWekvcB0S5e8eof1Nrbez86eWfZwYpepzZXVShLO0ybeUS22P78mRXym2tft
	eut+3SlJDKmJTdzW/SXS8XBcdrRlXVPrK8azcyyq9zsUGngpsRRnJBpqMRcVJwIARPhP8kED
	AAA=
X-CMS-MailID: 20250131204828uscas1p283110e0caa90588d2caffa1067a944b0
CMS-TYPE: 301P
X-CMS-RootMailID: 20250123050913epcas5p45fb9a638e62f436076da283e86e54ea2
References: <20250123050903.92336-1-vinayak.kh@samsung.com>
	<CGME20250123050913epcas5p45fb9a638e62f436076da283e86e54ea2@epcas5p4.samsung.com>
	<20250123050903.92336-3-vinayak.kh@samsung.com>
	<20250124151946.0000134f@huawei.com>

On Fri, Jan 24, 2025 at 03:19:46PM +0000, Jonathan Cameron wrote:
> On Thu, 23 Jan 2025 10:39:03 +0530
> Vinayak Holikatti <vinayak.kh@samsung.com> wrote:
>=20
> >     CXL spec 3.1 section 8.2.9.9.5.3 describes media operations command=
s.
> >     CXL devices supports media operations Sanitize and Write zero comma=
nd.
>=20
> As before, don't indent this.
>=20
> >=20
> > Signed-off-by: Vinayak Holikatti <vinayak.kh@samsung.com>
> > ---
> >  hw/cxl/cxl-mailbox-utils.c  | 217 ++++++++++++++++++++++++++++++++++--
> >  include/hw/cxl/cxl_device.h |  11 ++
> >  2 files changed, 220 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > index 2315d07fb1..89847ddd9d 100644
> > --- a/hw/cxl/cxl-mailbox-utils.c
> > +++ b/hw/cxl/cxl-mailbox-utils.c
> > @@ -1722,6 +1722,145 @@ static CXLRetCode cmd_sanitize_overwrite(const =
struct cxl_cmd *cmd,
> >      return CXL_MBOX_BG_STARTED;
> >  }
> > =20
> > +#define DPA_RANGE_GRANULARITY 64
>=20
> Could use existing CXL_CACHELINE_SIZE definition for this, though I guess
> strictly speaking it could be unrelated.
>=20
> > +struct dpa_range_list_entry {
> > +    uint64_t starting_dpa;
> > +    uint64_t length;
> > +};
> > +
> > +static int validate_dpa_addr(CXLType3Dev *ct3d, uint64_t dpa_addr,
> > +                             size_t length)
> > +{
> > +    MemoryRegion *vmr =3D NULL, *pmr =3D NULL, *dc_mr =3D NULL;
> > +    uint64_t vmr_size =3D 0, pmr_size =3D 0, dc_size =3D 0;
> > +    int rc =3D 0;
> > +
> > +    if ((dpa_addr % DPA_RANGE_GRANULARITY) ||
> > +         (length % DPA_RANGE_GRANULARITY)) {
> Probably makes sense to also check for length 0 here as that would
> be very odd if sent.
> > +        return -EINVAL;
> > +    }
> > +
> > +    if (ct3d->hostvmem) {
> > +        vmr =3D host_memory_backend_get_memory(ct3d->hostvmem);
> > +        vmr_size =3D memory_region_size(vmr);
> > +    }
> > +    if (ct3d->hostpmem) {
> > +        pmr =3D host_memory_backend_get_memory(ct3d->hostpmem);
> > +        pmr_size =3D memory_region_size(pmr);
> > +    }
> > +    if (ct3d->dc.host_dc) {
> > +        dc_mr =3D host_memory_backend_get_memory(ct3d->dc.host_dc);
> > +        dc_size =3D memory_region_size(dc_mr);
> > +    }
> > +
> > +    if (!vmr && !pmr && !dc_mr) {
> > +        return -ENODEV;
> > +    }
> > +
> > +    if (dpa_addr >=3D vmr_size + pmr_size + dc_size ||
> > +        (dpa_addr + length) > vmr_size + pmr_size + dc_size) {
>=20
> If length is checked as non zero above, only the second test is needed.
>=20
> > +        return -EINVAL;
> > +    }
> > +
> > +    if (dpa_addr > vmr_size + pmr_size) {
> > +        if (!ct3_test_region_block_backed(ct3d, dpa_addr, length)) {
> > +            return -ENODEV;
> > +        }
> > +    }
> > +
> > +
> > +    return rc;
>=20
> return 0. rc is never set to anything else.
>=20
> > +}
> > +
> > +static int sanitize_range(CXLType3Dev *ct3d, uint64_t dpa_addr, size_t=
 length,
> > +                          uint8_t fill_value)
> > +{
> > +
> > +    MemoryRegion *vmr =3D NULL, *pmr =3D NULL;
> > +    uint64_t vmr_size =3D 0, pmr_size =3D 0;
> > +    AddressSpace *as =3D NULL;
> > +    MemTxAttrs mem_attrs =3D {0};
> > +
> > +    if (ct3d->hostvmem) {
> > +        vmr =3D host_memory_backend_get_memory(ct3d->hostvmem);
> > +        vmr_size =3D memory_region_size(vmr);
> > +    }
> > +    if (ct3d->hostpmem) {
> > +        pmr =3D host_memory_backend_get_memory(ct3d->hostpmem);
> > +        pmr_size =3D memory_region_size(pmr);
> > +    }
> > +
> > +    if (dpa_addr < vmr_size) {
> > +        as =3D &ct3d->hostvmem_as;
> > +    } else if (dpa_addr < vmr_size + pmr_size) {
> > +        as =3D &ct3d->hostpmem_as;
> > +    } else {
> > +        if (!ct3_test_region_block_backed(ct3d, dpa_addr, length)) {
> > +            return -ENODEV;
> > +        }
> > +        as =3D &ct3d->dc.host_dc_as;
> > +    }
>=20
> You could factor out everything down to here and then use that
> for the validate_dpa_addr() as finding an address space means
> we also checked the address is valid. Otherwise it does not match.
>=20
> > +
> > +    return  address_space_set(as, dpa_addr,
>=20
> odd spacing after return. Should just be one space.
>=20
> > +                              fill_value, length, mem_attrs);
> > +}
> > +
> > +/* Perform the actual device zeroing */
> > +static void __do_sanitize(CXLType3Dev *ct3d)
> > +{
> > +    struct CXLSanitizeInfo  *san_info =3D ct3d->media_op_sanitize;
>=20
> Single space only before *san_info
>=20
> > +    int dpa_range_count =3D san_info->dpa_range_count;
> > +    int rc =3D 0;
> > +
> > +    for (int i =3D 0; i < dpa_range_count; i++) {
> > +        rc =3D sanitize_range(ct3d, san_info->dpa_range_list[i].starti=
ng_dpa,
> > +                san_info->dpa_range_list[i].length, san_info->fill_val=
ue);
> > +        if (rc) {
> > +            goto exit;
> > +        }
> > +    }
> > +    cxl_discard_all_event_records(&ct3d->cxl_dstate);
>=20
> Add a comment on why we are deleting event records when sanitizing a smal=
l
> part of memory?
>=20

See response below for disabling the media state. Same section referenced
below, 8.2.10.9.5.1 states all event logs should be deleted. Outcome
depends on how we interpret "follow the method described in 8.2.10.9.5.1".

> > +exit:
> > +    g_free(ct3d->media_op_sanitize);
> > +    ct3d->media_op_sanitize =3D NULL;
> > +    return;
> > +}
> > +
> > +static int get_sanitize_duration(uint64_t total_mem)
>=20
> Where did this come from?  Factor out the existing code
> in cmd_santize_overwrite() instead of duplicating this stack
> of if/else if
>=20
> Ideally do that as a precursor patch as it's just code movement.
>=20
>=20
> > +{
> > +    int secs =3D 0;
> > +
> > +    if (total_mem <=3D 512) {
> > +        secs =3D 4;
> > +    } else if (total_mem <=3D 1024) {
> > +        secs =3D 8;
> > +    } else if (total_mem <=3D 2 * 1024) {
> > +        secs =3D 15;
> > +    } else if (total_mem <=3D 4 * 1024) {
> > +        secs =3D 30;
> > +    } else if (total_mem <=3D 8 * 1024) {
> > +        secs =3D 60;
> > +    } else if (total_mem <=3D 16 * 1024) {
> > +        secs =3D 2 * 60;
> > +    } else if (total_mem <=3D 32 * 1024) {
> > +        secs =3D 4 * 60;
> > +    } else if (total_mem <=3D 64 * 1024) {
> > +        secs =3D 8 * 60;
> > +    } else if (total_mem <=3D 128 * 1024) {
> > +        secs =3D 15 * 60;
> > +    } else if (total_mem <=3D 256 * 1024) {
> > +        secs =3D 30 * 60;
> > +    } else if (total_mem <=3D 512 * 1024) {
> > +        secs =3D 60 * 60;
> > +    } else if (total_mem <=3D 1024 * 1024) {
> > +        secs =3D 120 * 60;
> > +    } else {
> > +        secs =3D 240 * 60; /* max 4 hrs */
> > +    }
> > +
> > +    return secs;
> > +}
> > +
> >  enum {
> >      MEDIA_OP_GENERAL  =3D 0x0,
> >      MEDIA_OP_SANITIZE =3D 0x1,
> > @@ -1729,10 +1868,9 @@ enum {
> >  } MEDIA_OPERATION_CLASS;
> > =20
> >  enum {
> > -    MEDIA_OP_SUB_DISCOVERY =3D 0x0,
> > -    MEDIA_OP_SUB_SANITIZE =3D 0x0,
> > -    MEDIA_OP_SUB_ZERO     =3D 0x1,
> > -    MEDIA_OP_SUB_CLASS_MAX
> > +    MEDIA_OP_GEN_DISCOVERY =3D 0x0,
> > +    MEDIA_OP_SAN_SANITIZE =3D 0x0,
> > +    MEDIA_OP_SAN_ZERO     =3D 0x1,
>=20
> See naming suggestions in first patch. Make sure to tidy up so you don't =
introduce
> them there then change them here!
>=20
> >  } MEDIA_OPERATION_SUB_CLASS;
> > =20
> >  struct media_op_supported_list_entry {
> > @@ -1777,9 +1915,14 @@ static CXLRetCode cmd_media_operations(const str=
uct cxl_cmd *cmd,
> >      };
> >      } QEMU_PACKED *media_op_in_pl =3D (void *)payload_in;
> > =20
> > +
>=20
> Blank line here doesn't add anything.
>=20
> > +    CXLType3Dev *ct3d =3D CXL_TYPE3(cci->d);
> >      uint8_t media_op_cl =3D media_op_in_pl->media_operation_class;
> >      uint8_t media_op_subclass =3D media_op_in_pl->media_operation_subc=
lass;
> >      uint32_t dpa_range_count =3D media_op_in_pl->dpa_range_count;
> > +    uint8_t fill_value =3D 0;
> > +    uint64_t total_mem =3D 0;
> > +    int secs =3D 0;
> > =20
> >      if (len_in < sizeof(*media_op_in_pl)) {
> >          return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
> > @@ -1788,7 +1931,7 @@ static CXLRetCode cmd_media_operations(const stru=
ct cxl_cmd *cmd,
> >      switch (media_op_cl) {
> >      case MEDIA_OP_GENERAL:
> >          switch (media_op_subclass) {
> > -        case MEDIA_OP_SUB_DISCOVERY:
> > +        case MEDIA_OP_GEN_DISCOVERY:
> >              int count =3D 0;
> >              struct media_op_discovery_out_pl *media_out_pl =3D
> >                  (void *)payload_out;
> > @@ -1806,7 +1949,7 @@ static CXLRetCode cmd_media_operations(const stru=
ct cxl_cmd *cmd,
> >                  return CXL_MBOX_INVALID_INPUT;
> >              }
> > =20
> > -            media_out_pl->dpa_range_granularity =3D CXL_CAPACITY_MULTI=
PLIER;
> > +            media_out_pl->dpa_range_granularity =3D DPA_RANGE_GRANULAR=
ITY;
> >              media_out_pl->total_supported_operations =3D MAX_SUPPORTED=
_OPS;
> >              if (num_ops > 0) {
> >                  for (int i =3D start_index; i < MAX_SUPPORTED_OPS; i++=
) {
> > @@ -1824,22 +1967,73 @@ disc_out:
> >              media_out_pl->num_of_supported_operations =3D count;
> >              *len_out =3D sizeof(struct media_op_discovery_out_pl) +
> >              (sizeof(struct media_op_supported_list_entry) * count);
> > -            break;
> > +            goto exit;
> return CXL_MBOX_SUCCESS;  No purpose in having the exit label as nothing
> to be done.
>=20
>=20
> >          default:
> >              return CXL_MBOX_UNSUPPORTED;
> >          }
> >          break;
> >      case MEDIA_OP_SANITIZE:
> > +    {
>=20
> From code here not obvious why scoping {} needed.
>=20
> >          switch (media_op_subclass) {
> > -
> > +        case MEDIA_OP_SAN_SANITIZE:
> > +            if (len_in < (sizeof(*media_op_in_pl) +
> > +                   (dpa_range_count * sizeof(struct dpa_range_list_ent=
ry)))) {
> > +                return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
> > +            }
> The check applies to all current cases. So move it outside this switch st=
atement
> to remove duplication.  Here all you should do is set the fill_value;
>=20
> > +            fill_value =3D 0xF;
> > +            goto sanitize_range;
> > +        case MEDIA_OP_SAN_ZERO:
> > +            if (len_in < (sizeof(*media_op_in_pl) +
> > +                (dpa_range_count * sizeof(struct dpa_range_list_entry)=
))) {
> > +                return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
> > +            }
> > +            fill_value =3D 0;
> > +            goto sanitize_range;
> Why goto. Just break...
> >          default:
> >              return CXL_MBOX_UNSUPPORTED;
> >          }
> and have the stuff below under the sanitize_range label here.
>=20
> >          break;
> > +    }
> >      default:
> >          return CXL_MBOX_UNSUPPORTED;
> >      }
> > =20
> > +sanitize_range:
> > +    if (dpa_range_count > 0) {
> > +        for (int i =3D 0; i < dpa_range_count; i++) {
> > +            if (validate_dpa_addr(ct3d,
> > +                media_op_in_pl->dpa_range_list[i].starting_dpa,
> > +                media_op_in_pl->dpa_range_list[i].length)) {
> > +                return CXL_MBOX_INVALID_INPUT;
> > +            }
> > +            total_mem +=3D media_op_in_pl->dpa_range_list[i].length;
> > +        }
> > +        ct3d->media_op_sanitize =3D g_malloc0(sizeof(struct CXLSanitiz=
eInfo) +
> > +                                  (dpa_range_count *
> > +                                  sizeof(struct dpa_range_list_entry))=
);
> > +
> > +        if (ct3d->media_op_sanitize) {
> > +            ct3d->media_op_sanitize->dpa_range_count =3D dpa_range_cou=
nt;
> > +            ct3d->media_op_sanitize->fill_value =3D fill_value;
> > +            memcpy(ct3d->media_op_sanitize->dpa_range_list,
> > +                   media_op_in_pl->dpa_range_list,
> > +                   (dpa_range_count *
> > +                   sizeof(struct dpa_range_list_entry)));
> > +            secs =3D get_sanitize_duration(total_mem >> 20);
> > +            goto start_bg;
> > +        }
> > +    } else if (dpa_range_count =3D=3D 0) {
> > +        goto exit;
>     if (dpa_range_count =3D=3D 0) {
>        return CXL_MBOX_SUCCESS;
>     }
>     for (i =3D 0; i < dpa_range_count; i++)
>=20
> //that is return early in the simple case the no need for else
> and the extra level of indent on these long lines.
>=20
>=20
> > +    }
> > +
> > +start_bg:
> > +    /* EBUSY other bg cmds as of now */
> > +    cci->bg.runtime =3D secs * 1000UL;
> > +    *len_out =3D 0;
> > +    /* sanitize when done */
> > +    cxl_dev_disable_media(&ct3d->cxl_dstate);
> Why?  This is santizing part of the device. As I undestand it the
> main aim is to offload cleanup when the device is in use. Definitely
> don't want to disable media.  If I'm missing a reason please give
> a spec reference.

Table 8-164, sanitize description mentions to follow method
in 8.2.10.9.5.1, which does call out placing device in disabled
state, but I'm not sure if method refers to all text in 8.2.10.9.5.1
or the method devices uses to sanitize internally.

I would imagine since sanitize is destructive we would not want to return=20
any data from device ranges impacted by sanitize. I believe a simple
way to achieve this is to disable entire device.=20

>=20
> > +    return CXL_MBOX_BG_STARTED;
> > +exit:
> >      return CXL_MBOX_SUCCESS;
> >  }
> > =20
> > @@ -3154,6 +3348,13 @@ static void bg_timercb(void *opaque)
> >              cxl_dev_enable_media(&ct3d->cxl_dstate);
> >          }
> >          break;
> > +        case 0x4402: /* Media Operations sanitize */
> > +        {
> > +            CXLType3Dev *ct3d =3D CXL_TYPE3(cci->d);
> > +            __do_sanitize(ct3d);
> > +            cxl_dev_enable_media(&ct3d->cxl_dstate);
> Ah. You turn it back on here.   Specification reference needed.
> > +        }
> > +        break;
> >          case 0x4304: /* scan media */
> >          {
> >              CXLType3Dev *ct3d =3D CXL_TYPE3(cci->d);
> > diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> > index a64739be25..6d82eb266a 100644
> > --- a/include/hw/cxl/cxl_device.h
> > +++ b/include/hw/cxl/cxl_device.h
> > @@ -581,6 +581,15 @@ typedef struct CXLSetFeatureInfo {
> >      size_t data_size;
> >  } CXLSetFeatureInfo;
> > =20
> > +struct CXLSanitizeInfo {
> > +    uint32_t dpa_range_count;
> > +    uint8_t fill_value;
> > +    struct {
> > +            uint64_t starting_dpa;
> > +            uint64_t length;
> > +    } dpa_range_list[0];
> []
> > +};
> > +
> >  struct CXLType3Dev {
> >      /* Private */
> >      PCIDevice parent_obj;
> > @@ -651,6 +660,8 @@ struct CXLType3Dev {
> >          uint8_t num_regions; /* 0-8 regions */
> >          CXLDCRegion regions[DCD_MAX_NUM_REGION];
> >      } dc;
> > +
> > +    struct CXLSanitizeInfo  *media_op_sanitize;
> Here we just need to know there is a definition of struct
> CXLSantizeInfo not what form it takes.  So use a forwards
> defintion and push the definition of struct CXLSanitizeInfo
> down to where it is needed only (in the c file).
>=20
> Thanks,
>=20
> Jonathan
>=20
> >  };
> > =20
> >  #define TYPE_CXL_TYPE3 "cxl-type3"
> =
