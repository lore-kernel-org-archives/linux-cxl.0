Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CCA146A68
	for <linux-cxl@vger.kernel.org>; Wed, 12 Mar 2025 03:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741751792; cv=none; b=ixn7wpWvs3EUakFGqCdmGEVMpIPXmaO2mcTsU14CabWLxNu5W8PyE3BhOlijIGLkvj1XM/1GhTEApqWrSrwnWQyzJCLB2oWdmN121+4aAeWvJsETvK7jIQGy35sF36kfgMS562HoPB32RPQGRTlbRgCf1RKemRo19HfxxBH2khE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741751792; c=relaxed/simple;
	bh=YV5c9I2KGBcWxVEUn+sZKE68pJf9dGVd8cGjXX0vWLM=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=LOkLVUrqCiz+JdXFaUl1Z97PpPh+jpjup4NG1cNgWQYGVuclgjFbPqWbEyP17eYn/5gqR3g7wZGGsR65YjZSCsOL2YhA5vYGWQxf6Kr/eiQQgxmF28L0p2j0jyI0VT7cBPRU6fFDE8q15wQltlurQLV7FX4I6xCPjFXFFCvU6xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=isWCL3Q9; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="isWCL3Q9"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741751787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=auV39a5GuOwACZTN2mqjdeu7C9K+VJpSJrR9evt/4oc=;
	b=isWCL3Q91xgN7tV6hrQpUaHgJx0R4NmrI4BiqaJEywsgucS4N+Qa03tw7uBHO9WQjgs7T7
	Dym3K9k6L0m19CXAFCFgsFKlVuf8hEwmf7/aDQD1TtWsAZXeKyoj5aRTfv9QjVZVXpGf+c
	+cRTZq2KpMSuPnMhkND8fVagovd913Y=
From: Itaru Kitayama <itaru.kitayama@linux.dev>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: CXL -next issue on arm64
Message-Id: <49A4B521-AB66-4037-A23D-1D0D7AF0F42F@linux.dev>
Date: Wed, 12 Mar 2025 12:56:01 +0900
Cc: linux-cxl@vger.kernel.org
To: Alison Schofield <alison.schofield@intel.com>
X-Migadu-Flow: FLOW_OUT

Hi Alison,
I rebased onto the latest CXL kernel -next this morning and `modprobe =
cxl_test` triggers a NULL pointer dereference see below. I am building a =
kernel with ACPI_HMAT set to =E2=80=9Cy=E2=80=9D but the FW doesn=E2=80=99=
t provide the table on my QEMU virt machine.

Thanks,
Itaru.
=20

[  128.095189][  T552] Unable to handle kernel NULL pointer dereference =
at virtual address 0000000000000000
[  128.095629][  T552] Mem abort info:
[  128.095703][  T552]   ESR =3D 0x0000000096000044
[  128.095789][  T552]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[  128.096320][  T552]   SET =3D 0, FnV =3D 0
[  128.096655][  T552]   EA =3D 0, S1PTW =3D 0
[  128.096733][  T552]   FSC =3D 0x04: level 0 translation fault
[  128.096862][  T552] Data abort info:
[  128.096939][  T552]   ISV =3D 0, ISS =3D 0x00000044, ISS2 =3D =
0x00000000
[  128.097042][  T552]   CM =3D 0, WnR =3D 1, TnD =3D 0, TagAccess =3D 0
[  128.097149][  T552]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D =
0
[  128.097325][  T552] user pgtable: 4k pages, 52-bit VAs, =
pgdp=3D0000000103981600
[  128.098312][  T552] [0000000000000000] pgd=3D080000010f5a6403, =
p4d=3D0000000000000000
[  134.299341][  T552] Internal error: Oops: 0000000096000044 [#3] =
PREEMPT SMP
[  134.299844][  T552] Modules linked in: cxl_mock_mem(O) cxl_test(O) =
cxl_mem(O) cxl_pmem(O) cxl_acpi(O) cxl_port(O) cxl_mock(O) libnvdimm =
cxl_core(O) sm3_ce sm3 sha3_ce sha512_ce sha512_arm64 button processor =
cfg80211 rfkill fuse drm backlight ip_tables x_tables ipv6
[  134.302032][  T557] cxl_mock_mem cxl_rcd.10: CXL MCE unsupported
[  134.302604][  T552] CPU: 1 UID: 0 PID: 552 Comm: kworker/u8:5 =
Tainted: G      D    O       6.14.0-rc1-00050-gb1eb9579d26a-dirty #103 =
09186677403f60ca5f8511de95b4969341ca485e
[  134.303300][  T552] Tainted: [D]=3DDIE, [O]=3DOOT_MODULE
[  134.304067][  T552] Hardware name: QEMU QEMU Virtual Machine, BIOS =
0.0.0 02/06/2015
[  134.304209][  T552] Workqueue: async async_run_entry_fn
[  134.304519][  T552] pstate: 61402005 (nZCv daif +PAN -UAO -TCO +DIT =
-SSBS BTYPE=3D--)
[  134.304856][  T552] pc : cxl_mock_mbox_send+0x514/0x11dc =
[cxl_mock_mem]
[  134.305024][  T552] lr : cxl_internal_send_cmd+0x40/0x118 [cxl_core]
[  134.305566][  T552] sp : ffff800082c5b9e0
[  134.305671][  T552] x29: ffff800082c5b9e0 x28: fffeffb34bacd010 x27: =
fffeffb3434af390
[  134.306215][  T552] x26: ffff800082c5bb57 x25: 0000000000000100 x24: =
0000000000000001
[  134.309335][  T552] x23: 0000000000000020 x22: fffeffb34bacd010 x21: =
fffeffb347f5e080
[  134.311287][  T552] x20: fffeffb3434af080 x19: ffff800082c5bb58 x18: =
00000000ffffffff
[  134.312134][  T552] x17: 0000000000000000 x16: ffffa563f133a508 x15: =
fffeffb347e3ea1c
[  134.313208][  T552] x14: ffffa563f31f4220 x13: 0000000000000040 x12: =
0000000000000228
[  134.313912][  T552] x11: 0000000000000000 x10: ffff5a4f60c1ec20 x9 : =
0000000000000028
[  134.314855][  T552] x8 : ffff800082c5bb98 x7 : 0000000000000003 x6 : =
0000000000000003
[  134.315033][  T552] x5 : fffeffb3437f3540 x4 : 0000000000000001 x3 : =
0000000000001000
[  134.318113][  T552] x2 : 0000000000000070 x1 : 0000000000000000 x0 : =
0000000000000088
[  134.318600][  T552] Call trace:
[  134.318680][  T552]  cxl_mock_mbox_send+0x514/0x11dc [cxl_mock_mem =
0d13b81331ab9470a26e7387d930d28978595994] (P)
[  134.319019][  T552]  cxl_internal_send_cmd+0x40/0x118 [cxl_core =
98e80007eca5dee8da38639ce9041c6e7bffd043]
[  134.322029][  T552]  cxl_mem_get_records_log+0xb8/0x184 [cxl_core =
98e80007eca5dee8da38639ce9041c6e7bffd043]
[  134.322795][  T552]  cxl_mem_get_event_records+0xb0/0xb8 [cxl_core =
98e80007eca5dee8da38639ce9041c6e7bffd043]
[  134.323051][  T552]  cxl_mock_mem_probe+0x41c/0x46c [cxl_mock_mem =
0d13b81331ab9470a26e7387d930d28978595994]
[  134.323233][  T552]  platform_probe+0x68/0xdc
[  134.323473][  T552]  really_probe+0xc0/0x388
[  134.323967][  T552]  __driver_probe_device+0x7c/0x15c
[  134.324085][  T552]  driver_probe_device+0x40/0x114
[  134.324599][  T552]  __driver_attach_async_helper+0x50/0xec
[  134.325234][  T552]  async_run_entry_fn+0x34/0x14c
[  134.326457][  T552]  process_one_work+0x150/0x294
[  134.326631][  T552]  worker_thread+0x2dc/0x3dc
[  134.326729][  T552]  kthread+0x130/0x204
[  134.326947][  T552]  ret_from_fork+0x10/0x20
[  134.327113][  T552] Code: 540010a8 f9400a61 52801100 d2800e02 =
(a9007c3f)
[  134.327240][  T552] ---[ end trace 0000000000000000 ]---
[  134.619427][  T557] Unable to handle kernel NULL pointer dereference =
at virtual address 0000000000000000
[  134.633336][  T557] Mem abort info:
[  134.644018][  T557]   ESR =3D 0x0000000096000044
[  134.668786][  T557]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[  134.672231][  T557]   SET =3D 0, FnV =3D 0
[  134.701787][  T557]   EA =3D 0, S1PTW =3D 0
[  134.705094][  T557]   FSC =3D 0x04: level 0 translation fault
[  134.705227][  T557] Data abort info:
[  134.705299][  T557]   ISV =3D 0, ISS =3D 0x00000044, ISS2 =3D =
0x00000000
[  134.705562][  T557]   CM =3D 0, WnR =3D 1, TnD =3D 0, TagAccess =3D 0
[  134.723727][  T557]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D =
0
[  134.786343][  T557] user pgtable: 4k pages, 52-bit VAs, =
pgdp=3D0000000101734880
[  134.791824][  T557] [0000000000000000] pgd=3D08000001019e9403, =
p4d=3D0000000000000000=
