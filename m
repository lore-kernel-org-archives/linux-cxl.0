Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6533F36829E
	for <linux-cxl@vger.kernel.org>; Fri, 27 Mar 2026 17:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774631229; cv=none; b=UL/TPfV+4pgKoxstt6PvoC3+23MqMYtyVETaEnalzEoUxog4ZCxclMCrC/GPRZL2bjIOFalxMtyxkP3Zt/hLX+AU/PH+2QKyBKaBiT3zOgLPpaymsYC+eDu7wv6dy5iVRvbAdJzO/PyJDnIWPR5N+tdyweXpwfS3kORhHcP4sqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774631229; c=relaxed/simple;
	bh=2eKbL7xYfeVPWfGy2MlBh+ZEdyTwNLEWnxOA3MYI+d8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NN8MR1GO4/759x0hX27GhMwhW/9/QMQCFEUCv+qtZzQIQ55NXjF6GVJM6M3oHxxkvn/zzH+3rA+RMxfGCYSAP5dkRlzFGT5MC4+TFkf2TCxK/nLp7i5TqZ+aQXd7tFw93iAvIwO0gxh02zOx2IQfoCjsVYHxVDt2Ke282Wu5Tss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g6LHGIct; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g6LHGIct"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774631229; x=1806167229;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2eKbL7xYfeVPWfGy2MlBh+ZEdyTwNLEWnxOA3MYI+d8=;
  b=g6LHGIctEO0x8HVPwO3U1zeGCDMxo2Vte0LoclKI/dv2jJM0MzE5Y4P/
   hJ1NJL8YSFMhTd4/1en+YQEB0hgpBklpdHhH/UQ5Mg+FyIILvedW/+Cz3
   WSYM1UESokPI8jERuAzFguB84nPkln85b7txuMVe0o6oB2EwfK6qA2iEu
   Izysb53Q6FRwjuRYPnZxGt4zvZhXcRXxxtlxjNxZqNQqj+QMSKGeoyuga
   bjo6NGeCt4YTYCSImBz7RjrZaEA/xp0vktJ9BuHJv9yhgskyQMRqwlcZf
   u5uXXkuLr6/n2aHPvHBhTicCJQSn50lWVCFrJmJ/3argV5kVlhvc2IvwF
   w==;
X-CSE-ConnectionGUID: 4Q1wouKhQ96zoCeF+jJl3Q==
X-CSE-MsgGUID: sowvQ9eKTkCBsPO36VoPKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11742"; a="79315413"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="79315413"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 10:07:09 -0700
X-CSE-ConnectionGUID: vVguU01ESZ+tI90ciJoe/Q==
X-CSE-MsgGUID: iQwTMJ8DQYGw+mM6rXAYsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="225625326"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.110.180]) ([10.125.110.180])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 10:07:08 -0700
Message-ID: <065bdf0c-dd55-4d8e-8ba0-aac20dc8a727@intel.com>
Date: Fri, 27 Mar 2026 10:07:07 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] dax/hmem: Parent dax_hmem devices
To: Dan Williams <dan.j.williams@intel.com>
Cc: patches@lists.linux.dev, linux-cxl@vger.kernel.org,
 alison.schofield@intel.com, Smita.KoralahalliChannabasappa@amd.com
References: <20260327052821.440749-1-dan.j.williams@intel.com>
 <20260327052821.440749-8-dan.j.williams@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260327052821.440749-8-dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/26/26 10:28 PM, Dan Williams wrote:
> For test purposes it is useful to be able to determine which
> "hmem_platform" device is hosting a given sub-device.
> 
> Register hmem devices underneath "hmem_platform".
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> ---
>  drivers/dax/hmem/hmem.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
> index e1dae83dae8d..af21f66bf872 100644
> --- a/drivers/dax/hmem/hmem.c
> +++ b/drivers/dax/hmem/hmem.c
> @@ -96,6 +96,7 @@ static int __hmem_register_device(struct device *host, int target_nid,
>  		return -ENOMEM;
>  	}
>  
> +	pdev->dev.parent = host;
>  	pdev->dev.numa_node = numa_map_to_online_node(target_nid);
>  	info = (struct memregion_info) {
>  		.target_node = target_nid,

