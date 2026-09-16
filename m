Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801481E9B37;
	Wed, 16 Sep 2026 02:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789525652; cv=none; b=gm47hnwYAqFh3J02U2k1c8TAFUkr2niL4ad2r5S3XWGqI9JuWuGVGHOjK/iozkIueC6qfwW7zgyapSMGfd9O4Nst06xWDb6IKv74k70xvdKETrfbZ7vpxUuMG5OblxiN1bMQ6crrwCJTKW5vSq/KRXKcBgYqw8ml36C0axignac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789525652; c=relaxed/simple;
	bh=IVH7Pm5R9WcquMq3t1bazYxK9kEFSC5StXvZOjAo1kE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b/FgGD8IsP0YfwQ0wzk+ak35V+VZ9dSPY3kVWQbe7thMzU4IhDgCmU/JVZI5zyomUXh2ihR13X30G3FNblPl1tF+98aUt6ll8Kf955NURNJ1GbVT4iA834c8VC2BXralzDNnQmzKi0CEkl9is1sWScukve3XRix9eOlP1PYdUtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UT6lIFqq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UT6lIFqq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 136031F000FF;
	Wed, 16 Sep 2026 02:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789525648;
	bh=v2JbBQdXc0cad9vO+Y+5U+zKD9ij3eTgcG+CMiqoS1U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UT6lIFqq5+AqaWFTuxFuDH6H+V71SypaHAIHKh/bTK9R5lWG5iOLoj9Mdbn27q/Jt
	 AT8WW0tijbwLyt8y551C12CmiIQhHH5J8NDs1HwsDLnnLGno2ygAciOl+jDjvu4cuR
	 4+P2RDpVsc51FWByIBod7MxTKDMqEis1RC5ZIfvPtzoPr7zW7nAQ13kjg9xYwtoY+g
	 DCChU3iwQjyIfgu4NLbAeIm5Gv31oSkhLDHMV/nc9jVTux1Mo4UjnV4O/sjWCiCaAv
	 ykEfw+ZDqCuXsYaiNbuCn3Onp/1FYTi0sm8nIi5ZdRQfaGcQPUBskTPQLmUj6rWglz
	 7pz1H57xdCfVg==
Date: Wed, 16 Sep 2026 03:27:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Richard Cheng <icheng@nvidia.com>, <dave@stgolabs.net>,
 <dave.jiang@intel.com>, <vishal.l.verma@intel.com>, <iweiny@kernel.org>,
 <ming.li@zohomail.com>, <gourry@gourry.net>, <rrichter@amd.com>,
 <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <kees@kernel.org>, <newtonl@nvidia.com>, <kristinc@nvidia.com>,
 <kaihengf@nvidia.com>, <kobak@nvidia.com>
Subject: Re: [PATCH v7 3/7] cxl/region: Don't leak tolerated RAM -EFAULT
 from unmapped poison scan
Message-ID: <20260916032722.5024645e@jic23-hlaptop>
In-Reply-To: <appWSlo5UJwg6Z90@aschofie-mobl2.lan>
References: <20260902053839.25595-1-icheng@nvidia.com>
	<20260902053839.25595-4-icheng@nvidia.com>
	<appWSlo5UJwg6Z90@aschofie-mobl2.lan>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 3 Sep 2026 22:25:30 -0700
Alison Schofield <alison.schofield@intel.com> wrote:

> On Wed, Sep 02, 2026 at 01:38:35PM +0800, Richard Cheng wrote:
> > cxl_get_poison_unmapped() tolerates the -EFAULT a RAM partition returns
> > for Get Poison List by skipping that partition, but left rc holding the
> > error. If the tolerated RAM fault was the last poison query before the
> > loop ended, the function returned a spurious -EFAULT and the poison-list

Good to call out why it is doing this just to remind the reader.
+ what the path to actually get -EFAULT is.  That might be relevant
to anyone considering if the bug effects them.

Unhelpfully (maybe fix this) cxl_internal_send_cmd() is documented as returning
-EFAULT for "Hardware Error Occured" whereas I think it comes from an
Invalid PA being passed in the query but I'm not 100% sure there isn't
another path.

> > read failed even though enumeration succeeded. Reset rc to 0 when
> > tolerating the fault, matching poison_by_decoder().  
> 
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>


