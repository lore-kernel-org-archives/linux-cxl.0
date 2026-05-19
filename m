Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7811B3DFC9C;
	Tue, 19 May 2026 09:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779182584; cv=none; b=FyBFe89EVvjQmSyOYcElJH5uRGQKsvArqbvVOLLJz/7mwcBasu8eUdAtbz+sX03wcKx1h7bBFGASvD3t/DDL9iExlxJ8n8pdx2TcL2erLflnFKUUyF0qRg0NvOmBQWoGuacq6UqTazHpTcVYvdk3A5jk9xj+4BKJDyaX72ctA0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779182584; c=relaxed/simple;
	bh=zoicHgt9O7RSwyA/8Yt8+UfNI+ddUfsokmOgEX1CF+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YsvWjaY0eIaD01iaX+Znfs7ZqgCAAoq4YeRw0rhmBpA3XPvIoVkNAdvCvkxethh2BeFhZR1Gh4wIVgBE9o0W6JJXBQpluYalxTXcQ9L/ctgA04BpTxflS7R6McnH0mH8KHILwtCWCE5EdY+blBXPpSVvmM/XuSyH+Sh/nqiwBWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pddg1vFT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pddg1vFT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E254C2BCF5;
	Tue, 19 May 2026 09:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779182584;
	bh=zoicHgt9O7RSwyA/8Yt8+UfNI+ddUfsokmOgEX1CF+Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pddg1vFTCh1TukRUY0V4DNXlP+8KxkotVm9cx5a5akZSkmQJ2odYwd7pIU7+gpN8o
	 tjnTCiM6/13XkQQSXuYmQgFOrTGugiwyU3kRtQwS2IODoBrZ7q7zh7FOMKoDxx0rAC
	 j90xHw17PtS7VJf8jLbE5Ip8FJ1I34Ecj92IuWCahEDAWSHrugL4oHETq6VF4I7apI
	 7lnaIJeLEOkYQhkCLSJ0unrz036rF1qkVLag1PEMQzH3HpPi8I/AKnC5G2n+PxRCOj
	 trB4WR4fNvfFR8Xi7XF1qaU6TzsDFqRnPEGBM0N2wC8Sl12aJtCDOew9X21WHmJL5V
	 RkVR7MV9cgSLw==
Message-ID: <d12b5738-ca14-40aa-930f-eddf3199818d@kernel.org>
Date: Tue, 19 May 2026 11:22:55 +0200
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
 <5fb43b8d-e772-42af-ba78-d75abd87bd0c@kernel.org>
 <8bc812fd-cda5-485f-98d2-4901ec17c66f@arm.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <8bc812fd-cda5-485f-98d2-4901ec17c66f@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/05/2026 11:02, Ahmed Tiba wrote:
> On 19/05/2026 08:04, Krzysztof Kozlowski wrote:
>> On 18/05/2026 13:57, Ahmed Tiba wrote:
>>> Describe the DeviceTree node that exposes the Arm firmware-first
>>> CPER provider and hook the file into MAINTAINERS so the
>>> binding has an owner.
>>>
>>> Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>
>>
>> Please implement previous comments.
> 
> Could you please clarify which previous DT comments you still see
> as unaddressed?
> 
> My understanding was that I had addressed the earlier points on the YAML
> description formatting, the `memory-region` description text, and the
> example. If I missed a specific item beyond the one below, please point 
> me to it.

You do not need other nodes for your device in the example. I asked why
this is needed for the example, but there was no answer.


Best regards,
Krzysztof
