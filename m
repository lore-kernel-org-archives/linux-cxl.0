Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6960F222562
	for <linux-cxl@vger.kernel.org>; Wed, 21 May 2025 15:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747841792; cv=none; b=Ng87jU9ZC0V4OMfnfRGaU5hYR9jB5VWLsGE/wHJu/bWjPxAuIkO4F+HoY2jZmRO6DF+2uGfGk4hajhRYrGkM2+4hp2W1krJPWIrKgFOIXVIwU4ZmTDAo9n6YUm8n+0aYbz0ZLb7vlSPLtuy/SbXjg/A0H55wp6RkGmBSfE0Vp3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747841792; c=relaxed/simple;
	bh=ePRqwbTrvoa75+LFeGmiaKqbFCqIqYAoJ9w4x7FIFhw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a0Uk9jCvnRAR4jAo/HkL53M1dzUL059eAQV7xvoqV6EpaY+cH7JUalC9muvIiMRzW/q+j3ABbzXFIIDneegtqpWvntnGTu/o9+l2NGliM+ESNuW5nU11iuPazZDJuJKNjbewiA9HJPDj+wjKuJQMCgv6a9k2lD+grNZjnWFCR/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b2b6J1xsCz6H7lx;
	Wed, 21 May 2025 23:33:12 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 03BB11404F4;
	Wed, 21 May 2025 23:36:24 +0800 (CST)
Received: from localhost (10.195.34.206) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 21 May
 2025 17:36:23 +0200
Date: Wed, 21 May 2025 16:36:21 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Itaru Kitayama <itaru.kitayama@linux.dev>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: Internal error: Oops: 0000000096000044 [#11]  SMP
Message-ID: <20250521163621.000013b6@huawei.com>
In-Reply-To: <aC2RKceK4HqYEQo/@vm4>
References: <aC2RKceK4HqYEQo/@vm4>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 21 May 2025 17:39:05 +0900
Itaru Kitayama <itaru.kitayama@linux.dev> wrote:

> Hi,
> On arm64/virt QEMU, the cxl/next (as of today) kernel prints out Internal errors:
> 
> [   80.968299] [     T48] Internal error: Oops: 0000000096000044 [#11]
> SMP
> [   80.989250] [     T48] Modules linked in: cxl_mock_mem(O) cfg80211
> rfkill cxl_test(O) cxl_mem(O) cxl_pmem(O) cxl_acpi(O) cxl_port(O)
> cxl_mock(O) libnvdimm encrypted_keys trusted caam_jr caam asn1_encoder
> caamhash_desc caamalg_desc error crypto_engine authenc libdes fuse drm
> backlight ip_tables x_tables sm3_ce sm3 sha3_ce sha512_ce sha512_arm64
> cxl_core(O) fwctl btrfs blake2b_generic xor xor_neon raid6_pq
> zstd_compress ipv6
> [   80.992210] [     T48] CPU: 1 UID: 0 PID: 48 Comm: kworker/u8:2
> Tainted: G      D    O        6.15.0-rc4-00040-g128ad8fa385b #40 PREEMPT
> [   80.992791] [     T48] Tainted: [D]=DIE, [O]=OOT_MODULE
> [   80.993039] [     T48] Hardware name: QEMU QEMU Virtual Machine, BIOS
> 2025.02-3ubuntu2 04/04/2025
> [   80.993400] [     T48] Workqueue: async async_run_entry_fn
> [   80.994718] [     T48] pstate: 61402005 (nZCv daif +PAN -UAO -TCO
> +DIT -SSBS BTYPE=--)
> [   80.995329] [     T48] pc : cxl_mock_mbox_send+0xec/0x12c0
> [cxl_mock_mem]
> [   80.995691] [     T48] lr : cxl_internal_send_cmd+0x40/0x104
> [cxl_core]
> [   80.996189] [     T48] sp : ffff800080d0b9f0
> [   80.996380] [     T48] x29: ffff800080d0ba70 x28: fff0000008dd2410
> x27: fff00000088fb390
> [   80.996714] [     T48] x26: ffff800080d0bb07 x25: 0000000000000100
> x24: 0000000000000003
> [   80.997135] [     T48] x23: 0000000000000020 x22: fff0000008dd2410
> x21: 0000000000000002
> [   80.998119] [     T48] x20: fff00000088fb080 x19: ffff800080d0bb08
> x18: 00000000ffffffff
> [   80.998419] [     T48] x17: 0000000000000000 x16: ffffa8d169128748
> x15: ffff800080d0b5ad
> [   80.999243] [     T48] x14: ffff800080d0b400 x13: ffff800080d0b5b8
> x12: fff000006f7a0000
> [   81.000519] [     T48] x11: 0000000000000058 x10: 0000000000000018 x9
> : fff000006f7a0000
> [   81.001337] [     T48] x8 : ffff800080d0bb48 x7 : fff0000074fa0000 x6
> : fff0000074fa0000
> [   81.002497] [     T48] x5 : fff000007f937508 x4 : 0000000000000001 x3
> : 0000000000001000
> [   81.003993] [     T48] x2 : 0000000000001000 x1 : 0000000000000000 x0
> : 0000000000000088
> [   81.004223] [     T48] Call trace:
> [   81.004795] [     T48]  cxl_mock_mbox_send+0xec/0x12c0 [cxl_mock_mem]
> (P)
> [   81.005136] [     T48]  cxl_internal_send_cmd+0x40/0x104 [cxl_core]
> [   81.005520] [     T48]  cxl_mem_get_records_log+0xbc/0x198 [cxl_core]
> [   81.006042] [     T48]  cxl_mem_get_event_records+0xb0/0xc0
> [cxl_core]
> [   81.006246] [     T48]  cxl_mock_mem_probe+0x568/0x6f0 [cxl_mock_mem]
> [   81.006417] [     T48]  platform_probe+0x68/0xd8
> [   81.008340] [     T48]  really_probe+0xc0/0x39c
> [   81.008885] [     T48]  __driver_probe_device+0xd0/0x14c
> [   81.009539] [     T48]  driver_probe_device+0x3c/0x120
> [   81.010239] [     T48]  __driver_attach_async_helper+0x50/0xec
> [   81.011130] [     T48]  async_run_entry_fn+0x34/0x14c
> [   81.011276] [     T48]  process_one_work+0x148/0x284
> [   81.011420] [     T48]  worker_thread+0x2c4/0x3e0
> [   81.011552] [     T48]  kthread+0x12c/0x204
> [   81.011693] [     T48]  ret_from_fork+0x10/0x20
> [   81.011840] [     T48] Code: 54001b28 a90c6bf9 52801100 f9400a61
> (a9007c3f)
> [   81.013772] [     T48] ---[ end trace 0000000000000000 ]---
> 
> How serious is this?
> 

Definitely not encouraging.  I'll see if I can replicate.
I had a suitable x86 config ready and not seeing it there.

Jonathan

> Thanks,
> Itaru.
> 
> 

