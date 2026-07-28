Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1575368974;
	Tue, 28 Jul 2026 04:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.209.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785213148; cv=none; b=E3T+7k5Z3ilHZDiilKAUEApyyIKLmIK9+S0CO3i1cGIQmw/HcR0mCPWVjzc4MNhZGTR0iqaYywtDOadmNoqogx+mwGmywFdvQuXrKxxu3q761+UpZFHyJV6s2qkvgSsPS4qIVy+pRWTpj9mpyT5wGWkzH7D78b0WInVIh5EGftU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785213148; c=relaxed/simple;
	bh=CZoYlxSuNuMoU417TNhEMI8f9Ys67vBSkNe55vwYvVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gr6ABh96tDtAveJC7IyF5QxEE1RDIUJG4d2Kb3+pg5EjrOAx3KEBxyTO7EgiZQ5eSDuLYXCx/2crwaFynRmTJ3TTEzIf4qj/9Wro6HU4CSvDqhBYSuVL/EDg2aSkmaXkfPpCG90osEv6cYqANywyRT9H8t6pcPjVfzwlNg7NlqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=WSFfULaE; arc=none smtp.client-ip=23.83.209.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="WSFfULaE"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id F3BAC722083;
	Tue, 28 Jul 2026 04:32:16 +0000 (UTC)
Received: from pdx1-sub0-mail-a203.dreamhost.com (100-105-0-234.trex-nlb.outbound.svc.cluster.local [100.105.0.234])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 9A787720482;
	Tue, 28 Jul 2026 04:32:12 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Robust-Inform: 4259d489715db56e_1785213136851_3454195873
X-MC-Loop-Signature: 1785213136851:3121928752
X-MC-Ingress-Time: 1785213136851
Received: from pdx1-sub0-mail-a203.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.105.0.234 (trex/8.0.2);
	Tue, 28 Jul 2026 04:32:16 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a203.dreamhost.com (Postfix) with ESMTPSA id 4h8Mxl6KKxz1p;
	Mon, 27 Jul 2026 21:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1785213132;
	bh=/uIp0wN5cilXCk2AarMNJI9YtsgyqT6i53jODNpoAcc=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=WSFfULaEJaQfieoBm8FqKoJbv+QB6U0F4/ak3IQ2Ahr+VJWBUhud7CURP4wNVNgt9
	 SxsRjHhF3N9SpGIY3dpYkvIWlrMYR1t924zi2UKNJ/ii067ValqD6kihqJcrLqwPf+
	 Wi7H6xXjDPF+14GrW1RhypP23V5FX6hnAgHigQj4mWtW/+BPVrRW91swcC+dhnBGxk
	 0sFqKm6ljWiAs8O92TWL/ksE/1Z6YMN5/4TknS/4UAYMkal4Vnlgrjkr2OrjPt8Ng5
	 V59PZkoeHpC4HuxP5uh/VaIgfJncVS2dd6JgzoNpUwhHlJD8KP6Dv5XOEyqDZ67Eq6
	 fg1KAPm6suCwg==
Date: Mon, 27 Jul 2026 21:32:08 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, alison.schofield@intel.com,
	icheng@nvidia.com, benjamin.cheatham@amd.com, alucerop@amd.com,
	dongjoo.seo1@samsung.com, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v6 0/9] cxl: Support Back-Invalidate
Message-ID: <20260728043208.qecadcgwwyxhdmux@offworld>
References: <20260727193601.651871-1-dave@stgolabs.net>
 <20260727215948.51ae3889@jic23-huawei>
 <20260727212605.tokwuzpf3lo4hb2z@offworld>
 <1c6f5b90-da61-46dc-8999-39e2c21ba122@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1c6f5b90-da61-46dc-8999-39e2c21ba122@intel.com>
User-Agent: NeoMutt/20220429

On Mon, 27 Jul 2026, Dave Jiang wrote:

>You may want to resend if you want sashiko coverage.

So I think we just don't get the emails, I can see the coverage in
the dashboard:

   https://sashiko.dev/#/patchset/20260727193601.651871-1-dave%40stgolabs.net

And on that note most of the issues were duplicate false positives or
things that are fixed in later patches in the series. And the actual
patches 7-9 came out green, so it seems sashiko had no issues with
the endpoint port lifecycle or the auto-commit support.

So yeah will just resend altogether as a v7 and go ahead and fold patch 7
into patch 2, which is the most sensible way to break the series up, imo.

Thanks,
Davidlohr
