Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389D634214A
	for <linux-cxl@vger.kernel.org>; Thu,  4 Jun 2026 10:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780568272; cv=none; b=bXDurcdhlu6RI9NyCtq5WHKHqDjZwUUh8XUtE8c/GkYQNAvykIuagKkN8W3exvm+z7/5B4Qtl4ZgwgW6iiwaQ52T7QBRZhgr5hT2ZrxpmbESDVxQzHciIFrMzHjE1D0JE3emOAD8OZkKWSJsp8EqN5Y3ILSgwG4w/FIELVT+NWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780568272; c=relaxed/simple;
	bh=ywtcx/osVVCJLvbXCEZLAa8QkBYQg2q9l0py+bbasV8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IJn/0RXUpxFo1J0+wurm8HE25cm3YH0SmeV7xOJDM5jni9SbYKRfcjL1OZ+g2CLja1kmQcFeKVWJpHYvljq6ujrw7YvLLhVtx+73BJuaiq+1i1MjAcJktgpEHrUfKyV0K18d+xyqpw8oPqCM+vHdjKcfZYF7c7Lt971goyfE9rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wgc/PTW3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wgc/PTW3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE0DA1F00898;
	Thu,  4 Jun 2026 10:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780568271;
	bh=VtViK+NdIGcUenqAqM9sD8velgWeyxkI3fFaV0E6y7Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Wgc/PTW3WCRrNdjaiox8cdnB72on4azw52uMhPW5uKT15qlBokL3k2icLsBWJY4sV
	 X8lOnfOaTsz01hyvtHfRJyQvlXgtWGOfmCWG8ezNr7aEpHyOuu/4o/SblFSRsdXp+W
	 RPDKzjhil/rG+PfcwJ+EirKSDZ5QQwjWi5dJSJIjvktYanWaYlycEDNYVIopDjJpSM
	 TvgGG+i130FhLQ8DDvorz0fHgh1at0+ci1Sl+A/b+37BloCPqlnF0692gLb9JvXlYT
	 ti0qgOPi0ZwjJg5tEcecf7DMWOVDtKTHmE0Fa6j+o38B3sd3K4ffL5tl4KNBceQv9h
	 9C3KHqTyOjB9g==
Date: Thu, 4 Jun 2026 11:17:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net,
 alison.schofield@intel.com, djbw@kernel.org
Subject: Re: [PATCH 0/2] cxl/pci: Fix the incorrect check of
 pci_config_read/write*() returns
Message-ID: <20260604111744.74cfc2bb@jic23-huawei>
In-Reply-To: <20260603185752.4149725-1-dave.jiang@intel.com>
References: <20260603185752.4149725-1-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  3 Jun 2026 11:57:50 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> The patches are inspired by comments from Richard Cheng WRT pci config
> accessors return PCIBIOS errors that are positive integers rather than
> negative errnos. I went and audited the cxl PCI code and found a few
> locations that need to be fixed. There are other locations that may
> trigger issues, but at this point we'll fix them as they happen.
> 
Reviewed-by: Jonathan Cameron <jic23@kernel.org>

> 
> Dave Jiang (2):
>   cxl/pci: Fix the incorrect check of pci_read_config_word() return
>   cxl/pci: Convert PCIBIOS errors to errno on DVSEC config accesses
> 
>  drivers/cxl/core/pci.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> 
> base-commit: e43ffb69e0438cddd72aaa30898b4dc446f664f8

