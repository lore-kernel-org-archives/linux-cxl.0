Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0123833D6C1
	for <linux-cxl@vger.kernel.org>; Fri, 10 Jul 2026 01:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783647022; cv=none; b=XVUWa+bSU6LJdvieWawpkriFzthp96lWgGhHTv0+eRko2+LfSbHBz+oxKO2xtbkk72Kya9Sc1zoAl03HlYPnqI6LDgBKmm75UF4NmGS3I7ASVPV7kRPd2kRR/6qqc82WjGpo0LoePNnrNguDxLpEV5AIY7mkGs3Uk/uUdoWQ8X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783647022; c=relaxed/simple;
	bh=3rYTe8e2Wt412qzExNzuhcRev2Wp33ZA51eAifLPzps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jagF005FIYXMgr1WHyVOJNUtQ1Grt3d0sOixbQ35gEUM1gvBZrRGjh0ucJcowU6PmW2BX5H4FEMqDaS2U79KMT1AegUe3HvQwQmD7MsOw6lD0EKMxZ5BF58GvSdAuaREdpzL9i84YGV1zH/8gZ/cpcC5qTQR8Hk5DHAb6jGJHLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ezt3K41n; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ezt3K41n"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8f1e274ccb9so2828616d6.2
        for <linux-cxl@vger.kernel.org>; Thu, 09 Jul 2026 18:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783647020; x=1784251820; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VaPhGtocKLbFXsyQXoR9g3DKOWhugqrS27IBZSVVhcw=;
        b=ezt3K41ndVI8K/PBTlFKFJBkY+47UWEjGaVnCpfxtVzzaiLbm1NZQP6lwkzck8cAHd
         nWxzWpxujl/DWdoer7tQfKNaNXZQmPIQVtdWuMXWksgOJiB5bfVbRZYU+Y+LrAKPUVOT
         ut1oh90UnAc9GcZxvnx/kiCbksRghpUtOSXdGxhPAbQIsCj5NCojyP+4R1JS/tuFlPY9
         Pw8gCJpbLxPeZj8pFil6k+itECVO5PzKojFiKr3gVw+6Z1oVtednjjAh+hSV8OzDCWdB
         bSQNJ9stOPQtopOblsEqCLS/USMKedJen9MlXZszjjaMRh8Eph3kP1wJVtoS0CPOVX2F
         HXVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783647020; x=1784251820;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VaPhGtocKLbFXsyQXoR9g3DKOWhugqrS27IBZSVVhcw=;
        b=X25z6GXhxsUPmnyYk64Zl3PcO/OMJ7E5Qa0IqY5KaY/JpE8tyh+3/aF6F0o/Qzfjds
         O8mh+83QWzAtmCIQfT7LAq+vuaOM6F3Q6515v8vq73LcwYMrLJdNDo248yGnqMV3aV0+
         ueXhlG5jEwJNs8GJMWL/Ace9DXgtcMQTLw7cXn+GNiAOv2e3LFjtm4CicneBxZxYA7pf
         AYIc16AVTuxUnFWj9bx+jdfA0eIwMeQPoeYGahxa3sdBfBAvrfA3MrKxVgRUxKeZgzDf
         TbOlI0oJQ7wIHSHL2Z4ULn48P6gvB524lPw/L8Qd85ShtTtVz8mQM9xBoHf2ehdN9MBg
         L6WA==
X-Forwarded-Encrypted: i=1; AHgh+RqVZnzFY6yUw6waLOqZPISzm8VzwaatFUbL+GcCibsZ2zBHREcCfFej8AW25ovOuz8ZunRxdReLevE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCiHe4EGAZ6gfk0VOjV2GzrtWC8xBCP40Sxsp289+1qlcLntW4
	LEMvY5s+zVaWYuOiLqw5KNgWRz/yAAinHgcDihLnWxr+UDUd7/DPP9EtPnOnxCyi/Mw=
X-Gm-Gg: AfdE7ckQ3ZSAiL4WQyxjvhKcNjwAOiK1lSFJ0Lz/5503Tp/lCMPO+hDF6H/qFYV78Es
	4kmlwH+ALVe3JEPiF09Eu+pjUQzMo6oBjQwSxKF/zt9S3Yl9Cw6gXHH+gitu+jRhzWX2ag23oKr
	wuZASQaFsROiGjCR+D7JbEP+YD0ntedngm6n6oIGZjnUpLTuS01dms3sUxICGrYnBgVX5KReNG5
	YwK23cFDBke+OOuIMJs3XVTn8qvqiET3mmsUvtqO+AyT8Av3tIqNjzswseBnNmnQyR0r3N4zowR
	UEZKqb1RdKLy5tH9kErqA1ceWYeQ6rA202NZFp1mZ47u/Vif+TV5fewU8d+KJolUumWDotLg4jZ
	af7BjSGUb3qYKgvyBRBBOvdTh5CH4FNF9vY33ZfGT+y/xYXGS6Hjn2TerMXMJe/x6Maqv128OQ2
	wYDqFHJa8LVJBXxj7+81f4nnPLV52TKv6sH7O0NJREgCMssX0TU+ydnWJlvHysUf27hyn6
X-Received: by 2002:ad4:5c8a:0:b0:8cc:2a92:48e4 with SMTP id 6a1803df08f44-8fec217b8bfmr110693186d6.32.1783647019857;
        Thu, 09 Jul 2026 18:30:19 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd7c1e8aesm29789146d6.28.2026.07.09.18.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 18:30:19 -0700 (PDT)
Date: Thu, 9 Jul 2026 21:30:14 -0400
From: Gregory Price <gourry@gourry.net>
To: "Dan Williams (nvidia)" <djbw@kernel.org>
Cc: linux-mm@kvack.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	driver-core@lists.linux.dev, linux-kselftest@vger.kernel.org,
	kernel-team@meta.com, david@kernel.org, osalvador@suse.de,
	gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
	vishal.l.verma@intel.com, dave.jiang@intel.com,
	alison.schofield@intel.com, akpm@linux-foundation.org,
	ljs@kernel.org, liam@infradead.org, vbabka@kernel.org,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	shuah@kernel.org, iweiny@kernel.org,
	Smita.KoralahalliChannabasappa@amd.com, apopple@nvidia.com
Subject: Re: [PATCH v6 07/10] dax: plumb hotplug online_type through dax
Message-ID: <alBLJoM86ujz5Fg1@gourry-fedora-PF4VCD3F>
References: <20260630211842.2252800-1-gourry@gourry.net>
 <20260630211842.2252800-8-gourry@gourry.net>
 <6a5016bf71df4_3b7ee5100b3@djbw-dev.notmuch>
 <alAb7Q_Ku5dVRKZ7@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alAb7Q_Ku5dVRKZ7@gourry-fedora-PF4VCD3F>

On Thu, Jul 09, 2026 at 06:08:45PM -0400, Gregory Price wrote:
> On Thu, Jul 09, 2026 at 02:46:39PM -0700, Dan Williams (nvidia) wrote:
> 
> This was more a matter of having the DEFAULT set consistently across
> the dax driver variant probe() functions to make the behavior explicit.
> I didn't want an un-set value bug to creep in here somehow.
> 
> Happy to drop them if you think that's unneeded.
> 

Ah

Not setting the value in each of those places is equivalent to setting
MMOP_OFFLINE (0), so better to just set DEFAULT regardless.

So unless you have strong feelings i will keep them as-is.

~Gregory
