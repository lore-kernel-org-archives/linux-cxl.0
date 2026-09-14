Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341EB38DC7F;
	Mon, 14 Sep 2026 09:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789379154; cv=none; b=JUJBLmGq7nhS9qtgmrnT7bOtDTP3Y0SHMiI/3wgIWpzSJWzVRTa6erEp6d0e2pZD/2iP8FWizB6KJVUO1S2DxKFyL+0TxKnJ66CPbSjiAeXF5oW3wiYaaY/Ge3bZ9M+cClFNMItbVmR26QKeML2MMNFtFQM3OykHbpvSUqwF5+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789379154; c=relaxed/simple;
	bh=cufKDvtbHvNCr7tUsHDxSE4aFj99msmSqEwqsrwv/RI=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=iEtovbOy7aOCYKsG+bNuD5Fzd6kM9aZWvGqhONa4GU1z18RIYkptBIwjc53VGcRKSdZYWMQPSdyOPfDEZoS0YX17Hkga+mD83QK7qny4l99ByQDezZpg+402jN6ZmL6LnGEv28qXtqL1lZhVBDOGqKxJNJlzq1yg1924gxNJiWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iGjqTOEx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iGjqTOEx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C2331F00893;
	Mon, 14 Sep 2026 09:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789379152;
	bh=zYFRtPItrR9BesC1c0SvNo0V7skAjyhampHOopOgb+E=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=iGjqTOExfOZa0QvKhfJUvbiv67FIG3c89Rj0rsUQxP5OgPpsgR006zq3WD2eeCfhV
	 xtycj63iozwTSTQ0srz1rAj0DzmLvTd1HsDnAM571u0uWAqqFa6GJ7U1ICrCTviShy
	 VlhuIhZbvEGvJPOqEAe6kgvO3E5SgKegqG+qAfIANENtQYb2h6+7+nbx8oJuwQc2ha
	 cT0M5h74snkyBiarWehir1s+f7q2TOzSFVyhkloVzYAwWHDSmStDrREmV4BgU/F8iK
	 QnhfITXbe5BRsMHiARKZDHBWD2Z4CS9tM/WILqW2KlADJsEMt7AqrbpsouYlFiZry7
	 RdDKOScVJI71g==
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 00/12] mm/sparse: remove SECTION_MARKED_PRESENT and
 further cleanups
From: Mike Rapoport <rppt@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Barry Song <baohua@kernel.org>, 
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
 Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Brendan Jackman <brendan.jackman@linux.dev>, 
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
 Oscar Salvador <osalvador@suse.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Jan Kiszka <jan.kiszka@siemens.com>, Kieran Bingham <kbingham@kernel.org>, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-cxl@vger.kernel.org, 
 driver-core@lists.linux.dev, linux-fsdevel@vger.kernel.org
In-Reply-To: <20260909-b4-sparsemem_cleanups-v1-0-008fc8d579fe@kernel.org>
References: <20260909-b4-sparsemem_cleanups-v1-0-008fc8d579fe@kernel.org>
Date: Mon, 14 Sep 2026 12:45:42 +0300
Message-Id: <178937914266.4188640.7965323974267420342.b4-review@b4>
X-Mailer: b4 0.17-dev

On Wed, 09 Sep 2026 15:32:53 +0200, David Hildenbrand (Arm) <david@kernel.org> wrote:
> mm/sparse: remove SECTION_MARKED_PRESENT and further cleanups
> 
> SECTION_MARKED_PRESENT is really only needed during boot, where we
> can instead just rely on SECTION_IS_EARLY_BIT by setting that flag
> earlier.
> 
> Some preparations for doing that conversion and some cleanups in the same
> (sparse) area.
> 
> [...]

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

-- 
Sincerely yours,
Mike.

