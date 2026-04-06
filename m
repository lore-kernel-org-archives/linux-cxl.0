Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0D5358363
	for <linux-cxl@vger.kernel.org>; Mon,  6 Apr 2026 22:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775513429; cv=none; b=ep8b9r5YCWahBA7dJN3VaGvfZbisagMB0RoncRGtYxEItauRTWOgAQdgHrCnjSobXcD89WbP64IHBZa3p925qjnTvW9C2wVryAMf01rM3aIsHsa6QItG/kBSRNl/gNIBUcPI9qfmCJjQVXppYWqbKmX/dPNXDMpDXThrO3WfESE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775513429; c=relaxed/simple;
	bh=jUJx2dHLtWVAhCD/NwIlBJWlN7aB3C76s4JEYE9cZNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rMzqj0zIIqtUfPs+5tBdQVG2ElIskRaLJzD9y958phoznhS7RxpKG4DW66NU/L/4WEbPT6KfaLkhYpYp/ZRmMGsCO6uZiCDEMi2ZyjubXfKIEcqjugu6opyu56iTB5DEdZq+o4hoqmv21W/JIHTerv1KuIhSXIkiWE7Sw8VY8Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Ow/9r4f1; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Ow/9r4f1"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-506a747448dso32562081cf.0
        for <linux-cxl@vger.kernel.org>; Mon, 06 Apr 2026 15:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1775513428; x=1776118228; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jUJx2dHLtWVAhCD/NwIlBJWlN7aB3C76s4JEYE9cZNI=;
        b=Ow/9r4f1wgV5ET9ewP1WS/ClATq8ocs2fqttQKEix70hzKQxvjNyvcrhWNN2zeLGdu
         H0BjKhwg17KhhpL7XoVjoojKW5iGKOH3Tq9u/r4uzrNvz1KBkE/Wh9TaOFNZQTPuQSTT
         fEscO83j5mgVedCoe3sVtHjXZy193lcLl1OXmkU8O9NomBOwVUonmm7nyeqRi3B41+vZ
         D4QsfV1n6EJpsGwAysjkwnttiwMMh+cq4J7m0uA7E0VhwLOidbssyV7uekxdsocdqtgD
         Myq8QFKgcgdBWpvyKJJBGRRvDShobEoDWkgbCbLYcQm4CMzhp59OGjGyf+Wz7LJNRABB
         Mj/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775513428; x=1776118228;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jUJx2dHLtWVAhCD/NwIlBJWlN7aB3C76s4JEYE9cZNI=;
        b=rpvI2BAWMoCa7Z44a/0rCsVK54uPoDdsSQG3HL6nrLJSZqThV1Q12Ypj+qnzwI1aAa
         T94QJVi3NltCoZegS8CdDnjzgcItVa3w3p6eiA4Gep7uQ825jliizbF36jc7jb0zCN0h
         /BDeoRj24VicKQv71w0CR91zoB09sDfVY0y3zOQuunXo8hdF2Y1EeWxo5pzOP/t6SZjM
         04r8mIw0BcVL/qrSL0LIJEvBCI8A7tOm5TWFOZ4CO47TlEU8CDzY9Slt2isULmr30VYH
         zEGx/3JFmF1BDtAjAKcYoYZc15nEbVk5UwxRtovpgmHKtXC+0vehLztmu1X/bofPtIcS
         do6g==
X-Forwarded-Encrypted: i=1; AJvYcCVJMHxKU5QPUsyNpsTMXFxbhFty4R9u3rXDVRZ7DVhSAIe6fEPAurzQwEVI4Rds9pdIkAX+Kq+zUH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvvZQnChoGdWfewWXNATXL4issQGPIH3yPC/33Kytebh+Wb+48
	/gDgfAzTvt620xZ9A+kBfwAWFBhN3GfFhij2iTj+p2BINEra2Z1DNJgPB0huctO8VPE=
X-Gm-Gg: AeBDiesahh15GCRmoqUSd4+7HBU4qXGNCtug+WKmaBA8M0hSzLr46DF4dTxyj4U7u1j
	SwFbci8RFcOUPKVZ1xYBqwDlWPmgTAwwScSW95Eglyry+Wb74uYRRVm90zSPRofS1Wu/2KC3DPy
	qcpiAFtKhp5CyMFlAwj9W32M1IxF26p7D/AITiBROQ2dWX6SQQ1RsIC0iLk22k/9UbQaXCBKvBR
	jm4I/zmYkpymuIkuWRUyM2xCsg+LhJW8HA1oMAtKu5WA9/YNcbKvv7ixiwoxnVm79S9xjAvEcnH
	LG3Xzc1glb3KCp1M1O0/kxAQDY4NkvjZACTq9we2hMZcjaPB/XDdk55XvWixB9InUkg3OXHXeTO
	AKJaEe+6uCBztj4q863w+w0ayngDORS5v1cj7fqpF8luNH6w5gOmS4N6eQl7ISawCCVBVK0IN8o
	Zosiakb0txvtRHVfE71kdWoaaErsEVkv/axUIefWjAREsfBXPMa0Owa/pcTviWLc8GD0VrqA==
X-Received: by 2002:a05:622a:418b:b0:50d:89f0:9a00 with SMTP id d75a77b69052e-50d89f142e1mr93804951cf.42.1775513427598;
        Mon, 06 Apr 2026 15:10:27 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50d4b93dd10sm122148721cf.7.2026.04.06.15.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 15:10:26 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w9s9J-0000000E4pT-1Nq1;
	Mon, 06 Apr 2026 19:10:25 -0300
Date: Mon, 6 Apr 2026 19:10:25 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Dan Williams <djbw@kernel.org>
Cc: mhonap@nvidia.com, alwilliamson@nvidia.com, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alejandro.lucero-palau@amd.com,
	dave@stgolabs.net, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com, dmatlack@google.com,
	shuah@kernel.org, yishaih@nvidia.com, skolothumtho@nvidia.com,
	kevin.tian@intel.com, ankita@nvidia.com, vsethi@nvidia.com,
	cjia@nvidia.com, targupta@nvidia.com, zhiw@nvidia.com,
	kjaju@nvidia.com, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	kvm@vger.kernel.org
Subject: Re: [PATCH v2 16/20] vfio/cxl: Register regions with VFIO layer
Message-ID: <20260406221025.GH2551565@ziepe.ca>
References: <20260401143917.108413-1-mhonap@nvidia.com>
 <20260401143917.108413-17-mhonap@nvidia.com>
 <69d0169115c06_1b0cc6100a5@dwillia2-mobl4.notmuch>
 <20260404185330.GD2551565@ziepe.ca>
 <69d1685538f45_556821002f@djbw-dev.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69d1685538f45_556821002f@djbw-dev.notmuch>

On Sat, Apr 04, 2026 at 12:36:53PM -0700, Dan Williams wrote:

> Then I assume it matters that memremap() sometimes silently falls back
> to the direct map. The "VFIO owns" expectation needs to guard against
> some helpful platform firmware mapping accelerator memory as System RAM.

I don't think how memremap works under the covers matters to vfio, it
takes in a phys_addr_t an gives back a KVA that is cachable kernel
memory.

We just have to be mindful to not allow mismatched attributes on
virtual aliases.

> At a minimum having VFIO fail to map in that case helps with the
> argument I have been making that "no, EFI_CONVENTIONAL_MEMORY type +
> EFI_SPECIFIC_PURPOSE flag" is not suitable for accelerators with private
> CXL memory. Those want to be enforcing "EFI_RESERVED".

Certainly it should fail the request region if something else is using
it, so if those EFI flags plug it into the mm and it is plugged when
VFIO starts then it should stop.

The direct map isn't really "plugged into the mm" but it does raise
the mismatched attributed issue.

Jason
