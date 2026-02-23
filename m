Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C88537D11D
	for <linux-cxl@vger.kernel.org>; Mon, 23 Feb 2026 23:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771887964; cv=none; b=bTUHO6oi/t2V4RJwUlv6DKJIEfIqPKW84J7otok0CtF5puL2uIxlxORykGwOxC35ET4bU2pFUiiMOG3s4gZIVIzwXO1rw76o2nriHVxJjNRbjsLDS9W/Sf9+O8FEvpLIF9QuSE1BRh4RHxHt2Kux2C1oc0/kPcBxMtneKETkrdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771887964; c=relaxed/simple;
	bh=bMxnpOmJ/i7kbFRWDrfQlqFrU/6L1/+p2Ubt2m6aDmE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AQHmEa32Uu/Y1MTHsOaVSGSzUGFhA1E6+tdbZ2gwHt34TaUDkX5ZtTaCcIa9YaN3u7mhp4AOdduD/9JGxB9gbl7rUXeNA7IAoEpdTyvJB/HhNt+8d50hkeaP54kCyd0GBqoqCQOFLPU+Tyb27UQKHBcY46APrlU1HYrvTN26wBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N0c2iGa/; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N0c2iGa/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771887964; x=1803423964;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bMxnpOmJ/i7kbFRWDrfQlqFrU/6L1/+p2Ubt2m6aDmE=;
  b=N0c2iGa/q4lkpfxSO7p8dLi89/bQyLa6/qOxfMwsaqHtikQitw9k3+h4
   n8upoY810iPD/g91exLLt1G2rzvApFSnEGSboquHf5606Nexp5rAbCi30
   exnnKbc2wqj3QEViaENFPMWNv3hJJ0nJnZsN+EzaQUIGvT1oM7pGdfjcr
   fjcS3oQG4XfKvL9AlHfJd0ThTqCjX6J5TwiuTlcO68zHDLP8uj0Htptdj
   FwI4wrOkaGhPjYJ15FA1Iw2DTDWPnp2R0ruu3brF1f40l2MsTeOMXxg6q
   hbiKmQPfN3r/HDSatXcRgr7g6cB1U3AYFmY6L7ljqIVZ+fH5BPClQZsaf
   g==;
X-CSE-ConnectionGUID: SVyf0hlqReqIJRLGsLW4eQ==
X-CSE-MsgGUID: WI3RySZqRZqSnKB4y4Y+iw==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="72601014"
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="72601014"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 15:06:02 -0800
X-CSE-ConnectionGUID: yiS6mY7GR8OIGGAhir2JJw==
X-CSE-MsgGUID: ytBpcFWoRHeunpsT1BtOrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="215563998"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.110.227]) ([10.125.110.227])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 15:06:01 -0800
Message-ID: <88e86d01-e328-448e-b824-d41ed61644bd@intel.com>
Date: Mon, 23 Feb 2026 16:06:00 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] cxl/region: Test
 CXL_DECODER_F_NORMALIZED_ADDRESSING as a bitmask
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
References: <98851c4770e4631753cf9f75b58a3a6daeca2ea2.1771873256.git.alison.schofield@intel.com>
 <63fe4a6203e40e404347f1cdc7a1c55cb4959b86.1771873256.git.alison.schofield@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <63fe4a6203e40e404347f1cdc7a1c55cb4959b86.1771873256.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/23/26 12:13 PM, Alison Schofield wrote:
> The CXL decoder flags are defined as bitmasks, not bit indices.
> Using test_bit() to check them interprets the mask value as a bit
> index, which is the wrong test.
> 
> For CXL_DECODER_F_NORMALIZED_ADDRESSING the test reads beyond the
> flags word, making the flag sometimes appear set and blocking creation
> of CXL region debugfs attributes that support poison operations.
> 
> Replace test_bit() with a bitmask check.
> 
> Found with cxl-test.
> 
> Fixes: 208f432406b7 ("cxl: Disable HPA/SPA translation handlers for Normalized Addressing")
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Applied to cxl/fixes
ebd11be59f7421e4b1ea19eaa8102d17ade3d6c6

> ---
> 
> Changes in v2:
> Split patches to align w Fixes Tags for backport ease
> Rebased on 7.0-rc1
> 
>  drivers/cxl/core/region.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 780ec947ecf2..42874948b589 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1105,7 +1105,7 @@ static void cxl_region_setup_flags(struct cxl_region *cxlr,
>  		clear_bit(CXL_REGION_F_NEEDS_RESET, &cxlr->flags);
>  	}
>  
> -	if (test_bit(CXL_DECODER_F_NORMALIZED_ADDRESSING, &cxld->flags))
> +	if (cxld->flags & CXL_DECODER_F_NORMALIZED_ADDRESSING)
>  		set_bit(CXL_REGION_F_NORMALIZED_ADDRESSING, &cxlr->flags);
>  }
>  

