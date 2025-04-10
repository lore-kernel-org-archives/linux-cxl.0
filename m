Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3170A2E62A7;
	Thu, 10 Apr 2025 21:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744320780; cv=none; b=l8Sxs7oBVI2VICRO99jVY+yXskmxD3qFkyF1pNzrLRi/cAUXTcFfs2j2aKVy2ysv9qJxfb2xA6dF6q9jj986MrBMXkQGHkfCZHlPs1TgDr7hITSA9RQwpLur6lFidSTZSfY5px46retZsmMh6wBaY3HtkhXnNVD11gtb6l+GKzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744320780; c=relaxed/simple;
	bh=H82et+KA7C3DoiZGph7TePsvX5xQzLKVxnnSZAKjOgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+otHb9BYihQ4kK2B3FMGgMXMqJjg/93EXqMXEEvO0zN1hzMl4MnFZvH/UK6TUd/ZcGiVLOM5UpqE4zSmA+8ZbaPlZ5B9qFLiIKv9h9AQOyEKmzUcqveNINMc83EqgSHkP5MJSAqvEJ7FnDm6H84qepXjz6AQ6LW9IiRbTMDwzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e7LTVUtv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7LTVUtv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91E57C4CEDD;
	Thu, 10 Apr 2025 21:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744320779;
	bh=H82et+KA7C3DoiZGph7TePsvX5xQzLKVxnnSZAKjOgM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=e7LTVUtvjihcK7lT9wD4tMt6GjrDMunK2qVeaUq6ymA0/khWcPaD1Qf9+wctrdnGL
	 Nicjq2hPYpBRSqCsjM62ROmW+sU5eprFYbgbBU7AOc1VoBSiKVx9WrgzUWgPtOb8aR
	 ain5+hSVpI8OmHYBbxuCve+ymhEPE74SpODo70/2JCpXfuyqaBhS3RgD04WxQwe8AA
	 TJl81FLPjqWyNoSwQwDuu58QwhMJiKht8SDorfIYOgMmcRaKIz4AJa35NTKERsqCVr
	 5W7r9rscmmNlPSJeSOpxU58zssUATjdG0gcHPLhv7X3rR5gODViYMHISnO3WKD5D9F
	 A1VJ2pnaXRM/w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 26167CE08E3; Thu, 10 Apr 2025 14:32:59 -0700 (PDT)
Date: Thu, 10 Apr 2025 14:32:59 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: jgg@nvidia.com, kernel test robot <lkp@intel.com>,
	linux-kernel@vger.kernel.org, dave.jiang@intel.com,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v3] fwctl/cxl: Fix uuid_t usage in uapi
Message-ID: <bbf61d5e-5141-46d3-be3f-f7221de08ca4@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <174430820360.604341.2116516906072729788.stgit@dwillia2-xfh.jf.intel.com>
 <174430961702.617339.13963021112051029933.stgit@dwillia2-xfh.jf.intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <174430961702.617339.13963021112051029933.stgit@dwillia2-xfh.jf.intel.com>

On Thu, Apr 10, 2025 at 11:27:40AM -0700, Dan Williams wrote:
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

Nice, thank you!!!

Tested-by: Paul E. McKenney <paulmck@kernel.org>

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
