Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6254E156F3
	for <linux-cxl@vger.kernel.org>; Wed, 15 Nov 2023 13:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="km6jbQgv"
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DADD109
	for <linux-cxl@vger.kernel.org>; Wed, 15 Nov 2023 05:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4VsbodmnGqm/8ENX/t139OwZgSdGl06qKrHQcjF56qc=; b=km6jbQgv0yfhR8EodjmrJvNfGP
	GzMols5XI0WOVR2XqeOz3xnKyTyNF1gWsNskcyi0IEwxiRFuedV29dZsJ1qDWkOgdmANfsGW91ZfR
	fvWfCQHUxXMCM3BfyIyE+mMcziFPMxyTOSVQlenD/ZrtOSzo3eR1x0ICWkJRQCYfRwvpKPwLMdEao
	2/clpchxCLstceP7tujdseGd0lRcPi8HxhzwIYAf8/Ay5NNGKnLY0mLnPSsK/naZAQUP28u+bfahb
	qgb9Zk4Z7KN/cW9+o9NoCMS/Z0dZrBb9ADhVvvzzC8eOHYq9A/gL09DBVNGmclxirM7GZ8aufcdSk
	MvHOk6fA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r3FW6-00EJXN-Cp; Wed, 15 Nov 2023 13:01:14 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 12981300427; Wed, 15 Nov 2023 14:01:14 +0100 (CET)
Date: Wed, 15 Nov 2023 14:01:13 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>,
	linux-cxl@vger.kernel.org, Jonathan.Cameron@huawei.com,
	dave@stgolabs.net, alison.schofield@intel.com,
	vishal.l.verma@intel.com
Subject: Re: [PATCH] cxl: Add cxl_region_rwsem around commit_end write during
 decoder enumeration
Message-ID: <20231115130113.GG3818@noisy.programming.kicks-ass.net>
References: <169948110840.509375.13862681045079385425.stgit@djiang5-mobl3>
 <654d5f7285171_af98d2949e@iweiny-mobl.notmuch>
 <654e90e4349f9_46f0294da@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <654e90e4349f9_46f0294da@dwillia2-mobl3.amr.corp.intel.com.notmuch>

On Fri, Nov 10, 2023 at 12:21:56PM -0800, Dan Williams wrote:

>         /* decoders are enabled if committed */
> -       if (committed) {
> +       if (committed) scoped_guard(rwsem_write, &cxl_region_rwsem) {
>                 cxld->flags |= CXL_DECODER_F_ENABLE;
>                 if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
>                         cxld->flags |= CXL_DECODER_F_LOCK;
> 
> 
> The alternative is a much more violent re-ident of the code to turn:
> 
>     if (...) scoped_guard(...) {
> 	...
>     } else {
>         ...
>     }
> 
> ...into:
> 
>     if (...) {
>         scoped_guard(...) {
> 	    ...
>         }
>     } else {
>         ...
>     }
> 

What's wrong with:

	if (...) {
		guard(rwsem_write, &cxl_region_rwsem);
		...
	} else {
		...
	}

?
