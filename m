Received: from buffalo.tulip.relay.mailchannels.net (buffalo.tulip.relay.mailchannels.net [23.83.218.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CBF34BA3C;
	Sat,  4 Oct 2025 00:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759537360; cv=pass; b=Fqyii+YNIZdRZScUSQcG/q4xEHST23v/R4B0/ss5Ok7KjGyJnTJA0iSOUdxWVOUqaHBRMge4/KSrEsDixAYahyko4JZWiMmY8KNEN2j1a3B9k/hRK7te7UXUcn5GVD/ChGwtnoeyBExBE/WmeFhnEJbxsi6EWaK8wdCY2wcBers=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759537360; c=relaxed/simple;
	bh=LRcgf3iMEM+qjHK9Z81mTEyoMcFrXF8kzKv7ohcJMuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RQyHRREpyCJv+V6XO0lkab1cIHS/t9g9AaSK5UjPlMy5Rv4B+jwgvbPHYisQ1DV/azOnyiZzoHXQPPhzGxr85rz9VonJYGIcUqfN7LxcuNlDzZvyMhgD13rJZlRtvYy2FUeaMqOa9nTa8XPZaHIr9gwZHDvGZPMtI9eBFc2QiHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=X7STbMa/; arc=pass smtp.client-ip=23.83.218.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="X7STbMa/"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id F20D66C203E;
	Sat, 04 Oct 2025 00:06:35 +0000 (UTC)
Received: from pdx1-sub0-mail-a275.dreamhost.com (trex-green-3.trex.outbound.svc.cluster.local [100.114.209.105])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 7B15C6C1FE5;
	Sat, 04 Oct 2025 00:06:35 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1759536395; a=rsa-sha256;
	cv=none;
	b=Ycbg9AVr2E5HumI49jjjkYXOdhcUclfAQJP6eJ7M+Ac6SCqYTquwb6za4bFuNFoVcGa/sZ
	YJq3yPihUyU7aTANZQw8ZzAo3+wvT5UUwdB7kL4rwIzrkh6cEPiMUYzdHJ7ZRCMOuUvK55
	T1Fn1+2T3F6AMGNVdjSd2j2+w99+agiXgU2IDuA0I9hzkgxVCa0ONwIaF7kFhqkqaOttR0
	usxJntlNICWf6xXdw3JhRmoOYp/lXEEXJwfETwlhjqtc11pckC4LVVbbauW/ADE7JGOWdj
	v+Zw4ZEOtwIv6ynppV+7jZt06lxo9oZzdNp5llbo1tyZjQ0pUhAKvMy4XNTHkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1759536395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=LRcgf3iMEM+qjHK9Z81mTEyoMcFrXF8kzKv7ohcJMuY=;
	b=aGvhjLoqmjZJTZBXdp9UbBSPcJL/oRBiebnT59Xu2ylgN0qVzaiY4yL6qrv9xAmzi4LDgR
	Anv4VmRv4K8W+NuFijByLYozt04KocnJBLTA2mpBzikY2noMDLP25AnomzxA7K158FyeMp
	PqMxqmI8cT3goOXR94VLk5z9ZVmLu+BDjmtDYJrxVKdAhsIBikej4q1ddn8l4+V893JRUx
	wMIyDO43I/+kwNzr97NsW10nWcCF/WA94JwkagjrO9OGUIKTcNVfBTKwydbiBxhlHKltxW
	fLJiEDs4LQ//aHIa+PdruD0SR5Q97DK1+witZWIjqgMpZWUraxe8YW9BF7iY5g==
ARC-Authentication-Results: i=1;
	rspamd-84f8cfc67-xc8ls;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Versed-Absorbed: 3f6264a7705c779f_1759536395825_1284957329
X-MC-Loop-Signature: 1759536395825:610673563
X-MC-Ingress-Time: 1759536395825
Received: from pdx1-sub0-mail-a275.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.114.209.105 (trex/7.1.3);
	Sat, 04 Oct 2025 00:06:35 +0000
Received: from offworld (syn-076-167-199-067.res.spectrum.com [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a275.dreamhost.com (Postfix) with ESMTPSA id 4cdm6L4Q8Mz3J;
	Fri,  3 Oct 2025 17:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1759536395;
	bh=LRcgf3iMEM+qjHK9Z81mTEyoMcFrXF8kzKv7ohcJMuY=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=X7STbMa/CsLXoBJglhKm3fE5hAXExPGwpmE0cyFXJ3uxcqCHwSDsmGPwF6/ivGdm6
	 jZJBq47RIInjvKetG+lSEaVuVW7j2KxtZkmL9jRVTmtO+RWaNWUmVRtGuy1+2ux/IY
	 B1yhoHmz0CUfCYjwneOKqqCOt6InU0FT+fAvLZnoz0erCdcNu8l3BNo+WLaHadmj2+
	 C5hpCtbzsyk/g4Lec6V905ndrbRzHcFRaYploh8+CVmpIPyTsuPsopF26JBhXfS9EH
	 CSM5FEccG26YZhkK/nHHEl/ZdW/h84jScZNbQILFjxZP6l0XbLmgnPSjAOwz0OfgSC
	 qINTtB8CV0lIA==
Date: Fri, 3 Oct 2025 17:06:31 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Vishal Aslot <vaslot@nvidia.com>
Cc: Dave Jiang <dave.jiang@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Li Ming <ming.li@zohomail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Zijun Hu <zijun.hu@oss.qualcomm.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] cxl/hdm: allow zero sized committed decoders
Message-ID: <20251004000631.h4vnnpxathjyoez7@offworld>
References: <SN7PR12MB81316C958DF0F4B10369B928BBE6A@SN7PR12MB8131.namprd12.prod.outlook.com>
 <cb300580-1297-4d4b-9a3a-2cf7445b739b@intel.com>
 <SN7PR12MB8131FBDB82D2A3A539FA09D0BBE6A@SN7PR12MB8131.namprd12.prod.outlook.com>
 <70a2ea96-0a4b-4185-8f37-ea77ed757b64@intel.com>
 <SN7PR12MB81319CD146CC8B4CFD45E62FBBE7A@SN7PR12MB8131.namprd12.prod.outlook.com>
 <SN7PR12MB8131F796BAE8B6243E088879BBE7A@SN7PR12MB8131.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <SN7PR12MB8131F796BAE8B6243E088879BBE7A@SN7PR12MB8131.namprd12.prod.outlook.com>
User-Agent: NeoMutt/20220429

On Fri, 03 Oct 2025, Vishal Aslot wrote:

>init_hdm_decoder() fails with -ENXIO if a
>committed HDM decoder has zero size.

This can be removed.

>
>The CXL spec permits committing zero sized decoders.

This is enough info, no need for the quote below.
And then add "Linux currently considers them an error".

>See "8.2.4.20.12 Committing Decoder Programming".
>It says,"It is legal for software to program Decoder
>Size to 0 and commit it. Such a decoder will not
>participate in HDM decode."
>
>This patch updates init_hdm_decoder() to return
>-ENOSPC if the decoder is commited with zero-size.

This is not needed in the changelog. Instead the reader
could be enlightened for potential reasons and use
cases of 0 sized decoders.

>The caller leaves the decoder allocated but does not
>add it. It simply continues to the next decoder.

Thanks,
Davidlohr
