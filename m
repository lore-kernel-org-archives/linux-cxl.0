Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0AF38551B;
	Thu, 19 Mar 2026 19:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773949109; cv=none; b=JdfUvaFbxp1ZTcAkVcBzSCEB5g0EOGJqtorxK6mgM1Z6Uz6LVeJ5EKiJ8YPS+T2TqsUnPNm9kA7qR4RjxOKE1elqszxBdiS+V4ktdD1dYn9x03sKeMVVWM/UznxZYhV03PqQ1illDKW0Mrxp9ArO1r9zFVTXULgR+YeQ0sRDCOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773949109; c=relaxed/simple;
	bh=YiPkuQ6dFBAJVz3h1COZnRhMIdto56/r+LybiYglshY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aqiQN2alWOlZfwLY+tfm0JPlk3kFkX5V+eLShIhhh4E9cQbOM1ZPj2H21TREQx5VNwJytcPq/BRryC4WtAHdrj/xynkiPOaHumfXwEWy2JBrHnM7Fu0ASOU4f9noTONkzqUdbTbI6GzGPSU7/pb5fIbsS04UHsy/RmMcqLYl56U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FM249Phy; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FM249Phy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773949109; x=1805485109;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YiPkuQ6dFBAJVz3h1COZnRhMIdto56/r+LybiYglshY=;
  b=FM249Phye4aUxx7pL1tvgiaxyaOKR+q4GsnzevUZPyZaRyqS5bGM374e
   WqCT8VuRKRolKyJm23iAMvEHcxbfHRSgm54ItoQ2xITWf9u+VvffQMIfd
   u05l+z0C0RB/wk7MA5kpm+eiF8/aYw8j5IGZhfJpmHk4xzDoTeydI5X87
   GmkNOJUq5t7zwJJJkAUVbZ1Sv/V5mqkN2ST+h/VKcj7BNXHsETp63ksIu
   3QWVlbUuzaYqANMM83Z5GCnZlgcfpyObvPEk+CyAOoGBW65n9k5NRfXrQ
   ZlEmPcJqBVH8fGx5W4X7dQPD94GsCtsOvjFw/qWbLGwIh1fjxpEIlGWij
   w==;
X-CSE-ConnectionGUID: /JIYWYIsSl69qcSBM9uIQw==
X-CSE-MsgGUID: wKnhAUszTAC0ipIoY7KmGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="86509949"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="86509949"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 12:38:26 -0700
X-CSE-ConnectionGUID: idZKjUp0RY6ozfWI/qJtRg==
X-CSE-MsgGUID: 4ESHFOJVSHKcgIfLaflrEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="227768956"
Received: from lkp-server02.sh.intel.com (HELO a51c2a36b9df) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 19 Mar 2026 12:38:16 -0700
Received: from kbuild by a51c2a36b9df with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w3JC2-000000001au-1Cvf;
	Thu, 19 Mar 2026 19:38:06 +0000
Date: Fri, 20 Mar 2026 03:36:11 +0800
From: kernel test robot <lkp@intel.com>
To: Ahmed Tiba <ahmed.tiba@arm.com>, linux-acpi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-cxl@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Ahmed Tiba <ahmed.tiba@arm.com>, Michael.Zhao2@arm.com,
	robh@kernel.org, linux-arm-kernel@lists.infradead.org,
	Dmitry.Lamerov@arm.com, rafael@kernel.org, conor@kernel.org,
	will@kernel.org, bp@alien8.de, catalin.marinas@arm.com,
	krzk+dt@kernel.org, linux-doc@vger.kernel.org,
	mchehab+huawei@kernel.org, tony.luck@intel.com
Subject: Re: [PATCH v3 10/10] RAS: add firmware-first CPER provider
Message-ID: <202603200349.vMgMwlEs-lkp@intel.com>
References: <20260318-topics-ahmtib01-ras_ffh_arm_internal_review-v3-10-48e6a1c249ef@arm.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318-topics-ahmtib01-ras_ffh_arm_internal_review-v3-10-48e6a1c249ef@arm.com>

Hi Ahmed,

kernel test robot noticed the following build errors:

[auto build test ERROR on 2d1373e4246da3b58e1df058374ed6b101804e07]

url:    https://github.com/intel-lab-lkp/linux/commits/Ahmed-Tiba/ACPI-APEI-GHES-share-macros-via-a-private-header/20260319-115432
base:   2d1373e4246da3b58e1df058374ed6b101804e07
patch link:    https://lore.kernel.org/r/20260318-topics-ahmtib01-ras_ffh_arm_internal_review-v3-10-48e6a1c249ef%40arm.com
patch subject: [PATCH v3 10/10] RAS: add firmware-first CPER provider
config: hexagon-randconfig-001-20260320 (https://download.01.org/0day-ci/archive/20260320/202603200349.vMgMwlEs-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 4abb927bacf37f18f6359a41639a6d1b3bffffb5)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260320/202603200349.vMgMwlEs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603200349.vMgMwlEs-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/ras/cper-esource.c:84:9: error: call to undeclared function 'readq'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      84 |                 val = readq(ctx->ack.addr);
         |                       ^
>> drivers/ras/cper-esource.c:87:3: error: call to undeclared function 'writeq'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      87 |                 writeq(val, ctx->ack.addr);
         |                 ^
   2 errors generated.


vim +/readq +84 drivers/ras/cper-esource.c

    75	
    76	static void cper_esource_ack(struct cper_esource *ctx)
    77	{
    78		u64 val;
    79	
    80		if (!ctx->ack.present)
    81			return;
    82	
    83		if (ctx->ack.width == 64) {
  > 84			val = readq(ctx->ack.addr);
    85			val &= ctx->ack.preserve;
    86			val |= ctx->ack.set;
  > 87			writeq(val, ctx->ack.addr);
    88		} else {
    89			val = readl(ctx->ack.addr);
    90			val &= (u32)ctx->ack.preserve;
    91			val |= (u32)ctx->ack.set;
    92			writel(val, ctx->ack.addr);
    93		}
    94	}
    95	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
