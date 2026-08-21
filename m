Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BDC389104
	for <linux-cxl@vger.kernel.org>; Fri, 21 Aug 2026 19:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787338893; cv=none; b=RJKbdQUTYvrCdAFl4ZXSoMlEzlvfv3zaS6MzMXCZCeetyNwZh5o4Move/IYm3FB8E0cKAhuDt6ipCa9OddFzi9ZirurLA5imcIONuyfHBVEp1QnekykNgalCLlc0fG7lLGt9ni7McZuhMdQ47pD8dlDJzHMbv4odSrU61r0jk90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787338893; c=relaxed/simple;
	bh=NUEwRdvxvCt8pHf09z8V816YlZPzClCNKCaltSgBD8U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d7ZUQEUJziyzYLw04mcAdYRsyeJzhLGYN1ur++TVOdybHQ8sdL3+oRwUR5td5MkKsaZnFU+cWS9xDyQCH2Jso376fUYoepdaM9dSrd/5NWL6se0/H3DU/FKaMYqJ7iO0VMT6TfFgwH+o/i2QIqgvd1mo4Ibw1Vk9OKe9gjtvWSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BbdmLn9Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BbdmLn9Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C2681F000E9;
	Fri, 21 Aug 2026 19:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787338892;
	bh=CEa4tXTaI1532MvcKGXM+Riwo3evBruj+KkywYT/Lv0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BbdmLn9YUQkeK8GNk/gBHJzKOPh/Kmfnl40cjpp+VmoyBi6SATg3fQP3lAbOi7yvu
	 r9WJxIXQE5BRilQSHB/pxE7UO7YNBpY3UoYzyvTgwDe5h7tKvAYiVxX3o9bUgEeS9F
	 /177EZnGNMAl4+O4oSZygGWAB3JCWSf0PLuSNjJGBBfwwAW9DwAMRPk5JSZ4AN7DKf
	 fRcq6z0WfZ9pRbybrp8sGtiI+uq/84joMoPgK/wrn/e2iykjyccoHEkygyZaDeYcFk
	 9w1ssOsZz4DXSH1/yJ0TrRhzGGiXlR66tp7GCWpgBhj5Pi22mQ4nQRlXvJMkzGBOCb
	 TL8ZCqPgGV+hg==
Date: Fri, 21 Aug 2026 20:01:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, Li
 Ming <ming.li@zohomail.com>, Robert Richter <rrichter@amd.com>,
 linux-cxl@vger.kernel.org
Subject: Re: [PATCH v4 1/6] cxl/region: Warn on user region position
 mismatch
Message-ID: <20260821200127.60bef3fd@jic23-huawei>
In-Reply-To: <c393fd7884c251d86ce3f5c92ed747dc3eef6d8d.1787255388.git.alison.schofield@intel.com>
References: <cover.1787255388.git.alison.schofield@intel.com>
	<c393fd7884c251d86ce3f5c92ed747dc3eef6d8d.1787255388.git.alison.schofield@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Aug 2026 16:31:19 -0700
Alison Schofield <alison.schofield@intel.com> wrote:

> User region creation includes a self-test that checks the assigned
> endpoint positions against the position calculation used by auto
> region creation. A mismatch is reported with dev_dbg().
> 
> Promote that to a dev_warn() so bugs in the auto region position
> calculation are easier to catch as that calculation is extended to
> support more region configurations.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Seems reasonable to me.
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

> ---
> 
>  drivers/cxl/core/region.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 1e211542b6b6..3b640c9ba5a0 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2218,10 +2218,10 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  		int test_pos;
>  
>  		test_pos = cxl_calc_interleave_pos(target, &cxlr->hpa_range);
> -		dev_dbg(&target->cxld.dev,
> -			"Test cxl_calc_interleave_pos(): %s test_pos:%d target->pos:%d\n",
> -			(test_pos == target->pos) ? "success" : "fail",
> -			test_pos, target->pos);
> +		if (test_pos != target->pos)
> +			dev_warn(&target->cxld.dev,
> +				 "position mismatch: calculated:%d programmed:%d\n",
> +				 test_pos, target->pos);
>  	}
>  
>  	return 0;

