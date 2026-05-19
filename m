Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46DE2874E3;
	Tue, 19 May 2026 07:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779174290; cv=none; b=uCO+4A73M2sSEcwhzvjFBUquXjc8frqW9/9vK/7TbJKGXwO9AQoRztMjmxTQmxiKxSl+ZB6LEK0gqMDM3LviPgJ+yd0zX3MRgiYnZ8kVo2ns7wSeu0dQvCP0CMUTLHO49OOwjpDd7E8MX6TcYYDC/dUrd4fxtHocEloCo289T8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779174290; c=relaxed/simple;
	bh=1irEky9aWBq8MFj23jSIgVbynmrjBX1upwAhF7Njc9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XBtyy7GgIdGDE+AQLDeoaCmIruRvHUBZxhRx/I1vPTU6Z64G3ZL7FtdEWzXCfXPNel7f8vjPPv/vaDd1C1n54Y0/A3sDSevVH3dFRV5FwDS3MY3V8eoeVxzPmviW1NHIUPDNaMCvtwNJNkvJXafGyZ91D02stAHTGpqYGrqVRLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pmteWGt5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pmteWGt5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9667C2BCB3;
	Tue, 19 May 2026 07:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779174289;
	bh=1irEky9aWBq8MFj23jSIgVbynmrjBX1upwAhF7Njc9k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pmteWGt56uJcXCo5A+rXNj7VwcTV1m1gvqCSUJ40cdwhP4SSi7VbDTBMZo/fjoB9O
	 jVxK69lU43R7NADVOysrSDc3m/mhP3lpBbVbHObVGLE1m+QDJfq7GmF6zvjiGaQHpW
	 tFmQRi90LF3riJQNuT9HHpkG5cGnwcbedNqETXQHLfV7YA+I3Dtfhx71CtjVdfD45x
	 mHMbL1NXUf6sq59kbKkDLtpknsoeAJKU5zJ0helOQO9hdh8Cae4G9u+Trh9Veek3cK
	 uPj4zTiuPfFP5LGzuX7alpo+ZUrr20vOXf8dWnikAvhSr+QcidzusPcgxbQK4X3Ech
	 LtZ5NX5RAo2ZA==
Message-ID: <5fb43b8d-e772-42af-ba78-d75abd87bd0c@kernel.org>
Date: Tue, 19 May 2026 09:04:40 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/10] dt-bindings: firmware: add arm,ras-cper
To: Ahmed Tiba <ahmed.tiba@arm.com>, rafael@kernel.org, bp@alien8.de,
 saket.dumbre@intel.com, will@kernel.org, xueshuai@linux.alibaba.com,
 mchehab@kernel.org, krzk+dt@kernel.org, dave@stgolabs.net,
 conor+dt@kernel.org, vishal.l.verma@intel.com, jic23@kernel.org,
 corbet@lwn.net, guohanjun@huawei.com, dave.jiang@intel.com,
 catalin.marinas@arm.com, lenb@kernel.org, tony.luck@intel.com,
 skhan@linuxfoundation.org, djbw@kernel.org, alison.schofield@intel.com,
 ira.weiny@intel.com, robh@kernel.org
Cc: devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-doc@vger.kernel.org, Dmitry.Lamerov@arm.com,
 linux-cxl@vger.kernel.org, Michael.Zhao2@arm.com,
 acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org
References: <20260518-topics-ahmtib01-ras_ffh_arm_internal_review-v4-0-42698675ba61@arm.com>
 <20260518-topics-ahmtib01-ras_ffh_arm_internal_review-v4-9-42698675ba61@arm.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20260518-topics-ahmtib01-ras_ffh_arm_internal_review-v4-9-42698675ba61@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/05/2026 13:57, Ahmed Tiba wrote:
> Describe the DeviceTree node that exposes the Arm firmware-first
> CPER provider and hook the file into MAINTAINERS so the
> binding has an owner.
> 
> Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>

Please implement previous comments.


> ---
>  .../devicetree/bindings/firmware/arm,ras-cper.yaml | 71 ++++++++++++++++++++++
>  MAINTAINERS                                        |  5 ++
>  2 files changed, 76 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/arm,ras-cper.yaml b/Documentation/devicetree/bindings/firmware/arm,ras-cper.yaml
> new file mode 100644
> index 000000000000..81dc37390af5
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
> +description:
> +  Arm Reliability, Availability and Serviceability (RAS) firmware can expose
> +  a firmware-first CPER error source directly via DeviceTree. Firmware
> +  provides the CPER Generic Error Status block and notifies the OS through
> +  an interrupt.
> +
> +properties:
> +  compatible:
> +    const: arm,ras-cper
> +
> +  memory-region:
> +    oneOf:
> +      - items:
> +          - description:
> +              CPER Generic Error Status block exposed by firmware
> +      - items:
> +          - description:
> +              CPER Generic Error Status block exposed by firmware.

Also, this is just a list with minItems. No need for oneOf.

Best regards,
Krzysztof
