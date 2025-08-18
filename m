Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D9221C9E1;
	Mon, 18 Aug 2025 22:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755557283; cv=none; b=hzKKCwe6jdEfGQKePM1VhiFEw7Op70G0eAlbyC3FxOJDOExKpqpDKlBCGkT14mNv7MtlTXBcgjvXBRZ+V8vSfd5hNP2MFYuT2z6jeLRKH2LvyYQNrT909yKDZLQm42w1QiCLNV03L7Ss6Rs/gvHDiLxPsDXYxB8ptkPEgSP71ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755557283; c=relaxed/simple;
	bh=yABuPzITeNVArb4vGkjBSmYeAjILd0FjDQGDML0bCBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vEbdLUJKHyzKCdEMiNk22ycjcvxVp9ikYWLpQmuIs5i3OSc7K5wvAWJJKWCi++P5lIFTqxmHhulxv6Z5DH2/qg2QnYBJm1eOLwUWr9I3IKyDkoJtg/GRBpplzvUbwqGIf/MNFwyE+iooOAeZEq72mQOorf8urlvBEY3tlKup+YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KN1phj01; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KN1phj01"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755557282; x=1787093282;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yABuPzITeNVArb4vGkjBSmYeAjILd0FjDQGDML0bCBA=;
  b=KN1phj01xK7p/qt/zxGla63W/iN7vsUNMO6SAwyqqiy8xXDc0SjqTd0g
   esfziZKDGJFT9c3w1uuSqzxtcBFjT3l0F1t4ybJh8FTIi2N3a2Fbr+aVL
   gyAaFokPf0ACcfLMWpUXEyNtanUqTov4lB9a+2e5CNhxAVKfHjpcAxIkM
   AhRmkslTsWxUghJYMCddmoIVuuSK5nXT2VglacoRgThERIFlnaONojHmz
   RazP3AvOWM0JEsO7SnuQoM0F+nCSvXopU4IL9JSgOI5kwFNZ5wCTTvpOm
   x/Ta6M/JRpwzNIruuZpy+h9PM/ODPIsdj3rWjoyAbEQXdXI9asXlVWZm0
   w==;
X-CSE-ConnectionGUID: CdnA/s34THeZfilCKEk1Pw==
X-CSE-MsgGUID: Dh87aD+4TMaLqqDYr7u6QQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11526"; a="45366599"
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="45366599"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 15:48:01 -0700
X-CSE-ConnectionGUID: xARAHPI0S+eJ+dA8HckXWw==
X-CSE-MsgGUID: nc/jVO4VT8mF78OAKfgplA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="198550778"
Received: from bvivekan-mobl2.gar.corp.intel.com (HELO [10.247.119.196]) ([10.247.119.196])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 15:47:54 -0700
Message-ID: <1232c1c6-5bea-4378-b3ee-041b75a87b94@intel.com>
Date: Mon, 18 Aug 2025 15:47:49 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Documentation/driver-api: Fix typo error in cxl
To: Rakuram Eswaran <rakuram.e96@gmail.com>, linux-doc@vger.kernel.org
Cc: dan.j.williams@intel.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, linux-cxl@vger.kernel.org,
 alison.schofield@intel.com, gourry@gourry.net, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linuxfoundation.org, corbet@lwn.net
References: <20250818175335.5312-1-rakuram.e96@gmail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250818175335.5312-1-rakuram.e96@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/18/25 10:53 AM, Rakuram Eswaran wrote:
> Fixed the following typo errors
> 
> intersparsed ==> interspersed
> in Documentation/driver-api/cxl/platform/bios-and-efi.rst
> 
> ---
> Changelog:
> 
> Changes since v2:
> - Fixed Signed-off-by line to include fullname
>   (feedback from Jonathan Corbet)
> 
> Changes since v1:
> - Dropped fix for page-allocator.rst as requested by Gregory
> 
> Suggested-by: Gregory Price <gourry@gourry.net> 
> Signed-off-by: Rakuram Eswaran <rakuram.e96@gmail.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  Documentation/driver-api/cxl/platform/bios-and-efi.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/driver-api/cxl/platform/bios-and-efi.rst b/Documentation/driver-api/cxl/platform/bios-and-efi.rst
> index 645322632cc9..a9aa0ccd92af 100644
> --- a/Documentation/driver-api/cxl/platform/bios-and-efi.rst
> +++ b/Documentation/driver-api/cxl/platform/bios-and-efi.rst
> @@ -202,7 +202,7 @@ future and such a configuration should be avoided.
>  
>  Memory Holes
>  ------------
> -If your platform includes memory holes intersparsed between your CXL memory, it
> +If your platform includes memory holes interspersed between your CXL memory, it
>  is recommended to utilize multiple decoders to cover these regions of memory,
>  rather than try to program the decoders to accept the entire range and expect
>  Linux to manage the overlap.

