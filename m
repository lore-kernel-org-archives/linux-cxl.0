Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CDE26AE6
	for <linux-cxl@vger.kernel.org>; Mon, 22 Apr 2024 11:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713784643; cv=none; b=S2aCv5oe5rDJ+1UgUQqc/fIWHB9wM45nX+GZoWFaTeE5+lyiJX14JMeOLjSBSoxASsXFI1uO0G7jtZJZSPmvjPuyWE1sn1BZuhMoAYH9xoPfa6J3vg26qfkT9PiAdDW3TJNVBxzjaRbN/8krcKO3sVLCyz8Dcufwb8W+SllMF78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713784643; c=relaxed/simple;
	bh=e6yS/kassOhrnGF23DnX29hMbbT/ooMTf/8bBJEc0AQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sxsLzfRkpMX768HS38vh7ll77ABBi0EepkF1bqPqXpQWgH0lzJtXxgkrwKF+FAOEuA6H1SsZ7bdj/Ewi/utWXm1mFVgHzEfnFcj/MRspEThJohy4btZlGnHrzj2sBL8QZ4Kno6NSWaNX8wn+t9HVjc32Lm3Zis0uqGi4zf3wGzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VNN2K1fznz6JBSq;
	Mon, 22 Apr 2024 19:15:05 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id D3A581406AC;
	Mon, 22 Apr 2024 19:17:18 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 22 Apr
 2024 12:17:18 +0100
Date: Mon, 22 Apr 2024 12:17:17 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Yao Xingtao <yaoxt.fnst@fujitsu.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <jim.harris@samsung.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] cxl/region: check interleave capability
Message-ID: <20240422121717.000025ab@Huawei.com>
In-Reply-To: <20240422091350.4701-3-yaoxt.fnst@fujitsu.com>
References: <20240422091350.4701-1-yaoxt.fnst@fujitsu.com>
	<20240422091350.4701-3-yaoxt.fnst@fujitsu.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 22 Apr 2024 05:13:50 -0400
Yao Xingtao <yaoxt.fnst@fujitsu.com> wrote:

> Since interleave capability is not verified, a target can successfully
> attach to a region even if it lacks support for the specified interleave
> ways or granularity.
> 
> When attempting to access memory, unexpected behavior occurs due to the
> incorrect conversion of HPA to a faulty DPA, leading to a segmentation
> fault, as observed when executing the command:
> $ numactl -m 2 ls

Don't mention a segfault as in theory it should have been impossible to
set this decoder up (commit decoder should have failed at the device end).
So just say that it fails and leave the details unmentioned.

> 
> According to the CXL specification (section 8.2.4.20 CXL HDM Decoder
> Capability Structure), bits 11 and 12 within the 'CXL HDM Decoder
> Capability Register' indicate the capability to establish interleaving
> in 3, 6, 12, and 16 ways. If these bits are not set, the target cannot
> be attached to a region utilizing such interleave ways.
> 
> Additionally, bits 8 and 9 in the same register represent the capability
> of the bits used for interleaving in the address, commonly referred to as
> the interleave mask.
> 
> Regarding 'Decoder Protection':
> If IW is less than 8 (for interleave ways of 1, 2, 4, 8, 16), the
> interleave bits start at bit position IG + 8 and end at IG + IW + 8 - 1.
> 
> If the IW is greater than or equal to 8 (for interleave ways of 3, 6, 12),
> the interleave bits start at bit position IG + 8 and end at IG + IW - 1.
> 
> If the interleave mask is insufficient to cover the required interleave
> bits, the target cannot be attached to the region.
> 
> The above check does not apply to the host-bridges with single port and
> switches with single dport, because there does not have a instance of
> CXL HDM Decoder Capability Structure for them.

There needs to be clear separation between such cases that do not
have HDM decoders and the permissible case where there is one but
it can effectively be set to anything because no interleaving is
going on.

> 
> Fixes: 384e624bb211 ("cxl/region: Attach endpoint decoders")
> Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>

>  
>  static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 5c186e0a39b9..5c09652136c9 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1210,6 +1210,60 @@ static int check_last_peer(struct cxl_endpoint_decoder *cxled,
>  	return 0;
>  }
>  
> +static int check_interleave_cap(struct cxl_decoder *cxld, int iw, int ig)
> +{
> +	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
> +	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
> +	struct cxl_switch_decoder *cxlsd;
> +	unsigned int interleave_mask;
> +	u8 eiw;
> +	u16 eig;
> +	int rc, high_pos, low_pos;
> +
> +	if (is_switch_decoder(&cxld->dev)) {
> +		cxlsd = to_cxl_switch_decoder(&cxld->dev);
> +		if (cxlsd->passthrough)
> +			return 0;
> +	}
> +
> +	rc = ways_to_eiw(iw, &eiw);
> +	if (rc)
> +		return rc;
> +
> +	if (!(cxlhdm->iw_cap_mask & BIT(iw)))
> +		return -EOPNOTSUPP;
> +
> +	rc = granularity_to_eig(ig, &eig);
> +	if (rc)
> +		return rc;
> +
> +	/*
> +	 * Per CXL specification (8.2.3.20.13 Decoder Protection in r3.1)
> +	 * if IW < 8, the interleave bits start at bit position IG + 8, and
> +	 * end at IG + IW + 8 - 1.
> +	 * if IW >= 8, the interleave bits start at bit position IG + 8, and
> +	 * end at IG + IW - 1.
> +	 */
> +	if (eiw >= 8)
> +		high_pos = eiw + eig - 1;
> +	else
> +		high_pos = eiw + eig + 7;
> +	low_pos = eig + 8;
> +	/*
> +	 * when the IW is 0 or 8 (interlave way is 1 or 3), the low_pos is
> +	 * larger than high_pos, since the target is in the target list of a
> +	 * passthrough decoder, the following check is ignored.

There may be a decoder even on 1 to 1 routing cases so is this correct?

> +	 */
> +	if (low_pos > high_pos)
> +		return 0;



