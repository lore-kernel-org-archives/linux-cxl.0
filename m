Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777B53C344C;
	Tue, 10 Mar 2026 17:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773164707; cv=none; b=VGxE+bN5V5kL6fRYrnxmfLX7roC3+8t0UE0uBVRDizDGKiGvBrtIom1yy9vAzUq/qoqXZjTXpwgF4Vfl1FV1BX0DYhxLkdLwrYT68YnyNr2JJZAJ3vT/6YIcKSxBt0XLzSCTMx6hMGLdQge7o/kj01cRXZO918CpJojKjQ7IXSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773164707; c=relaxed/simple;
	bh=zrAjDthZ4Kq4r9YPrygf3o8/fCs2tJdl3q25xZVyrho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PUytsCbd9j1B6qJjoLaTGPD51qn5q8Rg3tjUEPeFGYarMQ1nmymj1cA9z/jO6EF/heQCo19bGJGujJNyelnv010IcFVCYxEoiOEZ0CENkVeSx8IGbnyD4z/fTz3wxp7q7Sxq9l3Sc+SPbTb9wJlD1XEy0PEOahj2vHKARnUaIAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F9UK2d/S; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F9UK2d/S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773164705; x=1804700705;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zrAjDthZ4Kq4r9YPrygf3o8/fCs2tJdl3q25xZVyrho=;
  b=F9UK2d/SkQT3RDCShW7Of5Bfsky3UvaFdeuoIf+nuo6rRP7lYcW/uUBt
   laH/0kVsmhiGOfMj2JRjBlIek6I3RtHgHGwUxu97r4/Lzsm/6oQV/Qsts
   bEiW+ze+DJrXTHdbGjb9t0ToqLW6VNAC7erp8qLhtC0ZyGh4ZkV71CUfb
   WxfPgQObwK+5fQZW5bdnpC/7vWG0u+haSk5Z4VjeJVSM/uoNNuBg3GRXE
   w3TYPERIAIF64DMvAB5DjiIpnNeuTgiuo1VD55MOMjYEvHshqAXQf9uy3
   U4NI5HBzLUgF0zn0SyAX7KJir2oAwVeLIdM8qYn1hT395LLWoFb/hKNzY
   w==;
X-CSE-ConnectionGUID: 3RowMCkpTx6XBtQ2RjTfrw==
X-CSE-MsgGUID: rDkfoCk6TUKOkCp/VvCj8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="85698278"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="85698278"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 10:45:05 -0700
X-CSE-ConnectionGUID: XcSFCj1WSQKjf6Oe8WvCwQ==
X-CSE-MsgGUID: kFSs6Xf2TYK9J+CSw/NQrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="215546761"
Received: from aduenasd-mobl5.amr.corp.intel.com (HELO [10.125.110.11]) ([10.125.110.11])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 10:45:04 -0700
Message-ID: <127f99e8-f673-4cec-a573-be2257134f59@intel.com>
Date: Tue, 10 Mar 2026 10:45:02 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] driver core: Add conditional guard support for
 device_lock()
To: Li Ming <ming.li@zohomail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Ben Cheatham <benjamin.cheatham@amd.com>
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org
References: <20260310-fix_access_endpoint_without_drv_check-v1-0-94fe919a0b87@zohomail.com>
 <20260310-fix_access_endpoint_without_drv_check-v1-1-94fe919a0b87@zohomail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260310-fix_access_endpoint_without_drv_check-v1-1-94fe919a0b87@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/10/26 8:57 AM, Li Ming wrote:
> Introduce conditional guard version of device_lock() for scenarios that
> require conditional device lock holding.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Li Ming <ming.li@zohomail.com>
> ---
>  include/linux/device.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 0be95294b6e6..4fafee80524b 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -911,6 +911,7 @@ static inline void device_unlock(struct device *dev)
>  }
>  
>  DEFINE_GUARD(device, struct device *, device_lock(_T), device_unlock(_T))
> +DEFINE_GUARD_COND(device, _intr, device_lock_interruptible(_T), _RET == 0)

Can you please just squash this small change to the same patch that is using it? Thanks!

>  
>  static inline void device_lock_assert(struct device *dev)
>  {
> 

