Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5552361DD1;
	Fri, 27 Mar 2026 10:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774605650; cv=none; b=Pg+8cnp2OIRfvTdeWvHc7zwuc2ucI6p5Rqr5RmuN3FyvwKQu6CXyoeZyH2xioT0ItsFw5Ftp4bkZCMufrLxEAiAHwt+DqNzI4tMAL6TMn5vdJ9U/VEivdoZWZru9QqfbkMMmHN84hHxmJ8sO6sBq6406yZfre9xiHKZUSU71nbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774605650; c=relaxed/simple;
	bh=o+56grdb7ac39ib9dNl2LtTcrr4nD402U9sEfODjWW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tp6Dvnjm5+jKHUQvgQUg71bRu08TkcwN+cIqK9A3xMTDpnCmZPZGpc8rRe05Ld2ZLPgeRwjroQp8wdKiPKiW9O6RdtM4zyv91HhtflHDkrlZiCzMh9PfNQ5q9uMn9c9Tg+dIwyCbbybQ/LiwGSkWULy4kBlcq5uhxMP+oDkIUhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SHEWFF4D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SHEWFF4D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A16E5C2BC87;
	Fri, 27 Mar 2026 10:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774605650;
	bh=o+56grdb7ac39ib9dNl2LtTcrr4nD402U9sEfODjWW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SHEWFF4DGzAUakw0NqO9GKKRmb+hHKJcxiJIGhVRQzTY7M4bta6YERD/kiroO6Pr0
	 omcNn9ffxRkOkUo0LJIAMQRgmJe+tVO5KlaHYsQ8WlBLduUHKd4UoX17+E35lrRjH8
	 4qcl0+8DqCnKOykRq5jTA8ShIhz+WY+NDIPJlOco+S4BovRxMNxlLCKMlCGMNmOACh
	 8pZIEJp6s8rymij3r5asHb0aS/0MVlC66+pBoMb2rz+1LCeaB9OJfPYIRzVWHZ6cT1
	 xYm5M+WsWB0+fDtrmgfFja5SZncbFWzRtKUDXiE38PdWZBY3wJ8KTK4udTmR1oOqQT
	 wJ8DHYsIKy7fw==
Date: Fri, 27 Mar 2026 10:00:44 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, 
	linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org, 
	linux-cxl@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 00/15] mm: memory hot(un)plug and SPARSEMEM cleanups
Message-ID: <5a7ad1c5-6e06-4829-9971-05d3c599e581@lucifer.local>
References: <20260320-sparsemem_cleanups-v2-0-096addc8800d@kernel.org>
 <20260326195816.60110f50cd464d0076aad0ff@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326195816.60110f50cd464d0076aad0ff@linux-foundation.org>

On Thu, Mar 26, 2026 at 07:58:16PM -0700, Andrew Morton wrote:
> Lorenzo, I've assumed that your conditional R-b on [01/15] is now
> unconditional.

Yeah that's fine.

Cheers, Lorenzo
