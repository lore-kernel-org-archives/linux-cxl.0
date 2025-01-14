Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7132B1DFED;
	Tue, 14 Jan 2025 23:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736895687; cv=none; b=GUajfqjdfQKUD4sUhncBzkWL4HotCLcOIJ+IFZojMeWku6ioV+9vnUiCd+jhXwtwTfw4lAOCPk4Nlv1tHQm60YAAQKfI4GWPuNPFOI2xO6TJIWYnExN52+NG5atEwLaTPtV1tFC1fPzs1FW8eo20BIyP6pVhgpWtUDuxy3ThK/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736895687; c=relaxed/simple;
	bh=QyjendMUVBb89w6hK/4EBL1ORTHQRMWSIMkPimsxqTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d874wzBRe+akbrerRFzI6GfLuz/MePq7lxbMxAhZ1GmSvXXbkSTm7ccnHp6ZvenD+HFjka+H5DK7RpX176N2jASi3q0eZ1CIQWWkC6mFCZGK+I9wCnQdJbzQ2j+Si3r/cRETn/YxdrxeBWK82c5LLPkYDsMn8N1Ct7dIv24oQWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XOSV1CWf; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XOSV1CWf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736895685; x=1768431685;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=QyjendMUVBb89w6hK/4EBL1ORTHQRMWSIMkPimsxqTA=;
  b=XOSV1CWfxRZnDFALWP1OP9ZjkuCYf6pPWMOmc+c5a+v3eOLNPwxz5clY
   G1PkRn3uK6YxwQ1ik+0urVf6PkWdBfIbFsirVutcasNuJxGKuWkmQSS3v
   9OleDnDZv1nTqH8Qbm+olrjfMG899qXLGp9ueeEdEWao9eW2PECZA57u/
   I3rCGNhU/ECwuQv6meUOAuuNZepHJaEy0mxRuvH9dtD03qy5Mqnon/mY3
   e2vIGnwlbqXzKDWE227Y0X7rccsppMUapAAYdzSSHywXr+JeF7HkEa56F
   7hTm3gYJ8qoI7LGxrwMooGRufQcOZglnGLU8bhILt5H35S+cJJ9p26HoQ
   Q==;
X-CSE-ConnectionGUID: oRrIeA8UR3ag2lNc/vSwWw==
X-CSE-MsgGUID: Ni3kdvVZTnC9RJOlDwD1qg==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="54754204"
X-IronPort-AV: E=Sophos;i="6.12,315,1728975600"; 
   d="scan'208";a="54754204"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 15:01:25 -0800
X-CSE-ConnectionGUID: 40vkMDhOR4esu64JsLJLvw==
X-CSE-MsgGUID: Q2toCpa7QQqxZ0TfH+Qo3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,315,1728975600"; 
   d="scan'208";a="109902714"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.108.158])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 15:01:24 -0800
Date: Tue, 14 Jan 2025 15:01:22 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cxl/port: Constify 'struct bin_attribute'
Message-ID: <Z4bsws_eoYz4fMnp@aschofie-mobl2.lan>
References: <20250114-sysfs-const-bin_attr-cxl-v1-1-5afa23fe2a52@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250114-sysfs-const-bin_attr-cxl-v1-1-5afa23fe2a52@weissschuh.net>

On Tue, Jan 14, 2025 at 10:25:14PM +0100, Thomas Weiﬂschuh wrote:
> The sysfs core now allows instances of 'struct bin_attribute' to be
> moved into read-only memory. Make use of that to protect them against
> accidental or malicious modifications.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
>  drivers/cxl/port.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index 4c83f6a22e584f1f248807c7fa4fe932d6f11d67..664fde6ff53862c6aef2a83be56c1518b6bfbadd 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -153,7 +153,7 @@ static int cxl_port_probe(struct device *dev)
>  }
>  
>  static ssize_t CDAT_read(struct file *filp, struct kobject *kobj,
> -			 struct bin_attribute *bin_attr, char *buf,
> +			 const struct bin_attribute *bin_attr, char *buf,
>  			 loff_t offset, size_t count)
>  {
>  	struct device *dev = kobj_to_dev(kobj);
> @@ -170,7 +170,7 @@ static ssize_t CDAT_read(struct file *filp, struct kobject *kobj,
>  				       port->cdat.length);
>  }
>  
> -static BIN_ATTR_ADMIN_RO(CDAT, 0);
> +static const BIN_ATTR_ADMIN_RO(CDAT, 0);
>  
>  static umode_t cxl_port_bin_attr_is_visible(struct kobject *kobj,
>  					    const struct bin_attribute *attr, int i)
> @@ -184,13 +184,13 @@ static umode_t cxl_port_bin_attr_is_visible(struct kobject *kobj,
>  	return 0;
>  }
>  
> -static struct bin_attribute *cxl_cdat_bin_attributes[] = {
> +static const struct bin_attribute *const cxl_cdat_bin_attributes[] = {
>  	&bin_attr_CDAT,
>  	NULL,
>  };
>  
> -static struct attribute_group cxl_cdat_attribute_group = {
> -	.bin_attrs = cxl_cdat_bin_attributes,
> +static const struct attribute_group cxl_cdat_attribute_group = {
> +	.bin_attrs_new = cxl_cdat_bin_attributes,
>  	.is_bin_visible = cxl_port_bin_attr_is_visible,
>  };

What's the point of s/bin_attrs/bin_attrs_new above?

--Alison

>  
> 
> ---
> base-commit: 7f5b6a8ec18e3add4c74682f60b90c31bdf849f2
> change-id: 20250114-sysfs-const-bin_attr-cxl-d102eab47586
> 
> Best regards,
> -- 
> Thomas Weiﬂschuh <linux@weissschuh.net>
> 
