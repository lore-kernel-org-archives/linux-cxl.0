Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793222157;
	b=lFjm6Bb7LUN/+5L0pITJE0rXIbqwqFA1rFtKM+ktLYWjKG6r6SO65SoptTrq0FM3m6Vv
	 d3wVKV5I0t9YCMWzzpRg2tX4ykn52wyebqPce5OYk7j3QBfDPFLIlyNsTRVSN0DPcPIyn
	 cEUY4o9GP32oh2u/XilX5CVjkHqmniOyeV7GCUH/SgcIiepiohCEP3lLVMLBHQGgI0Hui
	 ArUqfKH1UF5dGbiXtXFxcFXQW58XcdFOiIyqigrV3pZ76LCylEmZB/wdUqEO0zFKKj7pm
	 FkrMkYcB3kYLrtxQVRUr5X0TDrDAlCP+ECxzX/Q71YeFluqMtZsFLjBTSCB9QSproWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793222157;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Gk8pg2wKBMP/5kEMjpmOkNXbA3/EnbPJI6yaBvDpwN8=;
	b=H+W1e1EtJE8UrGVtlh/PVUgNB2MqpLNUGEOk2UOxE7Lv+uIySYqeDtACqz8pnAdnYpcG
	 6p7cZG9u0/LJcQKvQVovaKJm+QOBu1X19E56SzLc56mgtAEr90oXMxN8OPbDCwbaIDH+E
	 La8oJNpHhTKFmmGGy0uUSA4o1AoZgqF/HRyx6opifun/6+StYyDqI0rcIeGa02uUX0w2k
	 4W4Fy7Yn7R3KpNp42D/p6+iKYa2M7kgXxIPW2hntXfPZjz8ITh/EJyX/5ejetLfvzvn+0
	 raEpffAbaeeC7IYHUwQbLzDNrvqkXBH+DcVg+74RAii1uGfvFJnsuMC9PrJ/mE1DrKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Md59gUPu;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E636606A31A
	for <linux-cxl@vger.kernel.org>; Wed, 28 Oct 2026 21:15:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E636606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Md59gUPu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793222156; x=1824758156;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RanB8vTQZwJrry99ZY1rbkYp9XuM5vohc+lSwdQQkbo=;
  b=Md59gUPufGFvJtODVLM4CWOu9dHHlu9/lvlBPWOA0UnPdjw9qmKibXj3
   cp+Sjk6Vvllmo6XaMe80flwbeccL7eSSKZ7dtT639iB5GarjZ+3rxt0FD
   9ac5pHYJxun/nLmMBeRmpn1gTi0SvtwoZvtc0gD9cekipvVoSn900GO+x
   jrvQkjGQC1WrluPkx+HSZDcITtsZooCMSX/PHKdWj3GITRlEvIOm4zpvw
   a7pdKrNg4Pt8q+DzeMa8ZdVxE8K/2ZbjmEgnzpMAuBiQUj3QWE1jrIA+f
   WE0NBsKkCOdF6XNopuT73z9t/NHmALWhngA7P+8ZBAvDT+gVp0RKvddlm
   w==;
X-CSE-ConnectionGUID: KYKOmeB7Sza6chZGHNmCFg==
X-CSE-MsgGUID: ivkOaqBwQRWF4qASurGoKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1840402"
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="1840402"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 14:15:56 -0700
X-CSE-ConnectionGUID: kkfujK/HR8SFILZfP339VQ==
X-CSE-MsgGUID: dTa+SyP+TdyqhiWorFfKSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="5034437"
Received: from iherna2-mobl4.amr.corp.intel.com (HELO [10.125.108.227]) ([10.125.108.227])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 14:15:54 -0700
Message-ID: <e66f1d85-b46a-469a-ac5a-2b480309acc0@intel.com>
Date: Wed, 28 Oct 2026 14:15:53 -0700
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/acpi: Drop the root decoder target_type assignment
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: jic23@kernel.org, alison.schofield@intel.com, ming.li@zohomail.com,
 icheng@nvidia.com, linux-cxl@vger.kernel.org
References: <20261028202757.912948-1-dave@stgolabs.net>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20261028202757.912948-1-dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/28/26 1:27 PM, Davidlohr Bueso wrote:
> A root decoder's target_type is never consumed. The field is
> already initialized to CXL_DECODER_HOSTONLYMEM by cxl_decoder_init().
> Drop the redundant assignment, which only suggests the root decoder's
> type matters.
> 
> Suggested-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/acpi.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index b7ce6b59c680..740e229e1c4c 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -443,8 +443,6 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
>  
>  	cxld = &cxlrd->cxlsd.cxld;
>  	cxld->flags = cfmws_to_decoder_flags(cfmws->restrictions);
> -	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
>  	cxld->hpa_range = (struct range) {
>  		.start = cfmws->base_hpa,
>  		.end = cfmws->base_hpa + cfmws->window_size - 1,
> --
> 2.39.5

