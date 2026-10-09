Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64695459AE0
	for <linux-cxl@vger.kernel.org>; Fri,  9 Oct 2026 23:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791586810; cv=none; b=mwB4qAeBfahEhTW4x87quIFdu/fk2vrK50gRPWJgs8njFvre9D+YoIW1mXrTFK2MNyW/fb2bz5qp4RshmgjZhYu1kk6+/I2gyLgauhvFI8HvaFxJ6PsBoSsH8v0GsZqad69ovfbB0my/iuGJOwodLBZQtY0fbNhHvYUVAjqSsfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791586810; c=relaxed/simple;
	bh=XULM4N0jjS0o1EsZh1FKXK8x8+76nRkq/gp2e8BAzt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fgp8eq+/NramUObPmSyIZ2nPcBIM1A3L61BzXWpOyfxVewGNskzMYTDouocMlav5fSye3Wz/BYZ01U3Vy1dsfYkCMHt40UucrWZNG3pzyOlVdeyTU5crsfN3WSVhN+3fH9b0jyzxEbW2HtErdLunT2M9g2PDsj3NfiEtxil/UlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tt+zbFcI; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tt+zbFcI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791586810; x=1823122810;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XULM4N0jjS0o1EsZh1FKXK8x8+76nRkq/gp2e8BAzt4=;
  b=Tt+zbFcIPlzRFKEHe98fVCa4IqA+n0P/66MtBf5ftIeO2GtzwGJP/Fib
   IAQSYVMvYKgvOgfdqy/Om3c+kwkN9sI9j3DT0ES556VbdvKC7L0+CCN1w
   4Q8q1fteuPHgWxbVBGuhyd9L1pQOgDCpuN/RYZf/hpigKienOze/si+sB
   x21iPYFCvU7VcbOTvlH6wzgHnYMCMPszmp7aEsK/iRKp/vdFnDJgSlhr2
   YlUT6+4t2Ot3yUGCzQQZNaZ652+T4STAH5UlT2AzP5rDdtTuwXAeRh+Wg
   9H9KYMNa9twTX1vx2+Rc4oirLDs8EqidMg9wRBIpo3/PjrnlA2UCn2RHw
   g==;
X-CSE-ConnectionGUID: Zfw2s16ET6Kd0QH6dM1qVA==
X-CSE-MsgGUID: OmejedICTTKxOSqOVxhmqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="291334"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="291334"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 16:00:09 -0700
X-CSE-ConnectionGUID: sfuMWSUjQoSQxYMrrGXRfg==
X-CSE-MsgGUID: SOr+2ThsQGC3Vfdz1kiAJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="409021"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO [10.125.109.123]) ([10.125.109.123])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 16:00:08 -0700
Message-ID: <4ab497e5-f407-41b7-aa7e-94192b35cb62@intel.com>
Date: Fri, 9 Oct 2026 16:00:06 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] tools/testing/cxl: Preserve DPA skip across mock
 decoder reset
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>,
 Li Ming <ming.li@zohomail.com>, Richard Cheng <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
References: <cover.1791582353.git.alison.schofield@intel.com>
 <6885e00e91e676dddf0de71722d16c8ad4dfe52e.1791582353.git.alison.schofield@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <6885e00e91e676dddf0de71722d16c8ad4dfe52e.1791582353.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/9/26 3:11 PM, Alison Schofield wrote:
> Mock decoder reset clears the DPA skip before releasing the decoder's
> resources. This leaks skipped capacity and can cause a later DPA
> allocation to fail with ENOSPC.
> 
> Preserve the skip until the DPA resource is released.
> 
> Assisted-by: LLM
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Richard Cheng <icheng@nvidia.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  tools/testing/cxl/test/cxl.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 62bd92b3be45..aa140307e0c3 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -913,15 +913,13 @@ static void __cxld_registry_save(struct cxl_test_decoder *td,
>  
>  		cxld_copy(&td->cxled.cxld, cxld);
>  		td->cxled.state = cxled->state;
> -		td->cxled.skip = cxled->skip;
>  
> -		if (!(cxld->flags & CXL_DECODER_F_ENABLE)) {
> -			td->dpa_range.start = 0;
> -			td->dpa_range.end = -1;
> -		} else if (cxled->dpa_res) {
> +		if ((cxld->flags & CXL_DECODER_F_ENABLE) && cxled->dpa_res) {
> +			td->cxled.skip = cxled->skip;
>  			td->dpa_range.start = cxled->dpa_res->start;
>  			td->dpa_range.end = cxled->dpa_res->end;
>  		} else {
> +			td->cxled.skip = 0;
>  			td->dpa_range.start = 0;
>  			td->dpa_range.end = -1;
>  		}
> @@ -1001,7 +999,6 @@ static void mock_decoder_reset(struct cxl_decoder *cxld)
>  			to_cxl_endpoint_decoder(&cxld->dev);
>  
>  		cxled->state = CXL_DECODER_STATE_MANUAL;
> -		cxled->skip = 0;
>  	}
>  	if (decoder_reset_preserve_registry)
>  		dev_dbg(port->uport_dev, "decoder%d: skip registry update\n",

