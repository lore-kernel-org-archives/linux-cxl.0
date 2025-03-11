Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EAA25F798
	for <linux-cxl@vger.kernel.org>; Tue, 11 Mar 2025 15:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741708741; cv=none; b=YuuazKutjUwEakOfFmaAtzu8sXCkuvjSml0Kq0aOQGRuh2FxX5xHRZKzAKhv97YPXcDyOIGHquwH7sVWSByN6hSB6fKqhmtmK5b6wL5QeE8Gsdcdph0BbjQviW2JFh/O449w3eE/Gh67GinNsj8XKXIYDrbDHQFeGDwR4ZZ4nHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741708741; c=relaxed/simple;
	bh=Kf0XD+4NQsGqhvJzqE/CH9n9Xpw5uC/LHjG4Urq2ZtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y7BWJTaqg1kWH5oA6gh5sQmil8R8udJ9vcw+DGZTYdtlTFGTitUdg2y6NVuThUf8Fcdk0KL2yzRCe79jYncyG3gdt+9j4ftiLda4MdvSHnW/OVgjFzlHbUai2+Xok0t5/QS3XQNQYCLPr6NlocpNarwTNwi3dfANZcebISyuq64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=G6GTh78x; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="G6GTh78x"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6dcd4f1aaccso82736546d6.2
        for <linux-cxl@vger.kernel.org>; Tue, 11 Mar 2025 08:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741708738; x=1742313538; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x5MIY1YFuGzMEl9B7g1td8wp5xC/AyaxT2y//gV10VU=;
        b=G6GTh78xzH1JT94By3eikJimS1MZQSieTW2dDl22jIML9n8HBsOYDG4HW7wnANuzey
         mEifVq7faiTt+3t96h2LhA/AUIHziymh33VN+WDSmTGUBgcksE337H2Nf+ljqDLZGb/b
         aE85TKdi1FHyc7uK0vrEysHU/5EHxDN+9ou80HKwebKgryRuD4Q5w9862g0lnlMQlUPs
         sRtHdHrSsmVQLZsVBi5N8g56sk8GbkKOb0p/fXZYuFmVWJGuY4CoQOzfZKe2pLeDWGiN
         FJwQSPHnojtfYr6PktFLJaFWrGNyAf4Knlk7zu9iLU62kakH0SkYPJs21XXbO31h5zPN
         vLJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741708738; x=1742313538;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x5MIY1YFuGzMEl9B7g1td8wp5xC/AyaxT2y//gV10VU=;
        b=H0lVNoPzuBWZkX2O/ubpVYFyXWKBzzT6z7sphwGeHJNsIVPageofUIDSWdFT5+biow
         qCliC7UaxerJFVXImFhf2hYzeGfbiE5ysBiwN5UibN4WiDIULcLQcR3slgaJ6uHFsSSc
         5yfbjF9lWDmr5C0vYZ2tglLWUFoWdIpaMLJcKAp9jvrHw7pruOGAU/LsWToWXhnVhWof
         ITXn+hvDJ1XGzhrW4cqEx1nIi8D3n16MovyLQEs87jAUf2wlrd7Sqlmsll7baV2D07/L
         NHRiX2JuvdByarbxh1/ezFLjhBcoDWXrsHANKL6GYJzxaG0vQjeSphBu3/3mVSeMsGc9
         8zJg==
X-Forwarded-Encrypted: i=1; AJvYcCUp2Co+DWOPfqu0Pov6Ena6qiIWFV5+VHyiosv5xc/IrQbmFtf98QW9EZ/zFWvuhOQkKJf61M3/Cak=@vger.kernel.org
X-Gm-Message-State: AOJu0YymnCv1l/vQN08DPbTwAjJLLP9BwKR1GsivC0FPvDhSXvp7PbTW
	rduM0uieP2+WX4JH1I8knK+kvbojvMmCdrqNhrDPXKjZoXARjjATkGsMBGkgfUs=
X-Gm-Gg: ASbGncsQove1KfDbz1Ng2LvbEjlvYyOtHwNr7mvJlSU0ZLb0T5UmV6EtJqOU3UBBXDz
	UMtunBGazoRltUvKBgXUaocMc+wPZVMSudvIZl2uF7+cgrgM7qyZgW3Lm8dpBTbhiKwGAo/+Fqh
	HWiD/09Wr5F1Kf9pP0bDRNUCrvlNfPr3Oq0EuKg11ARCvcUAoOACkJE4qPC1b2O/cvAlIoaOBVM
	vkE/Qc+VnuSeCUlaTmE0YFvUTQkvCCJ5PxRlSHJ90tdUse0/m/A5UyhZfSBWD2npSznQY8dZafm
	5wzBPV1c5pAqgQs9UrAQ8PcReM6pahidqefBsCoHj/J6HSNkYgACSOmMYktPhn8kWLRit1otYTq
	BpVrSkWV/7n53c52+Q0I9pEqW86Y=
X-Google-Smtp-Source: AGHT+IGY+q9fXEIzLK5PRqLHxDbH9gjNl112Y7A8nGw2k9Rrrn3f350E8jTleyyIVailHzrgpleY6g==
X-Received: by 2002:a05:6214:29ef:b0:6e8:fa72:be4c with SMTP id 6a1803df08f44-6e90060476bmr245065826d6.1.1741708738413;
        Tue, 11 Mar 2025 08:58:58 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f715b809sm73419286d6.79.2025.03.11.08.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 08:58:58 -0700 (PDT)
Date: Tue, 11 Mar 2025 11:58:56 -0400
From: Gregory Price <gourry@gourry.net>
To: Zi Yan <ziy@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>, Yang Shi <shy828301@gmail.com>,
	lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: CXL Boot to Bash - Section 3: Memory (block) Hotplug
Message-ID: <Z9BdwFZ-ZRpMSabG@gourry-fedora-PF4VCD3F>
References: <Z7OWmDXEYhT0BB0X@gourry-fedora-PF4VCD3F>
 <CAHbLzkq6Me6nRaL6b09YxJ_nFkxb+n+M3-q_aJwOs2ZO4q8VCg@mail.gmail.com>
 <Z7TLwtQY3vGUw2bO@gourry-fedora-PF4VCD3F>
 <1b4c6442-a2b0-4290-8b89-c7b82a66d358@redhat.com>
 <Z7TswQbpPV590ADr@gourry-fedora-PF4VCD3F>
 <bda4cf52-d81a-4935-b45a-09e9439e33b6@redhat.com>
 <CAHbLzkqDQcrHLPzk8n0SMgkidH2ByCqdwfYXX=uBPQfOArWf8A@mail.gmail.com>
 <Z7d3vVdJ8UWU5oex@gourry-fedora-PF4VCD3F>
 <4ae838ee-b079-408e-8799-e9530ca50417@redhat.com>
 <0C5749C4-B3EE-4393-A8EA-AA56B399E9E3@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0C5749C4-B3EE-4393-A8EA-AA56B399E9E3@nvidia.com>

On Tue, Mar 11, 2025 at 10:53:41AM -0400, Zi Yan wrote:
> On 20 Feb 2025, at 14:26, David Hildenbrand wrote:
> 
> > Yes, the only way to get some 1 GiB pages is by using larger memory blocks (e.g., 2 GiB on x86-64), which comes with a different set of issues (esp. hotplug granularity).
> 
> An alternative I can think of is to mark a hot-plugged memory block dedicated
> to memmap and use it for new memory block’s memmap provision. In this way,
> a 256MB memory block can be used for 256MB*(256MB/4MB)=16GB hot plugged memory.
> Yes, it will waste memory before 256MB+16GB is online, but that might be
> easier to handle than variable sized memory block, I suppose?
> 
> >

The devil is in the details here.  We'd need a way for the driver to
tell hotplug "use this for memmap for some yet-to-be-mapped region" -
rather than having that allocate naturally.  Either this, or a special
ZONE specifically for memmap allocations.

~Gregory
