Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0ED192D80
	for <linux-cxl@vger.kernel.org>; Fri, 30 Aug 2024 11:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725015773; cv=none; b=HIYu3UrzPnlFIpf0kboRadK1bCofmIOOmPPBXgBGi1L14v6Q/2nX2JNKbIeCA0RV9J4eaQQXYRe+Y7ANcHJUjN6MxKxzlK5XeFpb2DuK1CGTFzH4noYMbZwAz19sH5VazO42OwCfb5cw5LNaJGVF+BV2SPK5YfMQuyNlRzoveJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725015773; c=relaxed/simple;
	bh=mZbBfxra1IxNbfQePWPoWrIuw6fxU/OIw+j6vsdzgeQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K9Fd09s0rz7R+Pl1UuzjhldyFyjs57P2cmibaFE7qDDWkW6mmoudtN/Xs2RuJEinY/AC4JJHnsiCksLPq0WHjsjb50E2u/Nh0KTPx13c3++WeNc7oqZd7ejuo22assggWZhxObJTV0bqsH2b0nYhRvyFYyDaVUmvggksc5MfLxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WwFXL45Cfz6J7sb;
	Fri, 30 Aug 2024 18:59:30 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id A39761408F9;
	Fri, 30 Aug 2024 19:02:49 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 30 Aug
 2024 12:02:49 +0100
Date: Fri, 30 Aug 2024 12:02:48 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Hongbo Li <lihongbo22@huawei.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH -next] cxl: Remove duplicate included header file core.h
Message-ID: <20240830120248.00002bee@Huawei.com>
In-Reply-To: <20240830080016.3542184-1-lihongbo22@huawei.com>
References: <20240830080016.3542184-1-lihongbo22@huawei.com>
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
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 30 Aug 2024 16:00:16 +0800
Hongbo Li <lihongbo22@huawei.com> wrote:

> The header file core.h is included twice. Remove the last
> one. The compilation test has passed.
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/cdat.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index bb83867d9fec..e2e1ccda88fa 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -9,7 +9,6 @@
>  #include "cxlmem.h"
>  #include "core.h"
>  #include "cxl.h"
> -#include "core.h"
>  
>  struct dsmas_entry {
>  	struct range dpa_range;

