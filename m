Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E951C07CF
	for <linux-cxl@vger.kernel.org>; Wed, 11 Dec 2024 05:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733896348; cv=pass; b=hSZoZoGlCm6SzdfSQVAMUEoRJOuFsrdbqj5ZA/lOrJJqxRRxIj/JnzcIB7m3vGRY/L6+S2vnVyHgodaUBesqyN4YgzXjZifRetzpu78L06L74p5Lc4Lhfj6B3WH9WP9gXLN85DWwnOpgQQDGpwrHG1knjo17gqIpDwwdw6Vy2VI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733896348; c=relaxed/simple;
	bh=xz0V9iyb5Z/hQ0j/t45pq4qsl0yV+UNCtwwSIQMCI2U=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=PbuvJaBdwFqoa6K6b7ZBXvZrsjGaE3mKOEoKR14O6Ya+qswPrbreb1ut/WrZS0Zqj667QN6o3jIdCOFlztQOAKD2KVt2t28Sv99tL3PJFjmilbODzI8s+wCLafWUDz4uJ3icxWMJpnVPa1hrSJjlDmFowjKa1XDoDoGj2s3RzqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=JzgpDWGA; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="JzgpDWGA"
ARC-Seal: i=1; a=rsa-sha256; t=1733896344; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=HTDz5ST4V1i4ORpbwwU6rerCSumpMUqAHC6u6sCAz+z06AUtyjF9gquN+CNtkOv0oRHXOHNXf6K2XRsjv9qlm5Ri6i7M4tYsDYoJu5R3j+YpVuyK+VjzR12zqJb2+nlv66Pb1e16nCfoH1zyrvMnZe2lkp0G17Vb6JtdBiRScDU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1733896344; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=XVmtta38ONvy/fT/XC4BZHqvfAQajjzd/+HriZwxX+Q=; 
	b=W1j82LObbXe/oFQYkCDK4jMF3yVajCQi4lnZe0sd+Zf20T+Pk6Fq57Autq2d4V8aSgUsqrZhsx2EjQyjvU2EygT0/kujJnR3SFzUAORqxPIm84OpG4uLJoTMksAyGHUy/dZcJDAVAGyeTEtJHU/T8BgY1DA2jQ7dh+OBLfw03ak=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1733896344;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:From:From:To:To:Cc:Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=XVmtta38ONvy/fT/XC4BZHqvfAQajjzd/+HriZwxX+Q=;
	b=JzgpDWGAxm3tK/NMc6RO2AoP4vXGJMlZOcjMay7Bf/6SGV7C0wCJZ5tlF/hqn7OS
	cTtbrdXF/mfW11638LSSwvcWFDgmUYIdK/w3W4YH5iTlhdAM9psO2idrSEmkXcg0+vm
	N9h393c2Z3QXytlF4iRJJ2rqw3sFSlc1cW4ZRrbA=
Received: by mx.zohomail.com with SMTPS id 1733896342669231.55518440805554;
	Tue, 10 Dec 2024 21:52:22 -0800 (PST)
Message-ID: <8b1f108d-e6a3-42b8-a552-a7e7c1871d9f@zohomail.com>
Date: Wed, 11 Dec 2024 13:52:20 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/mem: Hide RCD attributes when pre-requisites are
 missing
From: Li Ming <ming.li@zohomail.com>
To: Dan Williams <dan.j.williams@intel.com>, dave.jiang@intel.com
Cc: alison.schofield@intel.com, linux-cxl@vger.kernel.org
References: <173386304532.1383902.17130961308615551692.stgit@dwillia2-xfh.jf.intel.com>
 <be2c5161-07d5-4570-8fcd-7158c0a3608d@zohomail.com>
In-Reply-To: <be2c5161-07d5-4570-8fcd-7158c0a3608d@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr080112278bd41ff6dbe841007eb29bec000028354974cce7b7f32c2f5977ad49d1d2dc5faf107ab741d37f:zu08011227f572ec0939131d61e50181770000906682a4012f78b66249a2dd4a96cca6da924d8b55e92cde88:rf0801122626c298cbb38520a5de062f3a00005fb6d6ec4c51c98ef3040b02b52e89bf5e11f5a5a9dea9af:ZohoMail
X-ZohoMailClient: External

On 12/11/2024 1:44 PM, Li Ming wrote:
> On 12/11/2024 4:37 AM, Dan Williams wrote:
>> A recent change to avoid a NULL rcd_pcie_cap pointer consumption in
>> rcd_pcie_cap_emit() [1] arranged for the problematic sysfs attributes to
>> return an error on access. However, if the attributes always fail on
>> read they should simply be hidden.
>>
>> Add a facility called @mem_groups that follows the same visibility rules
>> as the "dev_groups" of the cxl_mem driver. It is expressly for
>> PCI-device relative attributes, but that require the device to be
>> additionally connected to the CXL port topology.
>>
>> Link: http://lore.kernel.org/20241129132825.569237-1-ming.li@zohomail.com
>> Cc: Li Ming <ming.li@zohomail.com>
>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>> ---
>>  drivers/cxl/core/memdev.c    |   14 +++++++++-----
>>  drivers/cxl/core/port.c      |    3 +++
>>  drivers/cxl/cxlmem.h         |    7 +++++--
>>  drivers/cxl/mem.c            |    8 ++++++++
>>  drivers/cxl/pci.c            |   21 +++++++++++++++++++--
>>  tools/testing/cxl/test/mem.c |    2 +-
>>  6 files changed, 45 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>> index 84fefb76dafa..7801bf64aafa 100644
>> --- a/drivers/cxl/core/memdev.c
>> +++ b/drivers/cxl/core/memdev.c
>> @@ -616,8 +616,10 @@ static void detach_memdev(struct work_struct *work)
>>  
>>  static struct lock_class_key cxl_memdev_key;
>>  
>> -static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
>> -					   const struct file_operations *fops)
>> +static struct cxl_memdev *
>> +cxl_memdev_alloc(struct cxl_dev_state *cxlds,
>> +		 const struct file_operations *fops,
>> +		 const struct attribute_group **mem_groups)
>>  {
>>  	struct cxl_memdev *cxlmd;
>>  	struct device *dev;
>> @@ -633,6 +635,7 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
>>  		goto err;
>>  	cxlmd->id = rc;
>>  	cxlmd->depth = -1;
>> +	cxlmd->mem_groups = mem_groups;
>>  
>>  	dev = &cxlmd->dev;
>>  	device_initialize(dev);
>> @@ -1017,15 +1020,16 @@ static const struct file_operations cxl_memdev_fops = {
>>  	.llseek = noop_llseek,
>>  };
>>  
>> -struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>> -				       struct cxl_dev_state *cxlds)
>> +struct cxl_memdev *
>> +devm_cxl_add_memdev(struct device *host, struct cxl_dev_state *cxlds,
>> +		    const struct attribute_group **mem_groups)
>>  {
>>  	struct cxl_memdev *cxlmd;
>>  	struct device *dev;
>>  	struct cdev *cdev;
>>  	int rc;
>>  
>> -	cxlmd = cxl_memdev_alloc(cxlds, &cxl_memdev_fops);
>> +	cxlmd = cxl_memdev_alloc(cxlds, &cxl_memdev_fops, mem_groups);
>>  	if (IS_ERR(cxlmd))
>>  		return cxlmd;
>>  
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index af92c67bc954..a53f144bbac1 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -1397,6 +1397,7 @@ static void delete_endpoint(void *data)
>>  {
>>  	struct cxl_memdev *cxlmd = data;
>>  	struct cxl_port *endpoint = cxlmd->endpoint;
>> +	struct device *parent = cxlmd->dev.parent;
>>  	struct device *host = endpoint_host(endpoint);
>>  
>>  	scoped_guard(device, host) {
>> @@ -1407,6 +1408,8 @@ static void delete_endpoint(void *data)
>>  		}
>>  		cxlmd->endpoint = NULL;
>>  	}
>> +	if (sysfs_update_groups(&parent->kobj, cxlmd->mem_groups))
>> +		dev_info(parent, "CXL.mem sysfs attributes removed\n");
>>  	put_device(&endpoint->dev);
>>  	put_device(host);
>>  }
>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
>> index 2a25d1957ddb..9c5f2544da75 100644
>> --- a/drivers/cxl/cxlmem.h
>> +++ b/drivers/cxl/cxlmem.h
>> @@ -43,6 +43,7 @@
>>   * @cxl_nvb: coordinate removal of @cxl_nvd if present
>>   * @cxl_nvd: optional bridge to an nvdimm if the device supports pmem
>>   * @endpoint: connection to the CXL port topology for this memory device
>> + * @mem_groups: host device groups that change visibility based on cxl_mem attach
>>   * @id: id number of this memdev instance.
>>   * @depth: endpoint port depth
>>   */
>> @@ -54,6 +55,7 @@ struct cxl_memdev {
>>  	struct cxl_nvdimm_bridge *cxl_nvb;
>>  	struct cxl_nvdimm *cxl_nvd;
>>  	struct cxl_port *endpoint;
>> +	const struct attribute_group **mem_groups;
>>  	int id;
>>  	int depth;
>>  };
>> @@ -87,8 +89,9 @@ static inline bool is_cxl_endpoint(struct cxl_port *port)
>>  	return is_cxl_memdev(port->uport_dev);
>>  }
>>  
>> -struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>> -				       struct cxl_dev_state *cxlds);
>> +struct cxl_memdev *
>> +devm_cxl_add_memdev(struct device *host, struct cxl_dev_state *cxlds,
>> +		    const struct attribute_group **mem_groups);
>>  int devm_cxl_sanitize_setup_notifier(struct device *host,
>>  				     struct cxl_memdev *cxlmd);
>>  struct cxl_memdev_state;
>> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
>> index a9fd5cd5a0d2..2d2a662c99d4 100644
>> --- a/drivers/cxl/mem.c
>> +++ b/drivers/cxl/mem.c
>> @@ -50,6 +50,7 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
>>  {
>>  	struct cxl_port *parent_port = parent_dport->port;
>>  	struct cxl_port *endpoint, *iter, *down;
>> +	struct device *parent;
>>  	int rc;
>>  
>>  	/*
>> @@ -70,6 +71,13 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
>>  	if (IS_ERR(endpoint))
>>  		return PTR_ERR(endpoint);
>>  
>> +	parent = cxlmd->dev.parent;
>> +	rc = sysfs_update_groups(&parent->kobj, cxlmd->mem_groups);
>> +	if (rc) {
>> +		dev_err(parent, "CXL.mem sysfs attributes removed\n");
>> +		return rc;
>> +	}
> Hi Dan,
>
>
> I think the error log in devm_cxl_add_endpoint() should not be "CXL.mem sysfs attributes removed", "Failed to attach CXL.mem sysfs attributes" should be better?

Sorry, I think that I misunderstood it, it is used to update the visibility, "CXL.mem sysfs attributes removed" is good, sorry about that.


>
> Other looks good to me.
>
> Reviewed-by: Li Ming <ming.li@zohomail.com>
>
>
> Besides, RCEC address is stored in dport, but rcd upstream port pci express capability is a rcd capability, not a rch dport capability. Is it better to move rcd_pcie_cap into cxlds->regs? If yes, I can work on that.
>
>
>

