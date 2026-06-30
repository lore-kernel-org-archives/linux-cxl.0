Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3B746AF35;
	Tue, 30 Jun 2026 16:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782835498; cv=none; b=lvA/0/wHinKEVUH7G5B8+lkXN1faaTTjQDruZqSnTtt5/SP0aDG0mbqkYM484G68+bNkx35Jx7l8ZDJxCU1hJCgenvyhC/TYIzK6Y4aHQMAdylcUzXfPwxCpqY2F1YRyz2wyNoOnFgKTYL2igSW32uFsgylI+Begf88k/b5H55Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782835498; c=relaxed/simple;
	bh=mMBy++l++k2AyLihG3DzMOzhB7+XInALpbpAtGTqojw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tJUlLPEJNTDhbmyAfqOKdR6U72WJLvvDSoy+KUNqnN0efuoHHICU6YuiMHxYr1SI7dsQUGs4iJNNU7X7cAMAN4XC0isdczPBh4r1qAM0sFP3x0IxleH/XYtT4T3HhrKbuJ4EKKrzyhmiaDnJij3hTl6RDxMETBve191jRDNBjHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EtKYu9qx; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EtKYu9qx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782835495; x=1814371495;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mMBy++l++k2AyLihG3DzMOzhB7+XInALpbpAtGTqojw=;
  b=EtKYu9qxATRJx5IeXauB8eXDspdNCMrpzo3xpLD6rtfsmdhInPUuq4Zw
   j4BKqEEZ3vvKfg32Pi2B7e24RkSAYVtlEwvoKmvhaf1IYtSZVjtEClXCV
   wvOrGZ51dH0uJtf52Y1jzowYLxJNNVzgo9ss5REwkFnIDDjnCRzYLfdza
   R8SVTZVDlpD71ut9RDv6y0K4GZxyNS+dcElmnXRNoNeBaKmpRUztulb8h
   BjSkltrddRDyTWWrjQwiwvPvBhVsEbd5X+RF5RCeE9Ta1dTBlPPT/1Ax+
   1zWfhODI4Ry5pNek8zhZqMQOhUoX4jgcxcJrbFJJjr0LF4XurKq+IbT4Q
   Q==;
X-CSE-ConnectionGUID: 0LWBJSpvQtKDWkvwDgEM5Q==
X-CSE-MsgGUID: 8TyxoDetRtqIumqtzGLteQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="86102723"
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="86102723"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 09:04:54 -0700
X-CSE-ConnectionGUID: AGX7bR/3RRaJjrNUkWlWdw==
X-CSE-MsgGUID: Bs2o9K0PQlSFtyO9OpxDKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="249672964"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.109.254]) ([10.125.109.254])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 09:04:52 -0700
Message-ID: <7fe74f0d-50d6-4aa0-800c-35a75be01eca@intel.com>
Date: Tue, 30 Jun 2026 09:04:51 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] cxl/region: Don't leak tolerated RAM -EFAULT from
 unmapped poison scan
To: Richard Cheng <icheng@nvidia.com>, dave@stgolabs.net, jic23@kernel.org,
 alison.schofield@intel.com, vishal.l.verma@intel.com, djbw@kernel.org,
 danwilliams@nvidia.com
Cc: iweiny@kernel.org, ming.li@zohomail.com, gourry@gourry.net,
 rrichter@amd.com, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 kees@kernel.org, newtonl@nvidia.com, kristinc@nvidia.com, mochs@nvidia.com,
 kaihengf@nvidia.com, kobak@nvidia.com
References: <20260630074657.43077-1-icheng@nvidia.com>
 <20260630074657.43077-4-icheng@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260630074657.43077-4-icheng@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/30/26 12:46 AM, Richard Cheng wrote:
> cxl_get_poison_unmapped() tolerates the -EFAULT a RAM partition returns
> for Get Poison List by skipping that partition, but left rc holding the
> error. If the tolerated RAM fault was the last poison query before the
> loop ended, the function returned a spurious -EFAULT and the poison-list
> read failed even though enumeration succeeded. Reset rc to 0 when
> tolerating the fault, matching poison_by_decoder().
> 
> Fixes: be5cbd0840275 ("cxl: Kill enum cxl_decoder_mode")
> Signed-off-by: Richard Cheng <icheng@nvidia.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/region.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index be246fb09c99..52ba8e9e4288 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2933,8 +2933,10 @@ static int cxl_get_poison_unmapped(struct cxl_memdev *cxlmd,
>  		if (!length)
>  			continue;
>  		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
> -		if (rc == -EFAULT && cxlds->part[i].mode == CXL_PARTMODE_RAM)
> +		if (rc == -EFAULT && cxlds->part[i].mode == CXL_PARTMODE_RAM) {
> +			rc = 0;
>  			continue;
> +		}
>  		if (rc)
>  			break;
>  	}

