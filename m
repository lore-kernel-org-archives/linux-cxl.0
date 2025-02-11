Received: from sienna.cherry.relay.mailchannels.net (sienna.cherry.relay.mailchannels.net [23.83.223.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F70253B43;
	Tue, 11 Feb 2025 16:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.165
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739291166; cv=pass; b=JFQ14l+2dddhbKK2IWSqlif2RBJIw0m4nrCMIi+nUiHgcBFWv0GZjSM6xkvUZTaX+9ukTwWUmAIw8yWszsKry/LL4yluL4IEgutIIAFP6XwvxnTXOoalcG6OLwryJJt5iE1SdTNDOMNIyJ8X48jFzTQgbsPPITgTv6vAr1xIkW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739291166; c=relaxed/simple;
	bh=qwYi2UUDH8EB5JiCzhvOVvEE9T4L6yaTCiw/wnL4Oao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MbPuprkHEeyJhGG+Z06uBIFJXxfVs3cFx0BgwnQcXZmmyLm9RIac3hsmtuWj4iAD5b0YvYim65XGy4lcS2pnsWP6JDQeS1JsRcM2RrWtt2L5NCa5G07n9GsHNUF9TZcltaWjTVqGWDXPuHy5sLtzRbe6eS7x/sO17L5arS1qnw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=U4ApvGVQ; arc=pass smtp.client-ip=23.83.223.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="U4ApvGVQ"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 8F6E0782F0D;
	Tue, 11 Feb 2025 16:25:58 +0000 (UTC)
Received: from pdx1-sub0-mail-a292.dreamhost.com (100-122-220-145.trex-nlb.outbound.svc.cluster.local [100.122.220.145])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 076AF7825BE;
	Tue, 11 Feb 2025 16:25:57 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1739291158; a=rsa-sha256;
	cv=none;
	b=dXSfLF5yD/LQA6mcuLy9+IEAPH+d8EAWq3/w4E9iunuOEjEhgPvBIfNPbHgNlySeKN7yVf
	7RiPdE1Gfq4QdYa6/cxtEMFUti/ysfX7y17EQgkfAZy/2/CaNKpAcsQqEQ1Ll3TKtmejP2
	FSK4+cpnbKSGJWf+AJQdYgqfet8L4sT7lAxFbx7pDlyK/lMPgiei5Gac+ATaJYdMHsaeLS
	8MvzvVOmBdvUxGpabP6EAXGB6br/uf4gwaQWBcIRpsxVcHIwLAKZ+hf9VgwA4xfFXDQSiR
	Ybdw7994zBICUo+AL+RqlXUuTAnkcqiPo37qo7KEaD/I5E7lXA5PSaRX01yUkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1739291158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=qwYi2UUDH8EB5JiCzhvOVvEE9T4L6yaTCiw/wnL4Oao=;
	b=xNkptpAiU7E9vkMMtl5BmgEho1SNAGQ7Qd/MtH5p/cOhMCWyeBMWyqx8XnjwYyOMTk9Loj
	79D/j66QfVE1qA+WF9s9iCzPnA0wEIvXL0o4pMZXUufovbOznsRr8aRnnbQfCrTqZjGeQa
	GJkmRA5cvv/UPiBZGI7bVaDl6SJtpHPtUzsRCV+/mdxLyk7W03efpc27H9R1rDNJy8VXWK
	M5JdftPAvwyT99c70Z6qUHr/SEYbOyju62AQQ8OF2w4N6CkuYY47IghBiUlEqVs6i1bJ5m
	NLnQUZAgSEcnrg6ZUcOW/83giZkuPhKS/nZCODpBXqTP8ECwkjZgrwMyZ74D8A==
ARC-Authentication-Results: i=1;
	rspamd-68c88d6cff-mnvtp;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Interest-Unite: 24c0838b56538522_1739291158331_621628707
X-MC-Loop-Signature: 1739291158331:3069174138
X-MC-Ingress-Time: 1739291158331
Received: from pdx1-sub0-mail-a292.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.122.220.145 (trex/7.0.2);
	Tue, 11 Feb 2025 16:25:58 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a292.dreamhost.com (Postfix) with ESMTPSA id 4Ysmys1Z73z25;
	Tue, 11 Feb 2025 08:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1739291157;
	bh=qwYi2UUDH8EB5JiCzhvOVvEE9T4L6yaTCiw/wnL4Oao=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=U4ApvGVQI3cWGXIv0c/oHebXaQxqqK4GkDpCCue8+vOdIX5vbrND+V/rs+xM+MtR2
	 9EQn8YAucnRDKwjgEUQIJNpGa8L/AMlPOmcOkKAhkqUFbYmSEidnwJxnNZxgUbXCNN
	 1hjj9n6euI7jNCpfn14G+WYSfW8FVc9zE4tS1bxIAe2ff3YMK1m3YhDWk+URTyZIEW
	 0IOgzNE4szxbRgB4JyhuejrExjkWNRFc4cX4TGMJBneLzjvAThdE1BYT6h0xYRHTHE
	 64UqhmbQoYbmz0TjKUzQfOG6LN/+9rP+rq6Quy3qhIywOa00Tm21ktIyh4TQjiNxH3
	 C8nYWBNE60YUA==
Date: Tue, 11 Feb 2025 08:25:54 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Li Ming <ming.li@zohomail.com>
Cc: jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] cxl/cdat: Remove redundant gp_port initialization
Message-ID: <20250211162554.37qtvrdazzlkj4ne@offworld>
References: <20250211062054.300108-1-ming.li@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250211062054.300108-1-ming.li@zohomail.com>
User-Agent: NeoMutt/20220429

On Tue, 11 Feb 2025, Li Ming wrote:

>gp_port is already pointed to the grandparent port during its definition,
>remove a redundant code to let gp_port point to the grandparent port
>again.
>
>Signed-off-by: Li Ming <ming.li@zohomail.com>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
