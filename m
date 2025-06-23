Received: from poodle.tulip.relay.mailchannels.net (poodle.tulip.relay.mailchannels.net [23.83.218.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D480A275B18
	for <linux-cxl@vger.kernel.org>; Mon, 23 Jun 2025 16:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.249
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750695792; cv=pass; b=DmvnVuWT5VE29S73g372YAzu4Iua1QbIlOQPiN0GWsWPxMgy4P6MheXUU+8uRxXAp7lqnlVKHMPBtEGFaxyvOGaiY+XbuvUh8LQmRzcbE8carqohwiFgdnZggZSv1noS73PD01fWGnTu6/HLqDOFMsQj2ji7aEEhBjtEsy5+AXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750695792; c=relaxed/simple;
	bh=GTODrVxkXqnXs37MxzQgUoyy5N61+NECmSKH5MfYvgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQsvu0rIljbjluFFiO4pEov5vfk4qrmvUJ/zFeYD0xdF77tPaGhHwDdhjeqI4g/xJIMfxFwi7nygPRRsZHLAllk7VKU+ZyS69UZY6vlqvFpTmmQ/ktjcj0HhlIId6yTvnfwMJqBukSArfGubFJjqWPXJ7z8oodxYh/qX36QvN8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=kzusMJtH; arc=pass smtp.client-ip=23.83.218.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="kzusMJtH"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id C2C6A784663;
	Mon, 23 Jun 2025 16:14:45 +0000 (UTC)
Received: from pdx1-sub0-mail-a231.dreamhost.com (trex-green-5.trex.outbound.svc.cluster.local [100.127.221.91])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id DB0FB784D62;
	Mon, 23 Jun 2025 16:14:44 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1750695285; a=rsa-sha256;
	cv=none;
	b=WF0OdeAWERCx1cVBm+oz/XfHr0GP6aiDGF1HQVukXnIiUIfb85nMrkCTT6imEXRIeimUUs
	lY9jrc/JHY/Pi2vV7REJNTBYrFf5IzSyjEXps9ZzULs3vrsach1OgZ4S4nsVSOsM/wgbDr
	inPaJx3nU9wJVjK8TaxtfVHRaqOdLXCH/D/gKFWPBTWjPEwDL2ttwfHgw5rhIuv3gBzqOK
	0iHZUWiQFWT26XexINJtkbyDmXS7Ixlb2tA3I5hns7/nlN3Sq/H79IpX/XyEDVDntNbWu8
	SgbXJ3DaCfTv5aJpNBO+3D5RED2dVFNsgFxURny+vQqBH+LCAJ6WlCYLzHRYQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1750695285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=81uxsHvVrtpH46SQsRjG5NkzJ3x+z0p1bvchrenvILE=;
	b=nlRh1OlgUb45xgAp+yrC+e1f6IYZskuq/LWr0G150VN8VARz/V2eEdZuFIlKnkp+4rFbrQ
	XAtQdEyf6KcnPzTSyrEFbPLjfBenns68NC9XMkw+mWpMOW2lbhOzmdaR/oaSUS7OXvaFzN
	/J5HG1cZqva1TG8Xf17M06IcQMDvTBzPUdySWHwMYAq4EEKiaOO5y6hvven7lC5sBIJn5z
	AWXHn1b4+ibsKfpE1dZTOU68fTh9D9RwubFpPJ78wPyFzaATq9gkDyOYggHnTtf06l/r8p
	z0M0yY0P8JC5KMMBBnX8ZXG6gOKU0dJoqAsBCYDign/6Fg32K428QTLu5TfUwg==
ARC-Authentication-Results: i=1;
	rspamd-679c59f89-m8kv9;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Glossy-Cold: 7f9ab7907f3f2faf_1750695285542_1361437637
X-MC-Loop-Signature: 1750695285541:1203419598
X-MC-Ingress-Time: 1750695285541
Received: from pdx1-sub0-mail-a231.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.127.221.91 (trex/7.0.3);
	Mon, 23 Jun 2025 16:14:45 +0000
Received: from offworld (syn-076-167-199-067.res.spectrum.com [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a231.dreamhost.com (Postfix) with ESMTPSA id 4bQtSz73nYz9y;
	Mon, 23 Jun 2025 09:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1750695284;
	bh=81uxsHvVrtpH46SQsRjG5NkzJ3x+z0p1bvchrenvILE=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=kzusMJtH/BjDEosS0XzFFwX9iJA6uXK3wZZqk2S8DWAFVAid0kbEKa8qzrhuc5ELO
	 dHikV2SZaXgxzG4GmsjbmRybTd2V4a+qCvoQjOA99lFCDteDxEKcXF8eo0SBBPl55O
	 K63iE5Uqhp+6qlfSykRdnsgzjmVUlYHzpsyc9e5FuhMWW4z3wu/8PLTOQ0O2uUwrZb
	 jN2w62gf71028lwF2mn72va7OCOYckSb2bRSzg+zejqvq31cIpqHMZCFZWPwKL/PeA
	 d2HuVX4asa2rdVwpjZRNjiaKgi/A6eX1pWhpjAWJqAcAISVl71e2tvp3VPZS6aQvWT
	 4hZ3Uk80CwHtA==
Date: Mon, 23 Jun 2025 09:14:38 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: dave.jiang@intel.com, dan.j.williams@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, jgroves@micron.com, ravis.opensrc@micron.com,
	fan.ni@samsung.com, anisa.su@samsung.com, a.manzanares@samsung.com,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH 6/7] cxl/mbox: Shout upon async bgcmd race
Message-ID: <20250623161438.k6xnopilwcmpjc6t@offworld>
References: <20250617193611.564668-1-dave@stgolabs.net>
 <20250617193611.564668-7-dave@stgolabs.net>
 <20250623155049.00006f14@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250623155049.00006f14@huawei.com>
User-Agent: NeoMutt/20220429

On Mon, 23 Jun 2025, Jonathan Cameron wrote:

>On Tue, 17 Jun 2025 12:36:10 -0700
>Davidlohr Bueso <dave@stgolabs.net> wrote:
>
>> Make the condition a warning, as the mailbox will be corrupted
>> on such cases, which may trigger harder to debug issues down the
>> line when simply returning a common error.
>
>This is a little confusing.  I assume it is meant to be impossible to hit
>this race?

Correct, this is just being overly cautious.
