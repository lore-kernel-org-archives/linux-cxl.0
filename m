Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820C43E7177;
	Tue, 17 Mar 2026 15:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773759658; cv=none; b=V98jvpmkH0pAJAf8lzPJQkzq3A3WpVoyJUPnH+BbY7GPxfGEtLnbkW6pSnKVlG85v7Q6C8yp+OmCmuFYwuMmhNTi1d6eDgcdLVE9uHBaFPZR6exmn+1ipeufYSWxitsMbXTPe8M7W6D59xUI4kSKs7LahivzNfxV+k+hSUzFPxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773759658; c=relaxed/simple;
	bh=Ryq1Wth0uh3/qAeKhxHQfVqDR0h6U7f/aEurZbpQm0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HZV8deMwv9kvoxjlDEyAGXFfzJNmtOXGQo8T+6Jpih7Wbi36axdYe1L5QE+LkoADPOmmgyGkQBTzfRqxtiDxenX6aefHMod0p87eJcJ1MpR6WWMmpdaNN4HmREa6JT02p1DIKF5YLGqx+4mcpXbPKXzp59x0HTpsbbbkBjPN0ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HVUpY+B0; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HVUpY+B0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773759656; x=1805295656;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ryq1Wth0uh3/qAeKhxHQfVqDR0h6U7f/aEurZbpQm0c=;
  b=HVUpY+B0AZltGOUEBqoJFq3WKn7vMx5bLuBoJYKPpz58pQFr7+nhPjPO
   rX2rJUakSC3lJPNQDQWuCS+KvburdalHm9bJQHtRwyfdDhIr3+XlYqK6W
   JeyiocYI+7FVkIFBibURAZXVdWc8VKGXJh53pmH28R0Qu9UyaE5TmwAkJ
   x3vCQOPL9mP10Jru7knE8TUDzQFiLxw/DxjfETudPTZv24LbFcAqqsXia
   jeEzbbCal3qVNwlh2NmmmQjssZKL8fGmgFBl59/WzIySCVaDM+1t7mLQM
   5DvS4xccmyqHEZ1MZbug6+Z1ShPAQnyTv4RSPbbq4ACYRnjjC7o0lLwa8
   Q==;
X-CSE-ConnectionGUID: QpgRkXL9TWqEVC0QotFimg==
X-CSE-MsgGUID: PExX226OSFK0qBinmOdMTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="74912604"
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="74912604"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 08:00:55 -0700
X-CSE-ConnectionGUID: 5201O5lERBKtSn8wG8wDDg==
X-CSE-MsgGUID: UzNGCFAiRyyXsfijJ/Rc3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="226429848"
Received: from schen9-mobl4.amr.corp.intel.com (HELO [10.125.108.169]) ([10.125.108.169])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 08:00:53 -0700
Message-ID: <c784d84c-e8ac-4c87-abec-3d4e64f074a2@intel.com>
Date: Tue, 17 Mar 2026 08:00:52 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] cxl/memdev: Hold memdev lock during memdev poison
 injection/clear
To: Li Ming <ming.li@zohomail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Ben Cheatham <benjamin.cheatham@amd.com>
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org
References: <20260314-fix_access_endpoint_without_drv_check-v2-0-4c09edf2e1db@zohomail.com>
 <20260314-fix_access_endpoint_without_drv_check-v2-2-4c09edf2e1db@zohomail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260314-fix_access_endpoint_without_drv_check-v2-2-4c09edf2e1db@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/14/26 12:06 AM, Li Ming wrote:
> CXL memdev poison injection/clearing debugfs interfaces are visible
> before the CXL memdev endpoint initialization, If user accesses the
> interfaces before cxlmd->endpoint updated, it is possible to access an
> invalid endpoint in cxl_dpa_to_region().
> 
> Hold CXL memdev lock at the beginning of the interfaces, this blocks the
> interfaces until CXL memdev probing completed.
> 
> The following patch will check the given endpoint validity in
> cxl_dpa_to_region().
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Li Ming <ming.li@zohomail.com>

Hi Ming, I dropped this patch with Dan's comments [1] and updated cxl/next. Please check and make sure everything looks ok to you. Thanks!

[1]: https://lore.kernel.org/linux-cxl/69b8b81621e16_452b100e@dwillia2-mobl4.notmuch/

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
> 

