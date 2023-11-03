Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29CA1C6AE
	for <linux-cxl@vger.kernel.org>; Fri,  3 Nov 2023 16:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tFRHMHyI"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ADCA1BC;
	Fri,  3 Nov 2023 09:59:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E3027215EF;
	Fri,  3 Nov 2023 16:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1699030740; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uksxNlyaCkPKE2rCxUqHpdRT6fah3eDwts+mbY5jJ80=;
	b=tFRHMHyImjbSl76qgnGYfaGAQjIf2+RKyoSrDKE6JYpTj3dCCULp5IbO+HPk9WXCt3fUCF
	Tma8lM/OV+12rR+rWRNAoHDmvTAo+dQyglzQIRQYyylAI0I5KBZMBZ+4gjZCW/UncW3qeC
	+/gos/UZoYDWbzoJMfms4apKWMlAb2g=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BBAFB13907;
	Fri,  3 Nov 2023 16:59:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id W9LcKtQmRWVuVgAAMHmgww
	(envelope-from <mhocko@suse.com>); Fri, 03 Nov 2023 16:59:00 +0000
Date: Fri, 3 Nov 2023 17:59:00 +0100
From: Michal Hocko <mhocko@suse.com>
To: Gregory Price <gregory.price@memverge.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, 
	Gregory Price <gourry.memverge@gmail.com>, linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org, 
	linux-mm@kvack.org, ying.huang@intel.com, akpm@linux-foundation.org, 
	aneesh.kumar@linux.ibm.com, weixugc@google.com, apopple@nvidia.com, tim.c.chen@intel.com, 
	dave.hansen@intel.com, shy828301@gmail.com, gregkh@linuxfoundation.org, 
	rafael@kernel.org
Subject: Re: [RFC PATCH v3 0/4] Node Weights and Weighted Interleave
Message-ID: <oe7s47mjbemtfsc3tbhweeiledh4srjntrsyohsvpy5m4jsgsb@xjl7u5a3p3z3>
References: <rm43wgtlvwowjolzcf6gj4un4qac4myngxqnd2jwt5yqxree62@t66scnrruttc>
 <20231031152142.GA3029315@cmpxchg.org>
 <jgh5b5bm73qe7m3qmnsjo3drazgfaix3ycqmom5u6tfp6hcerj@ij4vftrutvrt>
 <ZUCCGJgrqqk87aGN@memverge.com>
 <pmxrljwp4ayl3fcu7rxm6prbumgb5l3lwb75lqfipmxxxwnqfo@nb5qjcxw22gp>
 <ZUKDz5NpMsoyzWtZ@memverge.com>
 <a4f5das6ckw5lwj3qv2eaygx4nypb762b6mdnxivrjjndqlhjk@zpjao2ewfdoc>
 <ZUMVI4YG7mB54u0D@memverge.com>
 <s72oio7nmez565i7h6fb4bdnhqkcablr34rz5gqteyrrf7yeux@lqrztvy35si5>
 <ZUPomvqNwZgDbo51@memverge.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUPomvqNwZgDbo51@memverge.com>

On Thu 02-11-23 14:21:14, Gregory Price wrote:
[...]
> Only thing I'm not sure of is what happens if mempolicy is allowed to
> select a node that doesn't exist.  I could hack up a contrived test, but
> i don't think the state is reachable at the moment.

There are two different kinds of doesn't exist. One is an offline node
and the other is one with a number higher than the config option allows.
Although we do have a concept of possible nodes N_POSSIBLE I do not
think we do enforce that in any user interface and we only reject nodes
outside of MAX_NODE.

The possible nodes concept is more about optimizing for real HW so that
we do not over shoot when the config allows a huge number of nodes while
only handful of them are actually used (which is the majority of cases).
-- 
Michal Hocko
SUSE Labs
