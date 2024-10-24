Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1831714B0
	for <linux-cxl@vger.kernel.org>; Thu, 24 Oct 2024 09:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729763065; cv=none; b=sYVOUaOPMpfhrrRQiS0VwmOcB/HrtZ1pGzSNE9ebYAzQo9caeAS+NvER/036b+IXFlzOqoj4OvMnhTDcjT4xvkxkhzCo+aqt+DM1+fjvZ0BTtNFvroLCfXlVoUCYtuec16Ti2SFJkSQiOjcdz8Sc1wPjCv7DzjvXgRrk3CxpK7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729763065; c=relaxed/simple;
	bh=QAJjP5+zjkxnxn51WzT7K+RiW8tOK+csI5bFBDE0ypQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pvB7S0O/cq46/XTWInj5p1ROWnpV3hL8l5TRiIHZLeBaTX40cJQylwKKUCGbhR5e/SRxVEEm1nHKE1YufxQHc+5kjvj5Ml3I80xvfnoKDCoHczmHoCKMFfkBOULwdXTiH1RdnImmtm1hH1Z0AXa/w4obJvAUg6VnUeTv5qXuryc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XZ1F53yNjz6K5rC;
	Thu, 24 Oct 2024 17:43:21 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 0EBE1140452;
	Thu, 24 Oct 2024 17:44:22 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 24 Oct
 2024 11:44:21 +0200
Date: Thu, 24 Oct 2024 10:44:20 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave.jiang@intel.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 3/6] cxl/acpi: Ensure ports ready at cxl_acpi_probe()
 return
Message-ID: <20241024104420.00004f90@Huawei.com>
In-Reply-To: <172964781969.81806.17276352414854540808.stgit@dwillia2-xfh.jf.intel.com>
References: <172964779333.81806.8852577918216421011.stgit@dwillia2-xfh.jf.intel.com>
	<172964781969.81806.17276352414854540808.stgit@dwillia2-xfh.jf.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 22 Oct 2024 18:43:40 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> In order to ensure root CXL ports are enabled upon cxl_acpi_probe()
> when the 'cxl_port' driver is built as a module, arrange for the
> module to be pre-loaded or built-in.
> 
> The "Fixes:" but no "Cc: stable" on this patch reflects that the issue
> is merely by inspection since the bug that triggered the discovery of
> this potential problem [1] is fixed by other means. However, a stable
> backport should do no harm.
> 
> Fixes: 8dd2bc0f8e02 ("cxl/mem: Add the cxl_mem driver")
> Link: http://lore.kernel.org/20241004212504.1246-1-gourry@gourry.net [1]
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Seems reasonable to me.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/acpi.c |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 82b78e331d8e..432b7cfd12a8 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -924,6 +924,13 @@ static void __exit cxl_acpi_exit(void)
>  
>  /* load before dax_hmem sees 'Soft Reserved' CXL ranges */
>  subsys_initcall(cxl_acpi_init);
> +
> +/*
> + * Arrange for host-bridge ports to be active synchronous with
> + * cxl_acpi_probe() exit.
> + */
> +MODULE_SOFTDEP("pre: cxl_port");
> +
>  module_exit(cxl_acpi_exit);
>  MODULE_DESCRIPTION("CXL ACPI: Platform Support");
>  MODULE_LICENSE("GPL v2");
> 
> 

