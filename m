Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4202E2679;
	Mon, 11 Aug 2025 15:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754927380; cv=none; b=YZOsv5uy3Pyne2/nzgs5C1GNoU+9zGbPnPs5qmtEcrWqhB/IbhUcAT6vqSs7G6gYuaqUOBfsC98kLgLwWpQLH7TKfrH4zIyiJTAkCldQRJ2xwKd1RWW4709BZRChEazAekXVM+4YOL+2ZaNiCOUkc754cvzi1ZzZ06ZIXfrWSjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754927380; c=relaxed/simple;
	bh=wgMrhgF8BDH/NEt5vs4XIt/Kl09yLdL8h+1ZH+N5j7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h/+q3KBvzAuQmOaUx8yOhWN4rGw1d6e+iEB0T7BSXN1Xa7W04v4mSoWN9O5yG1JV5gOvn7LJdqXoaUJWNeQQKWCyjZF3g9sklWcaSsqt6zw5+sAW0V8bYLLpheApAwsoQY92cttIte820S1WY72Ln/DlJvqu6U8ka4X3lq/qU/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SjL9DHFQ; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SjL9DHFQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754927379; x=1786463379;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wgMrhgF8BDH/NEt5vs4XIt/Kl09yLdL8h+1ZH+N5j7g=;
  b=SjL9DHFQ5Nn/KpMxQZMCVrPBrDxDVNMFF9Cg+mx2CsCAMfzBscnc/m2z
   rGH85NKp15NM2C1PygVUkOeC+K0k/jy5RBkohKkQJ1yXFVAmXMRDi+8QG
   W7Qs9MIrLfdI+Arrqd6jAjnoZyQ8y3EvxgoksFGqrTKYQ/sgx6DrkSFap
   0vcfg85wngdeDrt7/N9DnxTfEgS4A7ujH+0B4TDBpR6Vo+UPj4cjYkUhf
   R0aGmO55dXswr2pCcidFThXQhW3W08xv73c4XoPwdlZSBgzCpip0/PtnQ
   aVAEREb0bFhkI9x3jcJOUTISZANkq4h8LFDSjecWGi/bPEfFX9dNvCf3p
   Q==;
X-CSE-ConnectionGUID: usoJRIk5TLucNCm/1n08YA==
X-CSE-MsgGUID: nMlnW4h+Sf2BpBHtDxhlyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="67892446"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="67892446"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 08:49:38 -0700
X-CSE-ConnectionGUID: g9gOJu8DSiif7dMUTVlDwA==
X-CSE-MsgGUID: CMRXhL6sSy+yB0mIWjutug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="189622007"
Received: from bvivekan-mobl2.gar.corp.intel.com (HELO [10.247.119.140]) ([10.247.119.140])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 08:49:33 -0700
Message-ID: <3eac5580-d618-4905-a982-a34bf11cdedf@intel.com>
Date: Mon, 11 Aug 2025 08:49:27 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/hdm: Use str_plural() to simplify the code
To: Xichao Zhao <zhao.xichao@vivo.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250811122519.543554-1-zhao.xichao@vivo.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250811122519.543554-1-zhao.xichao@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/11/25 5:25 AM, Xichao Zhao wrote:
> Use the string choice helper function str_plural() to simplify the code.
> 
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/hdm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index e9e1d555cec6..37176c0a781f 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -197,7 +197,7 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
>  	 */
>  	if (should_emulate_decoders(info)) {
>  		dev_dbg(dev, "Fallback map %d range register%s\n", info->ranges,
> -			info->ranges > 1 ? "s" : "");
> +			str_plural(info->ranges));
>  		cxlhdm->decoder_count = info->ranges;
>  	}
>  

