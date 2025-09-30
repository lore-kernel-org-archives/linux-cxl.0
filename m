Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EF33C1F;
	Tue, 30 Sep 2025 00:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759193206; cv=pass; b=q3mr/ikvWwSqSD4PbW/4KwvLe9k8kkiFO3MrtCY2TKaZ2w61bxv8L7PjsyiPVKje6eh5c6eLy6fm4N5Vg/GsBtNuLWLYx7OLMoRNx6gB0z3i+d55+KtmHJ589CfBZnNPYvOTdrto/aamFplzmypmO+WgVI/zhJWFsj/taAtxF+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759193206; c=relaxed/simple;
	bh=2tpsfHIZAitH+jO8mwTMMlIAUUlmPFMJxme1/9PLQzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QSzGvxw6/LQD4+49TJLIzjz77Jua8CIm8T+lX8vULb5oLNaDsMGJ0GChPac6EfuOgXfVgFLnagbsgjfLeubu2He3NrwxbRB7V1JhW5dswwBIk2H3zI6jt+SVFKsDjfhEOGQejYWNr/jH6cx3kUlWLmuYvhMpIOml1o9/DdwBkJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=UZQo2Gfi; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="UZQo2Gfi"
ARC-Seal: i=1; a=rsa-sha256; t=1759193192; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=XiHWckNxugZc2McztlIBkoMC0HEqdjtB3yUAwqwYvXMaB1kIgJKE7Ds3igEg/o/2GDBQXvVPLBRj54WgCAd8JLnQw6R3O6W11sWBt00OSRk3Ni5Wh+G3fSLal5MbZe+LYOQg0kSUwPdSE5rupcQcqiM827r82rz/1xorxoMX90w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1759193192; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=+pssYrvbY8H+W1K4nWP6c9JK+9Cklrz9pjmXIYB1iKQ=; 
	b=Q60jSGIkM/24wXBObsSKSwkr2E2WaJpSro9n3Uqpp8XykFJFP1bjxDiZ4O+gKV8xJkASo4m0FdCqjkvoKuwz/+bwosjB4RGy8n4GSXHB00QghplTZE1i5Vl6GHqQ2WNOKWXJ8qOV3LRc7KM8zNx06G6V/VeB4CXlC/xEJo0xuRU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759193192;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=+pssYrvbY8H+W1K4nWP6c9JK+9Cklrz9pjmXIYB1iKQ=;
	b=UZQo2Gfio7w24ZrCLeIJuSn/6G5GaKXIbEN9dHc8x4Jau+TE0GsnCiGXFWA5iKbh
	V5PiFBBTkUC5P3ajqR3NSBTh3gaCCti6fN9Wt1ojzoBNPsTFLi4UCZ8IRPULJ34irYW
	zPvVp7SCaKY5H1HkoQ/SD2VHoS94dlUFu0PUKekU=
Received: by mx.zohomail.com with SMTPS id 17591931896491005.1533923106364;
	Mon, 29 Sep 2025 17:46:29 -0700 (PDT)
Message-ID: <34d5a43d-f3a7-4163-9ebc-afa2a9b666fb@zohomail.com>
Date: Tue, 30 Sep 2025 08:46:29 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] cxl/port: Avoid missing port component registers
 setup
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 dave@stgolabs.net, jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 shiju.jose@huawei.com
References: <20250928101433.424778-1-ming.li@zohomail.com>
 <e2749038-bf78-47a6-83da-96f02bd75599@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <e2749038-bf78-47a6-83da-96f02bd75599@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr080112277bc4f69d2dd2bef3afc0bc3a0000361e0988edbf63b8e48cdefe8be2f0c3b7c2d63cae81f2fa39:zu080112271020ed59dce3032ead1044ba00006a866044d7807d133e27f5a5b44b8ef05a4c2452e5c3aeae55:rf0801122dd8a358ba50482d1c48e44b060000abc46f99175dca5a010515226a00b425d5b2e4e3055e413c9bce1722e0710c:ZohoMail
X-ZohoMailClient: External

On 9/30/2025 12:53 AM, Dave Jiang wrote:
>
> On 9/28/25 3:14 AM, Li Ming wrote:
>> port->nr_dports is used to represent how many dports added to the cxl
>> port, it will increase in add_dport() when a new dport is being added to
>> the cxl port, but it will not be reduced when a dport is removed from
>> the cxl port.
>>
>> Currently, when the first dport is added to a cxl port, it will trigger
>> component registers setup on the cxl port, the implementation is using
>> port->nr_dports to confirm if the dport is the first dport.
>>
>> A corner case here is that adding dport could fail after port->nr_dports
>> updating and before checking port->nr_dports for component registers
>> setup. If the failure happens during the first dport attaching, it will
>> cause that CXL subsystem has not chance to execute component registers
>> setup for the cxl port. the failure flow like below:
>>
>> port->nr_dports = 0
>> dport 1 adding to the port:
>> 	add_dport()	# port->nr_dports: 1
>> 	failed on devm_add_action_or_reset() or sysfs_create_link()
>> 	return error	# port->nr_dports: 1
>> dport 2 adding to the port:
>> 	add_dport()	# port->nr_dports: 2
>> 	no failure
>> 	skip component registers setup because of port->nr_dports is 2
>>
>> The solution here is that moving component registers setup closer to
>> add_dport(), so if add_dport() is executed correctly for the first
>> dport, component registers setup on the port will be executed
>> immediately after that.
>>
>> Signed-off-by: Li Ming <ming.li@zohomail.com>
> That makes sense. Please add a fixes tag. The commit in cxl/next should be stable.

Thanks for the review, will do that.

Ming

>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>
>> ---
>> v2:
>> - remove dport from port->dports in case of component registers setup
>>   failed.
>>
>> base-commit: 46037455cbb748c5e85071c95f2244e81986eb58 cxl/next
>> ---
>>  drivers/cxl/core/port.c | 26 ++++++++++++++------------
>>  1 file changed, 14 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index d5f71eb1ade8..8128fd2b5b31 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -1182,6 +1182,20 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>>  	if (rc)
>>  		return ERR_PTR(rc);
>>  
>> +	/*
>> +	 * Setup port register if this is the first dport showed up. Having
>> +	 * a dport also means that there is at least 1 active link.
>> +	 */
>> +	if (port->nr_dports == 1 &&
>> +	    port->component_reg_phys != CXL_RESOURCE_NONE) {
>> +		rc = cxl_port_setup_regs(port, port->component_reg_phys);
>> +		if (rc) {
>> +			xa_erase(&port->dports, (unsigned long)dport->dport_dev);
>> +			return ERR_PTR(rc);
>> +		}
>> +		port->component_reg_phys = CXL_RESOURCE_NONE;
>> +	}
>> +
>>  	get_device(dport_dev);
>>  	rc = devm_add_action_or_reset(host, cxl_dport_remove, dport);
>>  	if (rc)
>> @@ -1200,18 +1214,6 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>>  
>>  	cxl_debugfs_create_dport_dir(dport);
>>  
>> -	/*
>> -	 * Setup port register if this is the first dport showed up. Having
>> -	 * a dport also means that there is at least 1 active link.
>> -	 */
>> -	if (port->nr_dports == 1 &&
>> -	    port->component_reg_phys != CXL_RESOURCE_NONE) {
>> -		rc = cxl_port_setup_regs(port, port->component_reg_phys);
>> -		if (rc)
>> -			return ERR_PTR(rc);
>> -		port->component_reg_phys = CXL_RESOURCE_NONE;
>> -	}
>> -
>>  	return dport;
>>  }
>>  


