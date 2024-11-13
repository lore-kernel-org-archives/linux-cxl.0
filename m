Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E373869D2B
	for <linux-cxl@vger.kernel.org>; Wed, 13 Nov 2024 15:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731512480; cv=none; b=eEvC3URfYbtt48Wy90O4GkSK3WoozQb0fAtzePnseB4oavZ8TYA0WN2yEL1ORko022yY/MddbeTvzete/9kKuifBi4rzL1XKRs6B8dqS+bc06U7aPX8W+K38W2dJwMD7e1Z7BJu+exnexOqIst5eASZ890TY3YGTGOSNwPKc7gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731512480; c=relaxed/simple;
	bh=aBCI84FVCDOpgRDFVzDyzpf5zLOMjCuMV700oRIVRpY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kvm/qWRqe1xj3FD750utYtaA/kqjCvqXjcjr7ivwoPBpofdx+Fl76fAKilyG9g8inrXn9/ermJGK1Frini0hOPx64vO2Vapz5RMfOXsd91D6OGi0XevysKnBIx7RKxw88cfBJbsvWykMS2KwQoeywqb5y81KpJf/FKqVTNA663A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kqxhXo3g; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kqxhXo3g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731512479; x=1763048479;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aBCI84FVCDOpgRDFVzDyzpf5zLOMjCuMV700oRIVRpY=;
  b=kqxhXo3gyI1CakgMu4jazR04Ew5dH73ynwZZSCTbqW2IEroSubRwQ8eZ
   +SxCXcMXQlL7ciJbmXGQoka5fY/WKQorUVblxz4AcJFHzB2myitlfFrur
   365FE8dUTh6mKkJggnHuRr1ZArsI5usF2lJrTJEcCDPF7sut+vkBxiEeT
   SHPENopf6Ffd8mI7cGT78ZaxQUQ+69MmnH32zE1VGYOH2fg39g9sR96Ud
   9OaUsRGvtlotnw/7yRS3zE2tRo+v3dv2tf2ycvtK5vsfN4jR4D5lXhWKM
   1KwSz2rJCj6zSD8Et3US/QdJiSY71KuE0QFTmz7O7vn/KPmeCqOAQlVOO
   g==;
X-CSE-ConnectionGUID: GgBe2MgYSnCS+9WfiNrkNw==
X-CSE-MsgGUID: 6wlwkqpjTwWuFYu9Zs/zCg==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="48918336"
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="48918336"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 07:41:17 -0800
X-CSE-ConnectionGUID: q+nKIVnMSJ2SgK/81fBCAA==
X-CSE-MsgGUID: hYiGWFpHTSOGfgVl8py9zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="92867770"
Received: from spandruv-desk1.amr.corp.intel.com (HELO [10.125.111.237]) ([10.125.111.237])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 07:41:16 -0800
Message-ID: <240c2264-b0f2-4e8b-b6e5-89c4317d0ba0@intel.com>
Date: Wed, 13 Nov 2024 08:41:15 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 10/13] fwctl/cxl: Add support for fwctl RPC command to
 enable CXL feature commands
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com, ira.weiny@intel.com,
 vishal.l.verma@intel.com, alison.schofield@intel.com, dave@stgolabs.net,
 jgg@nvidia.com, shiju.jose@huawei.com
References: <20240718213446.1750135-1-dave.jiang@intel.com>
 <20240718213446.1750135-11-dave.jiang@intel.com>
 <20240729122907.0000540a@Huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240729122907.0000540a@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/29/24 4:29 AM, Jonathan Cameron wrote:
> On Thu, 18 Jul 2024 14:32:28 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> fwctl provides a fwctl_ops->fw_rpc() callback in order to issue ioctls
>> to a device. The cxl fwctl driver will start by supporting the CXL
>> feature commands: Get Supported Features, Get Feature, and Set Feature.
> 
> I'll come back to this in reply to the cover letter, but this is
> problematic because some of those features will almost certainly be
> covered by standard kernel drivers and if Set Feature is enabled
> those drivers will need to be hardened against the state mysteriously
> changing under them.

Do we need to have an exclusive_features mask just like exclusive_cmds to block kernel managed features like RAS? That may be the best way to deal with things happening behind kernel's back.

> 
> This corner is the bit that worries me most about fwctl in general.
> Anyhow, one for the cover letter / policy discussion not deep
> in the patch series.

Need to add a documentation patch and maybe we can put policies and rules in there?

> 
> 
>>
>> The fw_rpc() callback provides 'enum fwctl_rpc_scope' parameter where
>> it indicates the security scope of the call. The Get Supported Features
>> and Get Feature calls can be executed with the scope of
>> FWCTL_RPC_DEBUG_READ_ONLY. The Set Feature call is gated by the effects
>> of the feature reported by Get Supported Features call for the specific
>> feature.
> 
> Break the moves of error codes etc out as a precursor no-op patch to
> make review of the real guts of this easier.

ok

> 
> Trivial comment inline.
>> diff --git a/drivers/fwctl/cxl/cxl.c b/drivers/fwctl/cxl/cxl.c
>> index 22f62034c021..01f0771148e1 100644
>> --- a/drivers/fwctl/cxl/cxl.c
>> +++ b/drivers/fwctl/cxl/cxl.c
>> @@ -51,10 +51,133 @@ static void *cxlctl_info(struct fwctl_uctx *uctx, size_t *length)
>>  	return info;
>>  }
> 
>> +static bool cxlctl_validate_hw_cmds(struct cxl_mailbox *cxl_mbox,
>> +				    const struct fwctl_cxl_command *send_cmd,
>> +				    enum fwctl_rpc_scope scope)
>> +{
>> +	struct cxl_mem_command *cmd;
>> +
>> +	/*
>> +	 * Only supporting feature commands.
>> +	 */
>> +	if (!cxl_mbox->num_features)
>> +		return false;
>> +
>> +	cmd = cxl_get_mem_command(send_cmd->id);
>> +	if (!cmd)
>> +		return false;
>> +
>> +	if (test_bit(cmd->info.id, cxl_mbox->enabled_cmds))
>> +		return false;
>> +
>> +	if (test_bit(cmd->info.id, cxl_mbox->exclusive_cmds))
>> +		return false;
>> +
>> +	switch (cmd->opcode) {
>> +	case CXL_MBOX_OP_GET_SUPPORTED_FEATURES:
>> +	case CXL_MBOX_OP_GET_FEATURE:
>> +		if (scope >= FWCTL_RPC_DEBUG_READ_ONLY)
>> +			return true;
>> +		break;
> 
> return false here.

ok

> 
>> +	case CXL_MBOX_OP_SET_FEATURE:
>> +		return cxlctl_validate_set_features(cxl_mbox, send_cmd, scope);
>> +	default:
>> +		return false;
>> +	};
>> +
>> +	return false;
> 
> And drop this.

ok

> 
>> +}

