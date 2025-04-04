Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B101E12DD95;
	Fri,  4 Apr 2025 13:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743774042; cv=none; b=ekoCz+qdHR3ZVR/EAwp2e4XtPRqJOBpTVGYPJ+B+KCQA3CYUgcqCzw7ocFB7CkdRPY8T2+musHL/MDWFfXRg2Or2ikLhDRV5yJ+zxhqFZsAL2FQK49XUzopP4x+afxpNAicr9HhPAYIFmP3I84PfCiJrOdm25/iVUoFnJ0bQlpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743774042; c=relaxed/simple;
	bh=08nROLE83sH/QfN+ScKwvqbF/rDt1zpxINveXRGVxQQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eD+PYcIztE7hxA3xDWhu2BBYeuKNoW+UQZE9izYaLHPIWzx2BRh2SDwYp9UUWgjb58yJmCERbhf+Xk2NwTmEnRuyUh+o7dp23vXPQn5KLv7Kt6aFYDidMcgxZxO33umd8NC4rSM3O00hqoAwUCGmF3bFLcN0MtLNKwWAerBsVlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZTflt0wvpz6K9DN;
	Fri,  4 Apr 2025 21:36:58 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id B59A11404F9;
	Fri,  4 Apr 2025 21:40:38 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 4 Apr
 2025 15:40:38 +0200
Date: Fri, 4 Apr 2025 14:40:36 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Gregory Price <gourry@gourry.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kernel-team@meta.com>, <dan.j.williams@intel.com>,
	<vishal.l.verma@intel.com>, <dave.jiang@intel.com>, <dave@stgolabs.net>,
	<alison.schofield@intel.com>, <ira.weiny@intel.com>
Subject: Re: [PATCH v2] cxl: core/region - ignore interleave granularity
 when ways=1
Message-ID: <20250404144036.000021c1@huawei.com>
In-Reply-To: <20250402232552.999634-1-gourry@gourry.net>
References: <20250402232552.999634-1-gourry@gourry.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed,  2 Apr 2025 19:25:52 -0400
Gregory Price <gourry@gourry.net> wrote:

> When validating decoder IW/IG when setting up regions, the granularity
> is irrelevant when iw=1 - all accesses will always route to the only
> target anyway - so all ig values are "correct". Loosen the requirement
> that `ig = (parent_iw * parent_ig)` when iw=1.
> 
> On some Zen5 platforms, the platform BIOS specifies a 256-byte
> interleave granularity window for host bridges when there is only
> one target downstream.  This leads to Linux rejecting the configuration
> of a region with a x2 root with two x1 hostbridges.
> 
> Decoder Programming:
>    root - iw:2 ig:256
>    hb1  - iw:1 ig:256  (Linux expects 512)
>    hb2  - iw:1 ig:256  (Linux expects 512)
>    ep1  - iw:2 ig:256
>    ep2  - iw:2 ig:256
> 
> This change allows all decoders downstream of a passthrough decoder to
> also be configured as passthrough (iw:1 ig:X), but still disallows
> downstream decoders from applying subsequent interleaves.
> 
> e.g. in the above example if there was another decoder south of hb1
> attempting to interleave 2 endpoints - Linux would enforce hb1.ig=512
> because the southern decoder would have iw:2 and require ig=pig*piw.
> 
> Signed-off-by: Gregory Price <gourry@gourry.net>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reasonable work around and good explanation.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/region.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 04bc6cad092c..dec262eadf9a 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1553,7 +1553,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  
>  	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
>  		if (cxld->interleave_ways != iw ||
> -		    cxld->interleave_granularity != ig ||
> +		    (iw > 1 && cxld->interleave_granularity != ig) ||
>  		    cxled->spa_range.start != p->res->start ||
>  		    cxled->spa_range.end != p->res->end ||
>  		    ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)) {

