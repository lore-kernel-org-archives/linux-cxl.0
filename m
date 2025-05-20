Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B8F21CA14
	for <linux-cxl@vger.kernel.org>; Tue, 20 May 2025 11:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747740109; cv=none; b=iQMKJA52FL4t+hNx0uDNmG/CLbnNHGyyu69lpXQ1/aHUmGIAmWXqroocKAwb+0ve5aX12TPOJK42bxYZteimKjgMe1RDyMaTSzaCQLnOgLcECxxi1ZF2baHSEDCdbRtGf5cXdH0mtKObealsz/50BpHSLi1e/xngf1fTCyTyQwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747740109; c=relaxed/simple;
	bh=4tYWaf0ovYB4Gaa5yL2Jlb7cKdufxKMoYxx8vKyrR9o=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iWrxQfo9MUhYtCLIwYO+ZPn43TGAaV5kjbMhZK7PlGyhFnAS1/brXgbWumLfYsP4FBKg1kKLtbjwyS19hAtklksN0Y9ydFYYLsbnC2G0cA0QSs7OWcXhUG7VegyvObGcYipgJKne8teCMjYBhJ3RnffqRBZLG9SLvqdISXh1lZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b1sVz54J2z6L52S;
	Tue, 20 May 2025 19:18:35 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id A28241402F7;
	Tue, 20 May 2025 19:21:43 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 20 May
 2025 13:21:43 +0200
Date: Tue, 20 May 2025 12:21:41 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: Alejandro Lucero Palau <alucerop@amd.com>, <linux-cxl@vger.kernel.org>,
	Dan Williams <dan.j.williams@intel.com>, <dave@stgolabs.net>,
	<alison.schofield@intel.com>, <ira.weiny@intel.com>, <rrichter@amd.com>,
	<ming.li@zohomail.com>
Subject: Re: [PATCH v2 03/10] cxl: Rename find_dport() to provide better
 function intent
Message-ID: <20250520122141.0000419c@huawei.com>
In-Reply-To: <431bc155-de69-4e07-82f1-33c654b6d907@intel.com>
References: <20250507004310.3536991-1-dave.jiang@intel.com>
	<20250507004310.3536991-4-dave.jiang@intel.com>
	<36ee7c17-4a06-4288-89d0-547c23afb8e6@amd.com>
	<431bc155-de69-4e07-82f1-33c654b6d907@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 19 May 2025 09:33:26 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> On 5/9/25 2:20 AM, Alejandro Lucero Palau wrote:
> >=20
> > On 5/7/25 01:43, Dave Jiang wrote: =20
> >> Rename find_dport() to find_dport_by_num() to indicate that the functi=
on
> >> is trying to match a dport by its hardware number index.
> >>
> >> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> >> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> >> ---
> >> =A0 drivers/cxl/core/port.c | 12 ++++++------
> >> =A0 1 file changed, 6 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> >> index e9c02e4d0d4c..1d7a4a2ef6ad 100644
> >> --- a/drivers/cxl/core/port.c
> >> +++ b/drivers/cxl/core/port.c
> >> @@ -1045,7 +1045,7 @@ void put_cxl_root(struct cxl_root *cxl_root)
> >> =A0 }
> >> =A0 EXPORT_SYMBOL_NS_GPL(put_cxl_root, "CXL");
> >> =A0 -static struct cxl_dport *find_dport(struct cxl_port *port, int po=
rt_num)
> >> +static struct cxl_dport *find_dport_by_num(struct cxl_port *port, int=
 port_num)
> >> =A0 {
> >> =A0=A0=A0=A0=A0 struct cxl_dport *dport;
> >> =A0=A0=A0=A0=A0 unsigned long index;
> >> @@ -1063,7 +1063,7 @@ static int add_dport(struct cxl_port *port, stru=
ct cxl_dport *dport)
> >> =A0=A0=A0=A0=A0 int rc;
> >> =A0 =A0=A0=A0=A0=A0 device_lock_assert(&port->dev);
> >> -=A0=A0=A0 dup =3D find_dport(port, dport->port_num);
> >> +=A0=A0=A0 dup =3D find_dport_by_num(port, dport->port_num);
> >> =A0=A0=A0=A0=A0 if (dup) {
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err(&port->dev,
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "unable to add dport%d-%s non-=
unique port num (%s)\n",
> >> @@ -1275,13 +1275,13 @@ EXPORT_SYMBOL_NS_GPL(devm_cxl_add_dport, "CXL"=
);
> >> =A0=A0 * devm_cxl_add_rch_dport - append RCH downstream port data to a=
 cxl_port
> >> =A0=A0 * @port: the cxl_port that references this dport
> >> =A0=A0 * @dport_dev: firmware or PCI device representing the dport
> >> - * @port_id: identifier for this dport in a decoder's target list
> >> + * @port_num: identifier for this dport in a decoder's target list =20
> >=20
> >=20
> > Not sure this change should be in this patch. It makes more sense to me=
 in the previous one.
> >=20
> >=20
> > Also, maybe adding some reference for easily seeing where the identifie=
r comes from:
> >=20
> > + * @port_num: hardware identifier for this dport in a decoder's target=
 list =20
>=20
> In the process of doing that, I realized that this entire comment line ge=
ts dropped in a later patch because we remove the port_num parameter. So pr=
obably no need to change since it goes away entirely.
>
Even though it's only a comment, if you are changing the name in
the function let's avoid the trivial issue of the kernel-doc
warning that will show up.  Make sure those are kept inline.

I'll assume you'll tidy this up one way or another - rest of patch is fine

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> DJ
>=20
> >=20
> >  =20
> >> =A0=A0 * @rcrb: mandatory location of a Root Complex Register Block
> >> =A0=A0 *
> >> =A0=A0 * See CXL 3.0 9.11.8 CXL Devices Attached to an RCH
> >> =A0=A0 */
> >> =A0 struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
> >> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct d=
evice *dport_dev, int port_id,
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct d=
evice *dport_dev, int port_num,
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 res=
ource_size_t rcrb)
> >> =A0 {
> >> =A0=A0=A0=A0=A0 struct cxl_dport *dport;
> >> @@ -1291,7 +1291,7 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct =
cxl_port *port,
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0 return ERR_PTR(-EINVAL);
> >> =A0=A0=A0=A0=A0 }
> >> =A0 -=A0=A0=A0 dport =3D __devm_cxl_add_dport(port, dport_dev, port_id,
> >> +=A0=A0=A0 dport =3D __devm_cxl_add_dport(port, dport_dev, port_num,
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 CXL=
_RESOURCE_NONE, rcrb);
> >> =A0=A0=A0=A0=A0 if (IS_ERR(dport)) {
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_dbg(dport_dev, "failed to add RCH dpor=
t to %s: %ld\n",
> >> @@ -1764,7 +1764,7 @@ static int decoder_populate_targets(struct cxl_s=
witch_decoder *cxlsd,
> >> =A0 =A0=A0=A0=A0=A0 guard(rwsem_write)(&cxl_region_rwsem);
> >> =A0=A0=A0=A0=A0 for (i =3D 0; i < cxlsd->cxld.interleave_ways; i++) {
> >> -=A0=A0=A0=A0=A0=A0=A0 struct cxl_dport *dport =3D find_dport(port, ta=
rget_map[i]);
> >> +=A0=A0=A0=A0=A0=A0=A0 struct cxl_dport *dport =3D find_dport_by_num(p=
ort, target_map[i]);
> >> =A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!dport)
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -ENXIO; =20
>=20
>=20

