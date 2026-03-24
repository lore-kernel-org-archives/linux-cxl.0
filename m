Received: from elephant.ash.relay.mailchannels.net (elephant.ash.relay.mailchannels.net [23.83.222.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604862F6562
	for <linux-cxl@vger.kernel.org>; Tue, 24 Mar 2026 19:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.222.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774380323; cv=pass; b=I3LBnIjpILAIh2wgAnWJiG17Xud5d8/7yap1EC+4eutmn2rTwThKlz/6hww9VUad3f1P24EI/s+lvZWnMmOHqBSb2AsUcbDQDd3EIrqvUKapDK3M9sRc1KxRyr2znsnS8xt76b1bHzjSF6OoJ2xLWb4iGl+szYGmJWR8+CX9+Sk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774380323; c=relaxed/simple;
	bh=s2gCzM/+mPbM8SltAZiXuYenRtYLSIPEMFDjI/5/RKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=twwxpV0e2DFZxKYVvtinWmo8i7gu3OjJKYKIfA5SiV+IZ4QORjeSs38DOab4Fh2U1HaX3BiCZ0iSrVELOKx6gy30I/RVY6ZD+e+LGqGiwLLopomxIXrym6so67atLAg9Bbi7O4dch6e2Be3tg1j+Y+odSUcwdksujCzfs4SoqxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=rG0e7jMa; arc=pass smtp.client-ip=23.83.222.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="rG0e7jMa"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 9E2B04C0989;
	Tue, 24 Mar 2026 18:07:58 +0000 (UTC)
Received: from pdx1-sub0-mail-a247.dreamhost.com (100-96-47-178.trex-nlb.outbound.svc.cluster.local [100.96.47.178])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 3078E4C0BEE;
	Tue, 24 Mar 2026 18:07:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1774375678;
	b=FAu25KFmyvlQszziH1SSRV3BdMpoxmsHhKkyRT3h5gdpySC7yBz+MYBxcURim2lfP0p2wT
	t/HadcXQ3HlGoEuuyY31KpXXy3ZPJcvQkhT0swvTSEg5rHesyj7S/uRfA3l4SZH+Waiokp
	jY6zPdMpSTIvRi2TbbKM4uAmuSv/dy4wrBDmJ3uIJiLVSlm3TkeSVQNjHvMwcT1Osy6d+Q
	j7+NKLqMq/c1WPBVGkTZ88mFQSolFKLXtuF2SvnVbQfNcgqlFSFNoLcIcdGAtAE9viGi/+
	N9e1cnbMXl9Wpf6mL2eebA+XL3vZnTRSijmauzjMRftjb30KWAGjtI16+iY/3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1774375678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=oVCMZGEM6JVYy1kjMDRq/hD/3Hv2apwS7Hm0VhnwPTk=;
	b=I51K0jUZNB7GgCpT6Mb7zVks9sc82/729E/y4Gs5WxanIfLis0xNPArgdTDsNWuKm2kmO8
	7OSHHJ0F8iBjHZfULSAX354yK6IrPdXIqQq7JZ1YtE+Fy89Bb3Y36NDOrYCEkP+rKKM6Ap
	+DwNOIw39dC5IFX3yQg5MKawCYmnjX4wOHimsM4U223zS0QG5oFCFcgktwcSlEqcxzjq+p
	y1u7ylrhPV5c2lUEfNwK+i8KxbGiwy8TACmS6G63n5vZPGvwhh0m5zdqeJ/1k/t7DWbjWo
	0Ip+R5+ORHsrTDn9FEpYMvnhy8cFQXVrL8uCCoV75lNbNkj1Fr9TtxT8I2oGbg==
ARC-Authentication-Results: i=1;
	rspamd-db964497c-8f7wh;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Abiding-Thread: 0f07286e08b1cc89_1774375678438_449189018
X-MC-Loop-Signature: 1774375678438:541811558
X-MC-Ingress-Time: 1774375678437
Received: from pdx1-sub0-mail-a247.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.47.178 (trex/7.1.5);
	Tue, 24 Mar 2026 18:07:58 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a247.dreamhost.com (Postfix) with ESMTPSA id 4fgJ193sW5zyrC;
	Tue, 24 Mar 2026 11:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1774375678;
	bh=oVCMZGEM6JVYy1kjMDRq/hD/3Hv2apwS7Hm0VhnwPTk=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=rG0e7jMa4iRIuEx2qgO15i5F7ftjsY1t2bJrIaIg9T6jb9Ad/nPzvXcpZxiYHv53V
	 tg40Y+JCYM4ZNaByy88UkU/SxbxSLDM379yv6YlCVthGwkIXK2xlsDgdb6683oJjN2
	 TAouBzrMIl5uaADdA+gFVqz+riRhkX9121kCwLQQ0xNWL+fUHS+H4UwCQd1xNZsNKz
	 qbA3j/3p8U5Lwpbh9PglWWeqEfQvzEcJxk7HMIfBjsVe4ezISS90rWset3bp2JBopu
	 2fDAxCpK2+fTYA0GmYy5ryq2I1l0LY/z4xl5KybYf+6IjD9vvl8Z5cEXTMpe2aDiH0
	 vrxrhxj5Tpbag==
Date: Tue, 24 Mar 2026 11:07:54 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: dave.jiang@intel.com, alison.schofield@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, dongjoo.seo1@samsung.com,
	anisa.su@samsung.com, linux-cxl@vger.kernel.org
Subject: Re: [RFC PATCH 0/1] cxl: Media Operations
Message-ID: <20260324180754.et4gwn6dobdplurt@offworld>
References: <20260323204013.4010634-1-dave@stgolabs.net>
 <20260324153238.0000750e@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260324153238.0000750e@huawei.com>
User-Agent: NeoMutt/20220429

On Tue, 24 Mar 2026, Jonathan Cameron wrote:

>On Mon, 23 Mar 2026 13:40:12 -0700
>Davidlohr Bueso <dave@stgolabs.net> wrote:
>
>> Hello,
>>
>> This implements support for Media Operation cmd. It is marked RFC because of these
>> noteworthy points:
>>
>>  (i) Sysfs interfaces. These changes implement 'security/zero' and multiplex
>>      'security/sanitize' to allow dpa, len pairs for the range (no impact for
>>      current usage as whole-device). This breaks the 1 value per file "rule",
>>      and would be a first for drivers/cxl/*, so am I open to suggestions.
>
>Value is a vague sort of term.  It's one thing (an range) so seems fine to me.

I agree.

>
>>
>>  (ii) Background cmd handling semantics. Media operations are synchronous,
>>       which for raged zeroing operations makes sense and for range sanitize
>
>ranged
>
>>       differs from the current async handling for whole-device, so user response
>>       differs significantly, something I am not crazy about. Another downside
>>       of this is that it exposes lock hold times to be user-controllable, but is
>>       no different than what we do for fw. Fundamentally, users have the
>>       responsibility to break up the work into sane ranges.
>
>We could apply a limit on this and make that discoverable via another sysfs attribute.
>So let userspace request in say 1Gig chunks.  Would have to check that the device
>supports that granularity though.

If we agree that this will be performed synchronously, then yes, adding a size cap
would be necessary. I don't love having it in ie: security/range_limit(?), but that
could be created at discovery time when we know the granularity. Another way would
be to avoid the extra file and just print the limit in the error message - but I
guess dev_dbg() would be needed to not spam the dmesg. In any case with a cap,
while no guarantees, this also reduces the chances of the user triggering driver timeouts.

>I don't think there is anything in the spec today to let us query how long
>something takes (which would be a better way to bound this).

Correct, that is just something Scan Media allows for - and yes, that's exactly
the sane way to do the work breakup.

Thanks,
Davidlohr
