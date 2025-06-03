Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D785238C2A
	for <linux-cxl@vger.kernel.org>; Tue,  3 Jun 2025 13:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748958529; cv=none; b=gB0yk5HYwocpJ8FN9eaz+Sfp7n5oyF6qN9Lti6ZSsC46JryiiW40ZrN10MDIhXU2zBgF6ThZfxoKEDNqUVbC6PnYs0a0Q1nXwHnOV3i/SRJJhFaLNQV2bZ9NEB1WKbowEDpO4ibgVAKSeLgdL9pRidz6AFQTsU/tspEWjvhyxrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748958529; c=relaxed/simple;
	bh=RcXEhllfDG955BJXEN1tqIgpRJ2MsHzTBep7rZd+naY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZRhPH33J508BPxxwFfeHFgndvbtjeLhNFCkyqgIHWjDwy+3i+BBkn9WqOnNiIv5pxO7jXNyEQd2a/rWT5840Q1QmsG61phSjHMejiGBGMNOKOvKy3m8D+0OrRwG8v3QOpTW6H86tWmkeNaLxx1b7yicUub797/9RgznGoOBVkcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=KoP8asrO; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="KoP8asrO"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7cadd46eb07so559076485a.3
        for <linux-cxl@vger.kernel.org>; Tue, 03 Jun 2025 06:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1748958525; x=1749563325; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZSTZfPDDH1MLe7AQH4Yed2Uaqt/hLn+gokhyp0JhueY=;
        b=KoP8asrOMIEJethoS/itlxDSGu3+zKoaKa8sDFbGOOwqgCYGuYTFZfYS8Mnkx+tl2G
         LjxtWypcZcjUxtywmuy3LTV23DzErA2mqesc1QMxuKAF1XQppJ55Q57IUPuLTyiUn0Sk
         YS/uss7FvucPNO97r9KoOsxXLFtUQJm+qNUu/DkymsWRGtNsFPMKPn5wT9vBJuunJkBi
         /ukr6MpVltCAllXmAe7Dx+EhPp2hMVvhbhJNotnIQu7A2DxkaHLbi1S2kV3TyJK+7eoh
         hFWkqGTwpByFV0dpwd0TOBMUr6BTdcw6HqglUcBifaQWg5i7gw3KGyxZEuz/Utn1gmBa
         rs/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748958525; x=1749563325;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZSTZfPDDH1MLe7AQH4Yed2Uaqt/hLn+gokhyp0JhueY=;
        b=hOR2xOuiU6vQdrEXK+uGPULOFtpprsJzmsvou4tO0aRq7OxOnGj1ho5H9gG7fMB7iu
         1ojuMt4FSNEcrfD1g/faRtxnbS7dtf89BOx55HgH5DqKuK+KRPvSRs8D2hbUI/xWnbek
         fVEL1jweMtNz0gKcoOxqH43f4JvNdVsAmyRR3y1ufMS72e879EXr4Bk8h7Zk/jrp2PES
         w6VDDDNSM/3LPJV+LHBkPhrk+mS7h6n0IUxdmrOigl4s0gETYmajC1P5z18rfLwZmL6C
         GLB6D9yhehz1U2bAlnvDCQ1WK7pKm0Ia5WkQlxw06GOs9knguyFcV9wp4b/g0W/qcqVo
         wrpw==
X-Forwarded-Encrypted: i=1; AJvYcCWdn6gccgZVDD/GTVT0YxD9yEC56AJiKbEBdXZbTpEzjCimHqpSkmfTC3Q6QlKDhPky8/b39YChiLg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk9HV09Vs0l03SEtQ8QChLg4FmNNu96IFjL8LbxTPcNPNGIGFJ
	Ew/vISMl/AGa8b9VDVOzP7f4GWvqhGK+J4GcQD6CkKfkSgCzbKuHDang1K6kPLzlPQc=
X-Gm-Gg: ASbGncv96DSiDhf7lmy4AGREuvhlXQVYaaceZOJar1S6BjypdiyYnZ2PocpLtK4TNGE
	WKhAH6DdjPyKFLkY4kIW0/npVrXzQDXuZ0+lcuRdcKJn32fB8+i/zO0dSHrwV4ZnzqlAjNUAfgr
	2tjNhiIRTlKw8FOFn2zZ1htCyW7DdSaQ8G6MEIec8mczImaEDZ9dvqF1C7mmvGd7w/Ddk9G+iMy
	8W1MCMQqJ4RKW0kZs1E0DYnkqgdptNUjZFjU2ww+zxv8cCpS0U8uD7rUIknzy5uJyUez6bPnVNc
	9pD2G3IxQWC4hBOwVIrON3K+izup5JMl5YMfFepxIrtN1TzKFMa0a9/zr+IYMmKhszUZYL1POzn
	w9WNSAo+ThoksyWHrv35JJLblHJo=
X-Google-Smtp-Source: AGHT+IH3Vn4y24ccOnNjvyrMKRdXMvoXmINXxWtKUHHRDjsnlypx2qCEJce143rhCfMATkU1PKi1PQ==
X-Received: by 2002:a05:6214:27cb:b0:6fa:acc1:f077 with SMTP id 6a1803df08f44-6facebef794mr265266426d6.35.1748958525108;
        Tue, 03 Jun 2025 06:48:45 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d09a10e844sm842209085a.49.2025.06.03.06.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 06:48:44 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uMS0S-00000001hBt-0o7d;
	Tue, 03 Jun 2025 10:48:44 -0300
Date: Tue, 3 Jun 2025 10:48:44 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alistair Popple <apopple@nvidia.com>
Cc: linux-mm@kvack.org, gerald.schaefer@linux.ibm.com,
	dan.j.williams@intel.com, willy@infradead.org, david@redhat.com,
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de,
	zhang.lyra@gmail.com, debug@rivosinc.com, bjorn@kernel.org,
	balbirs@nvidia.com, lorenzo.stoakes@oracle.com,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-cxl@vger.kernel.org, dri-devel@lists.freedesktop.org,
	John@groves.net
Subject: Re: [PATCH 08/12] mm/khugepaged: Remove redundant pmd_devmap() check
Message-ID: <20250603134844.GI386142@ziepe.ca>
References: <cover.541c2702181b7461b84f1a6967a3f0e823023fcc.1748500293.git-series.apopple@nvidia.com>
 <2093b864560884a2a525d951a7cc20007da6b9b6.1748500293.git-series.apopple@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2093b864560884a2a525d951a7cc20007da6b9b6.1748500293.git-series.apopple@nvidia.com>

On Thu, May 29, 2025 at 04:32:09PM +1000, Alistair Popple wrote:
> The only users of pmd_devmap were device dax and fs dax. The check for
> pmd_devmap() in check_pmd_state() is therefore redundant as callers
> explicitly check for is_zone_device_page(), so this check can be dropped.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> ---
>  mm/khugepaged.c | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
