Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36C21E2823;
	Tue, 13 May 2025 20:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747168279; cv=none; b=F+ALofBq0FMM8I8E3XH7y9/mfMFPm0IYToFtntjVUgs8ErSs9+x+Ur9FfmLdTJdadT/BwosAn74SRB8Jlx9aO8JptFeBIJopV3/KI9pepxfvX3bRLF7w3aI84msqOst3Q2liUVIrARzkf9ORPWou9qiSyqR0Of0jI6Uf49wtFSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747168279; c=relaxed/simple;
	bh=gA+8x4DGzYAZAfPIvSoJQeC5ZkWL3twwiDnjLdDy+UM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l5oy6Clpka08xXmiD0WOkQKluiAEJCSsUTOIIhIUlKjZGfYqUa4GHR3FlDfDuYq3tfAXJ8SKOdiwdU3cJctcJSdT7eoJ3DdiyPpu+WSbPlNfa8SKlAz4jmLKWeYypEf0k2h1AY74QxB/bonuGdXqeUyhTi0W159AAcBkRWM7f/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=cCEf+r+d; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="cCEf+r+d"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=n2rwy6BPkstBQAwHsmHlQyhzOnWb/VlR1Eu4mOLIIWo=; b=cCEf+r+d6wjqF2k7iE3W1Wz1yY
	AIAgjD+RYifKFPwAX6YfD6V/ucjo367aD7uO0KT9u0ZCwYwKJXimCk2iauk7aYQVBH73Be3J6jP3i
	t3TKRr5InJXTDtrzOhifkPXGEdom8PDBGZZY/xgGSqXK+zvwCxpdJabA5/N/kwviEH0udMwIgSSMi
	U9p81MunS2CBG8ngle0JU/SGWD+eNoqCFKe67pzqHLOvRan6ZDDEri/YMckE7VI6koPkSVc6QYBFa
	MyyQJwzJrnWjrevktOyL5DBq+BygLMqZjyvnxX+CPGrLWcWhOHtQVKeV8OtZvrtYcv4OlP+fxGQpy
	poRAJeig==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEwHS-00000004KXi-0ykh;
	Tue, 13 May 2025 20:31:14 +0000
Date: Tue, 13 May 2025 21:31:14 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>, dan.j.williams@intel.com,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Ingo Molnar <mingo@kernel.org>,
	"Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH 1/7] cleanup: Introduce DEFINE_ACQUIRE() a CLASS() for
 conditional locking
Message-ID: <20250513203114.GK2023217@ZenIV>
References: <20250509104028.GL4439@noisy.programming.kicks-ass.net>
 <681ea7d5ea04b_2a2bb100cf@dwillia2-mobl4.notmuch>
 <20250512105026.GP4439@noisy.programming.kicks-ass.net>
 <20250512182559.GB25891@noisy.programming.kicks-ass.net>
 <20250512185817.GA1808@noisy.programming.kicks-ass.net>
 <CAHk-=whxPoFnZ4cLKh4X3m4qVcaak__G8+0iG-aOGO7YkS3LdA@mail.gmail.com>
 <20250513070918.GB25763@noisy.programming.kicks-ass.net>
 <20250513085001.GC25891@noisy.programming.kicks-ass.net>
 <CAHk-=wjBiAqaWnXG_44ajMCqU3nNQOC1RQ6SUmKYC03Y1G=r1g@mail.gmail.com>
 <20250513200619.GJ2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513200619.GJ2023217@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, May 13, 2025 at 09:06:19PM +0100, Al Viro wrote:

> FWIW (unsigned long)v - 1 >= (unsigned long)(-MAX_ERRNO-1) yields
>         leaq    -1(%rdi), %rax
> 	cmpq    $-4097, %rax
> 	ja      .L4
> from gcc and
>         leaq    4095(%rdi), %rax
> 	cmpq    $4095, %rax                     # imm = 0xFFF
> 	ja      .LBB0_1
> from clang...

Nevermind - should've read back through the thread for context.
Sorry.
