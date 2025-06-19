Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BBE221FB5;
	Thu, 19 Jun 2025 11:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750331641; cv=none; b=dlPevnZThoFj1kdlBmesW2o0GCzQAAtbgGv8kk1XMLxSG7YALfmdM5vWdL6RmvfC5yFAjL9gRzLyNByihgFXVYoNTxZuYY7WmVl2B2yvgTYB0zDVfw66K6DpfAaGQLRZatkPLw9u9LzAI0kUUmksuEOKQLWwtrrBFtNq3N16aWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750331641; c=relaxed/simple;
	bh=vlN4f2vCH9XBiX2YMPzN2LNgBfmvt4ndYpsopsRYRKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=scuAX0b3yHXLFYjgdG32mvY5MyJAqGxx/3/K6FuImwKKkGDAYgMoDpSFZLKolBe2iny/WbZfjuXOI+M/YxmkF/gY4PeuO5Iw1vCbOtwh3KtBj6gaPWgmcqXJww2++RvlO6+6pJOuLYzE/6X7WmDkL+MUw5ArPN9RYEHpwe5F6uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PUiPjIRi; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PUiPjIRi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vlN4f2vCH9XBiX2YMPzN2LNgBfmvt4ndYpsopsRYRKQ=; b=PUiPjIRiyIlDrhklhgoYuQSI+g
	snd3EzUCb77/2LPrjrdbchj+KIqq6+v6KoASbt7Hq8fj4cNek9YC6DlK0tRqIu4WhS2XM4uInWBkK
	7sFO78jd4mDvgYb3rb4bLlvMWamgK6wHXJRQUBMr1kMXepFjKtUgT9s+i2J3yNfCbn59SCrtYU27S
	5FrkkVuWFf4xtsE//cJql11mY5Mq+l3UQtcUcfS1sgqw3nkhcEUCQ9R5wSjzWPyKw3kT1DetZfFZr
	xWXDgUfYEiPPiQSl5/M8AwyrBL5URMud0U5rLXDKS0C+g4xr7NlzAGCXrmm+ZBBb2p0RWrINB27SB
	2wBECjxQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSDDL-00000004Qao-2A8a;
	Thu, 19 Jun 2025 11:13:51 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 162A130890E; Thu, 19 Jun 2025 13:13:50 +0200 (CEST)
Date: Thu, 19 Jun 2025 13:13:50 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alison Schofield <alison.schofield@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	David Lechner <dlechner@baylibre.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	"Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>,
	"Fabio M . De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Ingo Molnar <mingo@kernel.org>, Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Shiju Jose <shiju.jose@huawei.com>,
	Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH v2 0/8] cleanup: Introduce ACQUIRE(), a guard() for
 conditional locks
Message-ID: <20250619111350.GF1613376@noisy.programming.kicks-ass.net>
References: <20250619050416.782871-1-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250619050416.782871-1-dan.j.williams@intel.com>

On Wed, Jun 18, 2025 at 10:04:08PM -0700, Dan Williams wrote:

> Note, all the code in patch1 is Peter's I just wrapped it in a changelog
> and added some commentary. Peter, forgive me if you were still in the
> process of circling back to this topic. I marked the patch attributed to
> you as: "Not-yet-signed-off-by". Otherwise, my motivation for going
> ahead with a formal submission are the multiple patchsets in my review /
> development queue where I would like to use ACQUIRE().

Definitely a case of too many balls in the air. Feel free to make that
Signed-off-by, and also:

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

for the patches that were sent my way. Thanks for the changelogs and
pushing this ahead.
