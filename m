Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F2E423785;
	Mon,  6 Jul 2026 16:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783356777; cv=none; b=WTwevkx7G9X63LxYQ5Ydlqw/q51GdiyMKmoYRZcykh99CZwK0aX+A6WjqUrrDrRdvC4BQrx/Hf35ensG3aAq16Td4O/4/H4k47wjYCD5yxKruWkLJQFE9bEXv91dzs6jK/euAS913G3ikgOCRmR3R0OXXAvDv6mpexe93E0C24A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783356777; c=relaxed/simple;
	bh=imbwlIRAHMBmLVLpsMoLZb1Q7ZWQycYLBzfYv4zy134=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FVkfL0rTv1bwIVNOIY7tG7Fzmg+AEGgyZviW/XlrTYOSh+HDQwpHEf3BgOEW7iRNGGV90ppkpSIi9b8JKyz7ild1mRi7gtzz/D7T0ndgLWQkfeNEwMwCcBYerRseA6mxgs0LrAVU8ofBcYOCuypl4gcLd+6DHqkwUEMZAhrashs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VV4+K8g+; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VV4+K8g+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783356776; x=1814892776;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=imbwlIRAHMBmLVLpsMoLZb1Q7ZWQycYLBzfYv4zy134=;
  b=VV4+K8g+nBXLKzO9zDmR6NKWcKCjx/BtP5UmyU/3dOX61HMPqQyw06kJ
   pGki38KmUSzsZsXWnDhQd6/ZDcvkusLlb55p4xMu8HwymhDkaHpYv6lr7
   Jdkp5fMyFqhezNjMmAsUM4pQ+A/x7U1IoJiwn3jyC9WNJVE5xrBYnM+e4
   RbIoLXjP1rfGCFYmUvgqw4ssjjAn5cH0SODSnqLfDSth1zXdVgadFiWEj
   X+UyGMzmHSm9cVgB0Oin6Mj3IXVqOYUvomBjnLxD6q2tCwrBs3yxwZ5K3
   ScYcy9+88iGPwZD6y9wGMq73d15I/6vBO8jJA6fBN5gxJSCsTGJnoJ+Ki
   g==;
X-CSE-ConnectionGUID: DCv/TRcgQP+fEgiDfQVfvA==
X-CSE-MsgGUID: OKM2VUeGQ8uiol8T1f3vrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="83866407"
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="83866407"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 09:52:55 -0700
X-CSE-ConnectionGUID: 1njo6MBxRauewq8XGcCPAA==
X-CSE-MsgGUID: q+OGLC4qRdWWdClZihDUCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="253856849"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.110.202]) ([10.125.110.202])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 09:52:54 -0700
Message-ID: <de755f91-4d2b-4a47-945a-b8f360a6c4a1@intel.com>
Date: Mon, 6 Jul 2026 09:52:53 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] cxl/features: Reject feature offset that overflows
 16-bit field
To: Richard Cheng <icheng@nvidia.com>
Cc: dave@stgolabs.net, jic23@kernel.org, alison.schofield@intel.com,
 vishal.l.verma@intel.com, djbw@kernel.org, danwilliams@nvidia.com,
 iweiny@kernel.org, ming.li@zohomail.com, gourry@gourry.net,
 rrichter@amd.com, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 kees@kernel.org, newtonl@nvidia.com, kristinc@nvidia.com, mochs@nvidia.com,
 kaihengf@nvidia.com, kobak@nvidia.com
References: <20260630074657.43077-1-icheng@nvidia.com>
 <20260630074657.43077-2-icheng@nvidia.com>
 <3cdc48ca-5c39-42aa-8853-e5e3a7884bbe@intel.com>
 <akYddc2XRTz7Jywh@MWDK4CY14F>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <akYddc2XRTz7Jywh@MWDK4CY14F>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/2/26 1:15 AM, Richard Cheng wrote:
> On Tue, Jun 30, 2026 at 08:54:29AM +0800, Dave Jiang wrote:
>>
>>
>> On 6/30/26 12:46 AM, Richard Cheng wrote:
>>> cxl_get_feature() and cxl_set_feature() build the mailbox command's
>>> offset as cpu_to_le16(offset + data_rcvd_size/data_sent_size), but never
>>> check the sum fits in the 16-bit field. Via fwctl, a user-supplied
>>> offset plus count/op_size summing over 65535 silently wraps, steering
>>> the device to the wrong feature offset.
>>>
>>> Fixes: 5e5ac21f629d ("cxl/mbox: Add GET_FEATURE mailbox command")
>>> Fixes: 14d502cc2718 ("cxl/mbox: Add SET_FEATURE mailbox command")
>>> Signed-off-by: Richard Cheng <icheng@nvidia.com>
>>> ---
>>>  drivers/cxl/core/features.c | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
>>> index 85185af46b72..db5964ea184f 100644
>>> --- a/drivers/cxl/core/features.c
>>> +++ b/drivers/cxl/core/features.c
>>> @@ -237,6 +237,9 @@ size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
>>>  	if (!feat_out || !feat_out_size)
>>>  		return 0;
>>>  
>>> +	if (offset + feat_out_size > U16_MAX)
>>> +		return 0;
>>
>> Should this return -EINVAL?
>>
> 
> I don't think so, the function's signature is size_t cxl_get_feature() , it returns the number
> of bytes received from the device, not an errno.
> If you really want this we need to change the signature.
> 
> But I agree that we shouldn't silently fail here, maybe move the check into cxlctl_get_feature()
> and return ERR_PTR(-EINVAL) ? would that work for you ?

We definitely do not want to silently fail. Given that the function has more than one checks that can fail, not sure if pulling this up is the right way to go. Also it gets called numerous times in core/edac.c. We can either change the return to ssize_t or return SIZE_MAX? Will need to fix up all the calling sites in cxl_edac code though. 

DJ

> 
> Btw, for sashiko-bot's review, I think it stands, I'll send v2 with the fix.
> 
> --Richard
>  
>>> +
>>>  	size_out = min(feat_out_size, cxl_mbox->payload_size);
>>>  	uuid_copy(&pi.uuid, feat_uuid);
>>>  	pi.selection = selection;
>>> @@ -287,6 +290,9 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox,
>>>  	if (return_code)
>>>  		*return_code = CXL_MBOX_CMD_RC_INPUT;
>>>  
>>> +	if (offset + feat_data_size > U16_MAX)
>>> +		return -EINVAL;
>>> +
>>>  	struct cxl_mbox_set_feat_in *pi __free(kfree) =
>>>  			kzalloc(cxl_mbox->payload_size, GFP_KERNEL);
>>>  	if (!pi)
>>

