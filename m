Received: from serval.cherry.relay.mailchannels.net (serval.cherry.relay.mailchannels.net [23.83.223.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACA93BBFD5
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jun 2026 00:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.223.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780619893; cv=none; b=VCGJplJJT85KFgIL0OwInksRLj8eDICo/f6M81m9292b9qRlB1jr0d5+DaFOGL+y0WReGAWnBi+XgEwxS+0qpwroWQoBE79BHgU00Z/ZTop7WN0TXiqza1Thz4qryQ9xZjyPqseoer8Au/tMxJYdF9K8nNPtnbIvqaq3oNXeXk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780619893; c=relaxed/simple;
	bh=noRiTl5Y3cKt8NUWxuKitnMk3DTj+jaCi+jIYKy6NBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kBIMZxzBXk8rQRzvCVoYPeOQzsGE2Tf+jhGoMdinLrMI4nfUlhHhTWq+tjvP42OzrLWMho5CkLU6QvT5fhRyHllTt0DY+xUem+VOb7daikegFkmQ3RGlDD0WpN2M6iymWrdpGeOfjo9soefbth/IyahBhErM11l2PIIx7hcpDWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=fgpJJebO; arc=none smtp.client-ip=23.83.223.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="fgpJJebO"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 9090A40249E;
	Fri, 05 Jun 2026 00:38:05 +0000 (UTC)
Received: from pdx1-sub0-mail-a258.dreamhost.com (trex-green-8.trex.outbound.svc.cluster.local [100.105.229.196])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 2AD12401EFB;
	Fri, 05 Jun 2026 00:38:05 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Soft-Hysterical: 643e7eb12dfe8cd0_1780619885390_170340365
X-MC-Loop-Signature: 1780619885390:1579572453
X-MC-Ingress-Time: 1780619885390
Received: from pdx1-sub0-mail-a258.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.105.229.196 (trex/7.1.5);
	Fri, 05 Jun 2026 00:38:05 +0000
Received: from offworld (186-79-219-2.fo.baf.movistar.cl [186.79.219.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a258.dreamhost.com (Postfix) with ESMTPSA id 4gWjG35DZFz1040;
	Thu,  4 Jun 2026 17:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1780619885;
	bh=noRiTl5Y3cKt8NUWxuKitnMk3DTj+jaCi+jIYKy6NBY=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=fgpJJebOCTBotFZI49jQUfAP2BMFdYIew3XAgPB5zqA74SfhD3Qbe2X5pTR3y1LSC
	 hK7aJv55wLVZ2QVU5vVFsj5rZIgFemU8MFClmPtCDeg610FwRZr/iLzU3p+lRBlbzW
	 NVnhptChjgW32+ZIna4rsE5Sb3YrJsLmoUAEtaDIl6msNDQdFGmL+vCeNpKJoqWmYu
	 0v5ttl44h/6qzv/1xHYNMb1F+Idnbv1avqZhL5b93qOlsmdEelHTnEL8w2JOcx+1oW
	 OE9re4LcS7nt+hDx6Rh4k6waJ1dMFriUEz6uslyQXc0T0yVyJGBODIOuiF6pEqFmTX
	 QS7I76nlH1EKQ==
Date: Thu, 4 Jun 2026 17:37:57 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-cxl@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [PATCH 4/4] hw/cxl: Add per-capability CXL Fixed Memory Window
 restriction flags
Message-ID: <20260605003757.mmplm66efpxgiujw@offworld>
References: <20260602231806.2469011-1-dave@stgolabs.net>
 <20260602231806.2469011-5-dave@stgolabs.net>
 <20260604113426.206c4d39@jic23-huawei>
 <20260604154259.tq7vnnzuc74jif2m@offworld>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260604154259.tq7vnnzuc74jif2m@offworld>
User-Agent: NeoMutt/20220429

On Thu, 04 Jun 2026, Davidlohr Bueso wrote:

>This is also why I drop the bit0 in the default restrictions. I am fine removing
>this check here for now, but also have a kernel equivalent which fails the cfmw
>parsing if any of the above is seen (maybe the failure could be downgraded to
>a warning).

Just fyi on the kernel v4 I just sent out, I removed the failing when bit0+bit1
and just left the error on bit1+bit5 (BI).

Thanks,
Davidlohr
