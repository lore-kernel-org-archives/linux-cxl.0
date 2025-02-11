Received: from iguana.tulip.relay.mailchannels.net (iguana.tulip.relay.mailchannels.net [23.83.218.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DDA26BDB9
	for <linux-cxl@vger.kernel.org>; Tue, 11 Feb 2025 04:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.253
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739248272; cv=pass; b=F7ZR2c9QcBMApviQwUuMbkXQyLSClM/rHFJ0tOfAoMlWlYeNWWkABQKUch1R5oFEwQDREAg+Z0x9niDI6HYl/P48gAeJTt6YjfVmXSF5q8K98dZvrknyw36dTBVW5NrISGvlz1k9rR0qOnqghand6zqG0XrnUDkivrvTVdsRpEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739248272; c=relaxed/simple;
	bh=1u1evFtQKGY6ys9yWCLGiaLYxkvYIz2dxZICgRacoHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=itpHtgXr+XS4mrHYNlBPQqO6DG5wYBX4H7EXsoTer4AuWwi+xWqGSdnz7h/w+zGRH+SIQA4/v6fH7sPZojIoq16KarJUkhRyQYsc178u+EaA8Y7qHvmdGtPl2l1mPkCuImaRq73kE5y1pBaYM0WSbvA/V6q5mZlm/1CWV0jDw+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=Io2fNahb; arc=pass smtp.client-ip=23.83.218.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="Io2fNahb"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 5E494161E29;
	Tue, 11 Feb 2025 04:13:34 +0000 (UTC)
Received: from pdx1-sub0-mail-a260.dreamhost.com (trex-2.trex.outbound.svc.cluster.local [100.126.220.89])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id E163A162011;
	Tue, 11 Feb 2025 04:13:33 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1739247214; a=rsa-sha256;
	cv=none;
	b=xOLnHk+10XYIG2aMQ6NQwb8WzLdHzBy5sPmegf+k6vH1jzGBQmseuXHPGSjT5/hncyto92
	kS/Y63/e0YngC/tIi8EUGQaMtDzShBbPGivlpJjxxeeuzxbTNGEbykS15T8WsEoYanVOpo
	ba9fog9NDnk8Do1hd8IhZfNwR5MqcCZutqqrkc+kwe9XUl35wE+GL0aTeMwiM8PEFOoIwr
	2CGwEL7LbljCsIIHLuulg2Kxgdb8L1bFe9lwTDdhSlI4e6gs7FL8xPMBUMGBb+ULXPKDuA
	rcc3gCFvGdYRcdv5Ue+MmnrcSMvmyMElAjDg0pEpIRjS3SdfkRHlbkoCr6yMnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1739247214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=1u1evFtQKGY6ys9yWCLGiaLYxkvYIz2dxZICgRacoHU=;
	b=hMP0okX7AGU64KOF65Fhrn0jk7hmiWtwZHKG8UjAPqMB4OX4AT91dBUMWuINNYvbkGFKDG
	3ukTwIA441M4Ep5kd37Jd0Q8why4s6h8OXU9CVPLaecgmkx61rPBmAw9tw5g9r/0jnVOZc
	GvfYOZWFwbNplozGvFcbVTTQIPmBNsaNkcJUfDbM8jBuNWl2uLVxaRG46WZwvgTB53pakS
	kZHd306OgqmLejuY4djOUu6GmmauBW3kDpHz56zeNstW2BeELplDc1+TBoLhkLhY2xa+KC
	DAY4E4GAShGdaAOMnFRfARjL4ctoqGxsNAd1JFiEN6M8PH/Jd8x6M5guN5BqCA==
ARC-Authentication-Results: i=1;
	rspamd-587f8d7697-76bcz;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Dime-Bitter: 05723ce17d41e7ce_1739247214192_2591481593
X-MC-Loop-Signature: 1739247214192:3729780211
X-MC-Ingress-Time: 1739247214192
Received: from pdx1-sub0-mail-a260.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.126.220.89 (trex/7.0.2);
	Tue, 11 Feb 2025 04:13:34 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a260.dreamhost.com (Postfix) with ESMTPSA id 4YsSjn0vLYzLG;
	Mon, 10 Feb 2025 20:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1739247213;
	bh=1u1evFtQKGY6ys9yWCLGiaLYxkvYIz2dxZICgRacoHU=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=Io2fNahbikLZagRjgemRzil1IMqFyLYFXOqSg7uCvCqOjcugv9NQfeA4gfL37253V
	 Q37xPYoW3A/2PpZtg6cg8M9kFvCPp6rB7+MLRULtk1Lnrt7E3FWb17mDvvbjJv49r6
	 GSeQa3oF3P1kbTTRkqzVRwKp3/BHNta7U36jEmI+rHdUpYspRsWCuwj4AvJXpV39fz
	 8LrmtBC6BX/5x7fiRFgSq7Bp+EmEwAFtrB7SzRAG671H/t8U5zUcZ5RcK0lMmhqix3
	 v1YsD1lvz5ET3/RqY4MezTl66rg2e3usyJoQnx/qJnRccwJdclYQrwyUwOQ2QvmrYL
	 k3I8vNvUR8OXg==
Date: Mon, 10 Feb 2025 20:13:28 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Dave Jiang <dave.jiang@intel.com>
Cc: dan.j.williams@intel.com, jonathan.cameron@huawei.com,
	alison.schofield@intel.com, ira.weiny@intel.com,
	vishal.l.verma@intel.com, seven.yi.lee@gmail.com,
	a.manzanares@samsung.com, fan.ni@samsung.com, anisa.su@samsung.com,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH 2/2] tools/testing/cxl: Set Shutdown State support
Message-ID: <20250211041328.f63g36mlitrfxvik@offworld>
References: <20250205040842.1253616-1-dave@stgolabs.net>
 <20250205040842.1253616-3-dave@stgolabs.net>
 <a689a2c9-1fff-4c26-842c-74293d2e4455@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <a689a2c9-1fff-4c26-842c-74293d2e4455@intel.com>
User-Agent: NeoMutt/20220429

On Mon, 10 Feb 2025, Dave Jiang wrote:

>
>
>On 2/4/25 9:08 PM, Davidlohr Bueso wrote:
>> Add support to emulate the CXL Set Shutdown State operation.
>
>Should the CXL_MBOX_OP_GET_SHUTDOWN_STATE support be added as well so the cxl_test can excercise the sysfs attrib and other parts of patch 1?

CXL_MBOX_OP_GET_SHUTDOWN_STATE is unused altogether - you might be thinking of
CXL_MBOX_OP_GET_HEALTH_INFO? (which is already supported by the mock device)

Thanks,
Davidlohr
