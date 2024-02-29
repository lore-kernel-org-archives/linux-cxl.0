Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960A270AEA
	for <linux-cxl@vger.kernel.org>; Thu, 29 Feb 2024 17:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709228727; cv=none; b=O+PZVSWQY6xhbRjXEBSLOnNrdcpXKYV02MnSd2wIWxkxjGH9N1VL1CY2l7iDzZgQ873fS+Y3tFLZTC3uZAIVF9JeGnqbiPtw0Pp9SkgqZlHIKF79UcJg9Yb6BIulYswrK8oGtaqvlrK0gnXntTnr8zm7KxV3aQDA+JQejEakC1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709228727; c=relaxed/simple;
	bh=Y3dktRX/2BVldXZn9r16G9f2WFrv1XwMIX8M07Lpo0Y=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EMcB5Zb1zKziQhCaSpty5XFgt7mfa+eyppvCFogVeGx54OYXEekDEwVs40Ayr6BOmQihJ2FlfXyKciAA/YH8vH2dCMVs8uURhIm1BifLAAZYWizSqtFykM/+pElRxu4Gz8PNghEOybYin/I1nQ+iussRB6P5cPnbqqto2Rf0RlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tlz5g1Q9sz6J9b9;
	Fri,  1 Mar 2024 01:40:39 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id ECBDE140B2F;
	Fri,  1 Mar 2024 01:45:21 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 29 Feb
 2024 17:45:21 +0000
Date: Thu, 29 Feb 2024 17:45:20 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>
Subject: Re: [PATCH 1/2] cxl: Remove checking of iter in
 cxl_endpoint_get_perf_coordinates()
Message-ID: <20240229174520.000073e2@Huawei.com>
In-Reply-To: <20240229002542.634982-1-dave.jiang@intel.com>
References: <20240229002542.634982-1-dave.jiang@intel.com>
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

On Wed, 28 Feb 2024 17:25:41 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> The while() loop in cxl_endpoint_get_perf_coordinates() checks to see if
> 'iter' is valid as part of the condition breaking out of the loop. However,
> iter is being used before the check at the end of the while loop before
> the next iteration starts. Given that the loop doesn't expect the iter to
> be NULL because it stops before the root port, remove the iter check.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/cxl/core/port.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index e59d9d37aa65..e1d30a885700 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -2142,7 +2142,7 @@ int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
>  	 * port each iteration. If the parent is cxl root then there is
>  	 * nothing to gather.
>  	 */
> -	while (iter && !is_cxl_root(to_cxl_port(iter->dev.parent))) {
> +	while (!is_cxl_root(to_cxl_port(iter->dev.parent))) {
>  		combine_coordinates(&c, &dport->sw_coord);
>  		c.write_latency += dport->link_latency;
>  		c.read_latency += dport->link_latency;

