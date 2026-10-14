Received: from buffalo.tulip.relay.mailchannels.net (buffalo.tulip.relay.mailchannels.net [23.83.218.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749C1283CB5;
	Wed, 14 Oct 2026 01:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.218.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791941478; cv=none; b=r7X6Zf6WdgYXcjj4vUydXchNXSxP0qA5VM2B/KYxOCXRRjcaBngS48eaBhUU6SvKavdcSSLxRV8WjTVSBdfvY4CDHvGQT8lbqVzXiSDsasHedF92vBbDQdwC/zlFNr8qtSCz3t3RoOAxqOQpypECwchV+sAhvMwbIqC8J7ay54M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791941478; c=relaxed/simple;
	bh=65aaMEZ4l4SG+3yai4f3Vmrgy6drxbo3TYpumAF8H+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HVIoU/1eE0J1P3W3WgKlK/hSLmT1lyuTrltH2y+N4i2+/J1C1HDFzcTHbZlj41+AaS9TaTyRlxy84p4Y49ktkq2q8pc2mvLQwwBJFrXuzU3EMs+NuemyZNtaOX6S5cCPyl2kBwrFR9DiozjnUNf4uUaQTwbrxF3xuUNQUXY5BQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=gJ81NAJF; arc=none smtp.client-ip=23.83.218.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="gJ81NAJF"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id EC40E382008;
	Wed, 14 Oct 2026 01:13:20 +0000 (UTC)
Received: from pdx1-sub0-mail-a233.dreamhost.com (100-100-76-207.trex-nlb.outbound.svc.cluster.local [100.100.76.207])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id A0DEE380D84;
	Wed, 14 Oct 2026 01:13:20 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Lettuce-Minister: 55915af466baebd0_1791940400793_1852143453
X-MC-Loop-Signature: 1791940400793:282171953
X-MC-Ingress-Time: 1791940400793
Received: from pdx1-sub0-mail-a233.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.100.76.207 (trex/8.0.2);
	Wed, 14 Oct 2026 01:13:20 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a233.dreamhost.com (Postfix) with ESMTPSA id 4j4CrH4zBzz103w;
	Tue, 13 Oct 2026 18:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1791940400;
	bh=U0C+J4dqdPlm7JgNbcBpdmGMl5igpDbobE/kdwVvjIk=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=gJ81NAJF81cUEMhu9SEOe8DvnVbn7lIFtLHIodYzRe6oOBRC2mB6QDqfaAvLnI1a6
	 FgOHNiiukirx7LQsG3Bygcjh1WlgqTeBB07C/UWe6BIi3Pjx+iFn9QnORdlgk2WNW4
	 tS5g/dUmIQsuXES+Nt7FCDMP0CygwJ/dG06xXERH0+U5wqJKCY3Aft3Zy08kCOOSuC
	 uusa7DS2isF4cOge2YPMbhdGnETTDgGtZjDOePQ3ohnbeHaRUw+hukhckLq1CtMlx1
	 ws4eRk+BAE1kA+LRqYCuuiDwfRrCRXp3gmebTmUIOo6Sb7Ggu1t9iSrUwsH9AjOd6Y
	 JUdXdQfGlI6KA==
Date: Tue, 13 Oct 2026 18:13:16 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Richard Cheng <icheng@nvidia.com>
Cc: jic23@kernel.org, dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, iweiny@kernel.org, ming.li@zohomail.com,
	kaihengf@nvidia.com, kobak@nvidia.com, newtonl@nvidia.com,
	kristinc@nvidia.com, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH v8 4/4] cxl/memdev: Don't overwrite the error from an
 earlier partition poison query
Message-ID: <20261014011316.pm3ctf74lzbsogob@offworld>
References: <20260922101129.52794-1-icheng@nvidia.com>
 <20260922101129.52794-5-icheng@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260922101129.52794-5-icheng@nvidia.com>
User-Agent: NeoMutt/20220429

On Tue, 22 Sep 2026, Richard Cheng wrote:

>cxl_get_poison_by_memdev() queries Get Poison List per partition but
>never checks the result inside the loop, so a later partition's success
>overwrites an earlier partition's failure and the whole scan reports
>success while that partition's poison went unlisted. Before the loop
>conversion the PMEM query returned early on error. Stop the loop on any
>error not already tolerated as a RAM -EFAULT.
>
>Fixes: be5cbd084027 ("cxl: Kill enum cxl_decoder_mode")
>Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>Reviewed-by: Alison Schofield <alison.schofield@intel.com>
>Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
>Closes: https://sashiko.dev/#/patchset/20260708074228.43654-1-icheng@nvidia.com?part=5
>Signed-off-by: Richard Cheng <icheng@nvidia.com>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

... with a nit below.

>---
> drivers/cxl/core/memdev.c | 2 ++
> 1 file changed, 2 insertions(+)
>
>diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>index b3419df586b9..e39b3d13fd56 100644
>--- a/drivers/cxl/core/memdev.c
>+++ b/drivers/cxl/core/memdev.c
>@@ -231,6 +231,8 @@ static int cxl_get_poison_by_memdev(struct cxl_memdev *cxlmd)
> 		 */
> 		if (rc == -EFAULT && cxlds->part[i].mode == CXL_PARTMODE_RAM)

This wants poison_efault_forgiven() - maybe move out of region.c into core.h?

> 			rc = 0;
>+		if (rc)
>+			break;
> 	}
> 	return rc;
> }
>-- 
>2.43.0
>
