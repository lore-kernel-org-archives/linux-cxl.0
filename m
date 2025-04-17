Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA3E13E41A;
	Thu, 17 Apr 2025 22:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744929308; cv=none; b=LgYXoY5HtxJEM3W984y6jCgSSxHbqY03w7T6N5xbvc+UngVL8L8tF2dXmmUKpAvlONzQwpx+2Q10iNKqTSKPakLW1uHNmv64K+CO+/GmJPsu0Yunhx02pxMm1IoDJOaX7LZP/Yw/ef8J1lzoSchXQWOOkupRA4A50RCI64nGgaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744929308; c=relaxed/simple;
	bh=BH/0yVVQnY8eXC83k0RQMvAr/eOdr7NHFC8RnB6g4eU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=F0ERVC/69NETLoEQzSTsBeq9FI1A/78GS0g2o1687I6/7L1OGKUJ3DKSTOjiXUgaU6MsPTJvSFzqGKTOHJE8Ii5g184xDwlpxoG207JBTo3Y3fMYcXMK61q9rdUUkuS6sCkUF3y84X/0YqWlRL7xTMrHSOuwmdBuqUUWmoL2zQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fqnIqI8k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fqnIqI8k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEFDAC4CEE4;
	Thu, 17 Apr 2025 22:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1744929307;
	bh=BH/0yVVQnY8eXC83k0RQMvAr/eOdr7NHFC8RnB6g4eU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fqnIqI8kTlEhouCoc0tG9GEbRO08T1sM26RKxnLmA4tK7l0qtV/l7STjnrsIfp5Ez
	 HG7ap6B/5emuunKy1bkgWKyKj/KVC8IH8vUgRIgb2DlD+efty1sN4Gy3o7vNXN+H6m
	 CF+/YUklg7J2jUaazp+MuyJQw22SgznHUeTWnJnc=
Date: Thu, 17 Apr 2025 15:35:05 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Rakie Kim <rakie.kim@sk.com>
Cc: gourry@gourry.net, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org, joshua.hahnjy@gmail.com,
 dan.j.williams@intel.com, ying.huang@linux.alibaba.com, david@redhat.com,
 Jonathan.Cameron@huawei.com, osalvador@suse.de, kernel_team@skhynix.com,
 honggyu.kim@sk.com, yunjeong.mun@sk.com
Subject: Re: [PATCH v9 0/3] Enhance sysfs handling for memory hotplug in
 weighted interleave
Message-Id: <20250417153505.c921f75a035089906bb38fe6@linux-foundation.org>
In-Reply-To: <20250417081106.732-1-rakie.kim@sk.com>
References: <20250417072839.711-1-rakie.kim@sk.com>
	<20250417081106.732-1-rakie.kim@sk.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Apr 2025 17:10:08 +0900 Rakie Kim <rakie.kim@sk.com> wrote:

> I sincerely apologize for causing repeated inconvenience. The series of
> patches version v8 that was merged into -mm, mm-new today needs
> additional corrections.
> Link: https://lore.kernel.org/all/6800742de6315_130fd2949c@dwillia2-mobl3.amr.corp.intel.com.notmuch/
> Therefore, I have updated a new version v9, in which the problems have
> been addressed.

No probs, this is why mm.git workflow (mm-new -> mm-unstable ->
mm-stable -> mainline) operates as it does - to easily permit revisions
and replacements as patches move towards their final state.

Please note that I added a cc:stable to your [1/N] patch - sysfs leaks
should be fixed in earlier kernels.  I considered this to be low
priority - if it's higher priority than this patch should best have
been separated from the series, so it can take a different merge path
from the other patches.  
