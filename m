Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7FE497B9D
	for <linux-cxl@vger.kernel.org>; Mon, 12 Oct 2026 15:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791817633; cv=none; b=Gt7D35MAWJBzvFMAX+iKgUZJ+yoRLZ2eZ+65h6iL92CEE5edYcstTfhHmoI40IHiqARwmdrJ+WxvezvnHzRqLyB13ltpsXbrbmQMYXF9ztm9/+g3+AYpZkHliS7Ns2pXNk7HEq4n8MYUahYd8ROxMnN64t70fkIvjj2hQLfKv7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791817633; c=relaxed/simple;
	bh=YdgMV4z/GJt8IWri057rklfWX179cip6h6FunZRHYEk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YaUF2aMhxwXf+mNUycBnffcQAkki+3ODRxQS6KwoTf4QJ2T5cj+mdK0Vs2u8N0UMJwk9cMtiUfZpXbPML7tozcDz+A9cQkHvldNRYIlb4fSZffyyEygQdpKA7yLTP02ZrzzzMWeVjDWOrpLg4k2uq8gwATzD6Guqq1iqgr95TUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZQAos98; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZQAos98"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECA211F0089C;
	Mon, 12 Oct 2026 15:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791817632;
	bh=+jKo+pSpSt8VQqrzmSy9yJnJ6SKQ52DmQK6fnMyvCZY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BZQAos98CxtD2eO+ChM0Z4ilcjfeUGSbxjjyRaLaXiUZ2oerHKGGhlMwleRVlWJxx
	 h3pmh/mFpne+PjJkMhaEqmvJBwTKSWCHHbziGwJxiMOK9qvVIA31oU8cNR8ol32WKW
	 Q31E186t3b9gtzFZ9rywX0c11prx72QbQI7bM5uYw+ug0SdSWOMhExwHemgcgq7CEo
	 mXzRDxneyY715wSZeCB9Gys+NUNfhhf4p/v/apeH+RGlJ0rFAau9bnJqPTBzlFMtxl
	 B5jm/hEOhZPkpn/tZCz/xH8Jc1GYLX1tcxhvKxowmPyY3e13oJIW1HclLdyfuGMtTm
	 W+c6pwYf+aeyA==
Date: Mon, 12 Oct 2026 16:07:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, Li
 Ming <ming.li@zohomail.com>, Richard Cheng <icheng@nvidia.com>, Robert
 Richter <rrichter@amd.com>, linux-cxl@vger.kernel.org, Jonathan Cameron
 <jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH v2 1/8] cxl: Add interleave encoding validity helpers
Message-ID: <20261012160704.7ab3417e@jic23-hlaptop>
In-Reply-To: <71f783fc905f3f68d931bbf5c4cb16fff3378944.1791676454.git.alison.schofield@intel.com>
References: <cover.1791676454.git.alison.schofield@intel.com>
	<71f783fc905f3f68d931bbf5c4cb16fff3378944.1791676454.git.alison.schofield@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 10 Oct 2026 17:20:16 -0700
Alison Schofield <alison.schofield@intel.com> wrote:

> Some callers of ways_to_eiw(), granularity_to_eig(), and
> eig_to_granularity() only need to determine whether an input is valid,
> but must provide storage for a converted value that is then discarded.
> This obscures the purpose of the call and requires unnecessary temporary
> variables.
> 
> Define and use new helpers that provide a validation-only interface for
> those callers.
> 
> cxl_port_setup_targets() also encodes and then decodes its calculated
> granularity solely to validate it. Calculate the granularity directly
> and validate it instead, making the calculation explicit and removing
> the encode/decode round trip.
Nice. I'd missed that one completely!

> 
> No functional change.
> 
> Suggested-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
