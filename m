Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320523112A9;
	Wed, 17 Sep 2025 23:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758150406; cv=none; b=bedlTJxgprH2VhrkjQJN/Id1yGH/NgXmTLZWs7KOFEiuZoCgPExiXtxHCtQxidJrYFrSvQ6YLf7xl8vcbJT5TZSj0eCB01MCyfiv6BgNF91o93A0qZvPiCmGUO7we65dvBFafq7BCdnHQ0FkP5VKHAi+1rMCxQO6twajnUm/TBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758150406; c=relaxed/simple;
	bh=fFgIEUM6/YXWdWd9K7ZM8JDuqHdBvd2jvx9ZolQ4SA0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=TpWNhSSN64p6jIJM0UPoN3fLvqzd3WtnCJq6IT0PvQ88dCpKfVhYexryerAu59Z9Hi8L0NHHeULiMSrnCUu360dh13+R+uw6QvNEejT+lQeamyDCYMu4By9gx/LBzbpc5kFutaaHwcfGhzlrGr4cg6yUcNoVK6UclhYw4pzAqD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Oem1V0RK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Oem1V0RK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4525BC4CEF9;
	Wed, 17 Sep 2025 23:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1758150405;
	bh=fFgIEUM6/YXWdWd9K7ZM8JDuqHdBvd2jvx9ZolQ4SA0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Oem1V0RKVMTk3xpu00Dj4Dyxx4SZn8UpCObFSFQKdLEeX46XlDj2Eq3R6skovdzEK
	 s2nLf+wpK97XPRcd6RjiwwGy7tjYHx5dyQQef2hqZohA9Tj8W0Ik7feMxCW8nkb0Ee
	 sOJzKpQkZY+P6dvQ7QPU8A+Oe3UsHYeM2EfGbWPg=
Date: Wed, 17 Sep 2025 16:06:44 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: <peterz@infradead.org>, <linux-kernel@vger.kernel.org>,
 <linux-cxl@vger.kernel.org>, "Nathan Chancellor" <nathan@kernel.org>, Linus
 Torvalds <torvalds@linux-foundation.org>, Dave Jiang
 <dave.jiang@intel.com>, "David Lechner" <dlechner@baylibre.com>, Jonathan
 Cameron <jonathan.cameron@huawei.com>, Andy Shevchenko
 <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v2] cleanup: Fix "unused function" warnings with
 conditional guards
Message-Id: <20250917160644.6f85ca40b1e352fa117dabf9@linux-foundation.org>
In-Reply-To: <20250904225010.1804783-1-dan.j.williams@intel.com>
References: <20250904225010.1804783-1-dan.j.williams@intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Sep 2025 15:50:10 -0700 Dan Williams <dan.j.williams@intel.com> wrote:

> While the warning could simply be moved to W=2 [1], there is some small
> value, and not much cost to fixing it.
> 
> The issue, Andy reports that the "lock_timer" scheme in
> kernel/time/posix-timers.c, with its custom usage of
> DEFINE_CLASS_IS_COND_GUARD(), results in:
> 
> kernel/time/posix-timers.c:89:1: error: unused function 'class_lock_timer_lock_err' [-Werror,-Wunused-function]
>    89 | DEFINE_CLASS_IS_COND_GUARD(lock_timer);
> 
> ...with a clang W=1 build. This warning has some value because it can catch
> when a conditional guard is defined, but not evaluated by a conditional
> acquisition helper like scoped_cond_guard() or ACQUIRE().
> 
> Andy also reports that plain DEFINE_GUARD() also encounters this warning:
> 
> drivers/pwm/core.c:54:1: error: unused function 'class_pwmchip_lock_err' [-Werror,-Wunused-function]
>    54 | DEFINE_GUARD(pwmchip, struct pwm_chip *, pwmchip_lock(_T), pwmchip_unlock(_T))
> 
> ...which *is* a false positive.
> 
> Fix those 2 issues by teaching scoped_cond_guard() to check for error
> values, and otherwise teach the DEFINE_GUARD() path to mark the conditional
> helpers as __maybe_unused.

Warning about unused static inlines in .c files is just annoying.  If
the function is unused in all possible configs (man GREP(1)) then OK. 
Otherwise, let it be.

> Alternatively just merge the suggestion in [1], and call it a day.
> 
> Link: http://lore.kernel.org/20250813152142.GP4067720@noisy.programming.kicks-ass.net [1]

lgtm, unless we think this (your) patch improves the code for other reasons?


