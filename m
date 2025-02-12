Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC51360
	for <linux-cxl@vger.kernel.org>; Wed, 12 Feb 2025 00:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739318569; cv=none; b=R5s+9ivSGMZkpa6ZfVRgGpS5b1ScYERLGb9+3nyoMXopxbxVmZuVfOPabxvGCzWTHQFW89bop/UHZb0Sqlcm8X0xTWJFPhHQC401idJfziRTIUp1SwxAO3+Cw0jI8n2luctMQx6eoNdPeeRJWgX9L2SUdaoEtQsv/f5RUAQyI5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739318569; c=relaxed/simple;
	bh=fMMFv+jSo7zzi7KLoGFNtsOVq+2ktkT4wQ9W9F6Rhc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aSKIUAi3LoZqq722CKYPf9LRHUP93rfj1FELOBmo77ZxLjKG38HnsGMEMwBkW4BVbW/F4sDltrTxEdhWZnZiugcqUz4xDpulAnvNPcpeYXQ0XhwBppvX24rVgyLTPzza9s9UISq1dh5nTjXDxDAEmVVEi3yqvFSQZoOPytnBZFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=dJUzPjTt; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="dJUzPjTt"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-471b1d7856aso739751cf.2
        for <linux-cxl@vger.kernel.org>; Tue, 11 Feb 2025 16:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1739318566; x=1739923366; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QmoPrNZsGcS3Reb5Ece6K60aasyBoOFla2DRA7O2TJQ=;
        b=dJUzPjTtUztTCFH4SWClXrzf6ng8gwdoQ80K+RYd8xbJGpA5mzr1KTDitosZzfaOVe
         kvZ7a6rL43cOjdJE4Sio4hTsK7iXvIicLkiv6G5n3BAWlngz8dQ+qK21KSn7hzjYBPtO
         zuhdL2tlZKLhbzy+MbBE5kJEzcMRg95HfJtlxpoWXlUAoYf2tTeReedyA3lfaA1TJqw2
         kQX7EtdDad+amajBBEUXhpTiQMLTabSH6bsduzgypgRZ8S/PyVm0+UEmwPH8+S8erECN
         ij78Ic8eSgq7ZlLY3lMCi7cyp/MEqs8UHkUEsI3+wKkBj6uCBO8rzjEPxxT+y+4BP/lt
         rXvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739318566; x=1739923366;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QmoPrNZsGcS3Reb5Ece6K60aasyBoOFla2DRA7O2TJQ=;
        b=BnwL4f46RWBpfoydwLBfNE3EwWdHz0MHYh0KmwXNw1A5sf/QtexGKyHaKRYX+FIcfo
         r1dRv6emNDBwP545Oj0X6ixG1V2gCLUG3hAKDUnFbDTB/GWJPQlpDDO5ZZ855UqmgTl0
         6iHz1G3/fsRQWsNt9aTPzKMORTFCu3CSORD09itTQbbLeN4STpyuxqP5CK7rS/Qcr89i
         wIpFdEwt0efk1ug61lUBuLPnfYF4zj3OUJdmIcCEeMl/xg/MRwKTmJU2tMU5bTQUA3SU
         Dub25JMy2LaADyO2MVCnAMt4AAngP8hDrxnqMzeoJGZsuO12k/4YgLUsYFVOTm/R0cdj
         8zAA==
X-Gm-Message-State: AOJu0YzAe/3+O1Wrftm4o0Uo5SFITIxcVgWo9CCLVj4W+bfgDPKQkuhA
	SMKyhxapqa+xbl4xLuo5OCYTFkHlOV3ySizTDse8+K/4g6mRWwdD4RqJJHIP/54=
X-Gm-Gg: ASbGnctM1jz1aMcxfqJx3OM9t1Xb/Tn6Edw7cV76xgDdxyFU1sRRnadn4VzqCZWx/9w
	e5hyiN6Nc8+6+ejvznFYo4TBFNoL8HDJpahfks9I0jFbmvV9pp3QrBLfQiiz4cBBxDbjoC8uv4R
	NUa2/5U7Sg7BNsXz9915WaS4apnHqSImJqvmAla9jVW8JGCDs/bM9pEodNI/8lRmdU1ehQ1Rp0O
	OdwLxb3dZAa33Z/FcjnpsA5WGjJZBb7NC8yXuaSI/le6pKjtQp62HyCZNKmfnkxiVoR2HOWhZG3
	SIS7QLe2Gx5ZMEwgfofWCDb0sf+yWqtgs8KJkgRKIaFtRBSZ0gCSfhUlF5Es3fINb5QKUkvaYw=
	=
X-Google-Smtp-Source: AGHT+IEZ3bke8jjQfP0MZWNv6laQYll9viopbjSznSPRl/BmTopl9h8Rj2ahTL9C2o5Xhb2Twsk4aA==
X-Received: by 2002:ac8:7d47:0:b0:46c:9f53:4a45 with SMTP id d75a77b69052e-471afef8df2mr20155001cf.43.1739318565725;
        Tue, 11 Feb 2025 16:02:45 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47153bc6c85sm67018281cf.53.2025.02.11.16.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 16:02:45 -0800 (PST)
Date: Tue, 11 Feb 2025 19:02:42 -0500
From: Gregory Price <gourry@gourry.net>
To: Terry Bowman <terry.bowman@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, nifan.cxl@gmail.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
	ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
	rrichter@amd.com, nathan.fontenot@amd.com,
	Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
	ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com
Subject: Re: [PATCH v7 06/17] PCI/AER: Add CXL PCIe Port uncorrectable error
 recovery in AER service driver
Message-ID: <Z6vlIhKFFqYKaivc@gourry-fedora-PF4VCD3F>
References: <20250211192444.2292833-1-terry.bowman@amd.com>
 <20250211192444.2292833-7-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211192444.2292833-7-terry.bowman@amd.com>

On Tue, Feb 11, 2025 at 01:24:33PM -0600, Terry Bowman wrote:
> cxl_do_recovery() uses the status from cxl_report_error_detected() to
> determine how to proceed. Non-fatal CXL UCE errors will be treated as
> fatal. If a UCE was present during handling then cxl_do_recovery()
> will kernel panic.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Reviewed-by: Gregory Price <gourry@gourry.net>
