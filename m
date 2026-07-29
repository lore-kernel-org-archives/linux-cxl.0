Received: from brown.larch.relay.mailchannels.net (brown.larch.relay.mailchannels.net [23.83.213.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDFF45C709
	for <linux-cxl@vger.kernel.org>; Wed, 29 Jul 2026 16:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.213.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785342994; cv=none; b=HSsYZ0kMoO7VEJMlNCq+l+tp4SJx4J2BDKHL8J7qnBbMBIFgyvHKUFZLOw+VR2YsJnXFTzBXGJ3cU63/5nNr+qjyG2Zk+Kn7k922y1iEHc/TEUD9RwlqDNqE37HFT90S2Q0JUSvKq2mYdQ8SAqFDLcJWHM/wbU1m5WqGoH5arNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785342994; c=relaxed/simple;
	bh=ZtRTVT3ygjp7HYfYEO1/0ptzec24TarXVSJ/WRBlAxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uf++kFMFqFyxW/VPoqGFFbABqar0U3zCAYgMqIt+6TWomsKbeOrtX84EG5iSL5gv6TPmOc3Ppy0EVqnvrIw4W7E5R98Xqwq3dQ9mVLKpgNZG4PrA8GfiDzZMA4CqRatB1mFSCx91G+BXFU2Kf0PU2DwAbnY0PPshPaAhnVVJBYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=HSrllKt1; arc=none smtp.client-ip=23.83.213.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="HSrllKt1"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id C25D03E4E76;
	Wed, 29 Jul 2026 16:36:32 +0000 (UTC)
Received: from pdx1-sub0-mail-a249.dreamhost.com (trex-green-6.trex.outbound.svc.cluster.local [100.111.249.252])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 752613E3DA3;
	Wed, 29 Jul 2026 16:36:32 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Good
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Invention-Bottle: 74e4287506db2436_1785342992605_2038095495
X-MC-Loop-Signature: 1785342992605:2184328466
X-MC-Ingress-Time: 1785342992605
Received: from pdx1-sub0-mail-a249.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.111.249.252 (trex/8.0.2);
	Wed, 29 Jul 2026 16:36:32 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a249.dreamhost.com (Postfix) with ESMTPSA id 4h9Hz405ZXz103w;
	Wed, 29 Jul 2026 09:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1785342992;
	bh=/bj6ICb+HMoeA3LzI44TgdXm0etY2yz5cPDOutdwteY=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=HSrllKt1ue0pbflZiD0tuISkveSbz/yv6ITeS22fYfR5D7VnOkrG948MsrfTWgVn/
	 U+ugO0YpuOa5s1HiX42JO3RFH+HQ8F8NaiyvE5CLa8BaIOcUZpZm5XjdTbzkGweby2
	 BPv99X7e+EoixrBcn6OZMFdvo+AK0KDuvJhjCLBwfDxmbZD+WFpHGBOuuHasdSxpKz
	 DGBxGqHlMMJyHhak49PSE0/MdggL1TTrKx+Vzmy0UzDs7movG4/zZbnmOC0dBs+qHi
	 f6jDpbMittnXevryyvv5zPgPylN9sWsesFjDjde70ZXYyLQAlf6+ZJYeUW1zNOeVjV
	 3OXLx9/StIwqg==
Date: Wed, 29 Jul 2026 09:36:29 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Alison Schofield <alison.schofield@intel.com>
Cc: dave.jiang@intel.com, jic23@kernel.org, linux-cxl@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH] cxl/hdm: Robustify decoder target list reads
Message-ID: <20260729163629.y2qkcfduas3kjntx@offworld>
References: <20260728230228.781303-1-dave@stgolabs.net>
 <amk_IetrE7138TT0@aschofie-mobl2.lan>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <amk_IetrE7138TT0@aschofie-mobl2.lan>
User-Agent: NeoMutt/20220429

On Tue, 28 Jul 2026, Alison Schofield wrote:

>Hi Davidlohr,
>I think this issue, and its spawn (the endianness issue), are addressed
>in this in flight patchset.  Please take a look:
>
>https://lore.kernel.org/linux-cxl/cover.1784595445.git.alison.schofield@intel.com/

Hi Alison, thanks for taking a look and yes I agree your patch 1/4 fixes
the issue. I would perhaps add the kasan splat in this changelog just for
extra evidence.

Thanks,
Davidlohr
