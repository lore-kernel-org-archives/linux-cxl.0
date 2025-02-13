Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601761547F5
	for <linux-cxl@vger.kernel.org>; Thu, 13 Feb 2025 17:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739467751; cv=none; b=RepySkO6H+ZNpCwdF0NBY39hEY4QU8MsqqxczfqbW71pCHHfQdNaXrKayIxBagPDgeeqNdvvboUSMNTKlyj9ZRxnxNppOpRrC+3Hk6VJAHjh3Q2s8Hl6s6XxnR5NrCLsyvsT7HI9zifauo+t81hHGCrdyXajbuLp/1tBkweaHNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739467751; c=relaxed/simple;
	bh=OKBVsaUK6MwFz+3yZTAcVuDkO3IKjBT/8uCn+AuMGJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qT8kk+mWvurCbCc8/cs6Aw2wcOiyqWUQWx+w9y5dJCmcDhm2qAO+44VVCEJZQ37cq7LFixwIQW+EXi8i/a6MWQgg+NbCLabFqBkODGcnD84jq9NV2w1aVdc7Gi6G9cF/cxriMG1O04MRr7nrhY8R7+XncCRq9Cph7NX21KFW/Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MIDIZ8U7; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MIDIZ8U7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739467750; x=1771003750;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OKBVsaUK6MwFz+3yZTAcVuDkO3IKjBT/8uCn+AuMGJc=;
  b=MIDIZ8U7vEtoo0c1/D9qgj+KK0tLDk9TIkixUQMJTripiiU6Asv1PV5F
   +Sm8v0+JuA5HDg28026ZybIJol8UnGNybzimbHIBlP9+IN5LWDRFYAqJ9
   64wyFpcHgxs83H1jPcF15rtj3frqdLw9t/A/UgSdMThPzN0yiQB9FBAg5
   7ji9lzt6idRx18nJkUFVOa7k9QlhvmvT7yujqGvAJKBP6jhtnCrHbZuy6
   lIWo57S5HPPyFzNje0y4TuLFg2YFIb0nheLkiOxauhZTU6ZJJJUspaiHG
   Ma82biwN2xPu/AL/tFJI+9KwWKd9D6NFXc1HOHadJp1V3uW2+TFOPGOXk
   Q==;
X-CSE-ConnectionGUID: +PC48YtrT6GtH08H/7p+Sg==
X-CSE-MsgGUID: B3dpdjblQd+ViUZmh104cw==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="43021158"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="43021158"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 09:29:09 -0800
X-CSE-ConnectionGUID: XLVIS2VYQa2b6KYLRDVb5Q==
X-CSE-MsgGUID: lTY3uO2eQpi7JN6rmKidtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="112953047"
Received: from ldmartin-desk2.corp.intel.com (HELO [10.125.108.200]) ([10.125.108.200])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 09:29:08 -0800
Message-ID: <4660a266-0feb-483d-8038-4842589da030@intel.com>
Date: Thu, 13 Feb 2025 10:29:05 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/15] cxl: Add support for FWCTL get driver
 information callback
To: Jason Gunthorpe <jgg@nvidia.com>, Saeed Mahameed <saeed@kernel.org>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com, ira.weiny@intel.com,
 vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net, shiju.jose@huawei.com,
 Li Ming <ming.li@zohomail.com>
References: <20250211182909.1650096-1-dave.jiang@intel.com>
 <20250211182909.1650096-9-dave.jiang@intel.com> <Z60QCS6o-3VInenG@x130>
 <20250213153200.GE3754072@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250213153200.GE3754072@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/13/25 8:32 AM, Jason Gunthorpe wrote:
> On Wed, Feb 12, 2025 at 01:18:01PM -0800, Saeed Mahameed wrote:
>>> +/**
>>> + * struct fwctl_info_cxl - ioctl(FWCTL_INFO) out_device_data
>>> + * @reserved: zero
>>> + */
>>> +struct fwctl_info_cxl {
>>> +	__u32 reserved;
>>> +};
>>
>> I would add some useful info such as: num_user_features, mbox->feature_cap,
>> etc ...
>>
>> Maybe if the callback is not implemented by the fwctl driver, then fwctl
>> subsystem should make sure to return a default info struct or some zero
>> response buffer.
> 
> Yes, lets not implement an empty struct. The core should permit a
> driver to nop this
> 
> Should I add this?

I'm planning to add some information like Saeed suggested. But this may not be a bad idea to allow the driver to nop the info callback.

> 
> @@ -62,7 +62,11 @@ static int fwctl_cmd_info(struct fwctl_ucmd *ucmd)
>         if (cmd->flags)
>                 return -EOPNOTSUPP;
>  
> -       if (cmd->device_data_len) {
> +       if (!fwctl->ops->info && cmd->device_data_len) {
> +               if (clear_user(u64_to_user_ptr(cmd->out_device_data),
> +                              cmd->device_data_len))
> +                       return -EFAULT;
> +       } else if (cmd->device_data_len) {
>                 void *driver_info __free(kfree) =
>                         fwctl->ops->info(ucmd->uctx, &driver_info_len);
>                 if (IS_ERR(driver_info))
> 
> Jason

