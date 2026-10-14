Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B55122AE65;
	Wed, 14 Oct 2026 01:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.209.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791940302; cv=none; b=i0DJqgkl7S+hMUCAGbnD+isNRFhaiSWOShNB8FTV6XM6ZjwUnYG/fnpyjByMOM+j62gYSVBprKDS//vgiXL05N4SvFLFpkAam3UJn5Z9HJ0/IeDWh7ewxnJxEUn6b5uIwTsPg/G0xG20qKxQni7g5rxPrMqTWQ4iQ7YdQlK8tiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791940302; c=relaxed/simple;
	bh=i5T6zbZQc8CGnSnGEjkof+o0c/hFuOWyEOSaskRrlIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sZUX+Q1zko21WL+mG7crmhap0gSJGC+TCeKpG63G7Bp41hLhqRR7kSB97jAheAe+WEAZSIeOMLFJiLmYkJeMJkfHLmkBgHwRdph0QOZ12zqu/7MpOq5L47eS1OrSF8J8cD1ovkjBmFbjsIocVb/OMBDPY4tozHlT3J+4EsbcyLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=gFuPvhdS; arc=none smtp.client-ip=23.83.209.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="gFuPvhdS"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id D80AB9420C7;
	Wed, 14 Oct 2026 01:02:44 +0000 (UTC)
Received: from pdx1-sub0-mail-a233.dreamhost.com (100-100-60-114.trex-nlb.outbound.svc.cluster.local [100.100.60.114])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 4BB499422A2;
	Wed, 14 Oct 2026 01:02:40 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Share-Arithmetic: 708ec7fc5bfd1be1_1791939764731_3773700087
X-MC-Loop-Signature: 1791939764731:273058391
X-MC-Ingress-Time: 1791939764731
Received: from pdx1-sub0-mail-a233.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.100.60.114 (trex/8.0.2);
	Wed, 14 Oct 2026 01:02:44 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a233.dreamhost.com (Postfix) with ESMTPSA id 4j4Cbz1Ld5z103x;
	Tue, 13 Oct 2026 18:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1791939760;
	bh=vVS7mK5iOf6z92nBzk3PjEszJ1HtyAMQLGAesZh3YzY=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=gFuPvhdSPkNMhXx3AoIdRyzHjdmsSfgknyRaEr7B/5XunpK6I7PRCPrgOLLol3uqp
	 3Wj4xMVjtzerpc+iCu38Fk/5THhypqqGCN4tRQWeAUf3sUsTo4nM7fGmlUl25NSKtQ
	 XqM1GgPCl1N68F5FMMSFX+kdqdT5JjJk8+azaZRqkqphMJbqQG1pokNUB35n4MRrpv
	 clCMVH7SmcBQpGDkqtzwykVDaH1uHKBHeAinbuDq6iifaTUc5EcBu0/e698A+kDs3/
	 k6GzYkhm0B56q0WL0mEyuw+heQ6m2eYV4f9veqJFPlmE6BZ//873vytTjctkqwP7WK
	 HSf7TRgYm6cVw==
Date: Tue, 13 Oct 2026 18:02:36 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Richard Cheng <icheng@nvidia.com>
Cc: jic23@kernel.org, dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, iweiny@kernel.org, ming.li@zohomail.com,
	kaihengf@nvidia.com, kobak@nvidia.com, newtonl@nvidia.com,
	kristinc@nvidia.com, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH v8 1/4] cxl/region: Scan all partitions for unmapped
 poison
Message-ID: <20261014010236.gv53t6tqga4pf2ys@offworld>
References: <20260922101129.52794-1-icheng@nvidia.com>
 <20260922101129.52794-2-icheng@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260922101129.52794-2-icheng@nvidia.com>
User-Agent: NeoMutt/20220429

On Tue, 22 Sep 2026, Richard Cheng wrote:

>cxl_get_poison_unmapped() sweeps the unmapped tail of each partition
>from ctx->part onward. A fully-mapped partition has no unmapped tail,
>it's a normal per-partition state, but the loop treated it with break,
>aborting the whole sweep and silently skipping unmapped poison in all
>later partition. Use continue so a fully-mapped partition is skipped and
>later partitions are still scanned.
>
>Fixes: be5cbd0840275 ("cxl: Kill enum cxl_decoder_mode")
>Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>Reviewed-by: Alison Schofield <alison.schofield@intel.com>
>Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
>Tested-by: Alison Schofield <alison.schofield@intel.com>
>Signed-off-by: Richard Cheng <icheng@nvidia.com>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

>---
> drivers/cxl/core/region.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>index 5ef0ca0694ff..7c7287315d72 100644
>--- a/drivers/cxl/core/region.c
>+++ b/drivers/cxl/core/region.c
>@@ -2952,7 +2952,7 @@ static int cxl_get_poison_unmapped(struct cxl_memdev *cxlmd,
> 			offset = res->start;
> 		length = res->end - offset + 1;
> 		if (!length)
>-			break;
>+			continue;
> 		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
> 		if (poison_efault_forgiven(rc, cxlds->part[i].mode))
> 			continue;
>-- 
>2.43.0
>
