Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD0F1C8633
	for <linux-cxl@vger.kernel.org>; Tue, 20 May 2025 16:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747758831; cv=none; b=l10XtyaRS9W6k+TssgxzhCamTs2nuQJbd7J9jSl/877d2TAgterYpr2cMiXH1OlIy90JApEP8TqiWGdLGHPhtUwBcfSpAyX6keWo/6UWWCVjzAXQlAdRlZwtdYBe5qqyzGPQba439JqCX7sbZUgF9JXmLED+wzOcbhi/FgJwTKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747758831; c=relaxed/simple;
	bh=dBv/zJNRr8Kf7p2U4dw8seR16eF0lRw6h+1qIAse+AM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wrfm5SIlvpW5UUxx3WPpCaHtO2PcQ3IhNrKrKGREYZ6ixmtXYgwUvWqnr/J1zFFagEi7ZGzMW+nC1mIStBS9Lk1OyJKogXYtvkrmCTCKgXeXYZ0W3JI/EiuSGVCEmTQ0Y54Q4051acmoSbddRp3Kd03d9+L+dO+jwIhE0m7FLok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=detmaO/l; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="detmaO/l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747758830; x=1779294830;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dBv/zJNRr8Kf7p2U4dw8seR16eF0lRw6h+1qIAse+AM=;
  b=detmaO/lK9v93DqZR7Aj5dazgNqheHUnk/wFTXzf0Ktv0DBvsQ8Bxo4M
   XX+nAahgAkVKEJzmtvucRZi7d793mzZfrxQe+Z2vcB2SOfasHB7FqM7qT
   hx03mlvinUPpGzVpcFsySbfyjgUtcV0TyJOQi8XOfkQono2migoZE+4yH
   Gu9YAjIEePp3vSVwA1y4pvI2glevfIJdLkX4RqDvwumMMrNYVVccpVnGe
   rgEdmjBIyhQKentW+fY6ahpZFIfHJZ5cVWfHcy0t1evnJrddLC0HCsmC/
   q3q/hTs6f4qtPvpiSuMVHwbYF9qX/RP5MAta3cy4MppmHo+ekc/pLfN7z
   w==;
X-CSE-ConnectionGUID: 8ei/44YvQcervk98HKoqBQ==
X-CSE-MsgGUID: G64CcAk9Q3y+6qZ8Hi4DXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="48959526"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="48959526"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 09:33:49 -0700
X-CSE-ConnectionGUID: s0CrL3oTRa+l7NVgycm9dA==
X-CSE-MsgGUID: DszHmmyNTje4UtO6ukxqHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="176882714"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.109.92]) ([10.125.109.92])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 09:33:48 -0700
Message-ID: <212a5734-ed23-49d6-b5f0-4fac3b0040d6@intel.com>
Date: Tue, 20 May 2025 09:33:47 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/10] cxl: Defer hardware dport->port_id assignment
 and registers probing
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Gregory Price <gourry@gourry.net>, linux-cxl@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>, dave@stgolabs.net,
 alison.schofield@intel.com, ira.weiny@intel.com, rrichter@amd.com,
 ming.li@zohomail.com
References: <20250507004310.3536991-1-dave.jiang@intel.com>
 <20250507004310.3536991-6-dave.jiang@intel.com>
 <aCNopruv5rUV2PBr@gourry-fedora-PF4VCD3F>
 <4ab4a497-e1e2-4e64-90dd-08c489cc52a7@intel.com>
 <20250520122653.00007e7d@huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250520122653.00007e7d@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/20/25 4:26 AM, Jonathan Cameron wrote:
>   
>>>> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
>>>> index a35fc5552845..4d840a6ef802 100644
>>>> --- a/drivers/cxl/port.c
>>>> +++ b/drivers/cxl/port.c  
>>> ... snip ...  
>>>>  	/* Cache the data early to ensure is_visible() works */
>>>> @@ -69,24 +68,7 @@ static int cxl_switch_port_probe(struct cxl_port *port)
>>>>  	if (rc < 0)
>>>>  		return rc;
>>>>    
>>> ... snip ...  
>>>> -	return -ENXIO;
>>>> +	return 0;
>>>>  }  
>>>
>>> 	return devm_cxl_port_enumerate_dports(port);  
>>
>> This was actually done on purpose. devm_cxl_port_enumerate_dports() returns the number of dports enumerated. So usually the return value is greater than 0. in drivers/base/dd.c, call_driver_probe() throws the return value into a switch() where any value not 0 are errors. So the probe() call would fail. Here we are intercepting the return value and return a 0 if it's positive. I got bitten here during this series's debug. I should add a comment and explain why.  
> 
> I'll ask a 'silly' follow up.  Why does devm_cxl_port_enumerate_dports()
> return the number.  From a quick look does anyone use it?  If not
> just change that as a precursor patch and allow this
> tiny bit of code improvement.

I think originally the return value was used to determine of the decoder is passthrough or not. I guess with the new behavior, I don't have access to that and use the dports_ida to do the same thing. We can have it return 0 going forward.

DJ

> 
>>
>>
>>>
>>>
>>> ~Gregory  
>>
>>
> 

