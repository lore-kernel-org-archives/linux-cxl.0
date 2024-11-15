Received: from sienna.cherry.relay.mailchannels.net (sienna.cherry.relay.mailchannels.net [23.83.223.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537F31D435C
	for <linux-cxl@vger.kernel.org>; Fri, 15 Nov 2024 17:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.165
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731692882; cv=pass; b=e2/1QpLsba4pfqH3R0iD+/B2gkMe/9WN5myg0Nzlm/j1YwkULVmb09I/SDpW76jJk3DQMfvRWNdcHp3K24YEvpBC9YX4VTgECWOsdJ/uVjMeXnDEPv2o3nEUV2gtcuTT90WM2rkP7nX/k1dTTa7ROWQuykkJmYHWnlCZ7mwIpDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731692882; c=relaxed/simple;
	bh=55j9nk+yfPJybTeNpai2YpNDm1xcPIoEdpaX4HwnEeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OYvpd4QycxevX6UqnKP7RLbWFUMIJLX/r+C0J+kIyTErYR9WrCk1sS2iXdfKF23QE93M/ANG9FOIlqIb6CfW53i4G4+ldvvwSJQCfEYe0YmGk+kfPYFvFIP4TUoP/ji2JcGK81eTMeXGT8TOwTj6ksq6jJBXm+WqNaC7N2axxfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=ajIWrkYU; arc=pass smtp.client-ip=23.83.223.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="ajIWrkYU"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 17E1FC1DE8;
	Fri, 15 Nov 2024 16:53:05 +0000 (UTC)
Received: from pdx1-sub0-mail-a291.dreamhost.com (trex-1.trex.outbound.svc.cluster.local [100.112.138.222])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 1A5AEC1A27;
	Fri, 15 Nov 2024 16:53:04 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1731689584; a=rsa-sha256;
	cv=none;
	b=SHY7/7zDkoBhy9Gelp3+h3Guj26BM4NiKre1/jc9rASxvlConrjRqk72GE5U4vnZeYGeqR
	lrM8nfUTMvr7FhCNTrRTI2TpFNBR52LKWSnWJuscwlDQ2p9pChypfkFaSsaEkY0dhSLOe+
	YUI8S5vNcjs23Ra32ZCTOvIw75AT9G/zAPrxpQuvAjo/FBIXDrU4+4pL9aOI6424J/ES/X
	pgxL3+P0tcI0bEmh/yCeTsIg7vkAR/sAr91TrDCS2qGOLU9oWcH1rauKPX5O+dYm5u3Xy2
	kwK+84YD5O1L0pOFaaZ+IQwmAQiKaz3PwR/yvto4zY2CnI08RvAuQo/N8fdXsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1731689584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=O4UnejLeVEGebiK25TXGbrrXiE1Ov2QlC2DjDb86E6c=;
	b=pK2POjpKd6W4c0sMnIvRdPI2rfu0iCfIMAl9pGuFP0FbhIoAw9EM5iKKdKwHCzSfWsMlYa
	3z6+d/ibXVVbhB7KcKMhwpvGrQ8nzpqeLIMhtLPCVGnhpdJEAMhMsjjF9EyCkvQgPUhZk2
	XQFIQyvLd/4sIIvo+/UGDLuqcvkKZOVF/JL0gC8yKpXugzdmWRq7YbC4KWDRmxBdYgOQMB
	R8uvgXxfBCPRJnRoYcXq715zccqAWdx8V2XVIrhvwgfJy9Mxbxes7nt/OZQQJIfjr5BCGU
	cDE3mC3t1aU4Nd8TEvCl0YIUHCHBQqzjZGwxqQ1CEUx91yqzTBaFquWTxTkSYA==
ARC-Authentication-Results: i=1;
	rspamd-7456989c76-xgklb;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Thread-Decisive: 5978ef136ab4cee6_1731689584388_413964471
X-MC-Loop-Signature: 1731689584388:3008821120
X-MC-Ingress-Time: 1731689584388
Received: from pdx1-sub0-mail-a291.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.112.138.222 (trex/7.0.2);
	Fri, 15 Nov 2024 16:53:04 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a291.dreamhost.com (Postfix) with ESMTPSA id 4Xqjkl3Hpnz6x;
	Fri, 15 Nov 2024 08:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1731689583;
	bh=O4UnejLeVEGebiK25TXGbrrXiE1Ov2QlC2DjDb86E6c=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=ajIWrkYUbWCd3+KadbWEx6Hc/mIX8THcm2ngeZuthDITwPqMO+k6oddS2boL8+cwD
	 38WC0stIOw0/wy/Ec+P6OLfwtunlonBcaJ2tIL3E0dkqkFPjpNmuRGSFz9n7K4VRW6
	 OeMqyTOdYwqTwJAbQjXXNY4U6FYDk3bzSlTB6s095yEybbyZ2d735+5+Kc3/j0i6NE
	 0ISlRyIORwrSLsKQk5jRgFGN66v0Cs0rR3r7sN8LdQq5+Akhw6Ub/2uziyaPmBglzS
	 +TZG2PMeHo34zuJd+upeSYfLi0TMPYoRMY7+IOxzqqNI/Rf6FYjeDf3A9uUkJAhK2a
	 qrLELFa9loWpw==
Date: Fri, 15 Nov 2024 08:49:01 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Alison Schofield <alison.schofield@intel.com>
Cc: dave.jiang@intel.com, dan.j.williams@intel.com, 
	vishal.l.verma@intel.com, ira.weiny@intel.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl/pci: Fix potential bogus return value upon
 successful probing
Message-ID: <2eau46txsxb7l4fgmaeope7i7odsjbipjjsjc7mvjiqzhg4llw@iiobkioccdap>
References: <20241114213439.6022-1-dave@stgolabs.net>
 <Zza4YONsVxWa8rpL@aschofie-mobl2.lan>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Zza4YONsVxWa8rpL@aschofie-mobl2.lan>
User-Agent: NeoMutt/20240425

On Thu, 14 Nov 2024, Alison Schofield wrote:\n
>This can be:
>
>	if (cxl_pci_ras_unmask(pdev))
>		dev_dbg(&pdev->dev, "No RAS reporting unmasked\n");

Yeah, it later occured to me that this was better. Will send a v2.

>
>There are a bunch that follow this pattern in that function, mostly in
>the pmu_count loop.
>
>How about tidying up the rc pattern throughout the function?

I think since this is an actual fix, any tidying up can come later.

Thanks,
Davidlohr
