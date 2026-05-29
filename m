Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6922E7378;
	Fri, 29 May 2026 16:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780071039; cv=none; b=PBk5vEY/V1oIhDtQ3GXmGH3DwSz1xUFAJxPlNtiNrwC8gos+wCfE+ren10YUBs9ciRC5bQYs5Aob10I0dTO37xb9IPA5KIcWkPInTQ5Lw+PfUYez7o38ORZvdpl03GrAbfYybJPCw1oePL9W8yvSNiuWnxgOGRpddH1bSDZwMME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780071039; c=relaxed/simple;
	bh=UZLusWf4bcT/ycD8aHU7xK0aEb315I5lvI1BlNafl7s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gg9qoxz8OYviNx893AlOE5nYKEmYEOzqTi5gnFgVzXiYUuNMEwncZHUPPM9V7k2Fw6Wh1a5Yq93Es6zKrB7t4rm4Ewgf//Vep2WlbnGxNHWAdF12GK+DXTvFiIKvMoxK4hvPmWjFbcXkJvuNI+FkG8JMkzKC7Qa8i4x33cSuq7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FdcVNoNq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FdcVNoNq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C09101F00893;
	Fri, 29 May 2026 16:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780071038;
	bh=0cfOaGqtXhzo3vVoQAD71kbwV/uATf5IVMb/TrLF8tQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FdcVNoNqszKzYLbncqvIj3IKV9TiF7cDek9qbm1jDcGWZPJsGPHvmcI3cdTh2v76a
	 yLrK4Dg3CkohtsWyEPNIQlflDTRRIaJ7zwdyaI0UBOtDjEbWeUKnQsxdH24d2rZd61
	 TqSz7Fz+CpQzmkh7nmzGtCyPSRaegM9l5FiTJXs1mzoNeM7tD5DdY7LdUjAlR3ztf+
	 Qj/Qvww9ZiZJ8PoW+ZF3XeswZDfbU6+x9PYXH4pg56pO2hOLdilYb9Hu50kfc1PSKJ
	 5qLa1+KqQVRd1lnHDxJIE21RH2xC7lTDms6xAs25pKN0KiC+0hdEzTq3IOQsYeVVqs
	 gMZZTLCaFI+2A==
Date: Fri, 29 May 2026 17:10:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ahmed Tiba <ahmed.tiba@arm.com>
Cc: will@kernel.org, xueshuai@linux.alibaba.com, saket.dumbre@intel.com,
 mchehab@kernel.org, dave@stgolabs.net, djbw@kernel.org, bp@alien8.de,
 tony.luck@intel.com, guohanjun@huawei.com, lenb@kernel.org,
 skhan@linuxfoundation.org, vishal.l.verma@intel.com, rafael@kernel.org,
 corbet@lwn.net, ira.weiny@intel.com, dave.jiang@intel.com,
 krzk+dt@kernel.org, robh@kernel.org, catalin.marinas@arm.com,
 alison.schofield@intel.com, conor+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, Michael.Zhao2@arm.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org, Dmitry.Lamerov@arm.com,
 devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-edac@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [PATCH v5 05/10] ACPI: APEI: GHES: move vendor record helpers
Message-ID: <20260529171022.073eb4cd@jic23-huawei>
In-Reply-To: <20260529-topics-ahmtib01-ras_ffh_arm_internal_review-v5-5-2e0500d42642@arm.com>
References: <20260529-topics-ahmtib01-ras_ffh_arm_internal_review-v5-0-2e0500d42642@arm.com>
	<20260529-topics-ahmtib01-ras_ffh_arm_internal_review-v5-5-2e0500d42642@arm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 May 2026 10:50:45 +0100
Ahmed Tiba <ahmed.tiba@arm.com> wrote:

> Shift the vendor record workqueue helpers into ghes_cper.c so both GHES
> and future DT-based providers can use the same implementation. The change
> is mechanical and keeps the notifier behavior identical.
> 
> Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>
A few questions  / comments inline

J
> ---
>  drivers/acpi/apei/ghes.c      | 86 +++++++++----------------------------------
>  drivers/acpi/apei/ghes_cper.c | 55 +++++++++++++++++++++++++++
>  include/acpi/ghes_cper.h      |  2 +
>  3 files changed, 75 insertions(+), 68 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index adab7404310e..81ac51632f21 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
...

> -
> -static void ghes_vendor_record_notifier_destroy(void *nb)
> -{
> -	ghes_unregister_vendor_record_notifier(nb);
> -}
> -
> -int devm_ghes_register_vendor_record_notifier(struct device *dev,
> -					      struct notifier_block *nb)
> -{
> -	int ret;
> -
> -	ret = ghes_register_vendor_record_notifier(nb);
> -	if (ret)
> -		return ret;
> -
> -	return devm_add_action_or_reset(dev, ghes_vendor_record_notifier_destroy, nb);
> -}
> -EXPORT_SYMBOL_GPL(devm_ghes_register_vendor_record_notifier);

>  #define CXL_CPER_PROT_ERR_FIFO_DEPTH 8
>  static DEFINE_KFIFO(cxl_cper_prot_err_fifo, struct cxl_cper_prot_err_work_data,
> @@ -514,6 +446,24 @@ int cxl_cper_prot_err_kfifo_get(struct cxl_cper_prot_err_work_data *wd)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_cper_prot_err_kfifo_get, "CXL");
>  
> +static void ghes_vendor_record_notifier_destroy(void *nb)
> +{
> +	ghes_unregister_vendor_record_notifier(nb);
> +}
> +
> +int devm_ghes_register_vendor_record_notifier(struct device *dev,
> +					      struct notifier_block *nb)
> +{
> +	int ret;
> +
> +	ret = ghes_register_vendor_record_notifier(nb);
> +	if (ret)
> +		return ret;
> +
> +	return devm_add_action_or_reset(dev, ghes_vendor_record_notifier_destroy, nb);
> +}
> +EXPORT_SYMBOL_GPL(devm_ghes_register_vendor_record_notifier);
> +

Why did these two move inside the file?  It is a bit odd to leave the devm calls in
a different place to what they are wrapping. I guess someone argued for that in an
earlier version? (hopefully not me ;)  
If the move puts them in an ifdef block then I'd not bother - it's tiny code and
to me doing this is more confusing than just leaving them where they were.


>  /* Room for 8 entries for each of the 4 event log queues */
>  #define CXL_CPER_FIFO_DEPTH 32
>  DEFINE_KFIFO(cxl_cper_fifo, struct cxl_cper_work_data, CXL_CPER_FIFO_DEPTH);
> diff --git a/drivers/acpi/apei/ghes_cper.c b/drivers/acpi/apei/ghes_cper.c
> index 0a117f478afb..131980d36064 100644
> --- a/drivers/acpi/apei/ghes_cper.c
> +++ b/drivers/acpi/apei/ghes_cper.c
> @@ -14,12 +14,17 @@
>  
>  #include <linux/err.h>
>  #include <linux/genalloc.h>
> +#include <linux/irq_work.h>
>  #include <linux/io.h>
>  #include <linux/kernel.h>
> +#include <linux/list.h>
>  #include <linux/math64.h>
>  #include <linux/mm.h>
> +#include <linux/notifier.h>
> +#include <linux/llist.h>
>  #include <linux/ratelimit.h>
>  #include <linux/rcupdate.h>
> +#include <linux/rculist.h>

I'm not seeing anything reason for most of these new includes.
Probably in the wrong patch


>  #include <linux/sched/clock.h>
>  #include <linux/slab.h>
>  
> @@ -266,6 +271,56 @@ void ghes_clear_estatus(struct ghes *ghes,
>  		ghes_ack_error(ghes->generic_v2);
>  }
>  
> +static BLOCKING_NOTIFIER_HEAD(vendor_record_notify_list);
> +
> +int ghes_register_vendor_record_notifier(struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_register(&vendor_record_notify_list, nb);
> +}
> +EXPORT_SYMBOL_GPL(ghes_register_vendor_record_notifier);
> +
> +void ghes_unregister_vendor_record_notifier(struct notifier_block *nb)
> +{
> +	blocking_notifier_chain_unregister(&vendor_record_notify_list, nb);
> +}
> +EXPORT_SYMBOL_GPL(ghes_unregister_vendor_record_notifier);
> +
> +static void ghes_vendor_record_work_func(struct work_struct *work)
> +{
> +	struct ghes_vendor_record_entry *entry;
> +	struct acpi_hest_generic_data *gdata;
> +	u32 len;
> +
> +	entry = container_of(work, struct ghes_vendor_record_entry, work);
> +	gdata = GHES_GDATA_FROM_VENDOR_ENTRY(entry);
> +
> +	blocking_notifier_call_chain(&vendor_record_notify_list,
> +				     entry->error_severity, gdata);
> +
> +	len = GHES_VENDOR_ENTRY_LEN(acpi_hest_get_record_size(gdata));
> +	gen_pool_free(ghes_estatus_pool, (unsigned long)entry, len);
> +}
> +
> +void ghes_defer_non_standard_event(struct acpi_hest_generic_data *gdata,
> +				   int sev)
> +{
> +	struct acpi_hest_generic_data *copied_gdata;
> +	struct ghes_vendor_record_entry *entry;
> +	u32 len;
> +
> +	len = GHES_VENDOR_ENTRY_LEN(acpi_hest_get_record_size(gdata));
> +	entry = (void *)gen_pool_alloc(ghes_estatus_pool, len);
> +	if (!entry)
> +		return;
> +
> +	copied_gdata = GHES_GDATA_FROM_VENDOR_ENTRY(entry);
> +	memcpy(copied_gdata, gdata, acpi_hest_get_record_size(gdata));
> +	entry->error_severity = sev;
> +
> +	INIT_WORK(&entry->work, ghes_vendor_record_work_func);
> +	schedule_work(&entry->work);
> +}
> +
>  /*
>   * GHES error status reporting throttle, to report more kinds of
>   * errors, instead of just most frequently occurred errors.
> diff --git a/include/acpi/ghes_cper.h b/include/acpi/ghes_cper.h
> index 1b5dbeca9bb6..51725f25c516 100644
> --- a/include/acpi/ghes_cper.h
> +++ b/include/acpi/ghes_cper.h
> @@ -104,5 +104,7 @@ int __ghes_read_estatus(struct acpi_hest_generic_status *estatus,
>  int ghes_estatus_cached(struct acpi_hest_generic_status *estatus);
>  void ghes_estatus_cache_add(struct acpi_hest_generic *generic,
>  			    struct acpi_hest_generic_status *estatus);
> +void ghes_defer_non_standard_event(struct acpi_hest_generic_data *gdata,
> +				   int sev);
>  
>  #endif /* ACPI_APEI_GHES_CPER_H */
> 

