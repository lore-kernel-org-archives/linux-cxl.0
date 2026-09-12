Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013FF2F2619;
	Sat, 12 Sep 2026 00:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789171232; cv=none; b=asREvw4oGhv96gWgJ4X7+jA6IMNejIkMgbQhBQ7Q022wI4YN4OmtC3uatR5ro4e5W/rdRf5K5+/uPxeMw3VRwmBlOAfCycK1BZejZFR63iYvcx9ilFq7Jjxc2VNlfu6rZR8rrXN5FRoWUjgb+GIcyvKrOY4WGr1SGNx08RYXbnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789171232; c=relaxed/simple;
	bh=dEMrIegqMAKxT2HNIahVYJnAeozBlb2dZyX8KRsgin0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BlcJAJeWfxA14r5E/ZBb0PeThs6ttmJyhogAR9el+ezJ2hxnePaXPqvf2glkS3yyrCFDNAWD4YlFr0SlA9l39H4j7w4PQxzgT2PH3C3I009ruzTWJe41Vz2YLjcBrK1qFY+mC7GsRPNTxiX//KZ7XyTsnOJmS0fKHXN9S9BB+M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jx51cAIt; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jx51cAIt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789171231; x=1820707231;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dEMrIegqMAKxT2HNIahVYJnAeozBlb2dZyX8KRsgin0=;
  b=Jx51cAIt5y8ypVgGc6NsO9MhR8/6cZRLHQPZfhRmqgAfpP9WUxwxkHbd
   bMlqWLfPhEUNWtYuWsTRTSpI5dkXcM9973zuaNkt1mPtyyr1OL3/+TQpQ
   g3QAZIwkSk1JQpnySttxmqsJR2/b3KJB490MTPs5xeZM7B9yZdllMpi1u
   DYYgpiIlZTw/+tHHBgEfSjaEeX82WZAsKLwqZCX/XMncv+zmeYduSj7YC
   L5FHcSx6id66pT6Y0vBJrSp3P/fT79mcFUkEuMBbh0vz8gPyzq76rDJqK
   qwFtiiep6oMgOov4YXCH2D4+TdI/J+QjOeM9THimz2B3l7T7pL9yoYq/9
   g==;
X-CSE-ConnectionGUID: 3dMy2D+nSaquHPjvkrILhw==
X-CSE-MsgGUID: paLdMT1HRdST5yk4RDDRkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="89678614"
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="89678614"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 17:00:31 -0700
X-CSE-ConnectionGUID: W0jYb3hZRYaax+3CtHsJ+g==
X-CSE-MsgGUID: YWDCEjRJQCmc+7UPOJx/UA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="310327739"
Received: from schen9-mobl4.amr.corp.intel.com (HELO [10.125.108.42]) ([10.125.108.42])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 17:00:30 -0700
Message-ID: <2a3e8c7c-4430-42fa-9489-1ced969324e6@intel.com>
Date: Fri, 11 Sep 2026 17:00:29 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/region: Fix the return value in devm_cxl_add_region()
 kernel-doc
To: Karl Mehltretter <kmehltretter@gmail.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>
Cc: Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
 Ben Widawsky <bwidawsk@kernel.org>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260911221748.7212-1-kmehltretter@gmail.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260911221748.7212-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/11/26 3:17 PM, Karl Mehltretter wrote:
> devm_cxl_add_region() returns the new struct cxl_region, or an ERR_PTR()
> on failure, but its kernel-doc says "0 if the region was added to the
> @cxlrd, else returns negative error code", which was never true.
> Describe the pointer.
> 
> Fixes: 779dd20cfb56 ("cxl/region: Add region creation support")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Dropped fixes tag since it's just a comment fix and not code bug.

Applied to cxl/next
2dfb4796d19b


> ---
>  drivers/cxl/core/region.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 27e63e6dab7c82ccd6c34b7955f52789a32ce478..28a8e3d1e1231eef40bc30cdd937af980952232c 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2727,7 +2727,7 @@ void kill_regions(struct cxl_root_decoder *cxlrd)
>   * This is the second step of region initialization. Regions exist within an
>   * address space which is mapped by a @cxlrd.
>   *
> - * Return: 0 if the region was added to the @cxlrd, else returns negative error
> + * Return: the new region if it was added to the @cxlrd, else an ERR_PTR() with the error
>   * code. The region will be named "regionZ" where Z is the unique region number.
>   */
>  static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,

