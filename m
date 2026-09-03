Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0304509F1A;
	Thu,  3 Sep 2026 20:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788466421; cv=none; b=g05b0e/xkU7TQmwBpooS9rv6aqK+nvBvIlZGrPztPRrE5GKglKo8YJ9wnAj7ylOcBvwdnVc0c2sEZek4ZdRJvSAdsjivy19n0V1uKxWBx3aVs78UNlQQQFLxdIpLULBUzGCMeVQBhOYrwHcZX8gbDTqRMc7jOr3BPaeME0LTgvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788466421; c=relaxed/simple;
	bh=b1UQFvU+V2IG2rTYiyAermvUg0b3jYe7expLdRblPRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m1MoYbODyFKyGrJzfGucF8XVkX3lWsmHnvcPTbb3QRT3i41fyqCfFOVcIyIlboTmmXHHuaW9vvZNENFVLRPfVQesMRMEETOftg4MtRK/MB7vqKclfBd0aX41bUdFdDv+oPLT86JDs0rmU+LlqMAH1AU3J4y7XNzTklR3O6RiH8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V0Rv6gUE; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V0Rv6gUE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788466410; x=1820002410;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=b1UQFvU+V2IG2rTYiyAermvUg0b3jYe7expLdRblPRQ=;
  b=V0Rv6gUEK0mFz9g/lHu7DzLTr+QLuVnOQPpUD9QkzxJMuJOXu+FWGgNL
   UodXM2hPKmQSk3GYZgHRvyPrhAwXeSFT6kkRU41mtwIwc2GM4ZxSEDKFt
   zlpVxuJ/DQyX2qCB2ica2qcb2WQlp6Rbq4f89ycGsOa2lds9OMmZMr2E4
   unxGUlCyA9sSJCBBq//JtYLWNYTw3gTEHxsdX2dzbmyFuTDwltHIj3+gW
   kzS5LkDvnEPAHFH+6rk4wRYsgVQjGLJzojXhVnTT6VbclPJRXGOnIrz1m
   pCGhWRgi6kYQ13LKc5qgG2OeCWgTiCGCGoPiSz4hBh8TQtby364GdYaa6
   A==;
X-CSE-ConnectionGUID: UYP6FwdiSl2+xWngwY4m0w==
X-CSE-MsgGUID: YEtbjnHmQvmX6y1xxqCBZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="87900229"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="87900229"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 13:13:25 -0700
X-CSE-ConnectionGUID: mDqEModVQYqnByXBVr+C9A==
X-CSE-MsgGUID: Pa5t0w73QoOXYNxPpYYMpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="269821169"
Received: from aschende-mobl.amr.corp.intel.com (HELO [10.125.110.190]) ([10.125.110.190])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 13:13:25 -0700
Message-ID: <5f10c64e-1f0d-48f7-bd6d-2373b69e7cad@intel.com>
Date: Thu, 3 Sep 2026 13:13:23 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl: docs/platform/acpi: Fix brackets
To: Manuel Ebner <manuelebnerli@mailbox.org>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260903095445.729419-2-manuelebnerli@mailbox.org>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260903095445.729419-2-manuelebnerli@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/3/26 2:54 AM, Manuel Ebner wrote:
> Add '}' and fix indentation.
> 
> Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>

Applied to cxl/next
f0f38b3d0730

> ---
>  Documentation/driver-api/cxl/platform/acpi/dsdt.rst | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/driver-api/cxl/platform/acpi/dsdt.rst b/Documentation/driver-api/cxl/platform/acpi/dsdt.rst
> index b4583b01d..73b23d82a 100644
> --- a/Documentation/driver-api/cxl/platform/acpi/dsdt.rst
> +++ b/Documentation/driver-api/cxl/platform/acpi/dsdt.rst
> @@ -25,4 +25,5 @@ Example Compute Express Link Host Bridge ::
>              ...
>              Name (_UID, 0x05)  // _UID: Unique ID
>              ...
> -      }
> +        }
> +    }

