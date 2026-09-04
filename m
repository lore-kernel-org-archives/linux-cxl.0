Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3BC29B781;
	Fri,  4 Sep 2026 02:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788490680; cv=none; b=j/4cnoimhsUMkTQXY8N3z4bhB5zse3fJcOp/LY+zXh14l9F3fA0xu1gp7Hyk9a1AcdMtnbWDYQ5evn5UV6K7ek5AhbzNGa8IQtkYBLRE/9cz1N2H4sjZLHj1+5bWxQVheGlekXrjwKDxUFdx1OT5U0H8Kd3nvZjFGcHnmNCflsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788490680; c=relaxed/simple;
	bh=ZFpG/XZaw/0wnI7NAOncgWaZNM7SZLhlnBzJhDF1cYg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=PvIR8CYsSOeUtUDcU0h/4u6TbVGHcwSzoyutcAkzLIOZHJg2p8IGGZoBXy2HRITK0YbkleX7Ns4HqGmkOay/1ngCtCa3qHM6UDvfsJCp13FxrOfKXx1o+JADPCwO+NuyCkcAS1SVjAeaQ3QNhdbGvlusG1Bfqgvxk357mLLeD+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O7sxg/p0; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O7sxg/p0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788490679; x=1820026679;
  h=message-id:date:mime-version:subject:from:to:references:
   in-reply-to:content-transfer-encoding;
  bh=ZFpG/XZaw/0wnI7NAOncgWaZNM7SZLhlnBzJhDF1cYg=;
  b=O7sxg/p0hzg1Tw9rrQR3ZxvmunNo8JJY3m0QmaZd9xvtE9XiQE55UTnB
   2g0cFS+msmZDsoyPcUo2qq+0TroDQiEsGh5V+GxCiYQao+7A1RS0M/OKL
   pK+Nnx2DRbW+qgGXatdDjQ8vQ//GXlgLk6tkk9zqBNZg+1QF9+Cw5gchf
   57xpKO6n7t58eqNpdlCcMHEdtCJkFw5byq1rd2wOkNa+r27IRXEnbyc26
   +aTOKTqT0uvjOGGWextIC/pwJDm73BIUtwS7f5EpLyscyMJFtHyTm43yA
   XzjV5X9eVKMpol1fA5vOmrhW/ISNaj4NhSatYGkAmZc8vEJ3hYTwzca1/
   A==;
X-CSE-ConnectionGUID: /sTEd+9nQTC/qHaDvBtjJQ==
X-CSE-MsgGUID: LLNQ6Z3uTl6n7pk/BBeOQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="87926625"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="87926625"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 19:57:58 -0700
X-CSE-ConnectionGUID: xacLvhE8T7qdgBwJJPb/gQ==
X-CSE-MsgGUID: 2VbywhQzR6qHkni0ew7b8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="270437902"
Received: from aschende-mobl.amr.corp.intel.com (HELO [10.125.110.190]) ([10.125.110.190])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 19:57:58 -0700
Message-ID: <58601306-2401-47ce-a051-684312ff6630@intel.com>
Date: Thu, 3 Sep 2026 19:57:57 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add Richard Cheng to CXL subsystem as a
 Reviewer
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260902235348.3563444-1-dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260902235348.3563444-1-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/2/26 4:53 PM, Dave Jiang wrote:
> Add Richard as a reviewer for CXL subsystem.
> 
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Richard Cheng <icheng@nvidia.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Applied to cxl/next
6495547d643d

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3a19da74d00c..25d61ce9506a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6567,6 +6567,7 @@ M:	Vishal Verma <vishal.l.verma@intel.com>
>  M:	Dan Williams <djbw@kernel.org>
>  R:	Ira Weiny <iweiny@kernel.org>
>  R:	Li Ming <ming.li@zohomail.com>
> +R:	Richard Cheng <icheng@nvidia.com>
>  L:	linux-cxl@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/driver-api/cxl
> 
> base-commit: cee9395acd8043be0644b25c34bfa86623f2b935

