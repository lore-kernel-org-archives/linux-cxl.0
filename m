Received: from tiger.tulip.relay.mailchannels.net (tiger.tulip.relay.mailchannels.net [23.83.218.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC5B29B8E8
	for <linux-cxl@vger.kernel.org>; Wed, 11 Mar 2026 16:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.248
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773247913; cv=pass; b=SokN4/Sh/JnGcM42rbnQSvu8IEmSzVfIRzY57AcedrcuomiCm55xsoYYtV5oHInsxFaxo5ECt/gSoj0SsLGjabCU2WkF9vOM5k+HmIsbAswsAP2AkNk1X800jaf5MoWEZh84S6UXqtAN8kLq57e3AXaKuWumBesaNraqDZ9bH2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773247913; c=relaxed/simple;
	bh=e+Dg34BPic+3UTmxk8h/yZdwwcAnt9JvSsq8U9b9Pxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=stK8NRxo7bGiENuTYN3STxe/ix3l4fNYFTi19fX8tE0PSBEGa9vexH+JLedaZAnYePGKklaWCHrGyLezO/+BXRgalEFEeAIfp9sHBsu549uzEI78IBtZs+MZt3RVoBlvC1Y268hZu+cpR61IRTRq/emP+hSM2pVStdwhC63GngU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=HlbPqW1C; arc=pass smtp.client-ip=23.83.218.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="HlbPqW1C"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 5FA60164A7F;
	Wed, 11 Mar 2026 16:51:46 +0000 (UTC)
Received: from pdx1-sub0-mail-a246.dreamhost.com (100-110-51-207.trex-nlb.outbound.svc.cluster.local [100.110.51.207])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id E7C3A164A21;
	Wed, 11 Mar 2026 16:51:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1773247906;
	b=CUxGqNu1bqD0EkIx29IuD6bupioPclM1wsnnRkBw04GCWeTcYMVOKTDWBH2KScfyvtMvuf
	ceCtablU95dtKP++0GbClIYbTWJJZ+CE3LPFW/cv/x6Wbi4PHPnEH0X/8zGsEEK1q4qgsu
	zV2BsYXWl4J7Wr/eVrRGQ2FvB/sheC4JreoAAK1tz4Z7L6PXdGEVg23gam8VnRLd+u5EvY
	q3nNXNj6mb8yO5P1aXdcK1/QThFbdJjgb+OwdIV1XJv8OnwH4+42k6akzgpkqIr8MDeJAI
	qKN3/SDygSbZ5vnf9T4ExJVSP+dAdjBqbyvQxTWamgbUao36FeRjZmjhRXCnKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1773247906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=oRLj+x8uPDi1mGtq7JjcC1rsstpLtdoVrMOoCW6bb2Q=;
	b=rlKPak94ttTls+Z96UdESB9CKVRpgIi1qMUj8now48r5bmFL5zA+PbQ/O7RnFyC33sobT8
	GqM3HYCwOqGarpog2hQJo117yWU9Mp53p2XHue0xssfXD0lINMBT6BduLhOgVhoBfNI8WO
	rYodoWGXL9m5DuFL1m0Y/iPVLVdD8yxvaQijJmol+2eTqCvzHakiC+rhah3yJA0dDSRuks
	UrhQzHBxdNAtFiNGIJy+Pndt6bR+u9gUxJSGUHRUTv0A5sRm8r58rxEzRTbhMWIzPidsQS
	6cJbip8lQp53v09MfS8B6sSvjw2j/mM15TDRnj8Y/M8GYep/TCqLu9/jsAMlSg==
ARC-Authentication-Results: i=1;
	rspamd-99596b4c6-v74nj;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Bored-Chief: 498696d5048d9b5d_1773247906244_3604954726
X-MC-Loop-Signature: 1773247906244:85354713
X-MC-Ingress-Time: 1773247906244
Received: from pdx1-sub0-mail-a246.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.110.51.207 (trex/7.1.3);
	Wed, 11 Mar 2026 16:51:46 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a246.dreamhost.com (Postfix) with ESMTPSA id 4fWGxF2lzrzyrG;
	Wed, 11 Mar 2026 09:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1773247905;
	bh=oRLj+x8uPDi1mGtq7JjcC1rsstpLtdoVrMOoCW6bb2Q=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=HlbPqW1CXuKn3Xz7LSWRGXXlrxnD1jnezX1gynoLr0yrZCJPigcQszzpVPkO6o/RT
	 L5w04n/+wfhw+M1BQHD/3Dmy7TyRiHq/60uNsh0N73mGKY3etG4AeU4vIfRDACzVX0
	 ZVx9cnGkekFyZmJoT53iD702Z53Zpjuz8IJ876dRIg8zT24gd8iTUHxNQqDkSSudK3
	 44m73Sdg8YCLxeIAQzrEjL/G+UTs/XudTJk8eGwJF0ziGwi45CUokLTVWSYX2bfIXY
	 vjos0G7LIJA2MwE0mkj7tf1NKGUR6FAtCYYKwKL7Z8h7QivguozMkMQxsqZpvFbMD6
	 Zt7orY9K/h6gg==
Date: Wed, 11 Mar 2026 09:51:42 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com
Cc: jonathan.cameron@huawei.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl/mbox: Use proper endpoint validity check upon
 sanitize
Message-ID: <20260311165142.cvrwupy4ptyzpv4k@offworld>
References: <20260301221739.1726722-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260301221739.1726722-1-dave@stgolabs.net>
User-Agent: NeoMutt/20220429

ping? Could this be picked up?

On Sun, 01 Mar 2026, Davidlohr Bueso wrote:

>Fuzzying CXL triggered:
>
>BUG: KASAN: null-ptr-deref in cxl_num_decoders_committed+0x3e/0x80 drivers/cxl/core/port.c:49
>Read of size 4 at addr 0000000000000642 by task syz.0.97/2282
>
>CPU: 2 UID: 0 PID: 2282 Comm: syz.0.97 Not tainted 7.0.0-rc1-gebd11be59f74-dirty #494 PREEMPT(full)
>Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
>Call Trace:
> <TASK>
> __dump_stack lib/dump_stack.c:94 [inline]
> dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
> kasan_report+0xe0/0x110 mm/kasan/report.c:595
> cxl_num_decoders_committed+0x3e/0x80 drivers/cxl/core/port.c:49
> cxl_mem_sanitize+0x141/0x170 drivers/cxl/core/mbox.c:1304
> security_sanitize_store+0xb0/0x120 drivers/cxl/core/memdev.c:173
> dev_attr_store+0x46/0x70 drivers/base/core.c:2437
> sysfs_kf_write+0x95/0xb0 fs/sysfs/file.c:142
> kernfs_fop_write_iter+0x276/0x330 fs/kernfs/file.c:352
> new_sync_write fs/read_write.c:595 [inline]
> vfs_write+0x5df/0xaa0 fs/read_write.c:688
> ksys_write+0x103/0x1f0 fs/read_write.c:740
> do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> do_syscall_64+0x111/0x680 arch/x86/entry/syscall_64.c:94
> entry_SYSCALL_64_after_hwframe+0x77/0x7f
>RIP: 0033:0x7f60a584ba79
>Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
>RSP: 002b:00007f60a42a7038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
>RAX: ffffffffffffffda RBX: 00007f60a5ab5fa0 RCX: 00007f60a584ba79
>RDX: 0000000000000002 RSI: 00002000000001c0 RDI: 0000000000000003
>RBP: 00007f60a58a49df R08: 0000000000000000 R09: 0000000000000000
>R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
>R13: 00007f60a5ab6038 R14: 00007f60a5ab5fa0 R15: 00007ffe58fad8b8
> </TASK>
>
>This goes away using the correct check instead of abusing cxlmd->endpoint,
>which is unusable (ENXIO) until the driver has probed. During that window
>the memdev sysfs attributes are already visible, as soon as device_add()
>completes.
>
>Fixes: 29317f8dc6ed ("cxl/mem: Introduce cxl_memdev_attach for CXL-dependent operation")
>Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
>---
> drivers/cxl/core/mbox.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
>index e7a6452bf544..12386d912705 100644
>--- a/drivers/cxl/core/mbox.c
>+++ b/drivers/cxl/core/mbox.c
>@@ -1301,7 +1301,7 @@ int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd)
>	 * Require an endpoint to be safe otherwise the driver can not
>	 * be sure that the device is unmapped.
>	 */
>-	if (endpoint && cxl_num_decoders_committed(endpoint) == 0)
>+	if (cxlmd->dev.driver && cxl_num_decoders_committed(endpoint) == 0)
>		return __cxl_mem_sanitize(mds, cmd);
>
>	return -EBUSY;
>--
>2.39.5
>
