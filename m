Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8F2388377
	for <linux-cxl@vger.kernel.org>; Mon, 23 Mar 2026 09:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774259510; cv=none; b=Uet1lhkkI5+MQfbGWCXf4hzBeIoFuCN84UQmbsPRhEYfMl1khi98/FFqZF/YPMONuUT4+P/IOtqMBg3mFSYwqnzwP9Mv8wLMJDUFUv5k2tOc9Dkdr8V0Ng4qirxWS3S1liBdSsyFnMJfvOtajLaO+SrZRjl4OLE7W8BbJt71wDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774259510; c=relaxed/simple;
	bh=uJil7NJbOV+0QadkpFuRqq6cw17EPIQpjcIvweZIiOE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=puuJJqpRH6Rtdi+kXLpGoiL9D/wvjrJANpRqCzpH3pR4D7u1PH63o27Z3UiGWqDOhcR2VjaQ/gTeTZ5DEn/BJW2tWgeD+cErxAj53fBvE26ZlXnKM7QJTk6kymOjkeu5jvC8+fNsJdD8tiiZDeqfSocrLWQAPBBMkX9GctNiGVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4ffT2p1rgTzJ468N;
	Mon, 23 Mar 2026 17:51:30 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 4C69B40589;
	Mon, 23 Mar 2026 17:51:35 +0800 (CST)
Received: from localhost (10.203.177.99) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 23 Mar
 2026 09:51:34 +0000
Date: Mon, 23 Mar 2026 09:51:31 +0000
From: Alireza Sanaee <alireza.sanaee@huawei.com>
To: Li Chen <me@linux.beauty>
CC: Jonathan Cameron <jonathan.cameron@huawei.com>, Fan Ni
	<fan.ni@samsung.com>, qemu-devel <qemu-devel@nongnu.org>, linux-cxl
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 0/3] cxl: avoid KVM internal error for fixed memory
 windows
Message-ID: <20260323095131.00006fed.alireza.sanaee@huawei.com>
In-Reply-To: <19d1414db80.826e8bdb1235052.3769762728645896585@linux.beauty>
References: <20260317033304.3185291-1-me@linux.beauty>
	<20260317165702.00003c98@huawei.com>
	<20260318150108.00001a5f.alireza.sanaee@huawei.com>
	<19d1414db80.826e8bdb1235052.3769762728645896585@linux.beauty>
Organization: Huawei
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Sun, 22 Mar 2026 13:46:44 +0800
Li Chen <me@linux.beauty> wrote:

Super!

> Hi Alireza,
>=20
>  ---- On Wed, 18 Mar 2026 23:01:08 +0800  Alireza Sanaee <alireza.sanaee@=
huawei.com> wrote ---=20
>  > On Tue, 17 Mar 2026 16:57:02 +0000
>  > Jonathan Cameron <jonathan.cameron@huawei.com> wrote:
>  >=20
>  > Hi Li,
>  >=20
>  > It looks like what you achieved is quite similar to what I have done i=
n the patchset Jonathan shared earlier.
>  >=20
>  > You have used memory_region_begin_transaction and memory_region_transa=
ction_commit calls that I believe they are useful to be there given other e=
xamples I checked in the qemu code base.
>  >=20
>  > I will be using those calls and will send another version. Also, pleas=
e let me know if that patchset actually addresses your usecase and fix the =
bug you have in the cover letter. =20
> =20
> Yes, exactly! Your patchset addresses my use case issue perfectly. Thank =
you very much for your effort!
>=20
> Regards,
> Li
>=20
>  > Thanks,
>  > Ali
>  >  =20
>  > > On Tue, 17 Mar 2026 11:33:00 +0800
>  > > Li Chen <me@linux.beauty> wrote:
>  > >  =20
>  > > > CXL fixed memory windows are currently modeled as an I/O MemoryReg=
ion.
>  > > > When running under KVM, this makes the entire window look like MMI=
O.
>  > > > If Linux onlines the window as system RAM (e.g. for a CXL Type-3
>  > > > volatile memdev), normal CPU stores into the window trigger KVM
>  > > > instruction emulation. Instructions like XSAVEC are not supported =
by
>  > > > the emulator and abort the VM with a KVM internal error.
>  > > >=20
>  > > > Repro:
>  > > >   - Boot a guest with a CXL Type-3 volatile memdev and a fixed mem=
ory window.
>  > > >   - In the guest, create a RAM region and online it as system RAM:
>  > > >       cxl create-region -m -t ram -d decoder0.0 -w 1 -g 4096 mem0
>  > > >   - QEMU exits with a KVM internal error.   =20
>  > >=20
>  > > Hi Li Chen,
>  > >=20
>  > > At least at first look this looks very like:
>  > >=20
>  > > https://lore.kernel.org/qemu-devel/20260306121151.883-1-alireza.sana=
ee@huawei.com/
>  > >=20
>  > > Which was ready for merge as far as I was concerned, but missed gett=
ing queued for
>  > > 11.0 (as last PCI pull request had gone) and is currently ready to g=
o in next cycle.
>  > >=20
>  > > Please see if that works for your case. If there are improvements I'=
d prefer
>  > > to see them applied on top of that series than reinventing what I th=
ink
>  > > is the same thing.
>  > >=20
>  > > It's not KVM specific as linear mappings (when valid) bring huge per=
formance
>  > > benefits on TCG as well as correctness for KVM.
>  > >=20
>  > > Jonathan
>  > >=20
>  > > +CC linux-cxl which is where CXL folk tend to hang out in larger num=
bers
>  > > than on the qemu list.
>  > >=20
>  > >=20
>  > >  =20
>  > > >=20
>  > > > Serial output excerpt:
>  > > >   KVM internal error. Suberror: 1
>  > > >   extra data[0]: 0x0000000000000001
>  > > >   extra data[1]: 0xc0314061c70f480f
>  > > >   extra data[2]: 0x024080f610478b48
>  > > >   extra data[3]: 0x0000000000000400
>  > > >   extra data[4]: 0x000000010000000f
>  > > >   extra data[5]: 0x00000004a0003140
>  > > >   extra data[6]: 0x0000000000000000
>  > > >   extra data[7]: 0x0000000000000000
>  > > >   emulation failure
>  > > >   RAX=3D0000000000000007 RBX=3Dffff8eace0001a40 RCX=3Dffff8eace000=
3100 RDX=3D0000000000000000
>  > > >   RSI=3D0000000000000007 RDI=3Dffff8eace00030c0 RBP=3Dffffd48ac174=
7c08 RSP=3Dffffd48ac1747bc8
>  > > >   R8 =3D0000000000000007 R9 =3D0000000000000007 R10=3D000000000000=
000d R11=3D0000000000000000
>  > > >   R12=3Dffff8ea945b51a40 R13=3Dffffd48ac166c000 R14=3D000000000000=
0000 R15=3D0000000001200000
>  > > >   RIP=3Dffffffffaf77a14d RFL=3D00000256 [---ZAP-] CPL=3D0 II=3D0 A=
20=3D1 SMM=3D0 HLT=3D0
>  > > >   ES =3D0000 0000000000000000 00000000 00000000
>  > > >   CS =3D0010 0000000000000000 ffffffff 00a09b00 DPL=3D0 CS64 [-RA]
>  > > >   SS =3D0018 0000000000000000 ffffffff 00c09300 DPL=3D0 DS   [-WA]
>  > > >   DS =3D0000 0000000000000000 00000000 00000000
>  > > >   FS =3D0000 00007f997da3fec0 00000000 00000000
>  > > >   GS =3D0000 ffff8eab0535d000 00000000 00000000
>  > > >   LDT=3D0000 fffffe7600000000 00000000 00000000
>  > > >   TR =3D0040 fffffe767cf8f000 00004087 00008b00 DPL=3D0 TSS64-busy
>  > > >   GDT=3D     fffffe767cf8d000 0000007f
>  > > >   IDT=3D     fffffe0000000000 00000fff
>  > > >   CR0=3D80050033 CR2=3D000055fd193a6468 CR3=3D000000010930c000 CR4=
=3D00350ef0
>  > > >   DR0=3D0000000000000000 DR1=3D0000000000000000 DR2=3D000000000000=
0000 DR3=3D0000000000000000
>  > > >   DR6=3D00000000ffff0ff0 DR7=3D0000000000000400
>  > > >   EFER=3D0000000000001d01
>  > > >   Code=3D0f 1f 44 00 00 48 8b 4f 10 48 8b 41 08 48 89 c2 48 c1 ea =
20 <48> 0f c7 61 40 31 c0 48 8b 47 10 f6 80 40 02 00 00 c0 74 1e 48 8b 05 9=
8 f8 e8 01 48 89 47
>  > > >=20
>  > > > This series keeps the existing MMIO dispatcher, but turns the fixed
>  > > > window into a container and (when the window maps linearly to a Ty=
pe-3
>  > > > volatile memdev) overlays a RAM alias so KVM can create a memslot =
for
>  > > > the range. The mapping is updated when HDM decoders are
>  > > > committed/uncommitted by the guest.
>  > > >=20
>  > > > This patchset is based on master branch 559919ce54927d59b215a4665e=
da7ab6118a48aa
>  > > >=20
>  > > > Local validation on this base confirmed that the issue reproduces
>  > > > without the series and is fixed with the 3 patches below.
>  > > >=20
>  > > > Li Chen (3):
>  > > >   cxl/type3: expose vmem mapping for fixed windows
>  > > >   cxl: alias fixed memory windows to RAM under KVM
>  > > >   cxl: update fixed window mappings on decoder programming
>  > > >=20
>  > > >  hw/cxl/cxl-component-utils.c |   2 +
>  > > >  hw/cxl/cxl-host-stubs.c      |   1 +
>  > > >  hw/cxl/cxl-host.c            | 189 ++++++++++++++++++++++++++++++=
++++-
>  > > >  hw/mem/cxl_type3.c           |  59 +++++++++++
>  > > >  include/hw/cxl/cxl.h         |   5 +
>  > > >  include/hw/cxl/cxl_device.h  |   3 +
>  > > >  include/hw/cxl/cxl_host.h    |   1 +
>  > > >  7 files changed, 258 insertions(+), 2 deletions(-)
>  > > >    =20
>  > >  =20
>  >=20
>  >  =20
> Regards,
>=20
> Li=E2=80=8B
>=20

