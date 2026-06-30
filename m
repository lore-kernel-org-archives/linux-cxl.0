Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970013451A6;
	Tue, 30 Jun 2026 16:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782836300; cv=none; b=dVjGQKxfL+uqAGmdp9w3ugvMHYxSBDMfZB9iuNT4JR9cFykYbqWkDnmV1HaZWsb500F66swIERVhoeavA70j/Y+SKZ03f05C3vfPOlBq/53kCoI+5eqTjQQrfl4Gux7xKhz3NccRw8qesb6K248d1Z9DOX6vllcKPt911Au7lxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782836300; c=relaxed/simple;
	bh=5ZTUtTYrWNugkzAoI9xi1TOefxCcgmeJKi4qT/lZ76I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rpTaYx62Easue/wL8jtOWKf+HBpbAx07ke4ccNKnTUePfOv/Yxm6vTjyHeZVDs7qIDWfsXq+T/NrX0sfAKuJovU0e7s02AL7+Rrtbzhf3KrcV1IqMxHUNxMsafMDvecrtT8vzH/bwpsVI2LP6FAeOxtuAAtKm7Otfj2PXKikVOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XxbZ3NK8; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XxbZ3NK8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782836295; x=1814372295;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5ZTUtTYrWNugkzAoI9xi1TOefxCcgmeJKi4qT/lZ76I=;
  b=XxbZ3NK8FEQM3sQIp4ZkJfMzVmSoO4LRe/xTS3dSM//82wi4rus9451W
   LVeUASVoHmj3bO2Um9qyHZeadOpsMo88+hUnG7FKh5bowv3z9/MG1JYVJ
   kjYWeVensGIIe61tS61JzouQDcGM49r67WuPDIk5+BwuemCCSoy3KL/k4
   BwkYOyFL7slYLFKbVIAxBpgN5bPmVFHyFG+oouy+NojOxOo9O+57Ab86m
   yoZuX60CfyrVjZCu9BOqZHbHcsBor5p09/Qu9Adjbi0etAWPs6s72GCaF
   5Q7x/MvKpoBWDWzKJ+5tSD7eLdOeZYwLGT9ZIcO+vgapUWNJgslfQDzdv
   Q==;
X-CSE-ConnectionGUID: UBg3CM0yQLa3X9aTFfDb9Q==
X-CSE-MsgGUID: PavQsTxqS7ytzAW46hanrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="82544492"
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="82544492"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 09:18:14 -0700
X-CSE-ConnectionGUID: OObtITKbR7y1N2wiRRvaRw==
X-CSE-MsgGUID: wmfycMl8Tk6M+1KfIWHlbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="257223215"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.109.254]) ([10.125.109.254])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 09:18:13 -0700
Message-ID: <a21cc48d-b676-4477-810f-889620a36712@intel.com>
Date: Tue, 30 Jun 2026 09:18:12 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 1/1] acpi/hmat: preserve hmat_adist_nb notifier
 block
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 linux-acpi@vger.kernel.org, rafael@kernel.org
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20260630143507.30193-1-alejandro.lucero-palau@amd.com>
 <20260630143507.30193-2-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260630143507.30193-2-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/30/26 7:35 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Remove __meminitdata from hmat_adist_nb declaration preserving it even
> when CONFIG_MEMORY_HOTPLUG is not set. Otherwise further notifier
> registrations using register_mt_adistance_algorithm() will find a
> notifier chain likely corrupted. This is the case when a CXL Type2
> driver will load after kernel initialization and a CXL region created from
> its committed HDM decoders registers an mt_adistance_algorithm notifier.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/acpi/numa/hmat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> index 9792dc394756..3006789ae31f 100644
> --- a/drivers/acpi/numa/hmat.c
> +++ b/drivers/acpi/numa/hmat.c
> @@ -995,7 +995,7 @@ static int hmat_calculate_adistance(struct notifier_block *self,
>  	return NOTIFY_STOP;
>  }
>  
> -static struct notifier_block hmat_adist_nb __meminitdata = {
> +static struct notifier_block hmat_adist_nb = {

Maybe do something similar to __init_or_acpilib in include/linux/acpi.h?

>  	.notifier_call = hmat_calculate_adistance,
>  	.priority = 100,
>  };

