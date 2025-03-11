Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEE31386DA
	for <linux-cxl@vger.kernel.org>; Tue, 11 Mar 2025 08:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741680500; cv=none; b=cw060Y7i71brwMs4U7AT7SxFeTSvGN62AAxPnS4wQ8QRkMHe2BdtGsWQO4XENElkD784S8pxNjsHxR3GRXWVJUuvY4iYgnyMA9y+pJ2LF25+bOQYLbmRQryv4bAEHDuVenD6KbP/18caXNj+8qNVa6HdfKo1y+zVOeKunAQ2uBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741680500; c=relaxed/simple;
	bh=XVEwwl1sXhLq3T4qtLMdypX08nnxiS3k9CcvMiSKkJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z6PeGGKVHsmqS6PsuwAJnhUetzVBFOpmSaXzbdNoHB05GJ4JhMYsiidQ7R4k7TbB8WdaOdYuqW8NBqNwzcL0h5ZV66LZ8Pb5OeYjLCUy0zjbO2NS9hu0ewjBeYjqEEkUr+dCC3othCM8lSMlLZyHxjEosthk3QvuV3uvI6gTdUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KcWhXrxF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KcWhXrxF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741680495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SkJjeRoc6mEUAou/LZwl/I3fpPe7ZBYGaQFkpeBI7yE=;
	b=KcWhXrxFGO4SQSjyeYzIBXr4ySGqsLgTUTejzwkOG9g2AJjEmfS3MKfHKePqtUUdETLk9U
	iANB8M/gjyJ7Y4CHkod8vxS6TU9evY/54vMIaIQYkdjzRm+hGTnSegEO8u8LWOyMEGtKUJ
	XSMY0jZFCap5+K8n1ghsUQYO3Fv5pck=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-459-pCwD9KUKPBuN_fgRTvdx9g-1; Tue,
 11 Mar 2025 04:08:11 -0400
X-MC-Unique: pCwD9KUKPBuN_fgRTvdx9g-1
X-Mimecast-MFC-AGG-ID: pCwD9KUKPBuN_fgRTvdx9g_1741680490
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D034A19560BB;
	Tue, 11 Mar 2025 08:08:09 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.205])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E00E81828A8C;
	Tue, 11 Mar 2025 08:08:08 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 6F41018000A3; Tue, 11 Mar 2025 09:08:06 +0100 (CET)
Date: Tue, 11 Mar 2025 09:08:06 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	qemu-devel@nongnu.org, pbonzini@redhat.com, mtosatti@redhat.com, mst@redhat.com, 
	marcel.apfelbaum@gmail.com, jon.grimm@amd.com, santosh.shukla@amd.com, vasant.hegde@amd.com, 
	Wei.Huang2@amd.com, bsd@redhat.com, berrange@redhat.com, ddutile@redhat.com, 
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH] pci-ids.rst: Add Red Hat pci-id for AMD IOMMU device
Message-ID: <o4swru5qsoemfs3acxcsifrzy45n4mptxh2vg3ulvnfwgirbv7@6iqvfqb76nh7>
References: <20250304183747.639382-1-suravee.suthikulpanit@amd.com>
 <20250310135731.00005b1f@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310135731.00005b1f@huawei.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

  Hi,

> As a heads up, I believe we have a similar problem with a few of the CXL IDs.
> The root port and type 3 device both use Intel IDs that were not reserved
> for this purpose.  VID=0x8086, DID=0x7075 and DID=0x0d93

Essentially we have two kinds of PCI devices in qemu.

 * The ones which try to mimic existing hardware, they usually have the
   PCI ID of the device they are emulating (and use the qemu subsystem ID).
   The classic example is the cirrus vga.  There are also many intel
   chipset devices for piix4 ('pc' machine type) and ich9 ('q35' machine
   type) with intel IDs.

 * The ones which are PCI class implementations and do not need a
   specific ID for drivers to accept them.  Most of them have a
   PCI device ID from the 1b36 vendor ID range.

The former tend to be older devices (before hardware standardization was
a thing, also before we got a range from 1b36 for qemu), and the latter
tend to be newer devices.  There are also a bunch of exceptions for
historical reasons.  The ahci emulation has a ich9 id.  xhci even has
two variants (one mimicking a NEC host adapter, one with qemu device id).

So, in short, using the intel IDs is not necessarily a problem.  Depends
a bit on what kind of device we are talking about.  For PCI class
devices it usually is more useful to have a qemu ID though.

> Switch ports and switch-cci are using valid Hisilicon IDs that are for
> emulation of these device only and are registered in our tracker
> for these IDs so won't get 'reused'.

That is perfectly fine.  There is no need to change IDs, although it
makes sense to document that fact in docs/specs/pci-ids.rst

Moving them to qemu pci id range is an option too if you prefer that.
Your choice.

take care,
  Gerd

