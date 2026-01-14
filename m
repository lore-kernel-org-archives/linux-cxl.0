Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD1B32A3EC
	for <linux-cxl@vger.kernel.org>; Wed, 14 Jan 2026 17:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768412992; cv=none; b=GrfBJ9eMGe4RaEDuxQRRBpInv8hsqwxW989fSmYvQVZZKrshFZYG/76Rk6qOw+viXMjRP1AnrhtEQfEaIO5U1OPXy9luu8aIjsnlGxLY+R+JVTtsQjjw0aXW7Wxd5iOxL2mwy/S8HkFYxk+aw3TZ93oxB4ZrTaeewnEkQ57SFxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768412992; c=relaxed/simple;
	bh=/VcR9roinD7y9klMbj//XW4tMEB6oqstOSg44XzR92Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AbT1bMwl3inaNeYRz3Z7IoOOEjY3H2ZPlggXmtwzbJ+18h4DJR6xU/G1/ZmkrDvB0bjhoALZQijXdJXgbEpyWBtfGSeQ++PAn3H18iV2MDh0ME4/jpYSqJhwNQklquY/gK7ede5EgAD7YW+1daaRG2jYWhFaKTM6//HmY+Lv9Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Vo+6h2ty; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Vo+6h2ty"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5014f383df6so302831cf.1
        for <linux-cxl@vger.kernel.org>; Wed, 14 Jan 2026 09:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768412990; x=1769017790; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rnSGVRURKZAVPD5jw0dyr/F1254P0uVRvVrsDhTaqXI=;
        b=Vo+6h2tyA2m5EVvduT/ZdhqAOcVr+/GY9iBvf9hzWHizrTNvYTUhW5ZSIcsAJj+aom
         3lV+P+6meBXt/O3dPW8g4TW1TCTkTwQKJDWHsVpPRXsaU7tr3v17J4rbdea8dKubJAYo
         QD1lJ2JKlHBDSYGx3/+m78QuQ7Hh/z2Capal+8Xuy+VdOX4YGhLZ7IElSFTph5I2F2Vb
         Vsv9ET+5+Ao8SgN3RtlSwN2zIXrX7iUjcT7hzqB/BQarPlaaNocDM8Wsrg36rejBWKJa
         UnbbYIBh67j7j61EsQH7+3em3ZlOF/dpIjdf7oGGNsDj6Veaml8jYQJ3dN5O6AyksgMY
         vD+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768412990; x=1769017790;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rnSGVRURKZAVPD5jw0dyr/F1254P0uVRvVrsDhTaqXI=;
        b=ANdqo1NEjFuB1+HjzaUBLrGgvXXj/s+wco8W9DOc7r/Y0NO1A3q+pAObbTwo331xQn
         72QT/M7QGtIHierA7L3w4hV2bcQnYrkBTwzJkLCMuCtfIN1rh9+DK0LtjY9k/41Y80xl
         qaiBbWSL0DOjD8VtLLK2cJL1Hvp8MU2zTJV5jp5sJ6iiBYUSMVkAZYLkMbfr0FvUdg8P
         Rqj24PPEzWrMgnNbxxvpBmbmBBHWe25O5xmvBGpIOW+inwxRJ5zkmOtQRcgy7ziCiGx/
         K6X4S6czuVQmSMzYwiaGDaTMsgZ5Y5db9D7vDpEJB+fQz89HBVI8ol8BHNurvHsyCMiC
         SCPw==
X-Forwarded-Encrypted: i=1; AJvYcCV6zoi2s10vUJGnVLRRx5uzlugHZXl3es8zdaiTrGobWNB1ytDHF8a9+p1IOAFnHw9a37nhrew5wZc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdxhtp0PBmRuk1ufxKYdVi5GyotJnmsIdXPk4QB65ci5ch9Tzf
	RROHLKWdM/CaFXpbEl8PwOrvJwGg0P9/pTYOrEvQYpAS7YSQ8BRJRh3ePxqjhgAxpWs=
X-Gm-Gg: AY/fxX4iUr0gJw/qIHy+GaYI6JM0T2pNsS63wjnLvgBd/DtiuOF0hHlBKaaFR4XnDie
	jURI1D/zIj17NKRG9cANQnlsfKpSWGxoH4i0tlHWl5i69KhuR0iTGbzawjBgOXDiHQ9Q4GKnq/T
	8bXyT4BxBzsPEGo8znEWw3+22bxHjqHZf8460CjrtakbEKqnaVHaDE30VFG49FmISJ+3juYWSUX
	Whuq0+gIoBhlpT4K57rQBnA6xX42X4iGoi/0CP2dwuzwkmy2S2owAEtBFJxFW3Ma9b0eY2U4GoR
	6AK+gRHPcB9AzZcpsehSM6i6k9aTHLPIPeZYTF6uY99EjnECnYh8YxI0y3MwBj5XoSrjqfOM53P
	Gvwy4o4JMeXupvPns6hTkaRykcKk4bAMEnEIdU2y+Io5L5idC8jYPRy+Hr6SnDY+FaloeWzAU1M
	TMWQ0dJcn1uUiBw9w34pAYucUqbDncU8MyeCEsLaouUgMfyvitybkCAENGKkjSwfMOTX0ZbA==
X-Received: by 2002:ac8:5312:0:b0:501:4b10:aa9e with SMTP id d75a77b69052e-5014b10ad9emr26844851cf.13.1768412989843;
        Wed, 14 Jan 2026 09:49:49 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890770e4262sm177915266d6.20.2026.01.14.09.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 09:49:49 -0800 (PST)
Date: Wed, 14 Jan 2026 12:49:16 -0500
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
Message-ID: <aWfXHKDzoQBsHxAp@gourry-fedora-PF4VCD3F>
References: <20260113081453.8293-1-akinobu.mita@gmail.com>
 <20260113081453.8293-4-akinobu.mita@gmail.com>
 <aWZLZzo5Hb1aFZ0j@tiehlicka>
 <CAC5umyib=XmPkTvRT6eAsMx+WDx0NkSP9djh4xkhLJgwk_v8Mw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC5umyib=XmPkTvRT6eAsMx+WDx0NkSP9djh4xkhLJgwk_v8Mw@mail.gmail.com>

On Wed, Jan 14, 2026 at 09:51:28PM +0900, Akinobu Mita wrote:
> can_demote() is called from four places.
> I tried modifying the patch to change the behavior only when can_demote()
> is called from shrink_folio_list(), but the problem was not fixed
> (oom did not occur).
> 
> Similarly, changing the behavior of can_demote() when called from
> can_reclaim_anon_pages(), shrink_folio_list(), and can_age_anon_pages(),
> but not when called from get_swappiness(), did not fix the problem either
> (oom did not occur).
> 
> Conversely, changing the behavior only when called from get_swappiness(),
> but not changing the behavior of can_reclaim_anon_pages(),
> shrink_folio_list(), and can_age_anon_pages(), fixed the problem
> (oom did occur).
> 
> Therefore, it appears that the behavior of get_swappiness() is important
> in this issue.

"It appears that..." and the process of twiddling bits and observing
behavior does not strike confidence in this solution.

Can you take another go at trying to define the bad interaction more
explicitly? I worry that we're modifying vmscan.c behavior to induce an
OOM for a corner case - but it will also cause another regression.

(I am guilty of doing this)

~Gregory
