Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F962BD5A7
	for <linux-cxl@vger.kernel.org>; Wed,  4 Feb 2026 11:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770205849; cv=none; b=Ju0FUoJAxrr9YGTGTpGECAsAf46EfQVSziNoY35LkoEANwhcJakr6Qj4AWiU/KiTwLWgBgpWPCGZ44alJAZbSLQ6kl6BkLNtjCbsu13SKO5jQguc8WNozKPuryTsiyvzIHt9tVNr9j2dIRea3kKPsNQDI9GNVkxE8fcNZWtgQ7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770205849; c=relaxed/simple;
	bh=4ktMZD2edvxDYZXIxn1NGKo9OFWVpRsSL4kkShtj3Es=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KGVthf/0APJD5HlUSupIyBEJ32TF56vWe91NNy/rj4Rd79OWWYVjpEqRNoodkMZR09NCH2JJXVouF/gzzWvjNhW4GETMd02SZDUSHFDLADamRHSwrFij0a2I5OfRTrKEjSupKmIxkplHytqFlJ1hrIBAS4Fw5E4yY2D4Heeft+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f5dv91nv0zJ46cP;
	Wed,  4 Feb 2026 19:49:57 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 381924056A;
	Wed,  4 Feb 2026 19:50:46 +0800 (CST)
Received: from localhost (10.122.19.247) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 4 Feb
 2026 11:50:44 +0000
Date: Wed, 4 Feb 2026 11:50:41 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: <qemu-devel@nongnu.org>, Davidlohr Bueso <dave@stgolabs.net>,
	<linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>, Ravi Shankar
	<venkataravis@micron.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
	Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH qemu v5 6/7] hw/cxl: Support type3 HDM-DB
Message-ID: <20260204115041.00001755@huawei.com>
In-Reply-To: <20260203144122-mutt-send-email-mst@kernel.org>
References: <20260109144511.557781-1-Jonathan.Cameron@huawei.com>
	<20260109144511.557781-7-Jonathan.Cameron@huawei.com>
	<20260203144122-mutt-send-email-mst@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml500005.china.huawei.com (7.214.145.207)


> > +        }
> > +
> > +        return cregs->cache_mem_registers[offset / 4];
> >      case 8:
> >          qemu_log_mask(LOG_UNIMP,
> >                        "CXL 8 byte cache mem registers not implemented\=
n");
> > @@ -118,6 +148,47 @@ static void dumb_hdm_handler(CXLComponentState *cx=
l_cstate, hwaddr offset,
> >      stl_le_p((uint8_t *)cache_mem + offset, value);
> >  }
> > =20
> > +static void bi_handler(CXLComponentState *cxl_cstate, hwaddr offset,
> > +                            uint32_t value)
> > +{
> > +    ComponentRegisters *cregs =3D &cxl_cstate->crb;
> > +    uint32_t sts, *cache_mem =3D cregs->cache_mem_registers;
> > +    bool to_commit =3D false;
> > +    int type; =20
>=20
> type is declared here...
>=20
> > +
> > +    switch (offset) {
> > +    case A_CXL_BI_RT_CTRL:
> > +        to_commit =3D FIELD_EX32(value, CXL_BI_RT_CTRL, COMMIT);
> > +        if (to_commit) {
> > +            sts =3D cxl_cache_mem_read_reg(cxl_cstate,
> > +                                         R_CXL_BI_RT_STATUS, 4);
> > +            sts =3D FIELD_DP32(sts, CXL_BI_RT_STATUS, COMMITTED, 0);
> > +            stl_le_p((uint8_t *)cache_mem + R_CXL_BI_RT_STATUS, sts);
> > +            type =3D CXL_BISTATE_RT; =20
>=20
> and initialized here
>=20
> > +        }
> > +        break;
> > +    case A_CXL_BI_DECODER_CTRL:
> > +        to_commit =3D FIELD_EX32(value, CXL_BI_DECODER_CTRL, COMMIT);
> > +        if (to_commit) {
> > +            sts =3D cxl_cache_mem_read_reg(cxl_cstate,
> > +                                         R_CXL_BI_DECODER_STATUS, 4);
> > +            sts =3D FIELD_DP32(sts, CXL_BI_DECODER_STATUS, COMMITTED, =
0);
> > +            stl_le_p((uint8_t *)cache_mem + R_CXL_BI_DECODER_STATUS, s=
ts);
> > +            type =3D CXL_BISTATE_DECODER; =20
>=20
> and here
>=20
> > +        }
> > +        break;
> > +    default:
> > +        break;
> > +    }
> > +
> > +    if (to_commit) {
> > +        cxl_cstate->bi_state[type].last_commit =3D
> > +                qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL); =20
>=20
> so there is no way for it to be used uninitialized.
>=20
>=20
> However some gcc versions are not smart enough to see that
> and they warn:
>=20
> https://gitlab.com/mstredhat/qemu/-/jobs/12972572228
>=20
>=20
> ../hw/cxl/cxl-component-utils.c: In function =E2=80=98cxl_cache_mem_write=
_reg=E2=80=99:
> ../hw/cxl/cxl-component-utils.c:181:48: error: =E2=80=98type=E2=80=99 may=
 be used uninitialized in this function [-Werror=3Dmaybe-uninitialized]
>   181 |         cxl_cstate->bi_state[type].last_commit =3D
>       |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^
>   182 |                 qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
>       |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../hw/cxl/cxl-component-utils.c:153:9: note: =E2=80=98type=E2=80=99 was d=
eclared here
>   153 |     int type;
>       |         ^~~~
> cc1: all warnings being treated as errors
>=20
Thanks. I'll set it to 0 at declaration with a comment that it's there to r=
esolve
a compiler warning (so no one deletes it as a cleanup!)

Jonathan

