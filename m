Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312917FBBB
	for <linux-cxl@vger.kernel.org>; Wed,  6 Mar 2024 13:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709731978; cv=none; b=HC1SX+4iOdESkaH1HZp5m33B+lVDdO0HfhdeRXQz/LIYJBQdSxLjCpiLlOS0Aohg1Ts69ezKMOUg+jiJ7D5G4doVVwNicc31K+GTIX7Cl4Xke1Aajofb5VNV9/qABNCJQKZTmSqHHM3fUUUOR7V+cTUY0HZoux5yoDYbnY40v2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709731978; c=relaxed/simple;
	bh=Bz030QG0ZU+iu2YSWsCJaH2mDG2eZNu5SQ5F52psvas=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CuqxssUi4G62RigkFmw6lWV3Oi+eAoE9osocyXumvJY6G/IoWf52auPQ+gx2w+LOXBVzxccMF8WAbfCI5qmtUirYIquEhUUbYL7l8KnTX3ee/EsLGKNYZibFoESFyJlsERUc+Hro8vW2UWzxFzqL/2p3DDgtoEyIkBad5JVYdQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TqYCR3LKdz6K63V;
	Wed,  6 Mar 2024 21:28:03 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 2699C140D30;
	Wed,  6 Mar 2024 21:32:50 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 6 Mar
 2024 13:32:49 +0000
Date: Wed, 6 Mar 2024 13:32:49 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>
Subject: Re: [PATCH v2 1/2] cxl: Remove checking of iter in
 cxl_endpoint_get_perf_coordinates()
Message-ID: <20240306133249.00006426@Huawei.com>
In-Reply-To: <20240229203040.755450-1-dave.jiang@intel.com>
References: <20240229203040.755450-1-dave.jiang@intel.com>
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
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 29 Feb 2024 13:30:39 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> The while() loop in cxl_endpoint_get_perf_coordinates() checks to see if
> 'iter' is valid as part of the condition breaking out of the loop. However,
> iter is being used before the check at the end of the while loop before
> the next iteration starts. Given that the loop doesn't expect the iter to
> be NULL because it stops before the root port, remove the iter check.
> 
> The presence of the iter or removing the iter does not impact the behavior
> of the code. This is a code clean up and not a bug fix.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
> v2:
> - Add explanation of not a bug fix in commit log. (Dan)
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

