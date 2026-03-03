Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199333988EF;
	Tue,  3 Mar 2026 10:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772532817; cv=none; b=Y5c3eoxy557YQFLws+kkMTFxWZrVluZEWBLS7mHL8o3IKmtzcxtOKmKvEGdsiF47+ANK8C7i8zErEhWaqzhJJirtKcAioji7OUGuhALfYGkY2fgSlijZR6GkEcvDHCFKIO6ZRI2Vhae7spankH4TNdgGS8dQdJZApx61XF5Sj8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772532817; c=relaxed/simple;
	bh=2YmnF2ZTwlH9xYopSUxJwbTnqOrQNmpPDLhCYY7VXbc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tCAvd/x/uPPCmcTUYKtfu5Q5efF64ILC/cP8Gwf8ydlqoEF8t+wxyseP4TQG66Gvzl5FzPplNBDRU9kAit1xcHi5XLg/7tHTEZqvMYjLCsvmJf9wgUsydcRnCyfx/F3sBTVw1ri/GJqjTrEYlwqrJ6be61RpUk5/3emIxfzG5ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fQBSq39qPzJ46ht;
	Tue,  3 Mar 2026 18:12:59 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 556BB40569;
	Tue,  3 Mar 2026 18:13:32 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 3 Mar
 2026 10:13:31 +0000
Date: Tue, 3 Mar 2026 10:13:30 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Gregory Price <gourry@gourry.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kernel-team@meta.com>, <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
Subject: Re: [PATCH] cxl/acpi: fix CXL_ACPI=y + CXL_PMEM=m link failure
Message-ID: <20260303101330.000039a6@huawei.com>
In-Reply-To: <20260302200429.803417-1-gourry@gourry.net>
References: <20260302200429.803417-1-gourry@gourry.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Mon,  2 Mar 2026 15:04:29 -0500
Gregory Price <gourry@gourry.net> wrote:

> Commit e7e222ad73d9 ("cxl: Move devm_cxl_add_nvdimm_bridge() to
> cxl_pmem.ko") moved devm_cxl_add_nvdimm_bridge() from cxl_core into
> cxl_pmem, creating a symbol dependency from cxl_acpi to cxl_pmem.
> 
> When CXL_ACPI=y and CXL_PMEM=m, the built-in cxl_acpi attempts to
> link against a non-built-in cxl_pmem, which the linker cannot resolve.
> 
> CXL_PMEM depends on LIBNVDIMM, so LIBNVDIMM=m constrains CXL_PMEM to
> at most =m.
> 
> Change IS_ENABLED() to IS_REACHABLE(), which returns false when a
> built-in caller references a modular target, preventing the link error.
> 
> The result is if the pmem/nvdimm symbols are not reachable at build
> time, then at runtime it will always return -ENODEV.
> 
> Fixes: e7e222ad73d9 ("cxl: Move devm_cxl_add_nvdimm_bridge() to cxl_pmem.ko")
> Signed-off-by: Gregory Price <gourry@gourry.net>

What's the impact of this build combination wrt to whether the result is
actually useful?   Is there any point in building CXL_PMEM as a module
without this call being made?  I can't remember and normally don't care
much about PMEM :) 

> ---
>  drivers/cxl/acpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 127537628817..7065413eda9f 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -952,7 +952,7 @@ static int cxl_acpi_probe(struct platform_device *pdev)
>  	if (rc < 0)
>  		return rc;
>  
> -	if (IS_ENABLED(CONFIG_CXL_PMEM))
> +	if (IS_REACHABLE(CONFIG_CXL_PMEM))
>  		rc = device_for_each_child(&root_port->dev, root_port,
>  					   add_root_nvdimm_bridge);
>  	if (rc < 0)

