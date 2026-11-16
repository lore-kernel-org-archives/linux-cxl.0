Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794868196;
	b=PFtYpjUFQglcd+IwNknRYf+XqTnQU26tSFzPIzsZMsSG6X3bq6LgZE1LphML2+8u32NE
	 LKbeHqHf+eSmgGsmYUczu99LW+EfzJVBIqn/duo7RJFp96L+eklpKVM8+uj7wULazdDyt
	 gSzepRyRH223Zgr1XskR/IEAeZ9hQHS4sl8lZpqeO+ebUpDk4Lwz3i7yxk8TmjORqZ9oO
	 30Ss/avsaQQmlky2BLlRqtx+xjyXrvSPd38shXNtOYael4owOMugg4ECKFHBWAzmByq42
	 261IvpOac0//dp+H+/9+K1hx4zyPRXiMYbmRhcZVzY4SuZ05DevFEO+MmjNUOpEL1BQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794868196;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Bm9xBoSUqXiPogzBseS8Tdzl6aaUQ0bs7ShMLPn4mTM=;
	b=JdHfcSPxQRB3aHXtEV64otdo+BvYUrymW4u+TtRdPscqa7XrvjTkf7pScP4bnJICqvWS
	 IjOWp66Q9+OpbSsHViWlaA6rtsEtuH7zr/0bZoUW7U0SMlGfoL74bwiSffO6jC/gPRcVS
	 PMDVXZC2c/RIz7IRx3iSaznmZDnzllFMe+Gw7u/IzbCeBK58/2+dIpKi+ta/IY4xQJC1a
	 19+3Y0od1p8V7neRk5IgntsFAshddJwp023W2HPZvUWus82mculXRk+GIfksBXevV4oTK
	 hOGfJtTs3dL1TjEMWfbGtLL1DMJCjDU3k2Dk6ejo1j815Xyvh56H2b1NYREzKrt+1AQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="GjNbS/IG";
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71570606A888;
	Mon, 16 Nov 2026 22:29:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71570606A888
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GjNbS/IG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794868192; x=1826404192;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CIBoGHUqRxvT7KACmwHa4NEdtDCNVqveh0Sg1/4KzR4=;
  b=GjNbS/IGSV41BHf9YH+xHUm/nzVBPQBmZn9EsXO4P1f4jkB2C6x9/UIs
   +vC3UnWlWJSixeNimS/JFRXx5xNMreNEaNLk9STpG/TNu7iOuIRO3d/pI
   ThI3PMuP5zoSAQyXCJvZIiU23FghVqWVTYdSHzaxTJ2S/L1C873KEkUP0
   a4NP/8XjLWlErQEVKgYXav7Bz9y3vJ1wMwrnhaRTqNeaiG+FTFQFp18pd
   FdCD5l8rpwRyVKJ8fHqVUS0EERX8dZTkOS0Fz8C1yjMHHTOFmXd7obfxc
   +XUDqcPiaSMQdi16ldj93mHxms/9wVyXyDEWsg7Q9cpxu5it+XkMQdkaW
   A==;
X-CSE-ConnectionGUID: OsUcy8SiQPWbhxu1g7Z19w==
X-CSE-MsgGUID: Zbfi80C+SH6kzD6cVdz0Tw==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3699613"
X-IronPort-AV: E=Sophos;i="6.27,217,1787036400"; 
   d="scan'208";a="3699613"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 14:28:01 -0800
X-CSE-ConnectionGUID: 4G80KSDwQo2+hcPa3oGVnQ==
X-CSE-MsgGUID: /faUMfIfQK2I6qZPKnplcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,217,1787036400"; 
   d="scan'208";a="9704998"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.108.118]) ([10.125.108.118])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 14:27:59 -0800
Message-ID: <740532e4-86f4-4113-9203-d23331fec246@intel.com>
Date: Mon, 16 Nov 2026 15:27:57 -0700
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
To: Yongxin Yang <yangyongxin@kylinos.cn>, Davidlohr Bueso
 <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>,
 Dan Williams <djbw@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
 Hanjun Guo <guohanjun@huawei.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Shuai Xue <xueshuai@linux.alibaba.com>,
 Len Brown <lenb@kernel.org>, Li Ming <ming.li@zohomail.com>,
 Robert Richter <rrichter@amd.com>, Ben Cheatham <benjamin.cheatham@amd.com>,
 linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <1a5ceda1-f039-4946-b8d7-2bc97ed48c00@amd.com>
 <20261104061256.1449275-1-yangyongxin@kylinos.cn>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20261104061256.1449275-1-yangyongxin@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/3/26 11:12 PM, Yongxin Yang wrote:
> The einj_types file under the CXL debugfs directory is never created when
> cxl_core is built in.  cxl_core_init() runs at subsys_initcall level, while
> einj_init() registers EINJ at device_initcall level, so the
> einj_cxl_is_initialized() check in cxl_core_init() always sees EINJ as not
> up yet and the debugfs_create_file() below it is never reached.
> 
> Change the file creation condition from EINJ being initialized to a compile
> time check for ACPI_APEI_EINJ_CXL and return -ENODEV until EINJ is up.
> 
> The same check also guards the inject files under every downstream port
> directory.  Gate that directory creation on CONFIG_ACPI_APEI_EINJ_CXL as
> well, and check einj_cxl_is_initialized() in cxl_einj_inject() to reject
> writes until EINJ is up.
> 
> Fixes: 8039804cfa73 ("cxl/core: Add CXL EINJ debugfs files")
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> Signed-off-by: Yongxin Yang <yangyongxin@kylinos.cn>

Applied to cxl/fixes
cab9eaa46f41
Next time please create a new email thread per revision and not reply to the previous threads. Thanks.


> ---
> Link: https://lore.kernel.org/all/de14c4ef-e3d8-432f-9ce8-87c468d6d2ad@amd.com/
> Link: https://lore.kernel.org/all/7a22cc6a-deba-40e6-8033-97d1234420ba@amd.com/
> Link: https://lore.kernel.org/all/63e782a6-e33a-46ce-a455-5d207a60661f@amd.com/
> Link: https://lore.kernel.org/all/1a5ceda1-f039-4946-b8d7-2bc97ed48c00@amd.com/
> 
> Changes in v7:
> - Drop the RCH mention from the third paragraph, as suggested by Ben.
> 
>  drivers/acpi/apei/einj-cxl.c | 3 +++
>  drivers/cxl/core/port.c      | 7 +++++--
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/apei/einj-cxl.c b/drivers/acpi/apei/einj-cxl.c
> index e70a416ec925..22a7eb4dc75e 100644
> --- a/drivers/acpi/apei/einj-cxl.c
> +++ b/drivers/acpi/apei/einj-cxl.c
> @@ -30,6 +30,9 @@ int einj_cxl_available_error_type_show(struct seq_file *m, void *v)
>  	int cxl_err, rc;
>  	u32 available_error_type = 0;
>  
> +	if (!einj_cxl_is_initialized())
> +		return -ENODEV;
> +
>  	rc = einj_get_available_error_type(&available_error_type, ACPI_EINJ_GET_ERROR_TYPE);
>  	if (rc)
>  		return rc;
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 625e4aa427db..a949228de936 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -806,6 +806,9 @@ static int cxl_einj_inject(void *data, u64 type)
>  {
>  	struct cxl_dport *dport = data;
>  
> +	if (!einj_cxl_is_initialized())
> +		return -ENODEV;
> +
>  	if (dport->rch)
>  		return einj_cxl_inject_rch_error(dport->rcrb.base, type);
>  
> @@ -819,7 +822,7 @@ static void cxl_debugfs_create_dport_dir(struct cxl_dport *dport)
>  	struct cxl_port *parent = parent_port_of(dport->port);
>  	struct dentry *dir;
>  
> -	if (!einj_cxl_is_initialized())
> +	if (!IS_ENABLED(CONFIG_ACPI_APEI_EINJ_CXL))
>  		return;
>  
>  	/*
> @@ -2515,7 +2518,7 @@ static __init int cxl_core_init(void)
>  
>  	cxl_debugfs = debugfs_create_dir("cxl", NULL);
>  
> -	if (einj_cxl_is_initialized())
> +	if (IS_ENABLED(CONFIG_ACPI_APEI_EINJ_CXL))
>  		debugfs_create_file("einj_types", 0400, cxl_debugfs, NULL,
>  				    &einj_cxl_available_error_type_fops);
>  

