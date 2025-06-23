Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5731A23ABB2;
	Mon, 23 Jun 2025 10:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750673150; cv=none; b=e43JJ00AFfYcz4SRY0WJU/FX69ucyXd6xgOu2wKN2OPYiaZvOWgJX8GlQgs5E4HcmEwccFHTxEjPL0ZTE9l6uYK5+r5ze7ei9c5mO0SYW5psz9E1iX8G7n70jNDVeiky4ykMqOjXsfkv9FIaGu/bBUCstc1rtIleUy6+cCR67lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750673150; c=relaxed/simple;
	bh=iPNitE4nbuEDiKbUBmKidOk6gTXChF4de7gB/oOsN0g=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WjuQsvZOOB5ctQFige7MzI5Zo4/cBmQTBPNjze3JQkFEjzeYsv14oDeZ4jMOJNhS8QchZMnyLvCs5sWGq1SGCUbvJqhoDOtqG31JFt+p9mUH0MXZsfWzqWKX7omYTkpbYaHygyBGfpG+UpR6yJNlesIJTrrEaGV+adudRts3hn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bQk9Z1cWTz6L5j9;
	Mon, 23 Jun 2025 18:00:50 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 0625E1402EA;
	Mon, 23 Jun 2025 18:05:46 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 23 Jun
 2025 12:05:45 +0200
Date: Mon, 23 Jun 2025 11:05:44 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, "Linus
 Torvalds" <torvalds@linux-foundation.org>, David Lechner
	<dlechner@baylibre.com>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>
Subject: Re: [PATCH v2 1/8] cleanup: Introduce ACQUIRE() and ACQUIRE_ERR()
 for conditional locks
Message-ID: <20250623110544.0000753d@huawei.com>
In-Reply-To: <20250619050416.782871-2-dan.j.williams@intel.com>
References: <20250619050416.782871-1-dan.j.williams@intel.com>
	<20250619050416.782871-2-dan.j.williams@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 18 Jun 2025 22:04:09 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> From: Peter Zijlstra <peterz@infradead.org>
> 
> scoped_cond_guard(), automatic cleanup for conditional locks, has a couple
> pain points:
> 
> * It causes existing straight-line code to be re-indented into a new
>   bracketed scope. While this can be mitigated by a new helper function
>   to contain the scope, that is not always a comfortable conversion.
> 
> * The return code from the conditional lock is tossed in favor of a scheme
>   to pass a 'return err;' statement to the macro.
> 
> Other attempts to clean this up, to behave more like guard() [1], got hung
> up trying to both establish and evaluate the conditional lock in one
> statement.
> 
> ACQUIRE() solves this by reflecting the result of the condition in the
> automatic variable established by the lock CLASS(). The result is
> separately retrieved with the ACQUIRE_ERR() helper, effectively a PTR_ERR()
> operation.
> 
> Link: http://lore.kernel.org/all/Z1LBnX9TpZLR5Dkf@gmail.com [1]
> Link: http://patch.msgid.link/20250512105026.GP4439@noisy.programming.kicks-ass.net
> Link: http://patch.msgid.link/20250512185817.GA1808@noisy.programming.kicks-ass.net
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: David Lechner <dlechner@baylibre.com>
> Cc: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
> Not-yet-signed-off-by: Peter Zijlstra <peterz@infradead.org>
> [djbw: wrap Peter's proposal with changelog and comments]
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
This looks like a nice solution.  One trivial style thing inline.

> ---
>  include/linux/cleanup.h | 77 ++++++++++++++++++++++++++++++++++-------
>  include/linux/mutex.h   |  2 +-
>  include/linux/rwsem.h   |  2 +-
>  3 files changed, 67 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
> index 7093e1d08af0..1e1eb35cc225 100644
> --- a/include/linux/cleanup.h
> +++ b/include/linux/cleanup.h
> +#define __GUARD_IS_ERR(_ptr) \
> +	({ unsigned long _rc = (__force unsigned long)(_ptr); \
> +	   unlikely((_rc-1) >= -MAX_ERRNO-1); })

Trivial but I'd have added spaces to make this
	   unlikely((_rc - 1) >= -MAX_ERRNO - 1); })

> +
>  #define __DEFINE_GUARD_LOCK_PTR(_name, _exp) \
>  	static inline void * class_##_name##_lock_ptr(class_##_name##_t *_T) \
> -	{ return (void *)(__force unsigned long)*(_exp); }
> +	{ void *_ptr = (void *)(__force unsigned long)*(_exp); \
> +	  if (IS_ERR(_ptr)) { _ptr = NULL; } return _ptr; } \
> +	static inline int class_##_name##_lock_err(class_##_name##_t *_T) \
> +	{ long _rc = (__force unsigned long)*(_exp); \
> +	  if (!_rc) { _rc = -EBUSY; } if (!IS_ERR_VALUE(_rc)) { _rc = 0; } \
> +	  return _rc; }
>  


