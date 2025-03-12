Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B39A1D5173
	for <linux-cxl@vger.kernel.org>; Wed, 12 Mar 2025 18:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741803043; cv=none; b=jVLkWjxh2tEj3QLNz4LuY78D5O64onoiO3W4+IDsael0XmBai9X4ZTYyss6QaVJJcjqjpzrX86oc6paZoUhoWyAh0dEepByI/Zo9MrRwWScHSmgB1T8mI0d8a/iGuTJ1mUC6UMYRJNI76uxFF4dvxfH+rP9UGs8X+kfSuC0/pBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741803043; c=relaxed/simple;
	bh=IBlcJr4U3fZCO3sZwvTmhdkfgv2ln2uWBDT39wfvKec=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PqVQ1GK78KFZ1L86uCIpn1b0u12BIx5qsbbeSo0e71YNgrNDBiMRSf7lGddg+cr4K0wsuzchw6hLfIvVMZ/jL+o0FFBVm1+YtRP57LCtYbngHJmomhmaSVWVlureLTtxbSj6bPUMe2IxLlAnVKNqMBVphYt75gA2VLaEE3KoyrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZCdsG2tfSz6JB0t;
	Thu, 13 Mar 2025 02:08:02 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 7642B140D26;
	Thu, 13 Mar 2025 02:10:38 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 12 Mar
 2025 19:10:36 +0100
Date: Wed, 12 Mar 2025 18:10:35 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] docs/cxl: Add serial number for persistent-memdev
Message-ID: <20250312181035.00006e32@huawei.com>
In-Reply-To: <4752672.2b5f.19565e01b65.Coremail.wangyuquan1236@phytium.com.cn>
References: <20250217112039.138650-1-wangyuquan1236@phytium.com.cn>
	<20250220161213.000049a9@huawei.com>
	<20250221065509-mutt-send-email-mst@kernel.org>
	<17b91a9f.2847.1955fd23d78.Coremail.wangyuquan1236@phytium.com.cn>
	<20250305141359.00001288@huawei.com>
	<4752672.2b5f.19565e01b65.Coremail.wangyuquan1236@phytium.com.cn>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 5 Mar 2025 18:35:40 +0800
Yuquan Wang <wangyuquan1236@phytium.com.cn> wrote:

> >=20
> > On Tue, 4 Mar 2025 14:22:48 +0800
> > Yuquan Wang <wangyuquan1236@phytium.com.cn> wrote:
> >  =20
> > > >=20
> > > > On Thu, Feb 20, 2025 at 04:12:13PM +0000, Jonathan Cameron wrote:  =
 =20
> > > > > On Mon, 17 Feb 2025 19:20:39 +0800
> > > > > Yuquan Wang <wangyuquan1236@phytium.com.cn> wrote:
> > > > >    =20
> > > > > > Add serial number parameter in the cxl persistent examples.
> > > > > >=20
> > > > > > Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>   =20
> > > > > Looks good.  I've queued it up on my gitlab staging tree, but
> > > > > Michael if you want to pick this one directly that's fine as well=
.   =20
> > > >=20
> > > > See no reason to, I was not even CC'd.   =20
> > >=20
> > > Hi, Michael
> > >=20
> > > I'm sorry, this is my fault. I used "get_maintainer.pl" to check this
> > > patch's maintainers but it shows "No maintainers found, printing rece=
nt
> > > contributors".=20
> > >  =20
> > I usually stage up multiple series together and send on to Michael.
> > So it was be being lazy for a minor change rather than anything much
> > that you did wrong.
> >=20
> > If I get time I'll post a series with this a few other patches
> > later today. =20
> >=20
> > Jonathan
> >  =20
> Thank you!
>=20
> BTW, I found a corner case in CXL numa node creation.
>=20
> Condition:=20
> 1) A UMA/NUMA system without SRAT, but with CEDT.CFMWS
> 2=EF=BC=89Enable CONFIG_ACPI_NUMA
>=20
> Results:
> 1) acpi_numa_init: the fake_pxm will be 0 and send to acpi_parse_cfmws()
> 2=EF=BC=89If dynamically create cxl ram region, the cxl memory would be a=
ssigned
> to node0 rather than a new node
>=20
> Confusions:
> 1) Is a numa system a requirement for CXL memory usage?

Obviously discussion has gone on elsewhere, but I'd say in general it
would be a bad idea to not have an SRAT because the moment we add CXL
it is definitely a NUMA system and we want the Generic Port entry to
allow us to get perf information.

So I wouldn't mind if we fail CXL init in this case, but maybe
it is worth papering over things.

Jonathan


> 2) Should we forbid this situation by adding fake_pxm check and returning
> error in acpi_numa_init()?=20
> 3=EF=BC=89Or we can add some kernel code to allow create these fake nodes=
 on a
> system without SRAT?
>=20
> Yuquan
>=20
>=20
>=20
>=20
>=20
> =E4=BF=A1=E6=81=AF=E5=AE=89=E5=85=A8=E5=A3=B0=E6=98=8E=EF=BC=9A=E6=9C=AC=
=E9=82=AE=E4=BB=B6=E5=8C=85=E5=90=AB=E4=BF=A1=E6=81=AF=E5=BD=92=E5=8F=91=E4=
=BB=B6=E4=BA=BA=E6=89=80=E5=9C=A8=E7=BB=84=E7=BB=87=E6=89=80=E6=9C=89,=E5=
=8F=91=E4=BB=B6=E4=BA=BA=E6=89=80=E5=9C=A8=E7=BB=84=E7=BB=87=E5=AF=B9=E8=AF=
=A5=E9=82=AE=E4=BB=B6=E6=8B=A5=E6=9C=89=E6=89=80=E6=9C=89=E6=9D=83=E5=88=A9=
=E3=80=82=E8=AF=B7=E6=8E=A5=E6=94=B6=E8=80=85=E6=B3=A8=E6=84=8F=E4=BF=9D=E5=
=AF=86,=E6=9C=AA=E7=BB=8F=E5=8F=91=E4=BB=B6=E4=BA=BA=E4=B9=A6=E9=9D=A2=E8=
=AE=B8=E5=8F=AF,=E4=B8=8D=E5=BE=97=E5=90=91=E4=BB=BB=E4=BD=95=E7=AC=AC=E4=
=B8=89=E6=96=B9=E7=BB=84=E7=BB=87=E5=92=8C=E4=B8=AA=E4=BA=BA=E9=80=8F=E9=9C=
=B2=E6=9C=AC=E9=82=AE=E4=BB=B6=E6=89=80=E5=90=AB=E4=BF=A1=E6=81=AF=E3=80=82
> Information Security Notice: The information contained in this mail is so=
lely property of the sender's organization.This mail communication is confi=
dential.Recipients named above are obligated to maintain secrecy and are no=
t permitted to disclose the contents of this communication to others.
