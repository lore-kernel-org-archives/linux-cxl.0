Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570E855C315
	for <linux-cxl@vger.kernel.org>; Fri, 11 Sep 2026 20:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789159007; cv=none; b=nLy+QXN2a28Q8wrG3W37Xq5URjgLSQNWHZGfgck4PM1rDrC+abDRpqU+eY6gOuo00Boj/Xkc1yMTiJjDQUyz8FAJ67dQFu9LAC7o+uxu74wDhddFnd/51+4gRNXhJkU02sCL0aGVlR2hJt6suL+gzLVVt8dd4J8bzfAwC/X6ffI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789159007; c=relaxed/simple;
	bh=EC+pkIlX+kgRA70DrrRqxPiFCmSwEvxflu1lTRjzdB0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QVH2cnDm9F37IJRVr3Fb1UwOugwgyKbp09dRYA3j0nEMt4XILSwj2fZCO07cWYa5QaRoYU9RWC9VLIXmSlXiy6PFx1tPP5Zur/uNqNzo0Za5bEnE1qZQ6gB+dLhso+Br6eq1X7C1FpYZqY7Cv3BJ0a2bcSBVOODfMhTQraT+zfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CatuidLS; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CatuidLS"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccb1a990so845a91.3
        for <linux-cxl@vger.kernel.org>; Fri, 11 Sep 2026 13:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789159006; x=1789763806; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=c8/mxVFLbAWrLtAdjW0O3hboJ3n0/xoGcj1njCyonOE=;
        b=CatuidLSLLk7RKpPAtDrehlWKU/bMMhO0g0MAr1tXtu9opUEBxaaEiEl1lqqWQBc5h
         NRpHitFSZ9X4LXqHJUmNDzqb43QJCM1uYDUA5hmgnx5GrL7DJ9DS8oczo+ewLdW57H+F
         gHwFIAYr/+cCWMdh0YfdTx8XKjjcVOfcvxXT+mDqCYhRIOjWr0YaNUGsEVDgWBGUcTNp
         U8b4EkNWIR4CiLr76YIbtv63lT7pfc4NWLmQQcSCPbmEXgglCtWxA7WsDAdQJfBj+VK2
         DZ2anvY21k90ejc7WY9S9c+blap3ab0bAcyLAfwoMmjReLNC3F4vUeKuDJfHyu5lvR5k
         pPcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789159006; x=1789763806;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=c8/mxVFLbAWrLtAdjW0O3hboJ3n0/xoGcj1njCyonOE=;
        b=cgLVV4xAn4ERhvqJWJ0eFsizN72MTElblCHLx478n6Ugf3ICFoiMAWVDHmPeggDkTx
         KfKk3YKRW145Be9+vSwWt1/2VD7iluAO0hX/1u5Q7A8Ut+SkruH2o+LMzklQClNKffIU
         e/m3OVAdOBfqoo6GvxcGxKbzTBiMDwNlXuBqsNmDgfR0wa1kJpOVsLGd60JeRE5N/66V
         bMWkEYIbH/C1F1Rk0hktoeAxKDm4KrAklPKbwr9YandwxkKFn0CuJYT7Rpv6MDLUT/JI
         R04b/BSO9akk9hBakSyCDW1INgFxZjnezEVtS9aYePxVd6EMJFeZvTNKMWs6Yw3anq6M
         lLrg==
X-Forwarded-Encrypted: i=1; AKwUvBxd7UCoIKm6hVZI+b1kFW2pjJtJ2wJy8OpgIjgiFFFkBYdMP39xUYjNHVYlefWukNF0FYMYHHaoiXk=@vger.kernel.org
X-Gm-Message-State: AFuF++kmeiDAyN8GUKr9i6nsMaeKJR/MgkzjllrUXVe1U6cZQYCc2O7T
	y8Ff+UZN4xe5dTJ10O2Dut8fB+JeAmqXN9pDWz5WwSL3QL4hr55546rV6eXrXA==
X-Gm-Gg: AYBFou2FC4uW9aO/RchPk3kBPy0jzuan30Znt2BrE7w9JqUEr62+k31LVtyjNDd6E/b
	0xb1qL14lwDNmnDih13dYqLZBSH6fOMD0tT8+UkFHFl0IQ571QD1cJ0rQ4IgrVG4fttBslAQWmO
	5iO1ze/A5JycjNuPKwxiuSxreUaXu8HogyKwfFKlwkJg4cuPj5gon0y5IC4OnlFocrgG+EF1JMI
	tM4gvwEHfUHYc87P8SF3ZOODGzwITl7uM1y95rCJNGLUVmTGtaO8EyXdAXMqFm74hWY1wN/TS67
	sh4CXgCbVuguttCYXIU5rLiSM46Rjr/a2hJ8iwFi1Hs4OYuWgL5svd30XJuot4HaGk79EKEGCJB
	mNE1Q1bvbsI28DjoFZePCHgwe5NAkIrXBpLJYZlPr9VbgHG6fNhxthGMS/vzsPqdEAbBbQbR+V2
	Gm8lgijUCreRL0lsomWbE+46YQowDx7Z1ZrxYgiGdb1TRKZAmh3zr51iOKT1HBi0KZb1BcH86Np
	8/8BRz+R6GqRofOYSQGcS0qFQ==
X-Received: by 2002:a17:90b:3903:b0:38e:659b:f366 with SMTP id 98e67ed59e1d1-39dbbc90260mr27915a91.0.1789159005565;
        Fri, 11 Sep 2026 13:36:45 -0700 (PDT)
Received: from cxlqual ([220.120.90.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d951d1056sm6455386a91.7.2026.09.11.13.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 13:36:45 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Sat, 12 Sep 2026 05:38:01 +0900
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: Anisa Su <anisa.su887@gmail.com>, linux-cxl@vger.kernel.org,
	alison.schofield@intel.com, jic23@kernel.org, dave.jiang@intel.com,
	gourry@gourry.net, icheng@nvidia.com, ming.li@zohomail.com,
	vishal.l.verma@intel.com, benjamin.cheatham@amd.com
Subject: Re: [RESEND PATCH v13 8/8] Documentation/cxl: Document DPA partition
 layout and ordering rules
Message-ID: <aqRmqRh89HEtlWS3@cxlqual>
References: <20260908102124.2231730-2-anisa.su@samsung.com>
 <20260908102124.2231730-10-anisa.su@samsung.com>
 <5bd5dbd90d5029f92232d8b8f18318d4@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5bd5dbd90d5029f92232d8b8f18318d4@stgolabs.net>

On Wed, Sep 09, 2026 at 08:19:54AM -0700, Davidlohr Bueso wrote:
> On 2026-09-08 03:15, Anisa Su wrote:
> > DC Partitions complicate DPA ordering. Add a DPA Partitions section to
> > cxl-driver.rst describing spec-mandated and Linux requirements for the
> > layout.
> > 
> > Suggested-by: Gregory Price <gourry@gourry.net>
> > Signed-off-by: Anisa Su <anisa.su@samsung.com>
> 
> Aside from removing the last paragraph per Jonathan’s feedback, perhaps
> update the maturity map as well to keep this in sync for when big features
> get it.
> 
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

For the maturity map part, I have another commit at the end of the full series
that describes how DCD works from extent record --> dax device
creation/tearing down, so I could update the maturity map in that
commit, when DCD becomes functional.

Thanks,
Anisa
