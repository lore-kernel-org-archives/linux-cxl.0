Received: from sienna.cherry.relay.mailchannels.net (sienna.cherry.relay.mailchannels.net [23.83.223.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970C51F3B85;
	Wed, 14 Oct 2026 01:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.223.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791943064; cv=none; b=okrbedoPs14athB9hFVgR1CK03DQX1C7kVFXXe8m5NLFwxta2V0obd4z7aIDc757LBiOmU1/NEvoKxKcMKUTcKAyacYoCjtR/9wCxTJwHVLcTIhyASh8Zze+xszZ3oLDtPJmW1ItYawj2n5BWnpGZVPCtupIwUuPjqFJ1OuaKeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791943064; c=relaxed/simple;
	bh=fyw82BLndg6/WQBOHwYrXwE0y9S/x4Z6+FObr0qSdGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j2uP1zhYcP+PVemTQj698OL3nRajNDyXWy6d8zxJrpksDof7w4i6MHj4ValnzFzAQaDGYCoRCI9dZj1Ood1ZOrOm9LPrVsex0PIwy1136534LchEV8Ooc8iTV2Em8gg8t6gRK48MNxxKBEbItzER0Hvgx01CugkJIItIpn01oSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=O4PFNrHZ; arc=none smtp.client-ip=23.83.223.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="O4PFNrHZ"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 1483A802859;
	Wed, 14 Oct 2026 01:57:43 +0000 (UTC)
Received: from pdx1-sub0-mail-a233.dreamhost.com (100-100-76-207.trex-nlb.outbound.svc.cluster.local [100.100.76.207])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 91BEC801F84;
	Wed, 14 Oct 2026 01:57:42 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Lettuce-Hysterical: 487017015431fa2c_1791943062921_3482747084
X-MC-Loop-Signature: 1791943062921:3076111395
X-MC-Ingress-Time: 1791943062921
Received: from pdx1-sub0-mail-a233.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.100.76.207 (trex/8.0.2);
	Wed, 14 Oct 2026 01:57:42 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a233.dreamhost.com (Postfix) with ESMTPSA id 4j4DqT4N0dz103x;
	Tue, 13 Oct 2026 18:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1791943062;
	bh=PJx7TZW9+kimKvarDE0TO3lpMXWCfB4VRf+TlpXGmsM=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=O4PFNrHZ48QFxoepfDuTZ/Q2T4t8X4TAgPC70WzPJ139X7hQVuiEOR04lKT5RcZ/5
	 O4ftgNHFnVgDlvOjvVmh+RSGoXA1H20G5rXKhql5vbP+dtkH4cUdxmdar6RsqOpq/L
	 U1Mm0F5vTZEEk6Vd8dDO3q6PKnx+w3r9nF+6NseuItlB0xw+uG6stSh1O55racBdII
	 5TLL7KHpfFHFcTQiS4C6UxwNrp5INk30d/Kfc6svctwoAsP7g7cV0y8nnF6WaPMhkz
	 S2t4e9AxuWHNYOrSkCXWb6enkFVS4vtn4xfe5BUeL9ShWj4aCwGrWagYVMcaROkVGK
	 n6NUUFGRVWQyQ==
Date: Tue, 13 Oct 2026 18:57:38 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Richard Cheng <icheng@nvidia.com>
Cc: jic23@kernel.org, dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, iweiny@kernel.org, ming.li@zohomail.com,
	kaihengf@nvidia.com, kobak@nvidia.com, newtonl@nvidia.com,
	kristinc@nvidia.com, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH v8 3/4] cxl/region: Start unmapped poison scan at the
 committed decoder boundary
Message-ID: <20261014015738.eelvhtdm3nzh3jh3@offworld>
References: <20260922101129.52794-1-icheng@nvidia.com>
 <20260922101129.52794-4-icheng@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260922101129.52794-4-icheng@nvidia.com>
User-Agent: NeoMutt/20220429

On Tue, 22 Sep 2026, Richard Cheng wrote:

>poison_by_decoder() stops at the last committed decoder and records the
>handoff in ctx->offset, but cxl_get_poison_unmapped() ignores it and
>starts after the highest DPA allocation instead. Allocation exist for
>uncommitted decoders too, so their DPA is skipped by both phases and
>poison there is never reported. Resume the scan at ctx->offset, and scan
>later partitions in full, restoring the pre-rewrite behavior.
>
>Fixes: be5cbd084027 ("cxl: Kill enum cxl_decoder_mode")
>Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>Reviewed-by: Alison Schofield <alison.schofield@intel.com>
>Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
>Signed-off-by: Richard Cheng <icheng@nvidia.com>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

>---
> drivers/cxl/core/region.c | 7 ++-----
> 1 file changed, 2 insertions(+), 5 deletions(-)
>
>diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>index 042356c71ed7..4869cdd6a3d4 100644
>--- a/drivers/cxl/core/region.c
>+++ b/drivers/cxl/core/region.c
>@@ -2931,7 +2931,6 @@ static int cxl_get_poison_unmapped(struct cxl_memdev *cxlmd,
> {
> 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> 	const struct resource *res;
>-	struct resource *p, *last;
> 	u64 offset, length;
> 	int rc = 0;
>
>@@ -2944,10 +2943,8 @@ static int cxl_get_poison_unmapped(struct cxl_memdev *cxlmd,
> 	 */
> 	for (int i = ctx->part; i < cxlds->nr_partitions; i++) {
> 		res = &cxlds->part[i].res;
>-		for (p = res->child, last = NULL; p; p = p->sibling)
>-			last = p;
>-		if (last)
>-			offset = last->end + 1;
>+		if (i == ctx->part)
>+			offset = ctx->offset;
> 		else
> 			offset = res->start;
> 		length = res->end - offset + 1;
>-- 
>2.43.0
>
