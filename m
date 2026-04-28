Received: from buffalo.birch.relay.mailchannels.net (buffalo.birch.relay.mailchannels.net [23.83.209.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945A4233D9E
	for <linux-cxl@vger.kernel.org>; Tue, 28 Apr 2026 23:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.209.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777417418; cv=pass; b=Rdrrv4gzhsubqedS6ENPAO584PfyipgxrIUsAfV4100s4zuplaZFbEeyDZmyIHPJerHMQ6ZZriKhCfPWn7LXf6EuoU5eTkjgwYxg6s3lCRUvK/WkItzd0ftgwpTHtC+pSVWDcJXUUqZmqRYNX9AvBC8JlhC+Dc/+q8eFpMcW5LI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777417418; c=relaxed/simple;
	bh=X3F6qsvH4KZxXHXnQqnrrNz2Sxq7teGuR+dVDDtAstg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/rTjX3iQfjTHcJqCXDW7qtMEyKuyfbYNFxl6whXPGYIN5fQNV7D0IjwWZV328l6p/k1vf2Ne5T8gy/iMz50GpiPPuuuJVBxroZ5cJwyfndx3aiUqepWKu+ngI0PtkH4l0oBgzJnGo0XJFSbRWV2ZxYuIkkuCsBsWMfbceubcdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=EZ2mxof+; arc=pass smtp.client-ip=23.83.209.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="EZ2mxof+"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id DFFB54C19BA;
	Tue, 28 Apr 2026 22:47:04 +0000 (UTC)
Received: from pdx1-sub0-mail-a234.dreamhost.com (100-96-22-203.trex-nlb.outbound.svc.cluster.local [100.96.22.203])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 88CB64C2585;
	Tue, 28 Apr 2026 22:47:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1777416424;
	b=NAfhbBy9Jks7XpJ583/1qasDFlYzKUPQxgMZ6Gp08rfNK1dbhTxVZaXEnNOffrj2iNfo+s
	aQtF39g8KWz3G9N/hdQIbUWp4GFQzePxu8hxhYir7ex08pLo2eek9jeDwojO9pFHNVh1bC
	F/MwqmtCHwWuZJi1QGMp80DSzZh9EzzQIAVtglMqgB4ZmykAnO4hDGsujln6jRZhY+gDJS
	VdX88iFmUNscAbnYiqVuK9Zdrs5yVODo4x+ENRkQCo7e6x77RxsM85iav7pYSRuomSe4ch
	aQjS0wgfL20EOIZKS1wpmdN2xBL6EZ7nCHBNtgvL7r8Z0L9Yz3yOBMQQsLaR6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1777416424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=X3F6qsvH4KZxXHXnQqnrrNz2Sxq7teGuR+dVDDtAstg=;
	b=pgiZGrKPvKmtz4crjajwIbjQBnJliBUZ4Uhk0EzlVvlZAWbu3OmvNAc4tJwbkhy4ThMy/W
	mBDuwo7xMtt/Aq8p3Vpjxd5MNExx3OcOGU5N4684IlOF1Xm7gyhKWRVYmytXWud/yq2mp0
	Ld8HYVKquHSekvu6bigLXjkoxS+P1ER66awGdMn+TjFy9k38w1eBqGB239q/+XdtlkfJtt
	LaqSD5KlpE1vtHnNNs5zQukcMPfiJv6SH9WpqTHCS9bf4we1lKvXq746kmCdw3iUxTcpre
	vhIVJR2dOuVDgaaC4A+EPG7aJ3Cz4H4l0m/YZEKw+igh4nvUoCEcR1B+3+9z3w==
ARC-Authentication-Results: i=1;
	rspamd-b9d4fc544-27gcj;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Cooperative-Cure: 1584e8181a964412_1777416424801_899143379
X-MC-Loop-Signature: 1777416424801:3174049784
X-MC-Ingress-Time: 1777416424801
Received: from pdx1-sub0-mail-a234.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.22.203 (trex/7.1.5);
	Tue, 28 Apr 2026 22:47:04 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a234.dreamhost.com (Postfix) with ESMTPSA id 4g4wY352r2z1075;
	Tue, 28 Apr 2026 15:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1777416424;
	bh=X3F6qsvH4KZxXHXnQqnrrNz2Sxq7teGuR+dVDDtAstg=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=EZ2mxof+FDi/hDP0iGQFQ7u6FDHnhkQYj1MYZcROkWPmuyCBso46HmcTtSZpEgcnj
	 WWjkwBmeH3av42TkDuRDsO0LyuFrStHlZp9qxoXO3CLE/0Magruh4GCERPgSE8M8+y
	 npwD8MukBn4hA+hAJXu0nQa4JZORHAdWiFYHTPJtt26mFYq1BwyC6tP6CMeyOMCbe5
	 oC4NdhK1cqWesKZgZAlzninpRgTDY9+ZYn4lsTN300ohAfsxI4yGgCWLHRttYFIhh2
	 7ORVDKOAyliBNX1T97LTagn/UTl+4uDuZtKDEB2aLxWkhWrmJyN3En7c4/h9YYWFmH
	 lM7SITT7MyyuA==
Date: Tue, 28 Apr 2026 15:47:00 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Dave Jiang <dave.jiang@intel.com>
Cc: jic23@kernel.org, alison.schofield@intel.com, ira.weiny@intel.com,
	djbw@kernel.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl/mbox: Use guard() for mbox_mutex locking
Message-ID: <20260428224700.koa6ls7thc5ggw27@offworld>
References: <20260428212220.711160-1-dave@stgolabs.net>
 <b96ab07b-a134-4417-86a5-386c17829977@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <b96ab07b-a134-4417-86a5-386c17829977@intel.com>
User-Agent: NeoMutt/20220429

On Tue, 28 Apr 2026, Dave Jiang wrote:

>
>On 4/28/26 2:22 PM, Davidlohr Bueso wrote:
>> Use the new helpers and simplify the code. No change in
>> semantics.
>>
>> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
>
>Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>
>Is this in prep of media ops?

I found the open coded locking by doing the media ops
patch, but ultimately these changes are independent.

Thanks,
Davidlohr
