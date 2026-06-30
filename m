Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151BC2FA0C4;
	Tue, 30 Jun 2026 13:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782827529; cv=none; b=LePo1xF2etFNbbyHFwqVB3Fu3wumNhXVMInuTCLKN7J5Ucpba02koYGDv3iEy0Sxv3Q6C/92rJNuRfpVTakH9YARzLhtViIFLwwlXKeSvCviUaVMVFJbfP8In6Avkpbe/3FaJSBc3y5aVU9DquleLkhVFZGnAeNUzfa84aImK7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782827529; c=relaxed/simple;
	bh=fcrjvHyRgEDnEyKZthITYPFPQmO3YCO/vYrKNtCSOkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hd9qeRriKr1rHPvXtgyxmp6ZAashv6StHMKxhZdgF253Rm91U7Sp6+TwuaJwUVxc8OyfuAQDn5G9Mi+GZpJiF/HAtaJo7eSKdRug7bYg/RgVfTXSVWx+JkSEHlzOx82OgDKopzKZU1eEcj2PfX8FEkoEI5LXxvmnZBNDbv1mxBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OYLpV4xa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OYLpV4xa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8C6F1F000E9;
	Tue, 30 Jun 2026 13:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782827528;
	bh=LIxDCIqGoO5YnS7sM89lDYN7/qU1dT6KiPHIvC5H1+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OYLpV4xaZjrElX/uvSWuXZD4SkkGn8NaPB8gcw1FkeLXh3gsJE3enB5YGDzMACuUm
	 xiQuq7RXBrppXszJMeSSHON6WB6lYMao07R8wnK+D2EJEh63FRz+Gw4HzkHv/lT3D3
	 BMim+rVqXKKw1S8lmk0Q8FnLrLrGAucqTYQ4ttrXK7eDC5LSmhA+HnXiywYfWMHqrp
	 iM+w3JQQW6SFBqZ3A8yR122tXa+8Rf9L+FPLoxFQBcNVtyzmqOHdO4ySLVvdUbRbV9
	 TycjXPq5lFHCEA23EshuBsFqrIoAqCmA6fdGumf0qnVCtWevDh0tEFW5hGjGa/rcxq
	 TWugaKofRcx8A==
Date: Tue, 30 Jun 2026 08:52:07 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ahmed Tiba <ahmed.tiba@arm.com>
Cc: Dan Williams <djbw@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-edac@vger.kernel.org, devicetree@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	Dmitry.Lamerov@arm.com, linux-acpi@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>, acpica-devel@lists.linux.dev,
	Saket Dumbre <saket.dumbre@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Corbet <corbet@lwn.net>, Len Brown <lenb@kernel.org>,
	Ira Weiny <ira.weiny@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 09/10] dt-bindings: firmware: add arm,ras-cper
Message-ID: <178282752577.2979480.8944194387626033684.robh@kernel.org>
References: <20260617-topics-ahmtib01-ras_ffh_arm_internal_review-v6-0-91f725174aa0@arm.com>
 <20260617-topics-ahmtib01-ras_ffh_arm_internal_review-v6-9-91f725174aa0@arm.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617-topics-ahmtib01-ras_ffh_arm_internal_review-v6-9-91f725174aa0@arm.com>


On Wed, 17 Jun 2026 14:54:47 +0100, Ahmed Tiba wrote:
> Describe the DeviceTree node that exposes the Arm firmware-first CPER
> provider and hook the file into MAINTAINERS so the binding has an
> owner.
> 
> The initial user is the upstream zena-css platform, validated so far
> on FVP.
> 
> Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>
> ---
>  .../devicetree/bindings/firmware/arm,ras-cper.yaml | 52 ++++++++++++++++++++++
>  MAINTAINERS                                        |  5 +++
>  2 files changed, 57 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

