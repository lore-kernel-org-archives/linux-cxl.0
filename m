Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A5E2F2907
	for <linux-cxl@vger.kernel.org>; Wed, 13 Aug 2025 11:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755083708; cv=none; b=rSVeuvgejnOo0eISTy07jcdaqKw+atE3sZd97f3fVKGeqQNGdyVB5Djx/dfmFRl8X8olUFE71emhDrYSn3dkLvR9ZldUywaHuq+a3FiHacF+txDchCSIWeOD28G3bMLJRn0G/n787n9pz3KL4UD7WCH19PWKo6NEuBlupQUW6CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755083708; c=relaxed/simple;
	bh=hWf4+P/L1Gmyw+zJapleYBmqmFyhCss/OmtprFUpNYU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CmJio+0EiqjJ4ETiF1Qr3MsgD6auI8Qfc4T/nQPGNAc0jv0wJzYM0ZVIIUsK5PduJHiH2b8uaZ57tYszj2VHc91uFaXnOPqB50d9L+k0xkRfwthMHnF9KsyrvAmB2DHhqzK60rJd9eNu5BApQ3W3nAi4L2X/oGwkITg4X5no/lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c25J25zqpz6HJnn;
	Wed, 13 Aug 2025 19:10:10 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 3C2921402EF;
	Wed, 13 Aug 2025 19:15:03 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 13 Aug
 2025 13:15:02 +0200
Date: Wed, 13 Aug 2025 12:15:01 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: peng guo <engguopeng@buaa.edu.cn>
CC: Davidlohr Bueso <dave@stgolabs.net>, <fan.ni@samsung.com>,
	<linux-cxl@vger.kernel.org>, <a.manzanares@samsung.com>
Subject: Re: [RESEND] hw/cxl: fix the determination of illegal physical
 addresses
Message-ID: <20250813121501.00005c89@huawei.com>
In-Reply-To: <aJIVyK7PPJdlsv4B@gp-VMware-Virtual-Platform>
References: <20240819120317.12505-1-engguopeng@buaa.edu.cn>
	<20240823161434.00004b30@Huawei.com>
	<4ylhz5gnwatapw2nwu6ktgr6i6l4iwyxirg7yamimsvilh2jla@d7vkuddno4z2>
	<aJIVyK7PPJdlsv4B@gp-VMware-Virtual-Platform>
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
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 5 Aug 2025 22:31:36 +0800
peng guo <engguopeng@buaa.edu.cn> wrote:

> On Wed, Sep 04, 2024 at 01:01:55PM -0700, Davidlohr Bueso wrote:
> > On Fri, 23 Aug 2024, Jonathan Cameron wrote:\n =20
> > > On Mon, 19 Aug 2024 20:03:17 +0800
> > > peng guo <engguopeng@buaa.edu.cn> wrote:
> > >  =20
> > > > When physical address range in the input payload of scan media comm=
and
> > > > exceeds static_mem_size but does not exceed the sum of static and d=
ynamic
> > > > memory, the scan media mailbox command unexpectedly returns an erro=
r code
> > > > which is CXL_MBOX_INVALID_PA.
> > > >=20
> > > > This patch determines whether the physical address is valid in two =
cases.
> > > > If dynamic memory exists, check whether the address range of the re=
quest
> > > > exceeds the range of static memory and dynamic memory.If dynamic me=
mory =20
> > 							 ^ space for a new sentence =20
> > > > does not exist, then check whether the address range of the request
> > > > exceeds the static memory size.
> > > >=20
> > > > Fixes: d61cc5b6a8d3 ("hw/cxl: Add get scan media capabilities cmd s=
upport") =20
> > > Is that the right one, this code is affecting cmd_media_scan_media()
> > > not the capabilities one which always limits to static_mem_size and
> > > hence also looks wrong. =20
> >=20
> > Yeah it is the right one - both commands were merged together (and
> > yes, they both need to be updated for dcd).
> >=20
> > Maybe have a helper to consolidate all cases where such ranges are used?
> >=20
> > uint64_t ct3d_get_total_size(CXLDeviceState *cxl_dstate, CXLType3Dev *c=
t3d)
> > {
> >=20
> > 	return cxl_dstate->static_mem_size + ct3d->dc.total_capacity;
> > }
> >  =20
> > >  =20
> > > > Signed-off-by: peng guo <engguopeng@buaa.edu.cn> =20
> > >=20
> > > As with the other patch, this needs to go to qemu-devel list
> > > + both should have gone to Davidlohr as author the patch you
> > > are fixing (sort of it, it's mostly down to what order patches
> > > landed in I think).
> > >=20
> > > Fan, Davidlohr, do we want to just cover the DCD regions as
> > > well with all the scan_media commands? =20
> >=20
> > Yeah, I think so - particularly since poison management already
> > considers dcd for CXL_MBOX_INVALID_PA.
> >=20
> > Thanks,
> > Davidlohr =20
>=20
> Hi Jonathan, Davidlohr,
>=20
> Sorry for the late reply.
>=20
> I=E2=80=99m following up on the discussion about the `scan media` command=
 behavior=20
> when dynamic memory is present. Based on our earlier exchange, it seems=20
> that the command currently returns `CXL_MBOX_INVALID_PA` if the requested=
=20
> address falls within the dynamic memory region =E2=80=94 even though this=
 should=20
> be a valid case when DCD is enabled.
>=20
> Just to confirm: should this be treated as a bug that needs to be fixed w=
ith=20
> an updated patch?
I'm not sure a device is obliged to support all features on DCD, but there =
is
no clean way to discover if it does or not.

So, probably not worth backporting to stable QEMU (as a bug) but worth fixi=
ng
going forwards.
>=20
> If so, I=E2=80=99d be happy to prepare a new version and send it to the p=
roper recipients.
>=20
Great!

Jonathan

> Thanks again for your feedback.
>=20
> Best regards,
> Peng Guo
>=20
> >  =20
> > >=20
> > >  =20
> > > > ---
> > > >  hw/cxl/cxl-mailbox-utils.c | 9 +++++----
> > > >  1 file changed, 5 insertions(+), 4 deletions(-)
> > > >=20
> > > > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > > > index 3ebbd32e10..b23c6b9b0b 100644
> > > > --- a/hw/cxl/cxl-mailbox-utils.c
> > > > +++ b/hw/cxl/cxl-mailbox-utils.c
> > > > @@ -1943,11 +1943,12 @@ static CXLRetCode cmd_media_scan_media(cons=
t struct cxl_cmd *cmd,
> > > >      }
> > > >      query_length =3D ldq_le_p(&in->length) * CXL_CACHE_LINE_SIZE;
> > > >=20
> > > > -    if (query_start + query_length > cxl_dstate->static_mem_size) {
> > > > -        return CXL_MBOX_INVALID_PA;
> > > > -    }
> > > > -    if (ct3d->dc.num_regions && query_start + query_length >=3D
> > > > +    if (ct3d->dc.num_regions) {
> > > > +        if (query_start + query_length >=3D
> > > >              cxl_dstate->static_mem_size + ct3d->dc.total_capacity)=
 {
> > > > +                return CXL_MBOX_INVALID_PA;
> > > > +            }
> > > > +    } else if (query_start + query_length > cxl_dstate->static_mem=
_size) {
> > > >          return CXL_MBOX_INVALID_PA;
> > > >      } =20
> > > Can we not rely on dc.total_capacity =3D=3D 0 if num_regions =3D=3D 0/
> > >  =20
> > > >  =20
> > >  =20
>=20
>=20

