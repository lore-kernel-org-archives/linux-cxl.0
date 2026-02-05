Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4845133B6E3;
	Thu,  5 Feb 2026 22:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770332324; cv=none; b=ukyTwayKkJKOFbbBsmGjueiEDtwRQjPmjNLY1TW3wa3CbUSnz8C4tH4dGHvCgbYyaxyv9VlEYAq2P/8E2RwUXHq2EQPL2mky50QvayicYLSh4FxMJDwX1i/vJFQZy5IaMTgy1tO5EcSvv81d4XESt5B8s9SBxvrrnc46urc2IjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770332324; c=relaxed/simple;
	bh=YcdYFHMV89lA40rLxsDkCLWE5HLfI7sYULz4cHVw3dM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=h6L+9oGuGBz3b16fP4B/rCQrsfsJPMThtfKjfKvwsqhamWNsg8Btn5Wa8AC8VIZrc1qMvJEVlnQb5rHc3T9leduJM8NBg1aaqkXrqJOgFiLihRyoe6cPcDoUmeTeOvE7hzSAsFiXlwm2qt5kPgF3gbrngy1sSZ0qqusCDKppvo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=c0aWC5+L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="c0aWC5+L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63FF7C19423;
	Thu,  5 Feb 2026 22:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1770332323;
	bh=YcdYFHMV89lA40rLxsDkCLWE5HLfI7sYULz4cHVw3dM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=c0aWC5+L57nNvj/7wYjE3r/jAClMP5119gbGWg1Ud5StPtmLAOOLTjWAHdWxbdsOE
	 RNa2XJNFGH8kF7/FRvT6UgCrqvxJMPkvdaRW751gVIHroXiZyq9tt39NHxyKVaIuO2
	 ejuqUNvWvImkGDwb6SoRV8QG/6VyFD7VE9x5aLck=
Date: Thu, 5 Feb 2026 14:58:42 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Cui Chao <cuichao1753@phytium.com.cn>
Cc: Gregory Price <gourry@gourry.net>, dan.j.williams@intel.com, Jonathan
 Cameron <Jonathan.Cameron@huawei.com>, Mike Rapoport <rppt@kernel.org>,
 Wang Yinfeng <wangyinfeng@phytium.com.cn>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 1/1] mm: numa_memblks: Identify the accurate NUMA ID
 of CFMW
Message-Id: <20260205145842.efb90572a902ae4c481e6ef6@linux-foundation.org>
In-Reply-To: <a90bc6f2-105c-4ffc-99d9-4fa5eaa79c45@phytium.com.cn>
References: <20260106031042.1606729-1-cuichao1753@phytium.com.cn>
	<20260106031042.1606729-2-cuichao1753@phytium.com.cn>
	<20260108094812.8757ce3ad8370668eaafb29c@linux-foundation.org>
	<9132054c-3017-4af0-84e0-e4359b0794a6@phytium.com.cn>
	<20260115101858.85fd7b8e837c1c92a4fdc5f0@linux-foundation.org>
	<696944eca1837_34d2a10056@dwillia2-mobl4.notmuch>
	<2d1e23ad-7ec1-483b-88b3-70ce19b69106@phytium.com.cn>
	<aXOl9CN_66HywIjZ@gourry-fedora-PF4VCD3F>
	<a90bc6f2-105c-4ffc-99d9-4fa5eaa79c45@phytium.com.cn>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Jan 2026 17:06:52 +0800 Cui Chao <cuichao1753@phytium.com.cn> wrote:

> > All that said, this does look harmless, and seems reasonable - but the
> > changelog should reflect what the hardware is doing above.
> This issue was discovered on the QEMU platform. I need to apologize for 
> my earlier imprecise statement (claiming it was hardware instead of 
> QEMU). My core point at the time was to emphasize that this is a problem 
> in the general code path when facing this scenario, not a QEMU-specific 
> emulation issue, and therefore it could theoretically affect real 
> hardware as well. I apologize for any confusion this may have caused.

This patch doesn't sounds very urgent.  Perhaps we should do a v3 with
updated changelog and handle that in the next -rc cycle?
