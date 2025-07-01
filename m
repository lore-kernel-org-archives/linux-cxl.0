Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A7627C154;
	Tue,  1 Jul 2025 15:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751383035; cv=none; b=OsgBk8ZGZ2BH+Br531V/TF8L8RsCECHlCcealv2qHOb7X6ZWqtyquyssQYtBSdRiOFdL0TPGDM3jyFwLoQr9HrE4XzW4/kElw2CBsm3bAh+tjFRtPovfPwbbdLhkw+g5KBam9qyem/b+OjQ5lBrsRSdlYPwJqZfUNxLoNHvtubw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751383035; c=relaxed/simple;
	bh=xF46JrP8aTdg2PgCUCAiAmpKdKQ9KAMX0vbS7CRfomU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uJGz9kSHkTKsCmzqZhHBit//Pv31+RnSHwbMqGcL/fk/LGKuObiuKtkPOFRoEWXSSgdutDjRVAP7ZmKn9giTNmcAu0iLfphxGR1gecVgzCKOqLnVfs+8NnUuYTWV8JIXJFkJr5PBrR7y+nMyUtfg1XbzqBHZKdyXxD1KVXYh8mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=byDTN9CB; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="byDTN9CB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751383034; x=1782919034;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xF46JrP8aTdg2PgCUCAiAmpKdKQ9KAMX0vbS7CRfomU=;
  b=byDTN9CBp0ldQsV3oOQ3HsDyWXPRAzKXqsTbQboWvITUfdZqFyoNJxbY
   DPxTyFB9Ipbk8tdhOH3D7ME64GBRZb9K8ff6lVF35SDOAFkVUk4MnjIYG
   f386ykKfItzIm2UVQTPH17wZq9cXqUgSwldnAnGpaOOgOxG2Ddezl+OCN
   OLb4hxBMxJ5jt4vE8VJIR7RI5klaVtTZefE40PMWvtYde7Asc05KeXFzn
   AZv4D/5/fR5MdLReoA9oYnTq27Nt5/U7g/N9mL/dXIh4AcOvXKg35gkv6
   V1V2TGMAVwufMoos1/mlX5Ikh8CIrihaJMMVnwD283iY+8m72lMPli0eO
   A==;
X-CSE-ConnectionGUID: d3V95BTVQm2A9dhEsSOp7w==
X-CSE-MsgGUID: y51vruxpQdWknQn8uzWj5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="56280821"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="56280821"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 08:17:01 -0700
X-CSE-ConnectionGUID: DFBSNyyLRgqMa0JsQlI12w==
X-CSE-MsgGUID: WZqqy4hiQMuisizYBYIJ9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="158072587"
Received: from puneetse-mobl.amr.corp.intel.com (HELO [10.125.109.179]) ([10.125.109.179])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 08:17:00 -0700
Message-ID: <60f4f153-9947-4730-a72b-2fe3df8d18e9@intel.com>
Date: Tue, 1 Jul 2025 08:16:59 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl: make cxl_bus_type constant
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
References: <2025070138-vigorous-negative-eae7@gregkh>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <2025070138-vigorous-negative-eae7@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/1/25 5:07 AM, Greg Kroah-Hartman wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the cxl_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: linux-cxl@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Applied to cxl/next
ac0fe6a5731700bcea6fecfd5d0b76c0454b3a20

> ---
> v2: fix up the subject line to be correct
> 
>  drivers/cxl/core/port.c | 2 +-
>  drivers/cxl/cxl.h       | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index eb46c6764d20..0696f7fcef56 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -2293,7 +2293,7 @@ static const struct attribute_group *cxl_bus_attribute_groups[] = {
>  	NULL,
>  };
>  
> -struct bus_type cxl_bus_type = {
> +const struct bus_type cxl_bus_type = {
>  	.name = "cxl",
>  	.uevent = cxl_bus_uevent,
>  	.match = cxl_bus_match,
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 3f1695c96abc..e7b66ca1d423 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -815,7 +815,7 @@ int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
>  
>  bool is_cxl_region(struct device *dev);
>  
> -extern struct bus_type cxl_bus_type;
> +extern const struct bus_type cxl_bus_type;
>  
>  struct cxl_driver {
>  	const char *name;

