Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2F13FFAA8;
	Thu, 26 Mar 2026 15:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774538680; cv=none; b=qyu1Pwtnyl+UouyU3/CtVgpOF8z/QCvMrz1q+KwbynbObpk3f/99Ah338fsU+UPmWSTi+yHT3X7wkCYnvZKvctpjcHjJjzK+/fSa4t0NaACnFUYKqmVDELfyVA7tJuyYPfCjumfbpSt+ISVC7ejNE7PbtV/2SreApXbAZuo0+zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774538680; c=relaxed/simple;
	bh=VC8lDUeLQaF89olSSrKq5JgPweNUCYlwAaUQYICMSVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A7fmLGpL0kqkmEA1U3qaMOW3m6tFN5WUIMmWsWZoWCeQKyYkq6/wd4xvm2eZbqR1zD6E0z8rdK1hg/m7J4ItiTbZFYBEWHOtyTH/cVkPHA9yctOgXEvnjhjvF8ji5ex6Z6wAq8sZbll5zkiJWkFxt56b5EgrrgzmeizfptGmtR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kaAEnN52; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kaAEnN52"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8768C19423;
	Thu, 26 Mar 2026 15:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774538680;
	bh=VC8lDUeLQaF89olSSrKq5JgPweNUCYlwAaUQYICMSVc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kaAEnN52eATLIBzXKxWYkAjEQF54lvKDkYc4MOirqFrd5bD5DAIMQRi7Z6XFDonBb
	 WKa61FlMkBcd/iXQJ6NVvj56BLrUfSeujVI4srqkrjEo0YNkS+P6/Xr/rSzIa4TTE8
	 2nnxiSlLoWZ9fwxqX9ylNk7h2LFe47bb/mfRrR6P0j9DmK3EzFipJ7bxp5c8xm2TuS
	 NiMdnWVRBzuXH1POPXiMkAnG50ifQBOXsOongqLa/bTPgKB4QNBbt70yCIYs0d7SRq
	 J1Ih9mzFlDLWUDBMRSL14ekNbotN/3lElMlAvI5lwEmHOwIOUc4QCgy+qNYqG3bT9G
	 pKTZSBiYPPjOg==
Date: Thu, 26 Mar 2026 10:24:36 -0500
From: Rob Herring <robh@kernel.org>
To: Ahmed Tiba <ahmed.tiba@arm.com>
Cc: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-cxl@vger.kernel.org, Michael.Zhao2@arm.com,
	linux-arm-kernel@lists.infradead.org, Dmitry.Lamerov@arm.com,
	rafael@kernel.org, conor@kernel.org, will@kernel.org, bp@alien8.de,
	catalin.marinas@arm.com, krzk+dt@kernel.org,
	linux-doc@vger.kernel.org, mchehab+huawei@kernel.org,
	tony.luck@intel.com
Subject: Re: [PATCH v3 09/10] dt-bindings: firmware: add arm,ras-cper
Message-ID: <20260326152436.GA2484010-robh@kernel.org>
References: <20260318-topics-ahmtib01-ras_ffh_arm_internal_review-v3-0-48e6a1c249ef@arm.com>
 <20260318-topics-ahmtib01-ras_ffh_arm_internal_review-v3-9-48e6a1c249ef@arm.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318-topics-ahmtib01-ras_ffh_arm_internal_review-v3-9-48e6a1c249ef@arm.com>

On Wed, Mar 18, 2026 at 08:48:06PM +0000, Ahmed Tiba wrote:
> Describe the DeviceTree node that exposes the Arm firmware-first
> CPER provider and hook the file into MAINTAINERS so the
> binding has an owner.
> 
> Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>
> ---
>  .../devicetree/bindings/firmware/arm,ras-cper.yaml | 71 ++++++++++++++++++++++
>  MAINTAINERS                                        |  5 ++
>  2 files changed, 76 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/arm,ras-cper.yaml b/Documentation/devicetree/bindings/firmware/arm,ras-cper.yaml
> new file mode 100644
> index 000000000000..bd93cfb8d222
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/firmware/arm,ras-cper.yaml
> @@ -0,0 +1,71 @@
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
> +description: |
> +  Arm Reliability, Availability and Serviceability (RAS) firmware can expose
> +  a firmware-first CPER error source directly via DeviceTree. Firmware
> +  provides the CPER Generic Error Status block and notifies the OS through
> +  an interrupt.
> +
> +properties:
> +  compatible:
> +    const: arm,ras-cper
> +
> +  reg:
> +    minItems: 1
> +    items:
> +      - description:
> +          CPER Generic Error Status block exposed by firmware
> +      - description:
> +          Optional 32- or 64-bit doorbell register used on platforms
> +          where firmware needs an explicit "ack" handshake before overwriting
> +          the CPER buffer. Firmware watches bit 0 and expects the OS to set it
> +          once the current status block has been consumed.
> +
> +  interrupts:
> +    maxItems: 1
> +    description:
> +      Interrupt used to signal that a new status record is ready.
> +
> +  memory-region:
> +    $ref: /schemas/types.yaml#/definitions/phandle

memory-region already has a defined type. You just need to define how 
many entries (maxItems: 1).

> +    description:
> +      Optional phandle to the reserved-memory entry that backs the status
> +      buffer so firmware and the OS use the same carved-out region.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    reserved-memory {
> +      #address-cells = <2>;
> +      #size-cells = <2>;
> +      ras_cper_buffer: cper@fe800000 {
> +        reg = <0x0 0xfe800000 0x0 0x1000>;
> +        no-map;
> +      };
> +    };
> +
> +    error-handler@fe800000 {
> +      compatible = "arm,ras-cper";
> +      reg = <0xfe800000 0x1000>,

Wait! Why is the reserved address here? There's 2 problems with that. 
There shouldn't be same address in 2 places in the DT. The 2nd is 
reserved memory should only be regions within DRAM (or whatever is 
system memory).

Rob
