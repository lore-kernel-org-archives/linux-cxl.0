Received: from dog.birch.relay.mailchannels.net (dog.birch.relay.mailchannels.net [23.83.209.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FDB4CA268
	for <linux-cxl@vger.kernel.org>; Wed, 29 Jul 2026 16:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.209.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785343230; cv=none; b=Jac32Dw3nX+S14OWGPywe8wB4aFKLKDW58oeA4N6MgMEHDBy63xomZ/Woc2qJx9JEJ3BsfhH/F91s1vBEMyCdjyIs/2RPtun+Kg+G5UaF+LyJEonaL8r6ZveJisJwtlClIQelUQa3TbDrqPT2+5Q8HwmXiLBJHH0S3LabsTcSxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785343230; c=relaxed/simple;
	bh=eeVUdSuqz937vyLROqYad9+t7CFcdjQa7JoPwP5U6gY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pR4Cw3dMs2PpExilsR0EEgDrapdRH3MhfjaGwQoufU2oBDUGu6heiKpjLNmRv/1afCOkuxC+hdJdPSZwM3aFWWP3dnfFC56Z8JZ0T41eFf0HyH9Lr0qt5A/CX6xQBtg41uL8PG+iBw0ShJLndVVDPMYTDPXWWgztszW6LpjZcv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=mcwRwHfb; arc=none smtp.client-ip=23.83.209.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="mcwRwHfb"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 34FF56451F;
	Wed, 29 Jul 2026 16:34:39 +0000 (UTC)
Received: from pdx1-sub0-mail-a249.dreamhost.com (100-106-248-30.trex-nlb.outbound.svc.cluster.local [100.106.248.30])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id C8A4262080;
	Wed, 29 Jul 2026 16:34:38 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Continue-Fearful: 739e3dd23aae3732_1785342879054_135268612
X-MC-Loop-Signature: 1785342879054:2230006138
X-MC-Ingress-Time: 1785342879053
Received: from pdx1-sub0-mail-a249.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.106.248.30 (trex/8.0.2);
	Wed, 29 Jul 2026 16:34:39 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a249.dreamhost.com (Postfix) with ESMTPSA id 4h9Hws5PLwz103w;
	Wed, 29 Jul 2026 09:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1785342878;
	bh=eeVUdSuqz937vyLROqYad9+t7CFcdjQa7JoPwP5U6gY=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=mcwRwHfb4jJiUHI3SluNX2qyiWeHpnLutPyRHV42I4PMAk8xYtv04ABPUWWCVQnWv
	 Nc7RZF3yxQPRGmf0frvwClopdcTwgp1ZguaSrcG3DELZqLRCGPLLzo/Aqj3xMKHg0Y
	 BLutC3gNpj34Odd0JAbt1Q+c6Aw0kcKU3InWuG9y3BFgYY3qquNaCO5bHroUaC8+yC
	 +auvARe2+yJXMsAB3lzGNE2lgzUBA7GAoIuTUyxIpMN7xkl4jBHmQvi12wm1v76kg0
	 vQtNMKbV6KKExr55QWPsT6uVC/dQINQA/mse/WlrzKEz4eDgafnGfj+7Iq1Yxm1B6X
	 a9wM/vL0d7yjg==
Date: Wed, 29 Jul 2026 09:34:35 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>, Dan Williams <djbw@kernel.org>,
	Li Ming <ming.li@zohomail.com>, linux-cxl@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: Re: [PATCH v4 2/4] cxl/hdm: Only interpret interleave settings on
 committed decoders
Message-ID: <20260729163435.7bkqk43tngtkx35w@offworld>
References: <cover.1784595445.git.alison.schofield@intel.com>
 <48e04e2688a636d90b6e49f3e0c2dca78f773c4f.1784595445.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <48e04e2688a636d90b6e49f3e0c2dca78f773c4f.1784595445.git.alison.schofield@intel.com>
User-Agent: NeoMutt/20220429

On Mon, 20 Jul 2026, Alison Schofield wrote:

>Decoder enumeration reads the interleave ways and granularity fields
>from the CTRL register unconditionally, then decodes and validates
>them for every decoder. On an uncommitted decoder these fields are
>stale. They hold whatever was last latched and are reprogrammed when
>the decoder is committed. Interpreting them serves no purpose, and
>rejecting enumeration on a reserved encoding in those stale bits can
>fail an otherwise usable decoder.
>
>Decode and validate interleave ways and granularity only when the
>decoder is committed. On an uncommitted decoder the stale register
>values are not interpreted. The interleave fields are set when the
>decoder is programmed at commit time.
>

It's weird to cat the respective sysfs file and get bogus values.
imo this should be kept as is.

Thanks,
Davidlohr
