Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E902227B9F
	for <linux-cxl@vger.kernel.org>; Fri, 15 Aug 2025 13:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755263054; cv=none; b=TUlcQKflhwjzcfrh58VxU3u7hrxZL+JGTc/O3/jZ/j+5Odb8ZziMeq9+eePtGLqrtwZXNnL6q/D3oQAL9YqEXsreJBRRbnj8EZr9PeR+0NomBaTAMQBEoBtY3skBOkh4dY7taBpWljcGeGC2tWPD9k50roruzniCRgMpuErapxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755263054; c=relaxed/simple;
	bh=zI4NHN4e4z2NkPp3oy0FGyzqLAyP6nh0yQxIX1NRpJE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KW323DLF3AEUKG84duNor+VNeIeaRMd6th918nibTx3kgzD2LcR+CTi5wIs5IcgMKtZj+95cnXbTv0OacTO/qkjqtQmSdTuGh3NB0vbcL1Rl9Jv89SpdCfYrnr9bcEwxefRR0+5AesSuLP11wlmJaId6ybXZe+FRxmodx2xt/dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c3Mct2gnxz6L5PG;
	Fri, 15 Aug 2025 20:59:10 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id ABE241400CA;
	Fri, 15 Aug 2025 21:04:08 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 15 Aug
 2025 15:04:08 +0200
Date: Fri, 15 Aug 2025 14:04:06 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <rrichter@amd.com>
Subject: Re: [PATCH v8 09/11] cxl/test: Setup target_map for cxl_test
 decoder initialization
Message-ID: <20250815140406.000040ce@huawei.com>
In-Reply-To: <20250814222151.3520500-10-dave.jiang@intel.com>
References: <20250814222151.3520500-1-dave.jiang@intel.com>
	<20250814222151.3520500-10-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 14 Aug 2025 15:21:49 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> cxl_test uses mock functions for decoder enumation. Add initialization
> of the cxld->target_map[] for cxl_test based decoders in the mock
> functions.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Looks fine.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>  tools/testing/cxl/test/cxl.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 0ef2a8ec1fab..2d50193d10fe 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -818,15 +818,21 @@ static void mock_init_hdm_decoder(struct cxl_decoder *cxld)
>  		 */
>  		if (WARN_ON(!dev))
>  			continue;
> +
>  		cxlsd = to_cxl_switch_decoder(dev);
>  		if (i == 0) {
>  			/* put cxl_mem.4 second in the decode order */
> -			if (pdev->id == 4)
> +			if (pdev->id == 4) {
>  				cxlsd->target[1] = dport;
> -			else
> +				cxld->target_map[1] = dport->port_id;
> +			} else {
>  				cxlsd->target[0] = dport;
> -		} else
> +				cxld->target_map[0] = dport->port_id;
> +			}
> +		} else {
>  			cxlsd->target[0] = dport;
> +			cxld->target_map[0] = dport->port_id;
> +		}
>  		cxld = &cxlsd->cxld;
>  		cxld->target_type = CXL_DECODER_HOSTONLYMEM;
>  		cxld->flags = CXL_DECODER_F_ENABLE;

