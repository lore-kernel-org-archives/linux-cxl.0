Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C12238C0C
	for <linux-cxl@vger.kernel.org>; Wed, 21 May 2025 08:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747816764; cv=none; b=NGkjTOgGqGP9qndBwMF/FawWfwBoQDUOWVolDsD9jknxJnrqan5z8tNTyA3kpQMdWFbWmCTtMcHE64u9CvCDjiaXEeZrRJBdOI+/eyWDZ3aGCTQTC9OTOZ0bQymOPUNzdXroAPy52Ej5+lP5ljyvyjL+SHwLWwDCuyU6TBKj1wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747816764; c=relaxed/simple;
	bh=y1CQYPNjB83HkVxuZwoMWkeVuDJBg0aSC/xcBhX2+gI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hCyrg6o4gjdRiYpcz1XyyD5Fx+sMzy9GvMXFqK0ohjLfujitjN/9HGcQs1IGL8FGY4SS12pajS2v/+DpuZnscAV6QfQqYHINn0Y0Z7qLRq7znbgJSbQoOdLxp3c8ZawmOznrC9z22HoDayNXqHHbb+mcqlLmxyPV12qD/6phb3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XfRTgoDr; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XfRTgoDr"
Date: Wed, 21 May 2025 17:39:05 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747816757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=ieJk/o5xDhw4NdIBgtgm+tx7dy70/CCzwmUDFQ+z9TU=;
	b=XfRTgoDrjHCTJ7ovdKaOz6x2A6GvKySbltkthiAOZymvtxckZ38nZCS6z8SV6A3RUUP6Ni
	wNwwQrZ1VUAqgI8aTJqkJwM1Hy0JLzJ9IruqGY2DkjfV8AbKcqwhoLnpmAK+Nme9dVBwCM
	6J2PQnVF1Ceh8Ytli0V6lfeWSNQWhh0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Itaru Kitayama <itaru.kitayama@linux.dev>
To: linux-cxl@vger.kernel.org
Subject: Internal error: Oops: 0000000096000044 [#11]  SMP
Message-ID: <aC2RKceK4HqYEQo/@vm4>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

Hi,
On arm64/virt QEMU, the cxl/next (as of today) kernel prints out Internal errors:

[   80.968299] [     T48] Internal error: Oops: 0000000096000044 [#11]
SMP
[   80.989250] [     T48] Modules linked in: cxl_mock_mem(O) cfg80211
rfkill cxl_test(O) cxl_mem(O) cxl_pmem(O) cxl_acpi(O) cxl_port(O)
cxl_mock(O) libnvdimm encrypted_keys trusted caam_jr caam asn1_encoder
caamhash_desc caamalg_desc error crypto_engine authenc libdes fuse drm
backlight ip_tables x_tables sm3_ce sm3 sha3_ce sha512_ce sha512_arm64
cxl_core(O) fwctl btrfs blake2b_generic xor xor_neon raid6_pq
zstd_compress ipv6
[   80.992210] [     T48] CPU: 1 UID: 0 PID: 48 Comm: kworker/u8:2
Tainted: G      D    O        6.15.0-rc4-00040-g128ad8fa385b #40 PREEMPT
[   80.992791] [     T48] Tainted: [D]=DIE, [O]=OOT_MODULE
[   80.993039] [     T48] Hardware name: QEMU QEMU Virtual Machine, BIOS
2025.02-3ubuntu2 04/04/2025
[   80.993400] [     T48] Workqueue: async async_run_entry_fn
[   80.994718] [     T48] pstate: 61402005 (nZCv daif +PAN -UAO -TCO
+DIT -SSBS BTYPE=--)
[   80.995329] [     T48] pc : cxl_mock_mbox_send+0xec/0x12c0
[cxl_mock_mem]
[   80.995691] [     T48] lr : cxl_internal_send_cmd+0x40/0x104
[cxl_core]
[   80.996189] [     T48] sp : ffff800080d0b9f0
[   80.996380] [     T48] x29: ffff800080d0ba70 x28: fff0000008dd2410
x27: fff00000088fb390
[   80.996714] [     T48] x26: ffff800080d0bb07 x25: 0000000000000100
x24: 0000000000000003
[   80.997135] [     T48] x23: 0000000000000020 x22: fff0000008dd2410
x21: 0000000000000002
[   80.998119] [     T48] x20: fff00000088fb080 x19: ffff800080d0bb08
x18: 00000000ffffffff
[   80.998419] [     T48] x17: 0000000000000000 x16: ffffa8d169128748
x15: ffff800080d0b5ad
[   80.999243] [     T48] x14: ffff800080d0b400 x13: ffff800080d0b5b8
x12: fff000006f7a0000
[   81.000519] [     T48] x11: 0000000000000058 x10: 0000000000000018 x9
: fff000006f7a0000
[   81.001337] [     T48] x8 : ffff800080d0bb48 x7 : fff0000074fa0000 x6
: fff0000074fa0000
[   81.002497] [     T48] x5 : fff000007f937508 x4 : 0000000000000001 x3
: 0000000000001000
[   81.003993] [     T48] x2 : 0000000000001000 x1 : 0000000000000000 x0
: 0000000000000088
[   81.004223] [     T48] Call trace:
[   81.004795] [     T48]  cxl_mock_mbox_send+0xec/0x12c0 [cxl_mock_mem]
(P)
[   81.005136] [     T48]  cxl_internal_send_cmd+0x40/0x104 [cxl_core]
[   81.005520] [     T48]  cxl_mem_get_records_log+0xbc/0x198 [cxl_core]
[   81.006042] [     T48]  cxl_mem_get_event_records+0xb0/0xc0
[cxl_core]
[   81.006246] [     T48]  cxl_mock_mem_probe+0x568/0x6f0 [cxl_mock_mem]
[   81.006417] [     T48]  platform_probe+0x68/0xd8
[   81.008340] [     T48]  really_probe+0xc0/0x39c
[   81.008885] [     T48]  __driver_probe_device+0xd0/0x14c
[   81.009539] [     T48]  driver_probe_device+0x3c/0x120
[   81.010239] [     T48]  __driver_attach_async_helper+0x50/0xec
[   81.011130] [     T48]  async_run_entry_fn+0x34/0x14c
[   81.011276] [     T48]  process_one_work+0x148/0x284
[   81.011420] [     T48]  worker_thread+0x2c4/0x3e0
[   81.011552] [     T48]  kthread+0x12c/0x204
[   81.011693] [     T48]  ret_from_fork+0x10/0x20
[   81.011840] [     T48] Code: 54001b28 a90c6bf9 52801100 f9400a61
(a9007c3f)
[   81.013772] [     T48] ---[ end trace 0000000000000000 ]---

How serious is this?

Thanks,
Itaru.
