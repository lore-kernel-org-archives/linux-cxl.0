Received: from panther.cherry.relay.mailchannels.net (panther.cherry.relay.mailchannels.net [23.83.223.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FBC19146C
	for <linux-cxl@vger.kernel.org>; Mon, 17 Jun 2024 22:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718663153; cv=pass; b=cu0vjQwMWvAwmioZjVQdIYrCT/kvJtT7fWfXswJDtKOWGVgu63M6NpSN4mNWdnfV90IECXvbbfp0CmUT5bH2jIZB6C+JHvKH5y/V3glfwxFHpI5QENd3toGL6vDiL54NyCnhdAbtQ/1WIBxnuWa5WfN0VS1cdu2XANe09FBOwcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718663153; c=relaxed/simple;
	bh=vpYz8t9YuOeAJsRcPhf5Wbifw6nFEsi89t1mjzOi3Qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a+lUc7nBBWSgI03VqAHamICEWVB3GM5Y6HDG38tu/QRbZRAXvwnaljgRfMmmnA38CzphHc5UhoBVDB1CYRiTxqCZlntUeJPpbEFJ/53sNXKE77r/m/XolhXH/sykwFIleiyKnyGvh+V48Dzm5aXmk2mlWZKYmtJKwDzgTjQHMWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=NfspojBO; arc=pass smtp.client-ip=23.83.223.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="NfspojBO"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 14BB13611CD;
	Mon, 17 Jun 2024 22:25:44 +0000 (UTC)
Received: from pdx1-sub0-mail-a290.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 8E2483629E6;
	Mon, 17 Jun 2024 22:25:43 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1718663143; a=rsa-sha256;
	cv=none;
	b=X+Z+v7+apMrxv/BG1mbPzCjNGVNpb2RCsQoantexN66H4kB2rHhizD3kyKAzr+CViMC7VN
	Km+SGCk2v/biqNuBGVrgZN3GLRXThx2RbMWInCAaV2j7dwDX5s80LV/0a+OwEbWeDUsftw
	O89B9kPKZ1oFYigTWA4+zclo7CPemC52tDftSx2G7+hmm4TsnucCy21Zj7q4jcb8dyMnPt
	8cfWRZ1x3MnMeoXsTuD+bzEWBP0pwU/u815N7NZUMNwksJQrHzsPSfQPHwqchpCNSYN6bf
	ryOb4pG57O5TTWLGDVpnEQgNsioVz46PLS1fgcbfy2rprYspTL95+KwO3FP2cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1718663143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=qzu9GH4NDWJ9j7+uBXzZgm4NlitSX+X8XgXoRKxSx8I=;
	b=UC3c/6T9GxumXT83d+SpwGdPQjgT4SWyb6a04l3XSADEhjdyL4luFr0qMp+UiiJY5WGPE+
	wd9E8X9L2BgZQnIWyniy7gkH892lrnR2Md6LJFpi8lfNwpKb1dOyRbQp4Cv/loj1xGtzmI
	4u6rrFfBelMbNuwljD5FQlH8Rnu32gM0Zn0vXkZS0NdExxysFTB5jkBZybd9aABnrLXiG3
	SOtX67ownx48si+B+2knEhwpeKyg+Ln9gfREMqJHXvmVRM1XETKwFOHK3+FVy+P1xuKdcl
	ObtAHJZOzDKyopDo3mwTWLbjPgoieJXWMEYMYW3S9psvckVH9xG+FJ5gNaD5yA==
ARC-Authentication-Results: i=1;
	rspamd-7f76976655-lbphb;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Macabre-Obese: 4bd1672d5970b62d_1718663143839_3999204878
X-MC-Loop-Signature: 1718663143839:4104157097
X-MC-Ingress-Time: 1718663143839
Received: from pdx1-sub0-mail-a290.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.114.240.136 (trex/6.9.2);
	Mon, 17 Jun 2024 22:25:43 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a290.dreamhost.com (Postfix) with ESMTPSA id 4W34GH0D3dzJ9;
	Mon, 17 Jun 2024 15:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1718663143;
	bh=qzu9GH4NDWJ9j7+uBXzZgm4NlitSX+X8XgXoRKxSx8I=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=NfspojBOyd4ngrF4mKdG8hypHp6Bn036+uopfsPPUFNSW5OnCZ1TNDTnT4x5aWOrI
	 PlGx31tKaaO3n4IjFl3ZW6Wx325ZgTyG4gIpSwOOlbyc25VGt4qtjcLeWKY4m4lEyN
	 oEuQVnIGb85ClgGwwfSqxkwtdP7BFDPNpA/B3UBw5DVO6E1F3KtWHsnfBM0Zgmmzxr
	 anrdBAv90bv60GFNR1Ednu6xgu76HG0JxBvx51mLr//g7Nt6Kxnin8TF3QsnIhTVw1
	 87MKUFpSO4UKkE8Jlv4ZRjv8FOc+H6ft3EMxgS8BYrCeUBSD9tsukLP5gVE3tzyukH
	 W8B0wmeoACOxA==
Date: Mon, 17 Jun 2024 15:25:39 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org, 
	dave.jiang@intel.com, Jonathan.Cameron@huawei.com, a.manzanares@samsung.com
Subject: Re: [PATCH] Documentation: CXL Maturity Map
Message-ID: <lc4y4twjmbl2pciifinnjoa3opjex3344xvt4ihmwutg43exlj@xhys2cf5eo5i>
References: <171659842954.843002.8140957498380360424.stgit@dwillia2-xfh.jf.intel.com>
 <ZmEroVRLDDLdHIqL@aschofie-mobl2>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZmEroVRLDDLdHIqL@aschofie-mobl2>
User-Agent: NeoMutt/20240425

Hi Alison,

On Wed, 05 Jun 2024, Alison Schofield wrote:\n
>I'm wondering if Scan Media can be added to the list. I was within
>striking distance of posting that set when higher priority work called.
>Since it got pushed aside no one has cared :(  I'd welcome the chance
>to contribute it upstream if there is a justification. Can we add it
>here as a [0] here to keep it on the radar.

I'd be interested in seeing these posted, and am curious as to what policy
you chose to use to trigger this. fyi there is support in Jonathan's qemu
newer branches for Scan Media, maybe that might serve you for any testing.
The kernel implementation I used to exercise the qemu changes was based
on poison list overflow, fwiw.

Thanks,
Davidlohr
