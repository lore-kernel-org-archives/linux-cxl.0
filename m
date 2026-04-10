Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A753722759C;
	Fri, 10 Apr 2026 08:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775809057; cv=pass; b=ORCTe4xCmMyLMD+71XnmJlgQyprHbceVyzVOWvTM7eRcC07+mRHUHS3aWWqRP0y3Fwr/Hxo7jfU+22Nnpk+Ni6tJiCEEN8/oiVzrD1w7aV18WWDHSJh7u44HWUq3mzqUkyNICcHg9EpUB3U71jW60XrQ3pmxfscbAWiGmJZljD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775809057; c=relaxed/simple;
	bh=RBjEHAuFDRWNTyNl9zyM2L9MpN+2i5Znc/lLqDa0nDE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=DN5AcSXe6UxiXLOqe8Qd/Cqm5IIwCpVx2WOIL8Pa0vxydQrxz3k3ggFylQKIW1pE4SfkH2MvylmXw5eJ75YOILqDk2V4FML+SUH3y1eN+peAwVNE1Vkj85LR+RDRlN2YRtvUa9birRRKKT/FkmaKAfBHln+m/FbH/zd4xlXSX48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=BU2hN8Ti; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="BU2hN8Ti"
ARC-Seal: i=1; a=rsa-sha256; t=1775809046; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=RM/o/bCw0fQkbZAvuxtfSeX3Wn6WmW1AXp4gmg+hVRDIwkO9z0M76HhpMyW/mTM0rSCaUYxgrpoOSR+OgaSAmW+djWIfVaH9zJB4ebpLOUI6fboVHArRQKrGYrG7pbpEWaiKRjOFVzMA6g0b/aPiWIR+dcbLMg16xd7YgTL1Rew=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1775809046; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Xq3AnbhurC0D6H/TfE4+1BzwSVoOedBPHf6T6DvvzMc=; 
	b=K33bzQNkEpuFqMG9UT+pton9eLfSwl4tjmjkGG3BDaDbxpYfSjGv4RKrYsR5ZKnuGGQ/0q3baCZtQY2P2NJFyHT3UTrJ8r3bYy7lbfXArhfMz8leRjxBvrjiCSSl8xOTcvakG3MFuo0IN+F6GzRerDxuzFwq6eisohPQjJ+G144=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775809046;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:From:From:To:To:Cc:Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=Xq3AnbhurC0D6H/TfE4+1BzwSVoOedBPHf6T6DvvzMc=;
	b=BU2hN8TiOYhLYqUe0SqF8xLyo+fyMLWCJfVav4JKMP34+uqmgUma5dM1b/ChR5L0
	ZkSX35tadhWj+G9c9z9R+bdvKn+bNUWVU8bedzRJH7wBPHZHJXECMHcIba/LBa1NDD/
	GwwID/OL8OjLgnzpGsZENdyV667GWImzpskehFLY=
Received: by mx.zohomail.com with SMTPS id 1775809043915743.3311271027749;
	Fri, 10 Apr 2026 01:17:23 -0700 (PDT)
Message-ID: <d9c29dea-0359-4257-9f8e-0e7a7e68654b@zohomail.com>
Date: Fri, 10 Apr 2026 16:17:17 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] cxl/hdm: Add support for 32 switch decoders
From: Li Ming <ming.li@zohomail.com>
To: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260321061459.1910205-1-ming.li@zohomail.com>
In-Reply-To: <20260321061459.1910205-1-ming.li@zohomail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: rr080112280bd0b0725bb9bb9ef7abd1c800005c41340b335a47eb41e81a918afaf49310221744e8b255fb78cd:zu0801122728a0500673b10643927242b4000008c9db1cfcd4d828f4cb038c0214258597cc01dc0972cfe206:rf0801122dcf5b49fc7be121f95896a26300003d522f8b92c50bffd19d6724c27d24c799df2992ebb57b5a24604c32412e81:ZohoMail
X-ZohoMailClient: External

kindly ping.

Is this patch missing in cxl/next?


Ming

在 2026/3/21 14:14, Li Ming 写道:
> Per CXL r4.0 section 8.2.4.20.1. CXL host bridge and switch ports can
> support 32 HDM decoders. Current implementation misses some decoders on
> CXL host bridge and switch in the case that the value of Decoder Count
> field in CXL HDM decoder Capability Register is greater than or equal to
> 9.
>
> Update calculation implementation to ensure the decoder count calculation
> is correct for CXL host bridge/switch ports.
>
> Signed-off-by: Li Ming <ming.li@zohomail.com>
> ---
> Changes from v1:
> - Return -ENXIO if the value violates SPEC. (Dave & Alison)
> ---
>   drivers/cxl/core/hdm.c |  2 +-
>   drivers/cxl/cxl.h      | 11 ++++++++++-
>   drivers/cxl/cxlmem.h   |  2 +-
>   3 files changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index c222e98ae736..3930e130d6b6 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -177,7 +177,7 @@ static struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
>   	}
>   
>   	parse_hdm_decoder_caps(cxlhdm);
> -	if (cxlhdm->decoder_count == 0) {
> +	if (cxlhdm->decoder_count < 0) {
>   		dev_err(dev, "Spec violation. Caps invalid\n");
>   		return ERR_PTR(-ENXIO);
>   	}
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 9b947286eb9b..0a5301049cf3 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -77,7 +77,16 @@ static inline int cxl_hdm_decoder_count(u32 cap_hdr)
>   {
>   	int val = FIELD_GET(CXL_HDM_DECODER_COUNT_MASK, cap_hdr);
>   
> -	return val ? val * 2 : 1;
> +	switch (val) {
> +	case 0:
> +		return 1;
> +	case 1 ... 8:
> +		return val * 2;
> +	case 9 ... 12:
> +		return (val - 4) * 4;
> +	default:
> +		return -ENXIO;
> +	}
>   }
>   
>   /* Encode defined in CXL 2.0 8.2.5.12.7 HDM Decoder Control Register */
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index e21d744d639b..399b150b404c 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -923,7 +923,7 @@ int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd);
>    */
>   struct cxl_hdm {
>   	struct cxl_component_regs regs;
> -	unsigned int decoder_count;
> +	int decoder_count;
>   	unsigned int target_count;
>   	unsigned int interleave_mask;
>   	unsigned long iw_cap_mask;
