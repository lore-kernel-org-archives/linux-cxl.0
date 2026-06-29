Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB58944BCA1;
	Mon, 29 Jun 2026 16:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782749112; cv=none; b=LI+EOznvIinX9Y2uTYsDvW3yaggGAmHr6cMuVnur70ZxwdtM/nlP8o8O44WRaWYR1I4+jmKLhL4KXoSpSNi10Rqh7CAXx0Vci5HegtN0JL+CE32w7P0ArzSt/4BD0P1irJb8B4Jlf08PdG81YYm/rFn2vFX+6dmslimiF+8J3eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782749112; c=relaxed/simple;
	bh=Tf3pNDOaGQX3fSS4yLYMyAKXRyAB+gUHE/PPajsX/xA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V2RtJ93CbfrsyHQ8zD/wsnYV8iC2ePmmLgx4kpvtb+hr+HThcQdhfCm9WwoLL2FOsVSkPaTX2UGcxDIQO/Jqq2nHoFAV2TR9IAtD0NmRDKd30rd9zRzbS/Zy+NcVa6wKMtvVlIaMyH6w1o/2u/fvxQa0DltoVrZX0gbf+/HDCXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gVizzjCh; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gVizzjCh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782749111; x=1814285111;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Tf3pNDOaGQX3fSS4yLYMyAKXRyAB+gUHE/PPajsX/xA=;
  b=gVizzjChFTEy/+zxZz4xuMeoYJHXqkylFv6KuxFyLOxEVJfw2bRLzuVU
   Gecng5GLFAbpc1bILJbzyNeossVumQg0IiANH+tXYtWmF9DsAQA/w9MtG
   S5uxtL5pb+nlTYww5NwBX2sVHlWxtkft+IUtIAvYN9LUQiZKxL6HiNF3a
   VxcI3H2mrTpx8rd6c1bDmq0fM1Tz30hTE5ph7BTQSOAhgKoZ6TQeMlgEk
   oXqpJ0bLb5IKKI9ccl4EaTWJZLZhuIsq/HTQEhx2dWScKumXiO5kl0kp2
   M3gTGpbEYPiXcqXUebGNuZbGz75sVBTLeRXsGnmwEmsNe/PRqmqk7otaG
   w==;
X-CSE-ConnectionGUID: q3qiBELSTiqBWLV+OgwUUQ==
X-CSE-MsgGUID: yNY8mhLVTMWBS6FG3C7lGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="87284831"
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="87284831"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 09:05:10 -0700
X-CSE-ConnectionGUID: JV9fMw1wTLCZZx8RvZ9u9A==
X-CSE-MsgGUID: jqGgIdi9SieCM5eq8rPw/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="256917214"
Received: from bradocaj-mobl.ger.corp.intel.com (HELO [10.125.109.194]) ([10.125.109.194])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 09:05:09 -0700
Message-ID: <e6106387-9884-4dc5-9b5b-d135f32cfc3a@intel.com>
Date: Mon, 29 Jun 2026 09:05:07 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl/mbox: Clamp mailbox output allocation to the
 payload size
To: Richard Cheng <icheng@nvidia.com>, dave@stgolabs.net, jic23@kernel.org,
 alison.schofield@intel.com, vishal.l.verma@intel.com, djbw@kernel.org,
 danwilliams@nvidia.com
Cc: iweiny@kernel.org, ming.li@zohomail.com, kobak@nvidia.com,
 kaihengf@nvidia.com, kees@kernel.org, newtonl@nvidia.com,
 kristinc@nvidia.com, mochs@nvidia.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260624144147.53997-1-icheng@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260624144147.53997-1-icheng@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/24/26 7:41 AM, Richard Cheng wrote:
> CXL_MEM_SEND_COMMAND bounds the user's in.size to the mailbox payload
> size but leaves out.size unbounded, then cxl_mbox_cmd_ctor() calls
> kvzalloc(out.size). A large out.size drives a huge allocation, above
> INT_MAX it WARNs and taints, and with panic_on_warn=1 it panics.
> 
> The transport __cxl_pci_mbox_send_cmd() already clamps the response copy
> to min(out.size, payload_size, device len), so the output buffer is
> never written beyond payload_size. Clamp the allocation to payload_size
> too, matching the RAW path.
> 
> Fixes: 583fa5e71cae ("cxl/mem: Add basic IOCTL interface")
> Reviewed-by: Kai-Heng Feng <kaihengf@nvidia.com>
> Reviewed-by: Koba Ko <kobak@nvidia.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> Signed-off-by: Richard Cheng <icheng@nvidia.com>

Applied to next
8a13db9f899d

> ---
> Changelog:
> 
> v1 -> v2:
>     - Correct the Fixes tag to 583fa5e71cae ("cxl/mem: Add basic IOCTL
>       interface")
>     - Drop the reproducer and sent it as a regression test in ndctl
> 
> Best regards,
> Richard Cheng.
> ---
>  drivers/cxl/core/mbox.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 7c6c5b7450a5..d9cb02c9f72c 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -380,11 +380,7 @@ static int cxl_mbox_cmd_ctor(struct cxl_mbox_cmd *mbox_cmd,
>  		}
>  	}
>  
> -	/* Prepare to handle a full payload for variable sized output */
> -	if (out_size == CXL_VARIABLE_PAYLOAD)
> -		mbox_cmd->size_out = cxl_mbox->payload_size;
> -	else
> -		mbox_cmd->size_out = out_size;
> +	mbox_cmd->size_out = min_t(size_t, out_size, cxl_mbox->payload_size);
>  
>  	if (mbox_cmd->size_out) {
>  		mbox_cmd->payload_out = kvzalloc(mbox_cmd->size_out, GFP_KERNEL);
> 
> base-commit: ef0c9f75a19532d7675384708fc8621e10850104

