Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA5529B22F
	for <linux-cxl@vger.kernel.org>; Tue, 27 Jan 2026 21:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769548888; cv=none; b=JVrgfkTeGFYwL80BJvsixxLB7axCSGPnj0lYn8sV85KC6+goHPebm8V4FKtevQEYwSC3fW7XHt1M7ELZlQqqIEFAlmUH8vNsSBMHGuxe/f2EZwPa7rxwXdrw8+zagG9RuF+DFDy3l4I8AdRhmTVh8qBq3cLzyMN0oTYvSFblOj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769548888; c=relaxed/simple;
	bh=0k7xrgOIOvXtFhZZx+9FIvVoOCNa1hPFQNr4u0DLDE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W+upWJvEB+/fzf6G8jB4GXujum15xxglRqjrKP4jYJhESzO2a7fmgqWsfn6Qt1JT8SWIablLVZaeHRTnC5uwTByclc8q9QR/+j/qfzhHAsuyOuIaiCePrQrqMoRsYbsgEI20QbLFtQiq9VyR108BxqK650aZMkKlfvSkqpQrvD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Jipqabu5; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Jipqabu5"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5033a2c4b81so58261cf.0
        for <linux-cxl@vger.kernel.org>; Tue, 27 Jan 2026 13:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1769548886; x=1770153686; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uvYegCnSnLXBpj+Df7xCTE5+wMwk6X3LJWzKMTNbnXE=;
        b=Jipqabu5TZF5ht7Ri9PT2sy2AeIJt7ZeHcS/kxHrjii0HoFX+YHHdbVgABwUXU8CbS
         b/aaYiovjEk7Xg1xlNSOnARQl0ElxVSIOfgtLFLCccjPDdo4MIoAQWyIVsJJd2yJxd1K
         eFB9q58upKnXK8G3aCYVYRu/WvyAX4msnbH8++U2IK7bQYAobnRXPnTY8RWB7u7tsGVj
         b1diyOpHCEGTnG4TGHIpWMdtZPQhTD5WKC+nFYVPq7G2y3CrJi7P8jabIrNLGHqw74bj
         W+MXmQ7cS0cwWs6g6ObyTFbmHAmz2rJ0oPwDtizNM5bYxrctRD4pcYMYZmpQipitnpck
         ijjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769548886; x=1770153686;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uvYegCnSnLXBpj+Df7xCTE5+wMwk6X3LJWzKMTNbnXE=;
        b=Rlt0l8HXOAzXHpOEpTxFjTDvxyfb9v5CzE8jF/1M1TjmZQh0fBzzYpc/xjszuJdq9i
         tw/eDPkEc4Km1fa3Iu6fwWh75PXO4yTNtvSeeb9Kz1Fwv/Z0zAuzJFBOzexKxiQYrxjd
         lV5F1ztMuUGhtB26+wTfytHyGWWP1x1NfmnNPtIA+4+V713INvMover0JfuvAODS+hi1
         IyJ8qd1hgG8r2Rcg32WtkraAiEa0j9NTBc8nKD9pUpZ3/NwluU5+TwGDyRm6KCdZbZ26
         hzUYYS1bLxWkSJyxnBvuh4OHovB5kB0HRvT4Iv7UgXbsq055kla1e2c5JRo1E0OL54mi
         qazg==
X-Forwarded-Encrypted: i=1; AJvYcCWXGgu2S0i3Afsa7japvLOLZdxerrq2H8j8C7OAENIwuUDBmcW784LEIu1Nfm/jLKoREnkPsFxaTsk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL5AG9KHPduzA8sZa+v6p7T/lKFD9CDVaY0zVGTbmQTxXWj1i7
	gk+SfAPiDLS4OxsL/obCAwbG7hdiNp4kgQJjYm4byKLFnRoA9Xy3iTG27htxuZ0jXsI=
X-Gm-Gg: AZuq6aJjV2fZys7saAbs5hT3LGuGbdckJjOu3654fAQdvp2pCXXZfHQw21P98hsIgR1
	asEDoQp1I7RzUOEtgjaSQh9LOlxmbAI2yshZdh0uuCxALDb0rps0pIxkGKq1xnMCw4yNUPJ8Wuu
	vrhG/i7IFk1z0otFbPCCD0iQ3Y8ozvITjY2xfRgB/T19c5jh0tXL6QLgTDruI3+QNNlZTAqjX+j
	ohEAKJa2m4lTSimTq7HnBrTKBJNuOIh5wWqbm+RjwqQI/ibqABXaKGheTSvlOfnw14xVKHx0rBT
	QGeM5pSu2+vX83LbWmXtKHYkojld4gtvHkaAKsHT7LA6PziScQxE75zQ5hdO4NaqdRUo1O0qRIz
	i5eXRNm/WfQ2jFd76EzAc8S4egLyzAU9OiniiQIs1Jfn0UsfIjT42bxDAHBvmAxqvZRJjvNFIzy
	k2k6u2kjB3rz72JdaeAxPccDOZoL+0cx7OLqF5HCdN+7olEtOLfQm0sOYcleU1DTINO/TtCcBar
	BXG58Xq
X-Received: by 2002:ac8:5d86:0:b0:4ff:c63c:525b with SMTP id d75a77b69052e-5032f77560bmr39338701cf.26.1769548885384;
        Tue, 27 Jan 2026 13:21:25 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d3759a59sm4809356d6.38.2026.01.27.13.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 13:21:24 -0800 (PST)
Date: Tue, 27 Jan 2026 16:21:22 -0500
From: Gregory Price <gourry@gourry.net>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Michal Hocko <mhocko@suse.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	akpm@linux-foundation.org, axelrasmussen@google.com,
	yuanchu@google.com, weixugc@google.com, hannes@cmpxchg.org,
	david@kernel.org, zhengqi.arch@bytedance.com,
	shakeel.butt@linux.dev, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, ziy@nvidia.com, matthew.brost@intel.com,
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
	ying.huang@linux.alibaba.com, apopple@nvidia.com,
	bingjiao@google.com, jonathan.cameron@huawei.com,
	pratyush.brahma@oss.qualcomm.com
Subject: Re: [PATCH v4 3/3] mm/vmscan: don't demote if there is not enough
 free memory in the lower memory tier
Message-ID: <aXksUiwYGwad5JvC@gourry-fedora-PF4VCD3F>
References: <20260113081453.8293-1-akinobu.mita@gmail.com>
 <20260113081453.8293-4-akinobu.mita@gmail.com>
 <aWZLZzo5Hb1aFZ0j@tiehlicka>
 <CAC5umyib=XmPkTvRT6eAsMx+WDx0NkSP9djh4xkhLJgwk_v8Mw@mail.gmail.com>
 <aWfXHKDzoQBsHxAp@gourry-fedora-PF4VCD3F>
 <CAC5umyg+wubKoQSfpDQvNh3K5Y7+iOEYn6_BuKFd53kHDVE7aw@mail.gmail.com>
 <CAC5umyjOgZE0Qpa3W3qZ=sSkwkuf_md47jctXgi5UKWuG49o1Q@mail.gmail.com>
 <aXJSlv1_K1uQCN16@gourry-fedora-PF4VCD3F>
 <CAC5umyhrcb963mA9dUaZswJKq2MF_OVaipNmy=L4J7u6rPjfqA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC5umyhrcb963mA9dUaZswJKq2MF_OVaipNmy=L4J7u6rPjfqA@mail.gmail.com>

On Mon, Jan 26, 2026 at 10:57:11AM +0900, Akinobu Mita wrote:
> >
> > Doesn't this suggest what I mentioned earlier?  If you don't demote when
> > the target node is full, then you're removing a memory pressure signal
> > from the lower node and reclaim won't ever clean up the lower node to
> > make room for future demotions.
> 
> Thank you for your analysis.
> Now I finally understand the concerns (though I'll need to learn more
> to find a solution...)
>

Apologies - sorry for the multiple threads, i accidentally replied on v3

It's taken me a while to detangle this, but what looks  like what might
be happening is demote_folios is actually stealing all the potential
candidates for swap for leaving reclaim with no forward progress and no
OOM signal.

1) demotion is already not a reclaim signal, so forgive my prior
   comments, i missed the masking of ~__GFP_RECLAIM

2) it appears we spend most of the time building the demotion list, but
   then just abandon the list without having made progress later when
   the demotion allocation target fails (w/ __THISNODE you don't get
   OOM on allocation failure, we just continue)

3) i don't see hugetlb pages causing the GFP_RECLAIM override bug being
   an issue in reclaim, because the page->lru is used for something else
   in hugetlb pages (i.e. we shouldn't see hugetlb pages here)

4) skipping the entire demotion pass will shunt all this pressure to
   swap instead (do_demote_pass = false -> so we swap instead).


The risk here is that the OOM situation is temporary and some amount of
memory from toptier gets shunting to swap while kswapd on other tiers
makes progress.  This is effectively LRU inversion.

Why swappiness affects behavior is likely because it changes how
aggressively your lower-tier gets reclaimed, and therefore reduces the
upper tier demotion failures until swap is already pressured.

I'm not sure there's a best-option here, we may need additional input to
determine what the least-worst option is.  Causing LRU inversion when
all the nodes are pressured but swap is available is not preferable.

~Gregory

