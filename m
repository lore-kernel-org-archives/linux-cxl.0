Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBC617BB6
	for <linux-cxl@vger.kernel.org>; Thu, 22 May 2025 09:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747907042; cv=pass; b=NRWA9htdi0YD92UznMNttU6FZmu8wUa0N7sqDKKpgzdyAf9ZlnUzcL+kj+17QqSkhINKJTGL8mzxFYseR351inLTP0HzUMJmFLMe6bJfTSw/9jYU7hsvoOGAKAZ5TbZZcQ//ccIK/9Sw/yM17uI+X+Gdfkcbmu01kqIm4wtT7U4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747907042; c=relaxed/simple;
	bh=AUBtIHmSHjNx/AZ8Ql2akGX2a9HOdiKTsZjXb0nnfuc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OiurL/700wwoOZS20S/cbtKNZ+4QhWCIyTO6rZOxLOdhtPq+jwCsujGey0mtQDsXkM1hHsNnS+Y18L4UhPR9Ywz0VuKK9rVM6/RlSYcLcfXUWyTvKqIF/FbGqnI+X8xtjfLIMlFT28Jkg+uxDH6awRFlK9xw1Y2+DVRsY7giRV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=CGHQ0Age; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="CGHQ0Age"
ARC-Seal: i=1; a=rsa-sha256; t=1747907026; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=C4hBFms+s0pGLkMUi5rQX1rKF3iEsPAOTSfc950onhqxk2ZzYA0gczRiLvXMHPUw9d2xGmLUTSZ1As8QH0soZb5BehTsGWQ376rLdqyMPo3bCM+G1H3x3BTUBEcV+3kDkkaYwXt8TbhWij1P5oLdUdZgjtLBYUZfeAulcKINoE0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1747907026; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=KBTzK9n1jau73aVKqpeyXYjgp9fDLDHQOzX2082Z9lA=; 
	b=USXMPbpdc2Ntdq8IFGijABB/mxCqtayTHoKcXe3fYId/Sj02+aFsiju5DNtxPMbcKKxbm12bN1G/wrRMjwuGMHVSFpmpeBivIIn0aM/TCLYK8aMUMKYo/Fu6WBrTg8bjAgec9fvIfRsIxOeO+yFAmGSFElHhhpMQxf/LgBkQ2kk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1747907026;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=KBTzK9n1jau73aVKqpeyXYjgp9fDLDHQOzX2082Z9lA=;
	b=CGHQ0AgeiMNgqZgrN4Ccbe55mpO9vgjGvoXOm/M3KifvLuDLVwgKUKlbIlPYcjAY
	EbBfUyp0lH5S9xoVWYlI4SHP/R1Y6DNMboqoA5cgdYxnAqH6RKmggOecv/sV4UeKdQ5
	QN4GwN7npl14hpyckQoY2/ESsi/8FDT2Ltaq//uE=
Received: by mx.zohomail.com with SMTPS id 1747907024724325.1215289680498;
	Thu, 22 May 2025 02:43:44 -0700 (PDT)
Message-ID: <39b8610c-aed5-41e7-8c09-73738230a334@zohomail.com>
Date: Thu, 22 May 2025 17:43:41 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/9] cxl: Add helper to detect top of CXL device
 topology
To: Dave Jiang <dave.jiang@intel.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, Jonathan Cameron <Jonsathan.Cameron@huawei.com>,
 linux-cxl@vger.kernel.org
References: <20250521183443.3828320-1-dave.jiang@intel.com>
 <20250521183443.3828320-3-dave.jiang@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20250521183443.3828320-3-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr08011227295acb06a82687c0475e296800009cacfa88b6582df371288b9933ee8550ba92b65d6cef81032d:zu08011227527b32aa850affca16d2b9fc000058160aec8dc8c8334f38a043c9025c1c9dc2fc0f4a34af7624:rf0801122d80cf16bb941ae47020e7bb560000dcbbcdd16e27c33a6baff67bcc1db1806c43ad89b0679f7c49ba4e1ca9f67e:ZohoMail
X-ZohoMailClient: External

On 5/22/2025 2:34 AM, Dave Jiang wrote:
> Add a helper to replace the open code detection of CXL device hierarchy
> root. The helper will be used for delayed hostbridge port creation later
> on.
>
> Reviewed-by: Jonathan Cameron <Jonsathan.Cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
> ---
>  drivers/cxl/core/port.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 726bd4a7de27..cafb1b13cba1 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -39,6 +39,15 @@ DECLARE_RWSEM(cxl_region_rwsem);
>  static DEFINE_IDA(cxl_port_ida);
>  static DEFINE_XARRAY(cxl_root_buses);
>  
> +/*
> + * The terminal device in PCI is NULL and @platform_bus
> + * for platform devices (for cxl_test)
> + */
> +static bool is_cxl_hierarchy_head(struct device *dev)
> +{
> +	return (!dev || dev == &platform_bus);
> +}
> +
>  int cxl_num_decoders_committed(struct cxl_port *port)
>  {
>  	lockdep_assert_held(&cxl_region_rwsem);
> @@ -1642,11 +1651,7 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>  		struct device *uport_dev;
>  		struct cxl_dport *dport;
>  
> -		/*
> -		 * The terminal "grandparent" in PCI is NULL and @platform_bus
> -		 * for platform devices
> -		 */
> -		if (!dport_dev || dport_dev == &platform_bus)
> +		if (is_cxl_hierarchy_head(dport_dev))
>  			return 0;
>  
>  		uport_dev = dport_dev->parent;


