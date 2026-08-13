Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721F12D7DC6
	for <linux-cxl@vger.kernel.org>; Thu, 13 Aug 2026 02:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786588633; cv=none; b=Rbnt3SNAQChpwXvpYFGbATMbKxoyECa2ry2RANEXRgUvbwqP9RBAYXs2cG2AXI6VaG0E9ux5NWfc2VrvgQl95imLSrIGyebbmWb1zsd32nidPDJBhoNBVuugcA97372OXHUbXJnFywfSA3GeG5RkW8RHOO2q5DQITmbDJAnskQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786588633; c=relaxed/simple;
	bh=ZAxW5Wglg+eNEd/7E2VgSitqFFT3iAHesn5itEgojfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XjrKmeqKjbcpFMCPSCMnpRH2AKpGla2T+cBXFND3XU+9nXsYOV8W9UlV4eNn/mlDBwWJSNHxp3QxFvfoXrQDYwSnQn28tfA2YFrCmzKYyBBd4eCGUA5HBgM7jwq8u8jBioZGt/VoWd77fnHNO4FIU0D9qPcNPFfiHunYklROgDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Ut1lI8+T; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Ut1lI8+T"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-92e65e18969so39504985a.1
        for <linux-cxl@vger.kernel.org>; Wed, 12 Aug 2026 19:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1786588630; x=1787193430; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iAIlYFnXn3LVoMPX9IDRNtgfCfuZ8em86m2CaDU8/H0=;
        b=Ut1lI8+Th91rtmqlpF5uu58FL6W24di/IVN4hD9Ua0yF90UzWtinb/QOnYj5x7ERuZ
         CydT8QftJMWWPo3BvKiPd/sI04dT+5AbtHtHzQiXmXraywowGZqXI1ySsACja90M5KVK
         YBuI6lXhaeqpJ1kXFGeYx4e1ImS/xYYcI3CoUrAuYaGQwdGB4brqud7deFDuDri2nDA6
         pAslgTE/zedgBN0RxD6AXKBg1YLXj8jQ5P5eADvXIjoD6nMHIyiAPw2FVhnzi8FGHEBm
         NiAbmltf2WVtAvq+loz782NxPLv5eJ6okoVOIFm+ik7DZIZ2Cp47f9sMFL5KKdaw77kV
         L4tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786588630; x=1787193430;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iAIlYFnXn3LVoMPX9IDRNtgfCfuZ8em86m2CaDU8/H0=;
        b=scsNNSpoaL0SnCHbavQj+34IkbCBn+IeidPflcdkmOiXi7f1sU019B9tPe0d0gb+3d
         jjJcUtXTgf39EG0+ivU2Ou6MV3GjalBUnPTbfKqJi32MfR8AwKmq89gUhi4k/pNo6K7M
         /Vo//cHMU5obJwfV9VVBIl5R92x5cfaQ5DWNa5ciAe7I8MVrEK94R0ruZHbM6leGCLLM
         Vh7aEkIj6MIje7kayM/zwjumOJuD6rwuOCaPbST/KL+ylSezycyYtstpMC5zEOmautH0
         8kC2nDr0A8f+yWxpZy/DSi53YiYc5PkS8nlYNPcRW/OA8JzaRCNw6+9aj00olTb2myEr
         /s4g==
X-Forwarded-Encrypted: i=1; AHgh+Rq/qeyY4cGDtr2vt7SnIDqr+dkkQsv5FDzidi7dY4WjsNEMMHEFju8Vuxzq9wjKGxrJOR4GJL01W4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBwligUiXEWtybj2u8XVvBzG6gsoMUl0hzaFzUBN5Yd48hmrt7
	aFEx2/2oP8CV/fSSKJ/J1E50WlThh4EB2BJL93w/bjM+awRWk8myhPeUQB35L1/Et+Q=
X-Gm-Gg: AR+sD13kCWV8bqXaPL9wX8atYq6Y4eYDVnpWBF9IFokZa4+FBHIiT3gmliNPU7dgSa/
	slRXP7DEDe/PUFxGVTt0dgP/9KE6MRNLZ0QwEROgqRg0ZVvr/wM+yFUgR5QrgInEzQN2czX0GEy
	aClQPm4GTfpvT8oyCt6vvg5ymPLGS02XgF6jdwJzMLdC0oso7K7WwGEDIq2uii31tWSjnlCmyGH
	tzrynstWT7BCf+Ie8RPcNfS4skQTim9KLVNPQd3eQnHHX0vD2ED4xCUaThHmtShcqFbsZgSJZmb
	HLpK/xExGDXX7S2pbOc4BjGCQ3D04Pp0Cg5QZib/PT0s0ieKlNgIUg17s6kmDaV5hF3ZmbIYI18
	yRh4WgSCm2i+aCD2XsFegOuZzrBEfVkAtFj+y++HA3trVoBgUNpVT3+tYuqbwyTGgqYHmzGzb4k
	kazRJ5Q136flTW89mpGL9JBtRoWwbBRXocCpzRZ6DB6AZd3w==
X-Received: by 2002:a05:620a:2727:b0:92b:3203:ea70 with SMTP id af79cd13be357-936c0b68fa2mr178922485a.12.1786588630298;
        Wed, 12 Aug 2026 19:37:10 -0700 (PDT)
Received: from fedora ([2601:19e:8500:d3c0::28fe])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-936c199108csm48835385a.19.2026.08.12.19.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 19:37:09 -0700 (PDT)
Date: Wed, 12 Aug 2026 22:37:06 -0400
From: Gregory Price <gourry@gourry.net>
To: Rakie Kim <rakie.kim@sk.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev, ziy@nvidia.com, matthew.brost@intel.com,
	joshua.hahnjy@gmail.com, byungchul@sk.com,
	ying.huang@linux.alibaba.com, apopple@nvidia.com, david@kernel.org,
	ljs@kernel.org, liam@infradead.org, vbabka@kernel.org,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	dave@stgolabs.net, jic23@kernel.org, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, harry@kernel.org, kernel_team@skhynix.com,
	honggyu.kim@sk.com, yunjeong.mun@sk.com
Subject: Re: [PATCH 0/4] mm/mempolicy: introduce package-aware weighted
 interleave
Message-ID: <an0t0mP9JB8f4ILK@fedora>
References: <20260806080936.421-1-rakie.kim@sk.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806080936.421-1-rakie.kim@sk.com>

On Thu, Aug 06, 2026 at 05:09:31PM +0900, Rakie Kim wrote:
> Package-aware weighted interleave places a task's weighted-interleave
> pages on the NUMA nodes of its local package, so that interleave traffic
> does not have to cross the interconnect to another package. This keeps
> each node's weight aligned with the bandwidth the task actually gets
> from it, so effective bandwidth holds up on a system that has more than
> one package. (A package is a CPU socket together with the memory
> attached to it.)
>

The only major question I have before I dig into the actual patches is
whether you actually need this on a *per-task* basis, rather than simply
a *per-process* basis - because that's all this really buys you.

You can already do what is described here by simply using a combination
of cpuset and mempolicy

cpuset.mems = 0,2
mempolicy = weighted interleave --all

If this is actually required on a per-task basis, then I agree this
concept is reasonable.  I just want to make we're grounded on a real
use case before we go adding this complexity.

~Gregory
