Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FDA3905F9;
	Mon, 24 Aug 2026 23:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787613202; cv=none; b=c7KHUdMb8alwBnltBgQU6guQYjATPnBL9mSq38Onoze+qfR+Qefqp1VIxugVVs1mKu5UQZFWZr6PGVP6YqxHy2vMjBjQmLeAkFGvJHFk8yQaq0Pif0VycoKx57sc1O6WuulCmvG7t5sIJu71SFDZVWdfapk3/PJb6JlBOYbOB9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787613202; c=relaxed/simple;
	bh=plWmf4F9jULrFlTE8vY+/jVWwj4KIl1SopAUXO+R80I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L30UvaQHnpIz08uz2YwDUuAiumJe0zNz5yo3F+gkqdQ7ED0NefjkaxB1Fep56cOW1ATagiyr9x239SMpOYVw1DoqmGrOF4QwTB4hgzWcbQIhBgDcpj/r4d/trJdQJN/XuQ1U6I6AW84FMYqkZukPPydKjxWm+nCmo8EjTIq4buQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QM1/P81x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QM1/P81x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 307FD1F000E9;
	Mon, 24 Aug 2026 23:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787613201;
	bh=gVn20YL37CpHok9iIdeHHPFrTvK5ecltNL9R3LCMVvA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QM1/P81x/LU0clFVqtVugWHkGtHEmKFwPCylinLtF0OLkD41G2tsta+hSxny9ocHm
	 pKhWpIHxU9OjGOCWbms7Dd9iRmKOTpMb0Bsn+Z5pbHrkSvjS7UUeaTuEqHqkJA7RrM
	 wGFIu0KbDRiUTEFlPRZaD4ioRBt+/ZMbNFrtKoFx+TPx+1rijVDbcIwsmG8DkAoZND
	 rTDC3IGrBqxIzHcFMVjcADFFxkttWAHAmLzdLPcLV1LH9y9sCRecXG2uLQFvZfP2R6
	 HOn9H8KM7WNFwReS1U1sfiXtn0xDgOIJaA1/9g99zrO8TwlaNRHaOvt4RDdDBlc2Nc
	 Tw77mJVw/Ib5w==
Date: Tue, 25 Aug 2026 00:13:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org,
 rafael@kernel.org, tony.luck@intel.com, bp@alien8.de, guohanjun@huawei.com,
 mchehab@kernel.org, xueshuai@linux.alibaba.com, terry.bowman@amd.com,
 benjamin.cheatham@amd.com, alison.schofield@intel.com,
 sashiko-bot@kernel.org
Subject: Re: [PATCH v4 08/13] ACPI: APEI: GHES: Bound CXL event record copy
 to the firmware section length
Message-ID: <20260825001309.23468edd@jic23-huawei>
In-Reply-To: <20260824174936.939059-9-dave.jiang@intel.com>
References: <20260824174936.939059-1-dave.jiang@intel.com>
	<20260824174936.939059-9-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Aug 2026 10:49:31 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> cxl_cper_post_event() copies a fixed sizeof(struct cxl_cper_event_rec)
> out of the firmware CPER section without checking how long the section
> actually is, so a short one reads past the record.
> 
> Pass gdata->error_data_length in and reject a section too small to hold
> the record before the copy.
> 
> Reported-by: sashiko-bot@kernel.org
> Link: https://sashiko.dev/#/patchset/20260617-topics-ahmtib01-ras_ffh_arm_internal_review-v6-0-91f725174aa0@arm.com?part=6
> Fixes: 5e4a264bf8b5 ("acpi/ghes: Process CXL Component Events")
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
