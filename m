Received: from bumble.birch.relay.mailchannels.net (bumble.birch.relay.mailchannels.net [23.83.209.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195232C235E
	for <linux-cxl@vger.kernel.org>; Tue, 24 Feb 2026 18:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.209.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771956310; cv=pass; b=fPdzxRmfj86d0iEDPDb98MiLH9raADPV/rrX4eCQGwIQJqtXwaIyiXmA0XihtMFjGx89KSFEiqzzKFMnf5B3SpWPTmHgpuAfZkL4Bpk2/Vxsn11ZTKEtxiizkO5QLhP5AsY7UgF6HkYQRXjc6bPrC+S3gi3ZnJiyjHcMnBDkKTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771956310; c=relaxed/simple;
	bh=2dYh8NqquBoUnnQ0za9zrssS7EQ13uIGEc5cPyJaYNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jV+bu0tL+aOeosiZwvtgkqfOCj0cezB48bb83WNfIhtaLURCBm9PXMhdMEwsLNmDx4UAEDrZfnAiIQ1+srW0FkZdHHt53CXb4q7UkoHql/HimqU+pLOQN4jOGJWGzxMOEDdzcS1FHRYweN8ZHwuFab04UnRIo4cA9M3+XT6nRr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=j2CtPbiD; arc=pass smtp.client-ip=23.83.209.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="j2CtPbiD"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 4538F823143;
	Tue, 24 Feb 2026 18:05:08 +0000 (UTC)
Received: from pdx1-sub0-mail-a239.dreamhost.com (100-104-34-8.trex-nlb.outbound.svc.cluster.local [100.104.34.8])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id BEE45821783;
	Tue, 24 Feb 2026 18:05:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1771956307;
	b=jMircRDVCeyKeTQcciz5B+EPZhj6WzBR+b1B35KBc0p1VOavVBIJqdnkvhHxbqi0vjWPta
	VHIixK0e8jQDT4Qd89ftnEoYxCW/Ih/iU6MloqBOhmhbK54VNT3J4RD/RRXMGTUHpj06as
	f3dCQuwOTCYSBhdkVpto43YEq/xaReOxLa35w5BiR62v6JD4SUfv9SC8RzA7XVgU6Zh6Mi
	9IQM/VBfUM9xuPAijSTM9jCGmlyMroP/K/pDyTjb+O1SfVlk924vqv2HlcgLgevf1dz8T+
	hTJOl9gtNlpgkI9qbDMvZMOsA1iLxIF04cMkH6rdfd7wgwUADvbztf8XF6rl1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1771956307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=YMOTt26XpYwIlITjT0DxXy4VSW/5r5YdPadR7BeEf0I=;
	b=PkRm398DNAM7c/kKS8RtnYrBxJcfSGjW2/eIl6vUlwxnBEZ2EIhMv0yt6nD6RWnw31tkoL
	5rRvLVe4QVhTIAeGt5NNW6S3t0WQA/X+X3NoPPOJWBZvZIxyuIHDrm6LYZfpdk4uVzZRCr
	0ylRosJBhhzWkKZ2gSqW7NWP08TUEy/9so6dAib4oCy4sFFP+Aqcs1JcHthNNdJnVrODH3
	mf2Yk15B1HIafWGfBzULDzDEf0vhMNSuP/+a4qJKyfI3JXaiO/8L//219mJTAS8qhMRzxd
	TUsF4KDxwcA/nWNdwgpbAavKvNlWmg1yWFjQTbFfOibZLsPXwKAqkqfywOVotw==
ARC-Authentication-Results: i=1;
	rspamd-7f65b64645-wb72n;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Harbor-Juvenile: 7f1ea69d6860830e_1771956308028_3784546453
X-MC-Loop-Signature: 1771956308028:1787463172
X-MC-Ingress-Time: 1771956308028
Received: from pdx1-sub0-mail-a239.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.104.34.8 (trex/7.1.3);
	Tue, 24 Feb 2026 18:05:08 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a239.dreamhost.com (Postfix) with ESMTPSA id 4fL5Gq0m0bz105X;
	Tue, 24 Feb 2026 10:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1771956307;
	bh=YMOTt26XpYwIlITjT0DxXy4VSW/5r5YdPadR7BeEf0I=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=j2CtPbiDnrO6gmERANl0tB8gY7Nn8nWqd6iMzmA0xCanR+HWue/3gGIbPKDAOLOcV
	 yjCje8LlnBJxzSz17JjPyVYinWl2DQ7KyxO1dxScy0dxRbugofWa5IsZhhZRhRtjIG
	 uyq2nQH+EVrTs3SMqEge1xzluOinfgJ0EtAMeeHo2SDWFd4RggPF2LO79hFrh7mh9+
	 3oCdfnpvp+qR6QR9k0Cp1keSoF5+A5eG34GnJZYRNyYNubHDhyr9+luNl89AbBdNnC
	 yn9tANQ7MxANjzk+8WZ4Mzm5IbdB46k9f9mSWdz+Npr7LdlYUAy8MTwLfoxGLM7QQp
	 gKWo673VQ7/jw==
Date: Tue, 24 Feb 2026 10:05:04 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: dan.j.williams@intel.com
Cc: dave.jiang@intel.com, jonathan.cameron@huawei.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, linux-cxl@vger.kernel.org,
	ming.li@zohomail.com
Subject: Re: [PATCH] cxl: Handle ERR_PTR endpoint in sysfs-accessible paths
Message-ID: <20260224180504.au56jyairbpp2xu7@offworld>
References: <20260224023609.1059138-1-dave@stgolabs.net>
 <699d145c1da21_1cc5100e4@dwillia2-mobl4.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <699d145c1da21_1cc5100e4@dwillia2-mobl4.notmuch>
User-Agent: NeoMutt/20220429

+Cc Li.
.
On Mon, 23 Feb 2026, dan.j.williams@intel.com wrote:

>Davidlohr Bueso wrote:
>> Fuzzying CXL triggered:
>>
>> BUG: KASAN: null-ptr-deref in cxl_num_decoders_committed+0x3e/0x80 drivers/cxl/core/port.c:49
>> Read of size 4 at addr 0000000000000642 by task syz.0.97/2282
>>
>> CPU: 2 UID: 0 PID: 2282 Comm: syz.0.97 Not tainted 7.0.0-rc1-gebd11be59f74-dirty #494 PREEMPT(full)
>> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
>> Call Trace:
>>  <TASK>
>>  __dump_stack lib/dump_stack.c:94 [inline]
>>  dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
>>  kasan_report+0xe0/0x110 mm/kasan/report.c:595
>>  cxl_num_decoders_committed+0x3e/0x80 drivers/cxl/core/port.c:49
>>  cxl_mem_sanitize+0x141/0x170 drivers/cxl/core/mbox.c:1304
>>  security_sanitize_store+0xb0/0x120 drivers/cxl/core/memdev.c:173
>>  dev_attr_store+0x46/0x70 drivers/base/core.c:2437
>>  sysfs_kf_write+0x95/0xb0 fs/sysfs/file.c:142
>>  kernfs_fop_write_iter+0x276/0x330 fs/kernfs/file.c:352
>>  new_sync_write fs/read_write.c:595 [inline]
>>  vfs_write+0x5df/0xaa0 fs/read_write.c:688
>>  ksys_write+0x103/0x1f0 fs/read_write.c:740
>>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>>  do_syscall_64+0x111/0x680 arch/x86/entry/syscall_64.c:94
>>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>> RIP: 0033:0x7f60a584ba79
>> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
>> RSP: 002b:00007f60a42a7038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
>> RAX: ffffffffffffffda RBX: 00007f60a5ab5fa0 RCX: 00007f60a584ba79
>> RDX: 0000000000000002 RSI: 00002000000001c0 RDI: 0000000000000003
>> RBP: 00007f60a58a49df R08: 0000000000000000 R09: 0000000000000000
>> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
>> R13: 00007f60a5ab6038 R14: 00007f60a5ab5fa0 R15: 00007ffe58fad8b8
>>  </TASK>
>>
>> cxl_memdev_alloc() initializes cxlmd->endpoint to ERR_PTR(-ENXIO) as a
>> sentinel until the endpoint driver has probed. During that window the
>> memdev sysfs attributes are already visible, as soon as device_add()
>> completes.
>>
>> Use IS_ERR_OR_NULL() instead of just NULL checks in all sysfs paths that
>> use cxlmd->endpoint to avoid the user prematurely accessing it.
>
>Ugh, no, like I said here [1] I think endpoint non-NULL @endpoint
>confusion is an indicator of other issues in the code.
>
>[1]: http://lore.kernel.org/69813ac070f79_55fa1005c@dwillia2-mobl4.notmuch

Ah, I missed this.

>>
>> Fixes: 29317f8dc6ed ("cxl/mem: Introduce cxl_memdev_attach for CXL-dependent operation")
>> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
>> ---
>>  drivers/cxl/core/edac.c   | 2 +-
>>  drivers/cxl/core/mbox.c   | 2 +-
>>  drivers/cxl/core/memdev.c | 2 +-
>>  drivers/cxl/core/region.c | 3 ++-
>>  4 files changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
>> index b321971fef58..65b37460d1a8 100644
>> --- a/drivers/cxl/core/edac.c
>> +++ b/drivers/cxl/core/edac.c
>> @@ -1149,7 +1149,7 @@ static bool cxl_is_memdev_memory_online(const struct cxl_memdev *cxlmd)
>>  {
>>  	struct cxl_port *port = cxlmd->endpoint;
>>
>> -	if (port && cxl_num_decoders_committed(port))
>> +	if (!IS_ERR_OR_NULL(port) && cxl_num_decoders_committed(port))
>>  		return true;
>
>This NULL check was never valid. How can a edac code ever encounter the
>port detached case?
>
>>  	return false;
>> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
>> index e7a6452bf544..f2308db13c5d 100644
>> --- a/drivers/cxl/core/mbox.c
>> +++ b/drivers/cxl/core/mbox.c
>> @@ -1301,7 +1301,7 @@ int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd)
>>  	 * Require an endpoint to be safe otherwise the driver can not
>>  	 * be sure that the device is unmapped.
>>  	 */
>> -	if (endpoint && cxl_num_decoders_committed(endpoint) == 0)
>> +	if (!IS_ERR_OR_NULL(endpoint) && cxl_num_decoders_committed(endpoint) == 0)
>>  		return __cxl_mem_sanitize(mds, cmd);
>
>This looks to be abusing ->endpoint when it should be checking
>cxlmd->dev.driver. The rule is @endpoint is always valid if
>cxlmd->dev.driver is non-NULL.

Ok, I will send a patch for checking ->dev.driver instead.

>
>>  	return -EBUSY;
>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>> index 273c22118d3d..f0a97aaaaf35 100644
>> --- a/drivers/cxl/core/memdev.c
>> +++ b/drivers/cxl/core/memdev.c
>> @@ -236,7 +236,7 @@ int cxl_trigger_poison_list(struct cxl_memdev *cxlmd)
>>  	int rc;
>>
>>  	port = cxlmd->endpoint;
>> -	if (!port || !is_cxl_endpoint(port))
>> +	if (IS_ERR_OR_NULL(port) || !is_cxl_endpoint(port))
>>  		return -EINVAL;
>
>If you can trigger this, which I do not think you can after Li Ming's
>recent fix, then the proper fix for this is in [1].

The only path I've been able to reproduce is Sanitize. This was testing
the 'fixes' branch with all the patches Dave picked up yesterday including
Li's. So it's possible the bug could have triggered without it, but cannot
say for sure.

>
>>  	ACQUIRE(rwsem_read_intr, region_rwsem)(&cxl_rwsem.region);
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 42874948b589..5ff5a086ca0d 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -2956,7 +2956,8 @@ struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa)
>>  		.dpa = dpa,
>>  	};
>>  	port = cxlmd->endpoint;
>> -	if (port && is_cxl_endpoint(port) && cxl_num_decoders_committed(port))
>> +	if (!IS_ERR_OR_NULL(port) && is_cxl_endpoint(port) &&
>> +	    cxl_num_decoders_committed(port))
>>  		device_for_each_child(&port->dev, &ctx, __cxl_dpa_to_region);
>
>I believe this was the exact issue fixed by Li Ming's fix.

Looking at the splat, yeah I agree. And of course that fix holding the host
lock is much nicer than papering over it with nil sentinel, or this patch.

Thanks,
Davidlohr
