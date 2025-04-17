Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F82222564;
	Thu, 17 Apr 2025 23:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744932711; cv=none; b=o21Ho89Hgj2Sz6qY9NNq7sK1uj0sX4XxZLNW1T+WfsN5dR8S8ZAkSgbcblI/U4JFQR9PPaAX6PdIutz8qtmEuiFBsy0XZ9FGKAZRmU2Ot2oMvYNTn7oapNjUyLUawK9GZRbi7Qh0HFq0Cy1hiHZbwOFfzruU/MILa1SyvOGMS/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744932711; c=relaxed/simple;
	bh=voDmLeRkXhnBh06zKO+SDWJ4p+ieK+pSNyDhd0/wngs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=EDwSoBFFsD+qmL8O8SJPcMkfu4+ZSFcogIenNo4P/RVTHxBQjFTibGP5YwxyVYswGxO4HSvX7FyTXWcUnsQvccYyOw5qhjPnfig7SY4lpFumqvthhDLCzne5Y/KrTw+NBO7oWeUwPs7Rm/QWY1sHWcS1ZSOdHp2nM8nKgXijFvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=yk3Nt81H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="yk3Nt81H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CB59C4CEE4;
	Thu, 17 Apr 2025 23:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1744932710;
	bh=voDmLeRkXhnBh06zKO+SDWJ4p+ieK+pSNyDhd0/wngs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=yk3Nt81HyWt8AB2Z4Zy0KzCNdCaAaL+E4nyoP35V0A8XO5tprE9Aj0S6sKaTHdo6U
	 RFNu9nPpT9lIEJFybkOlWDTRVvoRjfNZgieypSBpLEkmXWTLm76bTbPxbaRGOmtNjM
	 YtHmij0mEPrRJ7/ELuHB222LXFbe6X+NZTwGhLno=
Date: Thu, 17 Apr 2025 16:31:49 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Rakie Kim <rakie.kim@sk.com>, <gourry@gourry.net>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
 <joshua.hahnjy@gmail.com>, <ying.huang@linux.alibaba.com>,
 <david@redhat.com>, <Jonathan.Cameron@huawei.com>, <osalvador@suse.de>,
 <kernel_team@skhynix.com>, <honggyu.kim@sk.com>, <yunjeong.mun@sk.com>
Subject: Re: [PATCH v9 0/3] Enhance sysfs handling for memory hotplug in
 weighted interleave
Message-Id: <20250417163149.c918137ef2f9742daf79083f@linux-foundation.org>
In-Reply-To: <6801839a2481_71fe29462@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250417072839.711-1-rakie.kim@sk.com>
	<20250417081106.732-1-rakie.kim@sk.com>
	<20250417153505.c921f75a035089906bb38fe6@linux-foundation.org>
	<6801839a2481_71fe29462@dwillia2-xfh.jf.intel.com.notmuch>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Apr 2025 15:41:30 -0700 Dan Williams <dan.j.williams@intel.com> wrote:

> Andrew Morton wrote:
> > On Thu, 17 Apr 2025 17:10:08 +0900 Rakie Kim <rakie.kim@sk.com> wrote:
> > 
> > > I sincerely apologize for causing repeated inconvenience. The series of
> > > patches version v8 that was merged into -mm, mm-new today needs
> > > additional corrections.
> > > Link: https://lore.kernel.org/all/6800742de6315_130fd2949c@dwillia2-mobl3.amr.corp.intel.com.notmuch/
> > > Therefore, I have updated a new version v9, in which the problems have
> > > been addressed.
> > 
> > No probs, this is why mm.git workflow (mm-new -> mm-unstable ->
> > mm-stable -> mainline) operates as it does - to easily permit revisions
> > and replacements as patches move towards their final state.
> > 
> > Please note that I added a cc:stable to your [1/N] patch - sysfs leaks
> > should be fixed in earlier kernels.  I considered this to be low
> > priority - if it's higher priority than this patch should best have
> > been separated from the series, so it can take a different merge path
> > from the other patches.  
> 
> The risk of leak is low because it only appears to trigger if setup
> fails. Setup only fails due to -ENOMEM which is unlikely to happen from
> a late_initcall() when memory pressure is low.

Oh, OK, thanks.  I added the above paragraph to the changelog and
removed the cc:stable.

Generally, we assume that -ENOMEM doesn't happen in __init code.  If it
does, the kernel is totally messed up anyway)
