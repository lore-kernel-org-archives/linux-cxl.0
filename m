Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B8643E9C4
	for <linux-cxl@vger.kernel.org>; Mon, 17 Aug 2026 16:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786983598; cv=none; b=Dr/O2dPuq2m64rh7LYtJtIGRYlnMhP1xYAHlrJxX76WxDOT2XvAWLbmJ8yksh62nAUgYZZLJGuaFaRRVDq8KtIp5Aqr9rGn09txm1yNkjvIRUOt0QBX4dByuT0qax+1gERgKoNRJSklg7U538yQrJZotgvxRerz6REhKHPmnz6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786983598; c=relaxed/simple;
	bh=nz9452HQkCizulHzHgH6sPXgLsUkaADhbih6+tFp8A8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bPKmWZzOqm/wsTKmxVvKpDjBIc2qMAEGJHz8Mwv99UXpyi3ZsVoNDBwK9PZzGh73NP2fqf4p6Sk1iKHz48FOz1GjiXXNcz15OLW6b1kvqxkitaKiRrhQkanu0vbRxYd+7JsTyQKlKcEFwomXsvc4P7gN0FukPL7Cf3woJh0pLK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=fXvUSPwi; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="fXvUSPwi"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-92e6a434cabso168947285a.1
        for <linux-cxl@vger.kernel.org>; Mon, 17 Aug 2026 09:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1786983593; x=1787588393; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=g79rp1EAN8LS02s21Qd/CfSeDeEXT49xOteHy0W5fBY=;
        b=fXvUSPwiiLw1YebLJTtdAJ+CWLPQde4QHB1KfV4EKsyE1eW9krRh3ShCiG6fL8P4E9
         5PnrjumLCqIrPootoxDqEp0oYeXPOvoi97cv2s/o4MnVvfvwBKPy8ZGZBfGbskQxP1IB
         t401JIexZfnsHMxTwe/wk7zKFgxf7NVazvwZ9R0fckExm3B1LrNnFG369shmOTrW3gU6
         M3szJZ1jXobLbZqYLo9nmMm8+q8weSrs52c7CrpQHDsQShpnFyw/1IknqxyazhYNYEMd
         nFaBMREejsORutE9LiOVytMx8E6/6cUuJMH0o5cD+Wj8gc0Cr9jM6vL100BblBazZiSG
         RIRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786983593; x=1787588393;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g79rp1EAN8LS02s21Qd/CfSeDeEXT49xOteHy0W5fBY=;
        b=hP6lbsJZCLHeNSFH1WbZRMrbqopQqfQtoRyDn83HTgoQYlCb2IcogOVJ2J1aIWDl4K
         4nZp/JCnN4AjpOYEE75aj5N1Xj6B0iV5Gcy3RDHjJPSCSmWxggc2NHpEe2VY3ZbBDpbH
         8AQHYFpk+fsHW85SkC4558jxYYxCZiXzs5kFTYa9BabYlslJH4f++u7hi86lUSFaXkUu
         2gsL2oAz9UIoLUZGwSqEJLA0Gbl+bDwpTtKav2EEpwrpLwUwhVHEzC4c4V0WNoZPeTLW
         886bhDwzSa3yofIpbP9U7hdcMM0vBcambQBhnUbK2HCC0CNQABm+HA/i52y9AknbNCj2
         Dfag==
X-Forwarded-Encrypted: i=1; AHgh+RrmIl7dExW6yvf9awsRUgdM/8pILbOKsHMtx52wqWmHv5FLFbQRGwgb+7KifysBcq+a90Om73LK+Fo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaxUwIDRXIah9SPb5FX+8gfDhOW62BH0vB4uZmRXbgCNq3xFew
	WuJMa1ODyzxQM8MGrwZdDBw1KZ+jPn1b8RK6vEC4R4/AZwEvNWHZCc5EXEF1HyhE7Tg=
X-Gm-Gg: AR+sD10I6Tze/yP+ODhKTAgfCwNvK8dnBjoRYyeT2olEf1ERCY2Svb7o+3/sff4+sNB
	S4DwD7Xk1XbL5yrJQhXKhCat6nQpXONdej+etZ7kGGWBbXgRIF0J0Nr2/glhebJr681ryMj1d70
	1d0qHSGhqJylf30jESVgX9qBgM7X9HoETaWjHJkg/njA2JwmtIYMT69ToHzcIHktW6nsqQs2PHS
	cUKvrTZ4a+Lk/LEbP4iHxbUbgenzqMq1fP8ZJ8icsXP8X5m8hrhBUHvOJDGmCM6FXK5KisUqNMA
	fZ9wb5LIVhtJ0f2uFxaQBUOq1i9jfPG1m5uBLXQE1N9oJHsW1lo/7JTk9j6rjc5n6HQ/gw+sl8e
	fjX/NZ62XidIw+3ICh2l/CKad7flF3R9PLXzymg4SdE6JVEGL5BRguOHXMXIDFJRfFERQKdc/Rx
	Da9fPXyu35QYChnuyBGS9ybuUZw1pqVz34ENJ8sYreHbT3y6T9ICgIClf56BrIKOLXzY4EIX3Dv
	hI5CyXWg4AXh0rzuoqhniVz+qYEjoD/DfK/c5WaBuN1
X-Received: by 2002:a05:620a:5302:b0:936:ce17:dac3 with SMTP id af79cd13be357-936d238d066mr2289883285a.40.1786983593483;
        Mon, 17 Aug 2026 09:19:53 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-937033ce78csm80835485a.31.2026.08.17.09.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 09:19:53 -0700 (PDT)
Date: Mon, 17 Aug 2026 12:19:51 -0400
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
Message-ID: <aoMv3OhqkBTzSfek@gourry-fedora-PF4VCD3F>
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
> 
> To make this possible the kernel needs a notion of which nodes share a
> package. The NUMA distance model offers only relative latencies and no
> structural grouping, which is especially limiting for CXL memory nodes
> that come online without an explicit package association.
> 

The original attempt to handle cross-socket interleave tried to deal
with this with a matrix for weights, but this was deemed too invasive.

This brings back that matrix, but not for per-node weights - we're
basically just adding an addition weighting to filter on.

I have some concerns with the now additional filtering mechanism
introdced into the allocation stack, but fundamentally I think this is 
a *better* solution than a straight weight-matrix.

I will need to chew on this for a bit.  It seems there's non-trivial
sashiko bug reports here to address anyway.

> The series adds a package-aware topology layer that groups CPU and
> memory-only nodes into a "memory package", built from the physical
> package ids firmware reports and, for a memory-only node, an initiator
> CPU node or SLIT distances. A package can contain more than one CPU node
> or more than one memory-only node, so the layer maps a package to a set
> of nodes rather than to a single node or a single CXL device.
> 

When worded this way, "Package" sounds completely arbitrary and not a
useful distinction.  This really just sounds like an extention for the
existing fallback lists to take interconnects into account.

I wonder if abstract distance either:
  1) already gives you what you want (the secondary weight)
  2) can be twiddled in BIOS to give you what you want.

> The feature is off by default and opt-in through a sysfs toggle. The
> package topology itself is exposed read-only under
> /sys/devices/system/package/; there is deliberately no writable
> override, since a machine whose firmware describes its topology
> incorrectly should be fixed in firmware. On a topology that does not
> have the symmetric shape the placement relies on, enabling is refused
> and any active mode degrades cleanly to the original flat behavior.

The way this is written it sounds to me like this should just be the
default weighted interleave behavior.  We already know weighted
interleave does not jive well with multi-socket systems - this just
fixes that (in a more general sense, Socket => Package).

~Gregory
