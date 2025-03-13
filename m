Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B91268C57
	for <linux-cxl@vger.kernel.org>; Thu, 13 Mar 2025 15:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741878164; cv=none; b=VJhBQfdVDmB8rgsmtalWAwpygfoNpZymdwcMA/Vg1KfO0IPAGqosTj4twrMROPm4v3XkEO8cOvOAJ+tRIAxFaZKOZbfk2gkR5SqhrqJ4yelsAorSOHHygnhK6ncUWHgV/8wdg97E/J3sc2hiWrPdzclnFqo9QefiIbAYLURCWcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741878164; c=relaxed/simple;
	bh=7zDs/4jK42T9rjEWm6oQy/xsWRIMK8LilWON+YAA9gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RRtnAGIhToDsA9AHRkvm9QmzBWoayWMxNAzncXub7m0bBmFbGD8V/zXWnK5cBjYjXt+b5I74b/m8/rhmGJ2VNfp1XpMEs3jkD2fMciq44JMf7HJ1za/nDBM9kQPxe3FokFxIxRGpWp2/20AysRK9j87dbYP2h+8+Ouapverhx+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=SmhlXohl; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="SmhlXohl"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6dd420f82e2so15389926d6.1
        for <linux-cxl@vger.kernel.org>; Thu, 13 Mar 2025 08:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741878162; x=1742482962; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZHY1pG2tvmLOjvUIEAkagny8teglkhED6Z4pC45W9lk=;
        b=SmhlXohlhOkw1inTkuCmudxJb2FtoXioVgM0AuPDIpjTaw4nhQDVMH33mTYf0ayYh3
         NlVUxUQpMSsWyvFZ4d6wJwbdCxwDNqNuoIXnLomTJgKbBJsxXtDDtwqZlyxtUYtZYp7T
         XUDnY2u2/GQdNS4oVr2MB5MGrsbEwlmBW7yiVBqcu7O1dEhmzbTio+MZD7FBpd+dbNN9
         GW+Tgn+xricC2tjHWeXkWOvChI6dSx7hera8rrWEkFlXxZYh9mgK29Ue/hHDNaNBzZOt
         d4SCQKtNU82r0c0NXdkmMNJFuIokn2w4a+8KaJc+WUSbPtqMP729pE4a0arqDEF4glJu
         ubmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741878162; x=1742482962;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZHY1pG2tvmLOjvUIEAkagny8teglkhED6Z4pC45W9lk=;
        b=lKmC4OudLhTkeNEuXcq6+e5bDtvYTQttaXlcfL+I951tnyHlVrgu1bJYLufzkmXA4o
         cr7/04L0eA5L4Z0RWKkibKuCEDp6PL1qIrXLqHEGQ13SV01NTQuQ0Y+zVBl50N1n5HEZ
         DLGuO0IchdvggqlUa3TJzoUugr0NX8haIhfYgrt+LP5EkDcIqPcx8p8m2Yz9C3HaiW4F
         vKrfRcgJkoJW6nC4DQXwtA4uiWNxci6voQeh668TauiNJ2be6Kv/xYTD/HSRdGmvUZ/K
         vMTgjXFe5ukSnxfEZXZgOs8iWOVlvdLk1+oTo6DggOCa/mUpLLg9LRtIpi8eOK8UAJeo
         LS4g==
X-Forwarded-Encrypted: i=1; AJvYcCVF1vdwGXEqgSpIFv5Hw7ng3KV41tWXzZ6YHEkIWiHgAHRyb9VGbRWs0zh9+TRfVl+PLNqBw76KkgY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN7lR1knMkPwDMppVTIbVRpOJFHvRs/lCM/HHlWKz70lPxpwdb
	dKn3krbObFnlEuZuqYjccgAE39oOglfRjzZV8Qta2DoP0a1pMs5kKNasi8Iq9aw=
X-Gm-Gg: ASbGncs9P6Xiw84/FJ9MyQlWV12UERqQokVitgFoZZ6UpLZemNefOZ/HSqDdeO+qhy6
	9js0091oMCxvaJr0OffqyGKw31Trrf9kLdcU9P6VUKYu5HTs7/ErNFVd7Er+VKnF/vapsC12QUH
	6ETSQe7z0H08R2Yv5MmU4Lrwuxxrn12pRzYfBIa1melpB6peZFx+pvObj6qCFNn7A+qqOvN94/P
	VjhvbdtoVez9sMcREUFk5jLXeJpIZgNthuS8R0OxGPKUrCj6vZfs/dHwBrL2luLIyl4GM4ktlQS
	MWfr3j9olHLj55zLjIuFoN+PSQ41e6PECJeZHCLJM80HMrGx2C0FiylEYgRyfO7awAETRqG3DNH
	AthzfjnWWZ/bTiuKXiasE5ltLpXXseOP2RTn1tA==
X-Google-Smtp-Source: AGHT+IFAMWILyZ8bMRGv7bdKKe5rM96j+5H6aHjq4gkCifNGEy5AffkMBaHGkUHELx5174kUe35U8A==
X-Received: by 2002:a05:6214:518f:b0:6d4:1680:612d with SMTP id 6a1803df08f44-6eae78613admr673006d6.0.1741878161817;
        Thu, 13 Mar 2025 08:02:41 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade24d025sm10481686d6.51.2025.03.13.08.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 08:02:41 -0700 (PDT)
Date: Thu, 13 Mar 2025 11:02:37 -0400
From: Gregory Price <gourry@gourry.net>
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
Cc: rafael@kernel.org, lenb@kernel.org, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com, rrichter@amd.com,
	bfaccini@nvidia.com, rppt@kernel.org, haibo1.xu@intel.com,
	chenbaozi@phytium.com.cn, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2] ACPI: NUMA: debug invalid unused PXM value for CFMWs
Message-ID: <Z9LzjQCKFfsdE2yJ@gourry-fedora-PF4VCD3F>
References: <20250313060907.2381416-1-wangyuquan1236@phytium.com.cn>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313060907.2381416-1-wangyuquan1236@phytium.com.cn>

On Thu, Mar 13, 2025 at 02:09:07PM +0800, Yuquan Wang wrote:
> @@ -441,6 +441,11 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
>  	start = cfmws->base_hpa;
>  	end = cfmws->base_hpa + cfmws->window_size;
>  
> +	if (srat_disabled()) {
> +		pr_err("SRAT is missing or bad while processing CFMWS.\n");
> +		return -EINVAL;
> +	}
> +

I thought the srat was optional regardless of the presence of a CFMWS.
Is this not the case?

~Gregory
