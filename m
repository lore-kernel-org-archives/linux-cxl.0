Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F0E1DA27
	for <linux-cxl@vger.kernel.org>; Mon,  5 Feb 2024 22:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707172300; cv=none; b=TiJKd72hTd/icvxOwFb37iEfYNwg7c8E829QetfJYm8ZKQCN6NgA1VzAnkoFJjSz44QMSwkIaXKDATad1U4BM52NcrNpcAkGwwHbe2STfWp/l9RGIsjRHbo9CENoeNlwhcR/Q5slB1PkXPC+P+tDfUbb2gSPnwh335j3kgXh/+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707172300; c=relaxed/simple;
	bh=JlLiix+uOGwR1J/vVrf8lIz7OUgCCIjmGZOf+kA21hM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oVq1vg1af2kNFhNfxLmoPv6moSGxIHpuzMVYzERY9DAmhAijkPTaxmEzXtepsKWh/APhK3v84twRSHKTY668ds4NoTkNsBXVxODukOfg8thYY13KOjpWgPTTi2VlveyZeIYQjM8dPfLwsrEchZn9b4XUbNngUYych4ybtdmPR1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PzwdC57i; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PzwdC57i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707172299; x=1738708299;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JlLiix+uOGwR1J/vVrf8lIz7OUgCCIjmGZOf+kA21hM=;
  b=PzwdC57ikj8CtDyXu5mnKaLa+i2gyY7MvyJ4fYxcbN+TEtfoQ9TyYhEm
   unpd0xCZo84wl9sAFZfUShySRIMhown23OhOr0i668jDQJfhHOQB3ws97
   1IGOijCcBGzYEtaJv9zwenZi9Lpi2re2mAAwyL/uJe5EbKiCD2+zr/xko
   0Ivr9TyTR6N0rLhRsJYYiWmFhTj4dSM+VO93zZcq+SWiPCN8NemCSRfz0
   KegvH0LqIA+hTs+bH+RRUmMjQ4qagau0jsmqDyEdRCGUclLNGljOB6CUc
   XJaPqnXiPnLoRFg1odx7J3ufY9+OLMzxOLHzQf6RSQ7JLY7hHI3y7G1Ng
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="768741"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="768741"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 14:31:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="933275368"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="933275368"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.246.112.181]) ([10.246.112.181])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 14:31:37 -0800
Message-ID: <ebc9c00d-06f1-4d7f-b551-267301758e16@intel.com>
Date: Mon, 5 Feb 2024 15:31:35 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: cxl: question about cxl qos_class verification
Content-Language: en-US
To: wj28.lee@samsung.com,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Cc: "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
 KyungSan Kim <ks0204.kim@samsung.com>, Hojin Nam <hj96.nam@samsung.com>
References: <CGME20240205103602epcms2p8543d4f3a4bfb684c81f07a94627c7aef@epcms2p8>
 <20240205103602epcms2p8543d4f3a4bfb684c81f07a94627c7aef@epcms2p8>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240205103602epcms2p8543d4f3a4bfb684c81f07a94627c7aef@epcms2p8>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/5/24 3:36 AM, Wonjae Lee wrote:
> Hello,
> 
> To test the CXL driver with respect to QTG IDs on a real CXL device, I
> connected one CXL device to a CXL 2.0 Compliant System (v6.8-rc3).
> 
> However, during cxl endpoint probing, CDAT extraction and parsing works
> fine, but cxl_qos_class_verify() for cxlmd does not run properly.
> 
> To be precise, when cxl_qos_class_verify() is executed, the below error
> handling code is executed since cxlmd->endpoint is NULL:
> 
>     if (!cxl_root)
>         return -ENODEV;
> 
> 
> I'm not sure if I analyzed it correctly due to the complexity of the CXL
> driver, but I think it's because the cxl_port driver execute
> cxl_qos_class_verify() before cxlmd->endpoint = endpoint was executed in
> the cxl_mem driver. See the dmesg log below, where I've added debugging
> code.
> 
> # cxl_mem driver is adding the endpoint
> [] cxl_mem mem0: call devm_cxl_add_enpoint
> ...
> # endpoint port is probed, and cxl_qos_class_verify() runs
> [] cxl_port endpoint5: call cxl_qos_class_verify
> [] cxl_mem mem0: cxl_qos_class_verify: cxlmd->endpoint is NULL
> [] cxl_mem mem0: cxl_qos_class_verify: cxl_root is NULL
> ...
> # cxl_mem driver sets cxlmd->endpoint
> [] cxl_mem mem0: cxl_endpoint_autoremove: cxlmd->endpoint = endpoint
> ...
> 
> 
> I did an experiment to validate the hypothesis. If I call
> cxl_endpoint_parse_cdat() after cxlmd->endpoint is set,
> cxl_qos_class_verify() runs well without problems.
> 
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index c5c9d8e0d88d..33b39c6c46fd 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -74,6 +74,8 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
>         if (rc)
>                 return rc;
> 
> +       cxl_endpoint_parse_cdat(endpoint);
> +
>         if (!endpoint->dev.driver) {
>                 dev_err(&cxlmd->dev, "%s failed probe\n",
>                         dev_name(&endpoint->dev));
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index 97c21566677a..ee77aba62780 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -111,7 +111,6 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
> 
>         /* Cache the data early to ensure is_visible() works */
>         read_cdat_data(port);
> -       cxl_endpoint_parse_cdat(port);
> 
>         get_device(&cxlmd->dev);
>         rc = devm_add_action_or_reset(&port->dev, schedule_detach, cxlmd);
> 
> 
> Maybe there's something I'm missing. It would be very helpful if anyone
> could comment on the above analysis.

I think this should fix the issue you are seeing?

https://lore.kernel.org/linux-cxl/b243e80f-1b24-4756-8bb3-8389d66ea13a@intel.com/T/#mcbce77b6584bd1031d6c1928fcb36fe67be66039


> 
> Thanks,
> Wonjae
