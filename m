Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A6B19C569
	for <linux-cxl@vger.kernel.org>; Mon, 24 Mar 2025 13:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742823175; cv=none; b=qL8fLvmPGzFfTO5GldP4KduWNN0Qg37TAIRzEKn1+KfCoUqMh7KP9XberSqcKGA6QwsT6csfSIelhHknwTuoQt6+n8ugh5ZMyV5sOC4Tj/BhtbXSz6cGa8lkVhumrKVrmEhRFLo/RHX5j1kswG/x6Tj1IlxqVZwuRDeurHRSBBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742823175; c=relaxed/simple;
	bh=jyMXTLyNgoR+3Mh43uHX54/Ii8JgrwxoERkKPkXm7H4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bBGttwYy4mc1JiHPd+8w4frgcp1hH+20ePVtzokasoB74DbqoVOhMyvmEb/f/BFhUnei2v42cQWb5L8AZedHuaD3IKXehr6Nnn1zzjLgK4iaYlpTbgB6lPuIbIWFA7nOLt3rU0h7i3mQNj6SQOP/MSQRTO9cvIOCReSnuMW2Mpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=gebCyklj; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="gebCyklj"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6e8f254b875so39398966d6.1
        for <linux-cxl@vger.kernel.org>; Mon, 24 Mar 2025 06:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1742823172; x=1743427972; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iJ3k7yEhYDRnLKFARJZHNQlKgfuegZSgLZhOzT1gU3A=;
        b=gebCykljom64PRfiMPz5Rb9bwBFSxX4MbQEFO4m0eDTy1ODTtv7k2XjH5dbV+AbV7u
         zZ3amKMtNneMeV1wkqgiFzzyw8YM4U1W2B0Fy43wDwW1EI77HywLVsNXTdZE7/LV8NF8
         03sN9uW9TYZei4WYTYk46yqqw9++n/XE7zRLGrWpCrz2VCeOJz76rpnL8UVHukXESsQB
         eBOk3RwNvLJeOWJ0ggxUageoixKLtNeXFdHptLKL5M1QJc7ELe2A2v0DmrXrJ9N6Soxo
         HM49bWCVUVcWbXxcEl6d9o/VcMVQfz1gKA4ECGSdDbCpNKwQ5m3dVYsOaT3LtoPFIvDw
         6d6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742823172; x=1743427972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iJ3k7yEhYDRnLKFARJZHNQlKgfuegZSgLZhOzT1gU3A=;
        b=Ssf5NtLT/k0O+syCy/OED35B7HpqA8eYURY7Bai8Z7fCETZ4Hn9juk4M9r1KPyfpwl
         Yq52G3WsEU5MkRBz9lufzw/ji1lfjBr3B/UwCCWENhVQXHaBWKoWqIu+X7GgvVgNdmhg
         cngCNEegkxJ2A058enBsG2Q7noyC+0lUxrNeMpJ+CNVn+ihNfiFuuM2EaWfnu52YwOMA
         bHz0nY5a31bDSkn/3NOA7WbWVw9rtFgZinVSvBcGIXDhOJz/zrO5i06QpEY6iQ+ysrO6
         NvIDrJSpxscxqDoYv5NOrfwVxNpL+26KjSMOLKB8pSoI9Mz2eMj7cGliJ830afQ9fjkt
         ORbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjRRSWFq1w+GmLXenCJlQ1MEJVJgmRxL8B7CnLF14L6ECohMh/8N9ZvJ7KnPv6td61wLk0vtLZkos=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx73zEE6QZOoLSoQjemnyLcIl4cIYFKmFHXLIgqmcBoYxgh5450
	uSx52riJv1MSGnKm7y0DF84E8BZLrP6STCPS/FtBoIlqEaICx6W/7MunQyGHCWs=
X-Gm-Gg: ASbGncu4ga2BnyPPO59p4Gh3S3kYfyLKtP5PolKtjGVhGEwNzv7j1aTlAYa5p/GEe8Y
	1zX9mpAIFyUhMknGKX6OF3E8HlhQGGsKeKL82IejzGq9HO6pdnm3MEVFegeF2MiofgDPtwV0ZqD
	W5ooCK0k1D5dcRRxsoD/XgK44pgtPmieA3EEZHLp6wDPiFWjbN83ksx2r3KX8o19vCwO6Ii4FmT
	e5wgxiL4uVWd2D5xZRwoeZXotyXJaJNOXQ+BH6Fi1vIk7HG3eQXCgg+NmohQ0BhV4zAvd226b+M
	7hlbc9GPTlszX578DpCJTsx+reQqPiWFFvMOgk0NUqui224tFEXJew==
X-Google-Smtp-Source: AGHT+IH6AI2Hu4EvLbPfd+tJ+iT15wj0QMHGeMvnf+rKbGzhr8KsnPvdxaL8QbRANSa5d3GYbYPvMA==
X-Received: by 2002:ad4:5f4f:0:b0:6e8:fe16:4d45 with SMTP id 6a1803df08f44-6eb3f3446bemr145244976d6.41.1742823171962;
        Mon, 24 Mar 2025 06:32:51 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([99.209.85.25])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3ef34792sm44450036d6.68.2025.03.24.06.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 06:32:51 -0700 (PDT)
Date: Mon, 24 Mar 2025 09:32:49 -0400
From: Gregory Price <gourry@gourry.net>
To: Rakie Kim <rakie.kim@sk.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	joshua.hahnjy@gmail.com, dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com, david@redhat.com,
	Jonathan.Cameron@huawei.com, kernel_team@skhynix.com,
	honggyu.kim@sk.com, yunjeong.mun@sk.com
Subject: Re: [PATCH v3 3/3] mm/mempolicy: Support memory hotplug in weighted
 interleave
Message-ID: <Z-FfAUiGePF9mnPS@gourry-fedora-PF4VCD3F>
References: <20250324084920.987-1-rakie.kim@sk.com>
 <20250324085433.998-1-rakie.kim@sk.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324085433.998-1-rakie.kim@sk.com>

On Mon, Mar 24, 2025 at 05:54:27PM +0900, Rakie Kim wrote:
> 
> I'm sorry, the code is missing.
> I may not fully understand the scenario you described, but I think your concern
> can be addressed by adding a simple check like the following:
> 
>     case MEM_OFFLINE:
>         if (!node_state(nid, N_MEMORY)) --> this point
>             sysfs_wi_node_release(nid);
>

This should work.  I have some questions about whether there might be
some subtle race conditions with this implementation, but I can take a
look after LSFMM.  (Example: Two blocks being offlined/onlined at the
same time, is state(nid, N_MEMORY) a raced value?)

~Gregory
