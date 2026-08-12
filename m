Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7572BB13
	for <linux-cxl@vger.kernel.org>; Wed, 12 Aug 2026 11:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786534617; cv=pass; b=hdjIVmhoEZ27XFsqVan2sK1ITTue2CqX60EChaAKLIWUeqaCBhXvQ+97xIUAKIq3eD7EpSv54YWg5mNWp90KD/ZKxK29sNJkCQSBjwkZyXQxU1PpDNaJcD8Ygcsr8PAP7D6iPls8VsiafDRltQY/nhnqVBq7+fdHcKRvIygkjhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786534617; c=relaxed/simple;
	bh=R4KQia7QKgIkZ3nZehlC0f6YNvIDn9v0U9QhtTegXQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ajzVcfqL1V12a+pCxKe9ZNQmXZ0rq5yw2vPu+LAQRjjrAarSSytmx660nXunqKz7nB5jjVTjC1ugtrtnBL0EC/f5HC+4c0x8HsU0sUQHymwb70rAuSGZ8ATNhIH5t5qDsn84TXhDjJnEBspnEqZyjMMLZHDy7eMPNBo5yjQ6Bg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=L3qmqvvA; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="L3qmqvvA"
ARC-Seal: i=1; a=rsa-sha256; t=1786534602; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Yzv4Avpj84MQYJOt1E0m9xIrwroVQEwfPmFDoGhRlGa2ngqOEnD+F1SwcYuRIVSM/fhep2oNP/ZC7SdzBodENfyuPH0bVuNz7lPI/eBoaoAzDuc81SwXpyO4bSlDQRU4xIjq2RNfsJkwZHDOvzNj4Ov9mKpsVGL+JOKI0U4CKS4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1786534602; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=rkgCOhuPEaDN8g0u+rcXnM7ZZiXxpcUrTl5h0bKXh6o=; 
	b=eNxN1V6+CVGPpyuIT0njgT9jNzAS7ACM/wRtVJ9gdtonyuZj5V5krSubtA/sIOCnWJ4y2nco9LVEliaOhRvAqB9AuFOcl80m37Y3m4zgWEx9U8URXuLlIk7lcd7g7OaSGvHngw2Lu/JL8hIvFluHxhtfJ8cfbVYOA99E0RQgdpM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786534602;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=rkgCOhuPEaDN8g0u+rcXnM7ZZiXxpcUrTl5h0bKXh6o=;
	b=L3qmqvvANRt3lksL6wyj/V4Z/t6fRKPp7zRVYuFeB1UpBXBvCZEmsGyhYrDKc7GX
	j066+qhJg3Oq324tI06b+ylleyFYIaq3wnTVkg3/y+iz5EPMAFnPdeJOXiiO9ybJNtF
	FKccYkn5AVtvGa0B7bKA0gABMaC86UoEF5MKwiS8=
Received: by mx.zohomail.com with SMTPS id 1786534599988610.0571417220203;
	Wed, 12 Aug 2026 04:36:39 -0700 (PDT)
Message-ID: <22289a40-25d1-4758-90c6-11c358b77a3d@zohomail.com>
Date: Wed, 12 Aug 2026 19:36:28 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/hdm: Reset the commit cursor before enumerating
 decoders
To: Guixin Liu <kanie@linux.alibaba.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>,
 Ira Weiny <iweiny@kernel.org>
Cc: linux-cxl@vger.kernel.org
References: <20260812082524.359758-1-kanie@linux.alibaba.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20260812082524.359758-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: zu08011227e13c1ac62ddc3d5b62af0d730000bedd582ede98f81f14979f7394cf011b901bcb6fc2e230189b:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External


在 2026/8/12 16:25, Guixin Liu 写道:
> port->commit_end is the cursor that orders decoder commits. It is set to
> -1 when the port is allocated and then built up by
> devm_cxl_enumerate_decoders(): for each decoder found committed in
> hardware, init_hdm_decoder() checks that it follows the last one and
> assigns port->commit_end = cxld->id.
>
> Nothing lowers the cursor again when an enumeration attempt fails
> midway. The decoders themselves are registered with
> cxl_decoder_autoremove() against the port device, so they are released
> when their devres scope goes away, and their ids return to
> port->decoder_ida from cxl_decoder_release(). The other cursor,
> port->hdm_end, is unwound by cxl_dpa_release(). port->commit_end has no
> such counterpart - commit_reap() only runs when a decoder is reset - and
> the port object outlives the attempt because it belongs to the agent
> that called devm_cxl_add_port(), not to the port driver.
>
> For a switch port the retry is automatic and cannot succeed. Decoders
> are set up from cxl_port_add_dport() while port->nr_dports is still 0,
> inside a devres group that is released when
> devm_cxl_switch_port_decoders_setup() fails. That release destroys the
> decoders and returns their ids, but leaves the cursor advanced and
> leaves nr_dports at 0, so the next memdev that enumerates the same
> switch - devm_cxl_enumerate_ports() to find_or_add_dport() to
> add_dport() - runs the setup again with a stale committed count.
> init_hdm_decoder() now finds decoder0 out of order and returns -ENXIO.
>  From then on every dport addition fails for a reason unrelated to the
> original failure, even once whatever caused that failure is gone, and no
> memdev below the port can attach. An endpoint port takes the same damage
> across a rebind, where devm_cxl_endpoint_decoders_setup() runs again.
>
> The failure paths that strand the cursor are all driven by device state:
> an interleave ways or granularity encoding the driver rejects, a
> committed configuration whose size does not divide evenly by the ways,
> or a failed DPA reservation on the DVSEC emulation path.
>
> Reset the cursor at the start of devm_cxl_enumerate_decoders() rather
> than unwinding it on each error path. Enumeration reconstructs the
> commit state from hardware and has no reason to inherit a value from a
> previous attempt, so one assignment covers the existing failure paths
> and any added later. This matches cxl_switch_port_probe(), which
> already resets port->nr_dports so that a second attempt starts from a
> known state. The write takes cxl_rwsem.region because that is the lock
> cxl_num_decoders_committed() asserts for reading the cursor.
>
> Fixes: 176baefb2eb5 ("cxl/hdm: Commit decoder state to hardware")
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
> Found by the Sashiko review bot while looking at "cxl/hdm: Fix out of
> bounds read of the decoder target list" [1]. This is independent of that
> patch - the two touch different functions in hdm.c and apply in either
> order - so it is sent on its own.
>
> [1] https://lore.kernel.org/linux-cxl/20260812061017.56916-1-kanie@linux.alibaba.com/
>
>   drivers/cxl/core/hdm.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 0c80b76a5f9b..c69ec539e6d8 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -1163,6 +1163,10 @@ static int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
>   
>   	cxl_settle_decoders(cxlhdm);
>   
> +	/* The commit cursor is rebuilt from hardware below */
> +	scoped_guard(rwsem_write, &cxl_rwsem.region)
> +		port->commit_end = -1;
> +

Already have a same fixup from Alison.

https://lore.kernel.org/linux-cxl/cover.1786143520.git.alison.schofield@intel.com/T/#m7f9c703f0dc021191eed727c1fa285211c3e3743

>   	for (i = 0; i < cxlhdm->decoder_count; i++) {
>   		int rc, target_count = cxlhdm->target_count;
>   		struct cxl_decoder *cxld;
>
> base-commit: 7098e9cd98a05c0c5de2fae0c2465f9d966fdd07
