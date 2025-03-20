Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01281E25EB
	for <linux-cxl@vger.kernel.org>; Thu, 20 Mar 2025 16:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742489977; cv=none; b=IiqN9P91z/A6gobCCl8J2Vs053XDVxEGE9YwI9eHJ+NMPObn1tjB4VrxsmMIeQYeHonoOSNGpXOWhuxBXrYN/UKsF/IVlRzC1SV8ipVaXZkXRld6Q0PquV4Qx3T9u8Pi3J1QvCEbN4IpplTjvoqtCtTTkh2BxeHBA77XaaQeJh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742489977; c=relaxed/simple;
	bh=1Yk7hgNgZeHmwZa8RkOaLbHEcPIA8EWKztrD4+fPyyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HhSTzdb/lWHeSP7XrUzUlsbGUrRX61qszWtYPgGnJPC/7QmtRTXIXuMktxwOB+8eYweKKSRcw58+Rt95KRtwXFDc5lsvrSRgUtBRjxAhHhfHpl+iB2EebXQDjmL1uX8s6TaSuqfEOAYN0Hmgf8FuZ7rzWDko+31XDpQakdB/xOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=dPzcQ9fa; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="dPzcQ9fa"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c5b8d13f73so34117485a.0
        for <linux-cxl@vger.kernel.org>; Thu, 20 Mar 2025 09:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1742489974; x=1743094774; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ipib33z3sn+yQKX9c566UprPG9ZeHYaheF0uNRUCV3M=;
        b=dPzcQ9faTxWJ9okbH/bncnjZodsRWNYW5ufiWdJOmnnaeFltcSYqqphKZzzeAUTrZx
         ZpObSzAEd6KA3JgjPFHY7IisPih1mcCXGGMdR3yXHjTYnu6J1HrxfpygizWbrLiJs9pS
         KNI9fSgR9JcFEVcV6E9PGKGkksiVmmCSFEtji3PP+J7kq81cH83NSn2k8aFgvB2G+88m
         n1j5mGruBfmTDcB5NSl61x5rRMcoEDiFca9x5a+SNfuMxB7Gt1diB3CQtqASDUE3UXSu
         kfErwEgM0LtNwqHqOitiZwIv5VdzNlSktI1Tsk0ml/P7JpN0HBztwkv1c6YiE1FetfQK
         UKyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742489974; x=1743094774;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ipib33z3sn+yQKX9c566UprPG9ZeHYaheF0uNRUCV3M=;
        b=ORX2lTldF1WC+2EK9Z4F6aaTBIxw37kgjWtyyqYQiuOVyTJ56Pj1Z5GES/LBhJ8JAw
         hr6dp/Xun4LabWgI5mpVL3hsGdmz4mUhK//vY1OinSg0xma5dtZYou7rfbcpCPwvNrmw
         UUTBcYKK7XPjyOr5HdJfjt7LYy0brJKW3LRtfO1X84N4HOj+YjEZprnxIfwGPbN/XeSk
         ePGXloqQdYQt4HebeaDxv3JGtqoZHSHFhH7Q+RVcq05SMi5ChufXth+xSg9W5Re2xbBM
         mk3Uw64DOHFk97S3wlnw3Nb1tixRWUgdiGJ8olnRqXX9az+n96UiZeqAlbG97ZrLg02W
         U5qw==
X-Forwarded-Encrypted: i=1; AJvYcCWslIzmwiP8ygxMRrdWHRGGKtl+GYi2uiPztXVHN0scbdq0Dx0UxpqBM2pp24hRJMOO+O5eWXXDfc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxfpnV6DhVEzMtK1JfekdVWry8szRZhcjpxOvR8fnNBKkLOoVj
	fma8zzHIPeGNSMocD9T3mybbfuMEFRv/M2Wt45xXS56G0B9sDa1WLGzDi1mNaiA=
X-Gm-Gg: ASbGnctFE1kZpGAmjMbx0I9uGME7Cg99rhODdqmBqXScQ0rBRm6LTcn3NCtT9LgDEpF
	KauIdw+KgihvLdSdl4P5hw/TfqmV1XPyLRhgAsaeRbk8mO44K4gWSL7FQBBSOb0V7EcxYKhQFhO
	/djryPWEMN52t4I7QCp6m301ddT/r7/xEO97gS6B+c+RU2NQqNks7HBAs3WZY8JFspFYcY0qP1j
	HIUrcqDv8/xRFniUFPhzB35VopjfcXRpCbmKJ/7gaCu82PH4hYeCfHcpyolAdXNGfyGIDGTy7FN
	ALNa5mV7tHHPISbaWPYUJ+07GSNF6f8ygFHK4Pwcjv54HuKRC+oFxbJJ5umaTapKK9uSZsdwZEc
	HK7mUgUl9h+WUDrLS5o2SRXQxAt8=
X-Google-Smtp-Source: AGHT+IElzU98u73kWcMh/UGf7sxJFt1GG443MOL7RYcIkJXTEKBGeUAa+MD93tb0ZxGrkPDd7DzAKA==
X-Received: by 2002:a05:620a:c4c:b0:7c5:5909:18d8 with SMTP id af79cd13be357-7c5b0c8875dmr458154585a.14.1742489974499;
        Thu, 20 Mar 2025 09:59:34 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5b92ec688sm11579385a.64.2025.03.20.09.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 09:59:34 -0700 (PDT)
Date: Thu, 20 Mar 2025 12:59:32 -0400
From: Gregory Price <gourry@gourry.net>
To: Rakie Kim <rakie.kim@sk.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	joshua.hahnjy@gmail.com, dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com, david@redhat.com,
	Jonathan.Cameron@huawei.com, kernel_team@skhynix.com,
	honggyu.kim@sk.com, yunjeong.mun@sk.com
Subject: Re: [PATCH v3 1/3] mm/mempolicy: Fix memory leaks in weighted
 interleave sysfs
Message-ID: <Z9xJdP29XEz6CljB@gourry-fedora-PF4VCD3F>
References: <20250320041749.881-2-rakie.kim@sk.com>
 <20250320054010.914-1-rakie.kim@sk.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320054010.914-1-rakie.kim@sk.com>

On Thu, Mar 20, 2025 at 02:40:01PM +0900, Rakie Kim wrote:
> On Thu, 20 Mar 2025 13:17:46 +0900 Rakie Kim <rakie.kim@sk.com> wrote:
> 
> Hi Gregory
> 
> I initially planned to separate this patch from the hotplug-related patch
> series as an independent update. However, after reviewing the code following
> Jonathan's suggestion to consolidate `kobject` and `node_attrs` into a single
> struct, I realized that most of the intended functionality for Patch 2 was
> already incorporated.
> 
> As a result, Patch 1 now only contains the `kobject_put` fix, while the
> struct consolidation work has been included in Patch 2. Given the current
> design, it seems more natural to keep Patch 1 and Patch 2 together as part
> of the same patch series rather than separating them.
> 
> Rakie
> 

The point of submitting separately was to backport this to LTS via
-stable.  We probably still want this since it ostensibly solves a
memory leak - even if the design is to support this work.

~Gregory

