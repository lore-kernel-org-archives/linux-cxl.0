Received: from giant.apple.relay.mailchannels.net (giant.apple.relay.mailchannels.net [23.83.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7314519B5
	for <linux-cxl@vger.kernel.org>; Wed, 29 Jul 2026 18:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785350418; cv=none; b=EbYSf7mG2NznOEs2ucs/cza928UGwHgLOXxvlP04tcriht1SSPiDxvUCkFTQ27x53gQCWpDwrtJECa9j5SMyid9yg1EpIoEUIJ86zswJnokPXhAAYlRolL0tsYBmuLPjSrdcR6CHGNYs5jNGsB6Qt9EQxQQApxl2bl6VttywkgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785350418; c=relaxed/simple;
	bh=t55bO+9jXTQJ1tsHu0qmtMC5CDgf5dGJvU3AHRZmZJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=juU2xX5Hg9DoPJafqyaDCDYKILEfR6q9IT52YTESxmhTBhApxyloT39CF2aY78Qb/qkztNfAc2dodfKTCWgJgwAUL856VmGOc1jT5h3kfxV6Mj38LtD/bjB0uOkSI9A+iW3OdJ4e2G0FchHKQ295wTE72inErPaRqJDMit4//+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=kd8yOAJG; arc=none smtp.client-ip=23.83.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="kd8yOAJG"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id E04FE61E03;
	Wed, 29 Jul 2026 16:45:18 +0000 (UTC)
Received: from pdx1-sub0-mail-a249.dreamhost.com (trex-green-4.trex.outbound.svc.cluster.local [100.108.64.42])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id A99C8613C3;
	Wed, 29 Jul 2026 16:45:17 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Good
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Troubled-Chemical: 48c1a2745f17a973_1785343518149_1580690283
X-MC-Loop-Signature: 1785343518149:49706445
X-MC-Ingress-Time: 1785343518148
Received: from pdx1-sub0-mail-a249.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.108.64.42 (trex/8.0.2);
	Wed, 29 Jul 2026 16:45:18 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a249.dreamhost.com (Postfix) with ESMTPSA id 4h9J9905zHz1054;
	Wed, 29 Jul 2026 09:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1785343517;
	bh=t55bO+9jXTQJ1tsHu0qmtMC5CDgf5dGJvU3AHRZmZJ8=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=kd8yOAJG2OLxSxXixh3LWRG76Y1S3Nr4Sp48Up/xgG+mR2pgU9+rTwAYM/8LuGg3q
	 3fKR60Yfs2P4un5ChJ/50diiU53VrLkN36oiXIY/5xwbfqeJV15h3ZBfPjZJ+4GB+V
	 0K3mjKqgPsqWov10uVdCmhqrzGKlVpCs8VYbdgzRnR3uSsAue0ex+llg271fwUA5X2
	 Rwiowu/3lPY8bSNXHfDTwOtCaFOWsxj+NwaSxe6fFTo4TtCwf8XXceDzb313fzOSfk
	 cV92fXa2AlsfWOv4u2jF0HMXiakg1ju6qra85h/g9UZF/+h6oFC5x5Qao71pz96rm1
	 RICyv1ub4aESA==
Date: Wed, 29 Jul 2026 09:45:14 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>, Dan Williams <djbw@kernel.org>,
	Li Ming <ming.li@zohomail.com>, linux-cxl@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: Re: [PATCH v4 1/4] cxl/hdm: Reject switch decoder interleave ways
 that overflow targets
Message-ID: <20260729164514.esgrps5ajkydfqhz@offworld>
References: <cover.1784595445.git.alison.schofield@intel.com>
 <1e0e4d7b431a97efa0a8c83591b42b7a0622cea1.1784595445.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1e0e4d7b431a97efa0a8c83591b42b7a0622cea1.1784595445.git.alison.schofield@intel.com>
User-Agent: NeoMutt/20220429

On Mon, 20 Jul 2026, Alison Schofield wrote:

>Switch decoder enumeration validates that the interleave ways encoding
>is legal, but not that the resulting number of ways fits the available
>targets. This can overrun the target arrays during enumeration.
>
>Reject committed decoders whose interleave ways exceed either the
>hardware target list capacity or the reported target count. Reject
>switch decoders that report zero targets.
>
>For uncommitted decoders, ignore the stale interleave ways value and
>reset it to one until the decoder is committed.
>
>Add a clarifying comment that target_count is a direct count, not
>0-based like decoder_count.

Tested-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
