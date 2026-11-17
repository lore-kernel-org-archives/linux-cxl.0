Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794933079;
	b=Uq8cF7tyl2kfEl9Vs1BgArwJfBDxo+9N1xF7XFi2PMSkRpCNf4BFLMoDFAdDoM7luIBu
	 AMUVOuW/PM8vahUYdAn/L/jGT5VfGNWuvskHMW56xEbMPZM7KXovSYfOgmWnKZLIzhP4Q
	 8pD36kdn2Y78RnjGNIajcPWtN/NPl8il1+AnBMy7sOQcY5NmNZ9SP5wniBd+ivmHfWjHw
	 4VIjVbxQcq3glSNJXPcb1ZRdzMC229gZxq2Lwq6eY2Oc5NNBTv30HHrjWNTyERKo9aJwr
	 1GSKIM9eST7rwdyiU0Ij3R8QUDgkGmHWMLjgL7lNa9oYqvXs+2WRq+XGZUyNy+iC2mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794933079;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=+VXloAoiQ0gKVmlWB5TAUVUEMHWEDvblznNl0gTNGCs=;
	b=zlPGYjVyBuW4zH+laMqyJgNDQ4Hw0eO+BAiyP1HFjgFQQlhS/6269ngP5TTAOPxrJDzn
	 OQsNdKRx1eeEJTfwQf3m6i+EcRSksDHEdJ6gXGvXhoyI9UtF5amVLfOZdR3lsvXX24iDa
	 3AYY6GSJDjN4z4IsrEXM39tno3DWYVpiZfo2xiy2TqZwhixL6zELHegbYS4770pXp4CaN
	 Oj1OHh/UiPS9erHplY+z4ZnarBrvb/6OR40rH5ECLw1q73HqSD2tXMCBJKOQ3rtwdePsP
	 RS0gIMU9QMKl6s7fVMvd2XuBvlmlg3+/kBV5x3uNtnmqq2ZK1+w55cuPKS12gXqWRKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gJcGmrO9;
	arc=none smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B92606A31C;
	Tue, 17 Nov 2026 16:31:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01B92606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gJcGmrO9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794933079; x=1826469079;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=khxvaBeBVsEG9PmKiSGHgC+2HMBmBWS4n5T88RawKqQ=;
  b=gJcGmrO9FRzHhw+KCj1470FYvm37SNvC3IibjV8DDdACqw4FWdRCIVzx
   +xQq/dagRtoT6RQSjpx3nKKoUsOPpl/UxENt5pwfwT41cQXnGEr/jvsrE
   qySPDhnmQf0Z3DlbBcu5qf8o2UFiQeWf9IWxc9blCWMdxcJwd5EBfytBm
   xMUhlTwwZAvSC/JZMUyG5Kie3vnXOwtrzlyk2pv5eYpCsmNI0wxz+/1jS
   RGkGUuHUJUrZLOIph6p9/5M9TdmyiV/fvKROfEy53cuIrskCacKR4lQvs
   BCM4x09G+jgL3qWOgA3V9GyNP3HbBAEtn6XusB+qG2S0Ahxh8/f6G/9+Z
   w==;
X-CSE-ConnectionGUID: 1/1Q73UDRQ+QfGgDQfTgHg==
X-CSE-MsgGUID: TUT8xpqiS461xh1jqee8JA==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3753577"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3753577"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 08:31:18 -0800
X-CSE-ConnectionGUID: YG8HmDygTtygH122z1YjJA==
X-CSE-MsgGUID: Vh+xLxQMS/yWY7bhBPBPgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="9739547"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.108.197]) ([10.125.108.197])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 08:31:18 -0800
Message-ID: <17dbc525-b3b0-4285-8062-fecf70658e0d@intel.com>
Date: Tue, 17 Nov 2026 09:31:17 -0700
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] cxl/mbox: Return success for
 CXL_MBOX_CMD_RC_BACKGROUND
To: Li Ming <ming.li@zohomail.com>, dave@stgolabs.net, jic23@kernel.org,
 alison.schofield@intel.com, vishal.l.verma@intel.com, djbw@kernel.org,
 iweiny@kernel.org, icheng@nvidia.com
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261116070938.3675205-1-ming.li@zohomail.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20261116070938.3675205-1-ming.li@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/16/26 12:09 AM, Li Ming wrote:
> In CXL subsystem, each mbox command hw return code is mapped to a
> corresponding errno value. Currently, CXL_MBOX_CMD_RC_BACKGROUND is
> mapped to -ENXIO.
> 
> However, per Table-8-208 in CXL r4.0 section 8.2.9.4.5.1, a BACKGROUND
> HW return code indicates that the command has been accepted by the
> device and continues execution asynchronously. It does not indicate a
> command failure.
> 
> Return 0 instead of -ENXIO for CXL_MBOX_CMD_RC_BACKGROUND so that
> callers do not treat a successfully started background operation as an
> error.
> 
> Signed-off-by: Li Ming <ming.li@zohomail.com>
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

Applied to cxl/next:
d9b7b42f7bb8

> ---
> v3:
> - Drop fixes tag.
> - Collect review tag.
> v2:
> - Add a reference to the relevant spec section in the commit log.
> ---
>  drivers/cxl/cxlmem.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index c401e3a1af06..cc71d7a84cdc 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -160,7 +160,7 @@ static inline struct cxl_ep *cxl_ep_load(struct cxl_port *port,
>   */
>  #define CMD_CMD_RC_TABLE							\
>  	C(SUCCESS, 0, NULL),							\
> -	C(BACKGROUND, -ENXIO, "background cmd started successfully"),           \
> +	C(BACKGROUND, 0, "background cmd started successfully"),		\
>  	C(INPUT, -ENXIO, "cmd input was invalid"),				\
>  	C(UNSUPPORTED, -ENXIO, "cmd is not supported"),				\
>  	C(INTERNAL, -ENXIO, "internal device error"),				\

