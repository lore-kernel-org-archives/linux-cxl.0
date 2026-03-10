Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872993D522E;
	Tue, 10 Mar 2026 20:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773175308; cv=none; b=dgIa7DF5pBfS0TRY/Q5lxcXxhLhfktrcfSB2SnlWrmRTiph8PMTVrdiwUs94kar9h+fcNv/mJrzeBjXDnvK+6lQjocQs2sqKJCBBi3/RPwG0Nn0KXy+WfrWixbB69NHX1PCkyebARvQKeiooqObeb7qNIlLR9XNFdCah7jm7kNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773175308; c=relaxed/simple;
	bh=94RBwGBFG3Ta78EYudkIjPD8B3MK/G5aFYbFS+iZZQA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=umvMbZ4qWHVyeIOD14Bw5bbuvz8Lw4ROhCtJ1qImMdw818fDk8WlOtxb3CRQQTS7d8jhOayawogo/nkD4rjvsu5KsJ6CCzWMMxPZkz+8MI1GBsg/BQyg+ABLt65y9K5B0LoiX2Ed84UysThck1ISp3/RHl/SG+To49B6tRXV0Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKmbF8+G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKmbF8+G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5534AC19423;
	Tue, 10 Mar 2026 20:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773175308;
	bh=94RBwGBFG3Ta78EYudkIjPD8B3MK/G5aFYbFS+iZZQA=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=bKmbF8+GuzrRBwv+ps47sHR+VBEz5FtNnmw0goa4V6oTS9Q+pUs8+zxsXqgpuOGjL
	 6UX+oyI1ZIh+/ieUqOussULA2ISs04b2aTXKK8vhT87kPym+FUaSDLdY5QgMDLSWys
	 1s24/32DgyQ6bxRqs2usCs+sAYkjZTLrDPYR0jYJmYytSPfWJwdQaEkB0fY3qug3Pk
	 wqvBSfXDz5/slULUTGnQZfd2mr7X/RQt3K1ot2zBwWrhQ0dTXi85Fe7/32CCEovQhN
	 SmFXC+FLSSDBc1OOYiiI7hrIdMuSu0BbahVyQ5LrSf7KNKrnUic2Tl/hDxEMv0Bdy8
	 p4AlzAlvaXEJQ==
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 10 Mar 2026 21:41:43 +0100
Message-Id: <DGZE6P0URC9B.3SKL340LXC7WG@kernel.org>
Subject: Re: [PATCH 1/7] driver core: Add conditional guard support for
 device_lock()
Cc: "Dave Jiang" <dave.jiang@intel.com>, "Li Ming" <ming.li@zohomail.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Davidlohr Bueso" <dave@stgolabs.net>, "Jonathan
 Cameron" <jonathan.cameron@huawei.com>, "Alison Schofield"
 <alison.schofield@intel.com>, "Vishal Verma" <vishal.l.verma@intel.com>,
 "Ira Weiny" <ira.weiny@intel.com>, "Bjorn Helgaas" <bhelgaas@google.com>,
 "Ben Cheatham" <benjamin.cheatham@amd.com>, <driver-core@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
To: "Dan Williams" <dan.j.williams@intel.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260310-fix_access_endpoint_without_drv_check-v1-0-94fe919a0b87@zohomail.com> <20260310-fix_access_endpoint_without_drv_check-v1-1-94fe919a0b87@zohomail.com> <127f99e8-f673-4cec-a573-be2257134f59@intel.com> <DGZAVHW9AW34.3UKJ8WV6QR8XI@kernel.org> <43577d8d-f95a-4964-abe5-3e0b7155e99a@intel.com> <69b0654e4ffd1_2132100ce@dwillia2-mobl4.notmuch> <DGZCEIBES82T.27Z7GZ605OVB@kernel.org> <69b081083c1b6_490a10085@dwillia2-mobl4.notmuch>
In-Reply-To: <69b081083c1b6_490a10085@dwillia2-mobl4.notmuch>

On Tue Mar 10, 2026 at 9:37 PM CET, Dan Williams wrote:
> Danilo Krummrich wrote:
> [..]=20
>> As for sharing the commit throughout multiple trees, I can provide a sig=
ned tag
>> similar to [1] once Greg and Rafael had a chance to take a look at this =
patch as
>> well.
>
> That would be lovely, thank you. Please take this patch.
>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Thanks!

>> You may also want to sort out authorship / tags with Li.
>
> No worries about authorship for something so tiny.

Neither would I, but I'd rather make sure. :)
