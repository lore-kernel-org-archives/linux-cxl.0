Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA351D54D1;
	Thu, 20 Feb 2025 21:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740086371; cv=none; b=dGKGHJI0ios266waLZAyEEypw/DSRNU1uxm44p+xHUUTTz2RM/mWq3qeq0GU76MsHgbXlOpEZRd+glpse+40eVZRktLv6UF7Zc0okq3ECCwzUCg+59Exi3ulct1Yb4RIIe6rndlN9caxrAt9HcZgwg1IuUsHDGRk1f7H+Pb2vcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740086371; c=relaxed/simple;
	bh=PKhRrbtz1qFJVXw6e0MbzGcKe/ppuQLXf39RmfDFxjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tUhp6Q3NuUned6eEPwQU81Rc1Lx4qN+wFFt8UDCDSizjc/RSNjjdQmrz834lNIwtf9hu8LxIfTmKgXdCyQdHBEnTWSW5MyJNJTQnLgIYcXToTwZn3V2DKK/Oq0jM4KEwDkmVW9w5E9Q+q7EbxzCvTa5i2/ZetvR+9FvZDLg9akc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aQKzBLOX; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aQKzBLOX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740086369; x=1771622369;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PKhRrbtz1qFJVXw6e0MbzGcKe/ppuQLXf39RmfDFxjg=;
  b=aQKzBLOXNbJQfNpWCN+iPnb8qrHfLamq5vMh/HVPMOdNEagcSKug5xpx
   3zJxYogLlHOYt9LDeUSryh1qvIy9jldiOVToDaKbP46/abjheoWAVwlVY
   BxvzxSxBV50o7wnPz+tP6gvGiXt6WZwkXlZYUta3kDkhjncbJSUxJyJhj
   Icm39T0ZuL6qNtRCEEwdB50y24LHn8qe00JRXcd8+jR68eAxsEWAa59tO
   lD7/HM6zWv+rMGucL2JnZSICv8Oo6bl5CnZAbbESZyzYFsWOO6F5u0Q3Q
   dmJ1sAc7Q//gkA0eybQHsd6LeZM69hKMWlKiDG/MXMjmy8OMoTp93db/8
   w==;
X-CSE-ConnectionGUID: sdjQSXueQyitBjpJ6Ds4vA==
X-CSE-MsgGUID: nZNkR7zPSga2c6ihNkp0jQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="51509737"
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="51509737"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 13:19:28 -0800
X-CSE-ConnectionGUID: mqys3csGR7WKxyHX6ssCxw==
X-CSE-MsgGUID: +6KhEhXLREKxO+KQ7a0Cjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="114887647"
Received: from puneetse-mobl.amr.corp.intel.com (HELO [10.125.110.112]) ([10.125.110.112])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 13:19:27 -0800
Message-ID: <fc5ab516-3b73-4c6f-8c21-4ad643ff3320@intel.com>
Date: Thu, 20 Feb 2025 14:19:26 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/15] cxl: Introduce callback to translate an HPA
 range from a port to its parent
To: Robert Richter <rrichter@amd.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Davidlohr Bueso <dave@stgolabs.net>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gregory Price <gourry@gourry.net>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Terry Bowman <terry.bowman@amd.com>
References: <20250218132356.1809075-1-rrichter@amd.com>
 <20250218132356.1809075-3-rrichter@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250218132356.1809075-3-rrichter@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/18/25 6:23 AM, Robert Richter wrote:
> To enable address translation, the endpoint's HPA range must be
> translated to each of the parent port's address ranges up to the root
> decoder. Traverse the decoder and port hierarchy from the endpoint up
> to the root port and apply platform specific translation functions to
> determine the next HPA range of the parent port where needed:
> 
>   if (cxl_port->to_hpa)
>     hpa = cxl_port->to_hpa(cxl_decoder, hpa)
> 
> The root port's HPA range is equivalent to the system's SPA range.
> 
> Introduce a callback to translate an HPA range from a port to its
> parent.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> ---
>  drivers/cxl/cxl.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)

With such a small change, I would fold this into the patch where you are using it. 

> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index b19ba47242c6..17496784f021 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -418,6 +418,15 @@ struct cxl_switch_decoder {
>  	struct cxl_dport *target[];
>  };
>  
> +/**
> + * cxl_to_hpa_fn - type of a callback function to translate an HPA
> + * @cxld: cxl_decoder to translate from
> + * @hpa: HPA of the @cxld decoder's address range
> + *
> + * The callback translates a decoder's HPA to the next upper domain
> + * which is the address range of the decoder's parent port. The return
> + * value is the translated HPA on success or ULLONG_MAX otherwise.
> + */
>  typedef u64 (*cxl_to_hpa_fn)(struct cxl_decoder *cxld, u64 hpa);
>  
>  /**
> @@ -581,6 +590,7 @@ struct cxl_dax_region {
>   * @parent_dport: dport that points to this port in the parent
>   * @decoder_ida: allocator for decoder ids
>   * @reg_map: component and ras register mapping parameters
> + * @to_hpa: Callback to translate a child port's decoder address to the port's HPA address range
>   * @nr_dports: number of entries in @dports
>   * @hdm_end: track last allocated HDM decoder instance for allocation ordering
>   * @commit_end: cursor to track highest committed decoder for commit ordering
> @@ -602,6 +612,7 @@ struct cxl_port {
>  	struct cxl_dport *parent_dport;
>  	struct ida decoder_ida;
>  	struct cxl_register_map reg_map;
> +	cxl_to_hpa_fn to_hpa;
>  	int nr_dports;
>  	int hdm_end;
>  	int commit_end;

