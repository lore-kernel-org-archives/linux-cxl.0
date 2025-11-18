Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EF01F463E
	for <linux-cxl@vger.kernel.org>; Tue, 18 Nov 2025 22:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763506165; cv=none; b=JkBlUj0i6Pqn3KgMP/XR4RkD+d77wDxoNqY8NWd7WeSb8vK/YNRwV159nL9GHLICqEjuyQ5ed9uNgrG7i8cy+Sfb0BNdCiDCT8d5wKUrmD2qxeObTSK+TsK+q3ONTM9MCTb/6gbWjTdZTA8YqYshkBr29vPiWorB9WddErBV408=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763506165; c=relaxed/simple;
	bh=Bq7sdJeXu3pfJJI0pa/+ydbcRo99/Yp14lm6TetXMRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jaN9CKq5mGNLxC4dHBi3jYqS4pfMJqXo/kEnvryHV3wUGO28+GB5lJvorzJLctISY7/J6ERRsDbEcNxyUohaP9xeL0C9mwmNMiGMb2ZYcPtBfq0pSLYAqnmyufsTzYN5Sg49SyccPCDC6+Apm0LwUZ5UjsAdI09kCpd5iTaKo0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GNsvB3UQ; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GNsvB3UQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763506163; x=1795042163;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Bq7sdJeXu3pfJJI0pa/+ydbcRo99/Yp14lm6TetXMRI=;
  b=GNsvB3UQkWOF53uRTvwvrxzbah6+j08i0dwt2mw07P+igm4dsMLu4a+T
   LU6EcBwHnG65gel2MbD+uYcwDBbV0+OOtj6cq6C3vvl25TbfApZPDp0+y
   LpsIxl/7Ix2Hm+xNpjA/MDEpmae4orLPNGUTUPMu6ymaLI7bb0QYo5/dX
   l96Gr6uGL0VsAi55TE8fMrwpwRv+6HT7f5pb6bDlnAEv1CNTuYjJxpfr5
   T7hAxI4i/LU5tpe6gsIkFKWD1qQtt8/dcGpzO5FI6I0/oDFCQlkUhAvWT
   1gJO2sdi1XoGdawI4W7cnS6dEwoKzb11LnXGs1NXiJVfXqKdRdFxNsz1J
   g==;
X-CSE-ConnectionGUID: JxbF4K/bQ2GCfGimYgZJeA==
X-CSE-MsgGUID: 24ar9VYkRdWtsWNbk6EbHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="65244186"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="65244186"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 14:49:22 -0800
X-CSE-ConnectionGUID: f31TRzc0QEim2Rfzi9c+YQ==
X-CSE-MsgGUID: fVRNgcolRMS/eqQdisEaew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="191321078"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.109.115]) ([10.125.109.115])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 14:49:21 -0800
Message-ID: <69c1db75-113f-40de-902e-99e00d4b46c1@intel.com>
Date: Tue, 18 Nov 2025 15:49:20 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/test: remove unused function
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 dan.j.williams@intel.com
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20251118182202.2083244-1-alejandro.lucero-palau@amd.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251118182202.2083244-1-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/18/25 11:22 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Since commit 733b57f262b0 __wrap_cxl_rcd_component_reg_phys()
> is not necessary under mocking tests.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>

Applied to cxl/next:
26c5b0d9c080 (for-6.19/cxl-misc) cxl/test: remove unused mock function for cxl_rcd_component_reg_phys()

> ---
>  tools/testing/cxl/Kbuild      |  1 -
>  tools/testing/cxl/test/mock.c | 17 -----------------
>  2 files changed, 18 deletions(-)
> 
> diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
> index d07f14cb7aa4..52736f611ea9 100644
> --- a/tools/testing/cxl/Kbuild
> +++ b/tools/testing/cxl/Kbuild
> @@ -12,7 +12,6 @@ ldflags-y += --wrap=cxl_await_media_ready
>  ldflags-y += --wrap=cxl_hdm_decode_init
>  ldflags-y += --wrap=cxl_dvsec_rr_decode
>  ldflags-y += --wrap=devm_cxl_add_rch_dport
> -ldflags-y += --wrap=cxl_rcd_component_reg_phys
>  ldflags-y += --wrap=cxl_endpoint_parse_cdat
>  ldflags-y += --wrap=cxl_dport_init_ras_reporting
>  
> diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
> index 1989ae020df3..c471400116a1 100644
> --- a/tools/testing/cxl/test/mock.c
> +++ b/tools/testing/cxl/test/mock.c
> @@ -268,23 +268,6 @@ struct cxl_dport *__wrap_devm_cxl_add_rch_dport(struct cxl_port *port,
>  }
>  EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_add_rch_dport, "CXL");
>  
> -resource_size_t __wrap_cxl_rcd_component_reg_phys(struct device *dev,
> -						  struct cxl_dport *dport)
> -{
> -	int index;
> -	resource_size_t component_reg_phys;
> -	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
> -
> -	if (ops && ops->is_mock_port(dev))
> -		component_reg_phys = CXL_RESOURCE_NONE;
> -	else
> -		component_reg_phys = cxl_rcd_component_reg_phys(dev, dport);
> -	put_cxl_mock_ops(index);
> -
> -	return component_reg_phys;
> -}
> -EXPORT_SYMBOL_NS_GPL(__wrap_cxl_rcd_component_reg_phys, "CXL");
> -
>  void __wrap_cxl_endpoint_parse_cdat(struct cxl_port *port)
>  {
>  	int index;

