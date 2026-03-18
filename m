Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A6D2882C5;
	Wed, 18 Mar 2026 19:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773863510; cv=none; b=ZuwNksa41Hh1W07mENovw/ayp8v3aVTa4LfBuLncAapw+JS8kfnMt2RApwW1YPWnh3thXIH2pjUIvpgqpNCcpGJu0oObhbsgiCJP5N07IhAkIv1ms31HYbaXsl+f2NOikJwvt40ahUY+sYrRCohz5x/oNBBkNgnv0YIRqv3jmlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773863510; c=relaxed/simple;
	bh=ATKXW7OYZJzy7zqUfVprOrox3H7IfEFDgiGL1lnrzXM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Ucy7O7BzsXrItTUJ5wMj67Z1Q4HSApLhdpXZ4g6JYu9/oHBCKR56+BBdCGCeiMvQpHoW5e9h2xmdUmAYBuI7mBijL3qugLLekPtHKKHRoB9iSwPeFQQPdyuOZiWJuBLRHpL5nAo9pssCllzjy0Bn04Pmf0KcO4Xm5/uqrozQyGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ietM5KZ9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ietM5KZ9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A1CBC19421;
	Wed, 18 Mar 2026 19:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1773863509;
	bh=ATKXW7OYZJzy7zqUfVprOrox3H7IfEFDgiGL1lnrzXM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ietM5KZ9EEyDu64shWSabErQkw8l25bLGuX1+35aLUN/KzDUl/GwZkYGCDy787GdD
	 hdCnAo7nhOfN1IPk6aTWa3jLlxODrJwGj5dJHUhJOtNpv5Vw6PXMgdBT1muFUz7UPu
	 x1w8fu7+/e5AovPtfduiSJfbfGEn/ifu2HG7n9zQ=
Date: Wed, 18 Mar 2026 12:51:48 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-cxl@vger.kernel.org, Oscar Salvador <osalvador@suse.de>, Axel
 Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei
 Xu <weixugc@google.com>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan
 <surenb@google.com>, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 00/14] mm: memory hot(un)plug and SPARSEMEM cleanups
Message-Id: <20260318125148.b137df94f3c3398cf453e6c1@linux-foundation.org>
In-Reply-To: <20260317165652.99114-1-david@kernel.org>
References: <20260317165652.99114-1-david@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Mar 2026 17:56:38 +0100 "David Hildenbrand (Arm)" <david@kernel.org> wrote:

> Some cleanups around memory hot(un)plug and SPARSEMEM. In essence,
> we can limit CONFIG_MEMORY_HOTPLUG to CONFIG_SPARSEMEM_VMEMMAP,
> remove some dead code, and move all the hotplug bits over to
> mm/sparse-vmemmap.c.
> 
> Some further/related cleanups around other unnecessary code
> (memory hole handling and complicated usemap allocation).
> 
> I have some further sparse.c cleanups lying around, and I'm planning
> on getting rid of bootmem_info.c entirely.

Added to mm-new, thanks.

Sashiko said a few things, as I expect you've seen:
https://sashiko.dev/#/patchset/20260317165652.99114-1-david%40kernel.org
