Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED82379EFD
	for <linux-cxl@vger.kernel.org>; Wed, 18 Mar 2026 08:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773824009; cv=none; b=Fk8jQ0jqKqhsHwfUY1JvzQ7k7C7DT6aC/yqpA9yQLJ2uOsFc/k7arsFbAPSkfa9e+eFX/x4SR1hQT1PTCPBFRuSHbKOyVHhaTJuKVetDILEJ3stFJBE3pdXhP6Lzh5A5wltPfHUF4jTfgLvjaVmry0/UOymJM0eO0LmZ+C6QsU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773824009; c=relaxed/simple;
	bh=tySWRLoOAazTnWtxZ0D5d9/DGFBvSBZ8cCNPePrGITQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GuYve3ksImk77VjQzedUl1YHvZXtxoSRj+NNVPgXF7/OBxU+68NaggpL4+fklblbfwYJh4HM1j7oOmgR3sHtbO/dhcZkV7CGcYZqm2aX5xJZJeakYnbAKjcexwfXwon1PDXtZvafujpJcuzKaEE2evrzKIxbPuR9I5ks8M3no8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fbMyx5bBFzJ46lh;
	Wed, 18 Mar 2026 16:52:25 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 3EFC940086;
	Wed, 18 Mar 2026 16:53:23 +0800 (CST)
Received: from localhost (10.48.158.204) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 18 Mar
 2026 08:53:22 +0000
Date: Wed, 18 Mar 2026 08:53:21 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl/mbox: Use proper endpoint validity check upon
 sanitize
Message-ID: <20260318085321.000041c2@huawei.com>
In-Reply-To: <c9eafdbf-52c8-4578-8928-bf6bd08d114a@intel.com>
References: <20260301221739.1726722-1-dave@stgolabs.net>
	<20260311165142.cvrwupy4ptyzpv4k@offworld>
	<c9eafdbf-52c8-4578-8928-bf6bd08d114a@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Wed, 11 Mar 2026 11:09:06 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> On 3/11/26 9:51 AM, Davidlohr Bueso wrote:
> > ping? Could this be picked up? =20
>=20
> I'm waiting on Jonathan's tag since he reviewed it. Can you address his q=
uestion?
> https://lore.kernel.org/linux-cxl/20260311165142.cvrwupy4ptyzpv4k@offworl=
d/T/#mc95e8945bebd9fac8ff7d82fc73259b0410e4a08
> =20
As discussed last night I'm fine with Davidlohr's observation
the pattern is common enough already that adding a comment for just
this one seems silly.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

>=20
> >=20
> > On Sun, 01 Mar 2026, Davidlohr Bueso wrote:
> >  =20
> >> Fuzzying CXL triggered:
> >>
> >> BUG: KASAN: null-ptr-deref in cxl_num_decoders_committed+0x3e/0x80 dri=
vers/cxl/core/port.c:49
> >> Read of size 4 at addr 0000000000000642 by task syz.0.97/2282
> >>
> >> CPU: 2 UID: 0 PID: 2282 Comm: syz.0.97 Not tainted 7.0.0-rc1-gebd11be5=
9f74-dirty #494 PREEMPT(full)
> >> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.17.0-0-=
gb52ca86e094d-prebuilt.qemu.org 04/01/2014
> >> Call Trace:
> >> <TASK>
> >> __dump_stack lib/dump_stack.c:94 [inline]
> >> dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
> >> kasan_report+0xe0/0x110 mm/kasan/report.c:595
> >> cxl_num_decoders_committed+0x3e/0x80 drivers/cxl/core/port.c:49
> >> cxl_mem_sanitize+0x141/0x170 drivers/cxl/core/mbox.c:1304
> >> security_sanitize_store+0xb0/0x120 drivers/cxl/core/memdev.c:173
> >> dev_attr_store+0x46/0x70 drivers/base/core.c:2437
> >> sysfs_kf_write+0x95/0xb0 fs/sysfs/file.c:142
> >> kernfs_fop_write_iter+0x276/0x330 fs/kernfs/file.c:352
> >> new_sync_write fs/read_write.c:595 [inline]
> >> vfs_write+0x5df/0xaa0 fs/read_write.c:688
> >> ksys_write+0x103/0x1f0 fs/read_write.c:740
> >> do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >> do_syscall_64+0x111/0x680 arch/x86/entry/syscall_64.c:94
> >> entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >> RIP: 0033:0x7f60a584ba79
> >> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 8=
9 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0=
 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> >> RSP: 002b:00007f60a42a7038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> >> RAX: ffffffffffffffda RBX: 00007f60a5ab5fa0 RCX: 00007f60a584ba79
> >> RDX: 0000000000000002 RSI: 00002000000001c0 RDI: 0000000000000003
> >> RBP: 00007f60a58a49df R08: 0000000000000000 R09: 0000000000000000
> >> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> >> R13: 00007f60a5ab6038 R14: 00007f60a5ab5fa0 R15: 00007ffe58fad8b8
> >> </TASK>
> >>
> >> This goes away using the correct check instead of abusing cxlmd->endpo=
int,
> >> which is unusable (ENXIO) until the driver has probed. During that win=
dow
> >> the memdev sysfs attributes are already visible, as soon as device_add=
()
> >> completes.
> >>
> >> Fixes: 29317f8dc6ed ("cxl/mem: Introduce cxl_memdev_attach for CXL-dep=
endent operation")
> >> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> >> ---
> >> drivers/cxl/core/mbox.c | 2 +-
> >> 1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> >> index e7a6452bf544..12386d912705 100644
> >> --- a/drivers/cxl/core/mbox.c
> >> +++ b/drivers/cxl/core/mbox.c
> >> @@ -1301,7 +1301,7 @@ int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u=
16 cmd)
> >> =A0=A0=A0=A0 * Require an endpoint to be safe otherwise the driver can=
 not
> >> =A0=A0=A0=A0 * be sure that the device is unmapped.
> >> =A0=A0=A0=A0 */
> >> -=A0=A0=A0 if (endpoint && cxl_num_decoders_committed(endpoint) =3D=3D=
 0)
> >> +=A0=A0=A0 if (cxlmd->dev.driver && cxl_num_decoders_committed(endpoin=
t) =3D=3D 0)
> >> =A0=A0=A0=A0=A0=A0=A0 return __cxl_mem_sanitize(mds, cmd);
> >>
> >> =A0=A0=A0=A0return -EBUSY;
> >> --=20
> >> 2.39.5
> >> =20
>=20
>=20

