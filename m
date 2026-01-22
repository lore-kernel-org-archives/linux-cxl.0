Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1BE35DCE0
	for <linux-cxl@vger.kernel.org>; Thu, 22 Jan 2026 21:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769117093; cv=none; b=Mkj0/adqMC5PkbcGKSUgvbugfS6JqqpTedNDGjRZL+kdfsnJvhanCncaAs8qxHaHOEeOtQxCdNdiJeP4J7I5QtWnodXUuaAYwTFxiC1lpX/6yhY1Qab3oB1WAHOa9agzHxiyHC9Zxvxd74ygkapYjHRw8tdTMB1VlTfNnSYlncQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769117093; c=relaxed/simple;
	bh=349GCh+xrQ8yYCLiVE/uJbxSEtU21JZt37TOkvDRBFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kA14fe6vr08CcEKLJT5bSR5ajOLA5GwnWyaDmAfE2ag3tL8hPhsnoR/3y8mUt+50ZEBRGc9Om9YS02+foByLeyYRm5qjbEmg/pbSx8qoOjwx0HRx7t6t4mqHAkZAYevF96UhHsmDGuHRAalp8kYEnvnYTpphAN9/vGhLpYyBsKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PaX0qoXo; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PaX0qoXo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769117089; x=1800653089;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=349GCh+xrQ8yYCLiVE/uJbxSEtU21JZt37TOkvDRBFU=;
  b=PaX0qoXoGRkRtGCbo9nRmR4HJbZcXWAq4z9AnbdoP/99r9Rr05Yf5f1h
   H66zhK/8QWWwWEoVhTMH/FJXUSuJ8cDzNgCNzwDXkPu14BMsXNlrhpRLX
   2XcpCJvjeg+FZQhxTLmyG6yWZBbR4XWDe7/91f3tfBN/JexM8/B7dhD9h
   t+F+PpCMQGDpRkpSNc6fmBwwodfNNGAXxvtl+3z9Ed5MqEq4QmuRaeehK
   AnpKFMwkgDqTVCSZqtIEEXoht8Y4krPNz50KI4cRvJwboklBnys0ElBvt
   27gcXM7ObvHEH0iUuOfT9+bCbcWoDp5oghvU8dx88f97HGE3n4gGGZOwB
   w==;
X-CSE-ConnectionGUID: Y4mTfW2ET/SxmgMHd3FOdg==
X-CSE-MsgGUID: YKyDy1kvQiy0AyLIv9c9Cw==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="87947830"
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="87947830"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 13:24:44 -0800
X-CSE-ConnectionGUID: 4k+LtMuqSE+KHbYreHKmhw==
X-CSE-MsgGUID: noE+y2k2TQOqneYEO6qyEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="211346250"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.108.186]) ([10.125.108.186])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 13:24:43 -0800
Message-ID: <d52bfcaa-3b6c-47ff-8277-94324d4f8a78@intel.com>
Date: Thu, 22 Jan 2026 14:24:42 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] cxl/port: Unify endpoint and switch port lookup
To: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc: jonathan.cameron@huawei.com, dave@stgolabs.net,
 alison.schofield@intel.com, ira.weiny@intel.com, terry.bowman@amd.com
References: <20260122033330.1622168-1-dan.j.williams@intel.com>
 <20260122033330.1622168-10-dan.j.williams@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260122033330.1622168-10-dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/21/26 8:33 PM, Dan Williams wrote:
> In support of generic CXL protocol error handling across various 'struct
> cxl_port' types, update find_cxl_port_by_uport() to retrieve endpoint CXL
> port companions from endpoint PCIe device instances.
> 
> The end result is that upstream switch ports and endpoint ports can share
> error handling and eventually delete the misplaced cxl_error_handlers from
> the cxl_pci class driver.
> 
> Reviewed-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> ---
>  drivers/cxl/core/port.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 436d9f8f65cb..446a97d48423 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1591,10 +1591,20 @@ static int match_port_by_uport(struct device *dev, const void *data)
>  		return 0;
>  
>  	port = to_cxl_port(dev);
> +	/* Endpoint ports are hosted by memdevs */
> +	if (is_cxl_memdev(port->uport_dev))
> +		return uport_dev == port->uport_dev->parent;
>  	return uport_dev == port->uport_dev;
>  }
>  
> -/*
> +/**
> + * find_cxl_port_by_uport - Find a CXL port device companion
> + * @uport_dev: Device that acts as a switch or endpoint in the CXL hierarchy
> + *
> + * In the case of endpoint ports recall that port->uport_dev points to a 'struct
> + * cxl_memdev' device. So, the @uport_dev argument is the parent device of the
> + * 'struct cxl_memdev' in that case.
> + *
>   * Function takes a device reference on the port device. Caller should do a
>   * put_device() when done.
>   */

