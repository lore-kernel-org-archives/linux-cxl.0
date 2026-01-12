Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C680A35F8AA;
	Mon, 12 Jan 2026 15:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768232141; cv=none; b=lPH4qg7DHfY2ocFZ8Ftv2V+SzrZCnDhWBvfYOnY4XnQ0Bo4hg5t6duXkDw6qqjv+C28YOCCN0gU+13rHVwdMlPNV6oF0kwxG4wESRQulcdSMamQoYY5Ivet0Q/5GomuR6DL3+OMKL6aYzaW8T6b5+aikNekYOYldJzDGfLyplXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768232141; c=relaxed/simple;
	bh=7tgnJgGGqNFYLXlGRZyuDqLlZ/r18I6jQJsHTfl7VYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pn5kRo6mKP4AJhv4/U7qjUHKYYJIMTA8HGvshvplcuVFcW0STLgSCQrSrfg2Gym1v+8Pey2l03AxwQk4UAPfL4JuUrWAAB2j98JD0hSksSrjedeN4/8AYhJEAg8yndfLiOtjAvxHqwDy+FlVvXzuFBTKayd5JAxwI9fHa8n5I08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A44kdxzI; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A44kdxzI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768232140; x=1799768140;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7tgnJgGGqNFYLXlGRZyuDqLlZ/r18I6jQJsHTfl7VYI=;
  b=A44kdxzIMoQTeQNdu2oMJUfrMMZva5Qf3O7ARyfLET+kYP+F7UDYFAQB
   cS2TBDh+aMeiC9z+N2x/pJ962LwUHLL4KNHzejiwmSJ/cbMO7h7reCjnh
   aDnw4kvUXA4XlvYff/DuocniEVz1mXkNZDXGGIqdeCrXlkdulE2VcY/nZ
   8RxBArpJ9u7mretFVaiamn1TRKRs4bbLOFlmQm6NrANeT2rfOjQ/9Adur
   qLYE/kN7Al5EZhVcCgqKPuZyc14OVu5ITCORLhk9nwVhmAdZ6qAFsQqpx
   oPlKKLe4TTsR4ObxuR5A3fNHZSbdwi3j7HhuDPdI8y2Esu8cl25HE+gEM
   Q==;
X-CSE-ConnectionGUID: hNx1mgSwTV2Rxo3RO23sTw==
X-CSE-MsgGUID: JxTZILJsSZ+8xkMiFKnelQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11669"; a="80229485"
X-IronPort-AV: E=Sophos;i="6.21,221,1763452800"; 
   d="scan'208";a="80229485"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 07:35:39 -0800
X-CSE-ConnectionGUID: HigHMzcdSRez0a65SJGJ0A==
X-CSE-MsgGUID: k48WJRymT7eikWw6w7NpgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,221,1763452800"; 
   d="scan'208";a="204026912"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.110.139]) ([10.125.110.139])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 07:35:38 -0800
Message-ID: <2c0f5018-ec9b-4a69-8d11-6d1a4925c18f@intel.com>
Date: Mon, 12 Jan 2026 08:35:37 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] cxl/hdm: Fix potential infinite loop in
 __cxl_dpa_reserve()
To: Li Ming <ming.li@zohomail.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260112120526.530232-1-ming.li@zohomail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260112120526.530232-1-ming.li@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/12/26 5:05 AM, Li Ming wrote:
> In __cxl_dpa_reserve(), it will check if the new resource range is
> included in one of paritions of the cxl memory device.
> cxlds->nr_paritions is used to represent how many partitions information
> the cxl memory device has. In the loop, if driver cannot find a
> partition including the new resource range, it will be an infinite loop.
> 
> Fixes: be5cbd084027 ("cxl: Kill enum cxl_decoder_mode")
> Signed-off-by: Li Ming <ming.li@zohomail.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/hdm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 1c5d2022c87a..a470099a69f1 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -403,7 +403,7 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>  	 * is not set.
>  	 */
>  	if (cxled->part < 0)
> -		for (int i = 0; cxlds->nr_partitions; i++)
> +		for (int i = 0; i < cxlds->nr_partitions; i++)
>  			if (resource_contains(&cxlds->part[i].res, res)) {
>  				cxled->part = i;
>  				break;

