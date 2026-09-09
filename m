Received: from tiger.tulip.relay.mailchannels.net (tiger.tulip.relay.mailchannels.net [23.83.218.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7263DD87F
	for <linux-cxl@vger.kernel.org>; Wed,  9 Sep 2026 15:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.218.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788967626; cv=none; b=C8RR8tov7JFW/kJkPTOQaKUpvCOju372XqSf76lhRC82oRpkiLSaFhtWfassFrTs9tzSth81uYmI98uud+VKz6fxOKfW0KC8Lar+0v8tOZAr9FpGXThS7rn4N9kzPy5zfjoty9aqXu4FprEPpEzyUigUZO3hTMOmHz6TpJUB/+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788967626; c=relaxed/simple;
	bh=NAjCh2lcSUsT3Nh56buG4p9+lV2dFNwKunRpPSPuee8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=cF3aQKUq4PxLMU7XA8Vy0A7KtGBfADqofYnLvlH4XNLd0TmnlrA+7Vw8JN1y2QYWCLR5Sa3iyb1srLQEOhEfz/S62QaAqzK4zeAwa+3W3Q+f6a5C2YO6Sk4S1yPvqgIbzfaS2fntMlbwryzFGU6RUK95djMPWUvviR12CjGNCh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=mZLZ3KAK; arc=none smtp.client-ip=23.83.218.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="mZLZ3KAK"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id B8F8C4C27D5;
	Wed, 09 Sep 2026 15:19:54 +0000 (UTC)
Received: from pdx1-sub0-mail-a254.dreamhost.com (trex-green-3.trex.outbound.svc.cluster.local [100.96.170.102])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 61CD54C1868;
	Wed, 09 Sep 2026 15:19:54 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Soft-Continue: 72d6dc6c288bd671_1788967194509_3583377441
X-MC-Loop-Signature: 1788967194509:3974254081
X-MC-Ingress-Time: 1788967194509
Received: from pdx1-sub0-mail-a254.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.170.102 (trex/8.0.2);
	Wed, 09 Sep 2026 15:19:54 +0000
Received: from pdx1-roundcube57 (ip-66-33-200-4.dreamhost.com [66.33.200.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a254.dreamhost.com (Postfix) with ESMTPSA id 4hg4HG17xjz1049;
	Wed,  9 Sep 2026 08:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1788967194;
	bh=EaGMKzEknafBGBZaHzgHK9EXYG3nwfGtiH4xsS5yvs4=;
	h=Date:From:To:Cc:Subject:Content-Type:Content-Transfer-Encoding;
	b=mZLZ3KAKdBEpVf4z7T47kMeltgwF43ecDxp+BTQgndTAfDCb+N4sbq8tPB4kFRtbt
	 /wxLNkUNVLaiyVpLaspmqV1sH8+rdX/ikQrN9p7X5m9yc7I0r///LKKBJ0cZmgA0wW
	 KDgHO6jlpgEAoo8fomZoFWFvd4HIQONM9t4FsbnChiOjRZ7gNcp0vYM3NVmLHKuZxN
	 06oe2tLb7r1NtKQxgyhCtIXNGaj7K65j+yTJ5xazxbxXfvC85qi+qWorVqt8tEUlWm
	 R8Vq1YyHgTRD6Ao5Y+a3F5J/M9Ynb7sIut+GTyYBRGi5GXrkF8I4wFSbXA5f7Yhca7
	 bOS0zgEgLhjuA==
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 09 Sep 2026 08:19:54 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Anisa Su <anisa.su887@gmail.com>
Cc: linux-cxl@vger.kernel.org, alison.schofield@intel.com, jic23@kernel.org,
 dave.jiang@intel.com, gourry@gourry.net, icheng@nvidia.com,
 ming.li@zohomail.com, vishal.l.verma@intel.com, benjamin.cheatham@amd.com,
 Anisa Su <anisa.su@samsung.com>
Subject: Re: [RESEND PATCH v13 8/8] Documentation/cxl: Document DPA partition
 layout and ordering rules
In-Reply-To: <20260908102124.2231730-10-anisa.su@samsung.com>
References: <20260908102124.2231730-2-anisa.su@samsung.com>
 <20260908102124.2231730-10-anisa.su@samsung.com>
Message-ID: <5bd5dbd90d5029f92232d8b8f18318d4@stgolabs.net>
X-Sender: dave@stgolabs.net
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

On 2026-09-08 03:15, Anisa Su wrote:
> DC Partitions complicate DPA ordering. Add a DPA Partitions section to
> cxl-driver.rst describing spec-mandated and Linux requirements for the
> layout.
> 
> Suggested-by: Gregory Price <gourry@gourry.net>
> Signed-off-by: Anisa Su <anisa.su@samsung.com>

Aside from removing the last paragraph per Jonathan’s feedback, perhaps 
update the maturity map as well to keep this in sync for when big 
features get it.

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
