Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794955138;
	b=V753BX8DBnHU7GgULY1H23dg9GCNAFP1ATn43c3vEXnLWfV9rojS+0bXpoVlrJiXZ6Nw
	 I+zbJGNH3HbXHmeu60triMRqa+a05Y+uU0E9U3xO3fVGW/8xfWH/QDnWPPU0SkZU77vPZ
	 c3gH7bXAa+9QEJ/3C3ZRoROBjaolDOhdoEd30ccCVHN4QLc0FLpfs9F5xrHrGJ2kVJ8FH
	 LeEx/vzjN3XjJUnszipjsfZ4GoCpekktWHOvlv8qc1p4xrqCQpdLjI2BlWcs5mpVEz6fp
	 Yo/vfs6YH8qrZQ72vWQzVCQdkNClTFFfxIpxP9537apn6I+g6k9r81wMtQfz/a5+AWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794955138;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=3KqRtjnWYuruAcoUeMPeGWYzkyCz4RVSxHOYzdk8Skk=;
	b=l0VvVw+rZC6Zh/sycRNkUVVPzfgUG3MlkKqVF1HgFLzCrinko3p+EiUTzDWt+6R2hnTh
	 +KmqwN/EQs5hT8BC0PT8O7SaAfX2y1Ooqt9AvXHmeJioxz2e3k0e1I3LSketPkvnubEli
	 B9+CLB229ndrcVM1qc6owarN5Wd7hRd4sfO6iesilgTeocDX2O082tpEElG6NkfDUXilz
	 BJOpoo8+4A8d/lQZwIx7URTJ7UtnnuFfkDQJ+m5ct7G1CqSr5TOJyBU6p4iy7Krpag6Ie
	 KRnR/0E/8Tfa8uO0qLNn/vEivC+nc1Pw1eagMSxGQcK1wi5b6jvA7X5gFq7+STKah7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="NczcCu/j";
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B32606A32C;
	Tue, 17 Nov 2026 22:38:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7B32606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NczcCu/j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794955137; x=1826491137;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XqOcZsepo/SfG8MpnZhOvi8RKbUGhqPAzJDfW7ZvZPM=;
  b=NczcCu/jWs1Q4n899kmoBNlrGLzAffc8iHkjGhXE4W75oAgEBtzZZ4Ll
   5n8xrnJqFM1JWkx0nlzsK9j/F41tiCC77dAQk0I6Uo8XPkcA++cluziBl
   ugp1edDjV1JIv/iXy/3qpX+EQ9MoMbjh4BLTc+fJVgWBKsLhoI99JU3Lc
   ZzK6vylD04h3UUydd5NHzsEK3gDn0mKb19MueL1q2JIutGz/DKrlyyZtJ
   Lw/j0VLFNIHhzrS0oWDl1S5jFJs4+BYNBEQuVAabjyS06iv5IH6VJ7xI6
   2obPxKAiYA/3IzESgjHX3SF/XHMp6EQixlnpapRYmoLa14kiHKWFt4uHo
   Q==;
X-CSE-ConnectionGUID: 34tX6pIGR8WHVPyro5UlwQ==
X-CSE-MsgGUID: qm+uCr+4Tzyir7ZNS4XMeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3639081"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3639081"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 14:38:56 -0800
X-CSE-ConnectionGUID: lR1BMdJFSfOw7bf3Dv3DRw==
X-CSE-MsgGUID: LpwZUN7NR1CLyI3m+MslCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="10208482"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.108.197]) ([10.125.108.197])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 14:38:56 -0800
Message-ID: <26224876-7946-4284-9f3a-5c90411b37d0@intel.com>
Date: Tue, 17 Nov 2026 15:38:54 -0700
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] cxl/core: Create EINJ debugfs files regardless of EINJ
 init order
To: Alison Schofield <alison.schofield@intel.com>,
 Yongxin Yang <yangyongxin@kylinos.cn>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>,
 Dan Williams <djbw@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
 Hanjun Guo <guohanjun@huawei.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Shuai Xue <xueshuai@linux.alibaba.com>,
 Len Brown <lenb@kernel.org>, Li Ming <ming.li@zohomail.com>,
 Robert Richter <rrichter@amd.com>, Ben Cheatham <benjamin.cheatham@amd.com>,
 linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <1a5ceda1-f039-4946-b8d7-2bc97ed48c00@amd.com>
 <20261104061256.1449275-1-yangyongxin@kylinos.cn>
 <avzPbtCq9CedwCZt@aschofie-mobl2.lan>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <avzPbtCq9CedwCZt@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/17/26 3:04 PM, Alison Schofield wrote:
> On Wed, Nov 04, 2026 at 02:12:56PM +0800, Yongxin Yang wrote:
>> The einj_types file under the CXL debugfs directory is never created when
>> cxl_core is built in.  cxl_core_init() runs at subsys_initcall level, while
>> einj_init() registers EINJ at device_initcall level, so the
>> einj_cxl_is_initialized() check in cxl_core_init() always sees EINJ as not
>> up yet and the debugfs_create_file() below it is never reached.
>>
>> Change the file creation condition from EINJ being initialized to a compile
>> time check for ACPI_APEI_EINJ_CXL and return -ENODEV until EINJ is up.
>>
>> The same check also guards the inject files under every downstream port
>> directory.  Gate that directory creation on CONFIG_ACPI_APEI_EINJ_CXL as
>> well, and check einj_cxl_is_initialized() in cxl_einj_inject() to reject
>> writes until EINJ is up.
> 
> I believe this is changing user visible behavior.
> 
> On a host with no EINJ table, einj_types and the dport einj_inject
> files now exist even though EINJ never comes up, and every read or
> write of them fails with -ENODEV. They should not be there.
> 
> We last visited this here:
> 4ed7952b9e87 ("cxl/core: Fix cxl_dport debugfs EINJ entries")
> A file should only exist where injection can work.
> 
> Can the built-in fix keep these files absent when EINJ never comes up?
> 
> ndctl relies on the files being absent:
>   - 'cxl list -v' shows "protocol_injectable": true on root ports that
>     cannot inject
>   - 'cxl list -B' prints "failed to read .../einj_types: No such device"
> 
> 
> An implementation question below...

I've removed from cxl/fixes until issues raised by Alison are addressed.

DJ

> 
>>
>> Fixes: 8039804cfa73 ("cxl/core: Add CXL EINJ debugfs files")
>> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
>> Signed-off-by: Yongxin Yang <yangyongxin@kylinos.cn>
>> ---
>> Link: https://lore.kernel.org/all/de14c4ef-e3d8-432f-9ce8-87c468d6d2ad@amd.com/
>> Link: https://lore.kernel.org/all/7a22cc6a-deba-40e6-8033-97d1234420ba@amd.com/
>> Link: https://lore.kernel.org/all/63e782a6-e33a-46ce-a455-5d207a60661f@amd.com/
>> Link: https://lore.kernel.org/all/1a5ceda1-f039-4946-b8d7-2bc97ed48c00@amd.com/
>>
>> Changes in v7:
>> - Drop the RCH mention from the third paragraph, as suggested by Ben.
>>
>>  drivers/acpi/apei/einj-cxl.c | 3 +++
>>  drivers/cxl/core/port.c      | 7 +++++--
>>  2 files changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/acpi/apei/einj-cxl.c b/drivers/acpi/apei/einj-cxl.c
>> index e70a416ec925..22a7eb4dc75e 100644
>> --- a/drivers/acpi/apei/einj-cxl.c
>> +++ b/drivers/acpi/apei/einj-cxl.c
>> @@ -30,6 +30,9 @@ int einj_cxl_available_error_type_show(struct seq_file *m, void *v)
>>  	int cxl_err, rc;
>>  	u32 available_error_type = 0;
>>  
>> +	if (!einj_cxl_is_initialized())
>> +		return -ENODEV;
>> +
>>  	rc = einj_get_available_error_type(&available_error_type, ACPI_EINJ_GET_ERROR_TYPE);
>>  	if (rc)
>>  		return rc;
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index 625e4aa427db..a949228de936 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -806,6 +806,9 @@ static int cxl_einj_inject(void *data, u64 type)
>>  {
>>  	struct cxl_dport *dport = data;
>>  
>> +	if (!einj_cxl_is_initialized())
>> +		return -ENODEV;
>> +
>>  	if (dport->rch)
>>  		return einj_cxl_inject_rch_error(dport->rcrb.base, type);
>>  
>> @@ -819,7 +822,7 @@ static void cxl_debugfs_create_dport_dir(struct cxl_dport *dport)
>>  	struct cxl_port *parent = parent_port_of(dport->port);
>>  	struct dentry *dir;
>>  
>> -	if (!einj_cxl_is_initialized())
>> +	if (!IS_ENABLED(CONFIG_ACPI_APEI_EINJ_CXL))
>>  		return;
>>  
>>  	/*
>> @@ -2515,7 +2518,7 @@ static __init int cxl_core_init(void)
>>  
>>  	cxl_debugfs = debugfs_create_dir("cxl", NULL);
>>  
>> -	if (einj_cxl_is_initialized())
>> +	if (IS_ENABLED(CONFIG_ACPI_APEI_EINJ_CXL))
>>  		debugfs_create_file("einj_types", 0400, cxl_debugfs, NULL,
>>  				    &einj_cxl_available_error_type_fops);
> 
> Why are the two new einj_cxl_is_initialized() checks at different
> levels?
> 
> einj_cxl_available_error_type_show() checks for itself, but
> einj_cxl_inject_error() and einj_cxl_inject_rch_error() rely on their
> caller, cxl_einj_inject().
> 
> Can all three helpers check, like the !CONFIG_ACPI_APEI_EINJ_CXL stubs do?
> 
> -- Alison
> 
>>  
>> -- 
>> 2.25.1
>>

