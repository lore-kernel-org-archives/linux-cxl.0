Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E492641F8
	for <linux-cxl@vger.kernel.org>; Mon,  7 Jul 2025 18:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751913347; cv=none; b=Lo/WUAX9TYXdvjoZPDhCA0LnU+kw8ALsHPcEOCBowWMzovMlujXLDa20sZ/m4IcgMeTi4uDwC+9IgOzun4I1VrggsDtmwrvY+u+zTugNN6EwJlGfI+LfkS5GvFeZ2KYoIRy+lFj0H0612ctyD9T0M4lUy7ot7pAYct2+73Fusaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751913347; c=relaxed/simple;
	bh=oeh3HwfXXedUUSoRd7C9CvNEWxrNLcWnj37fK2lWsQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RW8Te2mPZ77aoJAClst6VrNroqir5rOD4V8JmAjtmXho2c1HR8cVEX3zLGiYFHrElQyVsYiydXYfLNsxHtrGQRp5Dw9JPziR13WSJWXvfsD9F1bPgIC8d5hxxFrgNphtSz1ep3//vhhLIEH5Fpif8YubjoSZVzSiPJVv6Z5LXOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wlq8N/qw; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wlq8N/qw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751913346; x=1783449346;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oeh3HwfXXedUUSoRd7C9CvNEWxrNLcWnj37fK2lWsQw=;
  b=Wlq8N/qwN1tfcBZtMiepGiTi/a+mGqQvIwyhQC8IvZzf27pd+Ncj+Nr6
   tu8avcBHf+xwgvAWblWR+x4hbEHcCMHIyj1DE5RGWN77gLqBJZphj2CTc
   kiypf4hIw1k6vblyXCmmbR2Qzqu8nuTqrOoRPcWe98jyRITEZSKm+qyDk
   qKUnVmVNauraPdDs2OJaYAa1vq3wUVqnm9oJeunD2YJK7SqJuEAOWNwjQ
   /iesnxq9+LsCX4jYrBLs99AZFkQb1Zp+bRlWiAAfBLo9JWRIPwiPAQGw9
   ZBwsu/ShwG5EVHKzq955b5LtLD2M5ZIr9Qb7OUqZFcTQybWsSuFolRKPo
   Q==;
X-CSE-ConnectionGUID: vAvOza3gST6yEI/qiEpEPw==
X-CSE-MsgGUID: D9X4Iw5YT6O3piN/w0cmUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="53353608"
X-IronPort-AV: E=Sophos;i="6.16,295,1744095600"; 
   d="scan'208";a="53353608"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 11:35:45 -0700
X-CSE-ConnectionGUID: kc1nfTFnRc6zVlIbCabFTA==
X-CSE-MsgGUID: vrGtvgAvTcWIH5z/7jy/Ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,295,1744095600"; 
   d="scan'208";a="160936957"
Received: from puneetse-mobl.amr.corp.intel.com (HELO [10.125.110.107]) ([10.125.110.107])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 11:35:44 -0700
Message-ID: <94e5d985-4775-4148-9fd5-f847eb9ab7a7@intel.com>
Date: Mon, 7 Jul 2025 11:35:41 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 9/9] cxl: Move enumeration of hostbridge ports to the
 memdev probe path
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 rrichter@amd.com
References: <20250624213916.1665889-1-dave.jiang@intel.com>
 <20250624213916.1665889-10-dave.jiang@intel.com>
 <20250701123257.000055a2@huawei.com>
 <c6b30b4a-e06d-4800-aada-d895989dfcab@intel.com>
 <20250704103908.00004f1e@huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250704103908.00004f1e@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/4/25 2:39 AM, Jonathan Cameron wrote:
> On Thu, 3 Jul 2025 16:22:38 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> On 7/1/25 4:32 AM, Jonathan Cameron wrote:
>>> On Tue, 24 Jun 2025 14:39:16 -0700
>>> Dave Jiang <dave.jiang@intel.com> wrote:
>>>   
>>>> Current enuemration scheme in cxl_acpi module creates the ports under the
>>>> root port by enumerating the hostbridges after the dports under the root
>>>> port is created. However error messages "cxl portN: Couldn't locate the
>>>> CXL.cache and CXL.mem capability array header" is observed when certain
>>>> platform has PCIe hotplug option turned on in BIOS. If the cxl_acpi module
>>>> probe is running before the CXL link between the endpoint device and the
>>>> RP is established, then the platform may not have exposed DVSEC ID 3 and/or
>>>> DVSEC ID 7 blocks which will trigger the error message. This behavior
>>>> is defined by the spec and not a hardware quirk.
>>>>
>>>> Setup an association in cxl_port to tie the host bridge device to the
>>>> associated cxl_root. The cxl_root provides a callback that's setup
>>>> by the cxl_acpi probe function in order to create a port per host bridge
>>>> that was previously done during cxl_acpi probe. Add the calling of the
>>>> callback in devm_cxl_enumerate_ports(). The observed behavior is that
>>>> ports that are not connected to endpoint device(s) are no longer
>>>> enumerated. This should also remove any excessive noise of port probe
>>>> failing on those inactive ports.
>>>>
>>>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>>> ---
>>>> v4:
>>>> - Reworked against new delayed dport allocation mechanism  
>>>
>>> One comment inline.
>>>
>>> This whole things is complex enough I'm not feeling particularly confident
>>> in my reviewing - so definitely needs a lot more eyes.  With that in mind.
>>>
>>> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>>>   
>>>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>>>> index 20d2f834bf94..b1d19c609dde 100644
>>>> --- a/drivers/cxl/core/port.c
>>>> +++ b/drivers/cxl/core/port.c  
>>>   
>>>> +
>>>> +static int cxl_hostbridge_port_setup(struct cxl_memdev *cxlmd)
>>>> +{
>>>> +	struct device *hb_uport_dev, *hb_dport_dev;
>>>> +	struct cxl_dport *dport;
>>>> +	int rc;
>>>> +
>>>> +	rc = get_hostbridge_port_devices(cxlmd, &hb_uport_dev, &hb_dport_dev);
>>>> +	if (rc)
>>>> +		return -ENODEV;
>>>> +
>>>> +	struct cxl_root *cxl_root __free(put_cxl_root) =
>>>> +		cxl_hb_uport_dev_to_root(hb_uport_dev);
>>>> +	if (!cxl_root)
>>>> +		return -ENODEV;
>>>> +
>>>> +	guard(device)(&cxl_root->port.dev);
>>>> +	struct cxl_port *port __free(put_cxl_port) =
>>>> +		find_cxl_port(hb_dport_dev, &dport);  
>>>
>>> I'm not certain that there isn't a path to dport being uninitialized
>>> if !port.  Maybe we always get passed the early checks in match_port_by_dport()
>>> at least once.  Event if it is safe, I suspect we might get false positive
>>> reports as a compiler or static analysis tool is going to struggle to figure
>>> that out.  
>>
>> I'm not quite sure I understand what you are saying here.
> Need more caffeine and a spell checker that day it seems.
> 
> My question was whether we can have (or a static analysis tool thinks we can
> have)
> 1. port == NULL here, dport not initialized.
>>
>> DJ
>>
>>>
>>>   
>>>> +	if (!port)
>>>> +		port = find_cxl_port_by_uport(hb_uport_dev);
> 
> 2. Then this successfully sets port.
> 
>>>> +
>>>> +	/* Port already established, add the associated dport if needed. */
>>>> +	if (port) {
>>>> +		if (dport)
> 
> 3. At which point this is using dport uninitialized.

find_cxl_port() should assign the dport to NULL if we don't find a port. Although I can set dport to NULL at declaration just to be sure.


DJ

> 
>>>> +			return 0;
>>>> +
>>>> +		guard(device)(&port->dev);
>>>> +		return devm_cxl_port_add_dport(port, hb_dport_dev, &dport);
>>>> +	}
>>>> +
>>>> +	/* No port found, setup a port via the root port ops */
>>>> +	if (!cxl_root->ops || !cxl_root->ops->setup_hostbridge_uport)
>>>> +		return -EOPNOTSUPP;
>>>> +
>>>> +	rc = cxl_root->ops->setup_hostbridge_uport(cxl_root, hb_uport_dev);
>>>> +	if (rc)
>>>> +		return rc;
>>>> +
>>>> +	/* Add the dport that goes with the newly created port */
>>>> +	return devm_cxl_add_dport_by_uport(hb_uport_dev, hb_dport_dev, &dport);
>>>> +}
>>>> +
>>>>  int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>>>>  {
>>>>  	struct device *dev = &cxlmd->dev;
>>>> @@ -1826,6 +1889,10 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>>>>  	if (cxlmd->cxlds->rcd)
>>>>  		return 0;
>>>>  
>>>> +	rc = cxl_hostbridge_port_setup(cxlmd);
>>>> +	if (rc)
>>>> +		return rc;
>>>> +
>>>>  	rc = devm_add_action_or_reset(&cxlmd->dev, cxl_detach_ep, cxlmd);
>>>>  	if (rc)
>>>>  		return rc;  
>>>
>>>   
>>
>>
> 
> 

