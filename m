Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A9C39A81B;
	Thu, 10 Sep 2026 20:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789073715; cv=none; b=uLnrXyqble9e8FyuSMfNlLESXm6UQsRgsLekG04exUIX0oi4yjXu/EFCeRpqiyucOMrdEfnfjhO2qG2xrzyYt2I8VuNG+Hp8y4CZGM6GuacFGIUVy9YpZvNJGzK77GOW8DNlQUYVrmNUHlbzoY+Evl/BYJWbjP9vzLPqji/CEH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789073715; c=relaxed/simple;
	bh=crOnlbHbyUPuGLh0JGVd37vqRbssmx4tna3eDDxQncM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AYYxVkUrYyfKfewkZF6l47FusRaxr89cTJB3evhv9VlwA7u5ZQy95S/0OTlRXCEqOx7Qbt0SEuIf0FEkpP9bcSwillGW8hw8BLgFLvdzLrumAwRSqUvcGZxD5vIwIJIwS803Q7CbHP7cRBy4xBtM9hx4gBmHMkkqtzKNEQGAqOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xoh0feO1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xoh0feO1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46FC31F000FF;
	Thu, 10 Sep 2026 20:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789073714;
	bh=D+msI9wYLgAPXjQbPqwb4BUHIoNDxsNY1NG+JACt0is=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Xoh0feO1QBoUTvaFc9nj+FXL/MEaEmvlbGSfUeqPWb00hKvvJgPsh9nRIl0MzQhVd
	 HuBezLD31zsfxmGSg9IuazudLg2IfqkNRg7Oui1pnp/TcqHqecQXcO0UhsrBkcIn3P
	 nn7HIZX4J/Dml0TL2nd69TZG1NMX5EAwoea/fy99bkbLyUGO1eq8cOxx50leJvM8y/
	 eOVeYgZaHriObwlQyMZC4p7/m38jZwvXaV2ObMO1IMO+aTr9nlNIFDDJpr66+LKhws
	 tIJtZoi71NOeTDe2xM+nKQlgwV+3E5ToD9PK9kyMDi3PFG7wHaPTfvT32nm72bDL8D
	 SzTt0cUwJn+Fg==
Date: Thu, 10 Sep 2026 21:55:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Junjie Cao <junjie.cao@intel.com>, Jonathan Cameron
 <jonathan.cameron@oss.qualcomm.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Alison Schofield <alison.schofield@intel.com>, Vishal Verma
 <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>,
 linux-cxl@vger.kernel.org, Ira Weiny <iweiny@kernel.org>, Li Ming
 <ming.li@zohomail.com>, Richard Cheng <icheng@nvidia.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cxl/regs: Reject register blocks in an unassigned BAR
Message-ID: <20260910215507.0b704da8@jic23-hlaptop>
In-Reply-To: <6bb0b537-eaef-48a6-aadb-232e44522dee@intel.com>
References: <20260910093858.535969-1-junjie.cao@intel.com>
	<6bb0b537-eaef-48a6-aadb-232e44522dee@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Sep 2026 08:38:06 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> On 9/10/26 2:38 AM, Junjie Cao wrote:
> > cxl_decode_regblock() only checks that the Register Locator offset fits
> > pci_resource_len().  A BAR the PCI core could not place is reset to zero
> > start, end and flags while config space keeps the firmware value, so a
> > zero offset passes and the block is mapped at physical address 0.  On
> > x86 ioremap() of the reserved low megabyte succeeds, the component
> > register header does not match, and a switch port fails with "HDM
> > decoder capability not found", pointing at the HDM decoders rather than
> > at the BAR.
> > 
> > Reject a BAR with no length or still unassigned, next to the existing size
> > check.  Skip empty Register Locator entries first: they decode as BAR0
> > offset 0 and would trip the check, and nothing looks them up.
> > 
> > Seen with edk2-stable202602 (f6489621b8ae, reverted in stable202605),
> > which places 64-bit non-prefetchable BARs behind a bridge in the
> > prefetchable window.  Linux refuses to claim them and the switch
> > upstream and downstream port BAR0s find no room in the 32-bit window.
> > QEMU q35 with a CXL switch, Fedora 43 edk2-ovmf-20260213, before:
> > 
> > pci 0000:0d:00.0: BAR 0 [mem size 0x00010000 64bit]: can't assign; no space
> > cxl_port port2: HDM decoder capability not found
> > 
> > after:
> > 
> > pcieport 0000:0d:00.0: BAR0: not assigned (type: 1)
> > cxl_port port2: No component registers mapped
> > cxl_port port2: Failed to map HDM decoder capability
> > 
> > Link: https://github.com/tianocore/edk2/issues/13104
> > Signed-off-by: Junjie Cao <junjie.cao@intel.com>  
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
