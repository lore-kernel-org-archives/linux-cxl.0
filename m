Received: from sienna.cherry.relay.mailchannels.net (sienna.cherry.relay.mailchannels.net [23.83.223.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F7B19F115
	for <linux-cxl@vger.kernel.org>; Tue, 21 Apr 2026 00:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.165
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776730794; cv=pass; b=Ga8E1RC+wz6WYc3ldubnVT4lXQHjPYTTFDpWKqCZZ2pQcVb+w2Izb2S/MdztE0Xr0RspvYBgHLxGEOKKZQOfDVna8480RfjnU+nCrzfCTqspGwXgXOew4BffGNgLq3BKaprEinGMZ40tcjKckZSRHDuB3Mxr4bhq3C6+3oNj5OI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776730794; c=relaxed/simple;
	bh=EgGc3fR3lhbvLG5CvBNV0PFZsN2MAd15HOn2ezwcKTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QnmwrU2txeObPChB0mO1LXsZfe1nWzW9Y4udXXHElTzm5d3SXgzq7si9W/er3q2oRsYt/5aT0Wp6nlAiZaVKIh/EwYDtv29EP+orcMisFjLwIz/akPbPbkJq3ijfGnHvb6j1z1QmlHUOTGsGsmFqATWvKBXUntiC6qBXezlsOyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=iS8aU2y1; arc=pass smtp.client-ip=23.83.223.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="iS8aU2y1"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id F16558A3110;
	Tue, 21 Apr 2026 00:19:46 +0000 (UTC)
Received: from pdx1-sub0-mail-a246.dreamhost.com (100-101-160-57.trex-nlb.outbound.svc.cluster.local [100.101.160.57])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 866908A3573;
	Tue, 21 Apr 2026 00:19:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1776730786;
	b=yIRVFWjvSSINbjzPQWQJUIFcD3Eh/XKhiaRKmtebeY8i1L3fNwiTfM0EH88g61Ke9RxaxM
	yAu7vL+imEqqTxPNPwNPdjOSC2muz5zMp+B4C6Rm5fcfcJQe7a/M0omud/lMoAKhzrebxO
	ucuv9mM6NpIhVvceGh4zkcb4dHdLpf6QThVDcHuJsDmZViVfc+kNLaXpDOKtDEFlO3qT1j
	xbo8snG/c9qFE+EqelnG3U2fBzQluglO2CAc0lL8UPyfG4oGJH+cGyiVPH+RqTR+f7VLNQ
	sdjObOHwSfqgX7YmFgqED+Nbau+nhYucXC2X7gYYO2S1VYOjt0WqUe6X3jvmtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1776730786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=FdbNj8OhP7/nEBNavfmvFR0VMUcoZiBZT+rBq5kTH9c=;
	b=7toKvurbbZTdiIAW+9j4RSJvqBNHlLH2nrgQvSxWyglH+ZzZLhVF89XLkaSE8Lhs3gL4qn
	SHsizcFsCnuednccnriATtaa0wMQWZzeAiPCV9aCb84j8XSR+hfiWPrFQjH9k1jrMd5w17
	EsLxBJ7E4v3jbkR5hlDdaUu6Bdj0RgUgsla9Nd+ZoX34rNRZ4RCL3305XumQubGdx2fwmY
	Z8x1kEoCx94Kc9aZmipLHiI+8TV3xE1Hs42qdKp6WndXq3p1v9ACmI/8NqQCewLPi03Ws5
	Xmj/1WjBLIl1ClI3NO4FOS87rDYBkl+hbk+AIzM83i3fe1PdmWCj6jUTwvmWWQ==
ARC-Authentication-Results: i=1;
	rspamd-5b57f64d8f-vw6kp;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Dime-Left: 5255cbb8075b2985_1776730786835_2434162124
X-MC-Loop-Signature: 1776730786835:2004003647
X-MC-Ingress-Time: 1776730786835
Received: from pdx1-sub0-mail-a246.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.101.160.57 (trex/7.1.5);
	Tue, 21 Apr 2026 00:19:46 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a246.dreamhost.com (Postfix) with ESMTPSA id 4g02zj6FnRz107Q;
	Mon, 20 Apr 2026 17:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1776730786;
	bh=FdbNj8OhP7/nEBNavfmvFR0VMUcoZiBZT+rBq5kTH9c=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=iS8aU2y15s2Qv1eNu1ps5DXe5fywBM7pDx+cP+des+B30QRwJ0p+lgEibf8+4bJhO
	 jA77qPLkailVVta7gJMFuE0RuE82oirTcVeujWD1wnP46S7y3J9ZtALZAPQHFy6fvG
	 n400amNnC2yO4b7QUIIYsWiM9p/HkNJXJvUJWd3TMlqTZb+19DaLfXuwY7d5CYurSU
	 f5IBcpuO5vUvtkqNWr/+w4asPI4la095qJfGAnPpztQyqkC7qg9bk6imFFPS8uayuX
	 ApnyGmfZY0/bE/DniKT4Diy53a2rXcKssyY6HyoXxQ9xJF6iCcCFB1MdRhVCe5D2XB
	 j9U3VqoMvrN5A==
Date: Mon, 20 Apr 2026 17:19:43 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: John Groves <John@groves.net>, dave.jiang@intel.com,
	alison.schofield@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, dongjoo.seo1@samsung.com,
	anisa.su@samsung.com, linux-cxl@vger.kernel.org,
	John Groves <jgroves@micron.com>
Subject: Re: [RFC PATCH 0/1] cxl: Media Operations
Message-ID: <20260421001943.ulyh5agi45qozewa@offworld>
References: <20260323204013.4010634-1-dave@stgolabs.net>
 <20260324153238.0000750e@huawei.com>
 <20260324180754.et4gwn6dobdplurt@offworld>
 <20260325120613.00007003@huawei.com>
 <acaes_gqFt-LLFrC@groves.net>
 <20260413165042.00004ec8@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260413165042.00004ec8@huawei.com>
User-Agent: NeoMutt/20220429

On Mon, 13 Apr 2026, Jonathan Cameron wrote:

>On Fri, 27 Mar 2026 10:17:01 -0500
>John Groves <John@groves.net> wrote:
>
>> On 26/03/25 12:06PM, Jonathan Cameron wrote:
>> > Yo John,
>> >
>> > I'm sure you are keeping a list of potential improvements for the appropriate group
>> > that I believe you have some leadership role in ;)
>> >
>> > I'd like devices to provide info to allow us to establish an upper bound on how
>> > long a zero / sanitize media operation would take.  This one doesn't need to be
>> > code first so we can consider this a potential feature request.
>> >
>> > Jonathan
>> >
>> > > Thanks,
>> > > Davidlohr
>> >
>>
>> Acknowledged. Are you thinking of a one-off for sanitize, or is there
>> a class of commands that might ought to provide such an upper-bound?
>
>Not sure - probably one to through at the spec group and see if anyone can
>think of more usecases beyond the various media operations.

Right, so sanitize has always been the painfully slow one.

>>
>> I'd be happy to try to push something through, but the solution ought
>> to come from somebody who experiences the inconvenience directtly :D

I'm really doing this for better end-to-end BI testing, so not really
running into any issues (much less on real hw); mostly just forward
thinking for/if whenever there is a device with this.

Thanks,
Davidlohr
