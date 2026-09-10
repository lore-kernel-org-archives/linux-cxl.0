Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860FA482D4;
	Thu, 10 Sep 2026 09:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789033947; cv=none; b=W/L/m2X+YDWsf8jMa9rlLfYvcms8NgPhT4LYiolarFD/LQZJOs2vm5IwFXW/xymcLPBaeVle/9+q9XI4k0byaLo0W2NApffYiMBLr/o7ahD+1XFOnpHQ8VKje4tVNKUxr79b4IagO9umZsbFBmu9OBjYJVFl2KYvW4xCxStPSxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789033947; c=relaxed/simple;
	bh=pndUJBEjnd7Wv3ABJyyPs9Z8EqRVfw+8ndyCpKmyO+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AHa+tWE3Pmvf9NqX0eg6PIHvqmUBmdfm290Ta+uVFMTyWvSHi0T7uD74nx2QYd7zM+qOS/YRAo4r5uQJ9EHbuV5Rrk5du5AO2Gb40TpZOSWxpmUYRtN+Jb8LhITSOpi98kSxg19cQQbwX5RyI8BnzIEGv2WBdShmrNyCGtVftf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UVyzcETz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UVyzcETz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82B2F1F00898;
	Thu, 10 Sep 2026 09:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789033946;
	bh=p9eKctnkrtB0QPAfMFCSIEJt6FyqyTGQq7V+DgZ9IbY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UVyzcETzMkQhIvWIpoUUNwPVFhHBnS1BCRJqhI22nO5dnVfxp99dD25b7KQ6StJ7v
	 jZYctZ6l9RJHQzWkwE8NucPNpceP/Nsml7cFBLP/R3IEpuQjt0stnz3R6HPoRwFAY2
	 EKrKPR3zlBe1ufakB8Dl7paftvLHob7OIx66p38Q=
Date: Thu, 10 Sep 2026 11:52:17 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Shaikh Kamaluddin <shaikhkamal2012@gmail.com>,
	linux-cxl@vger.kernel.org, driver-core@lists.linux.dev
Subject: Re: [PATCH v3 2/2] cxl/memdev: Fix deadlock between poison debugfs
 and cxl_mem unbind
Message-ID: <2026091013-deepness-astronaut-471a@gregkh>
References: <20260910094017.4032170-1-kanie@linux.alibaba.com>
 <20260910094017.4032170-3-kanie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910094017.4032170-3-kanie@linux.alibaba.com>

On Thu, Sep 10, 2026 at 05:40:17PM +0800, Guixin Liu wrote:
> The poison debugfs handlers take the memdev device lock so that the
> region lookup sees a stable cxlmd->dev.driver. debugfs holds a reference
> on the file across the handler, and cxl_mem unbind removes that file
> while holding the very same device lock, so a handler that waits for the
> lock deadlocks against a concurrent unbind.
> 
> Both tasks then hang. The unbind side is uninterruptible, and it also
> blocks the memdev detach work, which runs on an ordered workqueue and so
> stalls every other CXL bus work item.
> 
> Take the lock with the trylock guard and return -EBUSY instead of
> waiting. An unbind that wins the race removes the file first and the
> write fails with -ENOENT.
> 
> Found by code inspection. Reproduced by writing inject_poison in a loop
> while unbinding and rebinding cxl_mem, and confirmed fixed by the same
> test.

Why would anyone normally "unbind" cxl_mem at all?  That will taint
kernels soon, so you don't normally want to do that, right?

And debugfs is root-only, so this is a "root did something bad, and gets
to keep the mess", right?  This should not ever be a normal operation.

thanks,

greg k-h
