Received: from tiger.tulip.relay.mailchannels.net (tiger.tulip.relay.mailchannels.net [23.83.218.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E59819AA46;
	Wed, 23 Oct 2024 14:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.248
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729694861; cv=pass; b=XWpe9Oa2S1j2iUJnOVV2FKecJkJVBziSRm6giFOPL8vg6pug95QRj27nGW2D5bMWspXpS4YeWfB/MK57dpa54dDYLhalwzxzrZuXfO51AuMuziPh4Z8hC5MtdPI1O1KQnHlR02AQlLi5J6MTcxcgJ1XU/aIVoGpkCAcNTVLdVG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729694861; c=relaxed/simple;
	bh=Wq0dA0YgYkx6oieUjtNf5P+KES/bvf0EHBmJ8a3q9KE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iRvTagVGScL/783eXwC0Rl6E3v4NJjajxXmMiNGyqUnKrjXioALTPrFNd0ibxY+BF+kjeUyO60/2sWH9t3LLMkvBYm0e9fZEJ5ntG8RjnDx+I6wJ0sWEh3OTTpd+re6wUXHHwoFLY6sgx0FR7wjhm7GvYqfcxOX43tDRqq2Ct24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=j4p+/Eyi; arc=pass smtp.client-ip=23.83.218.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="j4p+/Eyi"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 14F01824CA2;
	Wed, 23 Oct 2024 14:31:58 +0000 (UTC)
Received: from pdx1-sub0-mail-a203.dreamhost.com (100-99-180-172.trex-nlb.outbound.svc.cluster.local [100.99.180.172])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 7440C823778;
	Wed, 23 Oct 2024 14:31:57 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1729693917; a=rsa-sha256;
	cv=none;
	b=igBP2dws7Oo+iAR/mnIwjeFVi9BCqevwLWywHGzF+xd4fH+bt9l4tvw6F7Y++V8uxudTZY
	UfAf2ExE9W40QfLdbgl4zzIGOCvTbE/mNWxnw/WpAwq8vhskq7I/rAtxOifhU0Tbv3l7DZ
	sUnrtrug5+X2YukKtP8cfr83A4dnJiiLAyAG+eDfFlI6jBkmv0f0YR3XK1Yd7/izA1+cDt
	ykztHXxiWH9rTzvcWT9dJvmdWVtzF1ij+Db96rU1y5dDNKcwwFRyuXmbLDIFf5mxco/Mzf
	O5qp9oeXTUGZeJ67BD/iZ9OELqYY2jfNNjNZugcBBYxIZCztvqgJt0vplE+JeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1729693917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=cuwb0qfrZ+dwEeP5isad8UT75Hf/mN+0+CRZKGSnS24=;
	b=2/Y/i2roAhsQzFRKOOwzSTsguj8IyK7EUpsDiwGS1bk1C9MUwGX7dXY67OvzOv2aSwwkeR
	U0ZEfJ8mej57wtFm23RKhTd8l4Rzfm6VrnkImNP3+RLtiIHUpmRkOSoxSky2KMsLnXxeQR
	EIkqoHeMNb4sf5yi1+pzwhA94VuI+cJS2VHt11gPJTyu+gLp/PYrp72im5nWG3IyLhI1P/
	24vzjyjmk9nxqghkPyRTVIstsW6AWvBao/vpB7ybAyDzw0vYplmqDyShkbCMaBUzDJ2Gyv
	qFvKOdtyBbsyTkHxSwqCaI8wSJafOvAjlu6K9byihk6/Dcz/28SITJL92uh66Q==
ARC-Authentication-Results: i=1;
	rspamd-7d55d965b5-wpbvg;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Keen-Squirrel: 7debb4446993431a_1729693917865_2424783291
X-MC-Loop-Signature: 1729693917864:4003134109
X-MC-Ingress-Time: 1729693917864
Received: from pdx1-sub0-mail-a203.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.180.172 (trex/7.0.2);
	Wed, 23 Oct 2024 14:31:57 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a203.dreamhost.com (Postfix) with ESMTPSA id 4XYWhX3HzKzFr;
	Wed, 23 Oct 2024 07:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1729693917;
	bh=cuwb0qfrZ+dwEeP5isad8UT75Hf/mN+0+CRZKGSnS24=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=j4p+/Eyi7pp1WH0N3r5BeUOKrp/MIP7URV/b6xx0g5YK9s65jheAPyOz12ZzPIn+X
	 Cj0PTRalDXCi7tIOpBifq4928lft9PAkJxsnr/6MXaNHmMKG8fT16FuhvNS/Mug5St
	 luxK2Z2KzxppFAJXyQaYHxQA8b5agNfwJvkYyXXCJKBCFYLlRMeGtLTL9Wd9Cr+nxD
	 XBsHNW2vePvV6f8P/BtruzoEHgaIaBFS5x0oCWuB3VnkdgFLNqJZOufrLpZprgFrOw
	 29BtO9mhVZsREwmn3yPTd1dOYCu7plr6husd91bZb+Idnria6WK8Wwa78/Xl8xWI4w
	 zCcKl+XK6k+ww==
Date: Wed, 23 Oct 2024 07:29:10 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Ravis OpenSrc <Ravis.OpenSrc@micron.com>
Cc: "dan.j.williams@intel.com" <dan.j.williams@intel.com>, 
	"dave.jiang@intel.com" <dave.jiang@intel.com>, "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>, 
	"alison.schofield@intel.com" <alison.schofield@intel.com>, "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, 
	"ira.weiny@intel.com" <ira.weiny@intel.com>, "fan.ni@samsung.com" <fan.ni@samsung.com>, 
	"a.manzanares@samsung.com" <a.manzanares@samsung.com>, Srinivasulu Opensrc <sthanneeru.opensrc@micron.com>, 
	Eishan Mirakhur <emirakhur@micron.com>, Ajay Joshi <ajayjoshi@micron.com>, 
	Srinivasulu Thanneeru <sthanneeru@micron.com>, "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] cxl/mbox: support background operation abort requests
Message-ID: <zrmn3j2wzzlnzzwunk64xfy4jussoiek5ro73qs3yrjqflemtz@zbn53a27tt6y>
References: <20241022031809.242591-1-dave@stgolabs.net>
 <feef15c9fcfd462e9b3cf614a1b4621c@micron.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <feef15c9fcfd462e9b3cf614a1b4621c@micron.com>
User-Agent: NeoMutt/20240425

On Wed, 23 Oct 2024, Ravis OpenSrc wrote:\n
>Hi Davidlohr,
>
>   We have recently submitted an RFC to implement Request Background Abort
>in case a timeout is encountered while executing a background command.
>The patch series disables those background commands which do not support abort
>based on their individual CEL properties.
>
>https://lore.kernel.org/linux-cxl/20241017163215.00000547@Huawei.com/T/#ma6710971908b85a5f8c5da2e23b8102b5a6e277c

*sigh* it would have been nice to be Cc'ed.

>
>This implementation is based on Dan's suggestion in a previous thread.
>https://lore.kernel.org/linux-cxl/66035c2e8ba17_770232948b@dwillia2-xfh.jf.intel.com.notmuch/
>
>We can discuss more on how we can potentially merge and arrive at a common ground.

I think that my approach is way more robust then defining a timeout as in that series.
It also aligns more with Jonathan's comments about the abort being on demand.
