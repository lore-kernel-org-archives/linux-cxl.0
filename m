Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEB94B04B3
	for <linux-cxl@vger.kernel.org>; Mon, 17 Aug 2026 00:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786927582; cv=none; b=g2dNosP2nTs1wfvMyB+7HTguQTGuxln2lyC6Ia1FtYHOxkfBt09PomZVoRmOTQk52XFyGjltHYPitVMd+JzEt62bz8R44AV3dc8LgeV7HyN948I29Z+kTIqvDSX6qgZlsGw2TVRzRk9eYhYJdw2y7vEpR4Tnm1lcDrzGvKKdQG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786927582; c=relaxed/simple;
	bh=ZERJlqmkFypfjYaByxkccL/su6TxOP0i7lN3f2Qe8Mo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UlHZRlgWEJdJ6NGSklByieA/bbqk1Mj9vGygfhYLAqigxhOun5HUPOZEunJOzCRMCWnN1aMJGr5Xp5yZo6AmSnnw339Up0Xn+IIdzRpIGLF8F96RhKWcsw1KTX4i678kfpYPodhXoV+1/7mqE444UtcXhsNtnRK2CBSgi4OL8M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=tryFzXye; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="tryFzXye"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51c4436d02cso6541151cf.1
        for <linux-cxl@vger.kernel.org>; Sun, 16 Aug 2026 17:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1786927580; x=1787532380; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1adrpR3QLynHsYFALPxmo4Zb1MnnrvFb0B1zDnSkG3k=;
        b=tryFzXyeBmzq8shqBuPnihvWBi3OBO8SHMC0OcDwL5V68cWxoopCaSww288nq33L7n
         IRKRqkB+U9v8klnSdnotQLZJzp2fWdp19FooE07ohrR6nnvTlFOZMx7LX4i1/LTeZswu
         2eOQ49EjRWI3WaNDMnefY7AOZ28J+IM+xAmYdajE86Z2nFI/BxMClRUvfUSzxFqrjCv1
         gFi9K6SXwz56bMZmuum81ukNjpUy3st9bbfCV8Bk9z3fHEk2Ooe9mXW5tvyLP6LBgK2i
         6L3Aed0QjBdewNBKHpUtqRKS6eq0MLiFjDlhbycaQ7HmV+Hdi3uhJjpiVU3SveXZTlvM
         3X9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786927580; x=1787532380;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1adrpR3QLynHsYFALPxmo4Zb1MnnrvFb0B1zDnSkG3k=;
        b=b5GHjS0F0dcHUeel6Tm4Z298lGuJxyVAPfql2XO4L2Z6/ExGt+8khGh+uW35E2vOHk
         2zEnyMEd8r7NBaNhW5x7egtkU9+TsN1dZHcseSJ1PbLLMjyA8olWjYfPV1sUD7m+Qh0O
         ttM3/tqRBvDTkgFnRvH8veNOXsLJq7tV4iUrf1XvdVwPWmsowuqL6MVwNhJNYdu2zaAc
         9N6/tYY4oJ0i1CMLHY/AwHfHS+ZoGC+b00u2me1KPzxJ83w86YKEqos8hzDcQkF3Zmiq
         Ie6FC5qYiTIc4Yfv7rB4QfEJ0O7T5DA2CXW2vNrzXBn826qXt19PsTQ8nFgSo7W7TMHs
         Zr7g==
X-Forwarded-Encrypted: i=1; AHgh+RoVFWDK7Cw3RLJjt+IIB5RZeq6i4+fag8FVDxMZu1kTRFNXxYXod54Kn/YT8wGw8ZCMqWzvnYoXbzg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe33DIME1jAoA6xGZ2wh2OtTVp648T85yNpiYTYJsGBHD+1EmV
	juTo9dY+m7pcDV7qY3AKASsD4JUU9pFd93/2MxU2o67bwPz8rSs8b3m+MtYvMjpgr/8=
X-Gm-Gg: AR+sD1103FA6FU/EI04dtUCl/7qlLfaDbhGZTVznLukUOoEP5dcFyIcJRiZ+P42vxYC
	hWHxptVB7Tk+0UjLhP/E5D2jT07gVn4eb+HyAJbgYTDxyYiyJsRknNrWuoh+ay1ZOzzl70MgNW3
	0n9UuF7Z4nosE94xk7uzAPgmmHBkqI78tTMETibTAphC2fzsmTKN6HEZP+jZNOR1vGYmkZMJoVD
	yHPXcxZ3FzLzzT0Ds1qIN0PB3dWAlESNELd1rwmdQpLz2jsDaBZAt2fTIl/aHQ4TtV5Zts9U6Mv
	i30Um6xMUPKiaRl/H+V30QErnfEVYgjaQE3cVr3TIqO63MY0KNAe4x19yC2PMvSY8Hi1h8Ep0+G
	oERtZSxQkFRghkt9pvRrl4oZNjqKUOzxnYNmHX7fSMhfjFdSN/Bfb3aW8hOQxZY0iwqKgJ+lJFN
	7cVEi6pU3rHYYUvx074jLEdtoAEuPIlFfeOGrWndrqeB0U8JxhEPbhgi8DW2+LrPmhTli0kN+eZ
	6SvRLpiCv4/LvPRvCqZbbGnKd4HIFNCAuJgEsAOZuhWZ9ZpVMelSkk=
X-Received: by 2002:ac8:5f10:0:b0:528:1478:e1fc with SMTP id d75a77b69052e-52d854a4899mr216242221cf.34.1786927579795;
        Sun, 16 Aug 2026 17:46:19 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52db612c2bfsm1249061cf.11.2026.08.16.17.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 17:46:19 -0700 (PDT)
Date: Sun, 16 Aug 2026 20:46:16 -0400
From: Gregory Price <gourry@gourry.net>
To: Rakie Kim <rakie.kim@sk.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev, 
	ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	byungchul@sk.com, ying.huang@linux.alibaba.com, apopple@nvidia.com, 
	david@kernel.org, ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, dave@stgolabs.net, 
	jic23@kernel.org, dave.jiang@intel.com, alison.schofield@intel.com, 
	vishal.l.verma@intel.com, ira.weiny@intel.com, harry@kernel.org, kernel_team@skhynix.com, 
	honggyu.kim@sk.com, yunjeong.mun@sk.com
Subject: Re: [PATCH 0/4] mm/mempolicy: introduce package-aware weighted
 interleave
Message-ID: <aoJY53BJztPQYumw@gourry-fedora-PF4VCD3F>
References: <an0t0mP9JB8f4ILK@fedora>
 <20260813062351.1856-1-rakie.kim@sk.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813062351.1856-1-rakie.kim@sk.com>

On Thu, Aug 13, 2026 at 03:23:48PM +0900, Rakie Kim wrote:
> On Wed, 12 Aug 2026 22:37:06 -0400 Gregory Price <gourry@gourry.net> wrote:
> 
> The cpuset.mems = 0,2 you describe is the node set of package 0, so
> the tasks in that cgroup use node0 and node2 wherever they run.
> 

I think you are over-complicating the explanation and that's making it
hard for folks to reason about this.

My best understanding here is for multi-socket systems, weighted
interleave as-designed is inherently sub-optimal for scaled workloads
that utilize multi-socket ("package") memory resources (DRAM, CXL...)

I think there is also an assumption that total memory utilization is
less than the total capacity - otherwise some of the assumptions here
break, but that comes with the general weighted interleave story.

I'm getting back from vacation, I will take a closer look this week.

~Gregory
