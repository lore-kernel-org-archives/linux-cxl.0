Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0045926ACD
	for <linux-cxl@vger.kernel.org>; Thu, 13 Mar 2025 15:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741881143; cv=none; b=nArd2CbAksipSSa4NTBnihvP1X3uqNwdk3o1jsyUiyWRo/NJJtIIIhJ3ApqxWhlhUWF4xt4vk/sMEioIhyFMQxBAKjc15T/gyZzHTjT13yNA3sjhrkzklCdDB3bnqycHWiEdIcTJ/F4k3YMyk+/eCmjaoOKvaE0KiMWHxn30yJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741881143; c=relaxed/simple;
	bh=A8AtJQ9TXJXCum6G19u7JfO6nSprHwo4DLUis4JKzdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m4zPdzvcvPGK2kBRLN36mk0QSbqppLmw9Hf37g5V4BU7VjjdPacBLbBmOhTOsAetC5v/sym8QZNnEDpB5+gRi9h8uOQNyEHu28eS1OSZGclXwYN1FHB2dRyqFkVs6yKN5l8VHQOzubHwcUUFQkH3jNSp2qy84Yb9mF4blbJPD4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=irWk5vig; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="irWk5vig"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c07cd527e4so91105685a.3
        for <linux-cxl@vger.kernel.org>; Thu, 13 Mar 2025 08:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741881141; x=1742485941; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4w37FL3B+Ve9xBUgAXtVYhnw9ChVr8Pqzg/e4uFmP8Q=;
        b=irWk5vigg7fORmZoRWqpPeLUaDAN45YovRW/66jhxR/2xAquXaqFgpd6uUdmys7t7l
         d4Oo1tq1RrUC+9OeXJtzQZbJVZ1WFsVdTRVz5dWXEp1nO3hVJ6OTTj1pgOmzXlWBwJb+
         4ohIebc/XcH0muc6t0lbKcEzws/eyP9JK54a/2gJUSb5+lwsFeQMqNbDrTgjihofgq2p
         jhKNs9UG1Hfcvxl6i7N5RwM30jCWC5EvBsWtRmDUMbj9TIsUlq0fkgqpbFAdaTPZ6bQ8
         q5ixIT0pH97SBXTQ83kwGtJVFHOUWvvRHGTEQeYWKwlRgWwaO9vdRfb6WqW7o9p68p+j
         hbxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741881141; x=1742485941;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4w37FL3B+Ve9xBUgAXtVYhnw9ChVr8Pqzg/e4uFmP8Q=;
        b=a5B54ZrAd7oVJODHSsAmPnrjqU2NVhsFlk5CCmkMyB6IWKIPbhOodObsRAPEE3pJ7V
         wQtthDpQiV+QBt9nGQSTU+I9TEzKNSfqvpTWtRaEu+h8byBZO4wiDbUmrG57KX1nXYAS
         GjGYtu8UYzgrsuDIxdjXIB/haU03ed7i6Dd9/zLL14TNoxa4MzfarrJgJjYU2CfVWgg2
         btXwjHLmDzo8cG9No16b+kYPW308f35E7RK09zvO1UgA5Bcjeg4AmcA+1o7zluKo33Dw
         iCw082U90nQVRQ606OKlf0sc2XxvEP51B8h4+DpuQpqKFup5l9Vo0borDXjz/ENFJ5zW
         uDIg==
X-Forwarded-Encrypted: i=1; AJvYcCX3FAQBwHyQb0yIOnbsx1ZCOaTuHsY5KstZRsNSdViJ0/5JR34bRpQG6WNzO2FL1RGHHL6ZcU/s1FY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDxPfyz6YMyUJ4WKde63JQv/IU6+UR4ALCyV5Lh8U8uq+IlmXf
	h5ycWHIGNzctZKDAV97otzhWXhKCvM/TWRSnvkNEbgp/gW24ABlAabtoGxsugB8=
X-Gm-Gg: ASbGncsPx6v0KFsOTdWFacxZ+w5iAxMxcXGfdZV2hg4afQsbEPP1UXLcDG9PlJkergM
	AFHKSOTytgtqeqfELagHfWjeO4bUum68Rtx/vonxswp6O/4c64K/T/+IxmcVGfD41Nz2JfS7Sxj
	FG4JkC041Cgu6lc7cebMnfsMYqKEgKzpj8+D1bMQ0tODEnQzLSvRrrb2HORgvMmgdZTZQ8/SVZI
	mKtHoAQPb124XOj07sDIalcTHKLVMbXZ5gTfk2absRJluxUSJgzctpY59Un3sZ7SH3D3b4eAoy7
	wQzj7xbo3ojFrQk7UaiZkpPs0+z2ZlifFOphhlGW1q0QQ46yk0skPVRxpOGCQMkcKNATWevmxjW
	NV8Ff65sQL5E9q5hExSPVcd1YRU4=
X-Google-Smtp-Source: AGHT+IEsoyWweiNgBmaWSKSfpN7pyNhVfLT8lOAAvmtKf+Ddah15RIIeIcih94D/NjT9dh4sWhGcyw==
X-Received: by 2002:a05:620a:43aa:b0:7c5:5909:18f3 with SMTP id af79cd13be357-7c55e90fe47mr2004594185a.37.1741881140875;
        Thu, 13 Mar 2025 08:52:20 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573d89815sm112187185a.91.2025.03.13.08.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 08:52:20 -0700 (PDT)
Date: Thu, 13 Mar 2025 11:52:18 -0400
From: Gregory Price <gourry@gourry.net>
To: Rakie Kim <rakie.kim@sk.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	joshua.hahnjy@gmail.com, dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com, kernel_team@skhynix.com,
	honggyu.kim@sk.com, yunjeong.mun@sk.com
Subject: Re: [PATCH v2 1/4] mm/mempolicy: Fix memory leaks in
 mempolicy_sysfs_init()
Message-ID: <Z9L_MgjuhrploEUm@gourry-fedora-PF4VCD3F>
References: <Z9Gs8i1FhJJ0eaiA@gourry-fedora-PF4VCD3F>
 <20250313063247.681-1-rakie.kim@sk.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313063247.681-1-rakie.kim@sk.com>

On Thu, Mar 13, 2025 at 03:31:38PM +0900, Rakie Kim wrote:
> > Is this correct? If kobject_init_and_add fails, from other examples we
> > need only free the mempolicy_kobj - because it failed to initialize and
> > therefore should not have any references.  I think this causes an
> > underflow.
> 
> Regarding the reordering of mempolicy_kobj allocation:
> 1) In kobject_init_and_add(), kobject_init() is always called, which

Quite right, mea culpa.

> 
> 2) The release function for mempolicy_kobj is responsible for freeing
>    associated memory:
> 
>    static void mempolicy_kobj_release(struct kobject *kobj)
>    {
>        ...
>        kfree(ngrp->nattrs);
>        kfree(ngrp);
>        kfree(kobj);
>    }
> 

I see what you're trying to do now after looking at the free-ordering
at little closer.

Lets do the following:

1) allocate node_attrs and mempolicy_kobj up front and keep your
   reordering, this lets us clean up allocations on failure before
   kobject_init is called

2) after this remove all the other code and just let
   mempolicy_kobj_release clean up node_attrs

3) Add a (%d) to the error message to differentiate failures

This is a little bit cleaner and is a bit less code. (Not built or
tested, just a recommendation).

I'd recommend submitting this patch by itself to mm-stable, since the
remainder of the patch line changes functionality and this fixes a bug
in LTS kernels.

~Gregory

---


diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 530e71fe9147..05a410db08b4 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -3541,38 +3541,34 @@ static int __init mempolicy_sysfs_init(void)
 	int err;
 	static struct kobject *mempolicy_kobj;

-	mempolicy_kobj = kzalloc(sizeof(*mempolicy_kobj), GFP_KERNEL);
-	if (!mempolicy_kobj) {
+	node_attrs = kcalloc(nr_node_ids, sizeof(struct iw_node_attr *),
+			     GFP_KERNEL);
+	if (!node_attrs) {
 		err = -ENOMEM;
 		goto err_out;
 	}

-	node_attrs = kcalloc(nr_node_ids, sizeof(struct iw_node_attr *),
-			     GFP_KERNEL);
-	if (!node_attrs) {
+	mempolicy_kobj = kzalloc(sizeof(*mempolicy_kobj), GFP_KERNEL);
+	if (!mempolicy_kobj) {
 		err = -ENOMEM;
-		goto mempol_out;
+		kfree(node_attrs);
+		goto err_out;
 	}

 	err = kobject_init_and_add(mempolicy_kobj, &mempolicy_ktype, mm_kobj,
 				   "mempolicy");
 	if (err)
-		goto node_out;
+		goto mempol_out;

 	err = add_weighted_interleave_group(mempolicy_kobj);
-	if (err) {
-		pr_err("mempolicy sysfs structure failed to initialize\n");
-		kobject_put(mempolicy_kobj);
-		return err;
-	}
+	if (err)
+		goto mempol_out;

-	return err;
-node_out:
-	kfree(node_attrs);
+	return 0;
 mempol_out:
-	kfree(mempolicy_kobj);
+	kobject_put(mempolicy_kobj);
 err_out:
-	pr_err("failed to add mempolicy kobject to the system\n");
+	pr_err("mempolicy sysfs structure failed to initialize (%d)\n", err);
 	return err;
 }

