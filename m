Received: from bumble.maple.relay.mailchannels.net (bumble.maple.relay.mailchannels.net [23.83.214.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C576C61FD7;
	Wed, 23 Oct 2024 02:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.214.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729650369; cv=pass; b=hR91HrpkFcPhGZRm4TdVbU77hlkyhGPW78UrEf6H8RevtQ9/s4EmJfOs90AdcAGC00G88SJ/dp7sMF4YLmL65NWn1j3oY7qfU5ezX+57qhAx/xwwCYc65wMXizHK27RG0n7ELlQwX0au/UZ0YzEzBbKitLa8Jjsovp2Rp0qCc5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729650369; c=relaxed/simple;
	bh=6ToOAMkpV3a2sSbsQlcf8VgemwRMvk+/hdji7SN7g8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K98hx4ykb14O4k5Qe2lc3+Qp4eSh1KUCRnV6tKn0XXg1q0TPE0AQqFGxYpJErR3+3dL2VBRyPiPJ8RrBzRH46TuZFhw7UzO6qazDuKDuDytmpQuYNaNBsug4sjyZJsVQXNORBErdu/wEcJxIS8cvpnrpRTZWIYXEVp0QXjgR388=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=aPBggA18; arc=pass smtp.client-ip=23.83.214.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="aPBggA18"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id E07A73229C3;
	Wed, 23 Oct 2024 02:26:05 +0000 (UTC)
Received: from pdx1-sub0-mail-a233.dreamhost.com (100-99-0-56.trex-nlb.outbound.svc.cluster.local [100.99.0.56])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 5FF47322C6B;
	Wed, 23 Oct 2024 02:26:05 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1729650365; a=rsa-sha256;
	cv=none;
	b=6vmrzw/LpjMw2XkIgS2k9HL3joZflL0t2PMb1Aj1Pv5u31O82gW91VP5EiQwzeNqwFoDtb
	NSUXpLC5XWUwhGCNQQh0Nm/cceLEXAr3vP1UhaocDhomxsEMxCrFiJKkwH4b3K2Az0r5XL
	aKLSf2C8Zmf8/HsHjAyL/VzJ5YqTb/27OEO7mpvXOG2PvUj22kpJyXESsmX7Qt0e6cYMuN
	ChxVkh0BlTwfTUVcWnu36Rs7ibmv3Ov3mYQgZPrnQsrEvK4CvZeFq5V0VONM8vhPvYHk6F
	SVOr1Dt8jkRcSc3JKnI3jnhoOOd0GzoRL8L4ym7F39p+jnXFlepA17xngdB5Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1729650365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=6ToOAMkpV3a2sSbsQlcf8VgemwRMvk+/hdji7SN7g8g=;
	b=CsZC3fyf5CPsgUqFRqxyP1NLHnegH5Zw5MtGvhFnpGokoQjDbyfn9IwAG6ioauRV4ZGaRq
	x9T0r+GJgoebxETbInXpjKLhTgSb1GuEF5Wr/JzSldWjNM3Wzre7jScRWXjvfnHB7dGwnb
	jaLuAd365iS6Nn4jhECi9d7/XHGYeG7nUIBRwcwcN6oC7KOh27AoIQme4in4MCjD/axHkI
	5z+Om0sifvhtyAPta1w39ymkPU0ZzA3I9g/JgQ0gZnEvMa0rMU5+Kb8N7ibDWZVqQJPxEi
	IJaBG4ZhBnIh88OK4xKKzwPRyv55XNMXF4lSMey5lZKH0l9pNJ9mw+CbgYXhEg==
ARC-Authentication-Results: i=1;
	rspamd-7d55d965b5-sg95h;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Lettuce-Celery: 272114fa7171783f_1729650365715_3605432993
X-MC-Loop-Signature: 1729650365715:1328253685
X-MC-Ingress-Time: 1729650365715
Received: from pdx1-sub0-mail-a233.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.0.56 (trex/7.0.2);
	Wed, 23 Oct 2024 02:26:05 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a233.dreamhost.com (Postfix) with ESMTPSA id 4XYCb040bzz2K;
	Tue, 22 Oct 2024 19:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1729650365;
	bh=6ToOAMkpV3a2sSbsQlcf8VgemwRMvk+/hdji7SN7g8g=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=aPBggA188uXZ37XUywmo4+3vqfdldB27twHo9svUEmIyY7hiUDBFRE56x7rvmJ7uj
	 lplKjTxoGg2+pVrAK+4W0Eo50YoAlKwlQZ8jeJ8f1v4uOt0leXftOA13TL1LZx8Lg5
	 hcnP9fZcTZPv+xJIvXEdr40W5rEBpFxAGx6yvS94nIPVzWIa9VLJ22QNo8uL9Dvyqs
	 5gEKEQ1ZBwejqg36zXHhiBzo8cB0z1GAn1AtT45FDppnZOqDWYJgf3bACdaeCT03OP
	 wUwb0jaKEUgJmDs5Fu7Gw487Jab2cBIRlj7Ca2hYmnePsNfx3BiK6mUXggB5mv8TZW
	 HCVidg/kUeiug==
Date: Tue, 22 Oct 2024 19:23:20 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: shiju.jose@huawei.com
Cc: dave.jiang@intel.com, dan.j.williams@intel.com, 
	jonathan.cameron@huawei.com, alison.schofield@intel.com, vishal.l.verma@intel.com, 
	ira.weiny@intel.com, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linuxarm@huawei.com, tanxiaofei@huawei.com, prime.zeng@hisilicon.com
Subject: Re: [PATCH v2 3/6] cxl/events: Update General Media Event Record to
 CXL spec rev 3.1
Message-ID: <i6snhmjw4njgl7mebvqk3zxwisdcwyxi54xxzqs36jdju23o36@elxtlbrjypbh>
References: <20241022105849.1272-1-shiju.jose@huawei.com>
 <20241022105849.1272-4-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241022105849.1272-4-shiju.jose@huawei.com>
User-Agent: NeoMutt/20240425

On Tue, 22 Oct 2024, shiju.jose@huawei.com wrote:\n
>From: Shiju Jose <shiju.jose@huawei.com>
>
>CXL spec rev 3.1 section 8.2.9.2.1.1 Table 8-45, General Media Event
>Record has updated with following new fields and new types for Memory
>Event Type and Transaction Type fields.
>1. Advanced Programmable Corrected Memory Error Threshold Event Flags
>2. Corrected Memory Error Count at Event
>3. Memory Event Sub-Type
>
>The format of component identifier has changed (CXL spec 3.1 section
>8.2.9.2.1 Table 8-44).
>
>Update the general media event record and general media trace event for
>the above spec changes. The new fields are inserted in logical places.

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
