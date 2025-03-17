Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4965E21D5A2;
	Mon, 17 Mar 2025 08:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742199856; cv=none; b=AwXUF7XhgGSncZxrN4OPVE63kOofrMK8hO6SZMwi5tmr1eqsyYf2xnTJ/pZ1S8qHluKZjRKbQPh9WMSx68ef0YWZdu3REZRdfz645amtMumuL+FvCHddia0uQh5mxUU4uiF/N9VqAK6o5bNJ/L9oqF6u9BqblhNmFjOjYFHeYGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742199856; c=relaxed/simple;
	bh=BiwCSc+UTvZ2qvigYc0vMmu6VSHo6eQ0Lf5xt4+jM54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SH1VvZHldGj2dmjHY9RClZLxBCC1RZvdOL7NWBKAo0KQRD0p7QOl7ztbgDgSSm7HIvR9OPqjsfMGQPwgLpcAcXZz1L8FfllWh6Zt1U1a8pjvEJeKUQx6dj5ebnegWbwtu1WfLSH4P3gO3UVGBXKwljYSABw7t4rau7aARoVwglo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-07-67d7dc2aa1fe
From: Rakie Kim <rakie.kim@sk.com>
To: Gregory Price <gourry@gourry.net>
Cc: Rakie Kim <rakie.kim@sk.com>,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	joshua.hahnjy@gmail.com,
	dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com,
	kernel_team@skhynix.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 1/4] mm/mempolicy: Fix memory leaks in mempolicy_sysfs_init()
Date: Mon, 17 Mar 2025 17:24:00 +0900
Message-ID: <20250317082406.818-1-rakie.kim@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <Z9QyR3mHw76u_Sq9@gourry-fedora-PF4VCD3F>
References: 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGLMWRmVeSWpSXmKPExsXC9ZZnka7WnevpBg+OmVvMWb+GzWL61AuM
	Fj/vHme3WLXwGpvF8a3z2C3OzzrFYnF51xw2i3tr/rNarF6T4cDpsXPWXXaP7rbL7B4tR96y
	eize85LJY9OnSeweJ2b8ZvHY+dDS4/MmuQCOKC6blNSczLLUIn27BK6MV+0f2QqWcFWsP/eH
	rYHxL3sXIyeHhICJxLO7P1lg7IWznwPZHBxsAkoSx/bGgJgiAqoSbVfcuxi5OJgFHjJJ3Jox
	gRmkXFggRGLdrcVgY1iAat5PuAkW5xUwlni14TwrxEhNiYZL95hAbE4BM4m7l16A2UICPEA1
	+xkh6gUlTs58AnYCs4C8RPPW2cwgyyQErrNJdHVOYYMYJClxcMUNlgmM/LOQ9MxC0rOAkWkV
	o1BmXlluYmaOiV5GZV5mhV5yfu4mRmBoL6v9E72D8dOF4EOMAhyMSjy8BuuvpQuxJpYVV+Ye
	YpTgYFYS4WXZcT1diDclsbIqtSg/vqg0J7X4EKM0B4uSOK/Rt/IUIYH0xJLU7NTUgtQimCwT
	B6dUA+OSm99cS875mFwQYlrHwRA4W//fC2tV3q8zfJ+ELGtujv1i5TpNhblW9cj2L2ErYtKm
	xdtYfT3c9eYcJ+tPQdMfl8QU7I8dP79y1gnOy40dGmFLr9T6LluYWfbgbJ/B5cboGaVLihM7
	JE4eEvj/PHk9n2tKWc2UvPCsHP3PWrH37jYz/fWYcECJpTgj0VCLuag4EQDklfQQaQIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrALMWRmVeSWpSXmKPExsXCNUNNS1frzvV0g08PdC3mrF/DZjF96gVG
	i593j7NbfH72mtli1cJrbBbHt85jtzg89ySrxflZp1gsLu+aw2Zxb81/VotD156zWqxek2Hx
	e9sKNgdej52z7rJ7dLddZvdoOfKW1WPxnpdMHps+TWL3ODHjN4vHzoeWHt9ue3gsfvGByePz
	JrkArigum5TUnMyy1CJ9uwSujFftH9kKlnBVrD/3h62B8S97FyMnh4SAicTC2c9Zuhg5ONgE
	lCSO7Y0BMUUEVCXarrh3MXJxMAs8ZJK4NWMCM0i5sECIxLpbi8FaWYBq3k+4CRbnFTCWeLXh
	PCvESE2Jhkv3mEBsTgEzibuXXoDZQgI8QDX7GSHqBSVOznzCAmIzC8hLNG+dzTyBkWcWktQs
	JKkFjEyrGEUy88pyEzNzTPWKszMq8zIr9JLzczcxAsN5We2fiTsYv1x2P8QowMGoxMNrsP5a
	uhBrYllxZe4hRgkOZiURXpYd19OFeFMSK6tSi/Lji0pzUosPMUpzsCiJ83qFpyYICaQnlqRm
	p6YWpBbBZJk4OKUaGFc/C6494HwxtPZMhWbY1vJ5csYtB5pLIgWua00R/p66wMJO6Zblrse1
	00ItFKOmfclcZjvvu9jGt4fPFO2Xqa9IeeVz6X+15izWqxWKP4OOvVd+0WEzN3Sf++YTb5g5
	6hWkbLd9uKHzO29u0eWn98+13chyCl35ldUlaaf/Jqlwvf5JO7y7bZVYijMSDbWYi4oTAUP0
	dDFjAgAA
X-CFilter-Loop: Reflected

On Fri, 14 Mar 2025 09:42:31 -0400 Gregory Price <gourry@gourry.net> wrote:
> On Fri, Mar 14, 2025 at 10:55:00AM +0000, Jonathan Cameron wrote:
> > > 
> > > 1) allocate node_attrs and mempolicy_kobj up front and keep your
> > >    reordering, this lets us clean up allocations on failure before
> > >    kobject_init is called
> > > 
> > > 2) after this remove all the other code and just let
> > >    mempolicy_kobj_release clean up node_attrs
> > > 
> > > 3) Add a (%d) to the error message to differentiate failures
> > 
> > Given how unlikely (and noisy) a memory allocation failure is,
> > maybe just drop the printing at all in those paths - allowing
> > early returns.
> > 
> > The lifetime rules around node_attrs in here are making readability
> > poor. It is implicitly owned by the mempolicy_kobj, but no direct association.
> > Maybe just encapsulating the kobject in a structure that contains
> > this as a [] array at the end.  Then we end up with single allocation of
> > stuff that is effectively one thing.
> >
> 
> Even better recommendation, lets do as Jonathan suggests. <3
> 
> ~Gregory

Hi Gregory

I will revise the next version based on Jonathan's feedback.
Moreover, I'll separate this patch from the hotplug series and make it an
independent patch.

Rakie
