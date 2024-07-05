Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672CB14A08B
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jul 2024 14:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720189463; cv=none; b=PF6e9Ybi4ViAee+9/RCwmQedNrn8Pa7EKaPlIzaWl4ntsZ2jfOVehBodWmMG6pFHx473aLkLBIabBpRyFh/OESJNUycol/co8hygk0CWjla2+8mgN9b5R/Qy91OuTR8B0fxDshCRk7K4M0ZGU52pEDFMZQS1Kz3b56rUr5z7wLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720189463; c=relaxed/simple;
	bh=ezE9cMK85xGULq2NDfyultVM78ZkLbyifJxcFeIVVd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=khlyFIkNlUiDDLvP85DVGdCsToSIdemUd/Pe5rz6mhswajcXtWFEJwQlaDtMO/89qS0Ox1129uUenXWdoVKMxgLWw7TscYzIEPROQ0ozzDa3fUYh1T6LmsdK2SuqGbOZiSYyoO2d4JOAk2Eh2HDB3fbwgG9+OTjg5T9HY193Lss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GomyGT6q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GomyGT6q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720189460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IqBTg61cVL77faXIzfdAxULAIPGMk1ZHXjVPHmfrZtE=;
	b=GomyGT6q4Dkoew0pCRUYAoml9aFCdZYOXIEQEjz64CtThBXoFF7Mra3soyxFZs7BYZGnr4
	vzGyfb+mUwBbgyhfR+bveNOh3TOMIFBnkRrYodstWMD/mhDtfkrnQteBVO2+kFcUWqNqxi
	S8ghGxK+13S2T1g7QDuve6Z+12fHe3M=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-73HL6s-5OdKBIqL-uJASsw-1; Fri, 05 Jul 2024 10:24:18 -0400
X-MC-Unique: 73HL6s-5OdKBIqL-uJASsw-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-446405b39baso3463641cf.0
        for <linux-cxl@vger.kernel.org>; Fri, 05 Jul 2024 07:24:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720189458; x=1720794258;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IqBTg61cVL77faXIzfdAxULAIPGMk1ZHXjVPHmfrZtE=;
        b=CozkhM3AJgWU33mh6ztuapI4zvWZ1mje83pfp6BKMnpaWJBiGkP3JR06mBWVGHW3vY
         GGGBn8JhQLjIkTAFr4cGZV4MraURsgnxnCuSPrJCi3oGmTh4EhSj7/mSbW2YOPyxGYeM
         EBBHjIk8fuJZ+n5PG8aqBNQ2uGum1lV2prKRyS5Fd7vM+W5aSWD/0sgj1o2HSFukKVe5
         p2D6XOt3kgz0AFdgrBwGXAuqs1rgkFHlcrOSKP8J/nuJyoGhvjCru1xXBwolTTDroLEv
         7gmMn3Mo7Hc0oVHnhi7/6XkDyStm85FdRGxND4aNu7GGh7htzJATlGiUP9ZLr/65brqE
         CkLQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6DfrAjzpdTCClC2gGJ6XwHFmQQUbfR2qBnxQP/kJ7gyH3Y4M+uad20JL0y4YivG3TwFOttT768xG3BNelrpN+TRRG+jm/rX/m
X-Gm-Message-State: AOJu0Ywfie3pIzHClyIgid+NRbLMQi9LUBMObk6iTOWC1e0UWcRg0stz
	EOxxvjFcFuJYGu7CYwDMdtYmdEWAIhVej2D29VG6pZxJYcuk1peAPpn74tVPjBVB3ViPZDcmXHp
	tjiXtgxVEdQt8DYe+c25MW/if6gHefXR3zv0VqyCSvDL4AsG3mRp4b8fo9A==
X-Received: by 2002:ac8:7c4b:0:b0:446:395a:37c9 with SMTP id d75a77b69052e-447cc1cd760mr50256811cf.4.1720189458365;
        Fri, 05 Jul 2024 07:24:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKP4/uPX8iCeoUcNLMV3z8vBAByHvLymsXhgYIxVOYKgo8tVByPTMSYbiLBJ2KPlAF3hMSkQ==
X-Received: by 2002:ac8:7c4b:0:b0:446:395a:37c9 with SMTP id d75a77b69052e-447cc1cd760mr50256521cf.4.1720189457935;
        Fri, 05 Jul 2024 07:24:17 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4465149b579sm69523231cf.75.2024.07.05.07.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 07:24:17 -0700 (PDT)
Date: Fri, 5 Jul 2024 10:24:14 -0400
From: Peter Xu <peterx@redhat.com>
To: Alistair Popple <apopple@nvidia.com>
Cc: dan.j.williams@intel.com, vishal.l.verma@intel.com,
	dave.jiang@intel.com, logang@deltatee.com, bhelgaas@google.com,
	jack@suse.cz, jgg@ziepe.ca, catalin.marinas@arm.com,
	will@kernel.org, mpe@ellerman.id.au, npiggin@gmail.com,
	dave.hansen@linux.intel.com, ira.weiny@intel.com,
	willy@infradead.org, djwong@kernel.org, tytso@mit.edu,
	linmiaohe@huawei.com, david@redhat.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de,
	david@fromorbit.com, Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 11/13] huge_memory: Remove dead vmf_insert_pXd code
Message-ID: <ZogCDpfSyCcjVXWH@x1n>
References: <cover.66009f59a7fe77320d413011386c3ae5c2ee82eb.1719386613.git-series.apopple@nvidia.com>
 <400a4584f6f628998a7093aee49d9f86c592754b.1719386613.git-series.apopple@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <400a4584f6f628998a7093aee49d9f86c592754b.1719386613.git-series.apopple@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi, Alistair,

On Thu, Jun 27, 2024 at 10:54:26AM +1000, Alistair Popple wrote:
> Now that DAX is managing page reference counts the same as normal
> pages there are no callers for vmf_insert_pXd functions so remove
> them.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> ---
>  include/linux/huge_mm.h |   2 +-
>  mm/huge_memory.c        | 165 +-----------------------------------------
>  2 files changed, 167 deletions(-)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 9207d8e..0fb6bff 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -37,8 +37,6 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
>  		    pmd_t *pmd, unsigned long addr, pgprot_t newprot,
>  		    unsigned long cp_flags);
>  
> -vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write);
> -vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write);
>  vm_fault_t dax_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write);
>  vm_fault_t dax_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write);

There's a plan to support huge pfnmaps in VFIO, which may still make good
use of these functions.  I think it's fine to remove them but it may mean
we'll need to add them back when supporting pfnmaps with no memmap.

Is it still possible to make the old API generic to both service the new
dax refcount plan, but at the meantime working for pfn injections when
there's no page struct?

Thanks,

-- 
Peter Xu

