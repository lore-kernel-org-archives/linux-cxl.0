Received: from mr85p00im-ztdg06021801.me.com (mr85p00im-ztdg06021801.me.com [17.58.23.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2CF4437
	for <linux-cxl@vger.kernel.org>; Sun, 20 Oct 2024 08:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729413983; cv=none; b=Xncfobp0MirC35quKEDPi9+gAX27mJuVE63MMy4zchCVCX3dBKz8XapbkRiplSqoYNBtPhkaozoiUd67VWR009RPbuLrLBPIjhqdl2LTaicKFP6tPXDc0NplwDExQOiq4NJTn2xhnEMK+DzTj+FGRmSdUcvMe9MmzvjhSaWGXlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729413983; c=relaxed/simple;
	bh=shYzWH38M0Iv0HOwyJX3iMO3xg6YQ1sjq2Q+5s0EwUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jbhXURY7YDUecIyTr1BkjCZ4uFymNp/fYsWNhFTHktqwJCei4sbnb3oJ4MLD2U9EdtOoV9XnWIf/dUISA7jaXm4kxHKNhM7RUg/a0ePXzB1Sh0W6+mh+if6+T7T715nGlwBBJ/PxrbixuAP9A9DglaxB9VYPp/EYL9vVYsty8yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=L40R9w/g; arc=none smtp.client-ip=17.58.23.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="L40R9w/g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1729413981;
	bh=n//xIPg2nhbV3/j5eH5T6ewlg1fUXDH32mPjzxFchtU=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=L40R9w/gyoeYQytpxdL8312eCHzojIHs9TtfhvViCY4qOH1MZi902uoIbzn558k3D
	 SNDDInDvu2s0jyDettC/wX3uM2n1Tn1SsvBGaBPO6QivD7wg6aZOyavybgqAg8Zjka
	 41rKuSTJv1D+bs/wWxbJ3Xk7i3baoz8VYR4zxP3JcEZIhh9U2Mtc2pOLl7Ci+bN10+
	 zQ8dCsowuT0u+rgnh1/ufWsPGEAIiUgfPdPAIU2Df94X2b6EangopeDgPrepQptZ83
	 3w+eRBNneBZeHxT+fybTla81683asELSPnUgK8hdq6j9T2Cuqivar8CzIhQurFP4Ko
	 eOWu6FZTxGJ/Q==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06021801.me.com (Postfix) with ESMTPSA id 2E2FCD0011E;
	Sun, 20 Oct 2024 08:46:17 +0000 (UTC)
Message-ID: <f6a954b6-a6fe-4b14-831c-b6e4bd106e5d@icloud.com>
Date: Sun, 20 Oct 2024 16:46:13 +0800
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
 Jonathan Cameron <jonathan.cameron@huawei.com>, linux-cxl@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <172895072669.39002.9296583943188706348.stgit@dwillia2-xfh.jf.intel.com>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <172895072669.39002.9296583943188706348.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: e86EAHkBL0pZsviaruqiI9FTl3P2yj0o
X-Proofpoint-ORIG-GUID: e86EAHkBL0pZsviaruqiI9FTl3P2yj0o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-20_06,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 mlxscore=0
 clxscore=1015 spamscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2410200056

On 2024/10/15 08:06, Dan Williams wrote:
> With the recent change to allow out-of-order decoder de-commit it
[snip]
> 
> As a side effect this allows match_free_decoder() to drop its dependency
> on needing write access to the device_find_child() @data parameter [1].
> 
Hi Dan Williams.

is it possible to make its fix into in v6.13-rc1?

i will start below bigger series which only depends on this fix ASAP.
https://lore.kernel.org/all/20240811-const_dfc_done-v1-0-9d85e3f943cb@quicinc.com/

> Reported-by: Zijun Hu <zijun_hu@icloud.com>

may use below one for v2 when possible
Zijun Hu <quic_zijuhu@quicinc.com>

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

what about below optimized one?

1) it is simpler
2) it only uses exiting driver core API.
3) it has the minimal iterating count.

you may use it as v2 if you also like it.

https://patchwork.kernel.org/project/cxl/patch/20241017-const_dfc_prepare-v6-1-fc842264a1cc@quicinc.com/

+++ b/drivers/cxl/core/region.c
@@ -796,8 +796,9 @@  static size_t show_targetN(struct cxl_region *cxlr,
char *buf, int pos)

 static int match_free_decoder(struct device *dev, void *data)
 {
+	struct cxl_port *port = to_cxl_port(dev->parent);
 	struct cxl_decoder *cxld;
-	int *id = data;
+	struct device **target_dev = data;

 	if (!is_switch_decoder(dev))
 		return 0;
@@ -805,15 +806,24 @@  static int match_free_decoder(struct device *dev,
void *data)
 	cxld = to_cxl_decoder(dev);

 	/* enforce ordered allocation */
-	if (cxld->id != *id)
-		return 0;
+	if (cxld->id == port->commit_end + 1) {
+		if (!cxld->region) {
+			*target_dev = dev;
+			return 1;
+		}

-	if (!cxld->region)
-		return 1;
+		dev_dbg(dev->parent,
+			"%s: cxld '%s' was reserved by '%s'\n", __func__,
+			dev_name(dev), dev_name(&cxld->region->dev));
+		return -EBUSY;
+	}

-	(*id)++;
+	if (cxld->flags & CXL_DECODER_F_ENABLE)
+		return 0;

-	return 0;
+	dev_dbg(dev->parent, "%s: cxld '%s' was out of order shut down\n",
+		__func__, dev_name(dev));
+	return -EINVAL;
 }

 static int match_auto_decoder(struct device *dev, void *data)
@@ -839,17 +849,18 @@  cxl_region_find_decoder(struct cxl_port *port,
 			struct cxl_endpoint_decoder *cxled,
 			struct cxl_region *cxlr)
 {
-	struct device *dev;
-	int id = 0;
+	struct device *dev = NULL;

 	if (port == cxled_to_port(cxled))
 		return &cxled->cxld;

-	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags))
+	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
 		dev = device_find_child(&port->dev, &cxlr->params,
 					match_auto_decoder);
-	else
-		dev = device_find_child(&port->dev, &id, match_free_decoder);
+	} else {
+		device_for_each_child(&port->dev, &dev, match_free_decoder);
+		get_device(dev);
+	}
 	if (!dev)
 		return NULL;
 	/*

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

