Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9B33DBD57
	for <linux-cxl@vger.kernel.org>; Tue, 16 Jun 2026 19:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781638520; cv=none; b=UNd238BH3UvUKqyNb8nZDOmmwsLEl1TTK4CG5igOQ270B+ctj2+OvUB9kTiXrmT4OKe9OGSKtznT0yhbiSCVaBEgGAqdAiiKUhzsl5jxRtTO7sWnMSo1G8x1G9sskX2xpcjZnvh+98TBzxvHRgFifmLWZc6oWyEopyU+cm7lla0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781638520; c=relaxed/simple;
	bh=MY2uIvhGYy/CfCwesRydbU3lcjiu5NG6iPQrb5kFAwE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=NpK7Fe61lhZt2FIaBAXHIC4DyBjIlGaPWaZa4Otsi6fHdWZmgsl5yy+U5kJ6adMuL1dlS8WeeKxIsYlUF5Oe4PPXgOAAkAjhK2wWcORyi7hNC5g13yRc7tVjCQQZzHh22khcKxLFdWKBUm/pI0449AVpRY9eaZzfHq+YVIMNVJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BR43W/Os; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BR43W/Os"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEC541F00A3A;
	Tue, 16 Jun 2026 19:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781638519;
	bh=xc7q3CiyQ1xlsHbVpzwNHmz7OTOjIGdfzCQpxWYDYAQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=BR43W/Osjpyd2eOM8j3NK/o09+OD9qwp1RZgBtAKFSGCcTRGwr4qN3GB6LRpB0kBA
	 in3oYPlwDlXvCcYPetAsJyyCOxEMj8uEiT3rAJDd6HEFXXfBgxJOBqCMxw4I+oMt+p
	 q44mECa9NHLmnW0OHfGzAHx7l1jPAcyuRcqFm1EJlLGFpmaxkG7X5uMrebuAYnCKSf
	 9z/kzH9xSiG1NO2+WG/q65MC8xEmGYB7rpr9txHG3uIlZamKqak7gJPWN1d2BoPviq
	 rSM/ogyf7sCkyL5zpzpvTX9dtGl6d6QrPrdmftVip7tZCOSTqI32L1sGbnOf9VWfZr
	 +5glPWePBRpkA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 09430F40076;
	Tue, 16 Jun 2026 15:35:18 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Tue, 16 Jun 2026 15:35:18 -0400
X-ME-Sender: <xms:daUxarsomvhDc1dUcWchGs59iZakPY9vQ7KAFK_NLCTMK97aijrUbQ>
    <xme:daUxahqhH0HuF9sX_P0-EihBX_C4EyRFCSDjLNYMTeqY2mfJv0eQi9mTW8tao1FMb
    akfJQJC_wyWnayYJ5rtlVjwInb8SBxgueN89k9kPOxPTdMSVU3cOw>
X-ME-Received: <xmr:daUxaiJ8l1TgIW4mQY6zey-d-WDGjCG47u91RYR0bQxTJ_eGHLCNzBlwnoJcvw_T8qaZ0aJnyE2CvDEoUS2n_lPnHr3UQwnz4Cs>
X-ME-Proxy-Cause: dmFkZTGT4fWcz8GiXUR15Vty2mK9nRAeRCRIMzTX/7Wr8CrObClROCZaHzFrP2gSBL0txg
    i/yZurKP3Ms1ZHxSrmkAT/RPkMr+mCJPY6mw6/rLDKs7ftWj+AW1ATfhLw/NxaK0svhjQn
    IMmA0UPUsW29MvvV4dcHkf5ka7QbGtM8mXSRBR5asTWk1WeveU15SagnzDOQ87wlThJ3q1
    ec36EGBpgp1QUitKFc3T78AOKB3FfTPEK4kt5m68f2Ur/pCdt97X3q1t3UR/O6SXh34L69
    TSelKDGIDDQ0HXi4+QPG9cEDcu9TBv/ntLYb1sN3krS3Vpni45on3Lmevd+Yv2fQ/VtIaQ
    mTiJdveLv2fuIWIKGK7h/6sIDtg0fdttgJ1oOpnyl8Tavui9spBPySiHMjJwegfDLdFCz/
    PrT6ukHLEYaR3IAM6c0rVmZSGRQzjSgwaVaedsgnWFI+a5GxF0LjSvgfWp5afl28pGmdTI
    lzjDpNlR5G30USCWsEYdpWM1jBbzbkKJsg4U7na32SaZIgpBVxmCuIFk2T+riWYlMCoeGc
    VoPIksZjfgRwZtD4hAuVnAU/FbAQqN/RXgZrq0RAuYOW8nslS6vKH6+EirSoK/ZZ8TsfnW
    MMc+jseXiBVsjL2eMZT7ewU7eFFtRIFpzW062Vjgt5QOWmRyi03GLgE9IKqg
X-ME-Proxy: <xmx:daUxapulfKeQpZH9gvJUIi5STlTAlezD16oTrpi16Hfmo69E_u-AEw>
    <xmx:daUxanBYO0T5EzU4BWTN2T-M2ByQuVkBC-4mJo3Pt7wbRkHAsxO9SQ>
    <xmx:daUxap7H2Uaegk-geLEE3dIPwtpbofcWnzaAkZ-WTPLLpMdFlCQ-lg>
    <xmx:daUxanCDdSClmBZQnoYlOY_NYvUFsfgB5Nba3B3YXxpm6Da_oQ2D8Q>
    <xmx:dqUxan6rlDhvI7runYI3TmTeuoKMCETKa3Tn8wiKss23Tsb25s6nfAO2>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Jun 2026 15:35:17 -0400 (EDT)
Date: Tue, 16 Jun 2026 12:35:16 -0700
From: "Dan Williams (nvidia)" <djbw@kernel.org>
To: Alejandro Lucero Palau <alucerop@amd.com>, 
 "Dan Williams (nvidia)" <djbw@kernel.org>, 
 alejandro.lucero-palau@amd.com, 
 linux-cxl@vger.kernel.org, 
 netdev@vger.kernel.org, 
 edward.cree@amd.com, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 edumazet@google.com, 
 dave.jiang@intel.com
Cc: Dan Williams <dan.j.williams@intel.com>, 
 Ben Cheatham <benjamin.cheatham@amd.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-ID: <6a31a5742e552_9b855100d5@djbw-dev.notmuch>
In-Reply-To: <17b68fb1-768e-49f6-884d-49e0952621b8@amd.com>
References: <20260609215755.8685-1-alejandro.lucero-palau@amd.com>
 <20260609215755.8685-4-alejandro.lucero-palau@amd.com>
 <6a28a0c349c9b_4fa7810099@djbw-dev.notmuch>
 <17b68fb1-768e-49f6-884d-49e0952621b8@amd.com>
Subject: Re: [PATCH v27 3/5] cxl/sfc: Initialize dpa without a mailbox
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Alejandro Lucero Palau wrote:
> 
> On 6/10/26 00:24, Dan Williams (nvidia) wrote:
> > alejandro.lucero-palau@ wrote:
> >> From: Alejandro Lucero <alucerop@amd.com>
> >>
> >> Type3 relies on mailbox CXL_MBOX_OP_IDENTIFY command for initializing
> >> memdev state params which end up being used for DPA initialization.
> >>
> >> Allow a Type2 driver to initialize DPA simply by giving the size of its
> >> volatile hardware partition.
> >>
> >> Move related functions to memdev.
> > The code movement is not strictly necessary. Just add cxl_set_capacity()
> > and we can consider a move later if mbox.o and memdev.o are ever not
> > both included in cxl_core.o by default.
> 
> 
> I think it is the right thing to do as the new function uses add_part() 
> (moved) and the other add_part() client is the other function moved, 
> cxl_mem_dpa_fetch().
> 
> Note cxl_mem_get_partition() used by cxl_mem_dpa_fetch() is the one 
> working with mbox commands and it remains in the same place inside 
> core/mbox.c and the only cxl_mem_dpa_fetch() client is cxl/pci.c
> 
> 
> This was reviewed and accepted so no reason for not doing it ...

Sure, I am ok to let it go as is.
