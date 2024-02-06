Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586BF1339AF
	for <linux-cxl@vger.kernel.org>; Tue,  6 Feb 2024 15:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707233051; cv=none; b=cyBaLiIm164NkEDu6TchxUu+CbCpseoxPTm1AEM399sAIAASNcUFWQgZw7B6+yR9LmUv8LjxoFyOM39xBwxh8mqnVDLB5oLNut7kzlQpfB23hxZ/gKmn93r0keIl9xBnN/z9uiQNH9dVp+kYOKMJI4pG5iZ4APnyzSyOIetfI+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707233051; c=relaxed/simple;
	bh=zQuekD4dXObNK2YjGF1Qz32VcLPfHHTuW/Yf+9ObYT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=co7qW/vIwayTTOg0QnQWj0g/R8glKnQ5BvZPe817lnDIJj64/ffOHAizlqDMEqc3hNHWkdehhlhNo4r2HNObKTpFUEQT84HGWQvUKji2MKMpGAwvIRlg+fhbJkpekFp6Wr2BBD4nAd25GeSQm2E52CyArDPeQckPpJFHNTyo9uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dNeG06nH; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dNeG06nH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707233050; x=1738769050;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zQuekD4dXObNK2YjGF1Qz32VcLPfHHTuW/Yf+9ObYT8=;
  b=dNeG06nHjLyxl90EvtcrQHuxO2zIQHkXjoH8QQvv9yQ9zOPfblUtOh/y
   nB5+QrbGJLg0BQi2+jfbiU8bb+xDdN3Wf+UX+jIhFCxqVhs7Wp8EjAT51
   HWnjQ7qXxXocMojezxTaEh/EBLqme9D/+t4dCH1LhueXAif6EM5uyydp0
   051tlSs90xVIojW78dWib7+IHwLiVaaGCVsik3yHQj+4Mg3RwL1JbZso+
   ptpWqmDb3R6JeCax9a2fi37wrac6R7sv0KRl2g4EZOwZ1u++k6M2++n7e
   eVQ14DScPjP5jGTPZHebZYIaRc4QSyXnV8aDzb+VyeTJi0zUDnESgFpPW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="4580424"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="4580424"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 07:24:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="31865523"
Received: from snandago-mobl.amr.corp.intel.com (HELO [10.246.113.99]) ([10.246.113.99])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 07:24:06 -0800
Message-ID: <c7e8fafc-b150-4232-b56a-215292f243e0@intel.com>
Date: Tue, 6 Feb 2024 08:24:04 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (2) cxl: question about cxl qos_class verification
Content-Language: en-US
To: wj28.lee@samsung.com,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Cc: "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
 KyungSan Kim <ks0204.kim@samsung.com>, Hojin Nam <hj96.nam@samsung.com>
References: <ebc9c00d-06f1-4d7f-b551-267301758e16@intel.com>
 <20240205103602epcms2p8543d4f3a4bfb684c81f07a94627c7aef@epcms2p8>
 <CGME20240205103602epcms2p8543d4f3a4bfb684c81f07a94627c7aef@epcms2p6>
 <20240206012321epcms2p6609fae86aaeb23ff377fce94578fc15b@epcms2p6>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240206012321epcms2p6609fae86aaeb23ff377fce94578fc15b@epcms2p6>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/5/24 6:23 PM, Wonjae Lee wrote:
> On Mon, Feb 05, 2024 at 03:31:35PM -0700, Dave Jiang wrote:
>>
>>
>> On 2/5/24 3:36 AM, Wonjae Lee wrote:
>>> Hello,
>>>
>>> To test the CXL driver with respect to QTG IDs on a real CXL device, I
>>> connected one CXL device to a CXL 2.0 Compliant System (v6.8-rc3).
>>>
>>> However, during cxl endpoint probing, CDAT extraction and parsing works
>>> fine, but cxl_qos_class_verify() for cxlmd does not run properly.
>>>
>>> To be precise, when cxl_qos_class_verify() is executed, the below error
>>> handling code is executed since cxlmd->endpoint is NULL:
>>>
>>>     if (!cxl_root)
>>>         return -ENODEV;
>>>
>>>
>>> I'm not sure if I analyzed it correctly due to the complexity of the CXL
>>> driver, but I think it's because the cxl_port driver execute
>>> cxl_qos_class_verify() before cxlmd->endpoint = endpoint was executed in
>>> the cxl_mem driver. See the dmesg log below, where I've added debugging
>>> code.
>>>
>>> # cxl_mem driver is adding the endpoint
>>> [] cxl_mem mem0: call devm_cxl_add_enpoint
>>> ...
>>> # endpoint port is probed, and cxl_qos_class_verify() runs
>>> [] cxl_port endpoint5: call cxl_qos_class_verify
>>> [] cxl_mem mem0: cxl_qos_class_verify: cxlmd->endpoint is NULL
>>> [] cxl_mem mem0: cxl_qos_class_verify: cxl_root is NULL
>>> ...
>>> # cxl_mem driver sets cxlmd->endpoint
>>> [] cxl_mem mem0: cxl_endpoint_autoremove: cxlmd->endpoint = endpoint
>>> ...
>>>
>>>
>>> I did an experiment to validate the hypothesis. If I call
>>> cxl_endpoint_parse_cdat() after cxlmd->endpoint is set,
>>> cxl_qos_class_verify() runs well without problems.
>>>
>>> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
>>> index c5c9d8e0d88d..33b39c6c46fd 100644
>>> --- a/drivers/cxl/mem.c
>>> +++ b/drivers/cxl/mem.c
>>> @@ -74,6 +74,8 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
>>>         if (rc)
>>>                 return rc;
>>>
>>> +       cxl_endpoint_parse_cdat(endpoint);
>>> +
>>>         if (!endpoint->dev.driver) {
>>>                 dev_err(&cxlmd->dev, "%s failed probe\n",
>>>                         dev_name(&endpoint->dev));
>>> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
>>> index 97c21566677a..ee77aba62780 100644
>>> --- a/drivers/cxl/port.c
>>> +++ b/drivers/cxl/port.c
>>> @@ -111,7 +111,6 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>>>
>>>         /* Cache the data early to ensure is_visible() works */
>>>         read_cdat_data(port);
>>> -       cxl_endpoint_parse_cdat(port);
>>>
>>>         get_device(&cxlmd->dev);
>>>         rc = devm_add_action_or_reset(&port->dev, schedule_detach, cxlmd);
>>>
>>>
>>> Maybe there's something I'm missing. It would be very helpful if anyone
>>> could comment on the above analysis.
>>
>> I think this should fix the issue you are seeing?
>>
>> https://lore.kernel.org/linux-cxl/b243e80f-1b24-4756-8bb3-8389d66ea13a@intel.com/T/#mcbce77b6584bd1031d6c1928fcb36fe67be66039
>>
> 
> Oh, you've already fixed it. I found that on the same testbed the commit
> you mentioned resolves the issue.
> 
> Thanks for your response!

Ok if I add your Tested-by tag to that patch?
 
> 
>>
>>>
>>> Thanks,
>>> Wonjae
>>
