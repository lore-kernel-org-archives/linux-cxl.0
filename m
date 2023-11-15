Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Cx98NoIb"
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F78A189
	for <linux-cxl@vger.kernel.org>; Wed, 15 Nov 2023 11:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HtWn+eEMb9933FMJYTH1A3p1JOoggo5Y3ikFa+BqGzw=; b=Cx98NoIbjrWY4n5w/9HaxApM8m
	vSsxz9PERoGYXpNKflC95mHNbl3C7rt6oBg/VY0pbTE52xOMa8AhaMHoXHjCRUtZxggUubZmMRyZW
	V34jyp+AvCyYDKrOvTn8m4TKrTch3UZYlTwFIj6fsr+BQJiILA7FYTVNdnaKLnckkwaaNCgYuzBaf
	/Iw1Hzz8b7Wox84RoTydB6YC5jKbCldfI3ucjCYRsQ69Z3+GTUU1ihOTbfbxS2rP2Q+y2PQq+duST
	gDa7PR+TeWzrETsPpLCgAml4OA049Gc7wQ5CiYNtpE5Aj2IgRqEdhpOLtpdW2vdT00r47lj2gptu3
	ZHqLncmw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r3LnP-00G2dR-Uj; Wed, 15 Nov 2023 19:43:32 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9898F300427; Wed, 15 Nov 2023 20:43:31 +0100 (CET)
Date: Wed, 15 Nov 2023 20:43:31 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>,
	linux-cxl@vger.kernel.org, Jonathan.Cameron@huawei.com,
	dave@stgolabs.net, alison.schofield@intel.com,
	vishal.l.verma@intel.com
Subject: Re: [PATCH] cxl: Add cxl_region_rwsem around commit_end write during
 decoder enumeration
Message-ID: <20231115194331.GA19552@noisy.programming.kicks-ass.net>
References: <169948110840.509375.13862681045079385425.stgit@djiang5-mobl3>
 <654d5f7285171_af98d2949e@iweiny-mobl.notmuch>
 <654e90e4349f9_46f0294da@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20231115130113.GG3818@noisy.programming.kicks-ass.net>
 <20231115130624.GK4779@noisy.programming.kicks-ass.net>
 <6554eb3d8af14_fa4f2949e@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6554eb3d8af14_fa4f2949e@dwillia2-mobl3.amr.corp.intel.com.notmuch>

On Wed, Nov 15, 2023 at 08:01:01AM -0800, Dan Williams wrote:

> ...and scoped_guard() is just a more convenient way to write:
> 
>     {
>         guard(...);
>     }

Exactly so :-)
