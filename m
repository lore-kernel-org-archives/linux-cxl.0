Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3792EBB8D
	for <linux-cxl@vger.kernel.org>; Sat,  8 Aug 2026 05:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786168381; cv=pass; b=j8RMgp9wyAwRLo9gYEJKguSBBnAqqyakZtduOM0HAqBO+3VXe+jrih5dCKutQ6oWT6OHXvAZjxS3ldbFFwnw9+2Jx5V8zZg8dDu5iNLLhrqf/shpPEz2UtPK1eveo0CwfafBOo6VpaehVoaDDLpxCdIQN/13czrt6q2d/tw7MCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786168381; c=relaxed/simple;
	bh=ncxgN9HbsNFYQUsnQwCBTsVtBObO/3OvMVIWlbrKiu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rc9XhXlwadzUSt1p/RaFViTut4i+BjpS02+RrNNnqioBDtKCKlCeb3sjmu0Uv4S1J9F2CxJXK7jsaUH1B8RCbYUxbx/r22+R9t3t9CSlubvGXrexcJlICCOlL6pHf9/eCyro7EKCsOKkYBIQY/qNYYPLos0f7vIXFaYthHbo6tY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=IBsGE72P; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="IBsGE72P"
ARC-Seal: i=1; a=rsa-sha256; t=1786168373; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ST6HGuKAgrnaPjcTo8dT8ztwH/AC/P3K2zj95nMl0xCr42Jd8e1XlXWpaLTi3XzoRnBOrWlsPyI1N7uBLOeR44+NNE8EaKYodU9cE11Wu00c25S3BBsrtsTZFL3C5fQsvfKfjYgtvJ9loOwSuBtKkrVV7p6BUiVPbhwch3yghIs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1786168373; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ncxgN9HbsNFYQUsnQwCBTsVtBObO/3OvMVIWlbrKiu8=; 
	b=bOw8fa/HvBMyrrz5fenkQhZ5cIH+GpDhaw/eh03br6Vke3qmsNGVRCPS74cLbHLm+b8cQan3HRkrN6d0i4uIJiIsJILgMRljTKg5pYSf7co6qwVsv6SYBvPS3vzUku6Cjb+nAFzXY0T9tQ7It4yIfCi6qMCvzl5seOpzl3KAyoU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786168373;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=ncxgN9HbsNFYQUsnQwCBTsVtBObO/3OvMVIWlbrKiu8=;
	b=IBsGE72PBbSVZc5K6/W8fZMum0Lud86eN8/UWDzv4hTxisEo+SiJ1DXDSJ9xMFxO
	gNf08T/8GsOJCv/cyG8qxW0FwXP9oo6RxPSfiEQghCAjh6R9I0mW6deE1YOI5rasAZg
	1vjOfm9+yZ+VpXumb8OsEzWIHGjf3N/kvhdfif3c=
Received: by mx.zohomail.com with SMTPS id 1786168369826730.2505866632396;
	Fri, 7 Aug 2026 22:52:49 -0700 (PDT)
Message-ID: <8fed1b31-4c4b-4b52-9a3d-42749669cf40@zohomail.com>
Date: Sat, 8 Aug 2026 13:52:42 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] cxl/port: Bound switch decoder target array access
 by nr_targets
To: Alison Schofield <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org, Srirangan Madhavan <smadhavan@nvidia.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <iweiny@kernel.org>
References: <cover.1786143520.git.alison.schofield@intel.com>
 <d7577652cc6d414e1de0ee4045d4d6b2808172ce.1786143520.git.alison.schofield@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <d7577652cc6d414e1de0ee4045d4d6b2808172ce.1786143520.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: zu080112279109e3a5105b16e270fb3476000055cdf711e3f89cd1a25f5056f163d5f6ba8d136eb70205fae8:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External

On 8/8/2026 8:05 AM, Alison Schofield wrote:
> Switch decoder target lookups walk the target array using interleave
> ways as the bound. The array is allocated with nr_targets entries, so a
> decoder whose interleave ways exceeds nr_targets reads and writes past
> the end of it. That happens during dport activation, during decoder
> target population, and when userspace reads the target_list attribute.
>
> Bounding by nr_targets alone is not correct either. Commit d6488fee6647
> ("cxl/port: Fix decoder initialization when nr_targets > interleave_ways")
> moved target population to interleave ways precisely so that targets a
> decoder does not use are left unpopulated. Neither field alone is a safe
> bound, so add a helper that returns the minimum of the two and use it at
> every walk of the target array.
>
> Valid configurations keep interleave ways within nr_targets, so this is
> not a behavior change for them.
>
> Fixes: 40ba17afdfab ("cxl/acpi: Introduce cxl_decoder objects")
> Fixes: d6488fee6647 ("cxl/port: Fix decoder initialization when nr_targets > interleave_ways")
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
