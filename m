Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436C24746A5;
	Fri, 25 Sep 2026 23:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790377794; cv=none; b=DqgoH8yfXB6V2dV+EP+UYfrGnfDrp+B+ap4Md7QM/C/LnwfHSeNcI/DwoJKFsPLiD1u47gYOmp9CyvlJcbLgIdx4MffvetJw1nQiXYT0E7F3D0AYP9rJM1Ah44eFgVN/AUoFTAcjOYllfax27oyUwxcZq6wPL8GpWgloKkrdqQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790377794; c=relaxed/simple;
	bh=uoM4MXjQo+6H2AoBOdp/G+fZmDHbKMwFkuVU19UQltk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Puiyp2RLqctE9cg9qPcXIWO4sHUTBg3Ta44h1nPmlH2oyBNVfHFgFgNy7x0K1SkOg+0VaJKESoZ8Gl8VgWLWD1UJ12ny6z3Qyutnfxz29sL6J96CPY917cLuyUIWHrzrf06FwNvIi3MoKh7qF/yUt5wnGynxjCXZ2CsnwHobIVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a5PYe3IH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a5PYe3IH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A00E1F000FF;
	Fri, 25 Sep 2026 23:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790377793;
	bh=iTAi320q47+Uncq8P7GlnXO4Ao5Emmd16DavP6Kc9T8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=a5PYe3IHa02wZMeHmjeS7FUY8fSQTa6QcxHIylpSsKd5q1mhV3Ib7OJP+L9ucZCB9
	 SOjCOGj+ARZOUgfwAGtKk6M3WKR/G2LubFE6IMQ7s/C1wSRsvKZKxDmaVKRHjZJ0AH
	 i1DXjPIAusRil6MMJ+kdvr42Q1/JqOitbFWgXXnj4fJJVV39vBeDcIy75FOWqF0TEZ
	 tCLnUo2MxaZSLC4w0UCsr40zV1cXC7B5wXzdPSWtAmXcEBWOkaiaIWXc7be5RFtjrE
	 72NoQgVHegvFESCvzr6upPaCiJ+hjoGnYimJo82D+7VqDBPK2V/yZriQYD0CfgKKYs
	 7SBLqvHGauPAw==
Date: Sat, 26 Sep 2026 00:09:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
 Alison Schofield <alison.schofield@intel.com>,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2] checkpatch: don't flag ACQUIRE_ERR() assignments in
 if conditions
Message-ID: <20260926000933.6d51223e@jic23-hlaptop>
In-Reply-To: <20260924033923.4140210-1-kanie@linux.alibaba.com>
References: <20260924033923.4140210-1-kanie@linux.alibaba.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Sep 2026 11:39:23 +0800
Guixin Liu <kanie@linux.alibaba.com> wrote:

> ACQUIRE_ERR() and its wrappers, PM_RUNTIME_ACQUIRE_ERR() and
> IIO_DEV_ACQUIRE_FAILED(), report whether a conditional cleanup.h guard
> was acquired, and drivers consume the result directly in an if
> condition:
> 
> 	if ((rc = ACQUIRE_ERR(mutex_intr, &lock)))
> 		return rc;
> 
> That combined form is the established style at the 49 in-tree call
> sites under drivers/cxl and drivers/pci/tsm.c, so ASSIGN_IN_IF fires
> there only as a false positive, and every patch touching those lines
> carries noise that reviewers have to wave off manually.
> 
> Skip the check only when every assignment in the condition assigns the
> result of such a call, matched by the *_ACQUIRE_ERR() /
> *_ACQUIRE_FAILED() naming convention of its wrappers. Plain
> assignments, mixed conditions and near-miss identifiers still get
> flagged.
> 
> Suggested-by: Alison Schofield <alison.schofield@intel.com>
> Cc: linux-cxl@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> 
I'm thoroughly in favour but seeing as I'd end up using an LLM
just to figure out what the actual code does no tags from me!

Jonathan
