Received: from silver.cherry.relay.mailchannels.net (silver.cherry.relay.mailchannels.net [23.83.223.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD9522AE65;
	Wed, 14 Oct 2026 00:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.223.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791939071; cv=none; b=L+mU37KPckW48OXXBdiEvUG1yoGBWi+K7KizNPRescOFeByQn2ZtznMUHI61Ly5UKyylycnbXttNA/nGPOey3/ZwL1mV/pg6cCSeq8eJMsIuHhPVq4NjzKJX5Gh4nL4EVZg+hCCaSlI6g0YDW5uSiA5jpPDZhzhuwX9tlc2lo5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791939071; c=relaxed/simple;
	bh=V5MMkxLynIIyKMZVS1dRz4T9xVEbijQEvuiWZPE3m6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V79TeABL8TVINxeR0K6WYNh1SUEnDONdnm3124oOlO52tjGOV42TJRCsU1Y83Cv5+Rk0QaLgF9Q1Nigj+9WudPexvFwIRg3W0G+l2227XmGVHdw+JltUrUn25D9x73CSZjvC3QiM135Sml+OKQGwv9Dv31tE6A/js/9QslnivDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=h/jwnSA4; arc=none smtp.client-ip=23.83.223.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="h/jwnSA4"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 666F340265D;
	Wed, 14 Oct 2026 00:51:04 +0000 (UTC)
Received: from pdx1-sub0-mail-a233.dreamhost.com (100-98-37-160.trex-nlb.outbound.svc.cluster.local [100.98.37.160])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id EA5A2403952;
	Wed, 14 Oct 2026 00:51:03 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Eyes-Thread: 55251ccd64ff50e0_1791939064225_2171894218
X-MC-Loop-Signature: 1791939064225:3107968013
X-MC-Ingress-Time: 1791939064225
Received: from pdx1-sub0-mail-a233.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.98.37.160 (trex/8.0.2);
	Wed, 14 Oct 2026 00:51:04 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a233.dreamhost.com (Postfix) with ESMTPSA id 4j4CLb0Npnz103x;
	Tue, 13 Oct 2026 17:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1791939063;
	bh=zBIBkkBfkVDuxh0Ch6icchuEdKUPMlE1gehV7QY9wHs=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=h/jwnSA4ZsjAyrrHL4kPqBr2F7LSY2i0GjjYWZdFpDy5zhf7zBRreN0In/FrDPDFM
	 Gsjm4dcg3cahk6lkrNPIqPxg1VZe5s1E52KAG1WrOwnJv8KNKQq3jkLOV9WqqKRxwf
	 rkhD77CkL98oIupp8igtmiBcmBRat3jv1qq+8MPjymBs1WHUsHFQ7irUo1Kts49g8J
	 upne52iIQkDR0X0vk/3X+SvSjOXGoWV657rfo2F8JLjhl39iJys5wT6xfh+XCjOIjn
	 u8lW9mY7DD5HFHYKX8kYi7jYi+Iq4QAdqRmRHYaTuepe3D7fJfeWpxItlfzfxHbXnK
	 h7rPhB68kxSIw==
Date: Tue, 13 Oct 2026 17:51:00 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Richard Cheng <icheng@nvidia.com>
Cc: jic23@kernel.org, dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, iweiny@kernel.org, ming.li@zohomail.com,
	kaihengf@nvidia.com, kobak@nvidia.com, newtonl@nvidia.com,
	kristinc@nvidia.com, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/4] cxl/region: Don't leak tolerated RAM -EFAULT from
 unmapped poison scan
Message-ID: <20261014005100.yj6eqsewe2xnosfs@offworld>
References: <20260922101129.52794-1-icheng@nvidia.com>
 <20260922101129.52794-3-icheng@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260922101129.52794-3-icheng@nvidia.com>
User-Agent: NeoMutt/20220429

On Tue, 22 Sep 2026, Richard Cheng wrote:

>CXL 3.0 section 8.2.9.8.4.1 requires Get Poison List to return Invalid
>Physical Address for a volatile range when the device does not support
>volatile poison lists.
>
>For example, consider a memdev with a single RAM partition and a
>committed decoder covering only part of it:
>
>  RAM partition: [ committed decoder ][ unmapped tail ]
>
>On a device without volatile poison-list support, querying this tail
>returns Invalid Physical Address, which cxl_internal_send_cmd() maps
>to -EFAULT. The driver tolerates this response for RAM because volatile
>poison-list support is optional.
>
>When cxl_get_poison_unmapped() was converted to iterate over partitions,
>the RAM-specific error handling became a continue without clearing rc.
>If no subsequent query overwrites rc, the function returns the tolerated
>-EFAULT and incorrectly reports the enumeration as failed.
>
>Clear rc before continuing, restoring the previous handling of this
>expected response for RAM partitions.
>
>Fixes: be5cbd0840275 ("cxl: Kill enum cxl_decoder_mode")
>Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>Reviewed-by: Alison Schofield <alison.schofield@intel.com>
>Signed-off-by: Richard Cheng <icheng@nvidia.com>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

>---
> drivers/cxl/core/region.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>index 7c7287315d72..042356c71ed7 100644
>--- a/drivers/cxl/core/region.c
>+++ b/drivers/cxl/core/region.c
>@@ -2954,8 +2954,10 @@ static int cxl_get_poison_unmapped(struct cxl_memdev *cxlmd,
> 		if (!length)
> 			continue;
> 		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
>-		if (poison_efault_forgiven(rc, cxlds->part[i].mode))
>+		if (poison_efault_forgiven(rc, cxlds->part[i].mode)) {
>+			rc = 0;
> 			continue;
>+		}
> 		if (rc)
> 			break;
> 	}
>-- 
>2.43.0
>
