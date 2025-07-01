Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B99F21D5BC;
	Tue,  1 Jul 2025 12:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751374456; cv=none; b=JghcinEAuZsswJvYx4Be8RVlSkwZ7TonxTfYLo7wEom/jGtmnha/pEJvHWc4/WxljIAR/ccznAa7ga5zWVUqakdK4cAlLKwKxY0brC3N7lAhqSyhIyzld4qPLMsmhvRHc0+WjwNnY4nNerVJn+Qh2dw/+xl3UJNMxC6PCPqLa5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751374456; c=relaxed/simple;
	bh=Dm4yxBSfVhY6e3BMkI0DCmsCmNv16N07mzalzA335AU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CI6xlAKHU0xWWk9VHmU5EL6SFwyEzSiy9z1ErfABeQWWYJiCPQtuH0Q7AG59P4c5oa4MAY/wBy1/RaAjniycmu5URVxG0JfTCfJoIthyOT/Ur8wp3BYRjUPRRNLurcD0Tj31NJVS43XCFIW/8JIpY77uh52Ka7oqKjesiaZcB+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bWjZb5wpBz6L4vL;
	Tue,  1 Jul 2025 20:51:19 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 369E614038F;
	Tue,  1 Jul 2025 20:54:10 +0800 (CST)
Received: from localhost (10.122.19.247) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 1 Jul
 2025 14:54:09 +0200
Date: Tue, 1 Jul 2025 13:54:08 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: <linux-kernel@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, "Dave
 Jiang" <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, "Ira Weiny" <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2] cxl: make cxl_bus_type constant
Message-ID: <20250701135408.00003144@huawei.com>
In-Reply-To: <2025070138-vigorous-negative-eae7@gregkh>
References: <2025070138-vigorous-negative-eae7@gregkh>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue,  1 Jul 2025 14:07:39 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> Now that the driver core can properly handle constant struct bus_type,
> move the cxl_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: linux-cxl@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
> v2: fix up the subject line to be correct
> 
>  drivers/cxl/core/port.c | 2 +-
>  drivers/cxl/cxl.h       | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index eb46c6764d20..0696f7fcef56 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -2293,7 +2293,7 @@ static const struct attribute_group *cxl_bus_attribute_groups[] = {
>  	NULL,
>  };
>  
> -struct bus_type cxl_bus_type = {
> +const struct bus_type cxl_bus_type = {
>  	.name = "cxl",
>  	.uevent = cxl_bus_uevent,
>  	.match = cxl_bus_match,
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 3f1695c96abc..e7b66ca1d423 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -815,7 +815,7 @@ int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
>  
>  bool is_cxl_region(struct device *dev);
>  
> -extern struct bus_type cxl_bus_type;
> +extern const struct bus_type cxl_bus_type;
>  
>  struct cxl_driver {
>  	const char *name;

