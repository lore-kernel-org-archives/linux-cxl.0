Received: from toucan.tulip.relay.mailchannels.net (toucan.tulip.relay.mailchannels.net [23.83.218.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7C1E546
	for <linux-cxl@vger.kernel.org>; Mon,  1 Jan 2024 22:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="Rt45KncK"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 0A2286C1DD8;
	Mon,  1 Jan 2024 21:28:41 +0000 (UTC)
Received: from pdx1-sub0-mail-a227.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 893A46C1D4B;
	Mon,  1 Jan 2024 21:28:40 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1704144520; a=rsa-sha256;
	cv=none;
	b=LZBWLmUtIpIcdtvuDCLk/F0B+udZ/aACkPPGz/qtv0ZpdWNxSNXxOCGgjzrpspDb0GG+hE
	J1fqfsAh5EzWQpaslnazj/n1HDbZTNUeKtSYy7OZ3qwFy1Z+l6CzhGGB23mtDmzUk7hIW9
	5tyIL0Kc0xeMdBmrFD77yo7UWosGMcw7+WglLUvSr9q/a3MXMqezQN+N/IurMcsdJrNL+B
	DnvskPoHM4MZQfm1CyVsoC11MBH8bl+qdBXaU5I2XGfar22ZjFDaM/sVjoNcPkspU4Ath5
	KJE522AmeKfcl87lRhSpOIef60Nce9bsYQunxjqPKMzQDyWq+0/9WB88J9WP3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1704144520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=0oD1xiM6uy2V3jqB5DTDX/o8KsAy73iiP5qy0qjI7ds=;
	b=YM4IJDnJvIgZ5Y9cN7ck/EJTHrarWIarDcOUBaSIbi+vaDLdRiqJLx5jXoqqEDqzHo6sm+
	bePCY+ICRLRfA+I2yQmBp8vSSuIfvw0Xwg5kQG2vK2T8b2C6RV2g5Hdob0L8ZsCC7Vu2zN
	SaL7XeRP75gviMMtVTAdPyZZ1fPRATT4m00DS9dW3ZkHffOQQks5QK6wGrWc3KfR8I/2QP
	2o6yfMqwSxuBYWAj9f5q9qEcIMEoNmgRXp7I/OLJBOrQGshIwc8Re8tUV6U4+nrqvqDIAA
	wb3dTrnWirQtpda7vBCBgwlGKi8e5Fm4uLjv5Y7KUmDuHB/6ckgL6RLTQdvXJw==
ARC-Authentication-Results: i=1;
	rspamd-659dcc87c8-bpmfx;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Inform-Abaft: 268c20a42454ca9a_1704144520854_219717415
X-MC-Loop-Signature: 1704144520854:2882183083
X-MC-Ingress-Time: 1704144520854
Received: from pdx1-sub0-mail-a227.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.125.149.135 (trex/6.9.2);
	Mon, 01 Jan 2024 21:28:40 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a227.dreamhost.com (Postfix) with ESMTPSA id 4T3pxz6stTzDG;
	Mon,  1 Jan 2024 13:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1704144520;
	bh=0oD1xiM6uy2V3jqB5DTDX/o8KsAy73iiP5qy0qjI7ds=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=Rt45KncKYGETLGhi0TMXKdgG3fg6oDTCnyDErsWA6d2hny62eWza5JoWSXkQlC79/
	 /SbD/jFK+s5gBbAjqgrRMnBd+DS/+UxV7u0KyzeGenofQhEqpkf3f79IH3ItWps5v4
	 ozwLgrsfYm1UfQes5XPpzHR/uJgWAL3sm4bxtnk+cLDR3BJ2qlDTbawlH0CulL8kAU
	 MSciGqzuncuQsB3Y7YB8kSXl/u+DN5qCt9uzgSqvApoyH/MuNS3ZS6VzM2cqgGOBnP
	 MJzouOERAjjuTVzfErMS50DV9Say04MwfahVNkyLYf3AwuNxj7ssw3pGFLiUBBRQN0
	 e6Oov2yFm5cUA==
Date: Mon, 1 Jan 2024 13:28:37 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: alison.schofield@intel.com
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v3] cxl/region: Add dev_dbg() detail on failure to
 allocate HPA space
Message-ID: <20240101212837.lir3vt4wthpllqf3@offworld>
References: <20231223004740.1401858-1-alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231223004740.1401858-1-alison.schofield@intel.com>
User-Agent: NeoMutt/20220429

On Fri, 22 Dec 2023, alison.schofield@intel.com wrote:

>From: Alison Schofield <alison.schofield@intel.com>
>
>When the region driver fails while allocating HPA space for a
>new region it can be because the parent resource, the CXL Window,
>has no more available space.
>
>In that case, the debug user sees this message:
>cxl_core:alloc_hpa:555: cxl region2: failed to allocate HPA: -34
>
>Expand the message like this:
>cxl_core:alloc_hpa:555: cxl region8: HPA allocation error (-34) for size:0x20000000 in CXL Window 0 [mem 0xf010000000-0xf04fffffff flags 0x200]

Nice.

>
>Now the debug user can examine /proc/iomem and consider actions
>like removing other allocations in that space or reducing the
>size of their region request.
>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

>Suggested-by: Dan Williams <dan.j.williams@intel.com>
>Signed-off-by: Alison Schofield <alison.schofield@intel.com>
>Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
>---
>
>Changes in v3:
>- Add parens around error number (Vishal, Dan)
>- Link to v2: https://lore.kernel.org/linux-cxl/20231129003953.1252985-1-alison.schofield@intel.com/
>
>
> drivers/cxl/core/region.c | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>index 56e575c79bb4..a7b695db5dfc 100644
>--- a/drivers/cxl/core/region.c
>+++ b/drivers/cxl/core/region.c
>@@ -552,8 +552,9 @@ static int alloc_hpa(struct cxl_region *cxlr, resource_size_t size)
> 	res = alloc_free_mem_region(cxlrd->res, size, SZ_256M,
> 				    dev_name(&cxlr->dev));
> 	if (IS_ERR(res)) {
>-		dev_dbg(&cxlr->dev, "failed to allocate HPA: %ld\n",
>-			PTR_ERR(res));
>+		dev_dbg(&cxlr->dev,
>+			"HPA allocation error (%ld) for size:%#llx in %s %pr\n",
>+			PTR_ERR(res), size, cxlrd->res->name, cxlrd->res);
> 		return PTR_ERR(res);
> 	}
>
>
>base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
>-- 
>2.37.3
>
