Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5463412294
	for <linux-cxl@vger.kernel.org>; Thu, 24 Sep 2026 08:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790238066; cv=none; b=TGTLVlG4JXFiTMIZkfiZI624GiFMfR+msdzvRZxL+7W27NcgzT4ub11W8bUIWqXEU0E8RvseTq+SWl6i+w9480pmAQ4CTA4Szs2zHt6jObSBH4xQhn3adrblGRwntKWVdJbHl0+NC8aF9Zs9qF06nY70oAk0XpDelex57CFWHFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790238066; c=relaxed/simple;
	bh=xLKwIgImHArSoDRxKNReWtyWPgR8tM7wwg9leeIrudk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eMspFohrd/hZqDXPgpe7xjKnAa1rQoZoGdSR3E0/NUEAo6lM5h0c6jd8fXHPHH9fCK6GxBoTLmVmMECwmHZlFSuyTu/VmFKOAL+QcGla2qOVaLFFreYBXyP+R9b2brrQ82G6N2xn/uRflajMywao69PFNdnshYyzy1IaXbfpTJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KjOQhQ35; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KjOQhQ35"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49e65a8f70eso26665e9.0
        for <linux-cxl@vger.kernel.org>; Thu, 24 Sep 2026 01:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790238063; x=1790842863; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TBbUmiE2dRkBbSKytOyHEBRYcqAsz7TnE/aajFa/CtM=;
        b=KjOQhQ352OkWxgPfQc3zytooDLLUAm0PwR+GQQN4Wc4TRHnEZ4u83QRhEe0Xu8jpj1
         z1tILVY7BIDm8CTFHX5JHQEq8l5cZcFEoZ5wTyVHbK0tPjaZ96BESEV/RlgxQ9slqaLi
         WK95fe5FqOEDSd4clYWH9Iu5a422idA5w3NK/0wPPSF79rLVcNskZMRwOj+rxs3zxtZH
         k7wjyArp8IjE/uzz4VqJtkdS7VslJDmTrDzvFbFoHA2eZ2Uk3grG6WpdDcJ9BOErfem9
         RWvyqNq2Bx87CyOZmjHHxD3pqkgyjJjrAjlMNwcigxFpzNAXzA/PcsOX1cEirDCpL9L3
         ur5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790238063; x=1790842863;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TBbUmiE2dRkBbSKytOyHEBRYcqAsz7TnE/aajFa/CtM=;
        b=RZodKpV9WPcWACrZoBowbcRC1V7CvSzD2Nx6hR87gGyIHVpc27YE/Tts2hkpl9y/+N
         WRgq0SkJCrbiXIjK2p19+BtRRoIvYqv3bjOGhQd/BQiaCKTFN/1OKJDPKCAov1IWhKSY
         Uctl0xKgNapw2mHNzrQoIpsqu07Ul6XRlJaFqoMwO2KNnj5NNtpI9kIJdwZ0xafpDPCm
         mg1qTibzaQ7y4ZM5gFfkn+iK7YeaaJc/wsTnpUoOtWr1CtlPMMCUs5fOAqLpiKQwCKSR
         IApIVidC4d0jSbt8LnbelKOK2wY+sIRscpglF7AWGTva/Ty+3U6+3kzcsO8v/H/OoWKp
         12wA==
X-Forwarded-Encrypted: i=1; AKwUvBzWflNYXD4Vv9JcVrnVk+iY1CD83mI3oNflBMDCHb4xzTIiiKlepwAiHFGGGvAIQLyRzBIFWHzShHQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mO1+MLOSRD0bm0yHXgXZ9tBy6/Hjz0xR2WgFWlVF6A4FPIAUsC
	TVwzhVxnjg1oDsGuQ2AOvUbQBOfMTJ4xWI76Oj9LmBNo/KDaRwq9FPagoC+3Ya0kdQ==
X-Gm-Gg: AYBFou0OlpoGYqNtEDDsWoZ15FnDNu5cX1S5OUPmeUNxljLXuVEF3c72fSaQFmCl/yw
	fi+nY+JCAN3/P1Z4tcrHJfS8pe0O0fqD5qIU+EWmhwoN3po4ajUX8I4t2PAZve8Y6+NxWfMh3eI
	N3dAloVeabIk26LnrIyUWLeVKGBEiuDvLexebciWWcagVjmGeGCt30MLN0rQ11yjqSC8YkQcJBJ
	02OTnQ0D2DFReCCxd3U9a3vSDwa9G67DQS+MN36XHOJ8b6cHtwkNbvbp5rhjDTrM3mxb2V9vStr
	8NxtwpBEWcjLTzegtbzFOs/cdhPWNhrZBgh8m/NO8pooPzB4bHtVI31RsFk4GwifQ1rc/JCq1Iu
	PXBj+jFtuY3pCkcY+3c3uNUQrSQY6BbHPd3vCbqQZb2BEQbWjtpRylwrB7tRx2agrim/2FMDr59
	g5qMK/ypSDIF0mElOANB0ufL8Hq1PZzys0+ibFuG5UObt6gPplstiqLT79Tje/6MjvsRWy4aBhQ
	RgJI4P5lQzxg4GYb9EilGpxT1JzhG9nna8ia8ld
X-Received: by 2002:a7b:c4cb:0:b0:49f:c839:28be with SMTP id 5b1f17b1804b1-49fe5996dc6mr523225e9.3.1790238062399;
        Thu, 24 Sep 2026 01:21:02 -0700 (PDT)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4886876c119sm14042034f8f.15.2026.09.24.01.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 01:21:01 -0700 (PDT)
Date: Thu, 24 Sep 2026 08:20:58 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Pranjal Shrivastava <praan@google.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org,
	vsethi@nvidia.com, Shuai Xue <xueshuai@linux.alibaba.com>
Subject: Re: [PATCH v6 06/17] iommu/arm-smmu-v3: Don't rb_erase() a
 never-inserted stream node
Message-ID: <arTdal7U8eK9Z_7j@google.com>
References: <cover.1790188510.git.nicolinc@nvidia.com>
 <76c5f9dde30269995ef842a12a3a5e1ebaa3e6df.1790188510.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76c5f9dde30269995ef842a12a3a5e1ebaa3e6df.1790188510.git.nicolinc@nvidia.com>

On Wed, Sep 23, 2026 at 01:11:25PM -0700, Nicolin Chen wrote:
> arm_smmu_insert_master() skips inserting a stream whose StreamID duplicates
> one the same master already owns (bridged PCI devices can present duplicate
> IDs), leaving that master->streams[i].node zeroed and unlinked from the
> smmu->streams rb-tree.
> 
> Both the insert error-rollback loop and arm_smmu_remove_master() then call
> rb_erase() on every master->streams[i].node unconditionally. rb_erase() on
> a zeroed node sees a NULL parent, treats the node as the tree root and sets
> root->rb_node = NULL, silently emptying the whole SID tree and breaking SID
> lookups (and DMA) for every other master on the SMMU.
> 
> Mark each node with RB_CLEAR_NODE() after sort_nonatomic() reorders the
> array, since sorting relocates the entries and would leave the earlier
> self-referential RB_CLEAR_NODE() pointer stale. An un-inserted node then
> stays RB_EMPTY_NODE() and is skipped in both erase loops; inserted nodes
> are linked by rb_find_add() and erased as before.
> 
> Fixes: b00d24997a11 ("iommu/arm-smmu-v3: Fix iommu_device_probe bug due to duplicated stream ids")
> Assisted-by: LLM
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Mostafa Saleh <smostafa@google.com>

Thanks,
Mostafa

> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 5732f3ba0122d..082da3dc09e56 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -4122,6 +4122,13 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
>  	     sizeof(master->streams[0]), arm_smmu_stream_id_cmp,
>  	     NULL);
>  
> +	/*
> +	 * Clear after sorting: RB_CLEAR_NODE() records the node's own address,
> +	 * which sort_nonatomic() invalidates by relocating the entries.
> +	 */
> +	for (i = 0; i < fwspec->num_ids; i++)
> +		RB_CLEAR_NODE(&master->streams[i].node);
> +
>  	mutex_lock(&smmu->streams_mutex);
>  	for (i = 0; i < fwspec->num_ids; i++) {
>  		struct arm_smmu_stream *new_stream = &master->streams[i];
> @@ -4154,7 +4161,9 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
>  
>  	if (ret) {
>  		for (i--; i >= 0; i--)
> -			rb_erase(&master->streams[i].node, &smmu->streams);
> +			if (!RB_EMPTY_NODE(&master->streams[i].node))
> +				rb_erase(&master->streams[i].node,
> +					 &smmu->streams);
>  		kfree(master->streams);
>  		kfree(master->build_invs);
>  	}
> @@ -4174,7 +4183,8 @@ static void arm_smmu_remove_master(struct arm_smmu_master *master)
>  
>  	mutex_lock(&smmu->streams_mutex);
>  	for (i = 0; i < fwspec->num_ids; i++)
> -		rb_erase(&master->streams[i].node, &smmu->streams);
> +		if (!RB_EMPTY_NODE(&master->streams[i].node))
> +			rb_erase(&master->streams[i].node, &smmu->streams);
>  	mutex_unlock(&smmu->streams_mutex);
>  
>  	kfree(master->streams);
> -- 
> 2.43.0
> 
