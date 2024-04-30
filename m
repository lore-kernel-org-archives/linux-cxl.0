Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49B8176FA3
	for <linux-cxl@vger.kernel.org>; Tue, 30 Apr 2024 16:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714494477; cv=none; b=fnZXHZaeVBslUSJurNpFEAf/+nj/04RHuJLYZC9c663BaZb6PuD/rkbgDcs+YhonSGxlCIQxQWRQhB9emLuEWluynmxZzOzAtk8rgo+dsKqMlQB0nslpa6RKi3sykTz4S01f0Pr2rajGyAKYvG9T8oEGvRacsRIc6vlwdaKfJDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714494477; c=relaxed/simple;
	bh=me3gMrJhssYJVUD8g+AdkcKKxISwphIaO4I+gMiNUu4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nXmD1sqPvLvzzMLU7oBILd9C0j0tj7NIUIxXgG3uxe6fjHKrr3BrN+RkP0bObfJ1wbuqxP6ZL4mv7OL61CRNOpfxQbJJx1m5aDPtaH56oL45Fprgcvuypifk3rjC3eZqKuhKK6fC9KvCsJEezxG9G0lPF5/2piswBp+o9RU4Erk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VTQbC11mRz6K8yJ;
	Wed,  1 May 2024 00:27:35 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 522DC140CF4;
	Wed,  1 May 2024 00:27:53 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 30 Apr
 2024 17:27:52 +0100
Date: Tue, 30 Apr 2024 17:27:51 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <alison.schofield@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
 Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>, "Steven
 Rostedt" <rostedt@goodmis.org>, Shiyang Ruan <ruansy.fnst@fujitsu.com>
Subject: Re: [PATCH v5 1/4] cxl/trace: Correct DPA field masks for
 general_media & dram events
Message-ID: <20240430172751.00005072@Huawei.com>
In-Reply-To: <23671305ae3cd299aacb3be61d90504d6918a7f8.1714435815.git.alison.schofield@intel.com>
References: <cover.1714435815.git.alison.schofield@intel.com>
	<23671305ae3cd299aacb3be61d90504d6918a7f8.1714435815.git.alison.schofield@intel.com>
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
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 29 Apr 2024 17:34:21 -0700
alison.schofield@intel.com wrote:

> From: Alison Schofield <alison.schofield@intel.com>
> 
> The length of Physical Address in General Media and DRAM event
> records is 64-bit, so the field mask for extracting the DPA should
> be 64-bit also, otherwise the trace event reports DPA's with the
> upper 32 bits of a DPA address masked off. If userspace was doing
> DPA-to-HPA translations this could lead to incorrect page retirement
> decisions, but there is no known consumer (like rasdaemon) of this
> event today.

https://github.com/mchehab/rasdaemon/blob/master/ras-cxl-handler.c#L205
Yes there is, though there may well not have been back in at v1.

> 
> Use GENMASK_ULL() for CXL_DPA_MASK to get all the DPA address bits.
> 
> Tidy up CXL_DPA_FLAGS_MASK by using GENMASK() to only mask the exact
> flag bits.
> 
> These bits are defined as part of the event record physical address
> descriptions of General Media and DRAM events in CXL Spec 3.1
> Section 8.2.9.2 Events.
> 
> Co-developed-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Jonathan Cameron <Jonathan.CAmeron@huawei.com>
Fixes tag would probably be appropriate I think as this should
be backported.

> ---
>  drivers/cxl/core/trace.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> index e5f13260fc52..7c5cd069f10c 100644
> --- a/drivers/cxl/core/trace.h
> +++ b/drivers/cxl/core/trace.h
> @@ -253,8 +253,8 @@ TRACE_EVENT(cxl_generic_event,
>   * DRAM Event Record
>   * CXL rev 3.0 section 8.2.9.2.1.2; Table 8-44
>   */
> -#define CXL_DPA_FLAGS_MASK			0x3F
> -#define CXL_DPA_MASK				(~CXL_DPA_FLAGS_MASK)
> +#define CXL_DPA_FLAGS_MASK			GENMASK(1, 0)
> +#define CXL_DPA_MASK				GENMASK_ULL(63, 6)
>  
>  #define CXL_DPA_VOLATILE			BIT(0)
>  #define CXL_DPA_NOT_REPAIRABLE			BIT(1)

