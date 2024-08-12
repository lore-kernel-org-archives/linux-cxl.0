Received: from giant.ash.relay.mailchannels.net (giant.ash.relay.mailchannels.net [23.83.222.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38731953B9
	for <linux-cxl@vger.kernel.org>; Mon, 12 Aug 2024 22:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.222.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723501757; cv=pass; b=D2XUrZ+ApTsI0uQXmP2pvE3FcQJ7yk23sbttiTbbXrctGd6mkK/DHf6EavE3jX80KJ3qjcNsFZu/Y+/i1pRRyBiCBI/+Chj5yIxKVt5R7g/mA0jpfQvcV7dhVBsXhO2uMs2HbVpp4KheDpw/UMlMTxK1BkN4KXYezX8hFKRGkX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723501757; c=relaxed/simple;
	bh=5R34oNngr0GM3rBsEl6KctKMgO1Bm489tsa/E9V4dGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rTt+7x2Pl1gSNcwKZ5673Z17HUwcCyll3bas5PjMVKCGwDQwsRXZImfPTEYm145NbshJFz3yGg/OjGfPINaX9t7mK8fuVQCAJZjJofH3M3/chnMtk6FrM55PJ+mzxqlOfdIWSIfYyYz7bCeAn0FezO1LgVLl73haNXvhJ2w4A0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=WPf4zRwF; arc=pass smtp.client-ip=23.83.222.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="WPf4zRwF"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 36E6145D14;
	Mon, 12 Aug 2024 20:04:41 +0000 (UTC)
Received: from pdx1-sub0-mail-a249.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id BC4FE45CEA;
	Mon, 12 Aug 2024 20:04:40 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1723493080; a=rsa-sha256;
	cv=none;
	b=lSMTg8O9U02YcPjt1n+/bAdiProULZ/hWu95YH2pmuqmNOWUYIbipSLCPhHaiH9WPPL3E2
	FlgMmO4H8hJSLfqnNpShaQLev/uAvliWaZg2vuIDrEowqWf6TZ+B01U6e0ynSW80UkJeFD
	oWveL7ZBZmgioYAAVkg8Tgh/3+QCPsNimWM4PaAGDDdRIok5NmoYOuPCcPa8OfCctDXp64
	J5zQcRQJV4SeuuAb4rSNUqObve+V4GfX/0N1RAiqtY/3D734IEgF+SigHeuwbRxNL0WvIj
	mDLKWWQEz+Aff2LLQIMuOs/pl1+pMe2I9gcDbm367iIPMs3+i6JkerCGE7ojvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1723493080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=5R34oNngr0GM3rBsEl6KctKMgO1Bm489tsa/E9V4dGU=;
	b=c0t4htyjjj9EPJ4yBAp/teCG15nz/V6C/3mflJ+f2IgNnFcJCbkYrHqsDMei1qBf1Es91s
	5otb1FZFHEGH15F532jnhwP9GoWNuiR3VnXAlte6G9312AaBdvPqNe8rsbhfuTR64N5LI4
	sfGCpu70z2nO66xcdiTHRqk4BzUHz3pOgBU15nyTFZlWNStDHZf3dkGQ8epsiOIb8LKRn1
	Xe0+nLM9W/dQnFp429DDeUclV/KFCy+jJs9SoKMrRlrdwN2O+IOnuPAQzpn62pBIZ08sl6
	M3AIjGMeHPzYI8i/F+sTYKmcgSNCsm8YIkWwGTXP3JHz8+kFofuZCZTM5tSpQg==
ARC-Authentication-Results: i=1;
	rspamd-68c6c69487-lv4gw;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Wide-Eyed-Trail: 620bd8e531d59568_1723493081058_1934286635
X-MC-Loop-Signature: 1723493081058:485994258
X-MC-Ingress-Time: 1723493081057
Received: from pdx1-sub0-mail-a249.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.127.145.187 (trex/7.0.2);
	Mon, 12 Aug 2024 20:04:41 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a249.dreamhost.com (Postfix) with ESMTPSA id 4WjQTh07vGzQ3;
	Mon, 12 Aug 2024 13:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1723493080;
	bh=5R34oNngr0GM3rBsEl6KctKMgO1Bm489tsa/E9V4dGU=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=WPf4zRwFduy/evolex7yvbDxHxlbrJcpchLffen29fL6ciFClZC+r/3FAUhwPO8TX
	 78D6drc6a50jR5oMF/Bf/q5ZFamyQDFhC1SUc3A6V4tIHWGQx+tiDwGI+EthR5YNSt
	 vW6iB/vYep+cZ/eGeZQFBNoskeqYf2yRtlY9BRSestV1UfZYEPTPrbCemmxV7b4A1R
	 X3AfVxf8v7HtbxHrC3O2QzBfqZsSX7Jg2V6VVGcT76hjIRfE/siXXdW2aWxHdxJEyJ
	 xXn8/gP8z0NAbIgrAvuHqKswbC0Ggu3nad/OjZokNXJCf+R0LkKsbLrA5KFzeKWu24
	 3f2cXpIEv6v2Q==
Date: Mon, 12 Aug 2024 13:04:36 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: "ajay.opensrc" <ajay.opensrc@micron.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, "john@jagalactic.com" <john@jagalactic.com>, 
	Eishan Mirakhur <emirakhur@micron.com>, Ajay Joshi <ajayjoshi@micron.com>, 
	Srinivasulu Thanneeru <sthanneeru@micron.com>, Ravis OpenSrc <Ravis.OpenSrc@micron.com>, 
	Aravind Ramesh <arramesh@micron.com>, "Tushar M Mulgund ." <tmmulgund@micron.com>
Subject: Re: [EXT] Re: [PATCH] hw/cxl: Add support for abort of background
 operation
Message-ID: <6erdnad5ql6xtzpwc6ay4mibud44u56kzd7r6nk5labxsmkkbi@e7lw2v7bffue>
References: <20240729102010.20996-1-ajay.opensrc@micron.com>
 <jvbuxqaqjclc5cy5veltygpo4dg3naej456gvphndpdc3ttyoa@p64fmecqr67r>
 <027f6872f7ae42c4ba97ed1209e50253@micron.com>
 <20240804171638.0000291c@Huawei.com>
 <739db69829ed4afead329649fda1d47b@micron.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <739db69829ed4afead329649fda1d47b@micron.com>
User-Agent: NeoMutt/20240425

On Wed, 07 Aug 2024, ajay.opensrc wrote:\n
>>From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
>>So to my reading if you elect not to stop because it's very
>>nearly done, or indeed it raced and the command is done,
>>the specification doesn't tell us what to return.
>>That operation supports abort, we just didn't.
>>
>>What do you think should happen here?

I had interpreted this case to return success for the req abort
command, but the caller had to check the Mailbox Status register
to see if result had actually canceled the on going bg op.
And I don't think there's a race between checking the status
register and the on-going bg command completing. Aborting
means percentage complete < 100 && bg field cleared.

Jonathan, would you want the patch to have an arbitrary "don't
abort the bg op over 85% done"? I see this useful as it allows
the cancel a bit more versatility, albeit potentially getting
in the way of testing. What do you think?

>
>IMHO, device should ignore the abort command and
>most likely return "Unsupported" code (since, the spec is not
>clear on what should be the return code in case the command
>is ignored). Does it make sense?

I don't think so. This is not an error imo. This case is about
supporting the request abort command, but the actual command
not actually triggering the desired cancel.

>
>Agree that it's a spec hole and may need to be clarified.

Yes, it would be nice to have this case be explicitly stated.
And it is not even a corner case, the way the spec describes
it, this case can perfectly happen.

Thanks,
Davidlohr
