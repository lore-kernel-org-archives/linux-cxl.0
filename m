Received: from tiger.tulip.relay.mailchannels.net (tiger.tulip.relay.mailchannels.net [23.83.218.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BA4DDC5
	for <linux-cxl@vger.kernel.org>; Tue, 19 May 2026 01:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.248
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779152506; cv=pass; b=sOXfwctIdRVWi0U+NNGMqQFJFS0Eu9rbBowh+ThBlJQ2wzgJi5ukkKox5Lmaji+vmsyclUdaqqoBp5jwmF/6F+oVcEb2byGV2772DZ2C1oHI2fGW/pX8qE4kxP3GZR83BU6KqwqXl5MamXlYc82oOYStXBe6LgNOiXz+sD1qsOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779152506; c=relaxed/simple;
	bh=HkpdGTTE1zb9mVA9epT8MbiudqQpgqi40ebS/bBrNIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fVN1R7ggyCSXjbsXYYbYbWj/KRBLt54c653xJ3ciOBBNeZ3FUDyKRcFqWQEWfHfR3Y9GpW/Y3r1dfJqPiCvst8efz6JeyiszRDO4v0JlAGVsVDFDxRCjVUk1Roywwc54+xDUQvE4099lInkrZbVN59lsWcthWfzpyqV4NbXfG7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=LVs7HfOQ; arc=pass smtp.client-ip=23.83.218.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="LVs7HfOQ"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id AA6264614D6;
	Tue, 19 May 2026 00:53:49 +0000 (UTC)
Received: from pdx1-sub0-mail-a228.dreamhost.com (100-99-215-164.trex-nlb.outbound.svc.cluster.local [100.99.215.164])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 56C5D46168E;
	Tue, 19 May 2026 00:53:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1779152029;
	b=QjbONwIObpaq3Kvx4d+xIfjfDbceQ4tKUUoKfPiopJUsH6n1KTvlXl75isJ1zk+hNrqWlo
	wxFtdwta1XHiSPe7ymSOC6s3lg6iXjuBINb9SUvMPCYD6WaJNQPwoawsgi9wJl7neLvcPq
	z96GvRROMmDBHsxTyNw0XGl+mo5oPJNKDLZocgpo05r4TaRBSp0zOS94+2VvzSOxHTWG9h
	7lm5wK3UCJ3i3lMiVXGRIxFgqhhYWidq4+0ti+2T3fqniY59D9Bfz0rEinSojvfEA4SEj/
	kG4oxZjUD1dAPO6Hk2ZEgQM9I5kLCFHxHQ1IDPCXNhPS1BdyIDmOz0lUYKjAXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1779152029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=zQro8Pzfvzq/HEtqYAhekbEm8rh4mQVm3aY4eoEoE6A=;
	b=z3sIXsGyy3m/jI0IAiWZQFcsPx78kxMAQbe3/ZJypuFxxw2VP4OJ8zdDeKRRX/bSTLOtwa
	UXkR4P7uM1S+80CTZZ26ziSFtJq5aKHg3C0wI79QpphGHySBDa6cF201AuqNurt8CALlgw
	wLwxV5WauUUkWHbKacACn/lrc29QZayIZ8P+cZgJrl+6zLQJPF8eX6jq62WE8i0O+okd0N
	2eGLaH+kxgnGm2/h+i+Ga+RxAtbNHGNf8s2tR1ssVSjFs0ykfKNfcW+Y2rsG0iIH7T7Gba
	Aj8bzwu8Z4LvpEmuKC1H7qRZJaUeq75qIt5OtbCNYBbMew0wwrExa78tM6atvQ==
ARC-Authentication-Results: i=1;
	rspamd-6cd998c8-tq5pq;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Occur-Chief: 57b902f5374dd541_1779152029594_3539254153
X-MC-Loop-Signature: 1779152029594:1881076888
X-MC-Ingress-Time: 1779152029594
Received: from pdx1-sub0-mail-a228.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.215.164 (trex/7.1.5);
	Tue, 19 May 2026 00:53:49 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a228.dreamhost.com (Postfix) with ESMTPSA id 4gKGQ45jjkz1Z;
	Mon, 18 May 2026 17:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1779152029;
	bh=zQro8Pzfvzq/HEtqYAhekbEm8rh4mQVm3aY4eoEoE6A=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=LVs7HfOQP8z7V7BvcNC1U7WCSHZ3gfxV61DlVqeE456Xp0Gj7/IpAbDJfPVlO8C73
	 NFtBzlXa0qDVOAvuz0LLKqrhDE370TY/OsTyq8TCcULxpo5hgjcuxBgnK+1Wooy1gi
	 5ZuS/7zYjF1l6W9au1411885NjdDfK2zlS2KUSM5nunLErziKYc+25KS+1PRy2RySr
	 2prRDNuioQmtleMhUlp7rFrTs7Vd//KukXztAiVIxwT6heP6OsY5O+4xLbmKLrRDh4
	 A6OiCocuVn7GDlYyvMIU/r3or6QeD5jF043XcA6MpFz9ULiWrPTr2h6Z5j5sYStCQL
	 lb/4jst+S9QOw==
Date: Mon, 18 May 2026 17:53:45 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Dan Williams <djbw@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>, ira.weiny@intel.com,
	dongjoo.seo1@samsung.com, anisa.su@samsung.com,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2] cxl/mbox: Support Media Operation
Message-ID: <20260518190026.am3p5acxooq7o75u@offworld>
References: <20260428200410.705675-1-dave@stgolabs.net>
 <1999de6e-7f14-41d2-ace2-db00faede674@intel.com>
 <20260502193429.hztbijgv3bjwit5k@offworld>
 <9f73073f-09f0-4e08-b1d8-746be33fd674@app.fastmail.com>
 <20260507120938.yyfn6hxjobr64xa7@offworld>
 <20260518172303.0b210abe@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260518172303.0b210abe@jic23-huawei>
User-Agent: NeoMutt/20220429

On Mon, 18 May 2026, Jonathan Cameron wrote:

>On Thu, 7 May 2026 05:09:38 -0700
>Davidlohr Bueso <dave@stgolabs.net> wrote:
>
>> On Sat, 02 May 2026, Dan Williams wrote:
>>
>> >However does userspace really need to pick ranges? Would it be sufficient to start with a "sanitize / zero all unmapped" semantic to walk all not mapped DPA. Or perhaps a "sanitize / zero on unmap" flag to the decoder to make it similar to a storage "trim on delete" semantic. The nice thing about that, you can defer freeing the DPA until it's clean to avoid reallocation races. You actually know what you're zapping because it had some recent prior association.
>> >
>> >Otherwise I do not trust the security properties of policy wanting to clean a DPA range but an unsuspecting thread can race to allocate between lock drops. Looks like a footgun.
>>
>> I agree that this is much better than having the user explicitly pass the range.
>
>
>>
>> As we discussed at lsfmm, for this we will need to move to the asynchronous bg handling since we can no longer control the size of the range.
>
>This confuses me a bit.  The kernel can do this in any sized chunk it likes
>whatever userspace asked for.  So why isn't it controlled?
>

Because we need to hold locks (ie: region/dpa) while doing this
if not done asynchronously. And while you can breakup the work in
chunks and submit it synchronously, each iteration would need
to drop the locks and retake them, which is a no no (yes then
other checks can be added but ultimately defeats the purpose).

FW transfer, for example, where the work is broken up, only
requires mbox_mutex, so retaking that is fine and you avoid
chugging the lock, but this is not applicable for ranged
media ops.

Thanks,
Davidlohr
