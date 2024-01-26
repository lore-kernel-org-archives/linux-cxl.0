Received: from relay.mailchannels.net (gt-egress-004.relay.mailchannels.net [172.255.62.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D36225AD
	for <linux-cxl@vger.kernel.org>; Fri, 26 Jan 2024 19:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=172.255.62.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706297641; cv=pass; b=tXPVZ2fHBeMyHDgWxsX3Zj3JPPoguu9EKOtp7O2+u/SEdPi07QtHV8uLpGvRmBOQHHB2XMoirvgKX48dJfMsID5saJ8382i+mfA/fsBH+i7ae3x7A9eOBbk+xgbyo98cNdWOqlKNw+FIKBL6Fj7oHR2HPtc+NwI3W5yMFafsO5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706297641; c=relaxed/simple;
	bh=43LxZTXWHVwNP0vENXewcAvnrBRVcG7PgLGfhqyjSjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pTcZ6L2J1lvPdDKirLKrQO35cis1XT5Jo4y5ifhKLiFnwir4pNYAkgLlcSGR91oubvg1+uqSSQvC8OfTraJHRo4TWBnVSfIPb6d7JhR/aWm+lFLcV+6FIIfQse/yFr3odGE5jHuR/HJaVJ1bBLjf8pfTmVhoMP3ZA3QuaGHyYqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=Q57LdvSe; arc=pass smtp.client-ip=172.255.62.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="Q57LdvSe"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 4F22C14345A;
	Fri, 26 Jan 2024 17:17:18 +0000 (UTC)
Received: from pdx1-sub0-mail-a313.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 8DE0A1434D6;
	Fri, 26 Jan 2024 17:17:17 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1706289437; a=rsa-sha256;
	cv=none;
	b=SumsGBibsM1S/idNLekcId5FC2LbkCdUPGJ/hhAUFP/o5KT/L5JARpMS8LTRgyJI0mdv0b
	SFbgwlaIG3UdnSTNkFvA/PcLAXRtqWYGyQv52x2lEffH64RmO41ImEBMXOM3y+CbM7ZPaK
	qN0SxFbBkXM/iMTRrf9ubUOUMaXpIexFXgwfEz7EnBuCbF2qyREfy6f0+yEZ166iFIJ2HC
	W8yChC7gUNQM+M67VTSiFlzYuyB/MsZ7sVohpKE5fHaZ0DZ3if7UuiIaxJCCwo2LwgQgq2
	GjaZcfxfEtV3cAIOCYYqSknr7R4YO3bm8vcYOcs7OlwhTWqs06CTy7hGVYONVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1706289437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=a11EaRkfGd9LRVKXzKjRrhaD6ophVU/ePDsda3ymzOI=;
	b=ZIhGhIRR8cuyTPzcPsL+S+BSPEGzJophz1SnSW+iDFvKb6BstK7RQ1qSpgRIjj/R/qkV/g
	cfdrWasunt5jRmfKNwKe1TwqjIGkA71pzpbArJQ0gxI/fodfYwRKODNnTC4CtXdOacqdE6
	tGjCf9rDO5bpKC3JwmwMl3dX8cBC/uclJSB6FHfwVVEpOUId5sisnqvc1b44xqOXCQmVua
	Va+zC1Q99c2qGm5jBQMI/ilyCEkt6RSSKU6AqgjxnM4+/4o77tnRRBRe/cWrtNSQutguSN
	UEbNncZpm9CPU6GHWDSfVcgi/CAORb9QotStg+Xj/7IQ5j8QarkYW9JdcIW8jw==
ARC-Authentication-Results: i=1;
	rspamd-9c9494d96-cwbbn;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Shrill-Cure: 78b9a11e00ac99fd_1706289438136_1599124016
X-MC-Loop-Signature: 1706289438136:2195006422
X-MC-Ingress-Time: 1706289438135
Received: from pdx1-sub0-mail-a313.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.100.20.137 (trex/6.9.2);
	Fri, 26 Jan 2024 17:17:18 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a313.dreamhost.com (Postfix) with ESMTPSA id 4TM4BP0Bw3z2m;
	Fri, 26 Jan 2024 09:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1706289437;
	bh=a11EaRkfGd9LRVKXzKjRrhaD6ophVU/ePDsda3ymzOI=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=Q57LdvSex/HIYDsr1/7QUYog/QTP6DpXg56R7dVuKGU7TEjBFvfmF7VBoplTQPYsI
	 3K86WRYcboEmAqc3vCFKPbdsAgUdxL4ZS90xMVC32aFO+qKcC3XWlQ6d8swDKCiXwF
	 P1doQN5/afafisZAZNQGObK+PYZn8dZ2uZWiADhyG4OzCR7FyLqhDU2IdVwLBCb3+J
	 aXdEY3Zqlp0kdBh/HxRRjlTJ2FxjCyRk4YaygnweachmN27LlOKMTbhhJqrOFGL0rc
	 RJS7UiSU0xg3iHnpwidkETtJQGYnwAV/T6OXJmu1Jh/RgadcHTO5tiH+786ScsldPZ
	 o6e+iCseN8Agg==
Date: Fri, 26 Jan 2024 09:17:13 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: vishal.l.verma@intel.com, fan.ni@samsung.com, a.manzanares@samsung.com, 
	mounika.k@samsung.com, linux-cxl@vger.kernel.org
Subject: Re: Re: [PATCH 1/2] hw/cxl: Add Transfer FW support
Message-ID: <vsm7fpp3fbywuzzepbhezzuhewrk5fc3avtvbcrb2nubs3lm2m@y257ghfqmqmr>
References: <20240109070436.21253-1-dave@stgolabs.net>
 <20240109070436.21253-2-dave@stgolabs.net>
 <20240126154220.00002797@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240126154220.00002797@Huawei.com>
User-Agent: NeoMutt/20231221

On Fri, 26 Jan 2024, Jonathan Cameron wrote:

>On Mon,  8 Jan 2024 23:04:35 -0800
>Davidlohr Bueso <dave@stgolabs.net> wrote:
>
>> Per the latest 3.1 spec for supporting firmware update metadata
>> (no actual buffers). Aborting a xfer is currently unsupported
>> through a nop.
>>
>> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
>Hi Davidlohr.
>
>Whilst we may never notice from the OS as we expect it to send valid
>sets of transfers only, I'd like the emulation to incorporate more
>of the validity checks the spec requires such as:
>- Multiple part transfers must all be for same slot - any interleaved
>  ones for other slots result in error.
>- Retry of previous transfer or one that starts where previous transfer
>  ended - otherwise Out of Order detected.
>
>So we have to hold state, and as such will have the information to
>set the slot as occupied with just one extra flag stored to say it is
>a FULL or END message.
>
>Otherwise lgtm.

I will send a v2 with your feedback. Do you prefer just using your
latest '2024-26-01-draft' branch?

Thanks,
Davidlohr
