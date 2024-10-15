Received: from pv50p00im-ztbu10021601.me.com (pv50p00im-ztbu10021601.me.com [17.58.6.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45E4A939
	for <linux-cxl@vger.kernel.org>; Tue, 15 Oct 2024 00:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728952504; cv=none; b=AP8fMNFGfvRKuJOXbA61yYacrrI5DscNK9pbtx+ncxD6UcUZAV34N4Dx0Un45A0p23BT2QTmUF90YQTivieRL5L55PZxrpJBe28M5z2zcinWRalsRHnzBnlTdPpz792tytt4SuNhdPpUx9ZU3j+EepcB68p+c1fsXoz48n6Us8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728952504; c=relaxed/simple;
	bh=qZKYebv8+UP4UOYA73z6K56g7txntkydaplfNWOIwJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HFl7QZUqVrTs5CZ4EjpnsNm9qaCPxqNDxOj4w3T6G8tzsO0APflOeHgvqOvoKVyiAlKwW89epmcVMP0WJsCFzAxwjuKTAep2eUCcehDgH5wHWk7c8gvzPPsOA3bBzwEwXWKkZdht52x0nFl6Q675CbaeWgvL589aPbtB49n5ftE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=MdCvR38M; arc=none smtp.client-ip=17.58.6.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="MdCvR38M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1728952502;
	bh=X46hMIKenxkRjNwBoi4spZZ7L2G/isjMSiQT/wEAj14=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=MdCvR38MxYhmwkvaj/Ke5o+7N1o4yT3jFmNYR/ZAhGcjO5ELhmKQaoKXbuiPD4or4
	 htpFXTIUYFxJlL9o+v+m2fOZoQ1HV5yMeH9zSKJb9UJikHjWilcEBzsvHox3MPunTx
	 0yqTgkXw7Z9EuAkPdaeUomQHNkyqRe4cAI9vQV0/V5TpgKE5xReHwZKMPivmq90EnU
	 Ucr5+ITGNhVb5DuUX+VWa6CgHf35kPVWkK6fTZc3EmAqxZ3ABwlNFOKVCHSwF3ns3Z
	 Jr+7TwnrhL7ypf/hLlnVBXFyrJaXphV0cMRnqsvsZsY0+gFNK3elArDfMNFrpivkVp
	 xFZdBmoXcetWw==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztbu10021601.me.com (Postfix) with ESMTPSA id 0F1E180444;
	Tue, 15 Oct 2024 00:34:57 +0000 (UTC)
Message-ID: <34f9ecb4-e3a3-496b-91f9-12428045d054@icloud.com>
Date: Tue, 15 Oct 2024 08:34:53 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/port: Prevent out-of-order decoder allocation
To: Dan Williams <dan.j.williams@intel.com>, dave.jiang@intel.com,
 ira.weiny@intel.com
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, linux-cxl@vger.kernel.org
References: <172895072669.39002.9296583943188706348.stgit@dwillia2-xfh.jf.intel.com>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <172895072669.39002.9296583943188706348.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 8V9WptBK5V9_z0R5L3mDeBb6O1gGYvR3
X-Proofpoint-ORIG-GUID: 8V9WptBK5V9_z0R5L3mDeBb6O1gGYvR3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-14_19,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 mlxscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2308100000 definitions=main-2410150002

On 2024/10/15 08:06, Dan Williams wrote:
> With the recent change to allow out-of-order decoder de-commit it
> highlights a need to strengthen the in-order decoder commit guarantees.
> As it stands match_free_decoder() ensures that if 2 regions are racing
> decoder allocations the one that wins the race will get the lower id
> decoder, but that still leaves the race to *commit* the decoder.
> 
> Rather than have this complicated case of "reserved in-order, but may
> still commit out-of-order", just arrange for the reservation order to
> match the commit-order. In other words, prevent subsequent allocations
> until the last reservation is committed.
> 
> This precludes overlapping region creation events and requires the
> previous regionN to either move forward to the decoder commit stage or
> drop its reservation before regionN+1 can move forward. That is,
> provided that regionN and regionN+1 decode through the same switch port.
> 
> As a side effect this allows match_free_decoder() to drop its dependency
> on needing write access to the device_find_child() @data parameter [1].
> 
> Reported-by: Zijun Hu <zijun_hu@icloud.com>
> Closes: http://lore.kernel.org/20240905-const_dfc_prepare-v4-0-4180e1d5a244@quicinc.com [1]
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
> This patch is incremental to "cxl: Initialization and shutdown fixes"
> 
> [2]: http://lore.kernel.org/172862483180.2150669.5564474284074502692.stgit@dwillia2-xfh.jf.intel.com
> 
>  drivers/cxl/core/region.c |   43 +++++++++++++++++++++++++++++++++----------
>  1 file changed, 33 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 3478d2058303..dff618c708dc 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -778,26 +778,50 @@ static size_t show_targetN(struct cxl_region *cxlr, char *buf, int pos)
>  	return rc;
>  }
>  
> +static int check_commit_order(struct device *dev, const void *data)
> +{
> +	struct cxl_decoder *cxld = to_cxl_decoder(dev);
> +
> +	/*
> +	 * if port->commit_end is not the only free decoder, then out of
> +	 * order shutdown has occurred, block further allocations until
> +	 * that is resolved
> +	 */
> +	if (((cxld->flags & CXL_DECODER_F_ENABLE) == 0))
> +		return -EBUSY;
> +	return 0;
> +}
> +
>  static int match_free_decoder(struct device *dev, void *data)
>  {
> +	struct cxl_port *port = to_cxl_port(dev->parent);
>  	struct cxl_decoder *cxld;
> -	int *id = data;
> +	int rc;
>  
>  	if (!is_switch_decoder(dev))
>  		return 0;
>  
>  	cxld = to_cxl_decoder(dev);
>  
> -	/* enforce ordered allocation */
> -	if (cxld->id != *id)
> +	if (cxld->id != port->commit_end + 1)
>  		return 0;
>  
> -	if (!cxld->region)
> -		return 1;
> -
> -	(*id)++;
> +	if (cxld->region) {
> +		dev_dbg(dev->parent,
> +			"next decoder to commit (%s) is already reserved (%s)\n",
> +			dev_name(dev), dev_name(&cxld->region->dev));
> +		return 0;
> +	}
>  
> -	return 0;
> +	rc = device_for_each_child_reverse_from(dev->parent, dev, NULL,
> +						check_commit_order);
> +	if (rc) {
> +		dev_dbg(dev->parent,
> +			"unable to allocate %s due to out of order shutdown\n",
> +			dev_name(dev));
> +		return 0;
> +	}

Above checking seems meaningless since there are only one CLDX with ID
port->commit_end + 1.

logical of below my proposal maybe what you want.
https://lore.kernel.org/all/4239bfd4-d5fe-4ac8-a087-9e1584765e61@icloud.com/

> +	return 1;
>  }
>  
>  static int match_auto_decoder(struct device *dev, void *data)
> @@ -824,7 +848,6 @@ cxl_region_find_decoder(struct cxl_port *port,
>  			struct cxl_region *cxlr)
>  {
>  	struct device *dev;
> -	int id = 0;
>  
>  	if (port == cxled_to_port(cxled))
>  		return &cxled->cxld;
> @@ -833,7 +856,7 @@ cxl_region_find_decoder(struct cxl_port *port,
>  		dev = device_find_child(&port->dev, &cxlr->params,
>  					match_auto_decoder);
>  	else
> -		dev = device_find_child(&port->dev, &id, match_free_decoder);
> +		dev = device_find_child(&port->dev, NULL, match_free_decoder);
>  	if (!dev)
>  		return NULL;
>  	/*
> 

