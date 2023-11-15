Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0167318B0C
	for <linux-cxl@vger.kernel.org>; Wed, 15 Nov 2023 13:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KO6V5GVA"
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E717E109
	for <linux-cxl@vger.kernel.org>; Wed, 15 Nov 2023 05:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AqXUQm5HrQp/EA6YFAjTLiHuBMthezy2Ie6boI3oB6c=; b=KO6V5GVAkb1yXKt5p5eHyCHZHg
	NVb8+zT8D9DvpWN38htkDmAx7CaZTr54XnRvObExDlT9igB6qrnJ7E7iPdcDOa2usr6KfDqqFCkAi
	4URiHmhGfLpDdUn02SPd3NYeqnXez/XsiMfWX1NSFsrTy5SinMCjZPpEngBvd7ik2/6hvStB3Dmel
	1HCGXFqR8XsIMX91QQg7B5saoxVTk5zlxh8rHQkDe9UEKuMtKZU+rlE3Bx+G1ugfYCBmQLCzIR4me
	ox96C8I3d/0Kj7byIa8CRYMeskrVgEZx5TMAYltcF0uyQ2QX1QrRw6kl/NOJYMFsEkl3xHEIN/pYj
	eRTMdOPQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1r3Fb6-004252-2Q;
	Wed, 15 Nov 2023 13:06:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6ABF2300427; Wed, 15 Nov 2023 14:06:24 +0100 (CET)
Date: Wed, 15 Nov 2023 14:06:24 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>,
	linux-cxl@vger.kernel.org, Jonathan.Cameron@huawei.com,
	dave@stgolabs.net, alison.schofield@intel.com,
	vishal.l.verma@intel.com
Subject: Re: [PATCH] cxl: Add cxl_region_rwsem around commit_end write during
 decoder enumeration
Message-ID: <20231115130624.GK4779@noisy.programming.kicks-ass.net>
References: <169948110840.509375.13862681045079385425.stgit@djiang5-mobl3>
 <654d5f7285171_af98d2949e@iweiny-mobl.notmuch>
 <654e90e4349f9_46f0294da@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20231115130113.GG3818@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115130113.GG3818@noisy.programming.kicks-ass.net>

On Wed, Nov 15, 2023 at 02:01:14PM +0100, Peter Zijlstra wrote:
> On Fri, Nov 10, 2023 at 12:21:56PM -0800, Dan Williams wrote:
> 
> >         /* decoders are enabled if committed */
> > -       if (committed) {
> > +       if (committed) scoped_guard(rwsem_write, &cxl_region_rwsem) {
> >                 cxld->flags |= CXL_DECODER_F_ENABLE;
> >                 if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
> >                         cxld->flags |= CXL_DECODER_F_LOCK;
> > 
> > 
> > The alternative is a much more violent re-ident of the code to turn:
> > 
> >     if (...) scoped_guard(...) {
> > 	...
> >     } else {
> >         ...
> >     }
> > 
> > ...into:
> > 
> >     if (...) {
> >         scoped_guard(...) {
> > 	    ...
> >         }
> >     } else {
> >         ...
> >     }
> > 
> 
> What's wrong with:
> 
> 	if (...) {
> 		guard(rwsem_write, &cxl_region_rwsem);

Uh, that is:
		guard(rwsem_write)(&ctl_region_rwsem);

> 		...
> 	} else {
> 		...
> 	}
> 
> ?

