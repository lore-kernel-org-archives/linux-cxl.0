Received: from skyblue.cherry.relay.mailchannels.net (skyblue.cherry.relay.mailchannels.net [23.83.223.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A494AEE9;
	Tue,  1 Oct 2024 02:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727750911; cv=pass; b=kAFVZ/C16BpvGgJpYwt3MYPYBRbBlgKclxVAdy2taOVns6fGJMOzxsIaOJxuJQxyIrtA9bbstpVJdRZKpCNOPqm9CjjNPdo7Fb8qp0igwzxfJCOU+3r0oaENYSvtH159EkPiV7orfnN2w7y9I1b78+ETFvznxE0faBj5KJSs200=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727750911; c=relaxed/simple;
	bh=pXnC0I5nFoihOuSkOJv2WVy9n/hXu5luM0AO1mqv84c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ou1Joo6P4+uO4y78JnP5QD3ujXXc04XPFFoT3IPOo2iyMAN/3YKfs5LKY71gGFpbCD2Vej0Nab8BRXDWX+wzfZCWr+uIrZvQ4d0m0ODWF+hJvJZsNBBXKOs+FrEfByw7EK4jtJLrtAFVf+lY2/oJDJL8GnLq31/g3q7jSZEZcWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=Xqhaygni; arc=pass smtp.client-ip=23.83.223.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="Xqhaygni"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id A114A82FE0;
	Tue,  1 Oct 2024 02:48:22 +0000 (UTC)
Received: from pdx1-sub0-mail-a311.dreamhost.com (100-96-87-216.trex-nlb.outbound.svc.cluster.local [100.96.87.216])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 32C7D82E00;
	Tue,  1 Oct 2024 02:48:22 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1727750902; a=rsa-sha256;
	cv=none;
	b=0kaveM/E9E+kS2N7Lv3Ssnodr7fPPX7kSP7efKRRwrvTf1ZX08rq47WY5JbZGyJHneqOaH
	i82pzDpv1wjBL3w/wKYh2In2gJwG8Qr73iGGKNdIBsjbT9zvl2LlcnMZYbNxVzY5TM/Y01
	VlCHW2oHDx2aLNxBaNh8qfI/WrAoFUsolIVv7nFbi0HzUDKqHvafFIN8AVEz054xFvSStU
	DbcfRPhTsqI01BPNw6MXqwjO6v1qkDzwkeH7H36FEaYf71z4BRX7cJCrlScQ9tZf/IkaAi
	OKI6xLk8gktWOgbxC05siexfYT5oLhzryCjRfHa1Tlz1Qh6M3vZ5bolJkdggOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1727750902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=+OzDF51qHcsxAKYk7mQb7m9zf6kbvxorNI13kUbqlHs=;
	b=fwtilx9McqGMFXtVHIYx9+nbcR6plCdZffcE7neO/9CVf8GnL8bTcDA08CSiqCGf4/wQyZ
	D/mkqSPXkOPpO9FN29IRLu2IZf2UPTVcxQCwQpX2IJp3Gl42k3UV00o2rSiHrZhzOEd+s6
	zVyf64Cf7TOhKa7GJPobD7sFYliVHS+Jw/JS+8dJkvXNg6aLsrMEpWTjvLlD2Fp7XVHfdn
	iSIVPBTMlMGLLUKm8/6Pgnpk8Mitr6ohvedRb7FJIGi5pEfXRHyJw4oaoqZp7421ybHCeN
	2e42EvQyBzgs1v0NJxNr3fZDhefBvNWXiPPDU/+X0AOuRUFZ87lCrIRiSqhYdw==
ARC-Authentication-Results: i=1;
	rspamd-9d66c6866-z8h92;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Trouble-Lyrical: 77a35d3a52075bfd_1727750902479_2277151766
X-MC-Loop-Signature: 1727750902479:1982707863
X-MC-Ingress-Time: 1727750902479
Received: from pdx1-sub0-mail-a311.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.87.216 (trex/7.0.2);
	Tue, 01 Oct 2024 02:48:22 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a311.dreamhost.com (Postfix) with ESMTPSA id 4XHj6s2ZGjzGP;
	Mon, 30 Sep 2024 19:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1727750902;
	bh=+OzDF51qHcsxAKYk7mQb7m9zf6kbvxorNI13kUbqlHs=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=Xqhaygnivi7U0M/nFzgy2h26I7egcM1+IuPxD+GwAUo8LXlKprlmg2cXYEZ3bvUPx
	 0dmjl4/Vn7z/m+z1RpLUcq6QyqGzGLvM0vQxyF94btlF/VJ3r2QYD6AeY1vfSe2VoU
	 4u/vgjsASdXpok78JXjHkmEdzUbjO5+Q6Av5vuYZ9KS/4wqvxmyOaDwLYUVHbQ95ft
	 QfXeG9StELaQM/4gdGIUHoqHv67pauckBvUl+o6xoxWxuNlDdn81rPuuSjlB+MrfU7
	 zTzE4i9xNeeHntFnoq7grznfU/zlLjWUYsCcjD8b1nbFA2rwYRORdRl1ZxEaTi5VMy
	 txthvqKn8JSwg==
Date: Mon, 30 Sep 2024 19:48:18 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Huang Ying <ying.huang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [RFC 1/5] cxl: Rename ACPI_CEDT_CFMWS_RESTRICT_TYPE2/TYPE3
Message-ID: <20241001024818.lvby5jab645nhnsc@offworld>
References: <20240925024647.46735-1-ying.huang@intel.com>
 <20240925024647.46735-2-ying.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240925024647.46735-2-ying.huang@intel.com>
User-Agent: NeoMutt/20220429

On Wed, 25 Sep 2024, Huang Ying wrote:

>According to the description of the "Window Restrictions" field of
>"CFMWS Structure" in the CXL spec v3.1 section 9.18.1.3: CXL Fixed
>Memory Window Structure (CFMWS), the bit 0 of "Window Restrictions" is
>formerly known as "CXL Type 2 Memory" and renamed to "Device
>Coherent", while the bit 1 is formerly known as "CXL Type 3 Memory"
>and renamed to "Host-only Coherent".  Because type 3 memory can only
>be host-only coherent before, while it can be host-only coherent or
>device coherent with "Back-Invalidate" now.
>
>To avoid confusing about type 3 memory and host-only coherent in Linux
>kernel, we rename corresponding bit definition from
>ACPI_CEDT_CFMWS_RESTRICT_TYPE2/TYPE3 to
>ACPI_CEDT_CFMWS_RESTRICT_DEVCOH/HOSTONLYCOH.  This makes the kernel
>code consistent with the spec too.
>
>Also rename the corresponding cxl_decoder flags
>CXL_DECODER_F_TYPE2/TYPE3 to CXL_DECODER_F_DEVCOH/HOSTONLYCOH.
>
>No functionality change is expected, because we just rename the flags
>constant definition.
>
>Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>Cc: Dan Williams <dan.j.williams@intel.com>
>Cc: Davidlohr Bueso <dave@stgolabs.net>
>Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
>Cc: Dave Jiang <dave.jiang@intel.com>
>Cc: Alison Schofield <alison.schofield@intel.com>
>Cc: Vishal Verma <vishal.l.verma@intel.com>
>Cc: Ira Weiny <ira.weiny@intel.com>
>Cc: Alejandro Lucero <alucerop@amd.com>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
