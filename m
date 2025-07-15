Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42DF248F75;
	Tue, 15 Jul 2025 15:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752593687; cv=none; b=Rtau4ZIPSY0NRAVnk2VfiIgA3OlD466dIigx/bUqfD0NWG9uh5zrh1k3epsPosYxGi2sYZ7BJ8NebK3FhV0Gr+i2wvWKnSg283FMQtYjsW9NJXovhmh2u5SQAMyJTT2Ne9M0WN+WgnAOg8TWF9zPQyv2uETHctu3xbOAQ/1l0aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752593687; c=relaxed/simple;
	bh=2X8TzFfvdle+cJIOGk4vEK4pIbmvHC3qFFVkkcuBD3w=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VV0Ptxr1OvfMQDMb0mmxuCq4DwqMLKxjl1bdKtQh4QA3Plbq4Dwk9wOokUj40gzmTidlXc4YUfA+94V1Xr1EJAsWStmZyfbJ1gOojQTA69Ejyj/yeBZOsHgxs28Ml7ltwb7f6nAoLK7tbgEWlE2GNBBwtI9/8AGNRI97JJktkLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bhNWL31bZz6L58d;
	Tue, 15 Jul 2025 23:33:34 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 7AC181402ED;
	Tue, 15 Jul 2025 23:34:42 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 15 Jul
 2025 17:34:42 +0200
Date: Tue, 15 Jul 2025 16:34:40 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Linus
 Torvalds <torvalds@linux-foundation.org>, David Lechner
	<dlechner@baylibre.com>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>
Subject: Re: [PATCH v3 1/8] cleanup: Introduce ACQUIRE() and ACQUIRE_ERR()
 for conditional locks
Message-ID: <20250715163440.00007849@huawei.com>
In-Reply-To: <20250711234932.671292-2-dan.j.williams@intel.com>
References: <20250711234932.671292-1-dan.j.williams@intel.com>
	<20250711234932.671292-2-dan.j.williams@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 11 Jul 2025 16:49:25 -0700
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
> Cc: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
> Signed-off-by: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> [djbw: wrap Peter's proposal with changelog and comments]
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

LGTM and is definitely an improvement on all previous attempts to solve this.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
