Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AEF37B3E1;
	Wed, 18 Mar 2026 08:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773824225; cv=none; b=SO5vtVrwFwaOTqATLqiLInMP3E4GZDzj8/DZzjSgp5oZMzty/IhNAbdGl6J74LBbvzkPkoXrsWPJ5G+WlrG/4WEdYQitNsV2CPT1Usj7ZwfB7aqgpgPBwMb0DSDnC9ukRIDpfQWlqRZXLC7x6TtUfL/Qn7yLufvlNfNnHHWHKbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773824225; c=relaxed/simple;
	bh=4uBSxFqIZq+o111sipBMJ6gRCXHJRWFp6ZRyxieDb3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M/slYSxZMrsM38ZX+ybyzGJVdQjKUKj/abXriNAIKldDqaI/Xbk2IZVWicCVI8/TgL74vg60djV1zhSB4qytCdbrzI7MqowjUWAUH4HJ1D31V2je05/9acK/R4AEQPT4eIe+oS79bDDp5LrIGFUdk66c4Cj21cPakAJkEl847uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lm2RDMUr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lm2RDMUr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76320C19421;
	Wed, 18 Mar 2026 08:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773824224;
	bh=4uBSxFqIZq+o111sipBMJ6gRCXHJRWFp6ZRyxieDb3c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lm2RDMUrdFpSVAbXyuXSorF+7mJosbpFXknmgF8KIqmP4uuYR1vNbGgq6594/I6ze
	 rhZRB5Ox+B86hABUg7I8OImw2cwaujyQop+xUSOdsvd/PxofMMsGO0bd1afnnyVB8m
	 z8rFlmxumPeDIzszxXN2yRtDu9NO1B7DlCNGup/NYrXUOD5zXMjYUuSylZeYoFgcFV
	 JdXCc6BqyX0QuCa9Iteb9dIfal0mnMDfc0nVJxBPuctCXoOLMkPrw+E6minXd+Pd0W
	 2C2GupBiAzTfGY+TJFsqdzQ8bwP3Z4xQhD0BGY4oIB5KNdj8m9QbCD630j4IaQPOgW
	 7qSbixRdOMSpg==
Date: Wed, 18 Mar 2026 10:56:58 +0200
From: Mike Rapoport <rppt@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 13/14] mm/sparse: move __section_mark_present() to
 internal.h
Message-ID: <abpo2qJq30cytRiB@kernel.org>
References: <20260317165652.99114-1-david@kernel.org>
 <20260317165652.99114-14-david@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317165652.99114-14-david@kernel.org>

On Tue, Mar 17, 2026 at 05:56:51PM +0100, David Hildenbrand (Arm) wrote:
> Let's prepare for moving memory hotplug handling from sparse.c to
> sparse-vmemmap.c by moving __section_mark_present() to internal.h.

Not strictly related to this patchset, we might want to start splitting
internal.h to sub-headers.
 
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  mm/internal.h | 9 +++++++++
>  mm/sparse.c   | 8 --------
>  2 files changed, 9 insertions(+), 8 deletions(-)

-- 
Sincerely yours,
Mike.
