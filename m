Received: from toucan.tulip.relay.mailchannels.net (toucan.tulip.relay.mailchannels.net [23.83.218.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7545125A647
	for <linux-cxl@vger.kernel.org>; Wed,  5 Feb 2025 04:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.254
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738731373; cv=pass; b=OID+Vb1XBU+vOXcQGps375XCEwL8w32EXYiQHj5ZS0EIfdymoPLsoPOyOiA8v+TzkWMIrWibG/QvWpo72XETD62LMy9/pACfoKCE/N1nFnZg8OUHtrOlYTnvwAMkK+U37NsXEmDDY4hjZKAZBw7ZnUEj/LjysAyDWAnL7IRQkH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738731373; c=relaxed/simple;
	bh=vWUPnHEXth515geAjdIMDxlMbrsPj3lmjTwoFs8iR98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BoF41ncJ8gKmBFFEgdYUrjGsPPkW0IHk3juPRub9D/5/trQqvOC0BpO3d6nBQLqyHqyvlsPI8zpFDADkNCB7lIkJlgOuv4C60v9IRmjnajr/vGqKAEyVKAQxMkE4GXVMLrYhiQXVhpig70qfVF4nuTR6jBWOgvtFk4b8raV28Ng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=eYF6Cbse; arc=pass smtp.client-ip=23.83.218.254
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="eYF6Cbse"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id B651C781EBD;
	Wed,  5 Feb 2025 04:47:54 +0000 (UTC)
Received: from pdx1-sub0-mail-a274.dreamhost.com (100-119-13-85.trex-nlb.outbound.svc.cluster.local [100.119.13.85])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 52028781812;
	Wed,  5 Feb 2025 04:47:53 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1738730874; a=rsa-sha256;
	cv=none;
	b=MTItOaBc7CM2aS9Pzpi0Pk6a1+8XFYMzDgAeJOfQa7jkYpJ7tqjgXBjW1ZIRMf/nKyCML9
	MXCtE2R73Bn9Y7OwoqUP2QD9pYl2lVS6En+yVMxV4rp5Z7fodUc7yF8X0NoXUzNAPhIysK
	spON+lObZZUJ74pEfw9qHvt6DV4Ie6CMzdBO01QN5BjG95zrUB7gpk8Q40CJd2VWDof9zU
	lfjt0CgNCehUIo2WkDnsbmCaXm5EzPyh10L+LkLnkWtVfOtlbFtkyLkkwaQ8nBHVX8lPR5
	mImLWNRRKIlF0jLqgN1IWXhR43lpaqk1I9F8NvziROMFdHGEo0ApCCIUKIgukQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1738730874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=vWUPnHEXth515geAjdIMDxlMbrsPj3lmjTwoFs8iR98=;
	b=aqYCZIrd+Z0aT9Enc2mJz7RWmkKLTRTZhZCMnHi4W6+xCv6hjPstDYNiSXGI61//Y5USig
	eMnmVAzT+3vZ+wULgisakqnmk+a4B64XBMbv0Fj0e26EKvZrrED5IKT8VTGTvSKugSPeXh
	XfGRMasrbri2XHCbeW0AQL/FT5Be8T7lJC7d9rZchm18sYR4OnQfI15CjRkG8jJgdamexL
	eRdgYxXKumeSWwOuhLA9k+rWK8gbtYAXxD36X2L70HfUvVSRDqeKmi685+reDpJpNIvhm5
	+HIS58h5lRKuNhI0V3EdyS1CJxfuw/KbE1ZON+cwpitS123ICtSbTj+w/F4k4Q==
ARC-Authentication-Results: i=1;
	rspamd-854f7f575d-l97bm;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Whispering-Tasty: 1c271af40ec7e8c9_1738730874513_2852093803
X-MC-Loop-Signature: 1738730874513:4256381980
X-MC-Ingress-Time: 1738730874513
Received: from pdx1-sub0-mail-a274.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.119.13.85 (trex/7.0.2);
	Wed, 05 Feb 2025 04:47:54 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a274.dreamhost.com (Postfix) with ESMTPSA id 4Ynnm83X3mzSJ;
	Tue,  4 Feb 2025 20:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1738730873;
	bh=vWUPnHEXth515geAjdIMDxlMbrsPj3lmjTwoFs8iR98=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=eYF6CbseqzUHYbuwA2CulTZ8K/563KyqpOhqtnh067nVX5LmPObb2HIX6k93gC3Pv
	 G8pdw+4uvwO9VqVN+lgSaxjCApm+m7+PMHl266SOVg2+1fE/ifNXpu2ZxBMMaFNmPA
	 SzEF3q23K4sQ4nxIz2vWAPqX4xTCb6/KLVCpyYvHHXVeRFIi/OvbsmMPSZaqD/Equ9
	 iUB0kxDd9/D7l05erjqcFn4E35zGRruRnkugexT1Qfkg7CFBgEhFVvG3gYwL5SZHVz
	 Ob/8kqwWh57NBq55OIcr2kO7Jk1+ho/bCt2ML2KQD4xoWhZ22kRwIkd2XzYLhEwCE0
	 CjYOfJjHdJvAA==
Date: Tue, 4 Feb 2025 20:47:49 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: ajay.opensrc@micron.com, fan.ni@samsung.com, john@jagalactic.com,
	emirakhur@micron.com, ajayjoshi@micron.com, sthanneeru@micron.com,
	ravis.opensrc@micron.com, arramesh@micron.com, tmmulgund@micron.com,
	linux-cxl@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/cxl: Support aborting background commands
Message-ID: <20250205044749.xoo73gewwjahxj6k@offworld>
References: <20240813221255.179200-1-dave@stgolabs.net>
 <20240827163357.0000228e@Huawei.com>
 <jdipjanthgt6atlksngodxjevfb5d43d5rshtxqxxwruszqa3e@vctljs77lg4e>
 <20241022180030.00004f68@Huawei.com>
 <20250203150706.00000e23@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250203150706.00000e23@huawei.com>
User-Agent: NeoMutt/20220429

On Mon, 03 Feb 2025, Jonathan Cameron wrote:

>On Tue, 22 Oct 2024 18:00:30 +0100
>Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
>
>> On Mon, 21 Oct 2024 20:23:46 -0700
>> Davidlohr Bueso <dave@stgolabs.net> wrote:
>>
>> > On Tue, 27 Aug 2024, Jonathan Cameron wrote:\n
>> > >No comments inline and LGTM. I'll queue it on my tree and push
>> > >that out on gitlab sometime soonish.
>> >
>> > I don't see this picked up, which is a good thing atm. While testing
>> > the kernel side, I noticed the following is needed, will send a v2
>> > with it folded in.
>>
>> Currently just on my cxl-2024-10-15 branch of gitlab.com/jic23/qemu.
>> I'll pick up your v2 and replace that.
>
>Hi Davidlohr,
>
>Did I miss v2, or still to send?

Ah, thanks for the reminder, I had forgotten to send it out.

Actually, considering you have been carrying v1 for a while now,
would it not be cleaner/better just rebasing the diff and sending you
that instead of a whole new v2? Otherwise, I'm not sure what to do
when working on your latest 2025-01-24 branch.

Thanks,
Davidlohr
