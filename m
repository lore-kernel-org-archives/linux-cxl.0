Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC0726A1A4;
	Mon, 27 Apr 2026 12:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777294304; cv=none; b=FSnYuAMN6GH1qTymYy/iJaSZDvR4ezHqg1a3MSJJrXIx6RGvuXL9Sl3BNsLuHw4kzeD5E5YWivdyz9IpK4b0B9YJ4E4fmp3abNS+UhrnOEGlMlOE4EIamXsGXHsF4WAUByLwPAp5OeqggCMSgvszpPncoCpMraX+HtbAs6jAyWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777294304; c=relaxed/simple;
	bh=Yupgt6WhksPtkoTuo9Rmvs+qfYOLtTWMBoIqgxRS2Ps=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FzNqgLiYiHWr9uFx0MeLF+KUP017iwPZsjnyzC2wXSeTw8WBANdXxVMfBM+USBAUo8esTHZZvlxIojaFSdN7lMZK5Qipc6fhFt+pmsbJqsD8WSeAZd4k3zD/8dCft6MLsvgr4oDG+6cxo7egOA3Fok9I0TWMVWeJ+uCpXCIrK3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p4XTPhc0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p4XTPhc0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3CBAC2BCB7;
	Mon, 27 Apr 2026 12:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777294303;
	bh=Yupgt6WhksPtkoTuo9Rmvs+qfYOLtTWMBoIqgxRS2Ps=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p4XTPhc0xls/70jA9TTIe57k2YH93QaLBlNiHNFaNRRTQn3hwWlFUqeWM0gZ2VG+l
	 g2W2mQbYKAiuWaFXWgJaFmyEDQ8cUo8shQhOyKe2ofiiR00vCUAULpUzEJW/OhQ5/w
	 +TZvVbW525EUglu1K+NIA1lDVOenT4t7JBVVMsfBD6D34ZHwYVQ+dtLiiBV7H5pHBS
	 mczQILKejPHJcjigDwTAdW+dB6lCzI3NsLYqlaT2DncCyN7BfyicuIUQJ9wL/D/BRD
	 5vPfkVXSs4hS6Dffeuk87UbaErMZc5xbcTUzGe/2tHg2PBjDaO+HxDEb0HBB+k5qtN
	 i/to7M1e6DKsw==
Date: Mon, 27 Apr 2026 13:51:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sungwoo Kim <iam@sung-woo.kim>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>, Vishal Verma
 <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
 <djbw@kernel.org>, Robert Richter <rrichter@amd.com>, Li Ming
 <ming.li@zohomail.com>, Gregory Price <gourry@gourry.net>, Ben Widawsky
 <bwidawsk@kernel.org>, Dave Tian <daveti@purdue.edu>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] cxl/region: Fix race conditions in cxl region
 unregistration.
Message-ID: <20260427135132.0fa47b24@jic23-huawei>
In-Reply-To: <20260427032010.916681-2-iam@sung-woo.kim>
References: <20260427032010.916681-2-iam@sung-woo.kim>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 26 Apr 2026 23:20:07 -0400
Sungwoo Kim <iam@sung-woo.kim> wrote:

> This version mainly addresses Dave's comments and meaningful issues reported by Sashiko AI[1].
> 
> Overview
> ========
> This patch series fixes race conditions in cxl region unregistration.
> 
> devm_release_action() should be called once, otherwise, it warns about
> the second call. However, the current implementation has a race condition
> that allows multiple calls to devm_release_action(). The details are in
> each patch.
> 
> To fix these, the first patch adds a new function that guarantees that
> devm_release_action() is called only once.
> Using this function, the second patch subsitutes the current use of 
> devm_release_action() in cxl region with the new function.
> 
> Change in v3
> ============
> Addressed Dave's comments:
> - Split and made this in a patch series.
> - Enhanced a commit log explaining why a workqueue is used in the first patch.
> - Added a context on how these issues were found and what impact was observed and how that effects a user in the second patch.
> Sashiko AI review fixes:
> - Fixed construct_region() as it also can race.
> - Used a driver's wq instead of system wq so unbinding can drain a work.
> 
> [1] https://sashiko.dev/#/patchset/20260422045637.3048249-2-iam%40sung-woo.kim
> 
> Earlier approach:
> v2: https://lore.kernel.org/linux-cxl/20260422045637.3048249-2-iam@sung-woo.kim/
> v1: https://lore.kernel.org/linux-cxl/20260308185958.2453707-2-iam@sung-woo.kim/

Looks fine to me - I'm not particular keen on delayed releasing as it
may end up with unordered tear down but I don't have a better idea.

Reviewed-by: Jonathan Cameron <jic23@kernel.org>


> 
> Sungwoo Kim (2):
>   cxl/region: serialize devm action removal via scheduled work
>   cxl/region: Fix a race bug in delete_region_store()
> 
>  drivers/cxl/core/port.c   |  6 +++++
>  drivers/cxl/core/region.c | 47 ++++++++++++++++++++++++++++++++++-----
>  drivers/cxl/cxl.h         |  9 ++++++++
>  3 files changed, 57 insertions(+), 5 deletions(-)
> 

