Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CEE1FDA
	for <linux-cxl@vger.kernel.org>; Wed,  2 Apr 2025 05:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743570953; cv=none; b=LRVT9gK9W1mjQYSLRXpThPF0OY+P5eBmQCofdiZapumhtcuvbbPPkIxmS1pc7FWUpuKMe7IPED8dP4syxyGIVhsruxAYHEwdCDTb24Q/GgxaXjLm9/FdUhHPU0hGedpv5ro1TNIQYyiX26NdURXtSmx4PgpLuFVOzdbQ92B41y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743570953; c=relaxed/simple;
	bh=bWPpUkos2jEtKhkovyKjA7nDv4oSfAEjB/EGeL+mVxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rdignwblNg8riqoEw9dWq4sG0KlXAt7Sk8XcxqH4n9yaKEek+ZtiOg0PMSoBaFKPnOx1rNAOS8oJtYGAOhYFR8YqoGbMj4e527Nqf/sA7Uwkz2CY5XBgJUV4iVuXDhpUpMEfpERsrhCChg6HHBcXrRaQqeD9iVwklx+zLNcIsBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ttR4NMtK; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ttR4NMtK"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4772f48f516so5097391cf.1
        for <linux-cxl@vger.kernel.org>; Tue, 01 Apr 2025 22:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1743570951; x=1744175751; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UBhayhNwyrGVLnHnARpnBOXHL1gt/zqo/tr6FDds1oQ=;
        b=ttR4NMtK/H38eDS2tIfHaLqhIIo3Oti6v8VEKq5Io1WU2NZlPSQfkFRUH0qvHyD1ac
         PiTyO44Gb12u/k4tqBeOrwqjmcqOmJU9jVhjv/BdYS325APoRrpaoDKcJGTSm0AAL+P5
         5ZADdMGFInd9iIXtQ4Dw2nM9FfP7/c+5TDIJ+G+jbB/lFFGUEh46UavhKN3jETpUc9U1
         CL/bJaO594zN6McEiTaiYYyCFOpOJHrF8D8pHHK/NVoX1TAzxQmIdFtFNTEgLr70WixV
         Y0+IKSCp8Z1kMFrfDX7pG47hyVA2810jGfi6BKm7xpXHvHh7Cl0t9qivUVfwFUmqH2B7
         gtjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743570951; x=1744175751;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UBhayhNwyrGVLnHnARpnBOXHL1gt/zqo/tr6FDds1oQ=;
        b=EB/C5PUmlGSzBPbc2LZwgma08aictShUptqGlJI77GWckbStfruSKAToCm18q/H0SF
         rrKZ9UgDpfo8l4KU7rCJe6RjdQLfz5h7/6gnATgab9SnbY2CTkG8lh0VIwoeCjJ96Ssg
         Xb4tYRpcdsPqBJKfBStP6dSaqgAYuFY+Gk7WpbUhfvmItUlpI+s3M23YzUQ5gEqGkloD
         YmtGy5nNH9uv6OwC4uz2hI/J4HOvCcny5e8usR6X6u7SiRM5YccJsxaa0YlmC4rIS4qo
         MqMuBZGRj1LU/0iSeq3Eb+ghLT1KFlu0PzRJTUZOUjDrCGDUpPOgqE26UJSjyyK0ZXaH
         teEg==
X-Forwarded-Encrypted: i=1; AJvYcCVn1cnkZZpPqWPHs7T/hyS/vFKDjSwvLEyAHbJ8d4nB/jV9d0YLfxAUc/YHRUhyJM2CIDQkIaV9dcY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxb/B3DxjpHRVn2ik6rVwZrTLU0bl18rRwyKu6Rr8HptS68Uhw
	DKYjA8usu6pyH4IINiYzEttVuxewdZUP897QB5BWvIti1JxfOxBv5w+NnnYfhpc=
X-Gm-Gg: ASbGncsgB8lIgvO6LVfBwnCHHT2K3NPqqnWJAzqdAWMZAdlKuWMAVn92hI0gtFr/4dg
	AZc3GpYFeZrb9Hc90H5TSHCtBpvzyX0Gv8RjXtzuvmFSR0+ef6BgmWR6L4UPMopwoDg02qKfqTR
	q+yMYBdGLNjoQ4qnCCyoZstrEkDZsOaIArjdF10eg1agBSoZ/wSINeHU2kzp+VgPKYS7RXa7duq
	YhCtXbrVaGX0+hT44XzE3Jxrk81sK4u2EHOKOdLmKiItImsSWKVElYCzYWwv1BVtIGynv0ub9nV
	2ak24Gs7xX2+sUlTGIauouiOMeyW9J75n0x7hOdi2Ve3aqUEM4CAxyQcgXy+kyeqw7I3Og2AzfO
	q4972H+pNm3dyrvxZqxPaFVSjv3o=
X-Google-Smtp-Source: AGHT+IG6cFDdBCUhJIJPUwLByZqnNAE8mx3kaNaRVSOgKBueJYVr4mwPJf5fLYFzpV4zids7Bu+0/A==
X-Received: by 2002:a05:622a:24a:b0:477:1dd7:af94 with SMTP id d75a77b69052e-4790ba8bf68mr8502081cf.2.1743570950681;
        Tue, 01 Apr 2025 22:15:50 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4778317ba85sm75550481cf.55.2025.04.01.22.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 22:15:49 -0700 (PDT)
Date: Wed, 2 Apr 2025 01:15:48 -0400
From: Gregory Price <gourry@gourry.net>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Honggyu Kim <honggyu.kim@sk.com>, Rakie Kim <rakie.kim@sk.com>,
	kernel_team@skhynix.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	joshua.hahnjy@gmail.com, dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com, david@redhat.com,
	Jonathan.Cameron@huawei.com, yunjeong.mun@sk.com
Subject: Re: [PATCH v5 3/3] mm/mempolicy: Support memory hotplug in weighted
 interleave
Message-ID: <Z-zIBM4zQ0LbGPYZ@gourry-fedora-PF4VCD3F>
References: <20250402014906.1086-1-rakie.kim@sk.com>
 <20250402014906.1086-4-rakie.kim@sk.com>
 <5462e706-5b29-495d-9af9-1945e8a5445e@sk.com>
 <20250401213439.4e7a124d94aa42603d31d45e@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401213439.4e7a124d94aa42603d31d45e@linux-foundation.org>

On Tue, Apr 01, 2025 at 09:34:39PM -0700, Andrew Morton wrote:
> > I'm not sure if this is going to the final version but could you please add this
> > patch to stable with Cc: <stable@vger.kernel.org>?
> > We might need to bring the whole series to avoid conflicts to stable tree.
> 
> This is all rather confused.
> 
> Do we need to backport all three patches into -stable?  If so, all three
> should have Fixes:.  Preferably they all have the same Fixes: so we
> aren't backporting untested patch combinations.
>

I'd just as soon leave the entire thing out of stable backports.

Only the first patch actually fixes a bug (very small memory leak
during system tear down, so it's not even a critical bug). This could
be added to stable.

Patches 2 and 3 aren't fixes, they're desired behavioral changes
to the feature. An interface being confusing doesn't mean it's broken.

~Gregory
