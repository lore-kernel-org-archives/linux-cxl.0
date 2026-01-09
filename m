Received: from tiger.tulip.relay.mailchannels.net (tiger.tulip.relay.mailchannels.net [23.83.218.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E03363C4B
	for <linux-cxl@vger.kernel.org>; Fri,  9 Jan 2026 15:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.248
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767973531; cv=pass; b=HVNEafwOsSSn0oxX6RlozX60vVQaWU0aaYT31zLrfaDyBHC4iL/AmsbSs0e1viMyry1ldTZ5g0AKNODsNLmizUBzwCieRukaRH8TahflP0j76o8Af2cgm63MFu+NmQX8vvSvvYCEB6V0QaeyZuCX19nGzJ/u04ummD1hFLq/7HM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767973531; c=relaxed/simple;
	bh=OJfIOr2J2fyjFZE2+AjXQctRdSyTBpPYdAEursA91N0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZloG6Ek5R0oPP3513I3Qmopoi9AJ3sck/z/sXGReXJq0qtQgnH0PM3cGCJgX/1W+QqwK5Pv4sjOcBzUUN+zMH/O39wjebNjMpeim1N4vrD1FwGEZxk0x2Nf0H5L41vjyvEkhjob6T2/+bVbpPakIqiD06L317Xo01DX5YHYxIAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=aVMrn8hM; arc=pass smtp.client-ip=23.83.218.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="aVMrn8hM"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id CFE511824F2;
	Fri, 09 Jan 2026 15:45:23 +0000 (UTC)
Received: from pdx1-sub0-mail-a231.dreamhost.com (100-113-119-120.trex-nlb.outbound.svc.cluster.local [100.113.119.120])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 48CEC1822C6;
	Fri, 09 Jan 2026 15:45:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1767973523;
	b=zbiDG+5wEowOyfwjzR0ktRkx3AxQYUF6zOXMu7MRSSGEGOPJoNAdRm1No5MLdji7tPa5LM
	d1x1JT1ChD/dFIk1MmGb3rFGij/x6xsYgPxOJB07CM3AGWB5qFFA9qApjoq2BfjQkQArJ/
	IOakqYZhMxGRY0CVJtfR2hhJeAQwcla4J56UUhHA39xCQc2Y7voW0tYEERyQ9/eZOCUB6o
	nptWDAagxtXPNT6kWQDVM4Xh0o5sm8JmPOKr8hrLaFIYHDzYr4pPmJK4mXf4cfKnvFWxfA
	JMhrXQ0XfwfhVr01/Dz11CD2wlDgR+8jCm4ABQ7pD/UApM09BHf5joFzCXVzOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1767973523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=OJfIOr2J2fyjFZE2+AjXQctRdSyTBpPYdAEursA91N0=;
	b=3OGJbB0lMQhkBxiMggVJiDuVOfcuI67THsdrI3rZYqKOqQJRhaEgJ+ugFU3Q5XxZmnIQDw
	SfxLrcuGfBPeG3SmZG1duN/ZgRyBbhYNrp51JyEq4mHglrZU8Dg/8pVBYu7ZP5HbifeMbF
	3gkALYxn6usdwy6P5FUDzsk3246K7SyP5KFduwUZJmC/vg9cVmwbN4CGbo9ZODGow6tRVl
	Z64JCEDeUmh6QOS3KFTvYH5yqVb7qUsV9DONvyzRBmLG8kKEESxSzPJ/oi7qjsWaycHCmx
	zhzzl9mKDIeDabQzB71BD9wKHbziTcYv5Yw22uqCWCeUHcZ2sBfShG25vwrKFQ==
ARC-Authentication-Results: i=1;
	rspamd-84bff5b669-r9lwq;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Left-Stretch: 2ae414452e9b4f80_1767973523576_332065032
X-MC-Loop-Signature: 1767973523576:1032402964
X-MC-Ingress-Time: 1767973523576
Received: from pdx1-sub0-mail-a231.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.113.119.120 (trex/7.1.3);
	Fri, 09 Jan 2026 15:45:23 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a231.dreamhost.com (Postfix) with ESMTPSA id 4dnmLp4hJyz1041;
	Fri,  9 Jan 2026 07:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1767973523;
	bh=OJfIOr2J2fyjFZE2+AjXQctRdSyTBpPYdAEursA91N0=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=aVMrn8hMw1s7P/DfvEom6O7rbgY4DWGBXGbm8nH3lFI+Sm2FBUpBIU6f97r0AMTgP
	 Upw+ceTrrQ3p7JRU8SUCfvsO/yUgEkaJ0wbFAGKXhGqJ0aFgEoj/4T96Twe//G2wjV
	 ZrwA4fbie42A+AXFzUswgwzVMjP4GJ3EV5i0ofP5OBUoYDWmtMpV67L0bbGG9qE5bp
	 vULg7lwazW9Hf2YtZraGL01pKrW93hktUT7PC8lnqKVAknr62ZXGgZhYh2bjz9sugZ
	 180070LJmd6EwqbR9Xsl8isNAdcgzyFhpCXJMIOrtm7MizLrgugqo5xra76MQ/uz8k
	 0r2ku4M86Q75A==
Date: Fri, 9 Jan 2026 07:45:11 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Michael Tsirkin <mst@redhat.com>, qemu-devel@nongnu.org,
	linuxarm@huawei.com, linux-cxl@vger.kernel.org,
	Ravi Shankar <venkataravis@micron.com>,
	Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
	Markus Armbruster <armbru@redhat.com>,
	Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH qemu v5 0/7] hw/cxl: Support Back-Invalidate (+ PCIe Flit
 mode)
Message-ID: <20260109154511.ictqvgbzelquln6q@offworld>
References: <20260109144511.557781-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260109144511.557781-1-Jonathan.Cameron@huawei.com>
User-Agent: NeoMutt/20220429

On Fri, 09 Jan 2026, Jonathan Cameron wrote:

>Lightly reworked version of Davidlohr's v4.
>https://lore.kernel.org/qemu-devel/20251103195209.1319917-1-dave@stgolabs.net/
>
>Whilst I have several other series posted for merge this applies fine
>to upstream, so no dependencies.
>
>Davidlohr, please check I didn't mess anthing up and perhaps give tags
>for the 3 new patches.

I have tried my kernel side stuff with these patches and they work correctly
(direct attached and switches). I also went through them and did not find any
issues.

Thanks,
Davidlohr
