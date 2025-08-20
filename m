Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A7326F476
	for <linux-cxl@vger.kernel.org>; Wed, 20 Aug 2025 20:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755723258; cv=none; b=AGIwlVOZTTp3eWZKpkfjvzmiARG8MlnG6SH9soX0sY+6w3rh3fPxgFpkPHW6KDAqbENWaa11gJ0DlWAxpRbiebRwp5HRPwvkQoKjNDBcSVliA4OhcVmc2en/uQJYmBU3AcDZOP8zzX9oOc3f4P8P8BLaOwTrpEMPJIGrDDQ3A14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755723258; c=relaxed/simple;
	bh=69Qy2Vy/gnSbKZ67TA5HBoOThXspEJBPToUpJexfIL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CstBOdoN7rargVAWz0wuIjc6Y6k7kjGVPjL5JN0Hq36WYh14e96j7jOUJIsxFXZKlvXs5HN6TKogz9Mfsa2wYvUuhf8z3e5g0KDv4S02erOcCAtZWm8Hb3DPigZIEigD2qX+4YuwwUE+/CUSoPZf0bsdORSeoZ0uiCRIQ2zNpNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PLsVnSSp; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PLsVnSSp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755723257; x=1787259257;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=69Qy2Vy/gnSbKZ67TA5HBoOThXspEJBPToUpJexfIL4=;
  b=PLsVnSSp6IJ6mEmf92IEKyWUJa54I2QE18pYkC4of0AduGNMscAtZcCv
   yiKWC1mUxrr8lnzIXGU5PHBkiDtnuhrFKBbTgfwveE/c+N/2fDsN9rc/J
   yAWsV5dANZjhCj3tSAx9Ci/MX7QbClQ1QQATj1PZM5ttasZ4FeeMD9GwE
   pWbd4xCzhInHgxtysWH+KYC+45jCJA0WpIpBBN0f5Hak5EKb7EI+1ZDH5
   NLSyxQX78yQtNrv09r+lyMbwsnGFnWt/Z3k2GJ4f/nrdRDOid12VUUw6j
   5L3NIhjW57gOgXHljdbCIfYwd3RmEG85oXrQ6e4lEilO3eTsT7fTdFyEh
   g==;
X-CSE-ConnectionGUID: xhmPp1wFS8CU7pktRjoLPQ==
X-CSE-MsgGUID: FJgMIdu+QpKIqc9Sfy04Vg==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="58099066"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="58099066"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 13:54:16 -0700
X-CSE-ConnectionGUID: YaS9cZelRBOXZGSkWCQ6ZA==
X-CSE-MsgGUID: koCsAlaUS0WbvxlPVTZtfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="191912084"
Received: from bvivekan-mobl2.gar.corp.intel.com (HELO [10.247.119.205]) ([10.247.119.205])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 13:54:10 -0700
Message-ID: <256917f1-42e1-48c0-976d-2c4cb2841561@intel.com>
Date: Wed, 20 Aug 2025 13:54:06 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 02/11] cxl: Add helper to reap dport
To: Robert Richter <rrichter@amd.com>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 Li Ming <ming.li@zohomail.com>
References: <20250814222151.3520500-1-dave.jiang@intel.com>
 <20250814222151.3520500-3-dave.jiang@intel.com>
 <aKXXYjyePuyj5Dmz@rric.localdomain>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <aKXXYjyePuyj5Dmz@rric.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/20/25 7:10 AM, Robert Richter wrote:
> On 14.08.25 15:21:42, Dave Jiang wrote:
>> Refactor the code in reap_dports() out to provide a helper function that
>> reaps a single dport. This will be used later in the cleanup path for
>> allocating a dport.
>>
>> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>> Reviewed-by: Li Ming <ming.li@zohomail.com>
>> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>  drivers/cxl/core/port.c | 16 +++++++++++-----
>>  1 file changed, 11 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index 855623cebd7d..fd316e9bd59d 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -1441,6 +1441,15 @@ static void delete_switch_port(struct cxl_port *port)
>>  	devm_release_action(port->dev.parent, unregister_port, port);
>>  }
>>  
>> +static void reap_dport(struct cxl_dport *dport)
> 
> Could you name that cxl_del_dport() as a counterpart to
> devm_cxl_add_dport? The cleanup helper should be named to
> cxl_del_dport to, put_cxl_dport is incorrect here (it is not the
> refcount decremented, kfree is used).

Will rename to del_dport(). No need to add cxl_ since it's a local function.

DJ

> 
>> +{
>> +	struct cxl_port *port = dport->port;
>> +
>> +	devm_release_action(&port->dev, cxl_dport_unlink, dport);
>> +	devm_release_action(&port->dev, cxl_dport_remove, dport);
>> +	devm_kfree(&port->dev, dport);
>> +}
>> +
>>  static void reap_dports(struct cxl_port *port)
> 
> cxl_del_dports()?
> 
>>  {
>>  	struct cxl_dport *dport;
>> @@ -1448,11 +1457,8 @@ static void reap_dports(struct cxl_port *port)
>>  
>>  	device_lock_assert(&port->dev);
>>  
>> -	xa_for_each(&port->dports, index, dport) {
>> -		devm_release_action(&port->dev, cxl_dport_unlink, dport);
>> -		devm_release_action(&port->dev, cxl_dport_remove, dport);
>> -		devm_kfree(&port->dev, dport);
>> -	}
>> +	xa_for_each(&port->dports, index, dport)
>> +		reap_dport(dport);
>>  }
>>  
>>  struct detach_ctx {
>> -- 
>> 2.50.1
>>
> 

