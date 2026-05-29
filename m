Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86C43E8C45;
	Fri, 29 May 2026 16:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780072631; cv=none; b=RMJxTO9R78UDsv+sSKRWCMRPFB4/DMlRNekW+wKkCysR/o7JoB9AmcqAelnmYhg/uvWVrc1eZoB84Fva8H4m5E4DXNk/ODrsT8PQgY092cmaQ2k0lIZKzLKXFZWWcTjNcZJPMo/oNYK9VCJzQcXd52q+/vsb8jQDshPsJS8zR6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780072631; c=relaxed/simple;
	bh=Er+CRp+/fzF6XP7lhBBmaTyKlQe5AEFZx4olmr5xIQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jsE1p4raTNtzCBThPLqBMzTpilmLLvrhI/M950ZdFCI2zk4D2HniOetcLWvIvVJI13Yrv0PI0RgIElp5jV2063PbkoCIMvg/F6y8i+bhOVadJgAY6pWr8Z9OmbBuc2wFhKwoplVWBxOb4jA1hPvcMx/wZ/IqpPQytfLcIZoFgpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DpJhVU3r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DpJhVU3r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF4E71F00893;
	Fri, 29 May 2026 16:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780072629;
	bh=Er+CRp+/fzF6XP7lhBBmaTyKlQe5AEFZx4olmr5xIQ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DpJhVU3rHJQc98K2nTljj478Xh+GZiF0GUfOrwna3KtBKLlr2LjxoQlGAGOl1YFYj
	 JBYbOaE9746eYVP4RH2CqkzDMpk83yl26x5ckIrnbt4smT+ohvYdTsPlkFYVI1mTej
	 EB0KqUUmrVx45MeOEZ5y7jdg7Lsd+RA3Snlz6IhJrxF4Iu5Nya8fgNgD4vxLhbNqjH
	 KpmKdd5xCszMTY5cp16+JK/yjzYpX+MQt80DJQ5CJWKsYanZIszzTUQHokKsxNcmTq
	 Sh9iw2+A5hUTvVNfA2MHfr0zoJwCpvO1wp44xDknFQUzawJM/USdYwTFXVanvDnM+M
	 mqN0hjyHWFxgQ==
Date: Fri, 29 May 2026 17:36:52 +0100
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
Subject: Re: [PATCH v5 00/10] ACPI: APEI: share GHES CPER helpers and add DT
 FFH provider
Message-ID: <20260529173652.25069d3b@jic23-huawei>
In-Reply-To: <20260529-topics-ahmtib01-ras_ffh_arm_internal_review-v5-0-2e0500d42642@arm.com>
References: <20260529-topics-ahmtib01-ras_ffh_arm_internal_review-v5-0-2e0500d42642@arm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 May 2026 10:50:40 +0100
Ahmed Tiba <ahmed.tiba@arm.com> wrote:

> This is v5 of the GHES refactor series. Compared to v4, it only updates
> the DT binding to address the latest review comments.

https://sashiko.dev/#/patchset/20260529-topics-ahmtib01-ras_ffh_arm_internal_review-v5-0-2e0500d42642@arm.com

It is mostly not happy with existing code, but there is one point where it notes
a header that should be there (linux/cleanup.h)

Given you are working with this code at the moment, maybe take a look at some
of the reported issues whilst you are here!

Jonathan
