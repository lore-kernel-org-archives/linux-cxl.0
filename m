Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCCE1B0406
	for <linux-cxl@vger.kernel.org>; Wed, 12 Mar 2025 23:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741820735; cv=none; b=PBIKj0Ngs3pFPiPk66Xazwc+Rk6/iy+HB1O2cN9ve/GQQhohFGgwCmptJYYd+/16NrgVT/Hs9yo4rKDMiyr3dTmApdfUrq6RScP3JMCDxzzTKuAq3Ej4k8e+30vjs7JY9YczoXktq9Rz+ckYyjkG+EEK4fiRB8goaMXPtBnSA/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741820735; c=relaxed/simple;
	bh=gJYTPMMHqqPpf6/XG7oo3vcSXJl99rzyMwO0M3geexM=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=UxKwQ57B3uAPWDcJxm1k1SvnudhC4X4tScjBAoxZmzdjC28uGZtGZUxYGPtP17TUInmtHGfwj/2CexzZzjvMn2NSHIDrU1Yq6o3Cgux1Y7o4YOhShejvnI+ukvtGV5vZR9j9637qgGa+6DlivsCPDNuTeEqAx7JoRwm/frZqonY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eBuicG0M; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eBuicG0M"
Content-Type: text/plain; charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741820731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/rU/pekjQeIJmW3ZTiIqn/Nt8nU5IRj0lgzZG7hvBR4=;
	b=eBuicG0MtTpacDEuVT6Rd1q39dGSpr2dO9rMbZ3XPuPjkTu5QKuF5AuARjMjBSh3d3L2zq
	7vCpWFOnstUL8D/O3oiHkM3w/nUtIxZ/PrjmtRRGC5FEDP3/6JVsk5rFbv0E0cGTDAYbiQ
	deGTj6CRoXC7nNBqR2RVqf8XyXiS+70=
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Itaru Kitayama <itaru.kitayama@linux.dev>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: CXL -next issue on arm64
Date: Thu, 13 Mar 2025 08:04:55 +0900
Message-Id: <E66E6163-EF8A-41BA-80DB-2479142BCE1D@linux.dev>
References: <2012e5eb-db6c-4982-9f0e-bced465d29c0@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 linux-cxl@vger.kernel.org
In-Reply-To: <2012e5eb-db6c-4982-9f0e-bced465d29c0@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
X-Migadu-Flow: FLOW_OUT

Dave=20

> On Mar 13, 2025, at 0:14, Dave Jiang <dave.jiang@intel.com> wrote:
>=20
> =EF=BB=BF
>=20
>> On 3/11/25 8:56 PM, Itaru Kitayama wrote:
>> Hi Alison,
>> I rebased onto the latest CXL kernel -next this morning and `modprobe cxl=
_test` triggers a NULL pointer dereference see below. I am building a kernel=
 with ACPI_HMAT set to =E2=80=9Cy=E2=80=9D but the FW doesn=E2=80=99t provid=
e the table on my QEMU virt machine.
>>=20
>> Thanks,
>> Itaru.
>>=20
>>=20
>> [  128.095189][  T552] Unable to handle kernel NULL pointer dereference a=
t virtual address 0000000000000000
>> [  128.095629][  T552] Mem abort info:
>> [  128.095703][  T552]   ESR =3D 0x0000000096000044
>> [  128.095789][  T552]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
>> [  128.096320][  T552]   SET =3D 0, FnV =3D 0
>> [  128.096655][  T552]   EA =3D 0, S1PTW =3D 0
>> [  128.096733][  T552]   FSC =3D 0x04: level 0 translation fault
>> [  128.096862][  T552] Data abort info:
>> [  128.096939][  T552]   ISV =3D 0, ISS =3D 0x00000044, ISS2 =3D 0x000000=
00
>> [  128.097042][  T552]   CM =3D 0, WnR =3D 1, TnD =3D 0, TagAccess =3D 0
>> [  128.097149][  T552]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D=
 0
>> [  128.097325][  T552] user pgtable: 4k pages, 52-bit VAs, pgdp=3D0000000=
103981600
>> [  128.098312][  T552] [0000000000000000] pgd=3D080000010f5a6403, p4d=3D0=
000000000000000
>> [  134.299341][  T552] Internal error: Oops: 0000000096000044 [#3] PREEMP=
T SMP
>> [  134.299844][  T552] Modules linked in: cxl_mock_mem(O) cxl_test(O) cxl=
_mem(O) cxl_pmem(O) cxl_acpi(O) cxl_port(O) cxl_mock(O) libnvdimm cxl_core(O=
) sm3_ce sm3 sha3_ce sha512_ce sha512_arm64 button processor cfg80211 rfkill=
 fuse drm backlight ip_tables x_tables ipv6
>> [  134.302032][  T557] cxl_mock_mem cxl_rcd.10: CXL MCE unsupported
>> [  134.302604][  T552] CPU: 1 UID: 0 PID: 552 Comm: kworker/u8:5 Tainted:=
 G      D    O       6.14.0-rc1-00050-gb1eb9579d26a-dirty #103 09186677403f6=
0ca5f8511de95b4969341ca485e
>> [  134.303300][  T552] Tainted: [D]=3DDIE, [O]=3DOOT_MODULE
>> [  134.304067][  T552] Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0=
.0 02/06/2015
>> [  134.304209][  T552] Workqueue: async async_run_entry_fn
>> [  134.304519][  T552] pstate: 61402005 (nZCv daif +PAN -UAO -TCO +DIT -S=
SBS BTYPE=3D--)
>> [  134.304856][  T552] pc : cxl_mock_mbox_send+0x514/0x11dc [cxl_mock_mem=
]
>=20
> Can you run scripts/faddr2line on this and see which line of code triggere=
d it? Thanks!
>=20
> Also a bisect vs 6.14-rc1 would be great if you can pin point which new co=
mmit is causing it.
>=20
> DJ

Sorry I can=E2=80=99t reproduce it now, next time I see it I=E2=80=99ll do w=
hat you suggested with a stack trace.
The latest CXL -next at least boots and I can do: sudo modprobe cxl_test wit=
hout warnings directly related to the cxl test suite on arm64.
I=E2=80=99m using Jonathan=E2=80=99s QEMU for now.

Itaru.
>=20
>> [  134.305024][  T552] lr : cxl_internal_send_cmd+0x40/0x118 [cxl_core]
>> [  134.305566][  T552] sp : ffff800082c5b9e0
>> [  134.305671][  T552] x29: ffff800082c5b9e0 x28: fffeffb34bacd010 x27: f=
ffeffb3434af390
>> [  134.306215][  T552] x26: ffff800082c5bb57 x25: 0000000000000100 x24: 0=
000000000000001
>> [  134.309335][  T552] x23: 0000000000000020 x22: fffeffb34bacd010 x21: f=
ffeffb347f5e080
>> [  134.311287][  T552] x20: fffeffb3434af080 x19: ffff800082c5bb58 x18: 0=
0000000ffffffff
>> [  134.312134][  T552] x17: 0000000000000000 x16: ffffa563f133a508 x15: f=
ffeffb347e3ea1c
>> [  134.313208][  T552] x14: ffffa563f31f4220 x13: 0000000000000040 x12: 0=
000000000000228
>> [  134.313912][  T552] x11: 0000000000000000 x10: ffff5a4f60c1ec20 x9 : 0=
000000000000028
>> [  134.314855][  T552] x8 : ffff800082c5bb98 x7 : 0000000000000003 x6 : 0=
000000000000003
>> [  134.315033][  T552] x5 : fffeffb3437f3540 x4 : 0000000000000001 x3 : 0=
000000000001000
>> [  134.318113][  T552] x2 : 0000000000000070 x1 : 0000000000000000 x0 : 0=
000000000000088
>> [  134.318600][  T552] Call trace:
>> [  134.318680][  T552]  cxl_mock_mbox_send+0x514/0x11dc [cxl_mock_mem 0d1=
3b81331ab9470a26e7387d930d28978595994] (P)
>> [  134.319019][  T552]  cxl_internal_send_cmd+0x40/0x118 [cxl_core 98e800=
07eca5dee8da38639ce9041c6e7bffd043]
>> [  134.322029][  T552]  cxl_mem_get_records_log+0xb8/0x184 [cxl_core 98e8=
0007eca5dee8da38639ce9041c6e7bffd043]
>> [  134.322795][  T552]  cxl_mem_get_event_records+0xb0/0xb8 [cxl_core 98e=
80007eca5dee8da38639ce9041c6e7bffd043]
>> [  134.323051][  T552]  cxl_mock_mem_probe+0x41c/0x46c [cxl_mock_mem 0d13=
b81331ab9470a26e7387d930d28978595994]
>> [  134.323233][  T552]  platform_probe+0x68/0xdc
>> [  134.323473][  T552]  really_probe+0xc0/0x388
>> [  134.323967][  T552]  __driver_probe_device+0x7c/0x15c
>> [  134.324085][  T552]  driver_probe_device+0x40/0x114
>> [  134.324599][  T552]  __driver_attach_async_helper+0x50/0xec
>> [  134.325234][  T552]  async_run_entry_fn+0x34/0x14c
>> [  134.326457][  T552]  process_one_work+0x150/0x294
>> [  134.326631][  T552]  worker_thread+0x2dc/0x3dc
>> [  134.326729][  T552]  kthread+0x130/0x204
>> [  134.326947][  T552]  ret_from_fork+0x10/0x20
>> [  134.327113][  T552] Code: 540010a8 f9400a61 52801100 d2800e02 (a9007c3=
f)
>> [  134.327240][  T552] ---[ end trace 0000000000000000 ]---
>> [  134.619427][  T557] Unable to handle kernel NULL pointer dereference a=
t virtual address 0000000000000000
>> [  134.633336][  T557] Mem abort info:
>> [  134.644018][  T557]   ESR =3D 0x0000000096000044
>> [  134.668786][  T557]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
>> [  134.672231][  T557]   SET =3D 0, FnV =3D 0
>> [  134.701787][  T557]   EA =3D 0, S1PTW =3D 0
>> [  134.705094][  T557]   FSC =3D 0x04: level 0 translation fault
>> [  134.705227][  T557] Data abort info:
>> [  134.705299][  T557]   ISV =3D 0, ISS =3D 0x00000044, ISS2 =3D 0x000000=
00
>> [  134.705562][  T557]   CM =3D 0, WnR =3D 1, TnD =3D 0, TagAccess =3D 0
>> [  134.723727][  T557]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D=
 0
>> [  134.786343][  T557] user pgtable: 4k pages, 52-bit VAs, pgdp=3D0000000=
101734880
>> [  134.791824][  T557] [0000000000000000] pgd=3D08000001019e9403, p4d=3D0=
000000000000000
>=20
