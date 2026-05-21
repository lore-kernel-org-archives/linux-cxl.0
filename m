Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4448837C0E6;
	Thu, 21 May 2026 16:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779382529; cv=none; b=ScKNs0HFrjONt67nDLYX01hp8B39ZwbIYeIDnNGxBagGRiX7W33zyFUuiT4IDWmkOsWS+vB0Si9cj+Pt6GQgcvfy6l5ewCP+sNVah5QvLfZO9SJIISetLhebc6uXpEWKxio2fPLSs2K39UIV1VyKyC2pJdcjf5Ja/UV2F2x5QzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779382529; c=relaxed/simple;
	bh=7EkOrrww0qSH4FUK/mvTgs56s7LoS81IkHqkiJI6rkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n8Be7tw2HtNQuLd2VWRXdFlx0IbojHII176e/USkow6SNGNxfcXv65NxNmDDp84/nCjCDCtN++w56A+q7GeUo4ari0ZkVki/nC2SsqXBvJd7aLbk4jqZMzElF1mUTb+5kNTk2/5rU2YwHHUdAwBSxS7dAJym4sNbUhe52Ik6H64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YXFcrBb1; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YXFcrBb1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779382529; x=1810918529;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7EkOrrww0qSH4FUK/mvTgs56s7LoS81IkHqkiJI6rkc=;
  b=YXFcrBb1q8cKdZRrB7RPTWcSZ4bjgkgC4Kfdeq+W7+5KzLO1uUvby/h8
   kMiel4NrBhK+cEZ4NJuS4xjvvtIwg9NwDwCnO+pcZiuKHPr9uAh58Hpgo
   wN3lqzfF5awVzqzKpDpy5D6rqtQ/WImulSv6kRsLvHzFtjXhq8reL/xZ5
   nfR63zeeQW0cPnnCrtcfTIWhQJESjHhCE7f5tgD74OYBFZAAfiizgCtpT
   5Ex1al1+X6gUsues16yN4TJtggfw7fKRC4yMwOH2xmcTsoFQTVPxYaFVL
   QL4X0aVbVBGZshK4q8+gxdBY58qydmAe/0ECXdl36KZgI/hRzyB+GVuzD
   g==;
X-CSE-ConnectionGUID: 61YGQovHQe+k2Nwl//tS0w==
X-CSE-MsgGUID: QMNWc37oT4O40MS+bLJgZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="91777409"
X-IronPort-AV: E=Sophos;i="6.24,160,1774335600"; 
   d="scan'208";a="91777409"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 09:55:28 -0700
X-CSE-ConnectionGUID: fKZI9DxORYOCNtYPc3jhCA==
X-CSE-MsgGUID: OSZ9auPYTfCwcv86qrswaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,160,1774335600"; 
   d="scan'208";a="240811808"
Received: from cjhill-mobl.amr.corp.intel.com (HELO [10.125.110.16]) ([10.125.110.16])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 09:55:27 -0700
Message-ID: <390888ab-e490-4ea5-a6bb-adcbdc426a5e@intel.com>
Date: Thu, 21 May 2026 09:55:26 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] cxl/memdev: Hold memdev lock during memdev poison
 injection/clear
To: Li Ming <ming.li@zohomail.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, djbw@kernel.org
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260423111949.177399-1-ming.li@zohomail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260423111949.177399-1-ming.li@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/23/26 4:19 AM, Li Ming wrote:
> cxl_dpa_to_region() assumes that it is running a context where it is not
> racing changes to "cxlmd->dev.driver". Acquire the memdev device lock in
> the debugfs entry points to preclude debugfs usage racing cxl_mem driver
> detach.
> 
> Suggested-by: Dan Williams <djbw@kernel.org>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Dan Williams <djbw@kernel.org>
> Signed-off-by: Li Ming <ming.li@zohomail.com>

Applied to cxl/next
c13052967873

> ---
> This patch originally belonged to the patchset[1], but was not merged
> into mainline together with the rest of the patchset. Resend this patch
> individually.
> 
> [1]: https://lore.kernel.org/linux-cxl/20260314-fix_access_endpoint_without_drv_check-v2-0-4c09edf2e1db@zohomail.com/T/#m9c302a841a3d26aa2eb7217ccdcdc4ae2607740a
> 
> Changes in v3:
> - Update changelog. (Dan)
> - Add review tag from Dan.
> Changes in v2:
> - Move hoding CXL memdev lock to cxl_debugfs_poison_inject/clear(). (Alison)
> ---
>  drivers/cxl/mem.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index fcffe24dcb42..ab88eaa31d1d 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -48,6 +48,11 @@ static int cxl_mem_dpa_show(struct seq_file *file, void *data)
>  static int cxl_debugfs_poison_inject(void *data, u64 dpa)
>  {
>  	struct cxl_memdev *cxlmd = data;
> +	int rc;
> +
> +	ACQUIRE(device_intr, devlock)(&cxlmd->dev);
> +	if ((rc = ACQUIRE_ERR(device_intr, &devlock)))
> +		return rc;
>  
>  	return cxl_inject_poison(cxlmd, dpa);
>  }
> @@ -58,6 +63,11 @@ DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_inject_fops, NULL,
>  static int cxl_debugfs_poison_clear(void *data, u64 dpa)
>  {
>  	struct cxl_memdev *cxlmd = data;
> +	int rc;
> +
> +	ACQUIRE(device_intr, devlock)(&cxlmd->dev);
> +	if ((rc = ACQUIRE_ERR(device_intr, &devlock)))
> +		return rc;
>  
>  	return cxl_clear_poison(cxlmd, dpa);
>  }

