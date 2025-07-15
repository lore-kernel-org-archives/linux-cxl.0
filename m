Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A801E5018;
	Tue, 15 Jul 2025 16:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752596442; cv=none; b=P1pIzQd7thDiWFEXKqH5H06TJ8PlHjOYgogzuc58+omRhdQ87+XS6dL5ctTWChhuIMyyi8UFlID0m/1RUlNDUYvcEUAtUPgyiuo5oJAPY8NM25mOTQPv933U+ECO2kCcXB+jwde92WK5m/3yAfHoxaarVLg1gG6i6bo5VK1pbWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752596442; c=relaxed/simple;
	bh=05/yvMMWgf6GXwk/H6EcY+YevbquuCG1Zjddctq4uZE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PHO/i4qRfhUruiQFVBba02eDHwxTI/L1F4735SFCoo4eBA6W+Yr91p2GxM/EXKHf7K4lvn/u1XMt4L15e6R/z79V65cIbIE8Fv/7EQAF8Loov1m904tZdZe9dVYiBcKfPuD51MFnB3NY4KzwZA93ZNrzfDrZOZfyk9C3muwHt1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bhPXK0djlz67V6P;
	Wed, 16 Jul 2025 00:19:29 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 416A014027A;
	Wed, 16 Jul 2025 00:20:37 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 15 Jul
 2025 18:20:36 +0200
Date: Tue, 15 Jul 2025 17:20:35 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, David Lechner
	<dlechner@baylibre.com>, Peter Zijlstra <peterz@infradead.org>, "Linus
 Torvalds" <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Shiju Jose
	<shiju.jose@huawei.com>
Subject: Re: [PATCH v3 8/8] cxl: Convert to ACQUIRE() for conditional rwsem
 locking
Message-ID: <20250715172035.00007f96@huawei.com>
In-Reply-To: <20250711234932.671292-9-dan.j.williams@intel.com>
References: <20250711234932.671292-1-dan.j.williams@intel.com>
	<20250711234932.671292-9-dan.j.williams@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 11 Jul 2025 16:49:32 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Use ACQUIRE() to cleanup conditional locking paths in the CXL driver
> The ACQUIRE() macro and its associated ACQUIRE_ERR() helpers, like
> scoped_cond_guard(), arrange for scoped-based conditional locking. Unlike
> scoped_cond_guard(), these macros arrange for an ERR_PTR() to be retrieved
> representing the state of the conditional lock.
> 
> The goal of this conversion is to complete the removal of all explicit
> unlock calls in the subsystem. I.e. the methods to acquire a lock are
> solely via guard(), scoped_guard() (for limited cases), or ACQUIRE(). All
> unlock is implicit / scope-based. In order to make sure all lock sites are
> converted, the existing rwsem's are consolidated and renamed in 'struct
> cxl_rwsem'. While that makes the patch noisier it gives a clean cut-off
> between old-world (explicit unlock allowed), and new world (explicit unlock
> deleted).
> 
> Cc: David Lechner <dlechner@baylibre.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Shiju Jose <shiju.jose@huawei.com>
> Acked-by: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Two trivial comments inline. 

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 4314aaed8ad8..ad60c93be803 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c

>  static int attach_target(struct cxl_region *cxlr,
>  			 struct cxl_endpoint_decoder *cxled, int pos,
>  			 unsigned int state)
>  {
> -	int rc = 0;
> -
> -	if (state == TASK_INTERRUPTIBLE)
> -		rc = down_write_killable(&cxl_region_rwsem);
> -	else
> -		down_write(&cxl_region_rwsem);
> -	if (rc)
> -		return rc;
> -
> -	down_read(&cxl_dpa_rwsem);
> -	rc = cxl_region_attach(cxlr, cxled, pos);
> -	up_read(&cxl_dpa_rwsem);
> -	up_write(&cxl_region_rwsem);
> +	int rc = __attach_target(cxlr, cxled, pos, state);
>  

... (start of block for next comment)

> -	if (rc)
> -		dev_warn(cxled->cxld.dev.parent,
> -			"failed to attach %s to %s: %d\n",
> -			dev_name(&cxled->cxld.dev), dev_name(&cxlr->dev), rc);
> +	if (rc == 0)
> +		return 0;
>  
> +	dev_warn(cxled->cxld.dev.parent, "failed to attach %s to %s: %d\n",
> +		 dev_name(&cxled->cxld.dev), dev_name(&cxlr->dev), rc);

I'm not seeing a reason for this change.  I prefer the original
with the error path as the out of line case.


>  	return rc;
>  }


> @@ -3592,30 +3552,23 @@ static int cxl_region_can_probe(struct cxl_region *cxlr)
...
  
>  	if (test_bit(CXL_REGION_F_NEEDS_RESET, &cxlr->flags)) {
>  		dev_err(&cxlr->dev,
>  			"failed to activate, re-commit region and retry\n");
> -		rc = -ENXIO;
> -		goto out;
> +		return -ENXIO;

		return dev_err_probe(&cxlr->dev, -ENXIO,
				     "failed to activate, re-commit region and retry\n");

perhaps. I always like the cleanup.h stuff enabling this as it improves the patch
line count no end ;)


>  	}
>  
> -out:
> -	up_read(&cxl_region_rwsem);
> -
> -	if (rc)
> -		return rc;
>  	return 0;
>  }
