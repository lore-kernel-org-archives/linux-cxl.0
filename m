Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D1523909F;
	Mon, 12 May 2025 16:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747067706; cv=none; b=uw3ni/l158en/oAbUQn6gZyzagT3WaL9yHibhryYv6qU+RIaDTwIyOx/c/a+4Cdd5eawPlrYaMSq7KvFF/H/BD7zjzEVl4geh+UvMNmtHifzNeQFhjXiyPnAszUfkmLUdiLIVUzmFEzxjpM+WLZlibvuNr8M9cQowr6X+dKrO2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747067706; c=relaxed/simple;
	bh=TKJnnei2eVx16RcQeukNeEQclx9j9wUljzuhpWTdZ0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KhxIimE16ErlWNrzA0du+fzuoRLAGUx11UyVBavelYlwWO4jsYb9tCu5DoMzInYqMWshEQCc9PS4Fzw9uBEt4mlaiMP6ZNA3WodKDR0PWYgxZv1ZnXUXh+xTk7LP0I+Dnj7wqSciF4igKHbyo5iYdJI3h4vULlQOP3BojDh8pM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=e+qN+1gK; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e+qN+1gK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=27z3nsnKNBs0/EpgHQUudDnqs7+MrF2uhYVPCFdQjFo=; b=e+qN+1gKLoTZsUNsKtD0WJD9Zk
	HhEaRR6WfSmnUmgOWG54tLCgHJiJR6KH8DxlPm2k39RKK7Lj31xa/PKaW3x6Gs/ox1apv29xbpOew
	wJ9imH6yysGjFaqx4OimJer+tTGgQQXnanEPF0zwCvmwjmCoFwvpnu9aE/yyuIyT+ycopfLSqUJGR
	iMZ1Fo0izVj/3PTmFE6fYQ4yQoOfkpt/d/PiPCpaNv4t2Z+4Gd31frm6gWCQlihH1Tdskc7X8Gw/n
	BsC+GpUtZSYwUnPYyrADFLgeTS4aYZkqKf4aC46IO+5qXpy8gNpwI7nbDb1ScKpBrT3vhGAl5jujx
	5w4xhwtw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEW7E-0000000A2yE-1Xvs;
	Mon, 12 May 2025 16:34:56 +0000
Date: Mon, 12 May 2025 17:34:56 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Gregory Price <gourry@gourry.net>
Cc: linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, corbet@lwn.net
Subject: Re: [PATCH v3 14/17] cxl: docs/allocation/page-allocator
Message-ID: <aCIjMNooAzKaONod@casper.infradead.org>
References: <20250512162134.3596150-1-gourry@gourry.net>
 <20250512162134.3596150-15-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512162134.3596150-15-gourry@gourry.net>

On Mon, May 12, 2025 at 12:21:31PM -0400, Gregory Price wrote:
> Document some interesting interactions that occur when exposing CXL
> memory capacity to page allocator.

We should not do this.  Asking the page allocator for memory (eg for
slab) should never return memory on CXL.  There need to be special
interfaces for clients that know they can tolerate the added latency.

NAK this concept, and NAK this specific document.  I have no comment on
the previous documents.
