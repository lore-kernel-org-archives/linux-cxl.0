Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1485E1DB124
	for <linux-cxl@vger.kernel.org>; Fri,  9 May 2025 15:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746805102; cv=none; b=aqkoW5Y6U8Lpyuecszt8Go2Ztv2JVkQ0CHly2gp+GU8u/h28w0bkABNbIvaLc7ld7e/FeWXYj8Oq5jILA6Zh/xwLrsgEGpnBJBRXybdpeIqlnS9lChUf6m62p5u9vgV0bFBO8gq7BbmG1ptbnqQ2NWaW7VdBnl4pqLROi5odQE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746805102; c=relaxed/simple;
	bh=Oy6l4WRJezKj6nbsbq5tfVCairUMKQnkw2W+moVl8to=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=M0uQqvGtFary2M63Lngc9ER38M0Za0MxofuQ7w/iOT/bHatkkMDwBRPVLc3fJx3YAC5g3V59WTYMJsMI6rjX8vDyk0CprsORZSTL1/W4HrIJaSRhUhEahypBPW+mlBbnhNOjXSJDXPu2F4M/utthTxwLWx1OHeJwm7PcEOVb4yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F9gKCTqQ; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F9gKCTqQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746805100; x=1778341100;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=Oy6l4WRJezKj6nbsbq5tfVCairUMKQnkw2W+moVl8to=;
  b=F9gKCTqQGp6JMP3XgPwZUXQ8ayKBacSpZf8WsYuyymmtVb8uo14BZ8IZ
   xbBxmh8/OXbDbodq4JvPXSaxkIfwBd8eT4g2qU70uvKSfwqIfxFJI60u5
   1Xztk3HTU2dtV0Nh3Zf9iq5YAOeUA1svUORVfQNrnnj8y8CylDeqKKdrV
   VDvzwInQKfhIc/V9UWsLyLBRuYUuvw+4q3fY+CgHoTzbzH6i+TbHie/vs
   RAEkH3Y7WemxGiLlKeYd6cjKhhLsmRmITzOcdad0Vl5Hi+Gp9HayIlwFB
   3SpNTc1oaGSA4hY2W9i0lhXizX3Q8+M1BwtG/DfB+uTbIlc/cS0HpfO+4
   g==;
X-CSE-ConnectionGUID: bi73O/btSTWhRARToHNs0Q==
X-CSE-MsgGUID: 0/Uro33gQFaQCZzJ1bIMOg==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="59983188"
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="59983188"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 08:38:19 -0700
X-CSE-ConnectionGUID: voNyt3yhSpWAGK9YHg4fzw==
X-CSE-MsgGUID: Kmu8331uS1C+yBH94qYEGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="136601135"
Received: from spandruv-desk1.amr.corp.intel.com (HELO [10.125.108.200]) ([10.125.108.200])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 08:38:19 -0700
Message-ID: <31c54b63-4d9a-4c86-b440-945e14756439@intel.com>
Date: Fri, 9 May 2025 08:38:18 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/test: Address missing MODULE_DESCRIPTION warnings for
 cxl_test
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com
References: <20250429235953.4175408-1-dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20250429235953.4175408-1-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/29/25 4:59 PM, Dave Jiang wrote:
> Add MODULE_DESCRIPTION() to address the following warnings:
> WARNING: modpost: missing MODULE_DESCRIPTION() in test/cxl_test.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in test/cxl_mock.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in test/cxl_mock_mem.o
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Applied to cxl/next
> ---
>  tools/testing/cxl/test/cxl.c  | 1 +
>  tools/testing/cxl/test/mem.c  | 1 +
>  tools/testing/cxl/test/mock.c | 1 +
>  3 files changed, 3 insertions(+)
> 
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 1c3336095923..eb36408d287a 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -1527,5 +1527,6 @@ MODULE_PARM_DESC(interleave_arithmetic, "Modulo:0, XOR:1");
>  module_init(cxl_test_init);
>  module_exit(cxl_test_exit);
>  MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("CXL test setup module");
>  MODULE_IMPORT_NS("ACPI");
>  MODULE_IMPORT_NS("CXL");
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index bf9caa908f89..32d47e3df22a 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -1909,4 +1909,5 @@ static struct platform_driver cxl_mock_mem_driver = {
>  
>  module_platform_driver(cxl_mock_mem_driver);
>  MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("CXL test mem device mock module");
>  MODULE_IMPORT_NS("CXL");
> diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
> index af2594e4f35d..6147f0966ffd 100644
> --- a/tools/testing/cxl/test/mock.c
> +++ b/tools/testing/cxl/test/mock.c
> @@ -312,5 +312,6 @@ void __wrap_cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device
>  EXPORT_SYMBOL_NS_GPL(__wrap_cxl_dport_init_ras_reporting, "CXL");
>  
>  MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("CXL test emulation module");
>  MODULE_IMPORT_NS("ACPI");
>  MODULE_IMPORT_NS("CXL");

