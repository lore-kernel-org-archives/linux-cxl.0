Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.83.222.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794362226;
	b=Ljq+PoWjEmYJ1zSzAKsQVSs7k5zTXhYspHlYf4s4A1OSOad4h5wAnKcCHn5meY84gI2s
	 iwmPuYJ2UA01l7GJyxsqakzYlOWQJWLvXEU6j/oHrtxk17vwSg7MQPJXxucqoiJI+0TgE
	 ZzCjeGP9iLKdes50om3y5pSkf9vn5QOLbUVXnmMa+raCzbNOrI2fWXqtv0Q4Rdv6SqdxR
	 HhZd5nXwqc18ptqXDqi2u+kJZ24fSpTG2S9bkZJEGiEWISbbMuYTBbFxCOaq6zLN6rgXP
	 nzyiOCpXUYfPEVJSRR2zanxWKMrT1OoD/e7V2n3ewNuw6OjHLYOFq+23rYzWcQUNsSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794362226;
	h=DMARC-Filter:X-Sender-Id:Received:Received:X-Sender-Id:X-MC-Relay:
	 X-MailChannels-SenderId:X-MailChannels-Auth-Id:X-Reign-Share:
	 X-MC-Loop-Signature:X-MC-Ingress-Time:Received:Received:
	 DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=3wik4b/iHvX827CoxAU7wFE1CWRGRXG984Mlgqtm/vA=;
	b=klxLdOMlF8pbdk9uqFD2r8ovEZqTI+i2xMIKDk7wU5PLZlqxIHMHjtJfeL0Q1etzwpSX
	 sfv1yOXofgYvNsXE+gDHDClEIlZ87BPysw1n9u5xfLCPePoSmTyOrO6B/2YwTamskdFnU
	 37RsGYm2xJtQfPiY9ppA+gJodxzFCE7URyp6UXD+wvy98W3x8DvpENAsTKfoFOLe6Ff5G
	 PHWWhYOStXYymcHarA6Ni2ZzGGdoUeKmIRB0+l+cCH0YAhv8LzXTSVagWlAkkET3hyeGb
	 yia6BiYgMCIq/2MMv8ZK27SA5+ZYK+06G3ChSp5/bhB+uU3ScNOi/raetyuyUUELjvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=stgolabs.net;
	spf=fail smtp.mailfrom=stgolabs.net;
	dkim=pass header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b="j/s5eKB5";
	arc=none smtp.remote-ip=23.83.222.37
Received: from cockroach.ash.relay.mailchannels.net (cockroach.ash.relay.mailchannels.net [23.83.222.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1615C606A31C
	for <linux-cxl@vger.kernel.org>; Wed, 11 Nov 2026 01:57:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1615C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=j/s5eKB5
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id A4CC8460E70;
	Wed, 11 Nov 2026 01:56:59 +0000 (UTC)
Received: from pdx1-sub0-mail-a250.dreamhost.com (100-99-188-152.trex-nlb.outbound.svc.cluster.local [100.99.188.152])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 3C314460814;
	Wed, 11 Nov 2026 01:56:55 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Reign-Share: 763a0d6146cca256_1794362219504_3806412083
X-MC-Loop-Signature: 1794362219504:329134662
X-MC-Ingress-Time: 1794362219503
Received: from pdx1-sub0-mail-a250.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.188.152 (trex/8.0.2);
	Wed, 11 Nov 2026 01:56:59 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a250.dreamhost.com (Postfix) with ESMTPSA id 4jPRTf4mvgzyrF;
	Tue, 10 Nov 2026 17:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1794362215;
	bh=3wik4b/iHvX827CoxAU7wFE1CWRGRXG984Mlgqtm/vA=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=j/s5eKB54eKpKuqdVKmxvTxmPZ0aeprDtACay49Pxq9RMnpgr9xgjgkZ0X13NB3w7
	 JyVyz7ZWs9S5u8vwQLg9qy9vyMvzhDkitAObxKaTFoPQ3xRRhmZeucFfs+lzTLl3fx
	 Bmvy09l4kzeGbAyOmUAn40E4eBxM6C9urOyldra2XRUBMcAPN5m0s+Cf71k1RSl6Tn
	 76nM6Pwq3e+q5YY61jEu0dV+v5UttJIzp4Ig8zAJanjDukwSARrYie4n/aNRT4BLNi
	 Cl9w9pqRNRTw4PntTR6ktpyu0QoMMerbLQFeIP8h3PbeCYTGQabgovlnvnk9fM8uBL
	 CO07yZpzXR4LA==
Date: Tue, 10 Nov 2026 17:56:51 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Dave Jiang <dave.jiang@intel.com>
Cc: jic23@kernel.org, alison.schofield@intel.com, ming.li@zohomail.com,
	icheng@nvidia.com, benjamin.cheatham@amd.com,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v11 00/10] cxl: Support Back-Invalidate
Message-ID: <20261111015651.pn4tsbwhd6qb2uq4@offworld>
References: <cover.1794172701.git.dave@stgolabs.net>
 <f6993ac2-8e1b-41b7-91dd-7bb8c4d29311@intel.com>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <f6993ac2-8e1b-41b7-91dd-7bb8c4d29311@intel.com>
User-Agent: NeoMutt/20220429

On Mon, 09 Nov 2026, Dave Jiang wrote:

>
>Applied to cxl/next:
>d7e0ff278782 cxl/doc: Update maturity map with BI support
>7d9e54add1ac cxl/test: Add mock BI topology support
>e8116033242d cxl: Handle auto-committed BI hdm decoders
>77d2d170a9bb cxl/pci: Split BI capability probe from setup
>6b47c508bd53 cxl/region: Log the coherency model at region creation
>77b165a5fce0 cxl/hdm: Rename decoder coherency flags
>e4c3f0d96667 cxl: Add HDM-DB region creation
>617f6082758f cxl/hdm: Add BI coherency support for endpoint decoders
>ad9c5385f8e1 cxl/pci: Add BI topology enable/disable
>d81c479843a2 cxl: Add BI register probing and port initialization

Thanks!

>
>I fixed up a minor merge conflict with Alison's cxl_test changes. Please check everything looks ok. Thanks!

So 6b47c508bd53 has a spurious
    Not-Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

... but otherwise looks good, and cxl/next passed all my tests.
