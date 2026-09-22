Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78AC361970;
	Tue, 22 Sep 2026 01:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790040326; cv=none; b=QKucKrxumGFA0rUde7bUOdB8XdKHyyNWrMe96uITWD13rzKS7U6DfkKOYfecQgOBDd2U0TK7NoX+fXWDgKXxQ45CpDUkQ7TXuoGlivrqiqpOJSdJtHbsE6SLyaoYu7U2H9WFuJRYYgr9rjJ40nI+/YFZs95DnXESUhEOS+IMQzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790040326; c=relaxed/simple;
	bh=lPAFJBA6CQZVEGhykqv1zy83g0pr6sOeKWxqZ9PtWlE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BVKbuqelpHPeYDcIZjSN+5rGJ3spmtozSASkw2GKCO0scSSlCFmAv6U1targDSauJsVFQL2wrQk6MmjQPubAFd+0HegiChssIS3LSyKg8fta1zU4yT68OWMAAHJQYsLknw66Uhc1WLOBaQYgiVo2qYAlypVsIBmWOMzSPEK0hpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h9PdAT14; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h9PdAT14"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 772F41F000FF;
	Tue, 22 Sep 2026 01:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790040324;
	bh=U0iRbAKnpxq8JC4/aMZEZXRDS3DY733wFMUpUEjItJI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=h9PdAT14tZN0OBK075QEHa4loozSySynmzjt7trkPX9EcEtviczVeC2pyTH/wCqDL
	 ZWNHUXqmcpz8UhoYu9UMy2qwXlOiOVXTefU3f5wSZHeavqHP7MHQRzO8mDrG4DRgDJ
	 0ZTK8W/ojO+Za7sqQ9u2zCNTDBY5J0Ye0HY2UR+Zlm57DqWs8y9qUkpWw8da+8fBXg
	 qW4qpjRS3Smoe1FsaYvp+2ZV7TJ1v/phIcnCocvOf59s0O/vxmQI0GGpc5E2NLczod
	 wHeL42rM5LsmcdBORJRVcyOoXfUdjXC+2ZMeAcH6ynNjcC6MM6cbsncOfZ2KGOxE78
	 xXW/ubKXlUVrQ==
Date: Tue, 22 Sep 2026 02:25:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Richard Cheng <icheng@nvidia.com>
Cc: "Lucero Palau, Alejandro" <alejandro.lucero-palau@amd.com>,
 dave@stgolabs.net, dave.jiang@intel.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, djbw@kernel.org, iweiny@kernel.org,
 ming.li@zohomail.com, gourry@gourry.net, rrichter@amd.com,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 newtonl@nvidia.com, kristinc@nvidia.com, kaihengf@nvidia.com,
 kobak@nvidia.com
Subject: Re: [RFC PATCH 0/3] cxl: Auto-create a region for Type-2 memdev
 attach
Message-ID: <20260922022518.1002b083@jic23-hlaptop>
In-Reply-To: <apU6tyyxSIGvzSs6@MWDK4CY14F>
References: <20260805074042.30173-1-icheng@nvidia.com>
	<a3978557-59d5-49bc-bdb3-9ef2dfa025d3@amd.com>
	<aobIoBYBACGlJ-OD@MWDK4CY14F>
	<53689d31-3707-4c15-9eb9-eb6c77ab3ca0@amd.com>
	<apU6tyyxSIGvzSs6@MWDK4CY14F>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Aug 2026 16:52:29 +0800
Richard Cheng <icheng@nvidia.com> wrote:

> On Tue, Aug 25, 2026 at 10:50:06AM +0800, Lucero Palau, Alejandro wrote:
> > Hi Richard,
> > 
> > On 20/08/2026 10:41, Richard Cheng wrote:  
> > > On Wed, Aug 12, 2026 at 10:58:02AM +0800, Alejandro Lucero Palau wrote:  
> > > > Hi Richard,
> > > > 
> > > > 
> > > > Some comments below.
> > > > 
> > > > 
> > > > Thanks!
> > > > 
> > > > 
> > > > On 8/5/26 08:40, Richard Cheng wrote:  
> > 
> > 
> > <snip>
> >   
> > > Hi Alejandro,
> > > 
> > > Thanks for the review and explanation. I've read them all.
> > > 
> > > I think you are right that this RFC doesn't currently have a production platform
> > > where the system FW publishes a Type-2 CFMWS but leaves the EP decoder
> > > uncommitted.
> > > 
> > > However, the config appears to be permitted by the CXL model. A CFMWS describes
> > > a FW-established root HPA window and the restrictions governing its use,
> > > including Type-2 v.s. Type-3 and volatile v.s. PMEM. The CFMWS def also
> > > describes OSPM assigning HPA ranges from those windows to discovered CXL.mem
> > > devices [1].  
> > 
> > 
> > Right. I'm not saying this should not be supported, just pointing out the
> > use case does not make sense with current BIOS functionality. I think BIOS
> > will/could support a config option for just leaving a Type2 HDM uncommitted,
> > but then why the kernel should do the same a default BIOS config would do?
> >  
> 
> Agreed. The kernel shouldn't recreate the config that BIOS would normally provide.

I'm a bit lost. Both BIOS doing nothing beyond cfmws as a design decision and
hotplug (where bios isn't in the loop) require this sort of flow.

Sure both might not be what you happen to have today but they are both
very much real usecases!

Jonathan

> And that's why I think we should move region createion out of devm_cxl_probe_mem().
> That helper should discover and attach to an already committed region.
> 
> If FW leaves the decoders unconfigured intentionally , a driver may explicitly request a region
> and provide the size it needs.
> 
> In my mind the new model should be
> - FW-committed config is only discovered and attached
> - an uncommitted config remains untouched unless a driver explicitly requests it
> - CXL core supplieds the allocation, validation, programming, accounting and teardown mechnism
> - the requesting driver owns the policy and the use of the region
> 
> So far I think PMEM reconstruction form label data maybe be a potential use case, though it's not
> provided in kernel right now, we can work on it in the future, or work on that one first and we'll
> continue the auto-create region part.
> 
> What do you think ?
> 
>  
> >   
> > > 
> > > The Linux CXL doc similarly states that only root decoders are required to be
> > > programmed during probe. Switch and EP decoder may remain available for runtime
> > > programming when the platform supports it [2].  
> > 
> > 
> > Tangential to this discussion, but I have problems with this assertion. Any
> > switch or EP HDM programming will need a root port HDM programming as well.
> > Not sure which root decoders will need to be programmed at boot time: a
> > CFMWS is "programmed" by the BIOS and root decoders will need to be
> > programmed as well for any Type2/switch found with an enabled link.
> > 
> >   
> 
> Here root decoder I mean the logical object created from a CFMWS. I didn't mean switch or EP
> decoder can be programmed independently.
> 
> My point was that FW establishes the CFMWS window, while the platform may leave downstream decoder
> path for later programming.
> 
> > > 
> > > I raise the RFC intended for the question of how Linux should support that
> > > architecturally permitted config.
> > > 
> > > The cxl_test config added in patch 3/3 constructs this scenario synthetically.
> > > This demonstrates the proposed kernel behavior, but I agree I don't know
> > > whether there exists a deployed FW scenario.
> > > 
> > > 
> > > And I agree that devm_cxl_probe_mem() shouldn't silently change from
> > > "attach to a FW-established region" into "allocate resources and program a new
> > > region". Those operations should have different semantics and ownership
> > > expectations.  
> > 
> > 
> > Glad with the consensus :-)
> > 
> >   
> > > 
> > > I am planning to rebase onto cxl/nexxt and rework the proposal as the following,
> > > please take a look and see if that matches your imagination or not.
> > > * Keep devm_cxl_probe_mem() behavior unchanged for FW-committed regions
> > > * Make region creation an explicit request from the accelerator provider,
> > >    rather than an automatic fallback during memdev attach
> > > * Have the provider specify the required size. CXL core shouldn't assume
> > >    that it maybe consume the entire volatile DPA partition as you mentioned.
> > > * Separate the reusable region-provisioning mechanism from the initial Type-2
> > >    policy.
> > > * The common mechanism should handle HPA/DPA allocation, decoder-path
> > >    construction, commit , rollback and managed teardown.
> > > * The initial type-2 caller would constrain that to volatile DEVMEM, IW=1
> > >    and a provider-requested size.
> > > 
> > > Oh and I'll replace "x1" with "IW=1" and explain the initial decoder,
> > > root-selection and granularity restriction more clearly.
> > > 
> > > How does that sound to you ?  
> > 
> > 
> > It sounds perfect!
> > 
> > 
> > FWIW, you likely saw Gregory's comment (discord) on this work requiring the
> > support for PMEM or at least the awareness PMEM support will need to use
> > same interface. His opinion and mine came from Dan's vision on this, and
> > your work will be the base for such PMEM support. I do not have an impending
> > reason for working on this PMEM support, but I am really interested in how
> > Type3 PMEMs can leverage CXL.mem for improving storage needs, and currently
> > reading/thinking about all this ...
> > 
> > 
> > Thanks!
> >   
> 
> Hmmm for this part I have no idea for now, I'll study more and discuss with you guys.
> 
> Best regards,
> Richard Cheng.
> 
> >   
> > > [1]: https://computeexpresslink.org/wp-content/uploads/2024/02/CEDT_ECN_1.0A_Eval.pdf
> > > [2]: https://docs.kernel.org/driver-api/cxl/linux/cxl-driver.html#runtime-programming
> > > 
> > > Best regards,
> > > Richard Cheng.  
> > > > > Testing result is in the following.
> > > > > - Built clean with clang/LLVM on arm64
> > > > > - cxl_test, type2_test=1. accel0 takes the unchanged attach path. accel1
> > > > >     drives auto_create -> a committed 512 MB RAM region. The test asserts
> > > > >     the 512 MB HPA range. committed state and 256 byte granularity confirmed
> > > > >     via sysfs.
> > > > > - Unbind tears the region down with no orphaned decoder, rebind re-creates
> > > > >     a fresh committed region.
> > > > > - Mock test only. Real accelerators whose FW commits a decoder take the
> > > > >     attach path, and vfio-cxl binds only FW-committed devices, so auto-create
> > > > >     has no real-HW caller yet.
> > > > > 
> > > > > Best regards,
> > > > > Richard Cheng.
> > > > > 
> > > > > Richard Cheng (3):
> > > > >     cxl/region: Reset software-created regions on memdev detach
> > > > >     cxl/region: Auto-create a region for memdev attach
> > > > >     cxl/test: Exercise Type-2 automatic region creation
> > > > > 
> > > > >    drivers/cxl/core/region.c      | 422 +++++++++++++++++++++++++++++----
> > > > >    tools/testing/cxl/test/accel.c |   7 +
> > > > >    tools/testing/cxl/test/cxl.c   |  61 ++++-
> > > > >    3 files changed, 439 insertions(+), 51 deletions(-)
> > > > > 
> > > > > 
> > > > > base-commit: 1c6b4ceafc3b994871c29340e0c1ddb0af5800e7  

