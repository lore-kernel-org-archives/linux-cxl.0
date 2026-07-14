Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3921B4DA54B
	for <linux-cxl@vger.kernel.org>; Tue, 14 Jul 2026 16:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784048002; cv=none; b=Ou08dw71XQKOm9MiqGufvvzHH9syzjIcJMUAoNoiGwdbq1pytRGCxHp7yV5utnAbCoy/DLZO2/nm6XwyyxjzDa0bJdwv/5NN8Qlw6E4t+dl19j70NQmAbQycq4yWnDQr0OW9s+zTvUSEPozufIqyMhP9KFNJv1SFgiFNjuH1m80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784048002; c=relaxed/simple;
	bh=Kwca1EfMkdOmMj2biLs2iTpBiSi5xSUNWaiUtEKRemo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g49iohtLfUU6AvSqWZpZwltbU4E99IQVUVVnH0SxY5EXIOskZ/0Mzsh9QDoFm+UnkCt0NYmJNYgWjDE5kjIRJ6aZsceB4BOqsVuzCvTTyjMtIvsL3TuQeP8K/gWVJAgdZgT8xxrALnxgL60iHggO1eNlw+dqZTJqrNHPb80hm9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iQPFb80Y; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iQPFb80Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784048001; x=1815584001;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Kwca1EfMkdOmMj2biLs2iTpBiSi5xSUNWaiUtEKRemo=;
  b=iQPFb80Y/TxdWsyDagU+twl8yzbFJ61vYiWVzsdRl2+U+jV8KrTaPisT
   lXK7ZKpKp6e+VDPmlGyr6kl0Sbw/6LXG2BcArTE0nFHy7bDs+Evm5yyrw
   7Yjy5h5ZGlZB9PAIWi9LIHph1oRI6K+y7RUyl80Gv0U7M2s+qFMc7I9zk
   G/NgrfcXw6yDN/OGsQ94P4HjYNXFbgW4GsKT8k1PtIZrjgkOlX6/OA2mH
   7ndhoy9Qr05Zy4nkqVN5PpMIk9ZyaHTlT47Hir1W7jdc1hCnS/X05racQ
   h5tYA9slvq6ga+/iBJyt28HxW7KIkjlSbesDYISri5D3dcRd1yB2+b1LK
   A==;
X-CSE-ConnectionGUID: DHB1g05RR+OyO/YDkfhhkQ==
X-CSE-MsgGUID: jaBq74DiQR+z+bqg2fkG0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="95822473"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="95822473"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 09:52:59 -0700
X-CSE-ConnectionGUID: my7c9dLRTEe578d827svBQ==
X-CSE-MsgGUID: 4Jqe6QeuQOmyIVIfuTrY8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="255412649"
Received: from aschende-mobl.amr.corp.intel.com (HELO [10.125.108.131]) ([10.125.108.131])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 09:52:59 -0700
Message-ID: <27593d55-9f43-430c-bd78-19edba356919@intel.com>
Date: Tue, 14 Jul 2026 09:52:58 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl/port: Restart port enumeration when a sibling adds
 the dport first
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>,
 Dan Williams <djbw@kernel.org>, Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org
References: <20260714020438.1822669-1-alison.schofield@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260714020438.1822669-1-alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/13/26 7:04 PM, Alison Schofield wrote:
> Endpoint probes can race while enumerating a shared switch. If a
> sibling probe adds the dport first, the losing probe finds the dport
> already present, gets -EBUSY, and fails to enumerate the endpoint.
> 
> Treat this race the same as the existing port-created case by
> restarting the port walk, allowing it to find the existing dport
> and continue enumeration.
> 
> This race was discovered while testing a cxl_test mixed-granularity
> topology, where twelve endpoints behind shared switches are probed in
> parallel during module load.
> 
> Fixes: 4f06d81e7c6a ("cxl: Defer dport allocation for switch ports")
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Applied to cxl/next
a623128bc2a1

> ---
> 
> Changes in v2:
> - Commit log: note that race is btw different dport add paths for the
>   same shared dport (Ming)
> 
>  drivers/cxl/core/port.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 1215ee4f4035..65f2d2f1eb00 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1749,8 +1749,8 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>  					     parent_dport, uport_dev,
>  					     dport_dev);
>  		if (IS_ERR(dport)) {
> -			/* Port already exists, restart iteration */
> -			if (PTR_ERR(dport) == -EAGAIN)
> +			/* Port or dport already exists, restart iteration */
> +			if (PTR_ERR(dport) == -EAGAIN || PTR_ERR(dport) == -EBUSY)
>  				return 0;
>  			return PTR_ERR(dport);
>  		}
> 
> base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482

