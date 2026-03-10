Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B0030EF6C;
	Tue, 10 Mar 2026 20:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773175828; cv=none; b=uTgI1X9sTS7+OWF+O+7cGpKW3tb8PbbZNsammW2x7u1OkvCgFUD4ljzgyGsrojSMFaL6ATsloXW03+bWZsRt/Rmfk2EIF5CBSPoy5xqbDeQwriw4OUOp2ttwTiUEo4d4wWhpu41TP+RiHQuRZdEycfmQ604TNIlSLBThEcljQ24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773175828; c=relaxed/simple;
	bh=Khpo+74TRUDC6rMmP3LnXqwT5R6uxwsM0KDfNzd46JM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TzcrxpT6OrhIDN+7zCKbASoCbl6cEZCMT46cSBjAd/vyEifGd4Uhsxg2vv8KGUIukcq1v3xWZyQU1aXCeqxTRxrQeYdpu7HWmT1oEd2xl8WwGO2j5CgoI0jX7h/ORRMID/aL423YvXSE8DdKAJsBuRWSP96V4SFSXj1oCHIhQQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GXMqjQiX; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GXMqjQiX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773175827; x=1804711827;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Khpo+74TRUDC6rMmP3LnXqwT5R6uxwsM0KDfNzd46JM=;
  b=GXMqjQiXGfHmen3hOsNszAjBasIIFbX+W/8TDWnZiTIJPVa0HTZrev7A
   COPTMzViis3Y2vpmV9QTJFRpO3tvdgXnJdGZL0yNy7zyZf/vDOhfbHWvw
   mhad0PJJ2JkhWaZnfVE+cw3CGJKYiLbO7MlECWdJT3vQAeecv7O+mUATS
   SUfoIp/XgoafY0N+0M4XOl5nYBu/n7PKT+YZJHr5jaFO7EXKBCJWieB2O
   /3TDt7LT5ps3sa1IP3i39sYyRGnVjVYhsnkGcQTBx9usjnrJe3fSj0BiR
   YFgpu33yF2rj8YkjnCaFA8b6Hdvt89PKI8pInkWyb9jrNLcAjdTa41qNR
   A==;
X-CSE-ConnectionGUID: miUHqxjIQba8ySWifejIew==
X-CSE-MsgGUID: R7FiQyioQSOmPnwNS43IkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="84564062"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="84564062"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 13:50:26 -0700
X-CSE-ConnectionGUID: bZA7DdlJTKyAugJ/StQQwQ==
X-CSE-MsgGUID: wkQ8mqq4QEqUX0y4kQTpFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="219355712"
Received: from aduenasd-mobl5.amr.corp.intel.com (HELO [10.125.110.11]) ([10.125.110.11])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 13:50:26 -0700
Message-ID: <684abc44-fed3-489c-838b-e81020ad5a36@intel.com>
Date: Tue, 10 Mar 2026 13:50:24 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] cxl/pci: Check memdev driver binding status in
 cxl_reset_done()
To: Li Ming <ming.li@zohomail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Ben Cheatham <benjamin.cheatham@amd.com>
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org
References: <20260310-fix_access_endpoint_without_drv_check-v1-0-94fe919a0b87@zohomail.com>
 <20260310-fix_access_endpoint_without_drv_check-v1-6-94fe919a0b87@zohomail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260310-fix_access_endpoint_without_drv_check-v1-6-94fe919a0b87@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/10/26 8:57 AM, Li Ming wrote:
> cxl_reset_done() accesses the endpoint of the corresponding CXL memdev
> without endpoint validity checking. By default, cxlmd->endpoint is
> initialized to -ENXIO, if cxl_reset_done() is triggered after the
> corresponding CXL memdev probing failed, this results in access to an
> invalid endpoint.
> 
> CXL subsystem can always check CXL memdev driver binding status to
> confirm its endpoint validity. So adding the CXL memdev driver checking
> inside cxl_reset_done() to avoid accessing an invalid endpoint.
> 
> Fixes: 934edcd436dc ("cxl: Add post-reset warning if reset results in loss of previously committed HDM decoders")
> Signed-off-by: Li Ming <ming.li@zohomail.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/pci.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index fbb300a01830..a5922116db2a 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -1043,6 +1043,9 @@ static void cxl_reset_done(struct pci_dev *pdev)
>  	 * that no longer exists.
>  	 */
>  	guard(device)(&cxlmd->dev);
> +	if (!cxlmd->dev.driver)
> +		return;
> +
>  	if (cxlmd->endpoint &&
>  	    cxl_endpoint_decoder_reset_detected(cxlmd->endpoint)) {
>  		dev_crit(dev, "SBR happened without memory regions removal.\n");
> 

