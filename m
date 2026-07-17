Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A13191F98;
	Fri, 17 Jul 2026 21:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784323495; cv=none; b=aMzbveEpmj3NerTY/bn5syqJ/nbyFyVtAK6JmPEz+BhJZKnAFnwamDEfhCu2X3KL6nw2pO26+L8Po1uSl3RRvjPn/LcLg6HVZFJ1u14DjLHy7NFw3ijqk45E1HLo8lxRk70hftTLOWZCtCWKC0CTvo8OfUI1bSUWg/ZSjKoqqQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784323495; c=relaxed/simple;
	bh=6Xfb7449eBp+JZKcx389iRGB5O3YRM9KEG6JzaYwD5w=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=q8Kyiw0p43a+AoP8r+7szEHJ9Q3VHUA+knPykrWeZJ/vQ5NoB8IB2325IeAcs4s0eLa7S79rodu2wK8OhJPhlvL0Pfaqo9Ar6EkRw+HrO4c5gS8fPWM4jpEBcIIW80vq6WKiQZjzwi3HQ2o5+cM2WIwMp6v3Tq7+RHut9np4LdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CDbbi16m; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CDbbi16m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784323493; x=1815859493;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=6Xfb7449eBp+JZKcx389iRGB5O3YRM9KEG6JzaYwD5w=;
  b=CDbbi16mj1hb/QXOcQ0DJDGh2ornxw3HjGMv3guWcDCeOSmfEiBKh1wT
   AXismtYJpJ7jRUZcg+E2VWT46zS1FXAIWflfJsqKY/ppN3vUobohmzrGG
   ga0qpNEGVa7/mq45PVgaFQYun1H5QsRM18Ei0Is/1O9AGXm8dQ4OS9at4
   6gc4xEcFCMwKmHVj6VlEUcyEJMOoeJVjZWuYp7y08VktOE5aCXffJ13ir
   n1Oxtrx6HgVzPMECQvdoK5W43xwU3XYoTWYOE5pFJCaw4rWixuT8ec/7/
   Gj0scnDAfe+a5AIZak+b1sDMAbQvb+QYlH/ICVvq/zyIWKpNhXnodO1ll
   A==;
X-CSE-ConnectionGUID: B+N+WL6NS52svJwB6dk4kQ==
X-CSE-MsgGUID: H5yKBOM2TAmmKU8AOCY1eQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11849"; a="84128198"
X-IronPort-AV: E=Sophos;i="6.25,170,1779174000"; 
   d="scan'208";a="84128198"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 14:24:52 -0700
X-CSE-ConnectionGUID: MJxBUqElSWy3r/mwP/pebg==
X-CSE-MsgGUID: 4f5zjYI0Su+oGpW8xMQFcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,170,1779174000"; 
   d="scan'208";a="261158537"
Received: from aschende-mobl.amr.corp.intel.com (HELO [10.125.109.76]) ([10.125.109.76])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 14:24:52 -0700
Message-ID: <9bc93d02-2dbe-47cb-ae6a-54f9dd637365@intel.com>
Date: Fri, 17 Jul 2026 14:24:50 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/10] ACPI: extlog: Fix CONFIG_ACPI_APEI_PCIEAER guard
 typo
From: Dave Jiang <dave.jiang@intel.com>
To: linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org
Cc: rafael@kernel.org, tony.luck@intel.com, bp@alien8.de,
 guohanjun@huawei.com, mchehab@kernel.org, xueshuai@linux.alibaba.com,
 terry.bowman@amd.com, sashiko-bot@kernel.org,
 Ben Cheatham <benjamin.cheatham@amd.com>
References: <20260717161647.1493259-1-dave.jiang@intel.com>
 <20260717161647.1493259-8-dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260717161647.1493259-8-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/17/26 9:16 AM, Dave Jiang wrote:
> sashiko-bot flagged that a Kconfig macro typo compiles out the extlog
> CXL protocol error handling entirely.

Sashiko flagged this. It should say:
sashiko-bot flagged that a Kconfig macro typo compiles out the extlog
PCIe AER handling entirely.

> 
> The guard reads "#ifdef ACPI_APEI_PCIEAER" instead of
> "#ifdef CONFIG_ACPI_APEI_PCIEAER", so the wrapped code is always compiled
> out. Use the correct CONFIG_ prefixed symbol.
> 
> Reported-by: sashiko-bot@kernel.org
> Fixes: 95350effc3ad ("ACPI: extlog: Trace CPER CXL Protocol Error Section")

Fixes: e778ffefa34d ("ACPI: extlog: Trace CPER PCI Express Error Section")

If there are no other changes to the series, maybe the maintainer can fix this up?

DJ

> Assisted-by: Claude:claude-opus-4-8
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/acpi/acpi_extlog.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
> index ae79d090de33..1fbaf134c04e 100644
> --- a/drivers/acpi/acpi_extlog.c
> +++ b/drivers/acpi/acpi_extlog.c
> @@ -136,7 +136,7 @@ static int print_extlog_rcd(const char *pfx,
>  static void extlog_print_pcie(struct cper_sec_pcie *pcie_err,
>  			      int severity, u32 len)
>  {
> -#ifdef ACPI_APEI_PCIEAER
> +#ifdef CONFIG_ACPI_APEI_PCIEAER
>  	struct aer_capability_regs aer_regs = {};
>  	struct aer_capability_regs *aer;
>  	struct pci_dev *pdev;

