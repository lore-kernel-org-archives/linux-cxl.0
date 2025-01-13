Received: from serval.cherry.relay.mailchannels.net (serval.cherry.relay.mailchannels.net [23.83.223.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E39165EFC
	for <linux-cxl@vger.kernel.org>; Mon, 13 Jan 2025 17:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.163
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736788129; cv=pass; b=BJgbnquc/E16ksYEzeCAS2NCacPJw2W3sL/Gbz0+MPCAzZyL4t4G3X2sDGfvUyuinqWHRhy3Q0CTMdzlLC0PberEro2JMHs+BUPIIWYsvrkxxC2OV7qk+/aPDAKKRoyHI8a5mPMOPHE/BqrO7G7Us7ZBZE53WpCDmfpIXng1paA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736788129; c=relaxed/simple;
	bh=LF3ZKWVxZ+7rUmrcUFebvBtf+SmEK5usM2UH4rV08Bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IFn/Oyarng7cRRtIBBLXlEV20J3imtOFf9RvD5S6fvdwrmoCEGalzAC+D+gXwz+qBaRcaEDFo6PMBvTdePWyTT0HYfORxgR2kAXOWNis3SXsGQa2g98yfdSyFtSKGt1Fv4zGgbplOiA3CfbpjPIqtBrox1un8QXGaR6Uv/nTllg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=KqiB87BH; arc=pass smtp.client-ip=23.83.223.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="KqiB87BH"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 9118B2C323B;
	Mon, 13 Jan 2025 16:49:45 +0000 (UTC)
Received: from pdx1-sub0-mail-a207.dreamhost.com (100-110-108-165.trex-nlb.outbound.svc.cluster.local [100.110.108.165])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 0ACB32C0EDD;
	Mon, 13 Jan 2025 16:49:45 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1736786985; a=rsa-sha256;
	cv=none;
	b=PiqtQGgqjOn77+2mNzVFphniTMfJ/cK34eviCKd5lUzimuo86kf9DohxcTeLV3vKeTsla4
	cdAkozZpMkOQ4kifiw1eda7QUHgOaZjNo4mAGu8Tnpm51soBBtILrBLV9AToWvZ/UcONbq
	/vFPCWP+ofN1nyNCWMuI5mBeBULlRWCrNVyOu7c79Vl+WaAr3iv7IqINLZXuRDRpS/tUGE
	3qzteAKFY0s3cO7V2X0Wrm5lY8pHF3xOdQE3aW5lg08DVTuTb/YARnB61IMORtYO1whmyY
	6E3yr27KOE2xHPOjVoaI0ghmB8GK3k2AILv8DLs866aT+sCCaqKQhgVDRBn4OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1736786985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=LF3ZKWVxZ+7rUmrcUFebvBtf+SmEK5usM2UH4rV08Bk=;
	b=j8SVdVzBKg9t9bbx28DsyUnSpcUG3Pn5I3OCnKQINFI3w8whYhdouIwXc/hIsmZ/a7wjx2
	QIYRTQuFXsMWar4uuQb7M+zt8KcS8bLXAhxgRAAX5Lv85O6OSDdfoY7f3qUecYAT8EsD42
	RIH5Z7LsD9Dytn5WjyKaCAagcTKQT3xG7D/s4+4+HXnQkmy0OqMdYnFgYJFgA7w6x3k88Q
	7w4ezkH7oiuFsp0QTCxVzz2+6s8mTeCNwyoW6jndWbDhB7TzfMyHYg4e3aadRB6SBCsB+1
	2q0qLmRRA+OlcJ2yjaF7XH1BD4/DY9tcaoSbAyMnSpKy1EhvETWrIAosEgfoyg==
ARC-Authentication-Results: i=1;
	rspamd-7df4dcbd86-d2q2t;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Spot-Soft: 0b094128349dca6f_1736786985286_3647490808
X-MC-Loop-Signature: 1736786985286:549089356
X-MC-Ingress-Time: 1736786985286
Received: from pdx1-sub0-mail-a207.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.110.108.165 (trex/7.0.2);
	Mon, 13 Jan 2025 16:49:45 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a207.dreamhost.com (Postfix) with ESMTPSA id 4YWysh3nksz9w;
	Mon, 13 Jan 2025 08:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1736786984;
	bh=LF3ZKWVxZ+7rUmrcUFebvBtf+SmEK5usM2UH4rV08Bk=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=KqiB87BHK4ANwl37ELlkMNkmmbYgGtSPFTGjL741bA6RJ937cD5cQG0+Sb+qsBpYi
	 nMBZkptuc2XtBbHAm3QxkpD/wLyhqr0XDrjWk0bKy1J9wizCLQwGss+owg1phP7NmC
	 wg9240BBT2lOwx4Wy9BHifCZxNYjZKKVqjDCIaf7DAHG4VmqqUqe6FP1zpXgbj0h7Z
	 1y2+toJ91RTvJZUmb97cjXhIoFRUOo8pUuOqpxLaYj+vPXD6r0ayl3YwDoRa3upwoJ
	 nsB/Jv5pgNV0xc5R2YoQhuhJkUikvIrzcWN1u78KCNJO6fqbdhGmGqolkahOXPkeH8
	 QTOW+UxnVGFvg==
Date: Mon, 13 Jan 2025 08:49:41 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: dave.jiang@intel.com, dan.j.williams@intel.com, ira.weiny@intel.com,
	alison.schofield@intel.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 2/2] cxl: Document missing sysfs files
Message-ID: <20250113164941.b75rlovjwbul5k5c@offworld>
References: <20250113025240.327124-1-dave@stgolabs.net>
 <20250113025240.327124-3-dave@stgolabs.net>
 <20250113125859.00003dcb@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250113125859.00003dcb@huawei.com>
User-Agent: NeoMutt/20220429

On Mon, 13 Jan 2025, Jonathan Cameron wrote:

>Spec currently caps it to 1MiB as well so a device reporting larger is buggy
>but I guess we don't need to mention that :)

Right.

>Units wise probably MB or MiB if we are being fusy. I think Mb is mega bit?

Dave, please shout if you want me to s/Mb/MB in a v2 patch, or if you
can update it when picking up.

Thanks,
Davidlohr
