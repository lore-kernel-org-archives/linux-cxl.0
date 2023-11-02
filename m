Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24806FBD
	for <linux-cxl@vger.kernel.org>; Thu,  2 Nov 2023 09:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Dym5O29y"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B80133;
	Thu,  2 Nov 2023 02:30:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0531021A0C;
	Thu,  2 Nov 2023 09:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1698917448; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pcw+LbWUfSvxfYB/h2cYbMJhx/7SmPVWKYqXZJ8Pv9I=;
	b=Dym5O29yyxXSjikUeyZ4MonWJ8zuFBbC0jJXdcLz/yKg3Gsf7Nl2fmYrR6RPXDy7hwu98N
	pISuW0g3YutuhubxJnAcbXXSN7q4kDEjywDsluYpt9moR+m8xUo9djqpMnmko+tdBNXN7F
	VDE3IgXVtacgzwmhX29LTAvEZsPh6tg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BA56C138EC;
	Thu,  2 Nov 2023 09:30:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id TCV1KkdsQ2U/awAAMHmgww
	(envelope-from <mhocko@suse.com>); Thu, 02 Nov 2023 09:30:47 +0000
Date: Thu, 2 Nov 2023 10:30:47 +0100
From: Michal Hocko <mhocko@suse.com>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, 
	Gregory Price <gourry.memverge@gmail.com>, linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org, 
	linux-mm@kvack.org, akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com, 
	weixugc@google.com, apopple@nvidia.com, tim.c.chen@intel.com, dave.hansen@intel.com, 
	shy828301@gmail.com, gregkh@linuxfoundation.org, rafael@kernel.org, 
	Gregory Price <gregory.price@memverge.com>
Subject: Re: [RFC PATCH v3 0/4] Node Weights and Weighted Interleave
Message-ID: <aou443yuqdizirtjddrrcfn4hoo3m3nort3g3mvsbdcg3w2ruc@m3iumue3tlps>
References: <20231031003810.4532-1-gregory.price@memverge.com>
 <rm43wgtlvwowjolzcf6gj4un4qac4myngxqnd2jwt5yqxree62@t66scnrruttc>
 <20231031152142.GA3029315@cmpxchg.org>
 <jgh5b5bm73qe7m3qmnsjo3drazgfaix3ycqmom5u6tfp6hcerj@ij4vftrutvrt>
 <20231031162216.GB3029315@cmpxchg.org>
 <3ilajsu7rlatugtmp63r6ussfdhqoxokj2vgmx3ki3zmx7f5po@i64b27upx5qx>
 <87edh81xqa.fsf@yhuang6-desk2.ccr.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87edh81xqa.fsf@yhuang6-desk2.ccr.corp.intel.com>

On Thu 02-11-23 14:21:49, Huang, Ying wrote:
> Michal Hocko <mhocko@suse.com> writes:
> 
> > On Tue 31-10-23 12:22:16, Johannes Weiner wrote:
> >> On Tue, Oct 31, 2023 at 04:56:27PM +0100, Michal Hocko wrote:
> > [...]
> >> > Is there any specific reason for not having a new interleave interface
> >> > which defines weights for the nodemask? Is this because the policy
> >> > itself is very dynamic or is this more driven by simplicity of use?
> >> 
> >> A downside of *requiring* weights to be paired with the mempolicy is
> >> that it's then the application that would have to figure out the
> >> weights dynamically, instead of having a static host configuration. A
> >> policy of "I want to be spread for optimal bus bandwidth" translates
> >> between different hardware configurations, but optimal weights will
> >> vary depending on the type of machine a job runs on.
> >
> > I can imagine this could be achieved by numactl(8) so that the process
> > management tool could set this up for the process on the start up. Sure
> > it wouldn't be very dynamic after then and that is why I was asking
> > about how dynamic the situation might be in practice.
> >
> >> That doesn't mean there couldn't be usecases for having weights as
> >> policy as well in other scenarios, like you allude to above. It's just
> >> so far such usecases haven't really materialized or spelled out
> >> concretely. Maybe we just want both - a global default, and the
> >> ability to override it locally. Could you elaborate on the 'get what
> >> you pay for' usecase you mentioned?
> >
> > This is more or less just an idea that came first to my mind when
> > hearing about bus bandwidth optimizations. I suspect that sooner or
> > later we just learn about usecases where the optimization function
> > maximizes not only bandwidth but also cost for that bandwidth. Consider
> > a hosting system serving different workloads each paying different
> > QoS.
> 
> I don't think pure software solution can enforce the memory bandwidth
> allocation.  For that, we will need something like MBA (Memory Bandwidth
> Allocation) as in the following URL,
> 
> https://www.intel.com/content/www/us/en/developer/articles/technical/introduction-to-memory-bandwidth-allocation.html
> 
> At lease, something like MBM (Memory Bandwidth Monitoring) as in the
> following URL will be needed.
> 
> https://www.intel.com/content/www/us/en/developer/articles/technical/introduction-to-memory-bandwidth-monitoring.html
> 
> The interleave solution helps the cooperative workloads only.

Enforcement is an orthogonal thing IMO. We are talking about a best
effort interface.

-- 
Michal Hocko
SUSE Labs
