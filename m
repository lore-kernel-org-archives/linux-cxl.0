Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9205F433CB
	for <linux-cxl@vger.kernel.org>; Fri,  4 Apr 2025 15:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743778987; cv=none; b=btgiXFEd4yxyl+zj8yvemGIcO7g9OgDbvKXumyaaCwx2B6lU9U9z71Ev7ttWlGVTOXRdXiDg2bs7GP5TxKSTnl9yKldg9cnOb4zyEK1sOXuUQnWJG0AX6XkIh+i2ssuxCGPoYAsjinHiDcLH0HlLO3E8LJIDR+FUQriBDDsaqnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743778987; c=relaxed/simple;
	bh=rXD92+jWCkDuXTv9QUxmJmRa7h3Sio2avqryl/5gPEA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OKKjgZsLiRf8pM0NVV4y6pJm38ulY4WYzGrXrzhnjqjhEbO6PvRIwPZIKHSrciEO7+WLyRdDHSdMA0SnqnNFQlLyv9AKV63D+K9z0apdKZBDdXqY4b1v6edtc/0n9H18ClCwHG+fCEp3+8WqJ5izrAIvikIgcyQzt0CgSJs4tFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZThZv6MWWz6M4XQ;
	Fri,  4 Apr 2025 22:59:19 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id CC53A14062A;
	Fri,  4 Apr 2025 23:03:01 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 4 Apr
 2025 17:03:01 +0200
Date: Fri, 4 Apr 2025 16:02:59 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] docs/cxl: Add serial number for persistent-memdev
Message-ID: <20250404160259.00004c75@huawei.com>
In-Reply-To: <243092c2.4d3c.195cc474586.Coremail.wangyuquan1236@phytium.com.cn>
References: <20250217112039.138650-1-wangyuquan1236@phytium.com.cn>
	<20250220161213.000049a9@huawei.com>
	<20250221065509-mutt-send-email-mst@kernel.org>
	<17b91a9f.2847.1955fd23d78.Coremail.wangyuquan1236@phytium.com.cn>
	<20250305141359.00001288@huawei.com>
	<4752672.2b5f.19565e01b65.Coremail.wangyuquan1236@phytium.com.cn>
	<20250312181035.00006e32@huawei.com>
	<243092c2.4d3c.195cc474586.Coremail.wangyuquan1236@phytium.com.cn>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 25 Mar 2025 15:49:37 +0800
Yuquan Wang <wangyuquan1236@phytium.com.cn> wrote:

> > -----=E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6-----
> > =E5=8F=91=E4=BB=B6=E4=BA=BA: "Jonathan Cameron" <Jonathan.Cameron@huawe=
i.com>
> > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4:2025-03-13 02:10:35 (=E6=98=9F=E6=
=9C=9F=E5=9B=9B)
> > =E6=94=B6=E4=BB=B6=E4=BA=BA: "Yuquan Wang" <wangyuquan1236@phytium.com.=
cn>
> > =E6=8A=84=E9=80=81: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org
> > =E4=B8=BB=E9=A2=98: Re: [PATCH] docs/cxl: Add serial number for persist=
ent-memdev
> >=20
> > On Wed, 5 Mar 2025 18:35:40 +0800
> > Yuquan Wang <wangyuquan1236@phytium.com.cn> wrote:
> >  =20
> > > >=20
> > > > On Tue, 4 Mar 2025 14:22:48 +0800
> > > > Yuquan Wang <wangyuquan1236@phytium.com.cn> wrote:
> > > >    =20
> > > > > >=20
> > > > > > On Thu, Feb 20, 2025 at 04:12:13PM +0000, Jonathan Cameron wrot=
e:     =20
> > > > > > > On Mon, 17 Feb 2025 19:20:39 +0800
> > > > > > > Yuquan Wang <wangyuquan1236@phytium.com.cn> wrote:
> > > > > > >      =20
> > > > > > > > Add serial number parameter in the cxl persistent examples.
> > > > > > > >=20
> > > > > > > > Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn> =
    =20
> > > > > > > Looks good.  I've queued it up on my gitlab staging tree, but
> > > > > > > Michael if you want to pick this one directly that's fine as =
well.     =20
> > > > > >=20
> > > > > > See no reason to, I was not even CC'd.     =20
> > > > >=20
> > > > > Hi, Michael
> > > > >=20
> > > > > I'm sorry, this is my fault. I used "get_maintainer.pl" to check =
this
> > > > > patch's maintainers but it shows "No maintainers found, printing =
recent
> > > > > contributors".=20
> > > > >    =20
> > > > I usually stage up multiple series together and send on to Michael.
> > > > So it was be being lazy for a minor change rather than anything much
> > > > that you did wrong.
> > > >=20
> > > > If I get time I'll post a series with this a few other patches
> > > > later today. =20
> > > >=20
> > > > Jonathan
> > > >    =20
> > > Thank you!
> > >=20
> > > BTW, I found a corner case in CXL numa node creation.
> > >=20
> > > Condition:=20
> > > 1) A UMA/NUMA system without SRAT, but with CEDT.CFMWS
> > > 2=EF=BC=89Enable CONFIG_ACPI_NUMA
> > >=20
> > > Results:
> > > 1) acpi_numa_init: the fake_pxm will be 0 and send to acpi_parse_cfmw=
s()
> > > 2=EF=BC=89If dynamically create cxl ram region, the cxl memory would =
be assigned
> > > to node0 rather than a new node
> > >=20
> > > Confusions:
> > > 1) Is a numa system a requirement for CXL memory usage? =20
> >=20
> > Obviously discussion has gone on elsewhere, but I'd say in general it
> > would be a bad idea to not have an SRAT because the moment we add CXL
> > it is definitely a NUMA system and we want the Generic Port entry to
> > allow us to get perf information.
> >=20
> > So I wouldn't mind if we fail CXL init in this case, but maybe
> > it is worth papering over things.
> >=20
> > Jonathan
> >  =20
>=20
> Hi, Jonathan
>=20
> Recentlty I managed to do some hot-plug tests on cxl type3 device on QEMU.
> I tried use "device add" qemu command in monitor, but it failed. I also u=
sed
> unbind/bind cxl_pci driver in sysfs, I can see the software flow on devic=
e but
> no expected actions on cxl root ports linked(like pcie hot-plug interrupt=
 and
> so on).
>=20
> Could we simulate a hot-add flow of type3 device in qemu now? Maybe I use=
d the
> wrong method :(

Only tweaks needed should be to set hotplug=3Dtrue for the root port or swi=
tch
downstream ports and then via the qemu monitor something like:
device_add cxl-type3,bus_cxl_rp_port1,volatile-memdev=3Dcxl-mem3,id=3Dcxl-m=
emD,sn=3D5
and you should see hotplug occur.

I just tested this on an arm64 setup (using my staging tree) but shouldn't
make any real difference as all native hotplug flows.

 pcieport 0000:0c:01.0: pciehp: Slot(3): Button press: will power on in 5 s=
ec
 pcieport 0000:0c:01.0: pciehp: Slot(3): Card present
 pcieport 0000:0c:01.0: pciehp: Slot(3): Link Up
 pci 0000:0e:00.0: [8086:0d93] type 00 class 0x050210 PCIe Endpoint
 pci 0000:0e:00.0: BAR 0 [mem 0x00000000-0x0000ffff 64bit]
 pci 0000:0e:00.0: BAR 2 [mem 0x00000000-0x0003ffff 64bit]
 pci 0000:0e:00.0: BAR 4 [mem 0x00000000-0x00000fff]
 pci 0000:0e:00.0: enabling Extended Tags
 pcieport 0000:0c:01.0: bridge window [io  0x1000-0x0fff] to [bus 0e] add_s=
ize 1000
 pcieport 0000:0c:01.0: bridge window [mem 0x00100000-0x000fffff 64bit pref=
] to [bus 0e] add_size 200000 add_align 100000
 pcieport 0000:0c:01.0: bridge window [mem size 0x00200000 64bit pref]: can=
't assign; no space
 pcieport 0000:0c:01.0: bridge window [mem size 0x00200000 64bit pref]: fai=
led to assign
 pcieport 0000:0c:01.0: bridge window [io  size 0x1000]: can't assign; no s=
pace
 pcieport 0000:0c:01.0: bridge window [io  size 0x1000]: failed to assign
 pcieport 0000:0c:01.0: bridge window [mem size 0x00200000 64bit pref]: can=
't assign; no space
 pcieport 0000:0c:01.0: bridge window [mem size 0x00200000 64bit pref]: fai=
led to assign
 pcieport 0000:0c:01.0: bridge window [io  size 0x1000]: can't assign; no s=
pace
 pcieport 0000:0c:01.0: bridge window [io  size 0x1000]: failed to assign
 pci 0000:0e:00.0: BAR 2 [mem 0x20000000-0x2003ffff 64bit]: assigned
 pci 0000:0e:00.0: BAR 0 [mem 0x20040000-0x2004ffff 64bit]: assigned
 pci 0000:0e:00.0: BAR 4 [mem 0x20050000-0x20050fff]: assigned
 pcieport 0000:0c:01.0: PCI bridge to [bus 0e]
 pcieport 0000:0c:01.0:   bridge window [mem 0x20000000-0x27ffffff]
 cxl_pci 0000:0e:00.0: enabling device (0000 -> 0002)

Whilst there are some corners where resource assignment actually fails
(various fixes have merged recently so maybe that all works now).
In this case it succeeds after a few tries (it reduces the requested
padding in this case I think but I haven't chased this one through).

If you are still having trouble I can fire up a test case on x86 but
probably not today.

Jonathan



>=20
> Yuquan
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
