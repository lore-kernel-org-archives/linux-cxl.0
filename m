Received: from cheetah.ash.relay.mailchannels.net (cheetah.ash.relay.mailchannels.net [23.83.222.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CCD396561
	for <linux-cxl@vger.kernel.org>; Wed,  2 Sep 2026 20:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.222.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788380611; cv=none; b=AAGhvmjtlm8/TCxYWUD99SqiHzEXJTNCFT3KkbLEARMdWe7jF+23LhelSyy0NgCg8bFnMOMLE+QiBbofSUQaRyphZUUmS0SKlnErupRXQvGK7quI+b0Fnrl4ibIVqWlpgDII3NPsYz3S3tgMyOPDi3A4ioAZdhTZ5rNopsy08m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788380611; c=relaxed/simple;
	bh=VGkOczxnD190OWI0SfQV3j+fry1Xv2HvB2b+Kim0mSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mz0mm9XouK+0V8UqLwUtnltHfca5SbAcJ+tMLS5yjIHRyRP+k1T6ZMn8orqeqJeCAB58qG8q1xC7xE0nH5qhqN3VQ2GzDysZrdto7CiSVju0MgzW1taiGODFMw3Cl+WKwQBm1v6xtpc2ggnX4LE/ty0FgtUEfh/zH8TZ6JdM8cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=CxC9mbQB; arc=none smtp.client-ip=23.83.222.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="CxC9mbQB"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 17FA141AA3;
	Wed, 02 Sep 2026 19:06:37 +0000 (UTC)
Received: from pdx1-sub0-mail-a208.dreamhost.com (100-97-3-9.trex-nlb.outbound.svc.cluster.local [100.97.3.9])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id AB44E42048;
	Wed, 02 Sep 2026 19:06:26 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Wipe-Supply: 62ae80ba6efa643d_1788375986944_3233175004
X-MC-Loop-Signature: 1788375986944:964268934
X-MC-Ingress-Time: 1788375986944
Received: from pdx1-sub0-mail-a208.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.97.3.9 (trex/8.0.2);
	Wed, 02 Sep 2026 19:06:26 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a208.dreamhost.com (Postfix) with ESMTPSA id 4hZsdt0JZlz1gF;
	Wed,  2 Sep 2026 12:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1788375986;
	bh=AdHoLzkU7FcEGVU9MlAP8avLi/6cPxejYoGuM/V4mGA=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=CxC9mbQBNu5EfSyKGP/foU0bNaWB0nsZdL7//YIpdxsC5BDIbcctu0QPAdTN9Jpbl
	 CSJOmByxJGV6XCyK2dq1kt+yOW+bdXOCg7JmLsMuS+A3TqMEmpMQfVEYUDnCjndfpN
	 fCtQv1DcZ1pgkoYqsKn3k7epUj4J+9jrqq+UyMYvI42/D247/Jako3+5Vlu3lUV4Fi
	 TCkrfZdk3ihBKqAAPJUds3yps3EPqibkWTtsTmVoL3BartkHy5aasxy7e1LSn1ICq+
	 CwqwSJuTd0aFbekz+diVManfuUi6p3goPZBJCIIgjc3JEhu4wamZPfKw12X+eN+5sa
	 sY5TbQAA0u3vg==
Date: Wed, 2 Sep 2026 12:06:22 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Anisa Su <anisa.su887@gmail.com>
Cc: linux-cxl@vger.kernel.org, benjamin.cheatham@amd.com, icheng@nvidia.com,
	dave.jiang@intel.com, alison.schofield@intel.com, jic23@kernel.org
Subject: Re: [PATCH v2 0/4] cxl/events: Robustify event interrupt handling
Message-ID: <20260902190622.aymrxkyfiiu7yuco@offworld>
References: <20260901002912.958-1-anisa.su@samsung.com>
 <apfd9eH0cVxMJJ5F@4470NRD-ASU.ssi.samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <apfd9eH0cVxMJJ5F@4470NRD-ASU.ssi.samsung.com>
User-Agent: NeoMutt/20220429

On Wed, 02 Sep 2026, Anisa Su wrote:

>On Mon, Aug 31, 2026 at 05:26:53PM -0700, Anisa Su wrote:
>> Based on the 7.2 tag.
>>
>> This patchset bundles various fixes along the event interrupt path.
>> The previous revision was a single patch, but Sashiko reported several
>> related pre-existing errors so I thought I may as well pick them all up into
>> one series.
>>
>> Link to v1:
>> https://lore.kernel.org/linux-cxl/cover.1787768932.git.anisa.su@samsung.com/T/#m393e57d7f7f3916e8f2826a006ef0bc4dfd3606a
>>
>Had a chat with Dave and he mentioned we only need to deal with device quirks
>when they show up. So I plan to drop patches 2-4, since they are just Sashiko
>reports and not observed on hardware.
>
>For patch 1, there are a few considerations, so if any maintainers could have a quick
>glance at the thread?
>
>1. I did observe the bug on hardware, but it's a sample device and the
>firmware is being patched, so nobody should see it happen IRL? The consequences
>of the issue were:

I think this says it all, and therefore is not a quirk imo. We should not cater
to flat out spec violations (for non-public hw/fw) - there are plenty of things
that could easily break all over the place if bits are not set/unset by hardware
when it is supposed to.

So I would pretend this never occurred, and if someone ever complains (it was seen
IRL) we have your solution at hand.

>	- 1 CPU taken up
>	- driver can't be unbound since free_irq() waits for threads_active = 0
>
>2. Li Ming mentioned checking the return value of cxl_mem_get_event_records()
>is still valuable (currently a void function). So we could drop the other
>changes from the patch and just keep that part.

Yes, I agree.

Thanks,
Davidlohr
