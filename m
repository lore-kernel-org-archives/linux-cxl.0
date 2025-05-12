Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65742512DD
	for <linux-cxl@vger.kernel.org>; Mon, 12 May 2025 16:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747067932; cv=none; b=Ky7VjFChyqcuwJfw5dVgMFXw31/nrtEHo8gFgx0SR+yeLzcGutrdT6QB//Egwrmn4r76eom7GKH+Ymq/K9vZ2b4p5dnRjaLUgBNX5Ydaz/cMCyPtw/aZnoEAEgAkF4R9coGoAxzgXfB4Uys5p7+LxrEyoUuZPVRy+jm9mvgHKws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747067932; c=relaxed/simple;
	bh=Yehlnc4ZkWKIJwXXxMMs5cwKVop6FmBrsGoE123p7sE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hETZQKGjcnlLucBCojryv3Fd/kVnnbcry++q5ogLYkisD865AvTEjGc6MogkXKi1K68wzviT6ASk+XTcVfIDlzbYW4ktHpuO7G6cSR6Pg27CPRCKZslJWW63cBOswl2bvqeizZozIYXmNT8TPZ6bAx09m6oVopHVXp/lxdBR1Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Xm8vpCNp; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Xm8vpCNp"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7caea4bc9e9so895775285a.1
        for <linux-cxl@vger.kernel.org>; Mon, 12 May 2025 09:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1747067929; x=1747672729; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1julnBD5+GcSaXU+eTIdcuLbn0p5bHzSEbl/z4yoEN0=;
        b=Xm8vpCNpFOh21VbbJXb5ohXssAScKGNIOsMZmLyI3oxETyYNV37N+q66z/aS2xHC+o
         /oyEKGkg8svFA9a8bvw5+7smp9Wyg+ch3Vb61GkXs6UoTX6y70/D+x8CZwGoQ7FxqJlb
         AYDqJa5RvRQ+yzYCnifCTclasQIQqhVftHeBW6gf5+6tzvqMXUymcPdZ33KNxXLlUHvQ
         gaPD/THBnQVMEHdbI8nLjsmLTdKtG0xrN72msZI5cHU0rotfnM7MlMJON8sBbf6fVbFR
         j/1xNs33VRfeMW5R6x7/QymSzZgOMQ3u1YtQg31akTqS4pNkGFfUMY0V9sEq74kL0H5x
         SfJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747067929; x=1747672729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1julnBD5+GcSaXU+eTIdcuLbn0p5bHzSEbl/z4yoEN0=;
        b=c2jzQ+5/UEuttRh3bfRzh2Wg5hbmfqOOo+7OEXso9d2klLR8EWV9xzfI421BQW1smB
         AVzXIn/isnhxXSSCvHzK0yttIeEP4Y4i0OQ0W+U5UuhJVYa9eVMxnkimuBEMEM+uqytA
         2KsGxbMW1ib5RDWgrLDCbGea668GepweblUZLHs348YAZZJRZ3EBL4ckmyJRjfewJ8RA
         4VLJWUFniyoNN5JG7jgladK2v7Q25lRzCoGAej/Sh9gufnUJvoA/f/qrvJioeY3QOBHz
         BMTJYTi1ucU5A57g9SM3heX/zRGFLz/OFNrnrjFqwUZ/e6bmsW467s0fmSsj5eTX+VMB
         HUEA==
X-Gm-Message-State: AOJu0YxFe8/rEhOfrRzEXpbHCbB1Qtg47Ax5OQ2OFKEYjnbjytRpUaHR
	nfiaGTI7ED6RSFOyMehy1BdHR123foXx4nrQ5/yXsWK7pXPtpqG8Hf5aLs9lDck=
X-Gm-Gg: ASbGnct6tNjTxePC6SVepmqnscadlNy/WzrF+k/uVg63RL0fGjtUAK1suc3dUuT/zZv
	xs+B7/kTNVGB+PNyHgQk12YcRbRGbIcSOKSrO7O2PBZkIt+OJ3HesIfJ0LL21UtgkL7/ntMS39p
	2k+e//w+inJ9HZjSJd8sJ2ZdTZu0/HhQyv0tC/SfoHw/GtMCuXETkVeo1pg5tJU059qF54DAdpn
	S/1Z2/kRz+GEU3crBMJOesXGfbVWQz03heGdzsI7Oms8EkUe0nee7pu/bPpg5MqhEZT/gyTMi1Z
	60Li/TPfQRJJW7ZG2VsE2IoT8tL+ucKw2SbjFlEl+3xP3Nbinpq4GCXVL7FbpmbcdcfHvpFBLvM
	mZ28u1D8PU97bRJr1+0z8cFPJt3nD6YrNRjOC5WXYHQ==
X-Google-Smtp-Source: AGHT+IHHMUdqgvopOB3bvhxDrzkGlwPiAUOBbIhdmlc5mYj64PucOzKQfQk92T4hzK7H4RQ84n8s7g==
X-Received: by 2002:a05:620a:2a09:b0:7ca:d53d:af75 with SMTP id af79cd13be357-7cd01155c4bmr2207761385a.56.1747067929639;
        Mon, 12 May 2025 09:38:49 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-42.washdc.ftas.verizon.net. [96.255.20.42])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd00f4e093sm568092885a.8.2025.05.12.09.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 09:38:49 -0700 (PDT)
Date: Mon, 12 May 2025 12:38:47 -0400
From: Gregory Price <gourry@gourry.net>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, corbet@lwn.net
Subject: Re: [PATCH v3 14/17] cxl: docs/allocation/page-allocator
Message-ID: <aCIkF6RZJtU0m3Ia@gourry-fedora-PF4VCD3F>
References: <20250512162134.3596150-1-gourry@gourry.net>
 <20250512162134.3596150-15-gourry@gourry.net>
 <aCIjMNooAzKaONod@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCIjMNooAzKaONod@casper.infradead.org>

On Mon, May 12, 2025 at 05:34:56PM +0100, Matthew Wilcox wrote:
> On Mon, May 12, 2025 at 12:21:31PM -0400, Gregory Price wrote:
> > Document some interesting interactions that occur when exposing CXL
> > memory capacity to page allocator.
> 
> We should not do this.  Asking the page allocator for memory (eg for
> slab) should never return memory on CXL.  There need to be special
> interfaces for clients that know they can tolerate the added latency.
> 
> NAK this concept, and NAK this specific document.  I have no comment on
> the previous documents.

This describes what presently exists, so i'm not sure of what value a
NAK here is.

Feel free to submit patches that deletes the existing code if you want
it removed from the documentation.

~Gregory
