Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72C8227BB5
	for <linux-cxl@vger.kernel.org>; Tue, 19 Aug 2025 12:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755605040; cv=none; b=uixuSOKLOQKlQstzenFvWhnf+elc6XTiLsh57w0azIFmH+c14m31GhU68b4m/xpK+pF5u+vhQWiI7hTf/f+Vm62IxQRYr+NpMSdv2YrWlaV7Bo5Cdur2jYRf/15t64Yr1FrggcOQzp4dMKiOja+cRWGrqfbOrdd/G1dgU5ajXgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755605040; c=relaxed/simple;
	bh=NVgzV0Zsyju0fyqX4POuH05Wjj6icxkpawjOFnALSl0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oq5+OSn3e4Bx1sxPTTQ6odXxbd4dmjet3C8NXn9ypWrGdZb/gGFA4x+/KhDIl9Yxrnolv0d7eTlKYHnDUxBImvCX+9EpBkpSTfPQikZpSz1k2ZXxbmcESt2ACgRdNm/gjKG+82gjydZBxn+NGv0e72P2MgQ5GRWUnaiem7Py5NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c5p7q3LwKz6H85j;
	Tue, 19 Aug 2025 20:00:55 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 6769314037D;
	Tue, 19 Aug 2025 20:03:55 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 19 Aug
 2025 14:03:54 +0200
Date: Tue, 19 Aug 2025 13:03:53 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH 08/18] cxl/port: Update switch_port_probe() for CXL
 cache devices
Message-ID: <20250819130353.0000659e@huawei.com>
In-Reply-To: <20250812212921.9548-9-Benjamin.Cheatham@amd.com>
References: <20250812212921.9548-1-Benjamin.Cheatham@amd.com>
	<20250812212921.9548-9-Benjamin.Cheatham@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 12 Aug 2025 16:29:11 -0500
Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:

> CXL switch port probe currently assumes there are only CXL.mem-capable
> devices below the switch with preconfigured HDM decoders. Now that
> CXL.cache devices can be added below a switch port, it's possible that
> they either have no HDM decoders (type 1) or the CXL.mem capabilities of
> the endpoint haven't been set up yet (type 2).
> 
> The HDM decoders being disabled (if present) is no longer a gauranteed
> failure condition when only cache devices are present below the port.
> Knowing what kind of devices are under the switch port isn't possible
> until the endpoints are probed, so delay HDM setup and validation until
> endpoint port probe.
> 
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> ---
>  drivers/cxl/core/hdm.c | 31 +++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h      |  1 +
>  drivers/cxl/port.c     | 23 +++++++++++++----------
>  3 files changed, 45 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 865a71bce251..6e04f1f4c166 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -205,6 +205,37 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
>  }
>  EXPORT_SYMBOL_NS_GPL(devm_cxl_setup_hdm, "CXL");
>  
> +int cxl_validate_endpoint_hdm_setup(struct cxl_port *endpoint)
> +{
> +	struct cxl_port *sp = parent_port_of(endpoint);
> +	struct cxl_hdm *cxlhdm;
> +	int rc;
> +
> +	for (; sp && !is_cxl_root(sp); sp = parent_port_of(sp)) {

Might as well set sp as loop init rather than earlier.

> +		cxlhdm = dev_get_drvdata(&sp->dev);
> +		if (cxlhdm && cxlhdm->decoder_count > 0)
> +			continue;
> +
> +		if (!sp->reg_map.component_map.hdm_decoder.valid || !cxlhdm) {
> +			dev_err(&sp->dev, "Missing HDM decoder capability\n");
> +			return -ENXIO;
> +		}
> +
> +		if (sp->total_dports == 1) {
> +			dev_dbg(&sp->dev, "Fallback to passthrough decoder\n");
> +			rc = devm_cxl_add_passthrough_decoder(sp);
> +			if (rc)
> +				return rc;
> +		}
> +	}
> +
> +	if (is_cxl_root(sp))
> +		return 0;

Could move this test into the loop, alowing the loop condition to be simplified
to just sp;

> +
> +	return -ENODEV;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_validate_endpoint_hdm_setup, "CXL");
> +

