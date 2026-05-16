Received: from slategray.cherry.relay.mailchannels.net (slategray.cherry.relay.mailchannels.net [23.83.223.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71FA28686
	for <linux-cxl@vger.kernel.org>; Sat, 16 May 2026 02:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778899529; cv=pass; b=BkwgI73AS1/mwLHk9UTqIMHVUGIauH2vEdEhONpXPiICONCW2rB23dSaz/vGd5zRuom9bxWeRq14H/EU1m7f74yJZLCCulPhk1/Ygn2rvRvpw+9aMDywqCS2X+eg2mVQaFYmfeoIGOS13OXG4Q1IcO7b5BXKRZ/rgitC8pkBYoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778899529; c=relaxed/simple;
	bh=yCZebKGAdLB2ozzlfgYN9EFHHUS195ILhlGAchKom4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qiOsXQkILhTVQMMCaXyEzk1nZo6O+1IwZN3/J2ZPr8uhuC507lusCPpDWw1tUjI7QASDC0cHdTyTZWC4A8d7V+AozyjJt8Anmm6HIY3+bIJrXUzMI3w7kY74C66tmX94r1+xcuufWU2bPwb0Zx6NsJ57WE/hkCbXg0iGvYDojIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=pFrNCB8E; arc=pass smtp.client-ip=23.83.223.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="pFrNCB8E"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 9E17964175A;
	Sat, 16 May 2026 02:27:15 +0000 (UTC)
Received: from pdx1-sub0-mail-a238.dreamhost.com (trex-green-2.trex.outbound.svc.cluster.local [100.98.28.153])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 40E86641845;
	Sat, 16 May 2026 02:27:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1778898435;
	b=puFAWfQWFGTImusgq0ARZBqYSg8gWOohsHM32eSSQR82drQBVIXOOEkhN8Z1iBt/KaqI1B
	FUObmNOFpw+WoXufb3mQ7eDWBLKK2Xt/3Mtti1tea7vPpmy4Xujp4SaOYiKwAOzFn2OKg5
	BTtCpEqspkRdKCkJ4Fb2q0NL/r7AKsUa4KYabt95YwIhhIjupNjRJioXVeXApuTU042qEf
	Qxn9lOA34szWVJR9g4ePmZIbi22cSy64BDENbW1yIvndAuwrAQ252rURPGECWYQz1MpU3/
	Mu5VXaQIrMa4+GzvdlJm+XeIObRRkCmiqmmNwMO+DhPfMeieRyLVnf5uYq7T5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1778898435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=yCZebKGAdLB2ozzlfgYN9EFHHUS195ILhlGAchKom4Q=;
	b=Se9WjAe0VNf8KIc+OwCaY2q1ktAxy0zgL+hMhXf+o6442j8Qwy1kmZFvJrdUo3o8qR3okL
	rXvidpmYFUeW3AuteIOkWOwyUKgm1c938pDJYtfV7jJsVXZ9ROjEHvbijDt1uMvwU5tiul
	8axML/PYt0dlxq7thoJYcpJ3d1sD4hX11rP6piI47/U9N9ZvTQQ+NDvcbw7ki8rKbkji/H
	b2cNnLH9xk8tvehIVTWDhPgf8WephbB0Q8Trrp86dUelCHvJGo78n0h2wrdSiV5zZHePCW
	/jBQw/1FWaWvjCyCRgwWpTxeGzgmBx7THwUPwB2GEFc22NKlG2fhpwv2sh6dGg==
ARC-Authentication-Results: i=1;
	rspamd-5c5444c55f-srnxv;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Ruddy-Arch: 5ec240e729a159ab_1778898435545_3184734174
X-MC-Loop-Signature: 1778898435545:3457473100
X-MC-Ingress-Time: 1778898435545
Received: from pdx1-sub0-mail-a238.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.98.28.153 (trex/7.1.5);
	Sat, 16 May 2026 02:27:15 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a238.dreamhost.com (Postfix) with ESMTPSA id 4gHSdG4FdDz102b;
	Fri, 15 May 2026 19:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1778898435;
	bh=yCZebKGAdLB2ozzlfgYN9EFHHUS195ILhlGAchKom4Q=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=pFrNCB8EynkCICZ1y7Lkxk401BRAIxJriuptDnKJH/BZyW+Tp+6v8SrlG0EqLRgI3
	 wIN7c0SIT17twyHKj7wM10n3JNIwZY5X75mUotODaf+6Y3Rg4jYhZ51lP7TKbWIWK8
	 /Jl3Q+0rMGTt+MYfI/gYBbg2ZBvAH5xBV/dBDE3iyDC4tOn9JqVv9WbTD3YAB0tTH3
	 0JhZU3hB71VS0b7B2fRt5YZqf8v/mk4/PjoxY1yhV6AyfC9HD3zvbehUVJF4vmEvq5
	 4F+dCXvBk1bLBWQDRvFPpxP/eGEKnwJ2NZjS2OmSd+dHL8lQNqnAf5LgksuHQLvqGN
	 ETsWC4C66Z3EA==
Date: Fri, 15 May 2026 19:27:11 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com, djbw@kernel.org
Cc: jic23@kernel.org, benjamin.cheatham@amd.com, alucerop@amd.com,
	alison.schofield@intel.com, ira.weiny@intel.com, gourry@gourry.net,
	dongjoo.seo1@samsung.com, anisa.su@samsung.com,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 0/5] cxl: Support Back-Invalidate
Message-ID: <20260516022617.ioafhfccxvv5as3g@offworld>
References: <20260516022037.1761453-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260516022037.1761453-1-dave@stgolabs.net>
User-Agent: NeoMutt/20220429

On Fri, 15 May 2026, Davidlohr Bueso wrote:

>Hello,
>
>Changes from v1 (https://lore.kernel.org/all/20260315202741.3264295-1-dave@stgolabs.net/):

Ergh, the patches that are labeled v3 are part of this series, fyi - while the cover letter says
v2, sorry for the confusion (of course along with the rfc, this is actually the third iteration
of this series :)

Thanks,
Davidlohr
