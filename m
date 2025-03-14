Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A994A1FF7CF
	for <linux-cxl@vger.kernel.org>; Fri, 14 Mar 2025 13:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741959757; cv=none; b=Bnvrk4x9C9r9gM6JM78mCIQFtblV6BmCZMCu50kLukb09URtcoePqRxcEojmvtVfGj4I3r7zR3noiaOvzE0ypM0iOqqGoDdMVpLRWlivIb5BPTHpAApe5dLHbBbN59BnbnbYT57aR1wPxVIqptC/MunSAGLskX0NSdShoDuTd94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741959757; c=relaxed/simple;
	bh=9LDdxVMmfAwVLZ75Sv27qRjzqf3Pi98p73DWbKx/oMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qo+mXvXnV4Wo7K7kaC/4luLZpSXNvxByg+zmZd6tmHPPPm93EIN02bgL/9oTC6yDTsQ/LXVvAldxYR3lHf8Iq+7n061W6yxcRIgZPSKUfCrkwOUNMp7KNOxMVg5bUaMFwQuRch+N+3TNdQb1T8m1u8yncXThFbj90YTRrCtaupo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=DjoS4jAY; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="DjoS4jAY"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6e8ec399427so17271586d6.2
        for <linux-cxl@vger.kernel.org>; Fri, 14 Mar 2025 06:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741959754; x=1742564554; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OPmTde2UkY8hmMygpptvq6ZcJy0VG5G4ypKl+rd41pc=;
        b=DjoS4jAYysdPEWX8EnRiWU0K9Mw4/k1fDmqhapb80Kg6ktkJydlDzOZtlBlKDOf433
         I3YH6bcHwcBohTTSS1rxn+gdBkffL7VJdVpNRwChuNSER8iyzt/ctrOlCou0dXAcLnlS
         yejrp7BUppDmnN4QvwmEY8o0gesX7TQXkkRWgcFAl8eK+2SZJTZGGsIy3rig3iLhHoy4
         6WlLcBdVRv26+vvZtj3aHRqesyFAdL9ZBfyfZGSc4GhDGdMxDtWHylSNt9N7HI/rmnKG
         zYiueTMT1gA4tnzlsu89xxfv5XF5/H1ndaQP/exQ3RLY7CBWKvvR+NKBK+rP8m9jVQtm
         iJOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741959754; x=1742564554;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OPmTde2UkY8hmMygpptvq6ZcJy0VG5G4ypKl+rd41pc=;
        b=qqCA1fBMAIPYibyamwMde77lqisuCpuwUj+QU0frn25Iy5om1ILHL865W0U1TO02W1
         nYjSakWXDc3KJ8IwsbFniwEPlXlaEXJoRYZHs9vvRC+sbElZdRLbZ1H86oSzkbhklTQv
         l2rQs0ICOHnbVXiTdGScGqrZhLaZSPXqUfX1honsv2mVUurY0FoUhDwN47wqq24UcDXV
         aTIEeqjZnpbwF5lWdXYkDizfoRPDgUp91qUkdWvJkEz1+eMOzlKKRUibG8PxxI1P7khM
         kMNPOvcv80fRIYSVfNxxVrJolwaOaVF6lPmK/SZ20TYQK7mpHOfjlMnauRZ1iO9HYyvp
         LNAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyN95eofTV28urAk8pBFseVlAnJstk9wQxSrayqXVbIhibXPgA/9lw3NNclBHz8b4/sPX2rRMYwkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyfxW0cpzE5IXBcm7SMX3z/dRLNLzmNTYYIPg/ETXfaIaOrMa4
	JbUIYm3WrPq+lIeULQgkpOrgCy6EPCqVueLLT34VjgJ7ngLGwQkBTSykc3JANVL+zm/PvoGg7qW
	p
X-Gm-Gg: ASbGncuiI9CARI2TMlXLcvyDDT5/mKEERjhwJV6MIZXw044dsn/51nUNal2MXNQKQ2S
	zgynvdk085HcHIvIGWqpmiThsimOZ4eaI0SCGjg+f0pdjYSVUr3jApPHhHlLDQORGVzEccIf3FJ
	jRrlzc/N9WPIUou+SSNPz30dHCgRVrUHha6K9dBGF6jc+0fRKdO6hQ0JJDvUH4PB6EL0o3R0db/
	MHuUV6al04oflSuYg52ZwDgs48VgvrPWLTQqnfbRZFDOphN53/PGRam3uN3kzb83+TcoeJDmSaB
	IltxBlrWWLmOlLXCXOfsTgtsFuAMwn6CRDj5MGm+NHnkSO/i/5C+g2QV4EfgQ5RrmZh247ScigV
	UCK/JMMZdQtN9gKAVWJMwJafr5cs=
X-Google-Smtp-Source: AGHT+IGPUbrzvzxuTFoznGJ1NMG5BctIcsuLHRaOHo5xqKBuPTb1ZQUOrATYZjhY4w0Hpk5vfoVj8A==
X-Received: by 2002:ad4:5b8d:0:b0:6d8:8fdd:9791 with SMTP id 6a1803df08f44-6eaeaa98f3amr36986026d6.25.1741959754512;
        Fri, 14 Mar 2025 06:42:34 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade209329sm23898726d6.16.2025.03.14.06.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 06:42:34 -0700 (PDT)
Date: Fri, 14 Mar 2025 09:42:31 -0400
From: Gregory Price <gourry@gourry.net>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Rakie Kim <rakie.kim@sk.com>, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, joshua.hahnjy@gmail.com,
	dan.j.williams@intel.com, ying.huang@linux.alibaba.com,
	kernel_team@skhynix.com, honggyu.kim@sk.com, yunjeong.mun@sk.com
Subject: Re: [PATCH v2 1/4] mm/mempolicy: Fix memory leaks in
 mempolicy_sysfs_init()
Message-ID: <Z9QyR3mHw76u_Sq9@gourry-fedora-PF4VCD3F>
References: <Z9Gs8i1FhJJ0eaiA@gourry-fedora-PF4VCD3F>
 <20250313063247.681-1-rakie.kim@sk.com>
 <Z9L_MgjuhrploEUm@gourry-fedora-PF4VCD3F>
 <20250314105500.00000157@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314105500.00000157@huawei.com>

On Fri, Mar 14, 2025 at 10:55:00AM +0000, Jonathan Cameron wrote:
> > 
> > 1) allocate node_attrs and mempolicy_kobj up front and keep your
> >    reordering, this lets us clean up allocations on failure before
> >    kobject_init is called
> > 
> > 2) after this remove all the other code and just let
> >    mempolicy_kobj_release clean up node_attrs
> > 
> > 3) Add a (%d) to the error message to differentiate failures
> 
> Given how unlikely (and noisy) a memory allocation failure is,
> maybe just drop the printing at all in those paths - allowing
> early returns.
> 
> The lifetime rules around node_attrs in here are making readability
> poor. It is implicitly owned by the mempolicy_kobj, but no direct association.
> Maybe just encapsulating the kobject in a structure that contains
> this as a [] array at the end.  Then we end up with single allocation of
> stuff that is effectively one thing.
>

Even better recommendation, lets do as Jonathan suggests. <3

~Gregory
