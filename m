Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0471018C2C
	for <linux-cxl@vger.kernel.org>; Tue,  9 Sep 2025 15:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757432649; cv=none; b=O+o5C3cWffjofO0HGgs2hGpvIetR6byUPaIc9B6OM1o75tMJXdoDxSVGxJTCT4WlVJfCsOhvmaGaNartGLnTJs0FGZ0Fa1MWs9QtDkI3kuCfqwHOk/YcSfdV1XJ/Ai/vo65I7JTiLlfN+LSUs1qHeE6eTiPdcRYvWNGvR4qlIEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757432649; c=relaxed/simple;
	bh=CyQAj7uCuTvujWV09wjGFDwd8ztgVSTmjI2+r0VCqUQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tg/EeepU+tTW4OX3HKmiIX3C3q/qaM3xOl/FpRxOh2Xjn5iOrwUiEgcEnPavrjiE2eLWRo4wAozTl6QwKsNohwoZBLrlkMw3rdBW2CwLRtj+JYZja1wLSFLgn8hvQgcY6WxlqucWblX3SMTmx260UMnjKXq6nYCQQH+lAUPawuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cLp4F4p6Cz6K9lD;
	Tue,  9 Sep 2025 23:42:53 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 9D72D1400D9;
	Tue,  9 Sep 2025 23:44:03 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 9 Sep
 2025 17:44:03 +0200
Date: Tue, 9 Sep 2025 16:44:01 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <rrichter@amd.com>
Subject: Re: [PATCH v9 05/10] cxl/test: Refactor decoder setup to reduce
 cxl_test burden
Message-ID: <20250909164401.00002430@huawei.com>
In-Reply-To: <20250829180928.842707-6-dave.jiang@intel.com>
References: <20250829180928.842707-1-dave.jiang@intel.com>
	<20250829180928.842707-6-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 29 Aug 2025 11:09:23 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Group the decoder setup code in switch and endpoint port probe into a
> single function for each to reduce the number of functions to be mocked
> in cxl_test. Introduce devm_cxl_switch_port_decoders_setup() and
> devm_cxl_endpoint_decoders_setup(). These two functions will be mocked
> instead with some functions optimized out since the mock version does
> not do anything. Remove devm_cxl_setup_hdm(),
> devm_cxl_add_passthrough_decoder(), and devm_cxl_enumerate_decoders() in
> cxl_test mock code. In turn, mock_cxl_add_passthrough_decoder() can be
> removed since cxl_test does not setup passthrough decoders.
> __wrap_cxl_hdm_decode_init() and __wrap_cxl_dvsec_rr_decode() can be
> removed as well since they only return 0 when called.
> 
> Suggested-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

There was a bit of code reordering in here that made it a little hard
to check but I can't see an easy way to make that more obvious.
A precursor patch shuffling the code would perhaps allow it to be
discussed in the patch description, but perhaps that's overkill

Anyhow, I'm fairly sure it is fine.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index cf32dc50b7a6..d8cae2b5bac6 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c

>  
>  static int cxl_endpoint_port_probe(struct cxl_port *port)
>  {
> -	struct cxl_endpoint_dvsec_info info = { .port = port };
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
> -	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> -	struct cxl_hdm *cxlhdm;
>  	int rc;
>  
> -	rc = cxl_dvsec_rr_decode(cxlds, &info);
> -	if (rc < 0)
> -		return rc;
> -
> -	cxlhdm = devm_cxl_setup_hdm(port, &info);
> -	if (IS_ERR(cxlhdm)) {
> -		if (PTR_ERR(cxlhdm) == -ENODEV)
> -			dev_err(&port->dev, "HDM decoder registers not found\n");
> -		return PTR_ERR(cxlhdm);
> -	}
> -
>  	/* Cache the data early to ensure is_visible() works */
>  	read_cdat_data(port);
>  	cxl_endpoint_parse_cdat(port);
> @@ -117,11 +87,7 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>  	if (rc)
>  		return rc;

Hmm. The reordering makes me a little nervous but I 'think' it's ok as the
code in between is all related to the cxlmd which none of the
code above is directly related to.
 
>  
> -	rc = cxl_hdm_decode_init(cxlds, cxlhdm, &info);
> -	if (rc)
> -		return rc;
> -
> -	rc = devm_cxl_enumerate_decoders(cxlhdm, &info);
> +	rc = devm_cxl_endpoint_decoders_setup(port);
>  	if (rc)
>  		return rc;

