Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28613F39F2;
	Fri, 29 May 2026 16:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780073065; cv=none; b=uk9UFulhNxfIvJem4sswJUANRJ5WG89W+QgStk0H7ZZR9IW2EUBWJi25d4PDxYlv1oNNe46Pb2BmY7+MqwSm2jXMw40pjmCUlDa9lFgSiqBYaNjkzNH+BTWPZsLF/u38nR2t6Vj2Ygno5fCNgmxMZn8A3N5e6RTB3TRAQMfQFo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780073065; c=relaxed/simple;
	bh=iAGB81dBLfsXAEdxg+76PjqGPkY/qwYtSvgjH4xRwWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uc3a2EqkJC+XwIY4io/+TTwoJ0NsRQhQV/RRAtSjAdhvWj3sGLkbQibPtORMjJXzrZudILauxVqbXFMJJ6z64i+cNqE7Sd27XCGAbTj+s5OIDHBB08e/uvIDZjQ6lWST3PWtdyiKMn3JYOytEfX1UHOcS0m0Ar7jA2kmJmUUmNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WM0FXeps; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WM0FXeps"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2FF41F00893;
	Fri, 29 May 2026 16:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780073063;
	bh=G3wDg+4g2GptZbsh0HCiLEhJwcrrrvElip6Ufk/Fn/o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WM0FXepsh/oPSKCdzTWjewW0wPQJFUaBHz7CLH18fotnVaOFZU+Ne2y6a0Q6qnlwe
	 tsxFmYFSHcvpPZGdmr3Xqv1rSHY+RHAlzg4dCm2D4uSI1Ohspv05QeRm5jSGHI48qk
	 imSVQ5s0omjKZRBZZAFxtjnfzqZizp6PFRfoCHK+oIHvuxetQzWtLKPteUn4NW/Qnh
	 NNWgpPd45k+Sd42HIf1LFbykbOj1IKD/Bwskw3FNLfCcGApKbjFRXJKB8TfeCg1uYM
	 KGMAQguxHHBhC4/wKlhQ1SnVVRgvCtGrNgpE/dDZwSmh9iekrsStpOO6qbKG8lF5Sa
	 nF04ArOzslibQ==
Date: Fri, 29 May 2026 17:44:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ahmed Tiba <ahmed.tiba@arm.com>
Cc: will@kernel.org, xueshuai@linux.alibaba.com, saket.dumbre@intel.com,
 mchehab@kernel.org, dave@stgolabs.net, djbw@kernel.org, bp@alien8.de,
 tony.luck@intel.com, guohanjun@huawei.com, lenb@kernel.org,
 skhan@linuxfoundation.org, vishal.l.verma@intel.com, rafael@kernel.org,
 corbet@lwn.net, ira.weiny@intel.com, dave.jiang@intel.com,
 krzk+dt@kernel.org, robh@kernel.org, catalin.marinas@arm.com,
 alison.schofield@intel.com, conor+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, Michael.Zhao2@arm.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org, Dmitry.Lamerov@arm.com,
 devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-edac@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [PATCH v5 09/10] dt-bindings: firmware: add arm,ras-cper
Message-ID: <20260529174407.7081ad0b@jic23-huawei>
In-Reply-To: <20260529-topics-ahmtib01-ras_ffh_arm_internal_review-v5-9-2e0500d42642@arm.com>
References: <20260529-topics-ahmtib01-ras_ffh_arm_internal_review-v5-0-2e0500d42642@arm.com>
	<20260529-topics-ahmtib01-ras_ffh_arm_internal_review-v5-9-2e0500d42642@arm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 May 2026 10:50:49 +0100
Ahmed Tiba <ahmed.tiba@arm.com> wrote:

> Describe the DeviceTree node that exposes the Arm firmware-first
> CPER provider and hook the file into MAINTAINERS so the
> binding has an owner.

Odd wrap. Pick a length (72 / 75 typical for commit messages) and
stick to it.

Request for references inline + a question on whether we have
to allow for the ack register not existing. I'd rather we required
it if possible.

> 
> Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>
> ---
>  .../devicetree/bindings/firmware/arm,ras-cper.yaml | 54 ++++++++++++++++++++++
>  MAINTAINERS                                        |  5 ++
>  2 files changed, 59 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/arm,ras-cper.yaml b/Documentation/devicetree/bindings/firmware/arm,ras-cper.yaml
> new file mode 100644
> index 000000000000..3d4de096093f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/firmware/arm,ras-cper.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/firmware/arm,ras-cper.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Arm RAS CPER provider
> +
> +maintainers:
> +  - Ahmed Tiba <ahmed.tiba@arm.com>
> +
> +description:
> +  Arm Reliability, Availability and Serviceability (RAS) firmware can expose
> +  a firmware-first CPER error source directly via DeviceTree. Firmware
> +  provides the CPER Generic Error Status block and notifies the OS through
> +  an interrupt.

I'd like some spec references in here if possible.

> +
> +properties:
> +  compatible:
> +    const: arm,ras-cper
> +
> +  memory-region:
> +    minItems: 1
> +    items:
> +      - description:
> +          CPER Generic Error Status block exposed by firmware.
> +      - description:
> +          Optional firmware-owned ack buffer used on platforms
> +          where firmware needs an explicit "ack" handshake before overwriting
> +          the CPER buffer. Firmware watches bit 0 and expects the OS to set it
> +          once the current status block has been consumed.

Does the arm spec really make this optional?  Can we constraint it to not be
just to make our lives easier?  I've never been sure how you would actually
make a working platform without the ack support.


> diff --git a/MAINTAINERS b/MAINTAINERS
> index 461a3eed6129..8a9714603a7d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22261,6 +22261,11 @@ M:	Alexandre Bounine <alex.bou9@gmail.com>
>  S:	Maintained
>  F:	drivers/rapidio/
>  
> +RAS ERROR STATUS
> +M:	Ahmed Tiba <ahmed.tiba@arm.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/firmware/arm,ras-cper.yaml
> +
>  RAS INFRASTRUCTURE
>  M:	Tony Luck <tony.luck@intel.com>
>  M:	Borislav Petkov <bp@alien8.de>
> 

