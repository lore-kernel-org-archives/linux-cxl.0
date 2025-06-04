Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74D214286
	for <linux-cxl@vger.kernel.org>; Wed,  4 Jun 2025 06:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749018683; cv=none; b=HMPCRM1AzWoY1Tg+5hdBwAWQfs7sf0E83C+ITR/W+RG0H9eGdxU24ALD6iYNKksWO3DeX3nwIxiAgwMxWse3necFAUagAl0Ks46nELv3RkN2m/5rBFT0LkdujS2gUezr5gbO9d6ZkDHA1oSRoo+xAOqRTycOwEv4ohIrJjfKqOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749018683; c=relaxed/simple;
	bh=9dqLWMyjkeXuSgWFSQJTjqgWWL/Rktm7h4Ajl4Nl29A=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=B34HNi1rcx+5TWQOzwjyKwZN/rGBY5nXtyeFLiPD3ipCJhQoDoDqgN6yRrPxM7VZ0BOY/oHyfCHcYzlSYLyrdsiwZFI77GgmsY89D0szBvXAk6DL7xqXHhkLP3G2bNPlh3ylDmkbMKVTdW/FdhjdQiQe9W98xQ9aZ2o/Dri2VpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=d8N1KCNg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="d8N1KCNg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1359C4CEE7;
	Wed,  4 Jun 2025 06:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1749018683;
	bh=9dqLWMyjkeXuSgWFSQJTjqgWWL/Rktm7h4Ajl4Nl29A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=d8N1KCNgZrVNM07/Ekv1SLOlq9XHGFIdl1Ngc5VEE4T5hI4R47+YspJsaLKh4pMf1
	 Hmkgm7gV8z8D7YHigVqpHhG0VnRgPKESYDXoC/94lhHTBCEaD8oViCZwLHzahrHi3I
	 Mb0Kc+wcNxCZ8rrWU0EEHCIzRVHN5xYfLV/3R0OI=
Date: Tue, 3 Jun 2025 23:31:22 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: Dan Williams <dan.j.williams@intel.com>, "linux-cxl@vger.kernel.org"
 <linux-cxl@vger.kernel.org>, "Jonathan.Cameron@huawei.com"
 <Jonathan.Cameron@huawei.com>, "andriy.shevchenko@linux.intel.com"
 <andriy.shevchenko@linux.intel.com>, "mika.westerberg@linux.intel.com"
 <mika.westerberg@linux.intel.com>, "ilpo.jarvinen@linux.intel.com"
 <ilpo.jarvinen@linux.intel.com>, "bhelgaas@google.com"
 <bhelgaas@google.com>, "huang.ying.caritas@gmail.com"
 <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH] resource: Fix resource leak in get_free_mem_region()
Message-Id: <20250603233122.ec3fa71427b72b958ab346e4@linux-foundation.org>
In-Reply-To: <368ccec8-2867-499e-a800-07e18ba8e5ee@fujitsu.com>
References: <174114125011.1367354.2670882864492961789.stgit@dwillia2-xfh.jf.intel.com>
	<368ccec8-2867-499e-a800-07e18ba8e5ee@fujitsu.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 4 Jun 2025 06:06:48 +0000 "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com> wrote:

> Hello,
> 
> Ping, I hit his leak again in v6.15+
> ﻿
> I'm surprised this patch has not been  merged into upstream.

I'm struggling because I'm not subscribed to linux-cxl (please cc
linux-kernel on patches) but it appears that Dan's alternative patch is
due for an update (thanks to comments from Andy and Jonathan) and that
appears to have not happened.

So Dan, can you please take a look, see if we can get this finished?
