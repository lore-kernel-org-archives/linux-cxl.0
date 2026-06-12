Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C5924886E;
	Fri, 12 Jun 2026 14:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781275752; cv=none; b=obDdfYmmv18HRn4PiO6Lp832JxM2LSWIzoNG76IGF5pFXxXmi7DGooWWEFUYsK9dnGCmgowcPjq592ptXtyYI9uOP9layRpYPA0IlgMzCXakmSCgqdcd/gJUW7O1GlABSH7B7SUEhUZSb2c6iaD1v5fLTDa+tZOT4Hlk/ziVGE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781275752; c=relaxed/simple;
	bh=BJFzGzOnd+wP2T3OXbmcSnUl6hlCrHcAS6mwQMT6zrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZPE2YdBVMcS9MLX8rgH8LdOvVPHY+xqdTfzS65Jf8TAWx5n1R2S9CdOZDnQx7NkWDu697q7ndEZTeFW4/MQF5aNFtiYf+MR94enFAakbmsnqy1UCRFbv6Rg0iLBmHf8O9+DukgeBwUpbT36w5T8UC+W0kP+LaiW/ZnWve6X/Xy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KqQ3m+ji; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KqQ3m+ji"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDC861F000E9;
	Fri, 12 Jun 2026 14:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781275751;
	bh=qhPHLYbQyUfvef9/xCIIY8vt5USpJP7O50ve0Xr9Fco=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KqQ3m+jibMcuY8vurw+rG7VdytA6Y6cMHo3roJQ8ImJswxu7g5OQsf6U9DmgKL9Ok
	 tMoVfnttQQhbTRLujJvFm4Z3bZ7gZzKPvuegSKFNGFlYLiavZptALOMGNFohVAJBsU
	 S2cf3GfT9s6pAt3G7PxxKl9WEcH0ikXnznL9+1kH7Dm5xiZa7amZAbjMwEevZ45B4a
	 vJr8GleYk5liMgzbxAkB3mPRM5aQevk6Yqrzi9aFtqJTDnvJHo9OtiT8zww01quWWU
	 JZFWZqvYd6+3/nlD+3b8S1gml9lQE6KMYyGi9pVigyovlwi1JcYwRC3L4eQz6SwZW2
	 qxF4lWtteSQaQ==
Date: Fri, 12 Jun 2026 09:49:10 -0500
From: Rob Herring <robh@kernel.org>
To: Ahmed Tiba <ahmed.tiba@arm.com>
Cc: Jonathan Cameron <jic23@kernel.org>, will@kernel.org,
	xueshuai@linux.alibaba.com, saket.dumbre@intel.com,
	mchehab@kernel.org, dave@stgolabs.net, djbw@kernel.org,
	bp@alien8.de, tony.luck@intel.com, guohanjun@huawei.com,
	lenb@kernel.org, skhan@linuxfoundation.org,
	vishal.l.verma@intel.com, rafael@kernel.org, corbet@lwn.net,
	ira.weiny@intel.com, dave.jiang@intel.com, krzk+dt@kernel.org,
	catalin.marinas@arm.com, alison.schofield@intel.com,
	conor+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
	Michael.Zhao2@arm.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	Dmitry.Lamerov@arm.com, devicetree@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: Re: [PATCH v5 09/10] dt-bindings: firmware: add arm,ras-cper
Message-ID: <20260612144910.GA989816-robh@kernel.org>
References: <20260529-topics-ahmtib01-ras_ffh_arm_internal_review-v5-0-2e0500d42642@arm.com>
 <20260529-topics-ahmtib01-ras_ffh_arm_internal_review-v5-9-2e0500d42642@arm.com>
 <20260529174407.7081ad0b@jic23-huawei>
 <ceb19cb6-7083-44ad-a262-a8198f489257@arm.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ceb19cb6-7083-44ad-a262-a8198f489257@arm.com>

On Thu, Jun 11, 2026 at 03:22:21PM +0100, Ahmed Tiba wrote:
> On 29/05/2026 17:44, Jonathan Cameron wrote:
> > On Fri, 29 May 2026 10:50:49 +0100
> > Ahmed Tiba<ahmed.tiba@arm.com> wrote:
> > >   .../devicetree/bindings/firmware/arm,ras-cper.yaml | 54 ++++++++++++++++++++++
> > >   MAINTAINERS                                        |  5 ++
> > >   2 files changed, 59 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/firmware/arm,ras-cper.yaml b/Documentation/devicetree/bindings/firmware/arm,ras-cper.yaml
> > > new file mode 100644
> > > index 000000000000..3d4de096093f
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/firmware/arm,ras-cper.yaml
> > > @@ -0,0 +1,54 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id:http://devicetree.org/schemas/firmware/arm,ras-cper.yaml#
> > > +$schema:http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Arm RAS CPER provider
> > > +
> > > +maintainers:
> > > +  - Ahmed Tiba<ahmed.tiba@arm.com>
> > > +
> > > +description:
> > > +  Arm Reliability, Availability and Serviceability (RAS) firmware can expose
> > > +  a firmware-first CPER error source directly via DeviceTree. Firmware
> > > +  provides the CPER Generic Error Status block and notifies the OS through
> > > +  an interrupt.
> > I'd like some spec references in here if possible.
> I can add a reference to the UEFI CPER specification for the Generic
> Error Status record format.
> 
> For the firmware-first DT description itself I do not have a more specific
> public reference to cite.

Is there a platform actually using this with DT (FVP doesn't really 
count)?

Rob
