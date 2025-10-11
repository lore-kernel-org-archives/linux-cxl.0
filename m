Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7B525EF90
	for <linux-cxl@vger.kernel.org>; Sat, 11 Oct 2025 14:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760192900; cv=none; b=VauQiFN9SYwbDiKdYRBodkVazGsjRusGsNgyAPzY9mHX1QeCDxxYas/DmqmraD1o2dwiUTDLQiRNOfLo03LYGTwl4osGp8n3yQB0ymLvffXLGu+nshi3E9winDLozsbofaOG37D8/E9hjcU8R0EmbJhf+CzdnzWii38b3yufDss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760192900; c=relaxed/simple;
	bh=rQoJtxt2BriuyS0+ot6gb0/UKZ009fbWDCi/XtYJlEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TXZQktzHUW3fVSDPlkCoSpUrrWoL1X9ShQHRFt9n+sdolptnLrnorFEULqFqE5SMkkhh7jfF6fgeV1P1eBdGiikFc8cnFza8QLu/QCicoAPK9yeXHihWzdtGLKMTWSykH3RT7xNojnxXPn0ClZWnwuTMem6mFGhn1CrVPxtQjlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=SVg9K2Vx; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="SVg9K2Vx"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-85e76e886a0so297600985a.1
        for <linux-cxl@vger.kernel.org>; Sat, 11 Oct 2025 07:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1760192898; x=1760797698; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b/r1FY8bZqjxYDXcFUiFtnDHS6mLgUS1oC1sgDS+nBI=;
        b=SVg9K2VxTwzotz4/cPTxe2tZ/dmETwuFxx/99xuN4OI/ah0tkJ3U+mb53TAjZSw5n1
         aNwZmC6KQofEcTjeNUloH/Jh+93l9vZ9Ut0t8GmHN50325QPYGcaRttgVBF26uJa2Jec
         Bm8K05sMYO5YOUgXfdbn7zSIwnHtf2aL6qE4pTU4488ZmQROR08JrY69pFOuaoqCgv8D
         m2LZ3b5+SXW06FG1dTKKvOQNuc/1dkNBc8ZtxAjszYKfZT7aJVkUz1Jx0vCJp9XtIJVr
         RObmOZQaKsHjB5b4EAz+CuITsEx5yQS1+7oLSUZ++LmVqa3j5TdDDbvFFg7PFJUdzAu3
         nEHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760192898; x=1760797698;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b/r1FY8bZqjxYDXcFUiFtnDHS6mLgUS1oC1sgDS+nBI=;
        b=LjDP9kexyAf6vMVa3TuFVOotCTr0eVD38khgtiU0G7bq+um3RjVSWx9tfvjfDLfjkA
         5t05uH4uNB0ROL7YB+TGSF0vA2AXBjpSjHtmp7YlfkgVM9z+ym9cXk3Mb2qyTgAbNPkX
         yjK6F2jq932oti1eDBb8civseMrpdraCCBBEOOfkdIWFFYcdWghtxVUjTa57e6nPMpA0
         FYIatxRS8PeMBhx2UGhBqXsVIHwWDh49g/ZiI04IIbJeBXQ0HN+vLuFCkiWRQ+/Tt2UA
         A2+Tzsq9tDB0Vn04d+ByX9lEB2gioN5YGDHXOLi2Nk7KjMQZ10jfFYwMq3w2ppQ5Wx9/
         R0GA==
X-Gm-Message-State: AOJu0YyUPFoB4CNx6s7ohYm04P1Q5Q/LT/JIcxKlLjNgQ4KFJnRAnEGQ
	3TIsWzRxgvEq9XMgxhwhityElaIT6sh70EjEyXOrwHrDB2lcVrMER9QFIxbk+wweK1M=
X-Gm-Gg: ASbGncsh47vF3eEWA3aKRtVd2I+/0cL+WS4vK296Y5g5AQ3Cgzyo12ckufdbJf9N9wR
	0/2z4su2FjmYkple6qyRGdCQ8dv2aHyZS2Zb5vXZ9Hp5Zh6eCMyz7DXzpbeJcHURQ9dAjVxHKSs
	9yXGeZh6CBUwpyN10QP41FCYDik9L1kpnHPeJ4lJ+AAmv5B+P/XewnB3btxtzI29TIqteRoKQh4
	kQLXdFcefHfv4nfJ0Wre7osVAwx7KYh7/7g0I7RhFY5tVMuMXcQF03E5hewWi6EAM05Ci7z8YUF
	wPHkZhqj39+9/bX1P19IEtUydckZtKlUMUE24yBQbabdvJu4MEkXswhHts+pPJjDfe2tkbxJ8C9
	0hu4Rwg/wcWgtSJvTIH4mg6lqA4zmiEu9oq4wF5uRTLpOueYLp7aq47kbDvT01tKnL++bN4aTmn
	GxYZV7XxtYUUYepwPpgkOSH6OK
X-Google-Smtp-Source: AGHT+IFD0vzYRbJTuBs6khLc1jQ0yyNx5qUHEJ724gV0IYfK1y4jq17kJcavHqgcFFlkpTTGGoaskQ==
X-Received: by 2002:ac8:7d8b:0:b0:4c4:1f53:54f5 with SMTP id d75a77b69052e-4e6eaced498mr185911741cf.30.1760192897697;
        Sat, 11 Oct 2025 07:28:17 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e706dd45bbsm38215871cf.40.2025.10.11.07.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Oct 2025 07:28:16 -0700 (PDT)
Date: Sat, 11 Oct 2025 10:28:14 -0400
From: Gregory Price <gourry@gourry.net>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net,
	jonathan.cameron@huawei.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: Re: [PATCH 2/3] cxl: Set range param for
 region_res_match_cxl_range() as const
Message-ID: <aOppfuWqLvitw4T0@gourry-fedora-PF4VCD3F>
References: <20251010205755.205280-1-dave.jiang@intel.com>
 <20251010205755.205280-3-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010205755.205280-3-dave.jiang@intel.com>

On Fri, Oct 10, 2025 at 01:57:54PM -0700, Dave Jiang wrote:
> The function takes two parameters and compares them. The second parameter
> should be const since no modification should be done to it.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Gregory Price <gourry@gourry.net>
