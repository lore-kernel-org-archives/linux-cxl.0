Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6811E392C4D;
	Fri, 16 Jan 2026 14:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768574340; cv=none; b=UCAyGb/+U2BNboshv/+2XM+Ooth/CsN3K1IOUUt3fk95lVsGByqIAhT6dpta1yhpI0eiEJFqkfK6T8BdHIDXSdaaD/jNoNiiynd4Rs30AV9nRfI0SiIq5+AW3v0qJhoOUw90zqPOahKYa7NcxNczTZPRyOPWV8zoQh1lcz4MwlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768574340; c=relaxed/simple;
	bh=vuntCnLe8s9zx9UF6n/CdCcUTOCgjCGXZ+r1gHYp5Jw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ATmrrqN1Vrv6L+ZwOfLcp/pRPfHmVhuHBFzW71w18MKHQAY6LAENHQgXFgaGWB8lG4O7fG93523CAnTQ/1nG2T5J6vbOq5U8z1o/ljNqJXzWf4+q7TYlJYAj1n0eFoCMdIfWGHGgx9LN0aHjBX61kmhHN+NNjzZFcbYEndatSyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Bd8oooS+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Bd8oooS+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4F8JMl7J3PkYqYKx7WnPy12MTGoQ5KLOxvg+BVH9RDM=; b=Bd8oooS+LwVHkT5qxgNpH2P/dr
	56JCDjy8RIhgdejZnijS8bgI7+kG+WBGQ4lJktGaEtUsDrTuynEiasAs2OH7hWwuCpH0D5VD9lcrS
	45Az28obRCasrjvrBp+wq83i+HTZOrQMfw70zDu3GUxT7/fc9ZEPk8O7ETJiESloR6TiqqIzkX09V
	d+/2FFKQoJQ4rAkKp1kh+wtPwefamcgiaFKpdaHDKF9+YhavSIPE60JUY+KmHJ9/w4VpZqZrm7zt5
	2AVGqVOlmDBLIqDNjAEOCNbA0iw9RBqTb4hRpE/TArUPQszRVDVV8Qx+xFtassXVR2oE2Sd/XJBfc
	1gk+oQ1Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vgkyG-00000009THG-0ySn;
	Fri, 16 Jan 2026 14:38:40 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E9A8F3005E5; Fri, 16 Jan 2026 15:38:38 +0100 (CET)
Date: Fri, 16 Jan 2026 15:38:38 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
	Robert Richter <rrichter@amd.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v9 10/13] cxl: Enable AMD Zen5 address translation using
 ACPI PRMT
Message-ID: <20260116143838.GC1890602@noisy.programming.kicks-ass.net>
References: <20260110114705.681676-1-rrichter@amd.com>
 <20260110114705.681676-11-rrichter@amd.com>
 <CAMj1kXHYTyxBcO3Jt97pukZiOTqL8U=zL5iari82sqMOen1cEQ@mail.gmail.com>
 <aWehZwXsK1IXRNU2@rric.localdomain>
 <CAMj1kXFhBdCPW_+xPR-TmU4M46Jr6DGwtjUtjDQ0EbgPGmL7vQ@mail.gmail.com>
 <20260114180859.00004623@huawei.com>
 <20260115080444.GD830755@noisy.programming.kicks-ass.net>
 <CAMj1kXENYZq-UkCup6FSH_4tmpRe4xJN1_veuSWs-hxxAo=1Ew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXENYZq-UkCup6FSH_4tmpRe4xJN1_veuSWs-hxxAo=1Ew@mail.gmail.com>

On Thu, Jan 15, 2026 at 09:30:10AM +0100, Ard Biesheuvel wrote:
> On Thu, 15 Jan 2026 at 09:04, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, Jan 14, 2026 at 06:08:59PM +0000, Jonathan Cameron wrote:
> >
> > > Do we have a potential issue wrt to merging this as it stands and improving
> > > on it later?  i.e. Is this a blocking issue for this patch set?
> >
> > Well, why do you *have* to use PRMT at all? And this is a serious
> > question; PRMT is basically injecting unaudited magic code into the
> > kernel, and that is a security risk.
> >
> > Worse, in order to run this shit, we have to lower or disable various
> > security measures.
> >
> 
> Only if we decide to keep running it privileged, which the PRM spec no
> longer requires (as you have confirmed yourself when we last discussed
> this, right?)

Indeed. But those very constraints also make me wonder why we would ever
bother with PRM at all, and not simply require a native driver. Then you
actually *know* what the thing does and can debug/fix it without having
to rely on BIOS updates and whatnot.

Worse, you might have to deal with various incompatible buggy PRM
versions because BIOS :/

> > If I had my way, we would WARN and TAINT the kernel whenever such
> > garbage got used.
> 
> These are things that used to live in SMM, requiring all CPUs to
> disappear into SMM mode in a way that was completely opaque to the OS.
> 
> PRM runs under the control of the OS, does not require privileges and
> only needs MMIO access to the regions it describes in its manifest
> (which the OS can inspect, if desired). So if there are security
> concerns with PRM today, it is because we were lazy and did not
> implement PRM securely from the beginning.
> 
> In my defense, I wasn't aware of the unprivileged requirement until
> you spotted it recently: it was something I had asked for when the PRM
> spec was put up for "review" by the Intel and MS authors, and they
> told me they couldn't possibly make any changes at that point, because
> it had already gone into production. But as it turns out, the change
> was made after all.
> 
> I am a total noob when it comes to how x86 does its ring0/ring3
> switching, but with some help, I should be able to prototype something
> to call into the PRM service unprivileged, running under the efi_mm.

The ring transition itself is done using IRET; create a iret frame with
userspace CS and the right IP (and flag etc.) and off you go. The
problem is getting back in the kernel I suppose. All the 'normal' kernel
entry points assume the kernel stack is empty and all that.

The whole usermodehelper stuff creates a whole extra thread, sets
everything up and drops into userspace. Perhaps that is the easiest
solution. Basically you set the thread's mm to efi_mm, populate
task_pt_regs() with the right bits and simply drop into 'userspace'.

Then it can complete by terminating itself (sys_exit()) and the calling
context reaps the thing and continues.

> Would that allay your concerns?

Yeah, running it as userspace would be fine; we don't trust that.

But again; a native driver is ever so much better than relying on PRM.

In this case it is AMD doing a driver for their own chips, they know how
they work, they should be able to write this natively.
