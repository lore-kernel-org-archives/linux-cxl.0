Received: from pv50p00im-zteg10011401.me.com (pv50p00im-zteg10011401.me.com [17.58.6.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393DD125B9
	for <linux-cxl@vger.kernel.org>; Wed, 16 Oct 2024 22:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729116694; cv=none; b=OMQBR/i0EzPtvXiq4078Yu/0vnzGBUrjfXJqAIlkUxgk+oGDzJSHi2R1quBp62TL3AsFK5CfjxceGvjEaFHB6gK2tgXsQHXYCpIKrXT4Mz1SQhcrLqEyXkjncPFpYq6+zw1raUIL+APNXo6NCMSJH6XPVNekMy9edm/BBMi8B7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729116694; c=relaxed/simple;
	bh=4DjQWmZ8afhpQmbAX+dr09RVutOY3lU2/lPYP6oRlow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YqGkQJTzkUnexgZLJ7Km7OBHpRczTeekOZ6/pMU4jlVagsZ2bqG9wKnR4jaD6EYF39KBrD0G2hxtQTSVbcdmM/3XYWyCi21cDX+njIDVNVfstnCeufHn6gaie+/7mDF8VjU2edIvvtbBwKmPtxJNIjHOlZe7/mvIGoSEwGtyKfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=jTOxdVmZ; arc=none smtp.client-ip=17.58.6.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="jTOxdVmZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1729116692;
	bh=1jyQhHEuCvsHv/vA456MKl3mZ9JM6WqPCkF7WlbdAps=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=jTOxdVmZ61KHPnZ2fBRY4lVpFvXOSNf3+6/cmdQRHYmzyBHm507m7TD0aPUbRFaTI
	 U2CWsKddcGpZMTk6Cs/Z4f24o0rxEjzJTK+5IGRXs6o786Zmua+4GKz6pkWDNfAnzu
	 tWQGjD8bb8x3q93FFps0+u5HarU9aMhHDA+AzXEVOhk2uvXahdrjFkPEI3GrG8ZHBa
	 CrfZhWpKTZ4ZiweuP64hc3M5Y98cYpmgDNUhnzGMVWjFeV11GwQraj4lrZ+ueMsl0p
	 94GC/r8S4+uqEEvJvmY+QhzaLW6YG6ZlgHtjwxD3Mtzx9y4j2fkxKvtENViPP6UhPi
	 zkEO5aO5RENxg==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10011401.me.com (Postfix) with ESMTPSA id B85D734BA75E;
	Wed, 16 Oct 2024 22:11:28 +0000 (UTC)
Message-ID: <b373be7f-7865-41fa-9357-849e91942ac1@icloud.com>
Date: Thu, 17 Oct 2024 06:11:19 +0800
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
X-Proofpoint-GUID: DVoimzy16BYZ-s4_vl1sNKnoEr3COpY9
X-Proofpoint-ORIG-GUID: DVoimzy16BYZ-s4_vl1sNKnoEr3COpY9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-16_17,2024-10-16_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 malwarescore=0 spamscore=0
 clxscore=1015 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2308100000 definitions=main-2410160141

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

Hi Dan,

i also submitted v6 based on your recommendation but with some
optimization here.

https://lore.kernel.org/all/20241017-const_dfc_prepare-v6-1-fc842264a1cc@quicinc.com/

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

