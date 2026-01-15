Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC46130214B
	for <linux-cxl@vger.kernel.org>; Thu, 15 Jan 2026 17:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768498968; cv=none; b=FthnhmB2h7mbY3bjd0Q6LpIlLPo+lnQrxWKHjTJudRXDeHy2GC0AizMHMjMiwtPmgO1aNk5A4we/MzzYv7Yvwnb2slzSL8xtrkULkRHT3VtZo/5ThtnUpULq0xodx7G6lZiaYJd8sTh9ijlpjifStcchc6f+lr57hUvYQT68fhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768498968; c=relaxed/simple;
	bh=7rVJtF+bvJULYMq8lpChlQoAbB/f9XjCtTYOiHbBkFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3JAHEKizVSl1NP2wnAWGwyNOoow4jdGmWjosxxoDYNbyY+Ve2Ew+Yh7pUFl2ORJltZBiJE5qoqCbcAWjP3CCJ0ga/98UhZRPkIQPmaRkn1PMcEqn48Yl9JOUK9eqKf+TAVnAW3vPGCy1PZ9kVrgp6EZKtNNqIS4fnI2HRk1iC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=QGnccM0h; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="QGnccM0h"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8c2c36c10dbso139470085a.2
        for <linux-cxl@vger.kernel.org>; Thu, 15 Jan 2026 09:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768498966; x=1769103766; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qzIg+4sDQXFup5j8N72u0s9znKRCdSZxBT6As8A61p4=;
        b=QGnccM0hLWQA3j/AWxSwkO4v/2QGjEKkL437JAjbv55DosaiJMPC+p/MEIsYVFTu+/
         jSlWDVzvMjByDnNiEGx7SipBojelK8m2ricssLEpoMeHq56zalz4m0/rUMFUlrq9ZIBG
         DCdD6oazZZVFpKr8HGRMlPfq+/ODTE5JbBPq4S0KAldvEUu0eBbru2kd2/MK8dnenEch
         U8+W061OTbS6OwKJp9aPunNutozh0+wXX57UZghC2I8Iyuc8nRJ5eseOZmXzsoNXMHxq
         /xNh1NMUBpZ5r0GD0Od52A3BWNYFHc6tXd421P0jtyNVGE8pop0i7wNvCuYAJWWkMurt
         fj6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768498966; x=1769103766;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qzIg+4sDQXFup5j8N72u0s9znKRCdSZxBT6As8A61p4=;
        b=vXMAvyntrx/CtybVVLjNICU2e/D5zFM0Ig9+0yvYaH+mCJxHpd7b3o26HW1cW4ryiZ
         LxT2qtOoyaR9gQVchA5SLHUTCNBc3ptfT3WE5T9AW3u9fPmEIqPNUgqQ4QUk328BRpAv
         BwMzoXRML7K2MDdNAeVHqxSVdaLAsma6OLUKEIcrhMDzTHByzmOzDW/vAeTssUQTKOiG
         9nP9bREa3zSj/8lelYhMlDS17ohsprUHZD9UmTnsmXQSC4RbXBPlNBfHRCN3Dp4lwwgt
         zfUmiPuWMVHcRxb+enMelbV+jBvGQG+GgPR3wXp/Z2Pibzlajvw78b4rcCf/d8dXNbAu
         6Wrg==
X-Forwarded-Encrypted: i=1; AJvYcCVPR5ndJmAwkMym/o4UXclqttUA2ffgTxcqK0mPi59l7fIkELQPSas09CcNa+AYXYZpVFOIK1ITXYs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6V0bRQXLJoEC8yQySREB8HGIrv/B7OUS09+GitDuu+rR9bfS+
	25VCupJQgG087bN+KfwsMO0tDY1m39zvkRLNRS+hN1wIGvuAoa1+1EZg5dOv078iyh4=
X-Gm-Gg: AY/fxX70zE+rq6mjGG6sNoROVzuUTeiBhnoNvOzk9g05ggsW65UyAxNNEAqLWhmEnoj
	4ATF4OGJZEHFgLRTKcgaCiLTh/t+fprXQg0xgIk2CMXIzUckVJqZUNjnlWPx3d23jOf39Ng+83/
	k83kLH5bxR6WtiA28aBUiW0aNzMjZVtw9SdyWh7eSxPFDsTXDIrzqhSgLv/W/UqGiKEvFw7D0hW
	zMRNwL14Bph0aQ9Y95k4e24YDq/iHoIZfx2mGtrxUTlL+fXlvsVfsntF8FqcJVPJfJhkxOvN/9M
	hcLSi3syG2yDMEK7M/n7Nuk6KljkP/PZ5ytkeBDLmkZ0gf6HbcgTSyqgJ7pPgF/0H3ztJrxJ8mn
	EuVijQ282nYNnhrnTAeC5ZrensNNWQKiPNA528bCAy0dBk4IFw9+vpI1oiIEpokatsnoBZVI52x
	BADLceB90eQAYMCEbqDVSAdfk/bTX4ZeQcf5RTtWwamW3qGCdM6McRN5lmZDJ0LSVR0yZqrw==
X-Received: by 2002:a05:620a:6c0d:b0:8b2:e533:66f7 with SMTP id af79cd13be357-8c6a66da89bmr35061185a.10.1768498965430;
        Thu, 15 Jan 2026 09:42:45 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c530bacb43sm463952585a.41.2026.01.15.09.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 09:42:44 -0800 (PST)
Date: Thu, 15 Jan 2026 12:42:11 -0500
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: linux-mm@kvack.org, linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	kernel-team@meta.com, dan.j.williams@intel.com,
	vishal.l.verma@intel.com, dave.jiang@intel.com, mst@redhat.com,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, osalvador@suse.de, akpm@linux-foundation.org
Subject: Re: [PATCH v2 0/5] add runtime hotplug state control
Message-ID: <aWkm8zVc9zy1w3eM@gourry-fedora-PF4VCD3F>
References: <20260114235022.3437787-1-gourry@gourry.net>
 <eb3e6ae9-d296-465f-a5a9-963da4d8ce6a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb3e6ae9-d296-465f-a5a9-963da4d8ce6a@kernel.org>

On Thu, Jan 15, 2026 at 06:26:21PM +0100, David Hildenbrand (Red Hat) wrote:
> On 1/15/26 00:50, Gregory Price wrote:
> > The dax kmem driver currently onlines memory automatically during
> > probe using the system's default online policy but provides no way
> > to control or query the entire region state at runtime.
> > 
> > This series adds a sysfs interface to control DAX kmem memory
> > hotplug state, and refactors the memory_hotplug paths to make it
> > possible for drivers to request an online type at hotplug time.
> 
> Gregory, slow down a bit please. I haven't even had the chance to go through
> your replies on v1.
>

Sorry, i realized your feedback on v1 showed there was just too much
complexity.  I would ignore v1 entirely at this point, this version is
significantly simpler.

> I'm currently on PTO and don't have the full day to review stuff :) And boy
> oh boy, do I have a lot of stuff in my inbox.
>
> Maybe given this is the second time the patch subject is suboptimal is
> another sign to slow down a bit? :P
> 

Apologies, and I will let this one sit.

~Gregory
