Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FC436F405;
	Mon, 21 Sep 2026 22:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790031186; cv=none; b=UL+frGKmU6NLuhR1SXVB4h83d5ZNnJjcKIwaYzf8z1alL212CQDc2aPLOcxYScY96cuzrif95WcthQbZPOzXpdxxLbUJ36FcO1liiHtIweqFxaJzw0gcnl0Yt8PbXTvMfeNCAPSMNWKAu1jFIm+vDd5PHv64XSVtHKg2VRni8JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790031186; c=relaxed/simple;
	bh=Mf5GJife6VZoabI9QINny6v+W6UXRMvScQI+ADs8ylE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=AwRVI+2654UYwiRvGhkWSJWzBY1ril1we9l5HCw1DuHLt/JdljCCgwRO9rbeGxT7LCicdUSsx8iN75Wqrm7sg9Gllh7WbjOtAuNowEWyRf4JPf7tAfZRW0O6nSwlC/zsS3CENKQhBj9OD0B4hfgZxRNwJjAYZW+4eqnCBJweB4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YzqYCbK6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YzqYCbK6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A90921F00893;
	Mon, 21 Sep 2026 22:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1790031184;
	bh=vr/gx0Gk1vpjpHWM5sT+D++JQRExEkJQGlPWeyGVKCo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YzqYCbK6VIEv4Im4C6xgjIzbiK246j5gGNTbeA/gxJmKzhCvtWP2kvF+17L0uRaHe
	 9vPeZg02uN09f8r+AS+I/MvdRcZkvexqG2w4jVdQpqn3c32VGwxf7ayQ15zilHy7G1
	 chR39CDncH1ayD3EMiA0ehzS0yV4nyaQlejUFI2o=
Date: Mon, 21 Sep 2026 15:53:03 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett"
 <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
 <mhocko@suse.com>, Kairui Song <kasong@tencent.com>, Qi Zheng
 <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, Barry Song
 <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie
 <yuanchu@google.com>, Wei Xu <weixugc@google.com>, Baoquan He
 <baoquan.he@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Brendan Jackman <brendan.jackman@linux.dev>, Johannes Weiner
 <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, Jan Kiszka
 <jan.kiszka@siemens.com>, Kieran Bingham <kbingham@kernel.org>, Oscar
 Salvador <osalvador@suse.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-cxl@vger.kernel.org, driver-core@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, Seongjun Hong <hsj0512@snu.ac.kr>
Subject: Re: [PATCH v2 00/13] mm/sparse: remove SECTION_MARKED_PRESENT and
 further cleanups
Message-Id: <20260921155303.0ac97f17e4bda6140079dc9c@linux-foundation.org>
In-Reply-To: <20260921-b4-sparsemem_cleanups-v2-0-54d81d65e125@kernel.org>
References: <20260921-b4-sparsemem_cleanups-v2-0-54d81d65e125@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Sep 2026 21:58:52 +0200 "David Hildenbrand (Arm)" <david@kernel.org> wrote:

> SECTION_MARKED_PRESENT is really only needed during boot, where we
> can instead just rely on SECTION_IS_EARLY_BIT by setting that flag
> earlier.
> 
> Some preparations for doing that conversion and some cleanups in the same
> (sparse) area.

Added to mm-new, thanks.


