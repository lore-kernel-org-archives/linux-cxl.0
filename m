Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573FC28F921;
	Thu, 10 Apr 2025 20:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744315408; cv=none; b=N90LNTjx0ADqvAdvSu1sNVvqRVNnyOFuyH2O6m7JvUo/AdyF6+7aOmmqJSQDIqBsszt5NfnJATzrvKACcV4KqhEF7lwzJofrLOY9b60YP0Jrp30ekML+6MrnyLz2Plps2LNz2ZpUd5yydnn1Do85q5tVotYPcQjndnIiAq1xwjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744315408; c=relaxed/simple;
	bh=6I2wEvgWN/nAwS9ia0rQUktsJxdypgPlQaQpr2sul5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b+/FT9Ccj3jH40p6c7l8KqtC3vL+bZ8QxCT8+tt2YcO0NCmpX60Q7MiE+NcjnCi5d4FBqceoCVycEmvoEYR/zKHCxEig+xlTN7/z500EG+0dsr9+ThcBmvxtT6HpztWzBnQMb1H7RpKqMGNr59UvESKN6OpRDdg+1uypfqcko8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U09W/XO+; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U09W/XO+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744315403; x=1775851403;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6I2wEvgWN/nAwS9ia0rQUktsJxdypgPlQaQpr2sul5A=;
  b=U09W/XO+ZW378Qa4NlspOPGw1j3zAWRS2/roR6q9oS0lLxMhL8RUVmcA
   YZZ6Fu9s4ZzIlUbIVkGGgSHTTqb3Msf5oQqJ4QDiRWXgEoP5o7Yj30b8m
   XZe8ZxoRjxRiEXvUpsLR8DhU/3yERsktr5A6aQOd9f5dbOYhejoRKoXmb
   GYNKhgMUKAyUSseh/VofkEDnzsRdmiF8aavimeLSATrpjn3gujcDInfmp
   IRGbmAGS2AzOwBSyZP/LnxZLTaKrshvXM9JNwhhZYJmu+WoMPFwEATaH/
   PTQGYgqKzU3lGTgfFmT9Z3KP8FVzbYq5fJ452ZZdomzsNttI+9t2MjDDO
   w==;
X-CSE-ConnectionGUID: PWqKmMDcRA+1812yz+mnhw==
X-CSE-MsgGUID: fbkoZQIETOOxqYK6b1CRzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="46022073"
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="46022073"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 13:03:22 -0700
X-CSE-ConnectionGUID: WA0qHErlTRWGto6Q+T1OJg==
X-CSE-MsgGUID: 11P1ptEpTVC6HOIFk2+NKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="128866525"
Received: from iherna2-mobl4.amr.corp.intel.com (HELO [10.125.108.92]) ([10.125.108.92])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 13:03:21 -0700
Message-ID: <2814b3c2-47fc-447c-a6ab-dcb84cffe46b@intel.com>
Date: Thu, 10 Apr 2025 13:03:20 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] fwctl/cxl: Fix uuid_t usage in uapi
To: Dan Williams <dan.j.williams@intel.com>, jgg@nvidia.com
Cc: "Paul E. McKenney" <paulmck@kernel.org>, kernel test robot
 <lkp@intel.com>, linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
References: <174430820360.604341.2116516906072729788.stgit@dwillia2-xfh.jf.intel.com>
 <174430961702.617339.13963021112051029933.stgit@dwillia2-xfh.jf.intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <174430961702.617339.13963021112051029933.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 4/10/25 11:27 AM, Dan Williams wrote:
> The uuid_t type is kernel internal, and Paul reports the following build
> error when it is used in a uapi header:
> 
>     usr/include/cxl/features.h:59:9: error: unknown type name ‘uuid_t’
> 
> Create a uuid type (__uapi_uuid_t) compatible with the longstanding
> definition uuid/uuid.h for userspace builds, and use uuid_t directly for
> kernel builds.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Reported-by: "Paul E. McKenney" <paulmck@kernel.org>
> Closes: http://lore.kernel.org/f6489337-67c7-48c8-b48a-58603ec15328@paulmck-laptop
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202504050434.Eb4vugh5-lkp@intel.com/
> Fixes: 9b8e73cdb141 ("cxl: Move cxl feature command structs to user header")
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
> Changes since v2:
> * Drop the tinkering with __align_of__ and just document the safety
>   rules (Jason)
> 
>  include/uapi/cxl/features.h |   21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/include/uapi/cxl/features.h b/include/uapi/cxl/features.h
> index d6db8984889f..490606d7694b 100644
> --- a/include/uapi/cxl/features.h
> +++ b/include/uapi/cxl/features.h
> @@ -8,10 +8,19 @@
>  #define _UAPI_CXL_FEATURES_H_
>  
>  #include <linux/types.h>
> -#ifndef __KERNEL__
> -#include <uuid/uuid.h>
> -#else
> +
> +typedef unsigned char __uapi_uuid_t[16];
> +
> +#ifdef __KERNEL__
>  #include <linux/uuid.h>
> +/*
> + * Note, __uapi_uuid_t is 1-byte aligned on modern compilers and 4-byte
> + * aligned on others. Ensure that __uapi_uuid_t in a struct is placed at
> + * a 4-byte aligned offset, or the structure is packed, to ensure
> + * consistent padding.
> + */
> +static_assert(sizeof(__uapi_uuid_t) == sizeof(uuid_t));
> +#define __uapi_uuid_t uuid_t
>  #endif
>  
>  /*
> @@ -60,7 +69,7 @@ struct cxl_mbox_get_sup_feats_in {
>   * Get Supported Features Supported Feature Entry
>   */
>  struct cxl_feat_entry {
> -	uuid_t uuid;
> +	__uapi_uuid_t uuid;
>  	__le16 id;
>  	__le16 get_feat_size;
>  	__le16 set_feat_size;
> @@ -110,7 +119,7 @@ struct cxl_mbox_get_sup_feats_out {
>   * CXL spec r3.2 section 8.2.9.6.2 Table 8-99
>   */
>  struct cxl_mbox_get_feat_in {
> -	uuid_t uuid;
> +	__uapi_uuid_t uuid;
>  	__le16 offset;
>  	__le16 count;
>  	__u8 selection;
> @@ -143,7 +152,7 @@ enum cxl_get_feat_selection {
>   */
>  struct cxl_mbox_set_feat_in {
>  	__struct_group(cxl_mbox_set_feat_hdr, hdr, /* no attrs */,
> -		uuid_t uuid;
> +		__uapi_uuid_t uuid;
>  		__le32 flags;
>  		__le16 offset;
>  		__u8 version;
> 

