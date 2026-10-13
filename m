Received: from sender5-pp-o94.zoho.com (sender5-pp-o94.zoho.com [165.173.182.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1252A4B405F
	for <linux-cxl@vger.kernel.org>; Tue, 13 Oct 2026 06:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791873040; cv=pass; b=BGxYBBiB3r7CCUEKRg32SW5LfgtW8Zw36jyq+b0ypZL/xgrQlyLMrALG+UTZ3012GspKHbRmDMiYVajnc3DaVH2qGk7Oyh7QrZNOmqmW1OH1mHJTHDMMAnzt2V0HEO53vaZXM0O3Gc1sogLrYt8faKbyF6J36eUgKfkymEanq5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791873040; c=relaxed/simple;
	bh=bHbOVwNnXwZzVSWEftMJb6mviEf0vsMbL0axAnnbQ3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SKXGdCwXGJM0DzrWmIeg0ndQGFnbxnmwRr17LoGm++CnEYw80mqEne3UWI4UBALHiob87ZMw8EmZVget/IxKV90TMcCjPzNGgBcYjbHNhQsnQXynHWnM+tvbwQvslYB9aV2Vv6f+uq7mwmNmJ5mEDNU6mO5dR/cOd22QLbI+7A8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=eETIqdWp; arc=pass smtp.client-ip=165.173.182.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="eETIqdWp"
ARC-Seal: i=1; a=rsa-sha256; t=1791873028; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UEy5Je/nua71hzgt7IZzxHJ/lmZkFIdduo9jOLnnPS8iKesEOfu6avEp5Ene3W4hqUQhn0lsSn74dR2qFEOmwqJ3X7ipLM5YgvK3x00B9R+PC70sTuw+n3WQJCOwNHYTNprqoKrV1ftoW4RWmvSsYvk5l6w0j/vCD/T5fRhiyHE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1791873028; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=YNMuTl+53mrqGfEy6YMUPssBPh9biu1KYNYd09onSV4=; 
	b=k2xqshI8jQyZgXYzl7BjDsSXnnbs3bTAgZ1+tGLLCipbgrPDgw+sMi9V8ncDpEQLg6XtIKBT/oteXzolNGwFdJAQubdqs8RhsugnEYd0oaFUzGVnA22+GxuJGQ9f21zOypO/XCrJGO21aib+1iZeWb3MafEaRQkCmkA3qgZLXfw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791873028;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=YNMuTl+53mrqGfEy6YMUPssBPh9biu1KYNYd09onSV4=;
	b=eETIqdWpSF1+8KUdgZjFn5/xxIWAe04ZSZxkBwZf65GJWI/UkQXQuVmvg4GfDktc
	CSkk/Qoz1aeApQ4HxqT6FD8mNMKALonBTt9wTVu6hVcQAXsckdFJsKUqyMVMhCgIfRE
	rRuEC3hCBzelgzkt8X+aDJMjFXAt/3QRmpwNhGKo=
Received: by smtp.zohomail.com with SMTPS id 1791873026031887.4650238733176;
	Mon, 12 Oct 2026 23:30:26 -0700 (PDT)
Message-ID: <6b0430bd-b7f6-48b4-bf56-efd1ff6bcda9@zohomail.com>
Date: Tue, 13 Oct 2026 14:30:22 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/7] cxl/region: Factor out cxl_port_peer_distance()
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <iweiny@kernel.org>, Richard Cheng <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org,
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
References: <cover.1791860305.git.alison.schofield@intel.com>
 <ab51546efee79855622d10a71993ef7d21ee247f.1791860305.git.alison.schofield@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <ab51546efee79855622d10a71993ef7d21ee247f.1791860305.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: zu08011227366d7395f3ce50b946ade2880000a625aa76fadc145450c81321166563a925903594ae64fd3f7c:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External


在 2026/10/13 12:25, Alison Schofield 写道:
> cxl_switch_port_setup_targets() is nearly 200 lines long and open codes
> each step of adding an endpoint to a port's decoder. One of those steps
> calculates the distance between region positions that share a downstream
> port.
>
> Move that calculation to a new helper, cxl_port_peer_distance().
>
> No functional change.
>
> Assisted-by: LLM
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>

> ---
>   drivers/cxl/core/region.c | 50 +++++++++++++++++++++++----------------
>   1 file changed, 29 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 9b0e2f195d1f..ea281ce4ec49 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1432,6 +1432,33 @@ static int check_interleave_cap(struct cxl_decoder *cxld, int iw, int ig)
>   	return 0;
>   }
>   
> +/*
> + * The "distance" between peer downstream ports represents which
> + * endpoint positions in the region interleave a given port can
> + * host.
> + *
> + * For example, at the root of a hierarchy the distance is
> + * always 1 as every index targets a different host-bridge. At
> + * each subsequent switch level those ports map every Nth region
> + * position where N is the width of the switch == distance.
> + */
> +static int cxl_port_peer_distance(struct cxl_port *port, struct cxl_region *cxlr)
> +{
> +	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
> +	struct cxl_region_ref *cxl_rr_iter;
> +	struct cxl_port *iter = port;
> +	int distance = 1;
> +
> +	do {
> +		cxl_rr_iter = cxl_rr_load(iter, cxlr);
> +		distance *= cxl_rr_iter->nr_targets;
> +		iter = to_cxl_port(iter->dev.parent);
> +	} while (!is_cxl_root(iter));
> +	distance *= cxlrd->cxlsd.cxld.interleave_ways;
> +
> +	return distance;
> +}
> +
>   static int cxl_switch_port_setup_targets(struct cxl_port *port,
>   					 struct cxl_region *cxlr,
>   					 struct cxl_endpoint_decoder *cxled)
> @@ -1445,7 +1472,6 @@ static int cxl_switch_port_setup_targets(struct cxl_port *port,
>   	struct cxl_region_params *p = &cxlr->params;
>   	struct cxl_decoder *cxld = cxl_rr->decoder;
>   	struct cxl_switch_decoder *cxlsd;
> -	struct cxl_port *iter = port;
>   
>   	/*
>   	 * While root level decoders support x3, x6, x12, switch level
> @@ -1460,27 +1486,9 @@ static int cxl_switch_port_setup_targets(struct cxl_port *port,
>   
>   	cxlsd = to_cxl_switch_decoder(&cxld->dev);
>   	if (cxl_rr->nr_targets_set) {
> -		int i, distance = 1;
> -		struct cxl_region_ref *cxl_rr_iter;
> +		int distance = cxl_port_peer_distance(port, cxlr);
>   
> -		/*
> -		 * The "distance" between peer downstream ports represents which
> -		 * endpoint positions in the region interleave a given port can
> -		 * host.
> -		 *
> -		 * For example, at the root of a hierarchy the distance is
> -		 * always 1 as every index targets a different host-bridge. At
> -		 * each subsequent switch level those ports map every Nth region
> -		 * position where N is the width of the switch == distance.
> -		 */
> -		do {
> -			cxl_rr_iter = cxl_rr_load(iter, cxlr);
> -			distance *= cxl_rr_iter->nr_targets;
> -			iter = to_cxl_port(iter->dev.parent);
> -		} while (!is_cxl_root(iter));
> -		distance *= cxlrd->cxlsd.cxld.interleave_ways;
> -
> -		for (i = 0; i < cxl_rr->nr_targets_set; i++)
> +		for (int i = 0; i < cxl_rr->nr_targets_set; i++)
>   			if (ep->dport == cxlsd->target[i]) {
>   				rc = check_last_peer(cxled, ep, cxl_rr,
>   						     distance);
