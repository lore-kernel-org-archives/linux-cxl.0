Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E844418A58
	for <linux-cxl@vger.kernel.org>; Fri, 24 Jul 2026 22:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784933310; cv=none; b=NKb/vh++rcYr7+Puq4cdfbBAspoQSDYH4qIG97XtwJVXBeNOs9sQsDJTxv7PwKR4SuP738BEVURrKKvJuNTLra8MX1e3f1p4ob57dhjV83m/4b61y8seRaBdTf+2Q+HLeoXE+Oy0UE6hIc26v4Y3mNAiWbF2sb1n+VkcKeeeQ/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784933310; c=relaxed/simple;
	bh=XeU/YPErqDjgyEz92/C5x/9CRQYSI8fHIA38kgF4A0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jxLsU95G7pywhEtXC1NKCMvX3Vh95GV86uugO6Yzoeppzb+Y/BARUThLGS8ltMxj3FoC6ulG3D2s3MKs6lLdhJ57AwdyTs1/hOURxed24odDrJEuTRdiHXt9TIPgxXqaaJGhapfrharxU4/lBAn286vLVaenMU7I60iZFpd0pR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PuslPrTC; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PuslPrTC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784933303; x=1816469303;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XeU/YPErqDjgyEz92/C5x/9CRQYSI8fHIA38kgF4A0Q=;
  b=PuslPrTC5bLDqcClrv4IGv+H1baDs9O5uJfCkNfiC287Irq2L5AF+7bN
   4GaO8BRVs0AxmNAQbRfcrmaB99nuWzG28b3BmMVzYHi0YoPDCNnXxBgq4
   IFiYLKuUhE/qhoU22hQ/MzNcsHndBRQh9Qha/JteDBNHtF5xLd9OqN8/T
   kcwKr+z3RxyM1Jg/IbeqTu13ToUV67SOSN3sObEFwFFzLKOnJBcK1BsAW
   DBsEztKdnlpEc9Mutc4uWFsF1ZuhoesP2oCkLNi/bXjqSbAB2eYJUIyyf
   vcTAT6sOAtVfJAGFEjIKfpxFKLJdYxJPMnxAIUBjP/eGgcsRN2WpfxqSM
   A==;
X-CSE-ConnectionGUID: Ea/2lcPxRaqTa+CVnj0MWw==
X-CSE-MsgGUID: U/fvalJ5TxyEtXhvhZOyzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11855"; a="85649737"
X-IronPort-AV: E=Sophos;i="6.25,183,1779174000"; 
   d="scan'208";a="85649737"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 15:48:21 -0700
X-CSE-ConnectionGUID: kLeRWjGbRU+WdDcQaZINEA==
X-CSE-MsgGUID: QCUhtz4cQCCiBDlHae5XhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,183,1779174000"; 
   d="scan'208";a="257577052"
Received: from smithj1-mobl2.amr.corp.intel.com (HELO [10.125.110.193]) ([10.125.110.193])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 15:48:20 -0700
Message-ID: <58edcca8-2a28-45fe-b5f8-87b08d22e82a@intel.com>
Date: Fri, 24 Jul 2026 15:48:19 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] cxl/region: Fix use-after-free in
 find_pos_and_ways() error path
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>,
 Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org,
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
References: <10deb519b543ef693ce23148b509a03fe1c07d0c.1784931354.git.alison.schofield@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <10deb519b543ef693ce23148b509a03fe1c07d0c.1784931354.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/24/26 3:28 PM, Alison Schofield wrote:
> The error path releases its reference to a switch decoder before
> logging an error that includes the decoder name. If the released
> reference is the last one, the decoder can be freed before the error
> message accesses its name.
> 
> Drop the reference after the error is reported.
> 
> Fixes: d90acdf49e18 ("cxl/region: Add a dev_err() on missing target list entries")
> Reviewed-by: Li Ming <ming.li@zohomail.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Series applied to cxl/next
15da704b7323
bad0aa134b64

> ---
> 
> Changes in v3:
> - Log dev_name(dev) instead of dev_name(&cxlsd->cxld.dev) (Jonathan)
> - Remove double space in commit log (Jonathan)
> Changes in v2:
> - No changes in v2
> 
> 
>  drivers/cxl/core/region.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 1e211542b6b6..6d902e1c4161 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1938,14 +1938,13 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
>  			break;
>  		}
>  	}
> -	put_device(dev);
> -
>  	if (rc)
>  		dev_err(port->uport_dev,
>  			"failed to find %s:%s in target list of %s\n",
>  			dev_name(&port->dev),
> -			dev_name(port->parent_dport->dport_dev),
> -			dev_name(&cxlsd->cxld.dev));
> +			dev_name(port->parent_dport->dport_dev), dev_name(dev));
> +
> +	put_device(dev);
>  
>  	return rc;
>  }
> 
> base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482

